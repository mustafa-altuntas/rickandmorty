import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

class CharacterCardView extends StatelessWidget {
  final Character character;

  const CharacterCardView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        elevation: 1,
        color: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              // Avatar Container
              _avatarWidget(context, image: character.image),

              const SizedBox(width: 17),

              // Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name and Location
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          _infoLocationWidget(
                            context,
                            location: character.location.name,
                          ),
                        ],
                      ),

                      // Status Chip
                      _infoStatusWidget(
                        context,
                        status: character.status,
                        type: character.species,
                      ),
                    ],
                  ),
                ),
              ),

              // Bookmark Button
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(left: 0),
                child: IconButton(
                  onPressed: () {
                    // Bookmark functionality
                  },
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _avatarWidget(BuildContext context, {required String image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.tertiary,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }

  Container _infoStatusWidget(
    BuildContext context, {
    required String status,
    required String type,
  }) {
    Color? statusColor =
        status == 'unknown'
            ? Colors.amber[600]
            : status != 'Dead'
            ? Colors.green
            : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   width: 6,
          //   height: 6,
          //   decoration: BoxDecoration(
          //     color: statusColor,
          //     shape: BoxShape.circle,
          //   ),
          // ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              '$status - $type',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _infoLocationWidget(BuildContext context, {required String location}) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

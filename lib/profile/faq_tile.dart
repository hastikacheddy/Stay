
class BasicTile {
  final String title;
  final String desc;

  const BasicTile({
    required this.title,
    required this.desc,
  });
}

final basicTiles = <BasicTile>[
  BasicTile(title: 'How do i save places?', desc: 'Places are saved by pressing the star buttun on the hotels page which can then be seen in the Saved section' ),

  BasicTile(title: 'Where to enter card details?', desc: 'Card details are enterd when payment is made'),

  BasicTile(title: 'Is my card details safe?', desc: 'Yes they are completely safe.'),
  BasicTile(title: 'How do i scan the Qr codes of hotels ?', desc: 'Our Qr code scanner can be accesed in the profile page.'),
  BasicTile(title: 'Can the app be accesed from outside of Mauritius?', desc: 'No.'),
  BasicTile(title: 'Can I cancel my booking?', desc: 'You cannot. Once its booked there is no refund. So be careful.'),
  BasicTile(title: 'How do I change to dark/bright mode?', desc: 'switching between the 2 modes can be done by pressing the icons in the top left of the profile screen')
];
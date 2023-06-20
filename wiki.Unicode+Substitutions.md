# Unicode Substitutions

To find Unicode characters in VS Code, just search with the following regex:
`[^\x00-\xFF]`



it is not easy to recognize Unicode characters via script, as they are technically two or more sequential characters.

Replacements done by [unicode-Substitutions - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=GlenBuktenica.unicode-substitutions)

| **Character Name**             | **Character** | **Unicode** | **Replace with**    | **Character** | **Replace with Unicode** |
| :----------------------------- | :------------ | :---------- | :------------------ | :------------ | :----------------------- |
| En Dash                        | –             | 2013        | Hyphen              | -             | 002D                     |
| Em Dash                        | —             | 2014        | Hyphen              | -             | 002D                     |
| Horizontal Bar                 | ―             | 2015        | Hyphen              | -             | 002D                     |
| Start Single Quote             | ‘             | 2018        | Single Quote        | '             | 0027                     |
| End Single Quote               | ’             | 2019        | Single Quote        | '             | 0027                     |
| Start Double Quote             | “             | 201C        | Double Quote        | "             | 0022                     |
| End Double Quote               | ”             | 201D        | Double Quote        | "             | 0022                     |
| Low Double Quote               | „             | 201E        | Double Quote        | "             | 0022                     |
| High Double Quote              | ‟             | 201F        | Double Quote        | "             | 0022                     |
| Slightly smiling face          | 🙂             | D83D DE42   | Colon & parentheses | :)            | 003A 0029                |
| Smiling face with smiling eyes | 😊             | D83D DE0A   | Colon & parentheses | :)            | 003A 0029                |

Other Unicodes which may occur and then have to be replaced manually:

| **Character Name**         | **Unicode**                                   | **Replace** |
| :------------------------- | :-------------------------------------------- | :---------- |
| Zero Width Space           | [ U+200B](https://unicode-table.com/en/200B/) |  ![image](https://github.com/macphil/passt/assets/7562031/77ec16f6-4e17-44fd-ac26-fd5b4a046062)|
| registered trade mark sign | [U+00AE](https://unicode-table.com/en/00AE/)  | `&reg;`     |

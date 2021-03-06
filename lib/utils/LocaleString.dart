import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'language': 'Language',
          'home': 'Home',
          'notes': 'Notes',
          'accounts': 'Accounts',
          'addaccounts': 'Add Accounts',
          'allaccounts': 'All Accounts',
          'bankaccounts': 'Bank Accounts',
          // Add Account inner page
          'vendorcode': 'Vendor Code',
          'vendorname': 'Vendor Name',
          'fathername': 'Father name/nominee',
          'phonenumber': 'Phone Number',
          'address': 'Address',
          'mobilenumber': 'Mobile Number',
          'gstinnumber': 'GSTIN Number',
          'emailaddress': 'Email Address',
          'pannumber': 'Pan Number',
          'aadharnumber': 'Aadhar Number',
          'bankname': 'Bank Name',
          'bankbranch': 'Bank Branch',
          'accountnumber': 'Account Number',
          'ifsc': 'IFSC ',
          'city': 'City',
          'save': 'Save',
          'action': 'Action',
          'task': 'Task',
          'milkcollection': 'Milk Collection',
          // milk collection
          'date': 'Date',
          'time': 'Time',
          'shift': 'Shift',
          'cattletype': 'Cattle Type',
          'fat': 'FAT',
          'snf': 'SNF',
          'clr': 'CLR',
          'weight': 'Weight',
          'rate': 'Rate',
          'amount': 'Amount',
          'delete': 'Delete',
          'edit': 'Edit',
          'editmilkcollection': 'Edit Milk Collection',
          'milksale': 'Milk Sale',
          'exportto': 'Export To',
          'sure': 'Are you sure you want to delete?',
          'yes': 'Yes',
          'no': 'No',
          'editmilksale': 'Edit Milk Sale',
          'kg': 'KG',
          'l': 'L',
          'exportto': 'Export To',
          'add': 'Add',
          'editaccount': 'Edit Accounts',

          // item sale
          'itemsale': 'Item Sale',
          'srno': 'Sr NO',
          'itemname': 'Item Name',
          'units': 'Units',
          'quantity': 'Quantity',
          'add': '+Add',
          'print': 'Print',
          'item': 'Item',

          // payments
          'payments': 'Payments',
          'billnumber': 'Bill Number',
          'editpayment': 'Edit Payment',

          // stock update
          'stockupdate': 'Stock Update',
          'type': 'Type',
          'editstockupdate': 'Edit Stock Update',

          // dispatch
          'dispatch': 'Dispatch',
          'editdispatch': 'Edit Dispatch',
          'avgfat': 'avg FAT',
          'avgsnf': 'avg SNF',
          'avgclr': 'avg CLR',
          'noofcans': 'No of Cans',




          // deduct

          'dispatch': 'Dispatch',
          'editdispatch': 'Edit Dispatch',
          'avgfat': 'avg FAT',
          'avgsnf': 'avg SNF',
          'avgclr': 'avg CLR',
          'noofcans': 'No of Cans',


        },
        'hi_IN': {
          'language': 'भाषा',
          'home': 'होम',
          'notes': 'नोट्स',
          'accounts': 'खाता',
          'addaccounts': 'खाते जोड़ें',
          'allaccounts': 'सभी खाते',
          'bankaccounts': 'बैंक खाते',
          // Add Account inner page
          'vendorcode': 'विक्रेता कोड',
          'vendorname': 'विक्रेता का नाम',
          'fathername': 'पिता का नाम/नामित',
          'phonenumber': 'फ़ोन नंबर',
          'address': 'पता',
          'mobilenumber': 'मोबाइल नंबर',
          'gstinnumber': 'जीएसटीआईएन नंबर',
          'emailaddress': 'ईमेल पता',
          'pannumber': 'पैन नंबर',
          'aadharnumber': 'आधार नंबर',
          'bankname': 'बैंक का नाम',
          'bankbranch': 'बैंक ब्रांच ',
          'accountnumber': 'अकाउंट नंबर',
          'ifsc': 'आईएफएससी ',
          'city': 'शहर',
          'save': 'जोड़ें',
          'action': 'कार्य',
          'task': 'टास्क',
          'milkcollection': 'दूध संग्रह',
          // milk collection
          'date': 'तारीख',
          'time': 'समय',
          'shift': 'शिफ्ट',
          'cattletype': 'मवेशी प्रकार',
          'fat': 'फैट',
          'snf': 'एस एन एफ',
          'clr': 'सी एल आर',
          'weight': 'वज़न',
          'rate': 'भाव',
          'amount': 'राशि',
          'delete': 'हटाना',
          'edit': 'एडिट',
          'editmilkcollection': 'एडिट मिल्क कलेक्शन',
          'milksale': 'दूध बिक्री',
          'exportto': 'Export To',
          'sure': 'क्या आप आश्वस्त है कि आपको डिलीट करना है?',
          'yes': 'हां',
          'no': 'नहीं',
          'editmilksale': 'एडिट दूध बिक्री',
          'kg': 'KG',
          'l': 'L',
          'exportto': 'निर्यात ',
          'editaccount': 'एडिट अकाउंट',
          // item sale
          'itemsale': 'आइटम बिक्री',
          'srno': 'क्र.सं.',
          'itemname': 'आइटम नाम',
          'units': 'श्रेणी',
          'quantity': 'मात्रा',
          'add': '+जोड़ें',
          'print': 'प्रिंट',
          'item': 'आइटम',

// payments
          'payments': 'भुगतान',
          'billnumber': 'बिल संख्या',
          'editpayment': 'एडिट भुगतान',
// stock update
          'stockupdate': 'स्टॉक अपडेट',
          'type': 'प्रकार',
          'editstockupdate': 'एडिट स्टॉक अपडेट',

          // dispatch
          'dispatch': 'डिस्पैच',
          'editdispatch': 'एडिट डिस्पैच',
          'avgfat': 'एवीजी वसा',
          'avgsnf': 'एवीजी एसएनएफ',
          'avgclr': 'एवीजी सीएलआर',
          'noofcans': 'कैन की संख्या',

        },
        'gu_IN': {
          'language': 'ભાષા',
          'home': 'હોમમાં',
          'notes': 'નોટસ',
          'accounts': 'હિસાબો',
          'addaccounts': 'એકાઉન્ટ્સ ઉમેરો',
          'allaccounts': 'બધા હિસાબો',
          'bankaccounts': 'બેંક ખાતા',
          // Add Account inner page
          'vendorcode': 'વેન્ડર કોડ',
          'vendorname': 'વિક્રેતાનું નામ',
          'fathername': 'પિતાનું નામ/નોમિની',
          'phonenumber': 'ફોન નંબર',
          'address': 'સરનામું',
          'mobilenumber': 'મોબાઇલ નંબર',
          'gstinnumber': 'GSTIN નંબર',
          'emailaddress': 'ઈ - મેઈલ સરનામું',
          'pannumber': 'પાન નંબર',
          'aadharnumber': 'આધાર નંબર',
          'bankname': 'બેંકનું નામ',
          'bankbranch': 'બેંક ની શાખા',
          'accountnumber': 'ખાતા નંબર',
          'ifsc': 'IFSC',
          'city': 'શહેર',
          'save': 'સાચવો',
          'action': 'ક્રિયા',
          'task': 'કાર્ય',
          'milkcollection': 'દૂધ સંગ્રહ',
          // milk collection
          'date': 'તારીખ',
          'time': 'સમય',
          'shift': 'પાળી',
          'cattletype': 'કૈટલ પ્રકાર',
          'fat': 'ચરબી',
          'snf': 'એસ એન એફ',
          'clr': 'સી એલ આર',
          'weight': 'વજન',
          'rate': 'દર',
          'amount': 'રકમ',
          'delete': 'દકાી નાખો',
          'edit': 'એડિટ',
          'editmilkcollection': 'એડિટ મિલ્ક કૉલેકશન',
          'milksale': 'દૂધનું વેચાણ',
          'exportto': 'Export To',
          'sure': 'શું તમે ખરેખર કા deleteી નાખવા માંગો છો?',
          'yes': 'હા',
          'no': 'ના',
          'editmilksale': 'એડિટ દૂધનું વેચાણ',
          'kg': 'KG',
          'l': 'L',
          'exportto': 'નિકાસ ',
          'editaccount': 'એડિટ ખાતા',

          // item sale
          'itemsale': 'આઇટમ વેચાણ',
          'srno': 'ક્રમાંક',
          'itemname': 'आइटम नाम',
          'units': 'એકમો',
          'quantity': 'જથ્થો',
          'add': '+ઉમેરો',
          'print': 'છાપો',
          'item': 'આઇટમ',

          // payments
          'payments': 'ચૂકવણી',
          'billnumber': 'બિલ નં',
          'editpayment': 'એડિટ ચૂકવણી',

          // stock update
          'stockupdate': 'સ્ટોક અપડેટ',
          'type': 'પ્રકાર',
          'editstockupdate': 'એડિટ સ્ટોક અપડેટ',


          // dispatch
          'dispatch': 'રવાના',
          'editdispatch': 'એડિટ રવાના',
          'avgfat': 'સરેરાશ ચરબી',
          'avgsnf': 'સરેરાશ એસએનએફ',
          'avgclr': 'એવજી સીએલઆર',
          'noofcans': 'કેનની સંખ્યા',
        },
        'mr_IN': {
          'language': 'इंग्रजी',
          'home': 'होमी',
          'notes': 'नोट्स',
          'accounts': 'खाती',
          'addaccounts': 'खाती जोडा',
          'allaccounts': 'सर्व खाती',
          'bankaccounts': 'बँक खाती',
          // Add Account inner page
          'vendorcode': 'विक्रेता कोड',
          'vendorname': 'विक्रेता नाव',
          'fathername': 'वडिलांचे नाव/नामनिर्देशित',
          'phonenumber': 'फोन नंबर',
          'address': 'पत्ता',
          'mobilenumber': 'मोबाईल नंबर',
          'gstinnumber': 'GSTIN क्रमांक',
          'emailaddress': 'ईमेल पत्ता',
          'pannumber': 'पॅन क्रमांक',
          'aadharnumber': 'पाया संख्या',
          'bankname': 'बँक नाव',
          'bankbranch': 'बँक बरंच',
          'accountnumber': 'अकाउंट नंबर',
          'ifsc': 'IFSC',
          'city': 'शहर',
          'save': 'जतन करा',
          'action': 'कृती',
          'task': 'कार्य',
          'milkcollection': 'मिल्क कलेक्शन',
          // milk collection
          'date': 'तारीख',
          'time': 'वेळ',
          'shift': 'शिफ्ट',
          'cattletype': 'गुरांचा प्रकार',
          'fat': 'फॅट',
          'snf': 'एस एन एफ',
          'clr': 'सी एल आर',
          'weight': 'वजन',
          'rate': 'दर',
          'amount': 'रक्कम',
          'delete': 'हटवा',
          'edit': 'एडिट ',
          'editmilkcollection': 'एडिट मिल्क कॉलेक्टिव ',
          'milksale': 'दुधाची विक्री',
          'exportto': 'Export To',
          'sure': 'तुम्हाला नक्की डिलीट करायचे आहे का?',
          'yes': 'होय',
          'no': 'नाही',
          'editmilksale': 'एडिट दुधाची विक्री',
          'kg': 'KG',
          'l': 'L',
          'exportto': 'निर्यात करा',
          'editaccount': 'एडिट खाती',

          // item sale
          'itemsale': 'आयटम विक्री',
          'srno': 'क्र',
          'itemname': 'आयटमचे नाव',
          'units': 'एकके',
          'quantity': 'प्रमाण',
          'add': '+जोडा',
          'print': 'प्रिंट करा',
          'item': 'आयटम',

          // payments
          'payments': 'देयके',
          'billnumber': 'बिल क्र',
          'editpayment': 'एडिट देयके',

          // stock update
          'stockupdate': 'સ્ટોક અપડેટ',
          'type': 'प्रकार',
          'editstockupdate': 'एडिट સ્ટોક અપડેટ',



          // dispatch
          'dispatch': 'पाठवणे',
          'editdispatch': 'एडिट पाठवणे',
          'avgfat': 'सरासरी फॅट',
          'avgsnf': 'सरासरी एसएनएफ',
          'avgclr': 'सरासरी सीएलआर',
          'noofcans': 'डब्यांची संख्या नाही',
        },
        'te_IN': {
          'language': 'భాష',
          'home': 'ఇళ్లు',
          'notes': 'గమనిక',
          'accounts': 'ఖాతాలు',
          'addaccounts': 'ఖాతాలను జోడించండి',
          'allaccounts': 'అన్ని ఖాతాలు',
          'bankaccounts': 'బ్యాంకు ఖాతాల',
          // Add Account inner page
          'vendorcode': 'वవిక్రేత గుర్తింపు',
          'vendorname': 'విక్రేత యొక్క పేరు',
          'fathername': 'తండ్రి పేరు/నామినీ',
          'phonenumber': 'ఫోను నంబరు',
          'address': 'చిరునామా',
          'mobilenumber': 'మొబైల్ నంబర్',
          'gstinnumber': 'GSTIN సంఖ్య',
          'emailaddress': 'ఇమెయిల్ చిరునామా',
          'pannumber': 'పాన్ సంఖ్య',
          'aadharnumber': 'ఆధార్ నంబర్',
          'bankname': 'బ్యాంకు పేరు',
          'bankbranch': 'బ్యాంకు శాఖ',
          'accountnumber': 'ఖాతా సంఖ్య',
          'ifsc': 'శాఖల ఐఎఫ్ఎస్సీ కోడ్ల మార్పు.',
          'city': 'నగరం',
          'save': 'సేవ్',
          'action': 'చర్య',
          'task': 'పని',
          'milkcollection': 'పాల సేకరణ',
          // milk collection
          'date': 'తేదీ',
          'time': 'సమయం',
          'shift': 'మార్పు',
          'cattletype': 'పశువుల రకం',
          'fat': 'కొవ్వు',
          'snf': 'ఘన కాదు కొవ్వు',
          'clr': 'లాక్టోఫాస్ట్ పఠనం సరిదిద్దబడింది',
          'weight': 'బరువు',
          'rate': 'ధర',
          'amount': 'మొత్తం',
          'delete': 'తొలగించు',
          'edit': 'ఎడిట్',
          'editmilkcollection': ' ఎడిట్ మిల్క్ కలెక్షన్',
          'milksale': 'పాల అమ్మకం',
          'editmilksale': 'ఎడిట్ పాల అమ్మకం',
          'exportto': 'Export To',
          'sure': 'మీరు తొలగించాలనుకుంటున్నారా ఖచ్చితంగా?',
          'yes': 'అవును',
          'no': 'లేదు',
          'kg': 'KG',
          'l': 'L',
          'exportto': 'కు ఎగుమతి చేయండి',
          'editaccount': 'ఎడిట్ ఖాతాలు',

          // item sale
          'itemsale': 'వస్తువు అమ్మకం',
          'srno': 'ఎస్. నం',
          'itemname': 'వస్తువు పేరు',
          'units': 'యూనిట్లు',
          'quantity': 'పరిమాణం',
          'add': '+జోడించు',
          'print': 'ముద్రణ',
          'item': 'వస్తువు',

          // payments
          'payments': 'చెల్లింపులు',
          'billnumber': 'బిల్ నెం',
          'editpayment': 'ఎడిట్ చెల్లింపులు',

          // stock update
          'stockupdate': 'స్టాక్ అప్‌డేట్',
          'type': 'టైప్ చేయండి',
          'editstockupdate': 'ఎడిట్ స్టాక్ అప్‌డేట్',


          // dispatch
          'dispatch': 'పంపడం',
          'editdispatch': 'ఎడిట్ పంపడం',
          'avgfat': 'ఎవిజి కొవ్వు',
          'avgsnf': 'ఎవిజి ఎస్ఎన్ఎఫ్',
          'avgclr': 'ఎవిజి సిఎల్ఆర్',
          'noofcans': 'డబ్బాల సంఖ్య',
        },
      };
}

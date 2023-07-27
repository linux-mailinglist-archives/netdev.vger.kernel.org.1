Return-Path: <netdev+bounces-22056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC1765CBB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6019428249F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC71C9E1;
	Thu, 27 Jul 2023 20:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E128F41
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 20:00:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D1DB5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfStJGCwMLrBJAvAVMVO13HPHHy6bR4ktCwof99QJQ2EwFZbOdAOhQqvpSlslK3cHcEb01TokfXYP7VqgZclWgI5O8B44Yf+T7i+wYK4vM5cJM8y4R7MdfY9HP4W2UJcX+A81SjVe2UwmI2KH3qNgmhM4KRn/V9RwTDOhgYTTCO2HuzkuKKy8P8zm0QqPEtfCpPe4EOweqgwt4GofbXAiPfFvToycjA7+8PGzzFiDzq+/1tiSx5bGIs7MNJdUHNLIN6fMVSLifR29uNnW8wdJfGSjIlU8m1IqyrDwsxVwrG7VbvnsydgUSVU0epROpNmOPK8NvnTyEPohAFEuhaaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQNMATfflw9F/iJT4/e5qJPUzOPEPx3xBIMOQws7USs=;
 b=cgbpqFKQhezUiytZpgh9IeXO0PXRKmHUXWlffnJXU1n1O1tKpIw8ZIqXaWF/PTDo5muoepXusUg6op1vX+K7RKk5rFVL+Gh/GKzer+D9z09kNMAJ5gn6je9sgRrJlYLep32SiAHDF9wkNOdk92NNqa02J0l8YCt6jxRE5mMTemvm3kb9gtWSw3+1mg7Jyr/ItvA80QBtcmnpMq4IhmFS9wCXUbErbEj/zev9jGCFTdG4axQBc75l1bJdgXbU96geBTegOMY6RLMQ6Ky84cMAYtcU+JihWIk0QSU4XkJrrM0n2LgF0qoUR4vJun+W/m7atcsJ4nyS8pVz8KbtjYlzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=welotec.com; dmarc=pass action=none header.from=welotec.com;
 dkim=pass header.d=welotec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=welotec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQNMATfflw9F/iJT4/e5qJPUzOPEPx3xBIMOQws7USs=;
 b=M5Qr/3jLeoT++yFRKGJ0sJPGhIVIHsBCtwg1bdScwMqWzOv/OIo4ztgC/fwDDqQb7Oxu7P9AUD3z0Kz5InL3dlsFMwOoZ1CDT5PPDpxmJ0gLfBf5M5mWanU+feCHNri9zEwgR2Zt8AdBFGVue7OlV8P2IZgjwECe1yKdWNs78FI=
Received: from AM0PR04MB5764.eurprd04.prod.outlook.com (2603:10a6:208:12f::20)
 by DU2PR04MB9146.eurprd04.prod.outlook.com (2603:10a6:10:2f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:00:43 +0000
Received: from AM0PR04MB5764.eurprd04.prod.outlook.com
 ([fe80::176:d0d2:340f:7687]) by AM0PR04MB5764.eurprd04.prod.outlook.com
 ([fe80::176:d0d2:340f:7687%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 20:00:43 +0000
From: Martin Kohn <m.kohn@welotec.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Martin Kohn <m.kohn@welotec.com>
Subject: [PATCH] net: usb: qmi_wwan: add Quectel EM05GV2
Thread-Topic: [PATCH] net: usb: qmi_wwan: add Quectel EM05GV2
Thread-Index: AQHZwHRS9JZvjvWM60ekV3+xdLUeEg==
Date: Thu, 27 Jul 2023 20:00:43 +0000
Message-ID:
 <AM0PR04MB57648219DE893EE04FA6CC759701A@AM0PR04MB5764.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=welotec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5764:EE_|DU2PR04MB9146:EE_
x-ms-office365-filtering-correlation-id: af4ea2c1-3a59-4b05-596e-08db8edc28d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0jIg5UhE9YoRLOVUjy0oDD7h6UBM56o/DBQCD/aUu/3rKI93GkAIE9orLE0FcxHLv/w1YvN7RSmebBHELm9PsUoOJQDHR23JUK5cn6jfI7TpKPzejVUHFKo+Pm9N7khujZ1dcbOBGDS/M5Yl4dC2tbu6p2P/UGxZNUf+aUSphbQDfq1YhiT7+RWeF/62qsf4zrgBIg83paoed7TKss1BiB1l2hd1eIG0olQCWF0vxvg5Z/5oj8ghamlXm/yvR5SZBVx7n3tLKe9VTK1K34HJ2s4A3P0KwtxCWzkfiCDGIDYJ7+tiWVxGQxw5lVVeMvwPLXygbfLGL0HhkDkL1AlsaigMFg4B92akcVyj539L8iUPQWrY9CyRzjEApbMuj7Yd9YRwHMFeOTCeZQiBgEKbZYLgr3GdzeL64LBZddy7UcyabtIGYZI5xuATStR+rcbc14RCMxnBqQQ3qmYh5Ijy8NAmQuYTJxHGwpClMTKiwruIVumDZFGO8qRE5xJRYXxz0+oJ4rkb2qOiUcWrQWKigqBzApjYD1pplRYv1PE8k81fV20YfBGE6YSspk9rDdMhn/HIpP5hFAbHmDT1/qM5yrggZE4yZduPAVlTOb4MEDHf/RwiIu9sz342NlV2y3+6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5764.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39830400003)(346002)(396003)(451199021)(9686003)(478600001)(7696005)(66476007)(6506007)(71200400001)(2906002)(66446008)(66556008)(6916009)(316002)(8936002)(91956017)(76116006)(52536014)(8676002)(5660300002)(41300700001)(66946007)(64756008)(38100700002)(122000001)(4326008)(86362001)(33656002)(38070700005)(55016003)(107886003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?neHQp+rCpE9Y6cpLTdh1Vqj/vT4dQBavyQmctYOuF7VX7Ed7VsYeSmKyah?=
 =?iso-8859-1?Q?GNu1SyahyzroQSFVkVqh5gm/0RG+TDXg5vZYICjACPU7MJdeFNgxckhiwl?=
 =?iso-8859-1?Q?Bx433n3chllAylSg8T5/SQLJa1FFcCSujhwMMpxnZ6xA+kV2dvEnCSfbSl?=
 =?iso-8859-1?Q?K8Lyur+PT+7o5CqSbWP3/0/ay+05KJWwlNCZl14Y16V6Pwisn3GzQeZSGI?=
 =?iso-8859-1?Q?xaUWvDz0Ct8B/uBrEX25BWRRBpgSXCufL5IjiymuDY8MEhKrgbq5CMDHvu?=
 =?iso-8859-1?Q?2y5bpmQBVXRAcQ4thQCBsb0Vqt9uElBR5O/bZhTbA6iWSncLUF8BuAEIOz?=
 =?iso-8859-1?Q?eOOzq/YayChPmNpfWhjSwpIr3VWsKuGX41as0174l6kBqBIo2ngwdFYhl7?=
 =?iso-8859-1?Q?vpzqaR3NuoFHY8aqsqFGZ+/1qPMZPciCBhj/J/GddrEnUD3bgSBzKD43ce?=
 =?iso-8859-1?Q?G2PNMjhEDjC8ITCoAPA/0LVgwiOhaxa/avYW7R6c6bUrvrKXXEcpTeWLVN?=
 =?iso-8859-1?Q?WmoO0qTVJT3WCxS1Fcwsvi/+qsr4760+EsteBSao3Qxgwh5AaKB7pcotI9?=
 =?iso-8859-1?Q?6R0sB9LYL6RgFO6yywtvo5lJ+rYNxbSG19TGyfrNbO62AvEXECIGZOW6j0?=
 =?iso-8859-1?Q?EdSp2FwZtRTXl7j9P5xq3ZyOs4YVkNjwH9kTIogSaIN9joPjr2KDYRrS9X?=
 =?iso-8859-1?Q?TT6ZST8uxsGgT93UbXzbb0jl70CZYaPOqv/Mv+RU/jFb6dG/LKUNdvt88J?=
 =?iso-8859-1?Q?2zDjJttflO/pEDzIKACbMP0ur+TtFDVpO5ukZCCObdiBWVomm8qlBMLwva?=
 =?iso-8859-1?Q?FuEnniB/h4JunM6VAw2SMPQghBclSjQpzj4Idn6W9M5AYD9tCNonk6V65K?=
 =?iso-8859-1?Q?1G0YOr3de4jv6YzmTD5kOnNl0AAj/IFhIkR7DVFboSMVtzwJLJh/yNYI7B?=
 =?iso-8859-1?Q?BejzKtFCD4Ciq3GKAwdFcVpqVKoAjBDnnz0C9ArO9bbCirfI01F5vbYnhx?=
 =?iso-8859-1?Q?VUOwvpNV7mhxhDfdVexfTpaOKET59Q4qsRPY72vq8IFR3WCusI15jGpirX?=
 =?iso-8859-1?Q?D/MoFoXMKQjQLdPqI54oZMnVhseOPSgtweypTQbuUh+/pYKOvoGqjk+jZU?=
 =?iso-8859-1?Q?goKG1xeF2HCRbvDHk2ZX2Ju1/z1Lyp4UEQce/ouR81jPDeje/KykMn8uIP?=
 =?iso-8859-1?Q?/4/z50HeB8h2bp0uhvbHUUzu3U6NVcFjDg01dxjBfrB1/9t7iyW+mDTS5T?=
 =?iso-8859-1?Q?dLX3VJrvZSjW1qwUSdyYKoks55MCbwscBmraHCpzDDlreBVkDQVQLOOR/B?=
 =?iso-8859-1?Q?gQUd92eEMn1BRS83XGAJGwrsb6Hhy8JUTDMfLA+P62/au5KW0z/xEGSz97?=
 =?iso-8859-1?Q?RD5BqlLKy8GkQHGLHoovIDu5S2A6YoOROqNaz9o+gW/GoYgr6pmhjY1qBO?=
 =?iso-8859-1?Q?a8BgFdlA+a2HexFyW6y1nvfp/v2B51B6y41t840GB0ldzCwoa8FkurbrTL?=
 =?iso-8859-1?Q?v0+Q2c7Llbc8a1wPuy18jji6//PpBWrxTqC/gDInZf/SGAM1nBiM8mCImO?=
 =?iso-8859-1?Q?VzVdRo99ZXSaVnFWKUWVMWz5xkjd2MZMgPLtBJdktFtl1YwIqM0qncSAB9?=
 =?iso-8859-1?Q?HrP7WSib7xvEVWf7/F8wAU7rwuqkrsIz+bchUtI9wL1kwXhuH5hBriwmv7?=
 =?iso-8859-1?Q?wCpvnOUsaNFM9dnAD40=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: welotec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5764.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ea2c1-3a59-4b05-596e-08db8edc28d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 20:00:43.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 25111a7f-1d5a-4c51-a4ca-7f8e44011b39
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+vzspODq7ZyNvr6mac/ENWKOrI3qhsKIiJ516Y3frOMw22BIzJyDTMXuiCMfARAGM7oyfxJ6D4pNkcLdUihuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9146
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for Quectel EM05GV2 (G=3Dglobal) with vendor ID =0A=
0x2c7c and product ID 0x030e=0A=
=0A=
Enabling DTR on this modem was necessary to ensure stable operation.=0A=
Patch for usb: serial: option: is also in progress.=0A=
=0A=
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480  Mx=
Ch=3D 0=0A=
D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1=0A=
P:  Vendor=3D2c7c ProdID=3D030e Rev=3D 3.18=0A=
S:  Manufacturer=3DQuectel=0A=
S:  Product=3DQuectel EM05-G=0A=
C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA=0A=
I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption=0A=
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
I:* If#=3D 1 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption=0A=
E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms=0A=
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption=0A=
E:  Ad=3D85(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms=0A=
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption=0A=
E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms=0A=
E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dqmi_wwan=0A=
E:  Ad=3D89(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms=0A=
E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A=
=0A=
Signed-off-by: Martin Kohn <m.kohn@welotec.com>=0A=
---=0A=
 drivers/net/usb/qmi_wwan.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c=0A=
index 417f7ea1fffa..07949ee9137d 100644=0A=
--- a/drivers/net/usb/qmi_wwan.c=0A=
+++ b/drivers/net/usb/qmi_wwan.c=0A=
@@ -1423,6 +1423,7 @@ static const struct usb_device_id products[] =3D {=0A=
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */=0A=
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */=0A=
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */=0A=
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */=0A=
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */=0A=
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */=0A=
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM sup=
port*/=0A=
-- =0A=
2.34.1=0A=


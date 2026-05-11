Return-Path: <netdev+bounces-286781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COQ5KugdAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14E514412
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93B3C30229C4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B147D93F;
	Mon, 11 May 2026 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="LXoQ90Sw"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAD47CC9E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523583; cv=none; b=U5eXQMEc09BUC2lNYbU9FdQ5V+vOa5HsCrJujpKd+FbyrAU5RTZ/r9oNUJK5k/8goXNiPaHlIjxu+MrgXOnNm1cW5Ab0gUvFkfQg+egECLKYXyhsODrkdimKuD/RSVi/xA9tmU7PB/24+LgMSax2vmwYk5tCWcMIETgD1KcsI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523583; c=relaxed/simple;
	bh=m4ONSm2slNeHtZyz4pon7ypwUIFXKqjd1C5UCatAN/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pIUsR/+/+bwDzSH5j5z54cx4OSco4r/Urh67vatGw4uKiCbVn8LFSuCFjouhXB2lKhjX5Mm41wV/x+5Tb/DSm8oy0BSlAHx80AYZDVJBurpSTR3j3Mys37ZO4bWsYKf6LcZwq2cwvaUeouB77BC162zN4gcAxC0EvdZeitqlKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=LXoQ90Sw; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4x7NjeMoG/JFQdxw2W1gY7+jTzbP2nlebLKY6UsFCI=;
	b=LXoQ90SwBaJ6TWRC+gTLYHoWJkYi+4vro1q5qspRALQUUgSDrYaDAwlTTf7cMVnqEGtfPD
	hhkStg8jjmQR8RiNWEU4kV3Tgq+BKVFwPhOIrFrayeYRTBI/ThdZsAYXAQnHJeW77pAWsY
	R172SDSRADAZ5HHqjgiwF33i42WxBzCIEoeER1kB3qyMIUZ4+W4McI/m5G54pVPApAez3j
	OISchQEFsKXgT8JuSSMFXNlnxipGc5moJEOAXiZeqA6SzJWOWgWSyIj0obKxGf5kf+L/u7
	TCJH9o8+uMRK1pTwwVXUxlwbQd9ORrieJNVFl2vBtkWLwvSDUhZ6xsyPkaltaA==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-56-8QSYCgxKOrqMigmT50Jljg-1; Mon,
 11 May 2026 11:19:36 -0700
X-MC-Unique: 8QSYCgxKOrqMigmT50Jljg-1
X-Mimecast-MFC-AGG-ID: 8QSYCgxKOrqMigmT50Jljg_1778523574
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:31 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:31 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 6/9] net: ethernet: oa_tc6: Hardware timestamp
 support for OA TC6 framework
Thread-Topic: [PATCH net-next v2 6/9] net: ethernet: oa_tc6: Hardware
 timestamp support for OA TC6 framework
Thread-Index: AdzhcTse81qQOOzqQKmojAYfFScwyg==
Date: Mon, 11 May 2026 18:19:31 +0000
Message-ID: <CY8PR02MB9249D813205563D5C64ACEFF83382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: f527a9a4-74ae-43bd-1583-08deaf89d8d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021|3023799003|11063799003
x-microsoft-antispam-message-info: lCx+Ytkt9fyhJKPynT3ok21WS45rTLpfQyZ/138NuJGqbbKY+jz+nTjqdQn+snvSwjRhIeDbVh5ytb+ew8PIGy6CoznvIS+s5FwwLd3DgVmLl9Lq+j1n3ieaAM9lFMQSosEXC3Qud4NoC3wo3mpKmttFHZuae9ngQ3YI1yTt8QuGLZfWNkRcc/lnrNPipztO0TN+U47OKdC5a+UHb5xUgdHkAdQN9k6z8/l2T6VTv3YRovZxDgySf5fsvcrIBUMrH7h8Xcrs3Vn5efi978nyc/XjPyBuZJ57i0qzL+oWxEg8Kib5yGnvfCtOrpRAdbZso1IagjweeHzWRHmgAtrvwHQ3Y+N8/9qr2g2f6QEshh6UeN5+JaLAfrapmGoBoDKzEu5U0LkrWQirrmEldpIGVf9ykfmcc2Za3SUJmUtktBzGDA7zNew+46OZKX11ft8IJWd229Wjiym08iUV9EFInlV76zG/8ACFSdQL2Kko7CaEzkxuENx1najSZdn36wwxqlQZmOND8oZp5DpHyXAT3oc0Msf0uvCkffhMXKySVvVYn2ieQY/9WKsjT9gZQGnNgBFaU6zQPwiMazw8cIaifQ+odirdIatbZS8eFTOZq46qks7Oo4xh/sr1DRUBgG3daInn905XgmTv5gQ5Er/S+5sdb5d6viWSGM4UsYp4FMfg9em6pCbz65wU4jJ/sdKWH/wusxlCDEZq6EYNrkrEwWChkQI99ZxBQVcoc68t1g1MBfwhFBzE6IQ5Rb8Z83o5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021)(3023799003)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZJqYENjNjShG22VcavoAZmKOKtKyfDCxkYB+rpAxPm2thsvqPg6O/jj11gw7?=
 =?us-ascii?Q?ubz0RXQgK6ZI0oW2O4FQJZ0NqW1NMaOL7aRVlKr6GdvFovEPbtwmnDtxre4W?=
 =?us-ascii?Q?6US0J89IXEog/ZoQFGqxQ8093tpYFhDyxQ4lP9fB3linC8IKjXDhHvogPHdQ?=
 =?us-ascii?Q?Z0DUpngyGfWFp9KmzJ/f9xZJobStdp6ERDz9CaCr7/7oeMJ+TI1fMIY2YOqw?=
 =?us-ascii?Q?TrgZPEvdWo9/xoIkJYTPDv7+hbjuEltwdIBJ/zoFGXZJNqU+ro2fCDpaIKhe?=
 =?us-ascii?Q?G9cGrG4fnDOrpGh0VKAgGCotCvBHLal0ShADOgoM8aAp1iHCG8pT2loDy9/g?=
 =?us-ascii?Q?E79Ps3fSsIdxM03w8DAav10V2aDRpWbcQEi8PU6/nG91B7CpScZIH2xcUDRD?=
 =?us-ascii?Q?aZmRl9+0BKR20uxhHmoy9HMK+LIigD5TWBtCUWfo6Ss0MAHwj3RJwdddJWkA?=
 =?us-ascii?Q?5DrR89vYZnApMkBMv8Ty92VsTDfpU5vOszkqPrBrOmXV+xsA6/oMB9dwhRrV?=
 =?us-ascii?Q?63wpz/D0+oIdvL1CVPPTCt0BXW3ksviYVS2oGJngsj6TD/2GWNDUMPz1Qt+s?=
 =?us-ascii?Q?SYnTPo8XXI4p7HQlWGTNnIDemUx3gIYqPe8S0hS54lPPMIqHkmOxSnlYEGec?=
 =?us-ascii?Q?70mYTSSfK5ogBuHTDx+dvuE9eRZwluWlofP9OuLiph5GXaPBXeMhbKZRFAnr?=
 =?us-ascii?Q?m1M0uFTJ1m0wliCV0FVShpsc7aVCSmNmTLP8MqaXO3B72/rWTB/8mt6C+ivy?=
 =?us-ascii?Q?2bsRAoowGC9wMsMwfSK/uhWo2zmO32MrPNulzafLskx2LbfRZfU21OYPB1FI?=
 =?us-ascii?Q?3GSdaRgo19sKFLNkicveSb+lx5YFNmrrdKcS/0SFwNlQdJv22SwKu1LtJG1a?=
 =?us-ascii?Q?eFatJgC2mBN+XI5svOtm1/XhoC6/mTRSGusS/mQR7ydSpCqiVi6yOaxiDmCj?=
 =?us-ascii?Q?D1rqBWeV6HmDh4+8iQYngRcod1QWltoWNavi0lHf52QymrX2+gsgWnymSWoj?=
 =?us-ascii?Q?CG7Txv1OISdS9I6WkRco7+DYhfacWbVYt4t9FSfRIFYc5pHgmD5DXAbPU/AI?=
 =?us-ascii?Q?+G0EMxAGw/t+D19pQmzzQiIWH/h5re8Edtdk7u8lvSBh59RQU+9cS1Ypi0/6?=
 =?us-ascii?Q?n7ijkSAza/H4wBHC9UtK1LnP6B/5I4ViLeg1HEACcdtJW4UnuQx4r4w0aGUW?=
 =?us-ascii?Q?eYPfyOW/lzxJ8ywuSzYBmk+Y8SSm6XZum1h5ILAQwXs5aoUzUVg1Ynftme9U?=
 =?us-ascii?Q?i2MwILCPkfWoTXeKvP4Kkiiujhs3ChbkE5gRw5lRVOPVWJNG69iypozRGTAS?=
 =?us-ascii?Q?04P5XtujU04AKhQSkc+wRSEJsStcxf/kLIYReUIdQzivYdvAA0dUrWoDfRyr?=
 =?us-ascii?Q?jqHbcxVQGEqtrneuKJrtaVVcLFRmihaFSSwFk/Mqd1b/hjooGe3mJ4SPLGXf?=
 =?us-ascii?Q?4h+wmy1lf6tNGoPpsY+TtoFGE4QKOyq4cLMcznjPUGxkWEaaby95HMr42M9k?=
 =?us-ascii?Q?SADbRSycKEgKam0Ufu6Ke1/p6t+a2WTLVGv5dKXSvcIaK3IW53V8sgoT5yQP?=
 =?us-ascii?Q?sz0O2Rx5Yzw2GJ4wzCHyk4AGXI8URZv6bzO1H30P2nAaSYZUK5EU8lRBwXps?=
 =?us-ascii?Q?W14+luDImtCj9DivFaeZ2bQW2YJAFu0twj7VB73n2jKX+L4GrVB8ijQkQgLJ?=
 =?us-ascii?Q?y1vZ10Qa0H6uk11+/q3+UP+1kVU7lNUjOpJi2fr6SSLx0ND2MewjJssp+roT?=
 =?us-ascii?Q?vAR3usFmX5vSgNWvoDzrNyTKS6lNCkY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PNKJQFTNXwl0hpazM3jCcudPU3ZeYRgwUoWWhiwM35RkCclDAsE6EDwgLQQ32IvNOnZcY4SBVunoNcSuNPp0YpcTPRHnYa4i9WjrZFLL/1HKJRhSRvYA08KV7U4clCl7dj9i4lQ0y9kTrily2RLvGRHpS54TY6erntmIdV10Hs2k+aJsW/G7C6olYDk0BU6ryn+CkAu+/VAlSju7jKxrpx0/qFkG5nH9N62MzrBZXEzIOPSGWC3pvkpn5AboSKJG6Izikzl8EfbzoC3OK9dHnjCc/8JFbaymxAwjhkTbsToyzbhH9zykSAmzFVICuVu52tqtmcI0O1VJxN0VJhtjEQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f527a9a4-74ae-43bd-1583-08deaf89d8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:31.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trO0iPJoVpLoQ4wYAvnvVOvnROGuGFWmaZkdUlgRdHaBqQcFBztv8HtEJZg5IasJem2WteJgsSHx4YnrkqTARBpea7fZKJUfT1hqnp+jtD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uM2cHNAsMP7Bl_SSEIlfDiQdM0z2DuYOZHLNR0zVtqE_1778523574
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F14E514412
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286781-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Added hardware timestamp support as defined in Open Alliance
10BASET1x MACPHY_Serial_Interface specification. ioctl interface
added for ethtool to report and set the hardware timestamp feature

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 321 ++++++++++++++++++++++++++++++++--
 include/linux/oa_tc6.h        |   5 +
 2 files changed, 312 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index beeac008f..48bd75f42 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -24,9 +24,16 @@
 #define OA_TC6_REG_CONFIG0=09=09=090x0004
 #define CONFIG0_SYNC=09=09=09=09BIT(15)
 #define CONFIG0_ZARFE_ENABLE=09=09=09BIT(12)
+#define CONFIG0_FTSE_ENABLE=09=09=09BIT(7)
+#define CONFIG0_FTSS_ENABLE=09=09=09BIT(6)
+#define CONFIG0_FTS_ENABLE_MASK=09=09=09GENMASK(7, 6)
=20
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0=09=09=090x0008
+#define STATUS0_TTSCAC=09=09=09=09BIT(10)
+#define STATUS0_TTSCAB=09=09=09=09BIT(9)
+#define STATUS0_TTSCAA=09=09=09=09BIT(8)
+#define STATUS0_TTSCA_MASK=09=09GENMASK(10, 8)
 #define STATUS0_RESETC=09=09=09=09BIT(6)=09/* Reset Complete */
 #define STATUS0_HEADER_ERROR=09=09=09BIT(5)
 #define STATUS0_LOSS_OF_FRAME_ERROR=09=09BIT(4)
@@ -40,6 +47,10 @@
=20
 /* Interrupt Mask Register #0 */
 #define OA_TC6_REG_INT_MASK0=09=09=090x000C
+#define INT_MASK0_TTSCACM=09=09=09BIT(10)
+#define INT_MASK0_TTSCABM=09=09=09BIT(9)
+#define INT_MASK0_TTSCAAM=09=09=09BIT(8)
+#define INT_MASK0_TTSCA_MASK=09=09=09GENMASK(10, 8)
 #define INT_MASK0_HEADER_ERR_MASK=09=09BIT(5)
 #define INT_MASK0_LOSS_OF_FRAME_ERR_MASK=09BIT(4)
 #define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK=09BIT(3)
@@ -64,6 +75,7 @@
 #define OA_TC6_DATA_HEADER_START_WORD_OFFSET=09GENMASK(19, 16)
 #define OA_TC6_DATA_HEADER_END_VALID=09=09BIT(14)
 #define OA_TC6_DATA_HEADER_END_BYTE_OFFSET=09GENMASK(13, 8)
+#define OA_TC6_DATA_HEADER_TSC_OFFSET=09=09GENMASK(7, 6)
 #define OA_TC6_DATA_HEADER_PARITY=09=09BIT(0)
=20
 /* Data footer */
@@ -75,6 +87,8 @@
 #define OA_TC6_DATA_FOOTER_START_VALID=09=09BIT(20)
 #define OA_TC6_DATA_FOOTER_START_WORD_OFFSET=09GENMASK(19, 16)
 #define OA_TC6_DATA_FOOTER_END_VALID=09=09BIT(14)
+#define OA_TC6_DATA_FOOTER_RTSA_VALID=09=09BIT(7)
+#define OA_TC6_DATA_FOOTER_RTSP_VALID=09=09BIT(6)
 #define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET=09GENMASK(13, 8)
 #define OA_TC6_DATA_FOOTER_TX_CREDITS=09=09GENMASK(5, 1)
=20
@@ -105,6 +119,22 @@
 #define STATUS0_RESETC_POLL_DELAY=09=091000
 #define STATUS0_RESETC_POLL_TIMEOUT=09=091000000
=20
+#define OA_TC6_REG_TTSCA_HIGH=09=09=09(0x1010)
+#define OA_TC6_TSTAMP_SZ=09=09=098
+
+#define OA_TC6_TTSCA_REG_ID=09=09=091
+#define OA_TC6_TTSCB_REG_ID=09=09=092
+#define OA_TC6_TTSCC_REG_ID=09=09=093
+
+struct oa_tc6_ts_info_rx {
+=09bool rtsa;
+=09bool rtsp;
+};
+
+struct oa_tc6_ts_info_tx {
+=09u8 tsc;
+};
+
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
 =09struct device *dev;
@@ -130,6 +160,9 @@ struct oa_tc6 {
 =09bool rx_buf_overflow;
 =09bool int_flag;
 =09int vend1_mms;
+=09u8 tx_ts_idx;
+=09struct hwtstamp_config ts_config;
+=09struct list_head tx_ts_skb_q;
 };
=20
 enum oa_tc6_header_type {
@@ -191,6 +224,238 @@ static int oa_tc6_get_parity(u32 p)
 =09return !((p >> 28) & 1);
 }
=20
+static inline struct oa_tc6_ts_info_tx *oa_tc6_tsinfo_tx(struct sk_buff *s=
kb)
+{
+=09return (struct oa_tc6_ts_info_tx *)((skb)->cb);
+}
+
+static inline struct oa_tc6_ts_info_rx *oa_tc6_tsinfo_rx(struct sk_buff *s=
kb)
+{
+=09return (struct oa_tc6_ts_info_rx *)((skb)->cb);
+}
+
+static void oa_tc6_defer_for_hwtstamp(struct oa_tc6 *tc6, struct sk_buff *=
skb)
+{
+=09if (tc6->ts_config.tx_type !=3D HWTSTAMP_TX_ON || !skb ||
+=09    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) =3D=3D 0)
+=09=09return;
+
+=09skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
+=09u8 ret =3D tc6->tx_ts_idx++;
+
+=09if (ret =3D=3D OA_TC6_TTSCC_REG_ID)
+=09=09tc6->tx_ts_idx =3D OA_TC6_TTSCA_REG_ID;
+=09oa_tc6_tsinfo_tx(skb)->tsc =3D ret;
+
+=09list_add_tail(&skb->list, &tc6->tx_ts_skb_q);
+}
+
+static int oa_tc6_process_deferred_skb(struct oa_tc6 *tc6, u8 tsc)
+{
+=09struct skb_shared_hwtstamps tstamp;
+=09struct oa_tc6_ts_info_tx *ski;
+=09struct sk_buff *skb, *tmp;
+=09bool found =3D false;
+=09int ret =3D 0;
+
+=09/* Size of data must match OA_TC6_TSTAMP_SZ */
+=09u32 data[2];
+
+=09list_for_each_entry_safe(skb, tmp, &tc6->tx_ts_skb_q, list) {
+=09=09ski =3D oa_tc6_tsinfo_tx(skb);
+=09=09if (ski->tsc !=3D tsc)
+=09=09=09continue;
+=09=09if (found)
+=09=09=09dev_warn(&tc6->spi->dev, "Multiple skb with tsc =3D %d\n", tsc);
+=09=09found =3D true;
+=09=09list_del(&skb->list);
+
+=09=09// Retrieve the timestamping info
+=09=09ret =3D oa_tc6_read_registers(tc6,
+=09=09=09=09=09    OA_TC6_REG_TTSCA_HIGH +
+=09=09=09=09=09    2 * (tsc - 1), &data[0], 2);
+
+=09=09if (!ret) {
+=09=09=09tstamp.hwtstamp =3D ktime_set(data[0], data[1]);
+=09=09=09skb_tstamp_tx(skb, &tstamp);
+=09=09}
+
+=09=09dev_kfree_skb(skb);
+=09}
+=09return ret;
+}
+
+static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6)
+{
+=09u32 cfg0, irqm, status0;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &cfg0);
+=09if (ret) {
+=09=09dev_err(&tc6->spi->dev, "Failed to read CFG0 register\n");
+=09=09goto out;
+=09}
+
+=09ret =3D oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &irqm);
+=09if (ret) {
+=09=09dev_err(&tc6->spi->dev, "failed to read IRQM register\n");
+=09=09goto out;
+=09}
+
+=09if (tc6->ts_config.tx_type =3D=3D HWTSTAMP_TX_ON ||
+=09    tc6->ts_config.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
+=09=09cfg0 |=3D CONFIG0_FTS_ENABLE_MASK;
+=09else
+=09=09cfg0 &=3D ~CONFIG0_FTS_ENABLE_MASK;
+
+=09if (tc6->ts_config.tx_type =3D=3D HWTSTAMP_TX_ON)
+=09=09irqm &=3D ~INT_MASK0_TTSCA_MASK;
+=09else
+=09=09irqm |=3D INT_MASK0_TTSCA_MASK;
+
+=09/* Clear timestamp related IRQs */
+=09status0 =3D STATUS0_TTSCA_MASK;
+=09ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, status0);
+=09if (ret) {
+=09=09dev_err(&tc6->spi->dev, "failed to write STATUS0 register\n");
+=09=09goto out;
+=09}
+
+=09// apply configuration
+=09ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, irqm);
+=09if (ret) {
+=09=09dev_err(&tc6->spi->dev, "failed to write IRQM register\n");
+=09=09goto out;
+=09}
+
+=09ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, cfg0);
+=09if (ret) {
+=09=09dev_err(&tc6->spi->dev, "failed to write CFG0 register\n");
+=09=09goto out;
+=09}
+out:
+=09return ret;
+}
+
+static void oa_tc6_events_handle(struct oa_tc6 *tc6, u32 val)
+{
+=09/* check TX timestamping */
+=09if (val & STATUS0_TTSCAA)
+=09=09oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCA_REG_ID);
+
+=09if (val & STATUS0_TTSCAB)
+=09=09oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCB_REG_ID);
+
+=09if (val & STATUS0_TTSCAC)
+=09=09oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCC_REG_ID);
+}
+
+static void oa_tc6_update_ts_in_rx_skb(struct oa_tc6 *tc6)
+{
+=09struct sk_buff *skb =3D tc6->rx_skb;
+=09struct oa_tc6_ts_info_rx *ski;
+=09u32 ts[2];
+
+=09ski =3D oa_tc6_tsinfo_rx(skb);
+=09if (!ski->rtsa)
+=09=09return;
+
+=09ts[0] =3D be32_to_cpu(*((u32 *)(skb->data)));
+=09ts[1] =3D be32_to_cpu(*((u32 *)(skb->data) + 1));
+
+=09/* Check parity */
+=09if ((oa_tc6_get_parity(ts[0]) ^ oa_tc6_get_parity(ts[1])) =3D=3D
+=09    !ski->rtsp) {
+=09=09struct skb_shared_hwtstamps *hw_ts;
+=09=09/* Report timestamp to the upper layers */
+=09=09hw_ts =3D skb_hwtstamps(skb);
+=09=09memset(hw_ts, 0, sizeof(*hw_ts));
+=09=09hw_ts->hwtstamp =3D ktime_set(ts[0], ts[1]);
+=09}
+=09skb_pull(skb, sizeof(ts));
+}
+
+/**
+ * oa_tc6_hwtstamp_get - gets hardware timestamp config
+ * @tc6: oa_tc6 struct.
+ * @cfg: kernel copy of hardware timestamp config
+ */
+void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, struct kernel_hwtstamp_config=
 *cfg)
+{
+=09cfg->tx_type =3D tc6->ts_config.tx_type;
+=09cfg->rx_filter =3D tc6->ts_config.rx_filter;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_get);
+
+/**
+ * oa_tc6_hwtstamp_set - sets hardware timestamp config
+ * @tc6: oa_tc6 struct.
+ * @cfg: kernel copy of hardware timestamp config
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, struct kernel_hwtstamp_config =
*cfg)
+{
+=09switch (cfg->tx_type) {
+=09case HWTSTAMP_TX_OFF:
+=09case HWTSTAMP_TX_ON:
+=09=09break;
+=09default:
+=09=09return -ERANGE;
+=09}
+=09tc6->ts_config.tx_type =3D cfg->tx_type;
+=09if (cfg->rx_filter =3D=3D HWTSTAMP_FILTER_NONE)
+=09=09tc6->ts_config.rx_filter =3D cfg->rx_filter;
+=09else
+=09=09tc6->ts_config.rx_filter =3D HWTSTAMP_FILTER_ALL;
+=09return oa_tc6_set_hwtstamp_settings(tc6);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_set);
+
+/**
+ * oa_tc6_hwtstamp_ioctl - ioctl interface for hardware timestamp
+ * @tc6: oa_tc6 struct.
+ * @rq: request from socket interface
+ * @cmd: value to set/get timestamp configuration
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
+{
+=09struct kernel_hwtstamp_config kcfg;
+=09struct hwtstamp_config tscfg;
+=09int ret =3D 0;
+
+=09if (!netif_running(tc6->netdev))
+=09=09return -EINVAL;
+
+=09switch (cmd) {
+=09case SIOCSHWTSTAMP:
+=09=09if (copy_from_user(&tscfg, rq->ifr_data, sizeof(tscfg)))
+=09=09=09return -EFAULT;
+
+=09=09if (tscfg.flags)
+=09=09=09return -EINVAL;
+=09=09memset(&kcfg, 0, sizeof(kcfg));
+=09=09kcfg.tx_type =3D tscfg.tx_type;
+=09=09kcfg.rx_filter =3D tscfg.rx_filter;
+
+=09=09ret =3D oa_tc6_hwtstamp_set(tc6, &kcfg);
+=09=09break;
+
+=09case SIOCGHWTSTAMP:
+=09=09break;
+=09default:
+=09=09return -EOPNOTSUPP;
+=09}
+=09if (copy_to_user(rq->ifr_data, &tc6->ts_config,
+=09=09=09 sizeof(tc6->ts_config)))
+=09=09ret =3D -EFAULT;
+
+=09return ret;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_ioctl);
+
 /**
  * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
  * @tc6: oa_tc6 struct.
@@ -697,6 +962,9 @@ static int oa_tc6_process_extended_status(struct oa_tc6=
 *tc6)
 =09=09return ret;
 =09}
=20
+=09if ((value & STATUS0_TTSCA_MASK) !=3D 0)
+=09=09oa_tc6_events_handle(tc6, value & STATUS0_TTSCA_MASK);
+
 =09/* Clear the error interrupts status */
 =09ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, value);
 =09if (ret) {
@@ -768,10 +1036,15 @@ static int oa_tc6_process_rx_chunk_footer(struct oa_=
tc6 *tc6, u32 footer)
=20
 static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
+=09oa_tc6_update_ts_in_rx_skb(tc6);
+
 =09tc6->rx_skb->protocol =3D eth_type_trans(tc6->rx_skb, tc6->netdev);
 =09tc6->netdev->stats.rx_packets++;
 =09tc6->netdev->stats.rx_bytes +=3D tc6->rx_skb->len;
=20
+=09if ((tc6->netdev->hw_features & NETIF_F_RXFCS) !=3D 0)
+=09=09skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 =09netif_rx(tc6->rx_skb);
=20
 =09tc6->rx_skb =3D NULL;
@@ -782,24 +1055,29 @@ static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6,=
 u8 *payload, u8 length)
 =09memcpy(skb_put(tc6->rx_skb, length), payload, length);
 }
=20
-static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
+static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6, u32 footer)
 {
+=09struct oa_tc6_ts_info_rx *ski;
+
 =09tc6->rx_skb =3D netdev_alloc_skb_ip_align(tc6->netdev, tc6->netdev->mtu=
 +
-=09=09=09=09=09=09ETH_HLEN + ETH_FCS_LEN);
+=09=09=09=09=09=09ETH_HLEN + ETH_FCS_LEN + OA_TC6_TSTAMP_SZ);
 =09if (!tc6->rx_skb) {
 =09=09tc6->netdev->stats.rx_dropped++;
 =09=09return -ENOMEM;
 =09}
=20
+=09ski =3D oa_tc6_tsinfo_rx(tc6->rx_skb);
+=09ski->rtsa =3D FIELD_GET(OA_TC6_DATA_FOOTER_RTSA_VALID, footer);
+=09ski->rtsp =3D FIELD_GET(OA_TC6_DATA_FOOTER_RTSP_VALID, footer);
 =09return 0;
 }
=20
 static int oa_tc6_prcs_complete_rx_frame(struct oa_tc6 *tc6, u8 *payload,
-=09=09=09=09=09 u16 size)
+=09=09=09=09=09 u16 size, u32 footer)
 {
 =09int ret;
=20
-=09ret =3D oa_tc6_allocate_rx_skb(tc6);
+=09ret =3D oa_tc6_allocate_rx_skb(tc6, footer);
 =09if (ret)
 =09=09return ret;
=20
@@ -810,11 +1088,11 @@ static int oa_tc6_prcs_complete_rx_frame(struct oa_t=
c6 *tc6, u8 *payload,
 =09return 0;
 }
=20
-static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16=
 size)
+static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16=
 size, u32 footer)
 {
 =09int ret;
=20
-=09ret =3D oa_tc6_allocate_rx_skb(tc6);
+=09ret =3D oa_tc6_allocate_rx_skb(tc6, footer);
 =09if (ret)
 =09=09return ret;
=20
@@ -859,7 +1137,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
 =09=09size =3D end_byte_offset + 1 - start_byte_offset;
 =09=09return oa_tc6_prcs_complete_rx_frame(tc6,
 =09=09=09=09=09=09     &data[start_byte_offset],
-=09=09=09=09=09=09     size);
+=09=09=09=09=09=09     size, footer);
 =09}
=20
 =09/* Process the chunk with only rx frame start */
@@ -867,7 +1145,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
 =09=09size =3D OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
 =09=09return oa_tc6_prcs_rx_frame_start(tc6,
 =09=09=09=09=09=09  &data[start_byte_offset],
-=09=09=09=09=09=09  size);
+=09=09=09=09=09=09  size, footer);
 =09}
=20
 =09/* Process the chunk with only rx frame end */
@@ -892,7 +1170,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
 =09=09size =3D OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
 =09=09return oa_tc6_prcs_rx_frame_start(tc6,
 =09=09=09=09=09=09  &data[start_byte_offset],
-=09=09=09=09=09=09  size);
+=09=09=09=09=09=09  size, footer);
 =09}
=20
 =09/* Process the chunk with ongoing rx frame data */
@@ -946,13 +1224,15 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_=
tc6 *tc6, u16 length)
 }
=20
 static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid=
,
-=09=09=09=09=09 bool end_valid, u8 end_byte_offset)
+=09=09=09=09=09 bool end_valid, u8 end_byte_offset,
+=09=09=09=09=09 u8 tsc)
 {
 =09u32 header =3D FIELD_PREP(OA_TC6_DATA_HEADER_DATA_NOT_CTRL,
 =09=09=09=09OA_TC6_DATA_HEADER) |
 =09=09     FIELD_PREP(OA_TC6_DATA_HEADER_DATA_VALID, data_valid) |
 =09=09     FIELD_PREP(OA_TC6_DATA_HEADER_START_VALID, start_valid) |
 =09=09     FIELD_PREP(OA_TC6_DATA_HEADER_END_VALID, end_valid) |
+=09=09     FIELD_PREP(OA_TC6_DATA_HEADER_TSC_OFFSET, tsc) |
 =09=09     FIELD_PREP(OA_TC6_DATA_HEADER_END_BYTE_OFFSET,
 =09=09=09=09end_byte_offset);
=20
@@ -971,6 +1251,7 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc6=
 *tc6)
 =09enum oa_tc6_data_start_valid_info start_valid;
 =09u8 end_byte_offset =3D 0;
 =09u16 length_to_copy;
+=09u8 tsc =3D 0;
=20
 =09/* Initial value is assigned here to avoid more than 80 characters in
 =09 * the declaration place.
@@ -980,8 +1261,10 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc=
6 *tc6)
 =09/* Set start valid if the current tx chunk contains the start of the tx
 =09 * ethernet frame.
 =09 */
-=09if (!tc6->tx_skb_offset)
+=09if (!tc6->tx_skb_offset) {
 =09=09start_valid =3D OA_TC6_DATA_START_VALID;
+=09=09tsc =3D oa_tc6_tsinfo_tx(tc6->ongoing_tx_skb)->tsc;
+=09}
=20
 =09/* If the remaining tx skb length is more than the chunk payload size o=
f
 =09 * 64 bytes then copy only 64 bytes and leave the ongoing tx skb for
@@ -1002,12 +1285,17 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_=
tc6 *tc6)
 =09=09tc6->tx_skb_offset =3D 0;
 =09=09tc6->netdev->stats.tx_bytes +=3D tc6->ongoing_tx_skb->len;
 =09=09tc6->netdev->stats.tx_packets++;
-=09=09kfree_skb(tc6->ongoing_tx_skb);
+
+=09=09/* Free the ones that are not saved for later processing,
+=09=09 * like timestamping.
+=09=09 */
+=09=09if (!(skb_shinfo(tc6->ongoing_tx_skb)->tx_flags & SKBTX_IN_PROGRESS)=
)
+=09=09=09kfree_skb(tc6->ongoing_tx_skb);
 =09=09tc6->ongoing_tx_skb =3D NULL;
 =09}
=20
 =09*tx_buf =3D oa_tc6_prepare_data_header(OA_TC6_DATA_VALID, start_valid,
-=09=09=09=09=09     end_valid, end_byte_offset);
+=09=09=09=09=09     end_valid, end_byte_offset, tsc);
 =09tc6->spi_data_tx_buf_offset +=3D OA_TC6_CHUNK_SIZE;
 }
=20
@@ -1025,6 +1313,8 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(stru=
ct oa_tc6 *tc6)
 =09=09=09tc6->ongoing_tx_skb =3D tc6->waiting_tx_skb;
 =09=09=09tc6->waiting_tx_skb =3D NULL;
 =09=09=09spin_unlock_bh(&tc6->tx_skb_lock);
+=09=09=09oa_tc6_defer_for_hwtstamp(tc6,
+=09=09=09=09=09=09  tc6->ongoing_tx_skb);
 =09=09}
 =09=09if (!tc6->ongoing_tx_skb)
 =09=09=09break;
@@ -1041,7 +1331,7 @@ static void oa_tc6_add_empty_chunks_to_spi_buf(struct=
 oa_tc6 *tc6,
=20
 =09header =3D oa_tc6_prepare_data_header(OA_TC6_DATA_INVALID,
 =09=09=09=09=09    OA_TC6_DATA_START_INVALID,
-=09=09=09=09=09    OA_TC6_DATA_END_INVALID, 0);
+=09=09=09=09=09    OA_TC6_DATA_END_INVALID, 0, false);
=20
 =09while (needed_empty_chunks--) {
 =09=09__be32 *tx_buf =3D tc6->spi_data_tx_buf +
@@ -1232,6 +1522,7 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, str=
uct sk_buff *skb)
 =09spin_lock_bh(&tc6->tx_skb_lock);
 =09tc6->waiting_tx_skb =3D skb;
 =09spin_unlock_bh(&tc6->tx_skb_lock);
+=09oa_tc6_tsinfo_tx(skb)->tsc =3D 0;
=20
 =09/* Wake spi kthread to perform spi transfer */
 =09wake_up_interruptible(&tc6->spi_wq);
@@ -1263,6 +1554,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, st=
ruct net_device *netdev)
 =09mutex_init(&tc6->spi_ctrl_lock);
 =09spin_lock_init(&tc6->tx_skb_lock);
 =09tc6->vend1_mms =3D -EOPNOTSUPP;
+=09tc6->tx_ts_idx =3D OA_TC6_TTSCA_REG_ID;
+=09INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
=20
 =09/* Set the SPI controller to pump at realtime priority */
 =09tc6->spi->rt =3D true;
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index d3c74555f..7fab8db3f 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -26,4 +26,9 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address=
, u32 value[],
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
 void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd);
+void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6,
+=09=09=09 struct kernel_hwtstamp_config *cfg);
+int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
+=09=09=09struct kernel_hwtstamp_config *cfg);
 #endif /* _LINUX_OA_TC6_H */
--=20
2.43.0



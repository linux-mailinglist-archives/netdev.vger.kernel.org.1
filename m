Return-Path: <netdev+bounces-293207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ikn2CPDhGWqrzggAu9opvQ
	(envelope-from <netdev+bounces-293207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 677DC607980
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E298031B0879
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D546AF36;
	Fri, 29 May 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="gmgK8tR4"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32646AEE5
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080107; cv=none; b=d/7jyWvMvw82MMF515eh6Hd5sW6lrbLyvjK8VF4SaMEtH6SAMtAGXWdeJvItR4zGKSAgNWLv/w1NyqS7NhmO113VOKiNQawthdrC2sQOn9xIRlOEQD2ibtVxY381rYF/UdGIvYFoz9Hspu0zAqp++reEHkw1WgL1D+Gd+6uNPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080107; c=relaxed/simple;
	bh=Ov608lSx2SqBSU7YrUR/x7AUyCCTx5sOCnPo1AvMqTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=daAI8M3In8gEUfBYcp2ntms0xkcRDzOjAfpjRjZfnjBFCpff9c8L1aY6oiByTnkXcrDqrAAuispPl5Uv/iL1jjDNJCWXQEJgH+UvpNJEqMgCpR1MJDX+Q544wbVd2n4MlwjP/pS2P6um8sCMzhGKi5zSzVHN61tInHrRvh4LBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=gmgK8tR4; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jzRjIFtrzpX+fy7DHm2/k48A1bVUxrhxGXl22rcpBxk=;
	b=gmgK8tR4Mr4VGMeEHw/UaN19yUFg0KvHmDOPYMCj3w6Pbi09NJKTFy6GTHHgEat3zf4HCx
	EoP7W4/EXOtF+o7UFW3xz2yB7bcDBzBh6G1XDV/U5Qv8y8JFhGJ+z49qvxAxI5BS43Y1Wu
	3h7p29PLsJ+w2vMiTHLq9nh2T9eC2za5V/7ONjfM2gBKxvyRdavXDddWpSa+lEEaAnZNe5
	eUhy79tjHifqye35eDwo3rtFxt3ghNZIYXfL50phKvSFY18/SOHDIdcIdJNB1OgMQPoeje
	FEb8LHjHT/faosIwzLeYuRKe5p0rZPeXyPqLq42ARQZ7V2MPhZ9rMQYJtpW9UQ==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-76-0j6Ja1oDMHGG-N9yV04MIA-1; Fri, 29 May 2026 11:41:32 -0700
X-MC-Unique: 0j6Ja1oDMHGG-N9yV04MIA-1
X-Mimecast-MFC-AGG-ID: 0j6Ja1oDMHGG-N9yV04MIA_1780080090
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:28 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:28 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Selvamani
 Rajagopal <Selvamani.Rajagopal@onsemi.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: Adzvmc0U2pnkhYraSem3MympdkFZgw==
Date: Fri, 29 May 2026 18:41:28 +0000
Message-ID: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: 57a90ffd-a531-4f38-5b94-08debdb1e4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|6133799003|3023799007|18002099003|18092099006|56012099006|11063799006|5023799004
x-microsoft-antispam-message-info: DFDiAbDykrQdbN/5iJiTuDbf1haZZV6GdkgC3/l7LeEZtOpy0MWybXVpOKM/bVbYYfo9tr0lqsgkumiTCPxUMmJHMsP0y6atzMYgSlM1+/b6en4vJw1fjJP9cv6aTasE5wUD3TTX+kj1raGyuwAQEQsiRXp7Ac8nehIWvXp9RConotXJIMMb2LaYGzVZlSBDDEGsTwRn7TxHqpCaWd1oTkIIwLMME1tpAEjDR9cGp3txxoy+c9a7f5tasmLFfz+88SlSMsuqq/4hiq9zj6ppfvU9DHYfWQnKEsn07whJxLpYficOz6eefJA6x5VW7Z1fb8D3zY7pHktw9lVOT13UWHMRjrezW2LLcjl8iDlUqlRBbk48Y46IO2aLz1VukWuJO9F/4bFj2RINL75CZUfPDk7JpRYOFZulG4Q7fWw5FfuuYnxIFv6wjWDXhr2IRVGmNBDg8BMO2eIuIjG6oNidCsK5xM2+LXM9lwx1STG1g5d3WnIGIVieEUVw7e8l/wVbFsDyfs9Twkqsu/3LqbLfA24WYeQAQ/u6wb0ZZHmLtTsD1L4qPSEVgA/yb473C5vEUbddHEaR85aTZcbQYRlxU96x7pxZCbx8RTbE30EaiK4IDuL4uDjOVNEEcdnH9dhwFOlv0EJlMEtg+ali2imjZuazREPmQ8SwMz6DQPxttks5l3EIcGc0VoIFM1YM5+Tt6/i0UULDLAdlnPVfC43Z0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(6133799003)(3023799007)(18002099003)(18092099006)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Up9DtIB2oCKlAv96tYvgBnMDZK+6irRv4LyiWdmI4GZ7XKtRXxuRt1Bqubk+?=
 =?us-ascii?Q?KCdRXPdEJose1m4SLpbwop+36j4Gu0UVW5Cw14qOPXW26ojRRf3w8p3y1A+O?=
 =?us-ascii?Q?6l5GxUxacc832sOkCeKMczKLjWbuGAXPq25g+w8WNv84edIdwFFxwFSikPs/?=
 =?us-ascii?Q?W19iBBAPutPq6BTtQhRKI7rd/0BsZ3J+dRprD1SIYA5f8k/jQiRw2IltfXNk?=
 =?us-ascii?Q?xwIVn36AelLeYikDkAb21V+9WGJ5kU0aSbTevJNY1RQghyJlreq7Hyrfws2g?=
 =?us-ascii?Q?+DyUZa9TB+r4BylNesbE0uZXItoeGpbVgg2nQ2ejMUrg3yEtlONRSVQ+f80T?=
 =?us-ascii?Q?Z+uAwxwyldrQwCodp1KnqTmPhi/1mP9vc665Ie2Xs3nRcMauDHyhIEHf0lP9?=
 =?us-ascii?Q?DMD3IDof1geg4H84EKFb1gz1Y2Oa4QDpfkcOw5VBpqfUmdMhsNrUXQKwLaq8?=
 =?us-ascii?Q?NWcs9YAL32siKkMlVPUH9sgE6lbWtE6WNSVpKwLu6YsNlxukWoSt+Y8cXbW2?=
 =?us-ascii?Q?nbBCtqSYKOZovoNBqFZVYcZYLdV8DqrDJ7Yni1LRCbxsB9OCsxHatMnrB5dl?=
 =?us-ascii?Q?EsDw0aN1/k76wyLtAx+EN5imddjgrsIe+9VS93XSIvHhEM5u8jzluUrf8FVb?=
 =?us-ascii?Q?h76q+KNa5PFtBEekNmusJGfiol1iciDV/1QwbrlccBNt7dXdecVnGpcTXpwr?=
 =?us-ascii?Q?D8XA4wHRnk1ewVp3wscMqOnQHpsPdDz9XSDhQqqGNKQ5R1CS3eAUsyRAxgfC?=
 =?us-ascii?Q?hGwuDvrgy+LvzyC9HffXLMiqKabBvD0yKnMxn+7dHBKrokR4hs6yoaL0zCfm?=
 =?us-ascii?Q?jyv88/Yy7nBYH6pN3KGMUUPhdGnGholsK01y52uwS0wI7gdqIxIeF8KaysMh?=
 =?us-ascii?Q?la5UzeN1462OUnBSemlWq7tC8vh/qblY8B9P2PMYOjjRlGyFLLtoLtp5bhEa?=
 =?us-ascii?Q?bDYEbIlgRoEVu0cT2esQmCrkdAqvmfaSeiSugIRX1EfiBzg5Y2SiOqca39KV?=
 =?us-ascii?Q?Ic1/ZZbEo+w9o+3l6rEm3y8a7QwiRpNZTtg9Wj4tTALkQF6lGOobrZIVdTN9?=
 =?us-ascii?Q?rKgh0Rq9XN9Z42YYfCu6B9H8r/pMOhIFSEZOMTslg2Z3Ocs3GJhO969hf36s?=
 =?us-ascii?Q?prKbKQRHzUM7s4G0s9RkiiAvtzPpUCvyIJ8pEeWJE+0BBind1MjIwxNUQgzo?=
 =?us-ascii?Q?ulnOmWeg6PmfH15KKXNZ/KMUdO73M7K3ZHdJJl0U07ARmVM20AHyjs0tK5nP?=
 =?us-ascii?Q?uxIHNx8G6lco+WwSrh5iFYtIbCBpbDAuDYf6MZUp2ctikGx8c2rerIs9bTtb?=
 =?us-ascii?Q?Jqhr2v0aHgOYolHvhY+cic3JIjVhdNBOKJXHhgScKyUjcvTMnB3Y6TkDumoO?=
 =?us-ascii?Q?2QcRUkQpKpIzU/DpAyVXit6oWiPaTJfLFicFRkqjgU2Wuy9dk69dj4jT3BHy?=
 =?us-ascii?Q?mzbWedPt3RwiL+Fuu8D/UN2BacluAh4qiebtwaiYQORQFtrdgZd7TcAfcp6H?=
 =?us-ascii?Q?VRupUMk5GwvMaVR5NAnAW7sHPaUPesPyqyjVAcKgGo9gDRjPjVcAetOG2nY6?=
 =?us-ascii?Q?iKbWLvzmtWJGMfQRHEbGZorFu0c6RL9kGH/d5G7kk80lBnXox65SY/O1nVjE?=
 =?us-ascii?Q?4YiF91RlWuPNWLXO16Knrf5OoO8f6Z61/EkvuUXKCq3xxSZTON29+1dO2f2I?=
 =?us-ascii?Q?ZNSpdZ7grDj2ErW5t4mTForMx4/hmRGVu8iNDigzQ71fkVzEI+p3cA+t7/ye?=
 =?us-ascii?Q?X6B+20qLm/0Jv7FgoEPxwWCMXdcZxXc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fSIPSqTbRZVAoSGVwc98akYW47hQbsLX4UFuv9YN9xqAt8MvS6QPbVeZQXGmby3hMhGx+vFIuJZKuT+LJvEJj91zAiD3NuCF/1CX/wjQVu1dPKlYIm57HH1g/vcA7M8JThxWzYStWHaM9kNQ/IMXxpZHXd4dCe4Jcnp/J4raYsxPy+uBOhB0f696ftI9EUvgWv/ZqoN4yKqYo5sQ+ozCWXrQ576pwxREK4lO59m2ifJsSVGZeS0lfg87VQUIz/51u3VytYU3hFqPLa6/1F/Uk8PlcEr4rzKLSdfY/xxFGhC8Ppd8X8jdsW64ZuY3WP+gN3IVE7sj8u+F53z1E8BtYQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a90ffd-a531-4f38-5b94-08debdb1e4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:28.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9efh49jroVvG1dPeQg1llqLQJeLGYEeLMBJW6fcZbVkKRkRoHvJgViO8/PZavYg/nYgikLGkHcawd5Cv+VB5ni71U4dGYsg9Toalzjf9u7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mvh1n1-IZoB1CHTCInX4PzkflA40s9UnCarvMEUSp0I_1780080090
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293207-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,linaro.org:email,onsemi.com:url,onsemi.com:email,onsemi.com:dkim,trustedfirmware.org:email]
X-Rspamd-Queue-Id: 677DC607980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Support for onsemi's S2500, 802.3 cg compliant Ethernet
transceiver with integrated MAC-PHY. Works with
Open Alliance TC6 framework.

adjtime callback is implemented using adjfine. If time
delta is too big, bigger than 1 second, using adjtime
would take long to reduce the delta. In those cases,
settime callback is used to reduce the delta. Once delta
becomes less than a second, it uses adjfine to reduce
the drift further.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/onsemi/Kconfig           |  21 +
 drivers/net/ethernet/onsemi/Makefile          |   7 +
 drivers/net/ethernet/onsemi/s2500/Kconfig     |  21 +
 drivers/net/ethernet/onsemi/s2500/Makefile    |   7 +
 .../net/ethernet/onsemi/s2500/s2500_ethtool.c | 764 ++++++++++++++++++
 .../net/ethernet/onsemi/s2500/s2500_hw_def.h  | 273 +++++++
 .../net/ethernet/onsemi/s2500/s2500_main.c    | 654 +++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c | 232 ++++++
 9 files changed, 1986 insertions(+)
 create mode 100644 drivers/net/ethernet/onsemi/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/s2500/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/s2500/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_main.c
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 76c823860111..ff9d437369c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19975,6 +19975,13 @@ S:=09Supported
 W:=09http://www.onsemi.com
 F:=09drivers/net/phy/ncn*
=20
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:=09Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:=09netdev@vger.kernel.org
+S:=09Supported
+F:=09Documentation/devicetree/bindings/net/onnn,s2500.yaml
+F:=09drivers/net/ethernet/onsemi/s2500/s2500_*
+
 OP-TEE DRIVER
 M:=09Jens Wiklander <jens.wiklander@linaro.org>
 L:=09op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/ons=
emi/Kconfig
new file mode 100644
index 000000000000..8dd3a3f074a2
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi network device configuration
+#
+
+config NET_VENDOR_ONSEMI
+=09bool "onsemi network devices"
+=09help
+=09  If you have a network card belonging to this class, say Y.
+
+=09  Note that the answer to this question doesn't directly affect the
+=09  kernel: saying N will just cause the configurator to skip all
+=09  the questions about onsemi ethernet devices. If you say Y, you
+          will be asked for your specific card in the following questions.
+
+if NET_VENDOR_ONSEMI
+
+source "drivers/net/ethernet/onsemi/s2500/Kconfig"
+
+endif # NET_VENDOR_ONSEMI
+
diff --git a/drivers/net/ethernet/onsemi/Makefile b/drivers/net/ethernet/on=
semi/Makefile
new file mode 100644
index 000000000000..f3d4eb154313
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+
+obj-$(CONFIG_S2500_MACPHY) +=3D s2500/
+
diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethern=
et/onsemi/s2500/Kconfig
new file mode 100644
index 000000000000..22b0afad7a21
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi S2500 Driver Support
+#
+
+if NET_VENDOR_ONSEMI
+
+config S2500_MACPHY
+=09tristate "S2500 support"
+=09depends on SPI
+=09select NCN26000_PHY
+=09select OA_TC6
+=09help
+=09  Support for the onsemi TS2500 MACPHY Ethernet chip.
+          It works under the framework that conform to OPEN Alliance
+          10BASE-T1x Serial Interface specification.
+
+          To compile this driver as a module, choose M here. The module wi=
ll be
+          called s2500.
+
+endif # NET_VENDOR_ONSEMI
diff --git a/drivers/net/ethernet/onsemi/s2500/Makefile b/drivers/net/ether=
net/onsemi/s2500/Makefile
new file mode 100644
index 000000000000..61ec705cdf9f
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+obj-$(CONFIG_S2500_MACPHY) :=3D s2500.o
+s2500-objs :=3D s2500_main.o s2500_ethtool.o s2500_ptp.o
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/ne=
t/ethernet/onsemi/s2500/s2500_ethtool.c
new file mode 100644
index 000000000000..7c44adfe71a5
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include <linux/ethtool.h>
+#include <linux/completion.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+
+#include "s2500_hw_def.h"
+
+#define S2500_NUM_REGS=09=09=0938
+#define S2500_REGDUMP_LEN=09=09(sizeof(u32) * (S2500_NUM_REGS * 2))
+
+#define S2500_LB_ETH_P=09=09=090x88B5
+#define S2500_LB_PAYLOAD_LEN=09=0964
+#define S2500_LB_DATA_SIGNATURE=09=090xC0DEFADE
+#define S2500_LB_DATA_PATTERN=09=090xA5
+#define S2500_LB_TEST_DATA_OFFSET=098
+#define S2500_LB_TEST_FRAMES=09=0920
+#define S2500_LB_PASS_PERCENT=09=0990
+#define S2500_LB_CAPTURE_TIMEOUT_MS=09500
+#define S2500_LB_FRAME_GAP_US=09=091000
+
+#define S2500_NUM_MAC_STATS=09=0921
+#define S2500_NUM_RMON_STATS=09=0912
+
+struct s2500_lb_counters {
+=09u32 tx_frames;
+=09u32 rx_frames;
+};
+
+struct s2500_lb_capture {
+=09struct net_device *ndev;
+=09struct completion done;
+=09const char *test_name;
+=09struct packet_type pt;
+=09u32 expected_frames;
+=09u32 received_frames;
+=09u32 expected_seq;
+=09u32 payload_len;
+=09/* Protect the callback */
+=09spinlock_t lock;
+=09bool failed;
+};
+
+static u32 phy_addr_list[S2500_NUM_REGS] =3D {
+=09S2500_REG_VS_ONIPVER,
+=09S2500_REG_VS_TWEAKS1,
+=09S2500_REG_VS_PLCAEXT,
+=09S2500_REG_VS_PMATUNE0,
+=09S2500_REG_VS_PMATUNE1,
+=09S2500_REG_VS_T1SWUPTUNE,
+=09S2500_REG_VS_HDD,
+=09S2500_REG_VS_DCQ_TOID,
+=09S2500_REG_VS_DCQ_SQI,
+=09S2500_REG_VS_DCQ_SQI_PLUS,
+=09S2500_REG_VS_HDD_TUNE1,
+=09S2500_REG_VS_HDD_TUNE2,
+=09S2500_REG_VS_HDD_TUNE3,
+=09S2500_REG_VS_WS_STATUS_0,
+=09S2500_REG_VS_WS_CTRL_0,
+=09S2500_REG_VS_WS_STATUS_1,
+=09S2500_REG_VS_WS_CTRL_1,
+=09S2500_REG_VS_MIIMIRQE,
+=09S2500_REG_VS_MIIMIRQS,
+=09S2500_REG_VS_DIOCFG0,
+=09S2500_REG_VS_CHIPID,
+=09S2500_REG_VS_TWEAKS2,
+=09S2500_REG_VS_MACID0,
+=09S2500_REG_VS_MACID1,
+=09S2500_REG_VS_NVM_HEALTH,
+=09S2500_REG_VS_PTP_SEC,
+=09S2500_REG_VS_PTPNSEC,
+=09S2500_REG_VS_PTP_SETSEC,
+=09S2500_REG_VS_SETNSEC,
+=09S2500_REG_VS_PTP_ADJ,
+=09S2500_REG_VS_CMPCTL,
+=09S2500_REG_VS_CMPSEC,
+=09S2500_REG_VS_CMPNSEC,
+=09S2500_REG_VS_CMPPER,
+=09S2500_REG_VS_CAPCTL,
+=09S2500_REG_VS_CAPSEC,
+=09S2500_REG_VS_CAPNSEC,
+=09S2500_REG_VS_BCNCNT,
+};
+
+enum s2500_stat_idx {
+=09S2500_MSTOCTECTSTX_IDX =3D 0,
+=09S2500_MSTFRAMESTXOK_IDX,
+=09S2500_MSTBCASTTXOK_IDX,
+=09S2500_MSTMCASTTXOK_IDX,
+=09S2500_MSTFRAMESTX64_IDX,
+=09S2500_MSTFRAMESTX65_IDX,
+=09S2500_MSTFRAMESTX128_IDX,
+=09S2500_MSTFRAMESTX256_IDX,
+=09S2500_MSTFRAMESTX512_IDX,
+=09S2500_MSTFRAMESTX1024_IDX,
+=09S2500_MSTTXUNDEFLOW_IDX,
+=09S2500_MSTSINGLECOL_IDX,
+=09S2500_MSTMULTICOL_IDX,
+=09S2500_MSTEXCESSCOL_IDX,
+=09S2500_MSTDEFERREDTX_IDX,
+=09S2500_MSTCRSERR_IDX,
+=09S2500_MSTOCTECTSRX_IDX,
+=09S2500_MSTFRAMESRXOK_IDX,
+=09S2500_MSTBCASTRXOK_IDX,
+=09S2500_MSTMCASTRXOK_IDX,
+=09S2500_MSTFRAMESRX64_IDX,
+=09S2500_MSTFRAMESRX65_IDX,
+=09S2500_MSTFRAMESRX128_IDX,
+=09S2500_MSTFRAMESRX256_IDX,
+=09S2500_MSTFRAMESRX512_IDX,
+=09S2500_MSTFRAMESRX1024_IDX,
+=09S2500_MSTRUNTSERR_IDX,
+=09S2500_MSTRXTOOLONG_IDX,
+=09S2500_MSTFCSERRS_IDX,
+=09S2500_MSTSYMBOLERRS_IDX,
+=09S2500_MSTALIGNERRS_IDX,
+=09S2500_MSTRXOVERFLOW_IDX,
+=09S2500_MSTRXDROPPED_IDX,
+};
+
+static const char s2500_mac_stat_strings[][ETH_GSTRING_LEN] =3D {
+=09"tx_bytes",
+=09"tx_frames",
+=09"tx_broadcast_frames",
+=09"tx_multicast_frames",
+=09"tx_underflow_errors",
+=09"tx_single_collisions",
+=09"tx_multiple_collisions",
+=09"tx_excessive_collisions",
+=09"tx_deferred_frames",
+=09"tx_carrier_sense_errors",
+=09"rx_bytes",
+=09"rx_frames",
+=09"rx_broadcast_frames",
+=09"rx_multicast_frames",
+=09"rx_runts",
+=09"rx_oversize_frames",
+=09"rx_crc_errors",
+=09"rx_symbol_errors",
+=09"rx_alignment_errors",
+=09"rx_busy_drops",
+=09"rx_mismatch_drops",
+};
+
+static const u8 s2500_mac_stat_map[S2500_NUM_MAC_STATS] =3D {
+=09S2500_MSTOCTECTSTX_IDX,
+=09S2500_MSTFRAMESTXOK_IDX,
+=09S2500_MSTBCASTTXOK_IDX,
+=09S2500_MSTMCASTTXOK_IDX,
+=09S2500_MSTTXUNDEFLOW_IDX,
+=09S2500_MSTSINGLECOL_IDX,
+=09S2500_MSTMULTICOL_IDX,
+=09S2500_MSTEXCESSCOL_IDX,
+=09S2500_MSTDEFERREDTX_IDX,
+=09S2500_MSTCRSERR_IDX,
+=09S2500_MSTOCTECTSRX_IDX,
+=09S2500_MSTFRAMESRXOK_IDX,
+=09S2500_MSTBCASTRXOK_IDX,
+=09S2500_MSTMCASTRXOK_IDX,
+=09S2500_MSTRUNTSERR_IDX,
+=09S2500_MSTRXTOOLONG_IDX,
+=09S2500_MSTFCSERRS_IDX,
+=09S2500_MSTSYMBOLERRS_IDX,
+=09S2500_MSTALIGNERRS_IDX,
+=09S2500_MSTRXOVERFLOW_IDX,
+=09S2500_MSTRXDROPPED_IDX,
+};
+
+static const u8 s2500_rmon_stat_map[S2500_NUM_RMON_STATS] =3D {
+=09S2500_MSTFRAMESTX64_IDX,
+=09S2500_MSTFRAMESTX65_IDX,
+=09S2500_MSTFRAMESTX128_IDX,
+=09S2500_MSTFRAMESTX256_IDX,
+=09S2500_MSTFRAMESTX512_IDX,
+=09S2500_MSTFRAMESTX1024_IDX,
+=09S2500_MSTFRAMESRX64_IDX,
+=09S2500_MSTFRAMESRX65_IDX,
+=09S2500_MSTFRAMESRX128_IDX,
+=09S2500_MSTFRAMESRX256_IDX,
+=09S2500_MSTFRAMESRX512_IDX,
+=09S2500_MSTFRAMESRX1024_IDX,
+};
+
+static const struct ethtool_rmon_hist_range s2500_rmon_hist_ranges[] =3D {
+=09{ 64, 64 },
+=09{ 65, 127 },
+=09{ 128, 255 },
+=09{ 256, 511 },
+=09{ 512, 1023 },
+=09{ 1024, 2000 },
+=09{ },
+};
+
+#define S2500_MAC_STATS_LEN ARRAY_SIZE(s2500_mac_stat_strings)
+static_assert(S2500_MAC_STATS_LEN =3D=3D S2500_NUM_MAC_STATS);
+static_assert(ARRAY_SIZE(s2500_mac_stat_map) =3D=3D S2500_NUM_MAC_STATS);
+static_assert(ARRAY_SIZE(s2500_rmon_stat_map) =3D=3D S2500_NUM_RMON_STATS)=
;
+
+#define S2500_TESTS_LEN 2
+
+static const char s2500_test_strings[][ETH_GSTRING_LEN] =3D {
+=09"MAC loopback",
+=09"PHY loopback",
+};
+
+#define STAT_REG_OFFSET(x) ((S2500_REG_MAC_ST##x) - \
+=09=09=09   S2500_REG_MAC_FIRST_STAT)
+
+static void s2500_update_stats(struct s2500_info *priv)
+{
+=09u64 *data =3D priv->stats_data;
+=09u32 *regs, *rptr;
+=09int ret;
+
+=09regs =3D kmalloc_array(S2500_NUM_STAT_REGS, sizeof(u32), GFP_KERNEL);
+=09if (!regs)
+=09=09return;
+
+=09ret =3D oa_tc6_read_registers(priv->tc6, S2500_REG_MAC_STOCTECTSTXL,
+=09=09=09=09    regs, S2500_NUM_STAT_REGS);
+=09if (ret)
+=09=09goto out;
+
+=09rptr =3D regs;
+
+=09/* TX bytes is a 64-bit register that spans over two 32-bit regs
+=09 * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+=09 */
+=09*(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+=09/* run until the next 64-bit register */
+=09for (rptr +=3D 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
+=09=09*(data++) +=3D *rptr;
+
+=09/* RX bytes is a 64-bit register that spans over two 32-bit regs
+=09 * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+=09 */
+=09*(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+=09for (rptr +=3D 2; (rptr - regs) < S2500_NUM_STAT_REGS; ++rptr)
+=09=09*(data++) +=3D *rptr;
+out:
+=09kfree(regs);
+}
+
+static void s2500_get_drvinfo(struct net_device *ndev,
+=09=09=09      struct ethtool_drvinfo *info)
+{
+=09strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+=09strscpy(info->bus_info, dev_name(&ndev->dev), sizeof(info->bus_info));
+}
+
+static int s2500_get_sset_count(struct net_device *ndev, int sset)
+{
+=09if (sset =3D=3D ETH_SS_STATS)
+=09=09return S2500_MAC_STATS_LEN;
+=09else if (sset =3D=3D ETH_SS_TEST)
+=09=09return S2500_TESTS_LEN;
+=09else
+=09=09return -EOPNOTSUPP;
+}
+
+static void s2500_get_strings(struct net_device *ndev, u32 stringset,
+=09=09=09      u8 *buf)
+{
+=09if (stringset =3D=3D ETH_SS_STATS)
+=09=09memcpy(buf, s2500_mac_stat_strings,
+=09=09       S2500_MAC_STATS_LEN * ETH_GSTRING_LEN);
+=09else if (stringset =3D=3D ETH_SS_TEST)
+=09=09memcpy(buf, s2500_test_strings,
+=09=09       S2500_TESTS_LEN * ETH_GSTRING_LEN);
+}
+
+static void s2500_get_ethtool_stats(struct net_device *ndev,
+=09=09=09=09    struct ethtool_stats *stats, u64 *data)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09int i;
+
+=09s2500_update_stats(priv);
+=09for (i =3D 0; i < S2500_NUM_MAC_STATS; i++)
+=09=09data[i] =3D priv->stats_data[s2500_mac_stat_map[i]];
+}
+
+static void s2500_get_rmon_stats(struct net_device *ndev,
+=09=09=09=09 struct ethtool_rmon_stats *rmon_stats,
+=09=09=09=09 const struct ethtool_rmon_hist_range **ranges)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09int i;
+
+=09s2500_update_stats(priv);
+
+=09memset(rmon_stats, 0, sizeof(*rmon_stats));
+=09rmon_stats->src =3D ETHTOOL_MAC_STATS_SRC_AGGREGATE;
+=09rmon_stats->undersize_pkts =3D priv->stats_data[S2500_MSTRUNTSERR_IDX];
+=09rmon_stats->oversize_pkts =3D priv->stats_data[S2500_MSTRXTOOLONG_IDX];
+=09rmon_stats->fragments =3D priv->stats_data[S2500_MSTFCSERRS_IDX];
+=09rmon_stats->jabbers =3D priv->stats_data[S2500_MSTALIGNERRS_IDX];
+
+=09for (i =3D 0; i < 6; i++)
+=09=09rmon_stats->hist_tx[i] =3D priv->stats_data[s2500_rmon_stat_map[i]];
+
+=09for (i =3D 0; i < 6; i++)
+=09=09rmon_stats->hist[i] =3D priv->stats_data[s2500_rmon_stat_map[i + 6]]=
;
+
+=09*ranges =3D s2500_rmon_hist_ranges;
+}
+
+static int s2500_get_ts_info(struct net_device *ndev,
+=09=09=09     struct kernel_ethtool_ts_info *ts_info)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09return oa_tc6_get_ts_info(priv->tc6, ts_info);
+}
+
+static int s2500_get_regs_len(struct net_device *dev)
+{
+=09return S2500_REGDUMP_LEN;
+}
+
+static void s2500_get_regs(struct net_device *ndev,
+=09=09=09   struct ethtool_regs *regs, void *p)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09u32 *pbuff =3D (u32 *)p;
+=09u32 val, reg;
+=09int ret =3D 0;
+=09int i;
+
+=09regs->version =3D 0;
+=09memset(p, 0, S2500_REGDUMP_LEN);
+
+=09if (!netif_running(ndev))
+=09=09return;
+
+=09for (i =3D 0; i < S2500_NUM_REGS; i++) {
+=09=09val =3D 0;
+=09=09reg =3D phy_addr_list[i];
+=09=09ret =3D oa_tc6_read_register(priv->tc6, reg, &val);
+=09=09if (ret)
+=09=09=09continue;
+=09=09*pbuff++ =3D cpu_to_be32(reg);
+=09=09*pbuff++ =3D cpu_to_be32(val);
+=09}
+}
+
+static void s2500_lb_fill_payload(u8 *payload, u32 seq, u32 payload_len)
+{
+=09u32 sig =3D S2500_LB_DATA_SIGNATURE;
+=09int seq_offset;
+=09u32 i;
+
+=09seq_offset =3D sizeof(sig);
+=09memcpy(payload, &sig, sizeof(sig));
+=09memcpy(&payload[seq_offset], &seq, sizeof(seq));
+
+=09for (i =3D S2500_LB_TEST_DATA_OFFSET; i < payload_len; i++)
+=09=09payload[i] =3D (u8)(S2500_LB_DATA_PATTERN ^ (seq + i));
+}
+
+static bool s2500_lb_payload_valid(const u8 *payload, u32 exp_seq,
+=09=09=09=09   u32 payload_len)
+{
+=09int seq_offset;
+=09u32 sig, seq;
+=09u32 j;
+
+=09if (payload_len < S2500_LB_TEST_DATA_OFFSET)
+=09=09return false;
+
+=09memcpy(&sig, payload, sizeof(sig));
+=09if (sig !=3D S2500_LB_DATA_SIGNATURE)
+=09=09return false;
+
+=09seq_offset =3D sizeof(sig);
+=09memcpy(&seq, &payload[seq_offset], sizeof(seq));
+=09if (seq !=3D exp_seq)
+=09=09return false;
+
+=09for (j =3D S2500_LB_TEST_DATA_OFFSET; j < payload_len; j++) {
+=09=09if (payload[j] !=3D (u8)(S2500_LB_DATA_PATTERN ^ (exp_seq + j)))
+=09=09=09return false;
+=09}
+
+=09return true;
+}
+
+static void s2500_log_lb_failure(struct net_device *ndev,
+=09=09=09=09 const char *test_name, const char *reason)
+{
+=09netdev_err(ndev, "%s loopback test failed: %s\n", test_name, reason);
+}
+
+static void s2500_lb_capture_init(struct s2500_lb_capture *cap,
+=09=09=09=09  struct net_device *ndev,
+=09=09=09=09  const char *test_name,
+=09=09=09=09  u32 expected_frames)
+{
+=09init_completion(&cap->done);
+=09spin_lock_init(&cap->lock);
+=09cap->ndev =3D ndev;
+=09cap->test_name =3D test_name;
+=09cap->expected_frames =3D expected_frames;
+=09cap->received_frames =3D 0;
+=09cap->expected_seq =3D 0;
+=09cap->payload_len =3D S2500_LB_PAYLOAD_LEN;
+=09cap->failed =3D false;
+=09memset(&cap->pt, 0, sizeof(cap->pt));
+=09cap->pt.type =3D cpu_to_be16(S2500_LB_ETH_P);
+=09cap->pt.dev =3D ndev;
+=09cap->pt.func =3D NULL;
+}
+
+static int s2500_lb_capture_rx(struct sk_buff *skb, struct net_device *dev=
,
+=09=09=09       struct packet_type *pt,
+=09=09=09       struct net_device *orig_dev)
+{
+=09struct s2500_lb_capture *cap =3D container_of(pt,
+=09=09=09=09=09=09    struct s2500_lb_capture,
+=09=09=09=09=09=09    pt);
+=09u8 payload[S2500_LB_PAYLOAD_LEN];
+=09unsigned long flags;
+=09bool failed =3D false;
+=09u32 frame_seq;
+
+=09(void)dev;
+
+=09if (orig_dev !=3D cap->ndev)
+=09=09goto out_free;
+
+=09if (skb->len !=3D cap->payload_len) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "RX frame length mismatch");
+=09=09failed =3D true;
+=09} else if (skb_copy_bits(skb, 0, payload, cap->payload_len) !=3D 0) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "unable to copy RX payload");
+=09=09failed =3D true;
+=09}
+
+=09spin_lock_irqsave(&cap->lock, flags);
+=09frame_seq =3D cap->expected_seq;
+=09if (failed || cap->failed ||
+=09    cap->received_frames >=3D cap->expected_frames) {
+=09=09if (cap->received_frames >=3D cap->expected_frames)
+=09=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09=09     "extra frame received");
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09if (!s2500_lb_payload_valid(payload, frame_seq,
+=09=09=09=09    cap->payload_len)) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "payload mismatch");
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09if (frame_seq !=3D cap->received_frames) {
+=09=09netdev_err(cap->ndev,
+=09=09=09   "out-of-order RX frame, expected %u got %u\n",
+=09=09=09   cap->received_frames, frame_seq);
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09cap->received_frames++;
+=09cap->expected_seq++;
+=09if (cap->received_frames =3D=3D cap->expected_frames)
+=09=09complete_all(&cap->done);
+=09spin_unlock_irqrestore(&cap->lock, flags);
+
+out_free:
+=09kfree_skb(skb);
+=09return 0;
+}
+
+static int s2500_lb_enable(struct s2500_info *priv, u32 reg, u32 *saved)
+{
+=09int ret;
+=09u32 val;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, reg, &val);
+=09if (ret)
+=09=09return ret;
+
+=09*saved =3D val;
+=09val |=3D BMCR_LOOPBACK;
+
+=09return oa_tc6_write_register(priv->tc6, reg, val);
+}
+
+static int s2500_lb_restore(struct s2500_info *priv, u32 reg, u32 saved)
+{
+=09return oa_tc6_write_register(priv->tc6, reg, saved);
+}
+
+static int s2500_read_lb_counters(struct s2500_info *priv,
+=09=09=09=09  struct s2500_lb_counters *cnt)
+{
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_MAC_STFRAMESTXOK,
+=09=09=09=09   &cnt->tx_frames);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_MAC_STFRAMESRXOK,
+=09=09=09=09   &cnt->rx_frames);
+=09if (ret)
+=09=09return ret;
+
+=09return 0;
+}
+
+static int s2500_send_lb_frames(struct net_device *ndev, int frame_count,
+=09=09=09=09u16 eth_proto)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09const int payload_len =3D 64;
+=09unsigned char *frame;
+=09struct sk_buff *skb;
+=09int frame_len;
+=09int sent =3D 0;
+=09int ret, i;
+
+=09frame_len =3D ETH_HLEN + payload_len;
+=09for (i =3D 0; i < frame_count; i++) {
+=09=09skb =3D alloc_skb(frame_len + NET_IP_ALIGN, GFP_KERNEL);
+=09=09if (skb)
+=09=09=09skb_reserve(skb, NET_IP_ALIGN);
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09frame =3D skb_put(skb, frame_len);
+=09=09memset(frame, 0xff, ETH_ALEN);
+=09=09memcpy(frame + ETH_ALEN, ndev->dev_addr, ETH_ALEN);
+=09=09frame[12] =3D (u8)((eth_proto >> 8) & 0xff);
+=09=09frame[13] =3D (u8)(eth_proto & 0xff);
+=09=09s2500_lb_fill_payload(frame + ETH_HLEN, i, payload_len);
+
+=09=09skb->dev =3D ndev;
+=09=09skb->protocol =3D htons(eth_proto);
+=09=09skb->priority =3D 0;
+
+=09=09ret =3D oa_tc6_start_xmit(priv->tc6, skb);
+=09=09if (ret =3D=3D NETDEV_TX_OK) {
+=09=09=09sent++;
+=09=09} else {
+=09=09=09netdev_warn(ndev, "TX frame %d failed\n", i);
+=09=09=09kfree_skb(skb);
+=09=09=09break;
+=09=09}
+
+=09=09udelay(S2500_LB_FRAME_GAP_US);
+=09}
+=09return sent;
+}
+
+static void s2500_eval_lb_result(struct net_device *ndev,
+=09=09=09=09 struct ethtool_test *eth_test, u64 *data,
+=09=09=09=09 unsigned int idx,
+=09=09=09=09 const char *test_name,
+=09=09=09=09 const struct s2500_lb_counters *before,
+=09=09=09=09 const struct s2500_lb_counters *after,
+=09=09=09=09 const struct s2500_lb_capture *capture,
+=09=09=09=09 int req_frames,
+=09=09=09=09 int sent_frames)
+{
+=09u64 tx_delta, rx_delta;
+=09bool failed =3D false;
+
+=09tx_delta =3D (after->tx_frames >=3D before->tx_frames) ?
+=09=09  (u64)(after->tx_frames - before->tx_frames) : 0;
+=09rx_delta =3D (after->rx_frames >=3D before->rx_frames) ?
+=09=09  (u64)(after->rx_frames - before->rx_frames) : 0;
+
+=09if (sent_frames < req_frames) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: transmit failure, sent %d of %d frames\n",
+=09=09=09   test_name, sent_frames, req_frames);
+=09=09failed =3D true;
+=09}
+=09if (tx_delta < (u64)req_frames) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: TX counter did not increment, delta=3D%llu expected=3D%d\=
n",
+=09=09=09   test_name, tx_delta, req_frames);
+=09=09failed =3D true;
+=09}
+=09if (rx_delta =3D=3D 0) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: no frames received back\n",
+=09=09=09   test_name);
+=09=09failed =3D true;
+=09} else if (rx_delta * 100 < (u64)req_frames * S2500_LB_PASS_PERCENT) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: received too few frames, rx delta=3D%llu expected=3D%d\n"=
,
+=09=09=09   test_name, rx_delta, req_frames);
+=09=09failed =3D true;
+=09}
+
+=09if (capture->failed ||
+=09    capture->received_frames !=3D capture->expected_frames) {
+=09=09if (capture->received_frames =3D=3D 0)
+=09=09=09netdev_err(ndev,
+=09=09=09=09   "%s: no received frames captured\n",
+=09=09=09=09   test_name);
+=09=09else if (capture->received_frames !=3D capture->expected_frames)
+=09=09=09netdev_err(ndev,
+=09=09=09=09   "%s: received frame count mismatch, got %u expected %u\n",
+=09=09=09=09   test_name, capture->received_frames, capture->expected_fram=
es);
+=09=09failed =3D true;
+=09}
+
+=09data[idx] =3D failed ? 1 : 0;
+=09if (failed)
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+}
+
+static int s2500_run_lb_test(struct net_device *ndev,
+=09=09=09     struct s2500_info *priv,
+=09=09=09     u32 loop_reg, bool use_phy_loopback,
+=09=09=09     const char *test_name,
+=09=09=09     struct ethtool_test *eth_test,
+=09=09=09     u64 *data, unsigned int idx)
+{
+=09struct s2500_lb_counters before;
+=09struct s2500_lb_capture capture;
+=09struct s2500_lb_counters after;
+=09u32 saved_val =3D 0;
+=09long timeout;
+=09int sent;
+=09int ret;
+
+=09s2500_lb_capture_init(&capture, ndev, test_name, S2500_LB_TEST_FRAMES);
+=09capture.pt.func =3D s2500_lb_capture_rx;
+
+=09if (use_phy_loopback)
+=09=09ret =3D phy_loopback(ndev->phydev, true, 0);
+=09else
+=09=09ret =3D s2500_lb_enable(priv, loop_reg, &saved_val);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09return 0;
+=09}
+
+=09/* First call clears the counters */
+=09ret =3D s2500_read_lb_counters(priv, &before);
+
+=09/* Counter values before starting the test (likely to be 0) */
+=09ret =3D s2500_read_lb_counters(priv, &before);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09goto restore;
+=09}
+
+=09dev_add_pack(&capture.pt);
+=09sent =3D s2500_send_lb_frames(ndev, S2500_LB_TEST_FRAMES,
+=09=09=09=09    S2500_LB_ETH_P);
+=09timeout =3D wait_for_completion_timeout(&capture.done,
+=09=09=09=09=09      msecs_to_jiffies(S2500_LB_CAPTURE_TIMEOUT_MS));
+=09dev_remove_pack(&capture.pt);
+=09if (!timeout)
+=09=09capture.failed =3D true;
+
+=09ret =3D s2500_read_lb_counters(priv, &after);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09goto restore;
+=09}
+
+=09s2500_eval_lb_result(ndev, eth_test, data, idx, test_name,
+=09=09=09     &before, &after, &capture,
+=09=09=09     S2500_LB_TEST_FRAMES, sent);
+
+restore:
+=09if (use_phy_loopback)
+=09=09ret =3D phy_loopback(ndev->phydev, false, 0);
+=09else
+=09=09ret =3D s2500_lb_restore(priv, loop_reg, saved_val);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09}
+
+=09return 0;
+}
+
+static void s2500_get_ts_stats(struct net_device *ndev,
+=09=09=09       struct ethtool_ts_stats *ts_stats)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09oa_tc6_get_ts_stats(priv->tc6, ts_stats);
+}
+
+static void s2500_self_test(struct net_device *ndev,
+=09=09=09    struct ethtool_test *eth_test, u64 *data)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (!priv)
+=09=09return;
+
+=09if (!mutex_trylock(&priv->selftest_lock)) {
+=09=09netdev_warn(ndev, "selftest already running\n");
+=09=09return;
+=09}
+
+=09eth_test->flags &=3D ~ETH_TEST_FL_FAILED;
+=09data[0] =3D 0;
+=09data[1] =3D 0;
+
+=09netif_stop_queue(ndev);
+=09if (eth_test->len < S2500_TESTS_LEN)
+=09=09goto unlock;
+
+=09/* MAC loopback is controlled directly through the PCS loopback bit;
+=09 * PHY loopback is routed through phylib so the PHY driver handles the
+=09 * standard BMCR loopback state transition.
+=09 */
+=09s2500_run_lb_test(ndev, priv, S2500_REG_PCS_CTRL,
+=09=09=09  false, "MAC", eth_test, data, 0);
+=09s2500_run_lb_test(ndev, priv, S2500_REG_PHY_CTRL,
+=09=09=09  true, "PHY", eth_test, data, 1);
+
+unlock:
+=09netif_start_queue(ndev);
+=09mutex_unlock(&priv->selftest_lock);
+}
+
+const struct ethtool_ops s2500_ethtool_ops =3D {
+=09.get_drvinfo        =3D s2500_get_drvinfo,
+=09.get_link           =3D ethtool_op_get_link,
+=09.get_link_ksettings =3D phy_ethtool_get_link_ksettings,
+=09.set_link_ksettings =3D phy_ethtool_set_link_ksettings,
+=09.get_ts_stats       =3D s2500_get_ts_stats,
+=09.get_sset_count     =3D s2500_get_sset_count,
+=09.get_strings        =3D s2500_get_strings,
+=09.get_ethtool_stats  =3D s2500_get_ethtool_stats,
+=09.get_rmon_stats     =3D s2500_get_rmon_stats,
+=09.get_ts_info        =3D s2500_get_ts_info,
+=09.get_regs_len       =3D s2500_get_regs_len,
+=09.get_regs           =3D s2500_get_regs,
+=09.self_test          =3D s2500_self_test,
+};
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h b/drivers/net=
/ethernet/onsemi/s2500/s2500_hw_def.h
new file mode 100644
index 000000000000..b283a92b3932
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h
@@ -0,0 +1,273 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#ifndef S2500_HW_DEF_H
+#define S2500_HW_DEF_H
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/phylink.h>
+#include <linux/spi/spi.h>
+#include <linux/oa_tc6.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/ktime.h>
+#include <linux/errno.h>
+
+#define DRV_NAME=09=09=09"s2500"
+#define DRV_VERSION=09=09=09"1.0.3.1"
+
+#define S2500_N_MCAST_FILTERS=09=093
+
+#define S2500_MODEL_ID=09=09=090xA7A8
+
+/* S2500 registers */
+
+/* Definitions for MMS defined in Table 6 Open Alliance TC6 standard
+ * that not present in oa_tc6.h
+ */
+#define S2500_OA_TC6_MACPHY_MMS0=090
+#define S2500_OA_TC6_MAC_MMS1=09=091
+#define S2500_OA_TC6_VS1_MMS12=09=0912
+
+#define S2500_MMS_MII=09=09=09(S2500_OA_TC6_MACPHY_MMS0 << 16)
+#define S2500_MMS_MAC=09=09=09(S2500_OA_TC6_MAC_MMS1 << 16)
+#define S2500_MMS_PCS=09=09=09(OA_TC6_PHY_C45_PCS_MMS2 << 16)
+#define S2500_MMS_PMDPMA=09=09(OA_TC6_PHY_C45_PMA_PMD_MMS3 << 16)
+#define S2500_MMS_VS1=09=09=09(S2500_OA_TC6_VS1_MMS12 << 16)
+#define S2500_MMS_VS2=09=09=09(OA_TC6_PHY_C45_VS_PLCA_MMS4 << 16)
+
+/* SPI OID and model register */
+#define S2500_REG_SPI_PHYID=09=090x1
+
+#define S2500_SPI_PHYID_OUI_SHIFT=0910
+#define S2500_SPI_PHYID_OUI_MASK=09GENMASK(31, S2500_SPI_PHYID_OUI_SHIFT)
+#define S2500_SPI_PHYID_MODEL_SHIFT=094
+#define S2500_SPI_PHYID_MODEL_MASK=09GENMASK(9, S2500_SPI_PHYID_MODEL_SHIF=
T)
+#define S2500_SPI_PHYID_REV_SHIFT=090
+#define S2500_SPI_PHYID_REV_MASK=09GENMASK(3, S2500_SPI_PHYID_REV_SHIFT)
+
+/* SPI configuration register #0 */
+#define S2500_REG_SPI_CFG0=09=09(S2500_MMS_MII + 0x4)
+
+#define S2500_SPI_CFG0_SYNC_BIT=09=09BIT(15)
+#define S2500_SPI_CFG0_TXFCSVE_BIT=09BIT(14)
+#define S2500_SPI_CFG0_CSARFE_BIT=09BIT(13)
+#define S2500_SPI_CFG0_TXCTHRESH_SHIFT=0910
+#define S2500_SPI_CFG0_TXCTHRESH_MASK=09GENMASK(11, S2500_SPI_CFG0_TXCTHRE=
SH_SHIFT)
+#define S2500_SPI_CFG0_TXCTE_BIT=09BIT(9)
+#define S2500_SPI_CFG0_RXCTE_BIT=09BIT(8)
+#define S2500_SPI_CFG0_FTSE_BIT=09=09BIT(7)
+#define S2500_SPI_CFG0_FTSS_64_BIT=09BIT(6)
+#define S2500_SPI_CFG0_PROTE_BIT=09BIT(5)
+#define S2500_SPI_CFG0_SEQE_BIT=09=09BIT(4)
+#define S2500_SPI_CFG0_CPS_SHIFT=090
+#define S2500_SPI_CFG0_CPS_MASK=09=09GENMASK(2, S2500_SPI_CFG0_CPS_SHIFT)
+
+#define S2500_TXCTHRESH_1=09=090x0
+#define S2500_TXCTHRESH_4=09=090x1
+#define S2500_TXCTHRESH_8=09=090x2
+
+#define S2500_CPS_8=09=09=090x3
+#define S2500_CPS_16=09=09=090x4
+#define S2500_CPS_32=09=09=090x5
+#define S2500_CPS_64=09=09=090x6
+
+/* SPI status register #0 */
+#define S2500_REG_SPI_ST0=09=09(S2500_MMS_MII + 8)
+
+#define S2500_SPI_ST0_CDPE_BIT=09=09BIT(12)
+#define S2500_SPI_ST0_TXFCSE_BIT=09BIT(11)
+#define S2500_SPI_ST0_TTSCAC_BIT=09BIT(10)
+#define S2500_SPI_ST0_TTSCAB_BIT=09BIT(9)
+#define S2500_SPI_ST0_TTSCAA_BIT=09BIT(8)
+#define S2500_SPI_ST0_PHYINT_BIT=09BIT(7)
+#define S2500_SPI_ST0_RESETC_BIT=09BIT(6)
+#define S2500_SPI_ST0_HDRE_BIT=09=09BIT(5)
+#define S2500_SPI_ST0_LOFE_BIT=09=09BIT(4)
+#define S2500_SPI_ST0_RXBOE_BIT=09=09BIT(3)
+#define S2500_SPI_ST0_TXBUE_BIT=09=09BIT(2)
+#define S2500_SPI_ST0_TXBOE_BIT=09=09BIT(1)
+#define S2500_SPI_ST0_TXPE_BIT=09=09BIT(0)
+
+/* SPI IRQ enable register #0 (use the S2500_SPI_ST0_*_BIT constants) */
+#define S2500_REG_SPI_IRQM0=09=09(S2500_MMS_MII + 0xc)
+
+/* SPI buffer status register */
+#define S2500_REG_SPI_BUFST=09=090xb
+
+#define S2500_REG_MAC_CTRL=09=09(S2500_MMS_MAC + 0)
+
+#define S2500_MAC_CTRL_MCSF_BIT=09=09BIT(18)
+#define S2500_MAC_CTRL_ADRF_BIT=09=09BIT(16)
+#define S2500_MAC_CTRL_FCSA_BIT=09=09BIT(8)
+#define S2500_MAC_CTRL_TXEN_BIT=09=09BIT(1)
+#define S2500_MAC_CTRL_RXEN_BIT=09=09BIT(0)
+
+#define S2500_REG_PHY_CTRL=09=09(S2500_MMS_MII + 0xFF00)
+
+#define S2500_REG_PCS_CTRL=09=09(S2500_MMS_PCS + 0x8F3)
+
+/* MAC address filter registers */
+#define S2500_REG_MAC_ADDRFILTL(n)=09(S2500_MMS_MAC + (16 + 2 * (n)))
+#define S2500_REG_MAC_ADDRFILTH(n)=09(S2500_MMS_MAC + (17 + 2 * (n)))
+#define S2500_REG_MAC_ADDRMASKL(n)=09(S2500_MMS_MAC + (32 + 2 * (n)))
+#define S2500_REG_MAC_ADDRMASKH(n)=09(S2500_MMS_MAC + (33 + 2 * (n)))
+
+#define S2500_MAC_ADDRFILT_EN_BIT=09BIT(31)
+
+/* MAC statistic registers */
+#define S2500_REG_MAC_STOCTECTSTXL=09(S2500_MMS_MAC + 48)
+#define S2500_REG_MAC_STOCTECTSTXH=09(S2500_MMS_MAC + 49)
+#define S2500_REG_MAC_STFRAMESTXOK=09(S2500_MMS_MAC + 50)
+#define S2500_REG_MAC_STBCASTTXOK=09(S2500_MMS_MAC + 51)
+#define S2500_REG_MAC_STMCASTTXOK=09(S2500_MMS_MAC + 52)
+#define S2500_REG_MAC_STFRAMESTX64=09(S2500_MMS_MAC + 53)
+#define S2500_REG_MAC_STFRAMESTX65=09(S2500_MMS_MAC + 54)
+#define S2500_REG_MAC_STFRAMESTX128=09(S2500_MMS_MAC + 55)
+#define S2500_REG_MAC_STFRAMESTX256=09(S2500_MMS_MAC + 56)
+#define S2500_REG_MAC_STFRAMESTX512=09(S2500_MMS_MAC + 57)
+#define S2500_REG_MAC_STFRAMESTX1024=09(S2500_MMS_MAC + 58)
+#define S2500_REG_MAC_STTXUNDEFLOW=09(S2500_MMS_MAC + 59)
+#define S2500_REG_MAC_STSINGLECOL=09(S2500_MMS_MAC + 60)
+#define S2500_REG_MAC_STMULTICOL=09(S2500_MMS_MAC + 61)
+#define S2500_REG_MAC_STEXCESSCOL=09(S2500_MMS_MAC + 62)
+#define S2500_REG_MAC_STDEFERREDTX=09(S2500_MMS_MAC + 63)
+#define S2500_REG_MAC_STCRSERR=09=09(S2500_MMS_MAC + 64)
+#define S2500_REG_MAC_STOCTECTSRXL=09(S2500_MMS_MAC + 65)
+#define S2500_REG_MAC_STOCTECTSRXH=09(S2500_MMS_MAC + 66)
+#define S2500_REG_MAC_STFRAMESRXOK=09(S2500_MMS_MAC + 67)
+#define S2500_REG_MAC_STBCASTRXOK=09(S2500_MMS_MAC + 68)
+#define S2500_REG_MAC_STMCASTRXOK=09(S2500_MMS_MAC + 69)
+#define S2500_REG_MAC_STFRAMESRX64=09(S2500_MMS_MAC + 70)
+#define S2500_REG_MAC_STFRAMESRX65=09(S2500_MMS_MAC + 71)
+#define S2500_REG_MAC_STFRAMESRX128=09(S2500_MMS_MAC + 72)
+#define S2500_REG_MAC_STFRAMESRX256=09(S2500_MMS_MAC + 73)
+#define S2500_REG_MAC_STFRAMESRX512=09(S2500_MMS_MAC + 74)
+#define S2500_REG_MAC_STFRAMESRX1024=09(S2500_MMS_MAC + 75)
+#define S2500_REG_MAC_STRUNTSERR=09(S2500_MMS_MAC + 76)
+#define S2500_REG_MAC_STRXTOOLONG=09(S2500_MMS_MAC + 77)
+#define S2500_REG_MAC_STFCSERRS=09=09(S2500_MMS_MAC + 78)
+#define S2500_REG_MAC_STSYMBOLERRS=09(S2500_MMS_MAC + 79)
+#define S2500_REG_MAC_STALIGNERRS=09(S2500_MMS_MAC + 80)
+#define S2500_REG_MAC_STRXOVERFLOW=09(S2500_MMS_MAC + 81)
+#define S2500_REG_MAC_STRXDROPPED=09(S2500_MMS_MAC + 82)
+
+/* First/last statistic register for sequential access */
+#define S2500_REG_MAC_FIRST_STAT=09S2500_REG_MAC_STOCTECTSTXL
+#define S2500_REG_MAC_LAST_STAT=09=09S2500_REG_MAC_STRXDROPPED
+
+#define S2500_NUM_STAT_REGS \
+=09(S2500_REG_MAC_LAST_STAT - S2500_REG_MAC_FIRST_STAT + 1)
+#define S2500_NUM_STAT_VARS=09=09(S2500_NUM_STAT_REGS - 2)
+
+/* Vendor specific MMS4 registers */
+#define S2500_REG_VS_ONIPVER=09=09(S2500_MMS_VS2 + 0x8000)
+#define S2500_REG_VS_TWEAKS1=09=09(S2500_MMS_VS2 + 0x8001)
+#define S2500_REG_VS_PLCAEXT=09=09(S2500_MMS_VS2 + 0x8002)
+#define S2500_REG_VS_PMATUNE0=09=09(S2500_MMS_VS2 + 0x8003)
+#define S2500_REG_VS_PMATUNE1=09=09(S2500_MMS_VS2 + 0x8004)
+#define S2500_REG_VS_T1SWUPTUNE=09=09(S2500_MMS_VS2 + 0x8007)
+#define S2500_REG_VS_HDD=09=09(S2500_MMS_VS2 + 0xCC01)
+#define S2500_REG_VS_DCQ_TOID=09=09(S2500_MMS_VS2 + 0xCC02)
+#define S2500_REG_VS_DCQ_SQI=09=09(S2500_MMS_VS2 + 0xCC03)
+#define S2500_REG_VS_DCQ_SQI_PLUS=09(S2500_MMS_VS2 + 0xCC04)
+#define S2500_REG_VS_HDD_TUNE1=09=09(S2500_MMS_VS2 + 0xCD00)
+#define S2500_REG_VS_HDD_TUNE2=09=09(S2500_MMS_VS2 + 0xCD01)
+#define S2500_REG_VS_HDD_TUNE3=09=09(S2500_MMS_VS2 + 0xCD02)
+#define S2500_REG_VS_WS_STATUS_0=09(S2500_MMS_VS2 + 0xD000)
+#define S2500_REG_VS_WS_CTRL_0=09=09(S2500_MMS_VS2 + 0xD001)
+#define S2500_REG_VS_WS_STATUS_1=09(S2500_MMS_VS2 + 0xD100)
+#define S2500_REG_VS_WS_CTRL_1=09=09(S2500_MMS_VS2 + 0xD101)
+
+/* Vendor specific MMS12 registers */
+#define S2500_REG_VS_MIIMIRQE=09=09(S2500_MMS_VS1 + 0x10)
+
+/* MIIM IRQ status register */
+#define S2500_REG_VS_MIIMIRQS=09=09(S2500_MMS_VS1 + 0x11)
+#define MIIM_IRQ_STATUS_RSTS_SHIFT=0915
+#define MIIM_IRQ_STATUS_RSTS=09=09BIT(MIIM_IRQ_STATUS_RSTS_SHIFT)
+
+#define S2500_REG_VS_DIOCFG0=09=09(S2500_MMS_VS1 + 0x12)
+
+/* Chip identification register */
+#define S2500_REG_VS_CHIPID=09=09(S2500_MMS_VS1 + 0x1000)
+#define S2500_CHIPID_MODEL_SHIFT=0916
+#define S2500_CHIPID_MODEL_MASK=09=09GENMASK(31, S2500_CHIPID_MODEL_SHIFT)
+#define S2500_CHIPID_REVISION_SHIFT=090
+#define S2500_CHIPID_REVISION_MASK=09GENMASK(15, S2500_CHIPID_REVISION_SHI=
FT)
+
+#define S2500_REG_VS_TWEAKS2=09=09(S2500_MMS_VS1 + 0x1001)
+
+/* Permanent MAC address register */
+#define S2500_REG_VS_MACID0=09=09(S2500_MMS_VS1 + 0x1002)
+#define S2500_REG_VS_MACID1=09=09(S2500_MMS_VS1 + 0x1003)
+#define S2500_REG_VS_NVM_HEALTH=09=09(S2500_MMS_VS1 + 0x1005)
+
+/* PTP registers */
+#define S2500_REG_VS_PTP_SEC=09=09(S2500_MMS_VS1 + 0x1010)
+#define S2500_REG_VS_PTP_SETSEC=09=09(S2500_MMS_VS1 + 0x1012)
+#define S2500_REG_VS_PTP_ADJ=09=09(S2500_MMS_VS1 + 0x1014)
+#define S2500_REG_VS_PTPNSEC=09=09(S2500_MMS_VS1 + 0x1011)
+#define S2500_REG_VS_SETNSEC=09=09(S2500_MMS_VS1 + 0x1013)
+#define S2500_REG_VS_CMPCTL=09=09(S2500_MMS_VS1 + 0x1015)
+#define S2500_REG_VS_CMPSEC=09=09(S2500_MMS_VS1 + 0x1016)
+#define S2500_REG_VS_CMPNSEC=09=09(S2500_MMS_VS1 + 0x1017)
+#define S2500_REG_VS_CMPPER=09=09(S2500_MMS_VS1 + 0x1018)
+#define S2500_REG_VS_CAPCTL=09=09(S2500_MMS_VS1 + 0x1019)
+#define S2500_REG_VS_CAPSEC=09=09(S2500_MMS_VS1 + 0x101A)
+#define S2500_REG_VS_CAPNSEC=09=09(S2500_MMS_VS1 + 0x101B)
+#define S2500_REG_VS_BCNCNT=09=09(S2500_MMS_VS1 + 0x101C)
+
+/* prototypes / forward declarations */
+extern const struct ethtool_ops s2500_ethtool_ops;
+
+struct s2500_info;
+
+struct s2500_info {
+=09struct device *dev;
+=09struct net_device *ndev;
+
+=09/* model information */
+=09u32 model;
+=09u32 version;
+
+=09/* To have atomic set_rx_mode operation */
+=09spinlock_t lock;
+
+=09/* To avoid simultaneous selftest request */
+=09struct mutex selftest_lock;
+
+=09/* To have atomic operation when time is adjusted */
+=09struct mutex ptp_adj_lock;
+=09struct task_struct *thread;
+
+=09/* global state variables */
+=09bool event_pending;
+=09unsigned int ndev_flags;
+=09bool rx_flags_upd;
+
+=09signed long poll_jiff;
+
+=09struct spi_device *spi;
+
+=09/* statistic counters variables */
+=09u64 stats_data[S2500_NUM_STAT_VARS];
+
+=09/* PTP related variables */
+=09struct ptp_clock_info ptp_clock_info;
+=09void *tc6;
+};
+
+int s2500_ptp_register(struct s2500_info *priv);
+
+#endif /* S2500_HW_DEF_H */
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_main.c b/drivers/net/e=
thernet/onsemi/s2500/s2500_main.c
new file mode 100644
index 000000000000..e524e7817374
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
@@ -0,0 +1,654 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "s2500_hw_def.h"
+
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+
+/* S2500 functions & definitions */
+
+#define S2500_STATUS0_MASK=09(S2500_SPI_ST0_CDPE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXFCSE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAC_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAB_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAA_BIT | \
+=09=09=09=09S2500_SPI_ST0_RESETC_BIT | \
+=09=09=09=09S2500_SPI_ST0_HDRE_BIT | \
+=09=09=09=09S2500_SPI_ST0_LOFE_BIT | \
+=09=09=09=09S2500_SPI_ST0_RXBOE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXBUE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXBOE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXPE_BIT)
+
+/* Converts a MACPHY ID to a device name */
+static const char *s2500_id_to_name(u32 id)
+{
+=09if (id =3D=3D S2500_MODEL_ID)
+=09=09return "S2500";
+=09return "unknown";
+}
+
+/* Initializes the net device MAC address by reading the UID stored
+ * into the device internal non-volatile memory.
+ */
+static int s2500_read_mac_from_nvmem(struct s2500_info *priv)
+{
+=09u8 addr[ETH_ALEN];
+=09u32 mac1 =3D 0;
+=09u32 mac0 =3D 0;
+=09int i, j;
+=09u32 val;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_PHYID, &val);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D (val & S2500_SPI_PHYID_OUI_MASK) >> S2500_SPI_PHYID_OUI_SHIFT;
+
+=09/* Convert the OID in host byte order */
+=09for (i =3D 2; i >=3D 0; --i) {
+=09=09addr[i] =3D 0;
+=09=09for (j =3D 0; j < 8; ++j) {
+=09=09=09addr[i] |=3D (val & 1) << (7 - j);
+=09=09=09val >>=3D 1;
+=09=09}
+=09}
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_MACID1, &mac1);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_MACID0, &mac0);
+=09if (ret)
+=09=09return ret;
+
+=09/* Pre-production parts may have 0 */
+=09if (mac0 =3D=3D 0 && mac1 =3D=3D 0)
+=09=09return -ENXIO;
+
+=09addr[3] =3D mac1 & 0xff;
+=09addr[4] =3D (mac0 >> 8) & 0xff;
+=09addr[5] =3D mac0 & 0xff;
+
+=09__dev_addr_set(priv->ndev, addr, ETH_ALEN);
+=09priv->ndev->addr_assign_type =3D NET_ADDR_PERM;
+
+=09return ret;
+}
+
+/* Writes MAC address to macphy registers */
+static int s2500_set_mac_filter(struct net_device *ndev, const u8 *mac)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09u32 val;
+=09int ret;
+
+=09/* Set unicast address filter */
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRMASKL(0),
+=09=09=09=09    0xffffffff);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRMASKH(0),
+=09=09=09=09    0xffff);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D ((u32)mac[2] << 24) |
+=09       ((u32)mac[3] << 16) |
+=09       ((u32)mac[4] << 8) |
+=09       ((u32)mac[5]);
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRFILTL(0), va=
l);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D S2500_MAC_ADDRFILT_EN_BIT | ((u32)mac[0] << 8) | ((u32)mac[1]);
+
+=09return oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRFILTH(0), val=
);
+}
+
+static int s2500_mac_ctrl_modify_bits(struct s2500_info *priv,
+=09=09=09=09      u32 in_bits, bool clr)
+{
+=09u32 reg =3D S2500_REG_MAC_CTRL;
+=09u32 rval =3D 0;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, reg, &rval);
+=09if (!ret) {
+=09=09u32 wval =3D 0;
+
+=09=09if (clr)
+=09=09=09wval =3D rval & ~in_bits;
+=09=09else
+=09=09=09wval =3D rval | in_bits;
+=09=09if (rval !=3D wval)
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6, reg, wval);
+=09}
+=09return ret;
+}
+
+static int s2500_init(struct s2500_info *priv)
+{
+=09u32 val;
+=09int ret;
+
+=09/* Configure the SPI protocol + 64 bit timestamp */
+=09val =3D S2500_SPI_CFG0_SYNC_BIT | S2500_SPI_CFG0_RXCTE_BIT |
+=09      (S2500_TXCTHRESH_8 << S2500_SPI_CFG0_TXCTHRESH_SHIFT) |
+=09      (S2500_CPS_64 << S2500_SPI_CFG0_CPS_SHIFT) |
+=09      S2500_SPI_CFG0_FTSS_64_BIT;
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_SPI_CFG0, val);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D (u32)~(S2500_SPI_ST0_RESETC_BIT |
+=09=09     S2500_SPI_ST0_HDRE_BIT | S2500_SPI_ST0_LOFE_BIT |
+=09=09     S2500_SPI_ST0_RXBOE_BIT | S2500_SPI_ST0_TXBOE_BIT |
+=09=09     S2500_SPI_ST0_TXPE_BIT);
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_SPI_IRQM0, val);
+=09if (ret)
+=09=09return ret;
+
+=09/* Read the initial value of TX credits */
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_BUFST, &val);
+=09if (ret)
+=09=09return ret;
+
+=09/* Program the source MAC address into the device */
+=09ret =3D s2500_set_mac_filter(priv->ndev, priv->ndev->dev_addr);
+
+=09val =3D S2500_MAC_CTRL_ADRF_BIT | S2500_MAC_CTRL_FCSA_BIT;
+
+=09return s2500_mac_ctrl_modify_bits(priv, val, false);
+}
+
+static void s2500_shutdown(struct s2500_info *priv)
+{
+=09u32 val =3D S2500_MAC_CTRL_TXEN_BIT | S2500_MAC_CTRL_RXEN_BIT;
+=09struct net_device *ndev =3D priv->ndev;
+
+=09netif_stop_queue(ndev);
+=09phy_stop(ndev->phydev);
+
+=09s2500_mac_ctrl_modify_bits(priv, val, true);
+}
+
+static int s2500_set_promiscuous_mode(struct s2500_info *priv,
+=09=09=09=09      unsigned int rx_flags)
+{
+=09u32 val =3D S2500_MAC_CTRL_ADRF_BIT;
+=09bool clr =3D false;
+
+=09if (rx_flags & IFF_PROMISC)
+=09=09clr =3D true;
+=09return s2500_mac_ctrl_modify_bits(priv, val, clr);
+}
+
+static int s2500_set_multicast_mode(struct s2500_info *priv,
+=09=09=09=09    unsigned int rx_flags)
+{
+=09int i, ret =3D 0;
+=09u32 val;
+
+=09if ((rx_flags & IFF_ALLMULTI) ||
+=09    (netdev_mc_count(priv->ndev) > S2500_N_MCAST_FILTERS)) {
+=09=09/* Disable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_modify_bits(priv,
+=09=09=09=09=09=09 S2500_MAC_CTRL_MCSF_BIT,
+=09=09=09=09=09=09 true);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Accept all multicasts */
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRMASKL(1), 0);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRMASKH(1), 0x100);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRFILTL(1), 0);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09val =3D S2500_MAC_ADDRFILT_EN_BIT | 0x00000100;
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(1), val);
+=09} else if (netdev_mc_count(priv->ndev) =3D=3D 0) {
+=09=09/* Enable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_modify_bits(priv,
+=09=09=09=09=09=09 S2500_MAC_CTRL_MCSF_BIT,
+=09=09=09=09=09=09 false);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Disable filters */
+=09=09for (i =3D 1; i <=3D S2500_N_MCAST_FILTERS; i++) {
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    0);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09}
+=09} else {
+=09=09struct netdev_hw_addr *ha;
+=09=09u32 addrh, addrl;
+
+=09=09/* Disable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_modify_bits(priv,
+=09=09=09=09=09=09 S2500_MAC_CTRL_MCSF_BIT,
+=09=09=09=09=09=09 true);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Disable filters */
+=09=09for (i =3D 1; i <=3D S2500_N_MCAST_FILTERS; i++) {
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    0);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09}
+
+=09=09i =3D 1;
+=09=09netdev_for_each_mc_addr(ha, priv->ndev) {
+=09=09=09if (i > S2500_N_MCAST_FILTERS)
+=09=09=09=09break;
+
+=09=09=09addrh =3D ((ha->addr[0] << 8) | ha->addr[1] |
+=09=09=09=09 S2500_MAC_ADDRFILT_EN_BIT);
+=09=09=09addrl =3D ((ha->addr[2] << 24) | (ha->addr[3] << 16) |
+=09=09=09=09 (ha->addr[4] << 8) | (ha->addr[5]));
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    addrh);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTL(i),
+=09=09=09=09=09=09    addrl);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRMASKL(i),
+=09=09=09=09=09=09    0xffffffff);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRMASKH(i),
+=09=09=09=09=09=09    0xffff);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09=09i++;
+=09=09}
+=09}
+=09return ret;
+}
+
+/* Deferred function for applying RX mode flags in non-atomic context */
+static int s2500_rx_mode_update(struct s2500_info *priv)
+{
+=09unsigned int rx_flags;
+=09unsigned long flags;
+=09int ret;
+
+=09spin_lock_irqsave(&priv->lock, flags);
+
+=09rx_flags =3D priv->ndev_flags;
+=09priv->rx_flags_upd =3D false;
+
+=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09ret =3D s2500_set_promiscuous_mode(priv, rx_flags);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D s2500_set_multicast_mode(priv, rx_flags);
+out:
+=09return ret;
+}
+
+static void s2500_set_rx_mode(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&priv->lock, flags);
+
+=09priv->rx_flags_upd =3D true;
+=09priv->ndev_flags =3D ndev->flags;
+
+=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09if (priv->thread)
+=09=09wake_up_process(priv->thread);
+}
+
+static int s2500_set_mac_address(struct net_device *ndev, void *p)
+{
+=09struct sockaddr *addr =3D p;
+
+=09if (!is_valid_ether_addr(addr->sa_data))
+=09=09return -EADDRNOTAVAIL;
+
+=09eth_hw_addr_set(ndev, addr->sa_data);
+=09return s2500_set_mac_filter(ndev, addr->sa_data);
+}
+
+static netdev_tx_t s2500_start_xmit(struct sk_buff *skb,
+=09=09=09=09    struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static int s2500_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09return oa_tc6_ioctl(priv->tc6, rq, cmd);
+}
+
+static void s2500_process_events(struct s2500_info *priv)
+{
+=09u32 val;
+=09int ret;
+
+=09if (!priv->event_pending)
+=09=09return;
+
+=09priv->event_pending =3D false;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
+=09if (ret) {
+=09=09dev_err(&priv->spi->dev, "Error reading ST0 register");
+=09=09return;
+=09}
+}
+
+static int s2500_thread_fun(void *data)
+{
+=09struct s2500_info *priv =3D data;
+=09bool update_rx_mode =3D false;
+=09unsigned long flags;
+=09signed long tout;
+=09int ret =3D 0;
+
+=09tout =3D priv->poll_jiff;
+
+=09do {
+=09=09if (update_rx_mode) {
+=09=09=09ret =3D s2500_rx_mode_update(priv);
+=09=09=09if (unlikely(ret)) {
+=09=09=09=09dev_err(&priv->spi->dev, "Failed to set new RX mode");
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+
+=09=09if (tout =3D=3D 0) {
+=09=09=09tout =3D priv->poll_jiff;
+
+=09=09=09/* Force checking the status register */
+=09=09=09priv->event_pending =3D true;
+=09=09}
+
+=09=09s2500_process_events(priv);
+
+=09=09spin_lock_irqsave(&priv->lock, flags);
+=09=09__set_current_state(TASK_INTERRUPTIBLE);
+
+=09=09update_rx_mode =3D priv->rx_flags_upd;
+=09=09ret =3D update_rx_mode;
+
+=09=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09=09if (!ret)
+=09=09=09tout =3D schedule_timeout(tout);
+=09=09else
+=09=09=09set_current_state(TASK_RUNNING);
+=09} while (!kthread_should_stop());
+=09return 0;
+}
+
+static int s2500_open(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09int ret =3D 0;
+=09u32 val;
+
+=09dev_dbg(&ndev->dev, "%s", "s2500_open");
+=09phy_start(priv->ndev->phydev);
+
+=09priv->thread =3D kthread_run(s2500_thread_fun, priv, DRV_NAME "/%s:%d",
+=09=09=09=09   dev_name(&priv->spi->dev),
+=09=09=09=09   spi_get_chipselect(priv->spi, 0));
+
+=09if (IS_ERR(priv->thread)) {
+=09=09ret =3D PTR_ERR(priv->thread);
+=09} else {
+=09=09val =3D S2500_MAC_CTRL_TXEN_BIT | S2500_MAC_CTRL_RXEN_BIT;
+=09=09ret =3D s2500_mac_ctrl_modify_bits(priv, val, false);
+
+=09=09netif_start_queue(priv->ndev);
+=09}
+=09return ret;
+}
+
+static int s2500_stop(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09dev_dbg(&ndev->dev, "%s", "s2500_stop");
+
+=09s2500_shutdown(priv);
+
+=09kthread_stop(priv->thread);
+=09priv->thread =3D NULL;
+
+=09return 0;
+}
+
+static int s2500_hwtstamp_get(struct net_device *ndev,
+=09=09=09      struct kernel_hwtstamp_config *k_cfg)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09oa_tc6_hwtstamp_get(priv->tc6, k_cfg);
+=09return 0;
+}
+
+static int s2500_hwtstamp_set(struct net_device *ndev,
+=09=09=09      struct kernel_hwtstamp_config *cfg,
+=09=09=09      struct netlink_ext_ack *extack)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09return oa_tc6_hwtstamp_set(priv->tc6, cfg);
+}
+
+static const struct net_device_ops s2500_netdev_ops =3D {
+=09.ndo_open            =3D s2500_open,
+=09.ndo_stop            =3D s2500_stop,
+=09.ndo_start_xmit      =3D s2500_start_xmit,
+=09.ndo_set_mac_address =3D s2500_set_mac_address,
+=09.ndo_set_rx_mode     =3D s2500_set_rx_mode,
+=09.ndo_eth_ioctl       =3D s2500_ioctl,
+=09.ndo_hwtstamp_get    =3D s2500_hwtstamp_get,
+=09.ndo_hwtstamp_set    =3D s2500_hwtstamp_set,
+};
+
+static int s2500_update_model(struct s2500_info *priv)
+{
+=09u32 val =3D 0;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_CHIPID, &val);
+=09if (ret)
+=09=09return ret;
+
+=09priv->version =3D val & S2500_CHIPID_REVISION_MASK;
+=09priv->version >>=3D S2500_CHIPID_REVISION_SHIFT;
+
+=09priv->model =3D val & S2500_CHIPID_MODEL_MASK;
+=09priv->model >>=3D S2500_CHIPID_MODEL_SHIFT;
+=09dev_info(&priv->spi->dev, "Macphy model %s, version %u\n",
+=09=09 s2500_id_to_name(priv->model), priv->version);
+=09return ret;
+}
+
+static int s2500_probe(struct spi_device *spi)
+{
+=09struct device *dev =3D &spi->dev;
+=09struct net_device *ndev;
+=09struct s2500_info *priv;
+=09u32 val;
+=09int ret;
+
+=09if (spi->irq < 0)
+=09=09return -ENODEV;
+
+=09ndev =3D devm_alloc_etherdev(dev, sizeof(struct s2500_info));
+=09if (!ndev)
+=09=09return -ENOMEM;
+
+=09priv =3D netdev_priv(ndev);
+=09priv->ndev =3D ndev;
+=09priv->spi =3D spi;
+=09priv->dev =3D dev;
+
+=09SET_NETDEV_DEV(ndev, dev);
+
+=09spin_lock_init(&priv->lock);
+=09mutex_init(&priv->selftest_lock);
+=09mutex_init(&priv->ptp_adj_lock);
+=09ndev->irq =3D spi->irq;
+
+=09spi->dev.platform_data =3D priv;
+=09spi_set_drvdata(spi, priv);
+
+=09ndev->netdev_ops =3D &s2500_netdev_ops;
+=09ndev->ethtool_ops =3D &s2500_ethtool_ops;
+=09ndev->if_port =3D IF_PORT_10BASET;
+=09ndev->priv_flags |=3D IFF_UNICAST_FLT;
+=09ndev->hw_features =3D NETIF_F_RXALL | NETIF_F_RXFCS;
+
+=09priv->poll_jiff =3D HZ * 5; /* Poll interval */
+
+=09priv->tc6 =3D oa_tc6_init(spi, ndev);
+=09if (!priv->tc6) {
+=09=09dev_err(&spi->dev, "OA TC6 init failed");
+=09=09return -ENODEV;
+=09}
+=09oa_tc6_set_vend1_mms(priv->tc6, S2500_OA_TC6_VS1_MMS12);
+=09s2500_update_model(priv);
+
+=09/* Clear RSTS, if set */
+=09oa_tc6_read_register(priv->tc6, S2500_REG_VS_MIIMIRQS, &val);
+=09val &=3D MIIM_IRQ_STATUS_RSTS;
+=09if (val !=3D 0)
+=09=09oa_tc6_write_register(priv->tc6, S2500_REG_VS_MIIMIRQS,
+=09=09=09=09      MIIM_IRQ_STATUS_RSTS);
+
+=09/* Acknowledge all IRQ status bits */
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
+=09if (!ret) {
+=09=09u32 mask =3D S2500_STATUS0_MASK;
+
+=09=09val &=3D mask;
+=09=09oa_tc6_write_register(priv->tc6, S2500_REG_SPI_ST0, val);
+=09}
+
+=09ret =3D device_get_ethdev_address(priv->dev, ndev);
+=09if (ret)
+=09=09ret =3D s2500_read_mac_from_nvmem(priv);
+
+=09if (ret) {
+=09=09eth_hw_addr_random(ndev);
+=09=09dev_warn(&spi->dev, "Using random MAC address %pM", ndev->dev_addr);
+=09}
+
+=09ret =3D s2500_init(priv);
+=09if (unlikely(ret)) {
+=09=09dev_err(&spi->dev, "failed to s2500_init the device");
+=09=09goto err_reg_read;
+=09}
+
+=09/* Configure PTP if the model supports it */
+=09ret =3D s2500_ptp_register(priv);
+=09if (unlikely(ret))
+=09=09goto err_reg_read;
+
+=09ret =3D register_netdev(ndev);
+=09if (ret) {
+=09=09dev_err(&spi->dev, "failed to register the S2500 device\n");
+=09=09ret =3D -ENODEV;
+
+=09=09goto err_reg_read;
+=09}
+=09return 0;
+
+err_reg_read:
+=09dev_err(&spi->dev, "could not initialize macphy");
+=09return ret;
+}
+
+static void s2500_remove(struct spi_device *spi)
+{
+=09struct s2500_info *priv =3D spi->dev.platform_data;
+
+=09dev_dbg(&priv->ndev->dev, "%s", "s2500_remove");
+
+=09oa_tc6_ptp_unregister(priv->tc6);
+=09unregister_netdev(priv->ndev);
+=09oa_tc6_exit(priv->tc6);
+}
+
+static const struct of_device_id s2500_of_match[] =3D {
+=09{ .compatible =3D "onnn,s2500" },
+=09{}
+};
+
+static const struct spi_device_id s2500_ids[] =3D {
+=09{ "s2500" },
+=09{}
+};
+
+MODULE_DEVICE_TABLE(spi, s2500_ids);
+
+static struct spi_driver s2500_driver =3D {
+=09.driver =3D {
+=09=09.name=09=3D DRV_NAME,
+=09=09.of_match_table =3D s2500_of_match,
+=09},
+=09.probe=09=09=3D s2500_probe,
+=09.remove=09=09=3D s2500_remove,
+=09.id_table=09=3D s2500_ids,
+};
+
+module_spi_driver(s2500_driver);
+
+MODULE_AUTHOR("Piergiorgio Beruto <Pier.Beruto@onsemi.com>");
+MODULE_DESCRIPTION("onsemi MACPHY ethernet driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/et=
hernet/onsemi/s2500/s2500_ptp.c
new file mode 100644
index 000000000000..58f532d78047
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "s2500_hw_def.h"
+
+static int s2500_ptp_get_time64(struct ptp_clock_info *ptp,
+=09=09=09=09struct timespec64 *ts,
+=09=09=09=09struct ptp_system_timestamp *ptp_sts)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 data[2];
+=09int ret;
+
+=09ptp_read_system_prets(ptp_sts);
+=09ret =3D oa_tc6_read_registers(priv->tc6, S2500_REG_VS_PTP_SEC,
+=09=09=09=09    &data[0], 2);
+=09ptp_read_system_postts(ptp_sts);
+
+=09if (!ret) {
+=09=09ts->tv_sec =3D data[0];
+=09=09ts->tv_nsec =3D data[1];
+=09}
+
+=09return ret;
+}
+
+static int s2500_ptp_set_time64(struct ptp_clock_info *ptp,
+=09=09=09=09const struct timespec64 *ts)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 data[2];
+
+=09if (ts->tv_sec >=3D (1ULL << 32))
+=09=09return -ERANGE;
+
+=09data[0] =3D (u32)ts->tv_sec;
+=09data[1] =3D ts->tv_nsec | BIT(31); /* bit 31 =3D execute set command */
+
+=09return oa_tc6_write_registers(priv->tc6, S2500_REG_VS_PTP_SETSEC,
+=09=09=09=09      &data[0], 2);
+}
+
+static int s2500_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 sign_bit =3D 0;
+=09long adj;
+=09u32 val;
+=09u64 ppm;
+
+=09if (scaled_ppm < 0) {
+=09=09/* split sign / mod */
+=09=09sign_bit =3D 1U << 31;
+=09=09scaled_ppm =3D ~scaled_ppm + 1;
+=09}
+
+=09/**
+=09 * Convert unsigned scaled_ppm to atto-seconds per clock cycles.
+=09 * The scaled_ppm format is Qx.16 --> 1 lsb =3D 1/65536 ppm.
+=09 * The clock period of the S2500 is 8ns (125 MHz), so 1 lsb of
+=09 * adj register LSB is 1 atto-sec / 8ns =3D 0.000125 ppm.
+=09 * Represented in Qx.16 format, this is 0.000125 * 2^16 =3D 8(.192)
+=09 * To convert scaled_ppm into a register value we need to divide
+=09 * it by the LSB value, hence adj =3D (scaled_ppm * 1000) / 8192 to
+=09 * minimize the precision loss due to the integer arithmetic.
+=09 * That further reduces to (scaled_ppm * 125) / 1024.
+=09 */
+=09ppm =3D (u64)scaled_ppm * 125;
+=09do_div(ppm, 1024);
+=09adj =3D (long)ppm;
+
+=09/* check overflow */
+=09if (adj >=3D (1L << 28))
+=09=09return -ERANGE;
+
+=09val =3D (u32)adj | sign_bit;
+=09return oa_tc6_write_register(priv->tc6, S2500_REG_VS_PTP_ADJ, val);
+}
+
+static int s2500_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09struct ptp_system_timestamp sts;
+=09struct timespec64 target;
+=09unsigned int period_ms;
+=09struct timespec64 now;
+=09int max_iters =3D 3;
+=09s64 scaled_ppm;
+=09s64 remaining;
+=09s64 target_ns;
+=09int ret =3D 0;
+=09s64 now_ns;
+=09s64 num;
+=09s64 den;
+
+=09if (!ptp)
+=09=09return -EINVAL;
+
+=09/* Nothing to do */
+=09if (delta =3D=3D 0)
+=09=09return 0;
+
+=09if (mutex_lock_interruptible(&priv->ptp_adj_lock))
+=09=09return -EINTR;
+
+=09/* Try to slew the clock using adjfine for better accuracy. For large
+=09 * adjustments fall back to setting time directly.
+=09 */
+=09remaining =3D delta;
+
+=09while (remaining !=3D 0 && max_iters--) {
+=09=09s64 abs_delta =3D remaining > 0 ? remaining : -remaining;
+
+=09=09/* If the adjustment is very large, more than 1 second,
+=09=09 * use settime to avoid very long slewing periods or
+=09=09 * excessive frequency offsets.
+=09=09 */
+=09=09if (abs_delta > 1000000000LL) {
+=09=09=09memset(&sts, 0, sizeof(sts));
+=09=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09=09if (!ret) {
+=09=09=09=09struct timespec64 delta_ts;
+
+=09=09=09=09if (remaining >=3D 0) {
+=09=09=09=09=09delta_ts =3D ns_to_timespec64(remaining);
+=09=09=09=09=09target =3D timespec64_add(now, delta_ts);
+=09=09=09=09} else {
+=09=09=09=09=09delta_ts =3D ns_to_timespec64(-remaining);
+=09=09=09=09=09target =3D timespec64_sub(now, delta_ts);
+=09=09=09=09}
+=09=09=09}
+
+=09=09=09if (target.tv_sec < 0 || target.tv_sec >=3D (1ULL << 32))
+=09=09=09=09ret =3D -ERANGE;
+=09=09=09else
+=09=09=09=09ret =3D ptp->settime64(ptp, &target);
+
+=09=09=09remaining =3D 0;
+=09=09=09break;
+=09=09}
+
+=09=09/* Choose a slewing period depending on magnitude */
+=09=09if (abs_delta <=3D 1000000LL) /* <=3D 1ms */
+=09=09=09period_ms =3D 1000; /* 1 s */
+=09=09else if (abs_delta <=3D 100000000LL) /* <=3D 100ms */
+=09=09=09period_ms =3D 10000; /* 10 s */
+=09=09else
+=09=09=09period_ms =3D 60000; /* 60 s */
+
+=09=09/* compute current time and fixed target for this iteration */
+=09=09memset(&sts, 0, sizeof(sts));
+=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09if (remaining >=3D 0)
+=09=09=09target =3D timespec64_add(now, ns_to_timespec64(remaining));
+=09=09else
+=09=09=09target =3D timespec64_sub(now, ns_to_timespec64(-remaining));
+
+=09=09/* Compute scaled_ppm (Qx.16). scaled_ppm =3D ppm * 2^16
+=09=09 * ppm =3D (delta_seconds / period_seconds) * 1e6
+=09=09 * =3D> scaled_ppm =3D delta_ns * 65536 / (period_ms * 1000)
+=09=09 */
+=09=09num =3D remaining * 65536LL;
+=09=09den =3D (s64)period_ms * 1000LL;
+
+=09=09/* Integer division rounds toward zero; keep sign in numerator */
+=09=09scaled_ppm =3D div_s64(num, den);
+
+=09=09/* Apply frequency adjustment */
+=09=09ret =3D ptp->adjfine(ptp, (long)scaled_ppm);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09/* Sleep for the slew period (interruptible). If interrupted, clear
+=09=09 * the adjfine and return with -EINTR.
+=09=09 */
+=09=09if (msleep_interruptible(period_ms)) {
+=09=09=09/* Clear adjfine */
+=09=09=09ptp->adjfine(ptp, 0);
+=09=09=09ret =3D -EINTR;
+=09=09=09break;
+=09=09}
+
+=09=09/* Clear adjfine and measure remaining offset */
+=09=09ptp->adjfine(ptp, 0);
+
+=09=09memset(&sts, 0, sizeof(sts));
+=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09/* remaining =3D target - now (in ns) */
+=09=09target_ns =3D timespec64_to_ns(&target);
+=09=09now_ns =3D timespec64_to_ns(&now);
+=09=09remaining =3D target_ns - now_ns;
+
+=09=09/* If remaining is small (< 1us), finish */
+=09=09if (remaining > -1000 && remaining < 1000)
+=09=09=09remaining =3D 0;
+=09}
+
+=09mutex_unlock(&priv->ptp_adj_lock);
+=09return ret;
+}
+
+int s2500_ptp_register(struct s2500_info *priv)
+{
+=09struct ptp_clock_info *info =3D &priv->ptp_clock_info;
+=09int ret;
+
+=09info->max_adj =3D 100000000;
+=09info->owner =3D THIS_MODULE;
+=09info->adjfine =3D s2500_ptp_adjfine;
+=09info->gettimex64 =3D s2500_ptp_get_time64;
+=09info->settime64 =3D s2500_ptp_set_time64;
+=09info->adjtime =3D s2500_ptp_adjtime;
+
+=09ret =3D oa_tc6_ptp_register(priv->tc6, info);
+=09if (ret)
+=09=09dev_err(&priv->spi->dev, "PTP registration failed");
+=09return ret;
+}
+
--=20
2.43.0



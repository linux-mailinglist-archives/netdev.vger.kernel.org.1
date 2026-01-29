Return-Path: <netdev+bounces-254738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB4qDcs6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA509AF102
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B03E3004DC8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485813803C4;
	Thu, 29 Jan 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWJNjgkj"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B634027E;
	Thu, 29 Jan 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683657; cv=fail; b=tMuPHkn0kP8+Fg5CGHRQcb+kObH5sNkgB1udvZdSFXj4JHooSnrb0mWdEGp4ILb18G6kwfTqbucEn2CsWfB+pkFfTUzedCbBLrvTBsNplXRdJ/7WLTf0xEdZJY8uOVfACYIWBw4y0pPDWcjCXW7u7FIFivyeLALniPOZd3FOUD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683657; c=relaxed/simple;
	bh=ggll8WRr8KBlL+iMBS8tam+v28ykxTSPkSLZKNGtwXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ce5oVNlmqiSbU6XJuRmjdqCLKBU6Cu4UVbpgygjj1/B0stYac3TioFzibZaFCnOrryMnntHdQb03x9gdDOb9z+nFGzfV12F2A87yk5psaueId9jA5BBCf86AB37fd7VCXTnm7kjWQv79GP55xTsBRYrfAwJzId+CmJd5t71BHT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eWJNjgkj; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivVuUfA63sN5+MNggZRdruWuaBLyJhsv5OzvZ9yta5OpFoPj0p2dluD8tFB07Ie7JbF0gyldK3WOR7xIOvzYvGTY+fcK0rC6de6nO0VzCoxjV79Zc2ahcsCrN+JvYMPT4yrYbeHgurE7dFsGFD/5TQxIdO34oxaYUx6E2TTtIF8qmWaS2CCO88hdF2RWbut4i44wo6VPdgC/r2xB3Pux0KFEb5NMjwS9Y50ROX0C1q9Ars4g1V0LlWMCznahldLRX5M9uKfKfza6udqDCI66TAZvAD5UfP/YypCZVbNMumN9nsL31U9vVdduSq8vdtA04xVTN5+MBmsj9/A9pGXv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggll8WRr8KBlL+iMBS8tam+v28ykxTSPkSLZKNGtwXk=;
 b=i6Anyalnm0he+KDQEetaI0henZ9sKuy/KoZ4IUwDwNPIHfTHIwa0UiGbCBLYbjaoYLrCBB6Y28sB2nVlOOFoj1ZCxc2sA0LWQ14UVeH15jV4vVJDUkBCwO6zQ0Wc+cp/V6ieg4dHhQZCbfxzC9lGKUJm8borOXp3JLZUNXbzn2V89O1kPimEKXQXOS/vJqrYL7TclUVq3daIU9s0eD4trYR7HfdM3RaFeb3y0z0avEyGCiCfgplQRydsWn4U+7OrfBveG0w00b7aATNfzdnKqFJ6ihXY/IS9W1EardLNxTJWsizRMBdxQYLIqnfXfkiQl5EkGCgetPdF6o6eKQaYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggll8WRr8KBlL+iMBS8tam+v28ykxTSPkSLZKNGtwXk=;
 b=eWJNjgkj4drEgwpqyHKInUS60ul5wUVTcxKGnaOhxu0FFXj1Azh4qudp5q/SuMkFzCSyn3RGh/d4Omh/yg3C7pKCu4bgI47YZngsX5oPscHtlyeKZ4YS2hh1VBGuHH+Lu7eB5B7UaU+63bTkYASR6zqkkcJCL+PPOYks8XYK1CqrnfzN1ncOidm7vGtQfldalWyFNGcRbSfgvel6mNcXZGXSPkBIunQgtanX2WMPHqLd4iSNR1qVSDbig6Li3N0nu7t/plZWLNV4k65E2k/dNqenVzWqxlkEGqDbxbDoZwPgIy35/155eNWkLSJ5IxEjmB8PYTH7+w+Co6fw1vr71g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 10:47:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:47:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>, xiaolei.wang
	<xiaolei.wang@windriver.com>, "quic_abchauha@quicinc.com"
	<quic_abchauha@quicinc.com>, "quic_sarohasa@quicinc.com"
	<quic_sarohasa@quicinc.com>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVo4MQAgAADeqCAAA+KAIAABfqw
Date: Thu, 29 Jan 2026 10:47:32 +0000
Message-ID:
 <PAXPR04MB85103D866242FCC7D84E21E7889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <7df10272-a06b-4509-ab8a-519d43944424@bootlin.com>
 <PAXPR04MB85100B7C2C6738CEA80C3C7D889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <7c37c518-fb6d-4f78-8e83-663e2518e5fd@bootlin.com>
In-Reply-To: <7c37c518-fb6d-4f78-8e83-663e2518e5fd@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8851:EE_
x-ms-office365-filtering-correlation-id: a5674eed-89f3-4dab-d755-08de5f23ce83
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZNsE7PDh3NipkfqIJ2H4hPpaAfb/f1o0xlivlC1xv8kvkmnY6JZksS1yMxxV?=
 =?us-ascii?Q?VctkuHAq+xvsopbx822u+zxMiBjQniPkxEBeds87BE2m/rISciOw0oD6hbyS?=
 =?us-ascii?Q?2dtA1LgpEaE5TAyo36KGYTwOB5HrBETK0TRmuLYG7tFzpO9T1S8Xi5tV6+vH?=
 =?us-ascii?Q?Imp4lA6fJKa7mbT/Ch36f7TG96ZGB04OJHS4N3L+pMTSu9wdYshMvy8cA41U?=
 =?us-ascii?Q?tZScboYD/lNnpnQbsSTWH+FdfKsMSv0GmYM2HN6955AVA5ZRklmmyrSfHPKG?=
 =?us-ascii?Q?CDSZRfZd4fw8YF5TUuanvMfnL9XAj+Sgue/n3uxWy28BTigklQ5/WfWPmajZ?=
 =?us-ascii?Q?rCmnkQdjvlQv/E6f/01TeCcsg3D0od5Bq0tUCZSbJrPD7faYGXwXDoQTKVfO?=
 =?us-ascii?Q?zY0kh6SOttV/kwKg2PEipFQIcDDuAecEnOV3Fx0FWKv+xGQHlqiFLDdHIZS/?=
 =?us-ascii?Q?14wUJ+kwCQasP9MKz+Fw52/A9N0zOJ1KfDsYvOdY6+QJ+cMZmIW+4WGSnsml?=
 =?us-ascii?Q?6q15aRs58soOHuXWA1EWscWnTlZibxRMoiuQB2hhZqrgxY2gTM2jNBHxllX2?=
 =?us-ascii?Q?Rut6m5nFSPZul02fyn8qj16wG9sVEQM34hOfmhQUKhnvFaiH2npddkcZHZ+r?=
 =?us-ascii?Q?wKjAFnkRdqIiH9eCsuVyPFfaOqoj23GWltTeOsDaKNv0vkXaaEoLMPnmLKKa?=
 =?us-ascii?Q?hfzjKs/7UxP+GtcBzAnBtT4ZX8igiG0ZtyZ9Pss88mo97lg1f9Y3COGOYbuf?=
 =?us-ascii?Q?KPpCsQ7gk82xFOQC2TsHtgheXOBMQbz/PrXgdNsGUGve7cp7CCvfJ3luvc2A?=
 =?us-ascii?Q?VSZ0lL7Zn7MIekispQdKLKJACctb8ix38pYIZrju15/qXqrMJfe4MEvJSE1J?=
 =?us-ascii?Q?aL3JBBf0moCQR2If5j8sKJwpbkitCki5F7o05PftboK0dJXt6WSJv0lIaIE2?=
 =?us-ascii?Q?alzYsA6AKaK1ByUNZIgeKvluCO2HPKS9jN0opXXXiuPBvzSBQcMj4Xfhboth?=
 =?us-ascii?Q?YVYM9CmxtRQreufBV11vbozxWuTUavrsK0hK8s5NMX2jjH8I4chE4Vb2yRvU?=
 =?us-ascii?Q?tEIsZk42G8nx5HsyNapZPziNfqrkia9YII+T7M8Hkd0fmQF9398OY+uc3GIA?=
 =?us-ascii?Q?DXrBOGsLx0Fi1ILMoAL5+XAlMYlT0cTSAvBb6kS5dHDcmBGG1lt3iefEt4gU?=
 =?us-ascii?Q?UtA4w7JpXX4len03tpP395PNR8XIAOCR8/LXDnKUbx89nHY5tXo4CF/7yFfd?=
 =?us-ascii?Q?b5kof/c4urPBvZGITF3MyX19mJQ74Ts6qoQGYvUN+cXFS5W1uH7gPjShK0NK?=
 =?us-ascii?Q?EEEyqjhQaN6qCzZfM3uiNfdWOuVQF/TkYn0dtGWITThRAR+RroO+1EJs33Lu?=
 =?us-ascii?Q?J/VNU3phDT3Uu/cBXjkij/NfjIy0qc+sSrAyE/RWgbLVLFXIm1oetQiqey1w?=
 =?us-ascii?Q?bbTClJflOpmJmTpvdZgXJpLXRvelR9a2TADSMS4Y68wr5qlqWbmqeGtm+St7?=
 =?us-ascii?Q?NJ/agIpxrrKyN9AE0f0LjiYB+ETHExuyHFOyl6vE8IeIv+wUQli7dO7zmdPs?=
 =?us-ascii?Q?gPAKA28MkQt/ETd9jao=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ik9nNH2jdO55BwWQET4SfVlqWOnjTQAxTLgPwWEI4LWWHmCgtJOiQdEtZsrx?=
 =?us-ascii?Q?U5S28Qw4kz3K76LZBCXVgQjgjAesy9IxAKYucLjgMZDhLjzPtO0YmvLKH+qG?=
 =?us-ascii?Q?U3mdsyC4pgpMVat/C+sZ4sU48C35oNhW4YR50r/v7n8DjzpCsgGzvuaxPIes?=
 =?us-ascii?Q?TT2pmhtcX93PE6ARoyxmKSiA+0mEQtyZs8wE3h/Nw9KL1U1nEYaD+doBBjeV?=
 =?us-ascii?Q?bABr9Y6UIh8A2qnyKAS2FdKuXevPO1Ikb95/sqD8S061Vo5/hzKgCKfJuXUs?=
 =?us-ascii?Q?OY7GsQpnlwfPJ8EOYfW4HZVkOl5P4ttNy3wnk5CzlFMMgMyMVsAKFkY/cG91?=
 =?us-ascii?Q?Spjz4kV9QFAJ2rjGrGwxRatHv/l2BpqTZ4I2Y2ojhNTiAtHQDO/LPr1plk81?=
 =?us-ascii?Q?3V8N4RkILHXJsKN91CWwUYy63sTr6sGQ65orlRNdo5SSt9oXXLTbxeA6jUgi?=
 =?us-ascii?Q?cpEt6F20qqu2hR1KcuGAmzXcwfWKUDQVT3fL4Uo9eeCtPat7Vtt+MscP0crg?=
 =?us-ascii?Q?b9ZU3by/suZXIQF0ENAtMk9PjIn4spWQWxQizoxpXlhdwphIezDcs2abZ4kZ?=
 =?us-ascii?Q?65BbeFSTqTblFWf1sMD0bnUSH6bZumpE20aVkMQ3ReYwc0SDuyRRxMdbO1Dt?=
 =?us-ascii?Q?J9m+ZHOThoF3JMn8U46WK2t9JIBBUaNVzWn/i++e1n7eJUAdJPiwUpTEbJqI?=
 =?us-ascii?Q?7/vhSc/JrJo2Pb6akhNFbhonA4lsnJG+WQtpWx6n2P+BjJTvWe6uhGFBfdDV?=
 =?us-ascii?Q?Mt+2X56vF5/faFWE6/iiEPhxPR3YoRUgBPyI6VY0k55QPX9vaUI/YF05m3CK?=
 =?us-ascii?Q?nct0CkygcCZbJWpThm/0lAFbqvHX63dEv2gJmQK/NE7R8qRH+6EtsrVnlnYB?=
 =?us-ascii?Q?oD6Y4fT3mmsrm7yGZSSv8yhVe+5XscGBPyAypXaTG/aQPNxEZrIVPrl4oXkx?=
 =?us-ascii?Q?kq2O+axsbyG0QKMyvs9odiTh4Gwlmfnu1p8KTNwBPLY1sz5bYULoOc85oWCg?=
 =?us-ascii?Q?2+rOJGIXNzmo4ryVDE3xaivgf1YPs/oLAkGVCthA3vYuD6MfoRAxjA7znpA1?=
 =?us-ascii?Q?0NX26SZh/5IWqaKOuuDVUvZuAlTtF31gMCCJXcPVjpOvk4gJJeJlptEqca7x?=
 =?us-ascii?Q?R6Thx0KmNeHfv7f3JRMPttLz6RgHL70dWg+n9eKpsRgNLNwQYE3zHiOxu4PZ?=
 =?us-ascii?Q?0oafzgkkO8rZHiMKRnTqB9zXJ3msj7wFoQKpoigY4SYnB10KSdl9YGY99zOt?=
 =?us-ascii?Q?Q9YLzy88OW182L/yh5KyZ7znXrz3dO1YGYmgqeesPD4we02BKkCse1+Az29g?=
 =?us-ascii?Q?rE7+1+gUwE5S4LO+hajnmzAlnh8RNH0KWYkfJtaNvrO0Run0qJ0bcyInO3qR?=
 =?us-ascii?Q?ak45TLHOjNxhlUkO2/yWtcwu4PJuYqwPJlLGXE67MdYZvolF3kNMrm3XRvyw?=
 =?us-ascii?Q?KPqOJ6yjAu7zyI71FLQTa+DRCKbUWFKNfAT6h0KkLFI5vXTHB727XvhAFWS5?=
 =?us-ascii?Q?Mjknc7L2p5KmRlYJrdv2xgID0MrVtR7Q9SfkpEqzQyGfDUb4cUxYB1aEiG7Z?=
 =?us-ascii?Q?JgUJFAUzp9GKb5n4wNmaun6JlTGhrCfQ702az5dBHhLN8rsTmESKz/Iv1wR8?=
 =?us-ascii?Q?9YB5Gp1XxcbIhFyZ8YaOC2Q/j35yTCDN3Bw08mm94GIZ8Qw/AK+F6JFYlkvj?=
 =?us-ascii?Q?miPcjT+u2Gm9ohtHm400tYycKimJ2HbBQTYGuhjpejG2YceG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5674eed-89f3-4dab-d755-08de5f23ce83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:47:32.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NHtdYF/MDGNWhksVLzm3IqjOvQyFFYTRalC2i+j6iI4AEoh2YJcIUEcAV0AdY1NNxaDvVl0aaUdjAyPbrdw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com];
	TAGGED_FROM(0.00)[bounces-254738-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA509AF102
X-Rspamd-Action: no action

> It is removed :
>
> https://elixir.boo/
> tlin.com%2Flinux%2Fv6.19-rc5%2Fsource%2Fdrivers%2Fnet%2Fphy%2Fsfp.c%2
> 3L2648&data=3D05%7C02%7Cwei.fang%40nxp.com%7C2f06a252bfa24532562e0
> 8de5f1fbe42%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6390527
> 87105780228%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlY
> iOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> 0%7C%7C%7C&sdata=3DFtbZ%2FZWqje7ckLwHvVENVlkus7nsTB3hZ3N05jYuflc%3
> D&reserved=3D0
>
> This line above is called when we unplug the SFP module.
>

Many thanks for your detailed explanation, I really know very little
about SFP. :(

> What I am seeing is that there are other devlink links that apply to
> the net_device, unrelated to the MDIO bus, at least on the devices I am
> testing this on, and they prevent the net_device from going away.
>
> One of these devlinks is a link between the sfp cage (compatible "sff,sfp=
") and
> the netdev. This devlink seems to be automatically populated when OF is
> parsed.
>
> To solve this, I think we need something more granular that this approach=
,
> and make a distinction between when it's OK for a phy_device to dissapear
> when attached to a MAC (SFP phys), and when it's not (PHYs hardwired to
> the MAC).

Yes, perhaps we need to add some flags to determine whether to add a
devlink between MAC controller and MDIO controller.

>
> Adding this devlink in phy_attach_direct() is too generic IMO. It's likel=
y
> that this link should be populated by phylink then.
>

Some drivers may not use phylink, like the fec driver.



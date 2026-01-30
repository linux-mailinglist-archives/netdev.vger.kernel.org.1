Return-Path: <netdev+bounces-255009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C57KmwofGkiKwIAu9opvQ
	(envelope-from <netdev+bounces-255009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:41:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16256B6E32
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7FA13013844
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBC34AB19;
	Fri, 30 Jan 2026 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lt2JeUJw"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480A32F745;
	Fri, 30 Jan 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744488; cv=fail; b=jo0M39Qqm9Ep5L3/T0hpptrbWTPmrplSo7rUTODJOQfhW4lxEPhCFK12IUYCwXDBwyWZBwasMmp/yl2Du7qKG0qvriRfGDaFuggrsFC9Ig1+A1nbulnxLRoHYeMkL9RnjEe052w8u1Ph8tVbF++ZsYLxtZWn3ko18Qp8xthiaPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744488; c=relaxed/simple;
	bh=5mn3GyL3vVBBrqE5B68RU/iuAOAqQ8Kl5osUep1b3pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SWcCLfm3JX37LSMZ3PqI0y+hOxGgejYNXKjDfpUZFSlmQwvOtqdyrsigu8aUOKQz1e0P+Jm4XLm4ZWdhGQTY9mKNPZWGPA4qZM34fGydFO0hdQFPwdJkr5ltg2DD+s3RxW/aiMe6DGnRisj+Zr2uX63neveiqHeJdvPa9elJL/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lt2JeUJw; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZQ3Rp5FtZn/h6EviuzeAKVZtQ9aeZ7tPIpgITfGt8VVkXrb8Ctkv0U8Nl6htgkPX0w23Vpf116+7tQpocKFbekqOJoGnrdAlfkKXeJUQBH+SGdVaxofiBeEZ9zSrZtgW6n9810Z73Rovn0px0uacJcyKhi6TZMGNfyf8BVf5FBiJxJ2jUE/opiHwbZ88kgrKxBrhSElSFekFJqk4PAcQgbIW0RLrkLe8d2v969P1dkgZr9Ahj4qYKjDvRSRO4tPE6w+AqqicUjhBhikRZncOdR8rMNYZ03O+xhHm5JmZEvkKCMu2TYj5dQ/ZRaTrQajWmkk1zFU1o7Ru2oWC5aYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GliczmIx+jbqtntKY2nCBNTcmiPCvOK68t/4V7CS8l4=;
 b=fXBqAk+Ca/7qW0vpSBlbUvzTi42Im3TdC4Gk5uS4f3DOocyQ/qgaPOKgvL4WBL3e8uIh6bzd5cLq+/wcMb8tLSrTOc2wiejOn4q8LOwuih2Vrg6dst8PwlryuDwZ/lsNe61moRlRIHVR0gn8CLfUi9dqVqLJYTAx9Rv5ijMKzrQUsS1f07014BMPHJfJYKm7dx1lSNSp5cpkmbb/TZSJwUZXmc0JBlN431U6sO4T3ngsKlJzEjshP5QuEZt1mrceyMS+ksASScMXztQ2II1vTL7xZjAZMI2jfv4nMN8WKmvJ1q4JXjgmrJduepynYEiUVJnvzrHUVkdJ/8jWpdPGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GliczmIx+jbqtntKY2nCBNTcmiPCvOK68t/4V7CS8l4=;
 b=Lt2JeUJw4lEeGdmprNKQrUNvJWfWoGyYzLo6eabQxG0wb8P7Nrq45hVB+m0FR0ZTcEQaGaGo80rP0Wuv/wwtKIWZ+ncP335+fHeZgmF7iDLRwF6yiAX1l9lhmG2cRQM8zdasEG5y4pyz3ft4vtpR02jlOr7ZeVAWNYgxvutVmtIYHF9aNSsmSR0Bbk3qCQ6i7vH1+r4jpBRJW+tApkx9cHf5Oiz8U4o8SU6svpgl+iI8+VzrB/ygoPBbBQqxz3wWOQDyQgcbrliHtWwzTAQiw3XUF3lSJJ5lr5lx59lYc1JbBA2rC5smhjZoP7znL+yxJIDizYyBrH5Ed5zfri3PfQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11874.eurprd04.prod.outlook.com (2603:10a6:150:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 03:41:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 03:41:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, xiaolei.wang <xiaolei.wang@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
	"quic_sarohasa@quicinc.com" <quic_sarohasa@quicinc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVojkqAgABiM4CAASQWMA==
Date: Fri, 30 Jan 2026 03:41:19 +0000
Message-ID:
 <PAXPR04MB85106B63AF43DE0830B4C362889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <20260128201501.04bb6e5c@kernel.org> <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
In-Reply-To: <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV4PR04MB11874:EE_
x-ms-office365-filtering-correlation-id: 99b3411b-459c-4376-8f1d-08de5fb16de7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2C9Zfyw0T1N8wu8amsA3t5rc1mp6z2IyRJKwwtBTBla8ihrfLjeT6XLRu5QW?=
 =?us-ascii?Q?9BzUEArt0u0P3IjP5xdINGpBJPe9lLLM0IKfOPAGOBlviCBMuWHqjByUCNQW?=
 =?us-ascii?Q?Ka8Y9VbxYbEySG0ur9IOf6PJpNFDz9/On6tJigp2uQayKsSJmlEQf6YOI1SU?=
 =?us-ascii?Q?C/OjXJHhZUjlBdRsL+/Ycq1Rq1RdpDvZfISb1lfppuFZzHU2S5Qcrg6l49Eh?=
 =?us-ascii?Q?2wUsyNdJAlLCtlzaWOGvfym/r6fOCiOp+RQZE/cE9l30vZ8R+UQ4WFd94XjZ?=
 =?us-ascii?Q?DJtTADpAcjIDNbxH93tgG6h9qORuCtHBMRiKWMRnZA0WGy48fwpVoFi/wE18?=
 =?us-ascii?Q?iibXOvWUD2iMox0RZszOjvWj5G2pSO9R0WqZ4oWjv6wNAnCK0EONxk3J7+IP?=
 =?us-ascii?Q?yRgrsGRahew8nZSjhKRBHo48DJUWBQlwsN3cs0TI2me3Vll2GAKKvq7Fboz1?=
 =?us-ascii?Q?ZdjwPf9pxmt/u3VCtyiq7adqFFadnClyZrD1CQzXy60/PbyuXn8s2jYNGb5i?=
 =?us-ascii?Q?pQ5j1bRaRVBwfJdzw4WygG6ct50NDVamxlgHJN++1OctGCut3acGD0ai47nf?=
 =?us-ascii?Q?1EdktAFETRawqwwPSoqeX4bP0zZN6QaiAQqmSmtXG3EFHhUvofQ3yX1vvRv/?=
 =?us-ascii?Q?jsHd0sdv+NhAF+6N8SDkTQFzXHllP9iyTCPi8HGVWBmyOfoKgqfW5uqXg3w5?=
 =?us-ascii?Q?DUSHhn7JvbRw3W2qNblsWDLu0Nq9gcS+HObzlUTuiUzQOUcs5uOmwy/9Zsxz?=
 =?us-ascii?Q?BrFqlHAoE/GQ30ckBg+HqyZm/VRz6uj//o878bca4mFovLg6XmjTh0jrAary?=
 =?us-ascii?Q?2PeqB/PzieD6Z6Om611BJsTSmG+lHSkXgyIwWUk2wz0vj29J8+sCPX+Z+DVv?=
 =?us-ascii?Q?0XBOlIZSfgwJfIVG5rhxDgYaeZZ2vH/UT7bZlaThaHbxrFy19BPPU9ErSGzI?=
 =?us-ascii?Q?33s2oeLzldDtI7TmbFgTqxp160XogIouocawIjvpKZE25Oqm1GJ34EIoe2sc?=
 =?us-ascii?Q?fZn9VAaWEwIHlAC86MEXCs2tc9Z6GZ7N+zJfgnBGlAWYnemYumuO6D0pAq4i?=
 =?us-ascii?Q?M/BUUDxBwyyPm44R/qSTErRK2k5AZHHyezpPizdiQ9pXcWXqcbCAZfPrNlkh?=
 =?us-ascii?Q?Mp2v8EfZFcbRI0Hzz279XFKh8PwGOsJfwvDRC4TNL4rugnbpR5+8rVgWWbwG?=
 =?us-ascii?Q?VhAG5cpBV5kKkUanD3JmN1uwVd17aR2xhhNvX65ssLCnT2uo7nl6TxNrXGGe?=
 =?us-ascii?Q?+oUYTCOY3eBVeknTtKBA1qZq71gpEBdUIjm9b93gd9Bm8ISpD+T1c0unlmXG?=
 =?us-ascii?Q?jhPTO+/RqP2h1QzW+CI80f3nxLFOcNBpNzoRXP+braZCzszcj9SsTqzLsUMN?=
 =?us-ascii?Q?fcn3Iyg69aF2Ay/y9ZErp8vEJJr+NNkcjZSKgTDQUzK2PSDC/lXIGia1KUvV?=
 =?us-ascii?Q?N8dCZFDvOpQBlWI1R9gogvzrMQFlazNZt+EXoEmWfFmKzuWgLvKCKt9EF/QI?=
 =?us-ascii?Q?QjM1cGTcBfNEiP/VICsH4hrSdeMrpPpX8meepjvmcNhbbxthHMjo43sS360f?=
 =?us-ascii?Q?jt9NsaPbFZ8u94B/Myf7Ixw+SniwlyceZ7xKMY8nj8NmARCtaCgWElzvQpzJ?=
 =?us-ascii?Q?p5F54YDtr7WzkXJHyXJ8pyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iuPbi6NY5K2Up0n5TmyS/oJxgazDLdOPanpDEAcUxL7Mw4o6/thCDHHswNFc?=
 =?us-ascii?Q?tvj3Niy+tKnnjPEtPI4xpdH2sEVV5n0/peVZv8d6bNWOpAfpibvOSatQiwKl?=
 =?us-ascii?Q?zt2Y4ua2H9dNbuXe3OOmqq6/3ZwnIBO27gfSeK1TGwoAnTOJvYI4deepFORn?=
 =?us-ascii?Q?jn8ivPKvHZJzutudAGYrWFsDT8SZ4KusuTISkwmq3JmAtxN7VX8USqF+eh7/?=
 =?us-ascii?Q?aXERNIOpXFquEOE30w//KFfcXLJNn2pDOQFm1dyqiB9DF97R2oAb6WCUX4ME?=
 =?us-ascii?Q?FFvGOmDPsyYZQNw5du8MPQont+Z5HeEJC+Vkj0r1KAn8OWqVbE6zph9W7e2a?=
 =?us-ascii?Q?vG/A6Vje0Kb2hLY75MK0X8pHqYBUsw0cIw2GF8OOv7K1aqImt4F0Upx8DoIB?=
 =?us-ascii?Q?g/fTcM8NXYbbgarbgQCDqbB9x7ibuJQAxqn26L9bode4xmQ511w8eb2m7mF7?=
 =?us-ascii?Q?sXPBqcsQlmHBwaMO4q+CqRrNFODacw3UPj37X9LLvGNFcXDtl5WzdIfk5cXk?=
 =?us-ascii?Q?u80wGQHJemEeCucg1eXCXzjRXdVGs3w7XThYfCiFKDrVBCNmXC90mYuFxdhL?=
 =?us-ascii?Q?V0CA+RnfYz/CymcduArnn7g9EVQGvS9N12S4BeItApjbbJ+laR0HYtzTWZYY?=
 =?us-ascii?Q?KNjvPED8d9xP/76XalkIs+Hk9ykBTKkZ4xGpEZnud4yh5ZpSbqQzBr0Uadsp?=
 =?us-ascii?Q?6+YM5ir8urYgJHPp+EC3crtrVdmnwZD+3C2+atDg6456Dob3B1iu1d0R+moq?=
 =?us-ascii?Q?NQAPuJSXyt9Md8e1a6H/2xiZMZfQXts3tup3P0/1+jKjTMUkbFTPZMQaL2FD?=
 =?us-ascii?Q?gT6TZ9qTnL1zdeCC82Eh4XrL+K+f/t0fBOfmfB+mdW+9NF5CJNlGJcGI1DOQ?=
 =?us-ascii?Q?5i5Psz4gKt5iJI8lM2KOoTlCTXiEhlRHJ/dDvNROssufO77kWe91kQa7vYVU?=
 =?us-ascii?Q?Jgxe30VVnmnhKHHlPiwpxcKRu33QITjH/4dYdXirst+MGBSt8ZSnzsEFgJf7?=
 =?us-ascii?Q?VKpkaQFhkklmfchWr0wkd791Ltv3Ru9O52bZYLEiIvUbsOVdFQmBMDYJhVu3?=
 =?us-ascii?Q?8MrSfNCNAr7zbJSbykreDapFNwVDGiWQFoIBKrF5MnRdCFQnDsZHY94DOUZu?=
 =?us-ascii?Q?veA09ulSQUeBKvQWAvpmr3n8ArwtC5duLouiilfWqaFr/exQPaGBUHG40F91?=
 =?us-ascii?Q?pH4iR8vF6HoDiImc3Z3+Z54yZgiNbP5L40o1SddYRagl4/UN9+wmE4dY0T2T?=
 =?us-ascii?Q?CVDrWuMwUqfSkLmkPipqKub6E2uTPkggqEYniE5sQdWi3mwPxWosQU9Plhvz?=
 =?us-ascii?Q?1bDssio70DquDjv9afkWoi3aQPOHyIQdZzKnD6vYKSG9r2NTvIs0MhizGHWi?=
 =?us-ascii?Q?tadXvQlnEaD9nrE7T4LoibU0DFoWpwe0hI++DHm0qgsnaLeo/RTb9VfHbnsW?=
 =?us-ascii?Q?f9W7bUi5crN92kM0o390ZcwH8kpwQQTzYOM1zIKEzJBQdZISjxY1PtVvMqol?=
 =?us-ascii?Q?DxXSumoEeXIW0B1+corqTJ/APmBRrj4Gof9dwyBLyxJK5YcVR9gk7Qx/5f7r?=
 =?us-ascii?Q?0FDI1Zm3CIXawq9reixIB5NKo+E5JrbL6LFlNrXOmMFmWs4xZv+rtQQwAZot?=
 =?us-ascii?Q?TWv/qaZ85jyJzGaeYOCdBCVBxYAYq0c7DDVzB2KkhuAVq3QjXvfzSRTWn4JA?=
 =?us-ascii?Q?FxOMI75JYzsGo/7QBUG6xnpOL0dT6Q7qcyLm0kjNmKBa/vpU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b3411b-459c-4376-8f1d-08de5fb16de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 03:41:19.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VoqsI77iHkh2s2g/i1AaDjlDZLczxfEhEjsA6NW3Ahm3+nOuqRz3Ogwv83FXGC62ADQGc8zUwvZQN/DtGkOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255009-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,nxp.com:server fail,PAXPR04MB8510.eurprd04.prod.outlook.com:server fail];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,broadcom.com,windriver.com,davemloft.net,google.com,redhat.com,bootlin.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 16256B6E32
X-Rspamd-Action: no action

> On Wed, Jan 28, 2026 at 08:15:01PM -0800, Jakub Kicinski wrote:
> > On Mon, 26 Jan 2026 18:44:09 +0800 Wei Fang wrote:
> > > The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> > > dev") has created a device link between the MAC and the PHY if the
> > > MAC uses a shared MDIO bus (The MDIO and the MAC are two separate
> devices).
> > > Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> > > DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the
> > > solution does not take into account the hot-swappable PHY devices (su=
ch as
> SFP).
> > > so when the PHY device is unplugged, the MAC driver will
> > > automatically be removed, which is not the expected behavior.
> > >
> > > Therefore, to solve this issue of the shared MDIO bus, we create the
> > > device link between the MAC device and the MDIO device, rather than
> > > between the MAC device and the PHY device. And when the shared MDIO
> > > bus is removed, all MAC drivers that depend on it will also be remove=
d.
> >
> > Anyone willing to venture a review tag?
>=20
> No, I don't agrew with the patch.
>=20

Is it because of SFP? If so, would the following modification be more
reasonable, while SFP still follows the previous logic? I'm not sure if
phydev->sfp_bus_attached can be used to distinguish between SFP
PHYs and non-SFP PHYs.

Anyway, this problem has existed for a long time, and I think we should
find a way to solve it in upstream. If there's a better approach, I can hel=
p
verify it.

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..c48335bfc7b6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1771,9 +1771,17 @@ int phy_attach_direct(struct net_device *dev, struct=
 phy_device *phydev,
         * another mac interface, so we should create a device link between
         * phy dev and mac dev.
         */
-       if (dev && phydev->mdio.bus->parent && dev->dev.parent !=3D phydev-=
>mdio.bus->parent)
-               phydev->devlink =3D device_link_add(dev->dev.parent, &phyde=
v->mdio.dev,
-                                                 DL_FLAG_PM_RUNTIME | DL_F=
LAG_STATELESS);
+       if (dev && bus->parent && dev->dev.parent !=3D bus->parent) {
+               if (phydev->sfp_bus_attached)
+                       phydev->devlink =3D device_link_add(dev->dev.parent=
,
+                                                         bus->parent,
+                                                         DL_FLAG_PM_RUNTIM=
E |
+                                                         DL_FLAG_STATELESS=
);
+               else
+                       device_link_add(dev->dev.parent, bus->parent,
+                                       DL_FLAG_PM_RUNTIME |
+                                       DL_FLAG_AUTOREMOVE_SUPPLIER);
+       }


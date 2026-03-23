Return-Path: <netdev+bounces-270474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AETDKpQawWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-270474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:48:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 295782F0773
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664CA30D0763
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6738D6AD;
	Mon, 23 Mar 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKAsyN6w"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AE36EAAE;
	Mon, 23 Mar 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262436; cv=fail; b=Egc71QAfb1Xxq2JAzGzwy+r3W6S96MnSvVWU23hP6bgyiGe758uB+aWup6k4YEMMYpdnNQWOTyVMWod/uxUAE3mIg9aTQVTz94eMyvJgTTQQgpXTy4qWd2hwT6tC18ecbAAMesdYzkmR3PUbUFsRTSla7j9S40nf6c8YrrxhvEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262436; c=relaxed/simple;
	bh=tU/IlxuiX6Yy1m8entUUSBbXVAumU2cnDJcbbEoB9f0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNqx9Ly74xbVt2VmLHIaC+la7ylq3Cy743RQR9uTsG+jM2pd2+anHEzn/foAD9ejrnE8K+/uJ8msXKpIawJ4DBMrkS+I0dvQ3NXda9+tWY8y9HLfzi8LK9zC4yREpxXu68B5bQd7GFkPNvZxvtMizVfLfoiI2MMDDaFpjogiQ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gKAsyN6w; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmV/Bs5csWyxL73ru4kbZmKgdS0ZzwQyAk0JR/UeBQMBBWR5CXe46Q2DLaRsWACjOo2FwhDfyVsRBUGFgH0RF2xUFuD+lTb7tI2/d5YezbEjWHyves1jMNaVMYvUg7UsPgHkXCUpD4SqLFEztdErLz2OYCJDpjnm0b70AYBx+8Me8+Nh98fOag1t/bbeUKSUtV2n1YKcjXKEf8pf1aq/oRk9TsjJ+7kjx2YNuXNw4ClLhEQGl2C2qDSSIi+BTist8CUuCr0Hg0nVOcNaFSMpcQFV53e8dlMYE8NN54s9dAQUvhdaeuK1NggoPwhk2XWDW7roga2X3ZjrtTD5XSW+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU/IlxuiX6Yy1m8entUUSBbXVAumU2cnDJcbbEoB9f0=;
 b=UQTwNtkjk9VA7r/Lm57mwJHxAcvoG6aU5L+4MmmNUeyEALmyztxuIooGM3xALd0OcQiJE/TvpPOtq/iwCYKMJLgU5TmlNlqb0dc5qqf171it3PLgItmy/WJul/FC8TE2oMSjAOZSGyekqOVwPBMm9cJby6QjjqnDaGHizmRpmeK6j7RQUOO+glvew4mfsEs0AwB92AXWMCM8HSZvkQYrA2aAdhfywdZZho1d61O/aHzKMpKu37uN6UOmhmjJNUnqWCqJ5Az5Mv9tF1HS3ChlRVLVNsr2dgSEijxaGvhqcaysoUJBTm3YvNH4KaCAyK+VRDdE4PDtDJQQK1uTawQhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU/IlxuiX6Yy1m8entUUSBbXVAumU2cnDJcbbEoB9f0=;
 b=gKAsyN6wdWjsukfRIY8l3pQDNJcrhNZ48GOVddPluZ4ttW7JwS29PT5IN/CFTcaXeAJxVfdlt9M/taIBJECMr34hKIICWzg9qP9WujxhnyV4wSrf4PlnoM3bntInjGkD7liT+md2reIXQ5wnytilFjfsY1eT4SCjdmtNj9+QthpJ4kbJK+zNRpCDPfmPWotVuCdgl8+Jr0ns//8zHrvSza/KRVsQr4Mf+7Qq8k53rVi23ZZQuprI939HkAa1iRULUefZ4QmgkJKFc03HOS6NeSbvGRwATTD8Ir99U6EaOH6cLVEpfQWhLRpJsRY6y6UlDWSX5/IPjjUMcr5fhs6Xag==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB10015.eurprd04.prod.outlook.com (2603:10a6:10:4d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:40:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:40:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>, "horms@kernel.org"
	<horms@kernel.org>, "saikrishnag@marvell.com" <saikrishnag@marvell.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Topic: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Index: AQHcss4KuCbBqII4UEKPje859/m9cLW7+6pA
Date: Mon, 23 Mar 2026 10:40:03 +0000
Message-ID:
 <PAXPR04MB8510310D3FEC15E163A2FCF7884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
In-Reply-To: <20260313094644.1132411-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB10015:EE_
x-ms-office365-filtering-correlation-id: 3e4284b0-0683-45c5-009a-08de88c88aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 S5csCEB5b8ntf6NXALguPgszipo0C8rYn0wWHfMc+I+SZkygUMLlqNPSMilEJ6KrO5LckHFTX/sf5CodVlwtU7am9TUVaKJ6xScl9nDnISif16CYwZus19OimJKPcC2od/PThN/u7muE4AzEwkq9PGvflXDArgo6YPcdtGBtrmIHdf4KN01/HIbQRKHh4DZTmz6dk41kzFadLgP7cQE+pwalZuix8yxjaYWYAxqj30OpsTCXVL1NKPPc+nuVP4iqiRd0tt5WSJzl0d32+nQFIcCNkuBYrdFm1o9VNa4gFaYcniOaPmyCFF7V+72NudHTLZQZWtKrLiKgdi8HVzAnZTSC0ROLRvwDqjydufiPXTDYK8EJzNZ2sMcm5KfhrdDk5iphLgeK3InjIJj7qYk6++KjO1bJAkctLOmDTLDjLG7xjt5DcUKaZeLHO1Hg3uajMURaLx0VlH9IqicmZEclScqRv6c0cG4tDhDABQmgnAIYOoA5ParCgX8X8xo5/YjoFgKYEWd86LugjEovhFIm1JCfzS6MR4MKq70NmWunuLR/8z8DCgXIb/lHcKMNMPnkWZcfik9Nu01pWJuuKC/DgcZXiwNqVLGo2R+ww9VkJ27IRd6yefgVTk9QdVsH2TF89QwchJ+lBigZnLx1ckiAQySGJZ3+29e1rW3XWccEaepfPFU+UDgxTlE8mE5FzXDg/zka2thREjs3HvHCdf3wmlNNxeTktZbJgiKKWlXlmOkuzvWKi+vYUOYfmjSwkGOZ0sJ8w7KsZ9oIDtVTJwE/dF1JbKoQibwdxvaXxoMhMoQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ehC0B6w4oxkpcUsiL5YLtYI7DDv3fMKVeXBYhaz0JEu8QesWCDtrSUHHHR5T?=
 =?us-ascii?Q?hn10ysvobAMzmzLW+9mojiNWPih47UkPN3xbbY1tEX4R/pxDa+Ub7sRd7utO?=
 =?us-ascii?Q?Emru1fso7efxhvoyliroJXX/nA3Ixo2lWkBuuiTUq/ZoxRFMkYWD9ZzLcV0i?=
 =?us-ascii?Q?ZHPnsBVYVu3CBNLvdPP8aCGpgXBUBqhok8RDyEuoW16uwzFiwMVbLextnE1X?=
 =?us-ascii?Q?7EjpWzaAGDt3JRFhrxiZiRJxIHa9henn53GIhIsjnWUzrmhEY7Hcyos6ucmU?=
 =?us-ascii?Q?lfRmXzltE7ZNyg5Y1qKtod2kEHauLo1wMBPGouR/xTbKKNWvcOSchLPNBlVS?=
 =?us-ascii?Q?XaaUB4a242JDqWwYMsiT+seTurARUXernoUjVxToLQDx4yoE4jEGEyKZmPCZ?=
 =?us-ascii?Q?MWURMImcr/93fzFHMlKg8IMgRYrGTtw2Y9E/iS7b6HnM2CnyE6hxRb/ZLXFL?=
 =?us-ascii?Q?53hMgXY5R36VE+mavc/BIp/VcxQF/4GmJAjkUJBYPCB1PqTcba9kq5oGjdSS?=
 =?us-ascii?Q?Lyh3n+pVcgDhnOb/T0rz6MU1n3kFMM/GHxABMHJ52qQFROPC8Xc1P8+ON/Aa?=
 =?us-ascii?Q?IRnzdjMOqYY+je3SaZ0FXTiWAD6CaxFcIrqwolz3MKkdH85NO+mA+pCftQGf?=
 =?us-ascii?Q?82eJpoK61YwqGhZZoAd9GXA1QZSp7N0ncQrpa3UdbobhqzVYa/LUqStRh0ad?=
 =?us-ascii?Q?uiJLUsCKAHfThCaaB4fLsqae3PaFjlF8WmD+DAk56zZcwjIvQaE2D/Axpik+?=
 =?us-ascii?Q?JfcG/iXitszfQ3bAjelM24NxYj+9MuW/cWRtj54ymJbN8/4GnytWOIxebDlH?=
 =?us-ascii?Q?jQPKpfnsMb569s5njKHpKJw45rqDayjZcN5klXZf2L6xzLIMm3k8k78Slbbo?=
 =?us-ascii?Q?zGSTu+ofB1yR6Ok8aW6nSgkD5NTLiIhEGTrmHkyDsKoaAv6d0C9vtNLeIWU4?=
 =?us-ascii?Q?KaiV0HnZh0aYIs/sHyqCGjGNA/HSZI3Nd2D3T8DGUDHHiPgj6X9NT8FCz6vg?=
 =?us-ascii?Q?a63OMyT5K/fDnGDqjbMqS0t/pi9Fd+aLmEhvS9ckoKhvAdJLFJUkcxZHNMuW?=
 =?us-ascii?Q?X4N4+NFbiV1Atn5Fyr120lr3cCXi0pcXJh9aT3sUD5uGcJkqH4saS4P0RNUk?=
 =?us-ascii?Q?9kZJWit6J9Xh5nX5RRwSerJYariBSc4CExA4wiQK/F3+1PPQM0ytfqja+6qw?=
 =?us-ascii?Q?AwDVNlZL+mzUFUcsn4gbrLHggLLN9fV5sc/zvIbj6kJXLiHdnn6ot8Zf0b1B?=
 =?us-ascii?Q?wNSMzzSqEPOCW9pJ0qoqXF4y0UzARRSHVI2ZdBOK2eWQMrRAmLAHbx0jantO?=
 =?us-ascii?Q?fGtRmGOxrm0XOU0x3p5YyuBYBbi+p8tNVW1/FshxZN/9utsAdG6cAcswabUE?=
 =?us-ascii?Q?A+TfTBmBVefGfKVboDeRw7e17PZO8n547TigGnYL9cFWZm1+mzYH/WWvuxzD?=
 =?us-ascii?Q?+Gig0EvsnoZwc3tQjCIB2KycxeICcsKBkprd8pqjAZ6xLCTJqiNRF9/dqcay?=
 =?us-ascii?Q?IadxNssbopuKU930CGEECebEYHX1USq79cbxGx7An4hN5qKIkRV91OvsiGGh?=
 =?us-ascii?Q?ZjGHFsNjO7+/iozA3yXqVjEBMB4JpsZig6PmWK50GB83FXllZdIQvfNK9+eJ?=
 =?us-ascii?Q?47zPf/EXqKoM10+exfMjFq9ZZKPlrjD1JUC/ysRGUj7lGNGpyU801vH6txHE?=
 =?us-ascii?Q?zN283hzZePfN3/yzao2ouZyzV048ltFLMRAPqyta54gynXbE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4284b0-0683-45c5-009a-08de88c88aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:40:03.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV//j2pSgu8jeGVeLStbKKuc2SOMBhKRPoeUfVXVuUfX85sRMwe/0rEUj4M8o4hnW1+wLJwZNdINQCnG2XRPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10015
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270474-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[PAXPR04MB8510.eurprd04.prod.outlook.com:server fail,nxp.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PAXPR04MB8510.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 295782F0773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work properly.
>=20
> Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
> the driver must reset them if they are not equal when reinitializing
> the TX BD ring.
>=20
> However, resetting the PIR and CIR alone is insufficient, it cannot
> completely solve the problem. When a link-down event occurs while the TX
> BD ring is transmitting frames, subsequent reinitialization of the TX BD
> ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
> clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
> not safe to reinitialize the TX BD ring at this point.
>=20
> To safely reinitialize the TX BD ring after a link-down event, we checked
> with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
> Therefore, add the Ethernet MAC graceful stop to the link-down event
> handler enetc4_pl_mac_link_down(). Note that this patch set is not
> applicable to ENETC v1 (LS1028A).
>=20
> ---
> v5:
> 1. Add patch 3
> 2. Correct the typo in commit message of patch 1
> v4 link:
> https://lore.kernel.org/imx/20260312095415.669128-1-wei.fang@nxp.com/

Hi Jakub, Paolo,

Can this series be applied? Or is further improvement needed?



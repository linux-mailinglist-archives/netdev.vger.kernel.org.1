Return-Path: <netdev+bounces-297884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G7bfJtwZKmotiwMAu9opvQ
	(envelope-from <netdev+bounces-297884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46066DC6B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:13:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QwsGoJfF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297884-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6945313F74A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B527A47F;
	Thu, 11 Jun 2026 02:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222026E6F2;
	Thu, 11 Jun 2026 02:12:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143939; cv=fail; b=eNjg8jMo0KulTciZhDVKnPYMMdYkxASF+PYmShFrnBtVdaLw3HpgW+60O5rUUHkqp4FEvu2r3NmVvs8A9GrcL8YCYyQ3TTDUVWFTzrD1LFOwUWA4pKTuYzlh64nKfies1xSomormbqa2qvLii0R/2Vx5EVSzMRhDtj0B7R5nJLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143939; c=relaxed/simple;
	bh=bGIHe4oAVcj1yK6R/GrA5dn0UVIVyyA/VR2pa50sMHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WG5YZ12SCrNjNsIPBlvYc6JK2QtRZfKRBJR+xqyx/MEu3eZ6/wj5rxbNSw/oDvfZ8w08t/XjNtmev8adKIrxlQZjpylQUikg4y1GGQxGQu9dvFFXbheKex3rznEtL9qIFF4sI/46sJzSL3iDEm0UOwHRr88eH94xwmTsCsqW3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QwsGoJfF; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO4f737sk+C1ccOV9Ri+yS8qTB4AMqrbd1sdK/iOw17fOaGxMgW2b2WtepVXQBem9NppqdTW9mSm5URfuMLDUK3S3l7jOXrXIiCfgXsbziSDC8l953pNgnvxZJ0VFs387wfMjCA0/o+6roHuXKCLC/52hD9HumySURWSP/nCaFJkASwo92Vqo1c6rFpS3+fsLipJ2n7AQ074iUqhZqJtO5xDK1vvFtqGJZRSdOrkOsLQ9LvbRkc3FEyE7i2aQ35fYxcaDPkDC55rMnEKR7Nw3OJBDnanI8BCTwpaG23XgToaQ/puTEquJdHdU0JOt2k/EuvGkB2UG2oHOHtK9zHKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=cEl2jV7cguu7tmqDVHJ8SJqfqF24KNYLvXoVLrT4eBT+xEP9clltZkMhz37a296hD/FY3Oa6MuLH7dnY2GNTX+mcxG2IoV4bDVbuVaOJpNVq9xwwKByFQK6fW5SmJ9GRMWnXlhdRYpCONc9pOgaa/Mco/rZvFMJ5HmZlKMvE2PUc8kqzVFK8giZP65G8gkFkdfl1jC4qnA6ZkB2f4wJrEMazqf3kvRvJxKw2JEzIEGSoT1afkB1aSj9rD7Guou2lN2MDF8cNj3/bmqrlOMF0W16aPYLJwhonD43qHSjUp8iLdzs4zxAJPpYyms34VH2tGK/G8gx8KEIP7FpnetkEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=QwsGoJfFOAweoBj+TLL0ULIFOnoR9SLEQBY5412NA2ijKGRnizunL/pXgH8pu055TkjVtB0rUnu0Ms1Edhe6bMjC4YfmWaedfptgq/MkZqm/FjWsKEiXV/PXazKAQsFPt6aW8ZvMtzko8xFbwBA5OEniEOWXhJPGGkZsBeCKwLwak4uqmCntIcHXhzug+xQHvGDW/18xSylPvjP1aQxMXaBna3MS2eztARWEXzbzK8iWEqbJC/skK9+OEzzkag91t/fR554Luuh2xeMk0pIjFCbHP/jPqDbMtaTkz+TnWyUOJchJxUzDRuL2RgHSavttPcWIbh0Z+yrA3HntCR3f+g==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:10 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:10 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Thu, 11 Jun 2026 10:14:52 +0800
Message-Id: <20260611021458.2629145-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7f69b7-e74f-4e95-7e25-08dec75ed836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|6133799003|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bxyghHHRNpvZTVBRvwCiYGl9r0lqBTyf2myDiGWxF40EgVe9nC5CIxwy13xd0luKGQ+ysIG8MNSOl+tvwc9OR2FzW5++HvH/w2oxE+bMMzjRHPVlOA2/6QfisLjf94H2s3D2A+evL3f7ky8Ovm639Gf24Rf4heADsYJdQ+yHVexX6dwAbFId+/AVgyunn162Wfhd5UL0UxHRLCf2xFjQcI3CZF+x69S/Tsknk6P8u9zQRQsqmhKETIEDqLi4BTp3jpIbjR2daD0tNVEQ9clQbbkMQGrqKeilyWrRtId7+FYNPxM/RHJBcGaCMohyC79YsyOXMbr9Xp1+X6rLjcfaa0P4n9288bZUm8/cpvWiHzTs0SxJm8jMsaStQq9aIhe33/3o3L1l4IALtr8h7w98kDJa8s+3hwtcYIkWZUSQrwsrKbmsr2XnXeZxa1XtPOcVesl9Z8c8LexWQO+z9qhhAw0avTaZfaEMhJoO+ZBUW2/eic/BvFPo2D2Ja0Uaqe4c6VPgVKE4vFcvg1VKE/sDSZNR/LLdwRSS0DsJ0mIJFyqsAY/fmPKerM4B8/vg8lCIW1kyGfwk6CcOlm3Tjb1hRYWJpkjYUJdu0OAsbAK/5j8ZSbQWtVHsp7gaVFTcDGsJLjHwqzt1SfsmkoY19ZEctHKkRwN5WqavaS7e2J5y2CocwdAR+H25aAQKMbLSGJLJ0JdS6/L7dHVgKePUcGvaqy9PZOGXGMqImun+slYDdZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(6133799003)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XwyvNgJ4fQ8KnlLUv6lAIMOMBrMbIyRkUnBVL6238qUQ5kI/nIf4UnRRNwJ?=
 =?us-ascii?Q?OsB4v3uxb4zEYQT2P5galZWCn5nZWzoILY6eHY38Lkvul1yisIzIIvDXghmk?=
 =?us-ascii?Q?ip10s7L4BXjlj1wa3Fp2RxKmSmztT12ywULUiNL+8oUCqy/4wL/u7zNwbSPA?=
 =?us-ascii?Q?KUCzZaFnlsYlnV/gCf8e4ehY6MTzR+Z73yTsMcozoZr+Yt6OSY23WfbjbUOW?=
 =?us-ascii?Q?i8d8xP/j6uU76Y1meG9AhOBkqFM/58RzhZdGgojiNhR1MVGdz5d144kZamQm?=
 =?us-ascii?Q?Md5l8E+WWcYpEsd3OkOzivsL5wgExnJT5pfDYTkIdDoZQpJTWDYFBnplmf25?=
 =?us-ascii?Q?jGLGhbEIvi0G2AndovyEfbjRnRAXygbr8MuWB2DWwKQufqLc69Nxo5C8A0mp?=
 =?us-ascii?Q?XzbAEhs8neGIBKXqEzAJuPO5nbqKKYFj7Mq36sPrcQW0xCuuj+T87tMxNdfy?=
 =?us-ascii?Q?XwScC4enKRenlA/R9+tzRMkEg+R1Jaf6l24LbAQL5TJ3H6/VLx/hcdhSyZlQ?=
 =?us-ascii?Q?F2QPxd37UHljM3mrH26PHo5+rGydDb7pmEsUdQEFs1RGX4CXcwYxvfIeEvDf?=
 =?us-ascii?Q?WOaCKbYECoGJ+FoFtJrLbHKDC0Tmy7sTIdi51SRkPHbTki+jpOBp8vQ7NH9y?=
 =?us-ascii?Q?lijj0DM8xrHXpOtuzdqSLKr9BpwHVpptbzC9arv7TFxFmLkPEHhx8Zy6qClM?=
 =?us-ascii?Q?+r7tpJrrxaGw0dUK37LhNEhEdnyQQKIc2a2nrafAxeQDoeZ8qXcsN1ZvZeDI?=
 =?us-ascii?Q?Rbhqg5jOeAL1Jh+rO9oEzSAZ90OOProVGol7dTipkL7qXcOxOICVCfoC8WNu?=
 =?us-ascii?Q?5loOuEZ7QY3mcN2asR43cQCd/DujocMfrfdQUD30zG6RzTf2Bk5caYce6vUE?=
 =?us-ascii?Q?yscfMRk+4xmgcSzDJyrPx1wxVQ0wGFE0oeNvBJbLTfKsXyxsJh1N0lvfYoFe?=
 =?us-ascii?Q?bXUhRjAV2NsUbSblSFmiHRm+YnvpxdF/13XvqAd11xZcjtzix7UgAV80i7So?=
 =?us-ascii?Q?mS+Nh5qn6XADWv6avX1Y5Z3G3TLbW1EraVLzZxniFpL5q5KSIL5uOdzchjBa?=
 =?us-ascii?Q?ciuGTSTWn9yMOvrjjlZaTnmBl/EK56EYc8HmPJEDKiBD+DJdt9seZc6tJ8ZA?=
 =?us-ascii?Q?XI1X0ps90YtGxKPTtH/JkiBvVkwNrb8taRzu8gHlvzAwEY7qOdO0c5WIj23t?=
 =?us-ascii?Q?HLPcrmGDP9q190ZiRU8jsRujSHg3oOQdzRPnJW/j8Qe/i7aB7ZbKEvosJxW1?=
 =?us-ascii?Q?ZSoayJ9+eYxURp0ilx/z8HzXR85WFAB7PNTuWHICbxGhgWvKu7eboofiNx/n?=
 =?us-ascii?Q?rrGWecyKs9O7XsotsKJ4B3qlODkznInBZqTqUD8mQd/iER6Qm3Z8VPk9TCpM?=
 =?us-ascii?Q?OITIJ73nQOrUVEG4eQ5l06mLiNrip+wJRqDZN6h1HWMqEwiycuJq1L79J5T6?=
 =?us-ascii?Q?iLqhr4m20ScjqKZ/DcV9odhUVZvVhI0l93UVHv2n/wKJq43x1A2rvbyE6nYM?=
 =?us-ascii?Q?L/z6Hb3BuuZxMb/i+8VCXsQTEm92OrB3pHZGOx/s6OMTL+EHXSgLEN/D/bBs?=
 =?us-ascii?Q?T9rCCmDUWAustdhtd2IQ80zJBc1N1fespYGltLeQuOzG+7be8xkcaPQgVEK8?=
 =?us-ascii?Q?Zrq+plW1Fo3XkmFgYk03dDPI0e8Zps9Henlj/R9CzjygYS/Kf0vjFy6eSOvl?=
 =?us-ascii?Q?yg/9l59wzFhmpMh3IYTRff7sIRh+tYGo1pfPWyE1K3XCW0ERID9897cZdgQb?=
 =?us-ascii?Q?pvF6r61Zd45cIikg2No5mbSvdDlcuTRBE3aEmknrO4dnM17BQUcQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f69b7-e74f-4e95-7e25-08dec75ed836
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:10.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJLtWyO92/J0E9kqydowtlIvFxHhIypW1JjsOfUsRXa0bA/Cx8xVS5Ncfn57RebGXecMwLIgRhZ3lk4O6gv2/SPqF0zkT94DToR3QHvprAJh1sOpVF3KA9AU784uzx+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297884-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA46066DC6B

From: Wei Fang <wei.fang@nxp.com>

Each entry in the egress treatment table contains the egress packet
processing actions to be applied to a grouping or scope of packets
exiting on a particular egress port of the switch. A scope of packets,
for example, could be the packets exiting a particular VLAN, matching
a particular 802.1Q bridge forwarding entry or belonging to a stream
identified at ingress. The egress treatment table is implemented as a
linear array of entries accessed using an index (0,1, 2, ..., n) that
uniquely identifies an entry within the array.

The egress treatment table only supports access vid entry ID, which is
assigned by the software. It supports Add, Update, Delete and Query
operations. Note that only Query operation is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 106 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 ++
 include/linux/fsl/ntmp.h                      |  23 ++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 4e60bbc38cfa..9249f78219ed 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -24,6 +24,7 @@
 #define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_ETT_ID			33
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -284,6 +285,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_ETT_ID:
+		return "Egress Treatment Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1091,6 +1094,109 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
+/**
+ * ntmp_ett_set_entry - add a new entry to the egress treatment table or
+ * update the configuration element data of the specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+static int ntmp_ett_set_entry(struct ntmp_user *user, u32 entry_id,
+			      int cmd, const struct ett_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct ett_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.ett_ver, 0,
+			  NTMP_GEN_UA_CFGEU, entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ETT_ID, cmd, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_ett_add_entry - add a new entry to the egress treatment table
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_ADD, cfge);
+	if (err)
+		dev_err(user->dev, "Failed to add %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_add_entry);
+
+/**
+ * ntmp_ett_update_entry - update the configuration element data of the
+ * specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_update_entry);
+
+/**
+ * ntmp_ett_delete_entry - delete the specified egress treatment table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return ntmp_delete_entry_by_id(user, NTMP_ETT_ID, user->tbl.ett_ver,
+				       entry_id, NTMP_EID_REQ_LEN, 0);
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9d30f128849a..531ea7ddd145 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -217,6 +217,14 @@ struct vft_req_qd {
 	union vft_access_key ak;
 };
 
+/* Egress Treatment Table Request Data Buffer Format of Update and Add
+ * actions
+ */
+struct ett_req_ua {
+	struct ntmp_req_by_eid rbe;
+	struct ett_cfge_data cfge;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 36a9089526ad..0c951e1c763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -36,6 +36,7 @@ struct netc_tbl_vers {
 	u8 vft_ver;
 	u8 bpt_ver;
 	u8 ipft_ver;
+	u8 ett_ver;
 };
 
 struct netc_swcbd {
@@ -214,6 +215,23 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct ett_cfge_data {
+	__le16 efm_cfg;
+#define ETT_EFM_MODE		GENMASK(1, 0)
+#define ETT_ESQA		GENMASK(5, 4)
+#define ETT_ECA			GENMASK(8, 6)
+#define ETT_ECA_INC		1
+#define ETT_EFM_LEN_CHANGE	GENMASK(15, 9)
+#define ETT_FRM_LEN_DEL_VLAN	0x7c
+#define ETT_FRM_LEN_DEL_RTAG	0x7a
+#define ETT_FRM_LEN_DEL_VLAN_RTAG	0x76
+	__le16 efm_data_len;
+#define ETT_EFM_DATA_LEN	GENMASK(10, 0)
+	__le32 efm_eid;
+	__le32 ec_eid;
+	__le32 esqa_tgt_eid;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -271,6 +289,11 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
 			  const struct vft_cfge_data *cfge);
 int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge);
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge);
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1



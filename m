Return-Path: <netdev+bounces-282623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AwlKSzD8mkjuAEAu9opvQ
	(envelope-from <netdev+bounces-282623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D00F49C7EC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F4154301E9EB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC1332608;
	Thu, 30 Apr 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CpsMmJZI"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584D32D0DE;
	Thu, 30 Apr 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517315; cv=fail; b=juaaBuRa5rEkLcpfL/s8/cJB98ZvbLvIKwUvbGze9vjMsBWPBsxyYTSsPt+tz2NxyAM5X5tcSvaWd8Qp7DISyBclIjd3nGNFATC5Cl8EYOTeHfpEx2YId55RAt2LUPztPcYwihWwYt7GU/7pMGg/HibTKWx2kyYik1XsSV4fZtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517315; c=relaxed/simple;
	bh=5MENXPVllZD5beNx5rPIqJrxtVoWqwiAkzPGh64uHYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcAf4WIt1/O5rwB+SjeCZfuxrlAvePJ+f9AV0CXlyM3RuqCEhk0z8GsiyD9FDPXQ9UAxRaI1OD9Rgih2vns4A0O1jFS50U1q+bpH9woWEo1GNEt8TwqazyvwpBmBlD5P+kshzv9bcMdmOTLjvCfr1wAiePG1DniGj9PNouHlplI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CpsMmJZI; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaiEex8EFHsFnOED7bZZHA7apcsTAuXQiBov2lFF6kgkQDuOJiKZh/ViOVlEF6ZQtD3LEkMdIMwZiXU2LEW2Vm/yd4Jjk6erzuQnecNuZfA4fXGwI6CgGrBTs6fa3dDz39aYo8hO6uXUqhyXXuuniUgz3A1gkAxNeCIqmiOvmgjx9EF03z2NSGnYofMxiJAKDrw0RRJPM6aZgmXoyRQgDFnxV7cBVrfCNKxnD3VKTRR9V8RN2SUIh1D7xKMhtNSlfJaewhhro8xN6ghAw4fCduu/srQjjtZ9Su7WxUFUzL5tKmfEAiZ08jW5o1Sxo49nXAFO00zcKN31Sgjp7+AtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deJTrk6VOzMiLAfwCesUVnAXxQ414AQl/Rrn2O4AyuI=;
 b=hLoIA7esqJfkyqM99ZQDrWc3OgyWaidw2OO2lzIy6tk9PPJ5XZN9JO/LhUwHBRXMYRoDVQs09WeBKhPXTt1BwSaXZfoLEgscls0Bn/s731RvFIXcRM8oBSAdY7NNrG/pLpObe5hisdhOIytm4TQPxt0eBO/VF4sPeyWycIROI23+qd24N4Y0TeNK6Ry7p2vJvCJrHdJZYsvg40mn/AHlGW+flJAgA5yUAKAucPULtWAi5iQh/y2p2LOgN1dMpPILloXGkqpgIX7Jd4/y60qYZd1gAppaCvxf0xrE+WqlGDzlnJLg44FRhH+CiWaNkc8X1+/nB0cayZ37Jo0evcbTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deJTrk6VOzMiLAfwCesUVnAXxQ414AQl/Rrn2O4AyuI=;
 b=CpsMmJZImJ+9grzb0VbE1FhB5yfiB2ED9U10JQsMAjUdven4/TBn2EXjS++vS3ktVSlokYSD29BFGHRKVEioEZx0xJtv18tRR+zzysFOIx8V2DnQdg5+K0AV8t/F7ikb5Ojr3obF9J2b0Xy95zFyFJPtoxqWpXUB1bKyBoiQw6X+spNmrscGRwZ0LaEKp46EqFAh4NPpQZVLlAQEQvbbgbO2erm2A3i5oBWL4S1RVtYEGESYsiRWZM9mIrzpllmZFI1OH4JBI6/Q8dZFci5Mq/eUouHl0ZLi12gJN/Lvq13Y+pZLPKiPTJYALtsvaiX4lQdoSAQi24hMSHWAgBK95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:30 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 09/15] net: dsa: add NETC switch tag support
Date: Thu, 30 Apr 2026 10:49:39 +0800
Message-Id: <20260430024945.3413973-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8e62ba-c4b5-4fed-2507-08dea662f653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rMPZuC0vq8yU8LZmR0ZGpuVdvNz3qK30IU5n9bBCee+bbEi4UOK+sJG4MAKsnJoqX4CnRbPsIq0Tn8roTndUfxFYGpdkaOLamypBaNzNU65d2hse1i5jFnUmsxWmQyVri3OqKcny6p4AVUIHaFNBAwM9yjyTjxgBufzICuwTu+/GRUM03tCzc5D+tZKH8uePpjAgAOWj4TS1Fi+Mt3vhBBcgkom79NW4Jw9wc8pxxJaBRqaJyUjvIhvN6YgJxRmWAQBcjYt4erZvMgOEuFotwZeKJMyOodvgKLvlDOfs4lKVgvJfEGT3nbE7lxJdpgGY8XZxWvcIWDduAHimdqozZPEbt19XH8ejAPTH1qp3oh5ToZOTUUYsmrJA6tpdW5o+vXlgA4K68kuK0906Z6TOx4TlnkC7W7JF/HT+CUJpA6VJFNxDaqt7cOVRTEQrGoTQC5svHnuXM3SK7wt6fKxZBe6A3hFwLooxVGKsPMq39lJLLd3RBpRXt+HpHfHxp82+PU9TvY350SxD3TvYatwtqnX2T5BWtl2fativ6AZxrIpP7N6V3gqycHt8MsjdS7JsP4x6FN/r/YjvdXIavvJQt2uGM6zwv1feBmh9PNReiKePcWlsq74X0OPer1fH/2BoBs/AD5UjaeVDDLPibE2/pPfD2Qp2lFjKWDZ0supedVOb5slKPAEQDO0D/vGt5/VrnXK6gCFRqPRP3VizaClQriso46khkVPr3owhqnvmOqECb2+MZ+Zkyy+5JaTTDtUnnUyqVPljgwLu8t20BsHEItnXRdMLfCGtwAu4wkZIvY7m6Akq81X589yW6fi+OaW2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q0gzYkLd/g/xDKelKzMNKwvVqWK7Fow7QmcVaoB/W9OArFf9CIO128wLFYA1?=
 =?us-ascii?Q?iWwBwZtixKvZHTv1LohIfFdavboYVeMb6GSgtt9pz2Wk3TTzqGG8ySRKXS1b?=
 =?us-ascii?Q?aToZDTCoCBPv9dmsUbAiijjLM+WkvYIGDCAKt2f6alZisBOeIUyu5EN5+kb8?=
 =?us-ascii?Q?rJbH+yJtgVL463Ie0BSo7X54srIYebTmJu7+xhQ9JUEmf28al8B8oXexoGwp?=
 =?us-ascii?Q?8y3VYY/yioiUIJ6LfslZM/FOQBR90ZM0H5TxwDI6I296EDaETbYtcqEk/AzQ?=
 =?us-ascii?Q?jhWVT4qi6FHTvai0M04HN/EnShyua4BZpNsRQqkdGKhEE+fsaDsObmizbZgF?=
 =?us-ascii?Q?YpnVG0zwx2TmOlD2zA9dUMTmndtGcIubPxmQrED86nLtAmIag3kcmycvXjXM?=
 =?us-ascii?Q?Fp9BiwyPxQy8jKii+ldtVDXHFIAEji1f2H36DA91x3I9hKfR0gJWvwqaN26q?=
 =?us-ascii?Q?Q9U5/ocyPJ69+CpFOS/17Id4wnO/jJ71BNBOv9kmOEJx/sZVpNCgiEVvXQf5?=
 =?us-ascii?Q?42FxaIcNo8TxUFEPe/UU3/snUTHmT1oQ8vHdoCwtTDBh0sPw+RaXDqvLHCLO?=
 =?us-ascii?Q?l06I6Ab50Gnza08lLbqGnn78LTXMQggx/Sz3lJyq6nxPiTWFG/LnrLhRgnbM?=
 =?us-ascii?Q?HlS+2Rw6Pc+mq3wlFpaKAqwzppRMw7XsIx2CbmZDi0XtgA+wfWrJW1FeW6kI?=
 =?us-ascii?Q?rAwShb4zRvUWqgbjBESow3Xi1AG3hU5M1rTCMup4rClwn/4rxDHWPCFVvocc?=
 =?us-ascii?Q?BW8z5lviE48GJ1loEUNrVlxCUfEgtijlMgrxUuXwI4oGlVw2e3gX6hEFLxEi?=
 =?us-ascii?Q?yTEwW1Vjph/Zttvo3BLMlewSxrVj22BcsYzrOlw73FPFiKsBuuaejlSa67i/?=
 =?us-ascii?Q?zMNw65/rUqtPwxjmjfrmUrfWtpXPMpXxTFEtb6pJNg6ND708tsFYGXoHDyWT?=
 =?us-ascii?Q?EfiZdiMdUP9egJUYpDTrpPyyAQZzE4M7n/jgocf2cdlYWIu8m24eEgMtAYTv?=
 =?us-ascii?Q?T2v2HnxdcaB+mddoEqjq5s3vmI0KKiARJOt2qY0ZidKqukv+ppVFJWIn8QYc?=
 =?us-ascii?Q?4Dj+DEd3KjsWSSJ4OKAsAHiZRHhCr1rWFHT8eTWkns4Isspm/7GNFLcF3O7E?=
 =?us-ascii?Q?BiMNIdvcASndNII2SdOCFuN0c8DUtmsaizwlNMkaEmkydK/8hoBijkeOCzx3?=
 =?us-ascii?Q?cSSJZZUN6kYguf55tTU1XPofhlsZT6E5Clumafi4ChCXwEIaSrM+nq7lhwoc?=
 =?us-ascii?Q?UmovuHuGEFa6iXnOkNhtIl0mdZAgZXNfkF35WIPpNg71aZwVNNeF9a6i6/4p?=
 =?us-ascii?Q?+7lDTUkJzhKqo7P6oRqTSFHq1kG2zDI8ulGDX67rmoNzoBhra58E+ZrM6KeV?=
 =?us-ascii?Q?TYZrrVhVxlcMFJ0P7JiuSm1nenZWippifMJdPbOapkOBn/Qg4ioz/34OUOgM?=
 =?us-ascii?Q?QcIx7aq+Go/3u+SvnqMY3VFqtfo7xIJF/9fxy66knqElvAKj///bMqc6NCNG?=
 =?us-ascii?Q?lCCPL9l50/Imq0YELRQ7r3iPUfAlZnww0Zxk4Bg3lxWqHjQgOsnqK/7P6YBf?=
 =?us-ascii?Q?SLmWOrbGEvGlf1ObXGFcOR9bjC6mIf9EMDpUBgxJHbQkOXD96W67GiO89ll0?=
 =?us-ascii?Q?xtDFvjDv9GppG2plXmRWYnIdmxf9e+H9GGQoKiS2S74u3LWj0NYb4WS3zQuK?=
 =?us-ascii?Q?Cj/XdDarq62UQFobiqi6JJ8f9iPeimU3s4EtUhENHX/WpzzZLiqBhHnxYusV?=
 =?us-ascii?Q?SolQA6jZzQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8e62ba-c4b5-4fed-2507-08dea662f653
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:30.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15916DwJFks4zgARqv2DO6khSyjQkNP1n4Ss9vLqm5QYYiMCxlYL1olrJWTVyxVjto2BlWfCEqv4K5ONgGNa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608
X-Rspamd-Queue-Id: 8D00F49C7EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-282623-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]

The NXP NETC switch tag is a proprietary header added to frames after the
source MAC address. The switch tag has 3 types, and each type has 1 ~ 4
subtypes, the details are as follows.

Forward NXP switch tag (Type=0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port NXP switch tag (Type=1): Represents frames that are to be sent
to a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host NXP switch tag (Type=2): Represents frames redirected or copied
to the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
    management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

In addition, the length of different type switch tag is different, the
minimum length is 6 bytes, the maximum length is 14 bytes. Currently,
Forward tag, SubType 0 of To_Port tag and Subtype 0 of To_Host tag are
supported. More tags will be supported in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 include/linux/dsa/tag_netc.h  |  14 +++
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |  10 ++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_netc.c            | 193 ++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+)
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
new file mode 100644
index 000000000000..fe964722e5b0
--- /dev/null
+++ b/include/linux/dsa/tag_netc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __NET_DSA_TAG_NETC_H
+#define __NET_DSA_TAG_NETC_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#define NETC_TAG_MAX_LEN			14
+
+#endif
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8b6d34e8a6f0..f199781594db 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_NETC_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index df9d44a11540..fb5efc8e06cc 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -123,6 +123,7 @@
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_NXP_NETC  0xFD3A		/* NXP NETC DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 
 #define ETH_P_802_3_MIN	0x0600		/* If the value in the ethernet type is more than this value
 					 * then the frame is Ethernet II. Else it is 802.3 */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..d5e725b90d78 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -125,6 +125,16 @@ config NET_DSA_TAG_KSZ
 	  Say Y if you want to enable support for tagging frames for the
 	  Microchip 8795/937x/9477/9893 families of switches.
 
+config NET_DSA_TAG_NETC
+	tristate "Tag driver for NXP NETC switches"
+	help
+	  Say Y or M if you want to enable support for the NXP Switch Tag (NST),
+	  as implemented by NXP NETC switches having version 4.3 or later. The
+	  switch tag is a proprietary header added to frames after the source
+	  MAC address, it has 3 types and each type has different subtypes, so
+	  its length depends on the type and subtype of the tag, the maximum
+	  length is 14 bytes.
+
 config NET_DSA_TAG_OCELOT
 	tristate "Tag driver for Ocelot family of switches, using NPI port"
 	select PACKING
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..b8c2667cd14a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
+obj-$(CONFIG_NET_DSA_TAG_NETC) += tag_netc.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
new file mode 100644
index 000000000000..c2e4aa7e5ec2
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/dsa/tag_netc.h>
+
+#include "tag.h"
+
+#define NETC_NAME			"nxp_netc"
+
+/* Forward NXP switch tag */
+#define NETC_TAG_FORWARD		0
+
+/* To_Port NXP switch tag */
+#define NETC_TAG_TO_PORT		1
+/* SubType0: No request to perform timestamping */
+#define NETC_TAG_TP_SUBTYPE0		0
+
+/* To_Host NXP switch tag */
+#define NETC_TAG_TO_HOST		2
+/* SubType0: frames redirected or copied to CPU port */
+#define NETC_TAG_TH_SUBTYPE0		0
+/* SubType1: frames redirected or copied to CPU port with timestamp */
+#define NETC_TAG_TH_SUBTYPE1		1
+/* SubType2: Transmit timestamp response (two-step timestamping) */
+#define NETC_TAG_TH_SUBTYPE2		2
+
+/* NETC switch tag lengths */
+#define NETC_TAG_FORWARD_LEN		6
+#define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE1_LEN	14
+#define NETC_TAG_TH_SUBTYPE2_LEN	14
+#define NETC_TAG_CMN_LEN		5
+
+#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
+#define NETC_TAG_TYPE			GENMASK(7, 4)
+#define NETC_TAG_QV			BIT(0)
+#define NETC_TAG_IPV			GENMASK(4, 2)
+#define NETC_TAG_SWITCH			GENMASK(2, 0)
+#define NETC_TAG_PORT			GENMASK(7, 3)
+
+struct netc_tag_cmn {
+	__be16 tpid;
+	u8 type;
+	u8 qos;
+	u8 switch_port;
+} __packed;
+
+static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
+				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
+{
+	tag->tpid = htons(ETH_P_NXP_NETC);
+	tag->type = FIELD_PREP(NETC_TAG_TYPE, type) |
+		    FIELD_PREP(NETC_TAG_SUBTYPE, subtype);
+	tag->qos = NETC_TAG_QV | FIELD_PREP(NETC_TAG_IPV, ipv);
+	tag->switch_port = FIELD_PREP(NETC_TAG_SWITCH, sw_id) |
+			   FIELD_PREP(NETC_TAG_PORT, port);
+}
+
+static void *netc_fill_common_tp_tag(struct sk_buff *skb,
+				     struct net_device *ndev,
+				     u8 subtype, int tag_len)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	u16 queue = skb_get_queue_mapping(skb);
+	s8 ipv = netdev_txq_to_tc(ndev, queue);
+	void *tag;
+
+	if (unlikely(ipv < 0))
+		ipv = 0;
+
+	skb_push(skb, tag_len);
+	dsa_alloc_etype_header(skb, tag_len);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
+	/* As 'dsa,member' is a required property for NETC switch, the
+	 * member is used to specify the switch ID (thus the hardware
+	 * switch ID and the software switch ID are consistent), which
+	 * is a non-zero value, so dp->ds->index will not 0 here.
+	 */
+	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
+			     dp->ds->index, dp->index, ipv);
+
+	return tag;
+}
+
+static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE0,
+				NETC_TAG_TP_SUBTYPE0_LEN);
+}
+
+/* Currently only support To_Port tag, subtype 0 */
+static struct sk_buff *netc_xmit(struct sk_buff *skb,
+				 struct net_device *ndev)
+{
+	netc_fill_tp_tag_subtype0(skb, ndev);
+
+	return skb;
+}
+
+static int netc_get_rx_tag_len(int rx_type)
+{
+	int type = FIELD_GET(NETC_TAG_TYPE, rx_type);
+
+	if (type == NETC_TAG_TO_HOST) {
+		u8 subtype = rx_type & NETC_TAG_SUBTYPE;
+
+		if (subtype == NETC_TAG_TH_SUBTYPE1)
+			return NETC_TAG_TH_SUBTYPE1_LEN;
+		else if (subtype == NETC_TAG_TH_SUBTYPE2)
+			return NETC_TAG_TH_SUBTYPE2_LEN;
+		else
+			return NETC_TAG_TH_SUBTYPE0_LEN;
+	}
+
+	return NETC_TAG_FORWARD_LEN;
+}
+
+static struct sk_buff *netc_rcv(struct sk_buff *skb,
+				struct net_device *ndev)
+{
+	struct netc_tag_cmn *tag_cmn;
+	int tag_len, sw_id, port;
+
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+		return NULL;
+
+	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
+	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
+		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
+				     ntohs(tag_cmn->tpid));
+
+		return NULL;
+	}
+
+	if (tag_cmn->qos & NETC_TAG_QV)
+		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
+
+	sw_id = FIELD_GET(NETC_TAG_SWITCH, tag_cmn->switch_port);
+	/* ENETC VEPA switch ID (0) is not supported yet */
+	if (!sw_id) {
+		dev_warn_ratelimited(&ndev->dev,
+				     "VEPA switch ID is not supported yet\n");
+
+		return NULL;
+	}
+
+	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
+	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
+	if (!skb->dev)
+		return NULL;
+
+	if (tag_cmn->type == NETC_TAG_FORWARD)
+		dsa_default_offload_fwd_mark(skb);
+
+	/* Remove Switch tag from the frame */
+	skb_pull_rcsum(skb, tag_len);
+	dsa_strip_etype_header(skb, tag_len);
+
+	return skb;
+}
+
+static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+			      int *offset)
+{
+	struct netc_tag_cmn *tag_cmn = (struct netc_tag_cmn *)(skb->data - 2);
+	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
+	*offset = tag_len;
+	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
+}
+
+static const struct dsa_device_ops netc_netdev_ops = {
+	.name			= NETC_NAME,
+	.proto			= DSA_TAG_PROTO_NETC,
+	.xmit			= netc_xmit,
+	.rcv			= netc_rcv,
+	.needed_headroom	= NETC_TAG_MAX_LEN,
+	.flow_dissect		= netc_flow_dissect,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_NETC, NETC_NAME);
+module_dsa_tag_driver(netc_netdev_ops);
-- 
2.34.1



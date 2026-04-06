Return-Path: <netdev+bounces-275746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPFNCU4k1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D23E3A7851
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3ADA33014A1F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98B3932EC;
	Mon,  6 Apr 2026 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j2CyNY9e"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CC39182D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510543; cv=fail; b=mwN39vg/f9cu+rxh/QVFD/tL5JRJXumx6K6lADovHI+K9JEmnCvyH2XM4ErjHLnmqCewST1tevV7Xsp9KAM9rQmN+liabt/AbAGszOs/cuLoQ3NIKG4jUQVFz2xc03P0qI16iy8GavJeXQhoEmFOg+Vu2oBtRBVcA3wpi4sOPU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510543; c=relaxed/simple;
	bh=l2B7c5uruU5gT9liDl13W++nka/IkKdg4LLp4I+aC3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xd0u9iwrNKwpmUWfQz9FDmDk8wFr6R2osVzL1Y8UbFUND6ZtwGD2vJJGIM/TUCBHvl4zmpd0m7oFxm7+PNzh6dBmjQm6dxm8+4uIv71NTvBVE8JuMalW7b0DdClmOMZpUHcJJU4T+qWNTTxgAgk/8BB+HRRvFIaqSQOQaYCeuug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j2CyNY9e; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLocZQ6blztlzB08+AATssL3cPh75BaGoytE3E/+8t1KgDjvtDclvJoByDH2h6iS4mC/MJuhVGFapQb/zsdYxOYxLLf/9gGug1Vx9ivlWFc/XVHU1F9BvYFGE3nrXzcGd9NECyv6Kv67Vh4n5fdabVqRHw/9JYOxzFuV4/VzEOWhyzFQM8vc5PbG2kEMHGcZTH1HIbTRfC8nnDpy2MN6HUpuNZQvVR8rJ+kqh5JUrMaAIV4M5ugNCf9rFfr18MuDjnqQ/JkJMjWQj18IEkd5aSeewiQbI17kq7Tpcy9sXashoaUWGEkcDx1n41cc49RMHQTZo4EOFZ9/F+z77SO6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8SknybJ0Z3S8crQzcFsWyjJeEuHQ3OiASPXTGSdFus=;
 b=bvupggPjn78Zc1X5mXWAElzcA8AKgyWVEUNKaecCMeWukjcm0wTHbV+BxJr1uVIFQCXGAYKh/2gDS7z+31xU9cPHQVu0jC1xFL4fkDtp0IC3IrrKK9o5e9W6JjAAt0wPHoQTFIuJQc7RwqAr6r38b2kqhilpz7FBk97N7t3r4Z6HmQqfef4NQh33oViCnnjCKJcPLCjPwWHb8OTPBaQAjBblOFhOhKU0006MCBUK3oJ7MHarx9bfmsUMEaEC3YVPFjI4+AqipbvMeBPPjr3UfGL1860iExOyYVNuIEpWU3i6I3L8cJPAUT0WrZ1H4XWQmd0x61bqSuaqLXeu4hwd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8SknybJ0Z3S8crQzcFsWyjJeEuHQ3OiASPXTGSdFus=;
 b=j2CyNY9eKdd/szD3bZe7+rFyODuGqe4AWZYLAGjQ8lreHbyCuDgPcTZXKhxfFidvLYUB8eEfn10o1E/DzVGzBaQkEeRJZLXr6OpjTpI29SYOXsKs5F8cXhW01LsTWIEHZSWE8U0X/1XiDrW1egpVVKsWniRuwlE7tMFOWnD4S6I4gQqXis2ueSz8ZhG+qHNttuBK8Mq6XzU4tP0NOYA4ahJdR8KKbR1gSOeoPHIPU9gsraWs1wGoR6JG/SeuaVsZ1dv0nLwXSnnzAXeoggxMQcrff0/x0Mu6GjD+JMuRCetBQKBoYib8P0bT2uu6AH7G+0YxI1+f7hmUvlvlrJCAyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 6 Apr
 2026 21:22:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 21:22:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 3/4] net: dsa: remove unused platform_data definitions
Date: Tue,  7 Apr 2026 00:21:57 +0300
Message-ID: <20260406212158.721806-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406212158.721806-1-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ccc7ac-3fca-4541-61b1-08de9422937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RMwJmvTwlFu5mXj9uDi37JIB5Zg9m+HVvJjnVJqrFNKqU7TikVzF5s+vw+leEy+6SNQatPTYsH86NhgQmG3hVtkZgwiyVaKiKb5LyNqi0+FuMLPqrGzNUDCmJkH5Z3RgiabcgWA5PG/9HxdE7oV392dpfM0As3ofl7DlSud5C8vgmtXskVW+uik1uy8ZVMBKQ48MbzvDh7Meix1+N+htTk05rbt+G2EVMNET+uby34My0qwGRlsZX792+H9tdXmzFGYxVj0kMQrJvCuL0QYzNdoivNX3StiEDgHgOMHerPtWb4Nj5Hb3jQVq2dHw7J0dAy7U0V+VcgiUd0flc9puFjHmWZZceb9mbc9w1MyJg0rij9emLoYTtSvT3YRa1hTP3RtLZAPvcZvmxyLHrHvcvir0J5XJ7FwaTNyAWpVizuzlw7Y8gG9/h4skWxSX/nNE8wuz9T7zRbTktlS2flf5GSj5Z4mtn6budr5aHUmaNLiYlj7AoCYT02NgZhAj4sOMUBi26G+pQd/K4qeYTITfodu5b0ROITEyC5mbGQwE16VZw5Q7BraQadLFE+RdpYPBoAKvb6gBJmCYazwabKb4eoTNgiSyTqBAMmRjdQm1vDNo3LreJZ6nrwEmnxTu/ZjtokAkiJjrL+fJKvbCls4mwbIDBgRZuhCQoQN16+HcoiFFh6RanXdvu2gNqTDB4cEfwB3Bmo4XDdQ39a9sldqFNLJbJj8m8NIHTHJEK0oMCDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuR6ZwuI14LwCwAoZeI7IwAxgGuSFcerXdrfDK6uD4778rCSLR29oqDWGfHD?=
 =?us-ascii?Q?BoK4SBdzdFQ97hqbBYRTM1XxD1SavkrjO7z+hJ7Nbw2dhO9FMr0Ek2NHxvsI?=
 =?us-ascii?Q?AvGCF1CvQ6d66ORbhqJ1j0YPMK4c9C9G/tdPzrzIshvCLrelQt3a3SchI7BS?=
 =?us-ascii?Q?b5Ujv5x5F+6c6o9zuBqW+yq758bcYsrFliwaKI7DK74AbPLF4dieSbU1GGTn?=
 =?us-ascii?Q?10nIXEt1nXKaq9k5LtcFyfaXVzy0yL8/1Bi3ziGzniPJE+Q+S/i8tt2ueC/I?=
 =?us-ascii?Q?pZTzL0EZv7j+q/JhuboTszG0hpr+Rd4fFb8EomB0QPbGbm04aVV0ega7w7YL?=
 =?us-ascii?Q?z5L6HFELiuJl2H35NELR/EOJLu727VlH9hzwU9g0BZyKN6up0R0gnKa+05pl?=
 =?us-ascii?Q?CHaN88iUzdIm2DIEfXTSTqobO6k/2tNfYJgY+xn1xfM/HE++iA1+D7CkAWLV?=
 =?us-ascii?Q?J7aDv5+4T+HaxBqHzQDLKQbUjynzWlR5YWT9FM1xZIquzOfOcOLhbZX+lrIp?=
 =?us-ascii?Q?oVH3shBvE6cMPnOCNMDmE30ImD7JreopHtNnoXWDZpf4YlFyTN/yZg/xIkE1?=
 =?us-ascii?Q?Z8+YvpWWaiowA72BgKr2JCTH1+Z3raVo43LlMOvgiyOii1jt7T09jEAiCd0B?=
 =?us-ascii?Q?AgDMF+pJ9Tnl29SFEqzxA5hzVw3HDpKODRijzEP34HP6Ar5vmjpHMf3UsRxt?=
 =?us-ascii?Q?yEOwuJQzw0GZk50IX3YclW3Ro1uPwTAOwM0ejtQJCHXL4hYjDqqA72HgWlVH?=
 =?us-ascii?Q?6k/k1STcV6+BvXZuLfOU/s3a2PjwzI/DN9nTRdp0ZaE17/ziP7vTvnbdqh8s?=
 =?us-ascii?Q?boHLoxdusbONbPCHT2fTCUDZrXV8MGXfFCUQDAeEgiXnOuRjMzlEq0SxPaLL?=
 =?us-ascii?Q?EQh+yU7e3zXXPCRRroUalimxnbXswhU0XXwEJUMVg1a9ppOn7kVIUINHnpnw?=
 =?us-ascii?Q?FXP8gVEtTNFb/u5NNTRBOaaRaqV75b/HQ0zx3R1934WK8wxANh393BxwDFXW?=
 =?us-ascii?Q?wHsX6EchNBO1HCxtrIpwFBAd+wO9z0J82AMsgpOKKBalL0DthOabUNLtiRui?=
 =?us-ascii?Q?f9T0Suaj3iu/sVNnnZt5D8+whjqgnZxR7R/COvDGjzy969bJ/pAR5MzzSmX4?=
 =?us-ascii?Q?ACAylUXcEjEXWazbVMBa/tKquDKGSdAJUMpN8Q0qvsbYPiPEMQGpL3yg53jC?=
 =?us-ascii?Q?1VW4k1CmD9EgGb3YCTWWOBq8NqW4HTg3VnXtMjnmVc3lWMUpr0WJG0kITt87?=
 =?us-ascii?Q?I+oSC3dFBWtveVYC5yHiAdUAlyhcBJMS5ktenuGIMLW3pdP42tW+62pOKYm/?=
 =?us-ascii?Q?7DgdZ9WAakED4hOADe2DghCPh46b3FOj5tUg5qyJbaczJ+2i56o1WYy8LQv1?=
 =?us-ascii?Q?cl996Y5XN6d1FH1jTkCOCUvaCdl58Eoyq723SmYIql6I+jDyFAxvRuhkyV/r?=
 =?us-ascii?Q?WW0tgSeH+tLNJZjcK1pmF2HiC4gbjW6DzcIpS4LKSHuSoH5fQ1CUYuEw5n44?=
 =?us-ascii?Q?NDvNOVrD/Rf0stnAcoBF/ifsTeJpO5GGwd4XPFXPoz/ycJvIWqhKxpKbPbUp?=
 =?us-ascii?Q?8QQZYkWF4TRSu8IU6+7wJMkPZm3y3/xZ5CYa5xUDq1bnYIJXMvGjfTWYS4Vq?=
 =?us-ascii?Q?R+zfq21nwhnGy0O6FJ5crq42Eu7UMqAuWB3OuCNzQA5E+LLt/2Trhm51Ugge?=
 =?us-ascii?Q?FdCUoIotvInJZ/dFIhSx/97nAbryZq1FKPxYdHy4I2dEJRhaNDb+DFJmN0Hk?=
 =?us-ascii?Q?bBwBIZL+eimy4Dxe2rmqTYMJy2tCQLkU+XevnGPhkk6+CAjCyWb7np7nO80s?=
X-MS-Exchange-AntiSpam-MessageData-1: EB1vvVZSPgVbCi6LATPzB8fHRoKlzpxxIiA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ccc7ac-3fca-4541-61b1-08de9422937e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:22:15.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ7+Pel6kGRkRfw2gE1kK3A/SYnuMobIqVzXsAA6ss2TspxA51NU0ODvFoFUXupthbmhSuGBpjBrNQ+o7VGM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275746-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 2D23E3A7851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pretty self-explanatory, nobody needs these.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/platform_data/dsa.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/platform_data/dsa.h b/include/linux/platform_data/dsa.h
index 031f4cf83ae2..77424bb24723 100644
--- a/include/linux/platform_data/dsa.h
+++ b/include/linux/platform_data/dsa.h
@@ -3,11 +3,8 @@
 #define __DSA_PDATA_H
 
 struct device;
-struct net_device;
 
-#define DSA_MAX_SWITCHES	4
 #define DSA_MAX_PORTS		12
-#define DSA_RTABLE_NONE		-1
 
 struct dsa_chip_data {
 	/*
-- 
2.43.0



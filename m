Return-Path: <netdev+bounces-266539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDgbOF8ssWkBrgIAu9opvQ
	(envelope-from <netdev+bounces-266539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:48:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C925FA8E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BF23424DA5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E533BD237;
	Wed, 11 Mar 2026 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGFG922z"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7A3B9D8C;
	Wed, 11 Mar 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218362; cv=fail; b=NvMV3J05XbW5YJ+ROOUV8JymsRR6OVHgksMy3cVbdp7MLgOBkIs+LU6YlRxtM5IPPK6093VVzvbXWNQvqS+P30SSoCgNsdccGoiLVRTyTyXtED3oJNtGsi4z261Sgrsm/g5Uq0piZVn0WHdBSpODOAFaqCbutNlx17jAtQes47c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218362; c=relaxed/simple;
	bh=B6qzTPC1OaEFnXUm6ZBCoFu+VgqvyQaFJyKdGQI/rKo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RKOk8ZeboItvvrb/dTYerHrhz213cTw4yqAv8K4okxV/lGT1lfiI0DytyuU+gAW0ByZ2D7hIFy2d7yljY/SxZNVXs5EKBkNTIxAS9JqBJ2v+exeBq1SglYJ4yaoOyd5im7HSXbY5MoCPo+vWGx9Tpc8RUOefk4R6Hv4jIkrErm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lGFG922z; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMr8y+XJalULOfuB2ZXK8uv9hwpPdoTLLAmcHnPLuH6AkvXFDkZbDjpE1fdXLZssQHnwd/QV5SGalbrmO72uLL5tjh4CGqcOAH6SEsunQFANjGG59yjabBVLCcg908cF5ajvgEw2QxI1fMP85m7F/KKaAXPWPFqOoPMil4mvBpt0yt9embe/JgtbQ0afflPM0ykWKvuOYMDnkqClBDHjFVZVYEu1AyIT3fOqc7iOvf3i+w2FUXVa7GZRuRlbxSw4dITCmjQvHM1vhdyEXjrJbE7YYlabq5wjkoklbwn/h1OCx4X8P3WERlm0lz+ZP7cEqqJz9uxj+bTGZRNAT88FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Zo19qZU/I1ZbzM+hYjoOAF6CchBhlS+fXhvcs3BXs=;
 b=nwMWGiBKxz0Qw25MgaFLSe0FMUH1s2+USpZi/ixpta2H3btac5EbQVhfarsIrg4H795cLAV+Hvkr1Fn9GlPkdLa3GG+UAAJ6zYjIEtn+Pw5NqUcKah+9CWEmde6/nIAWFlQg1i/tw0KF2Q93vi5Mms0dzBsVpiFk83ExLe2PLyJbdsqnm6gjND5J1z/gbeU9zBGtgEdlrVS/bU0bxUwvi9S9n5uVo8WmCEogmcr5AELa1mNnYxhQm1/uGJYoh537k3eZqq37WJPV2/FR1jnKKB+vXIheAKLQSmI7KzDGTxlCLb53KlKmT4vWbgMmc/CozIkyUooFF2AGJ5YbSk+22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20Zo19qZU/I1ZbzM+hYjoOAF6CchBhlS+fXhvcs3BXs=;
 b=lGFG922zS9ElvYmq+/IqAG5FvSec3medNcDsCBKHBOpJEGrGuLhDtPo8N+jlInHuF3raTPxq+yUYSJW0Xp1B/awBijv4tb1aDCqbYA0QxzvEAbCzopvzLQY4Wvlf6Z8jebm1ugOHJQL5vVlE0NB52Oko3D3EQc+VDdxKZ9jnR21snMBjeP/unDS75KT8ELjG88ZCpH6Ik2gVMAwCRRQIjM3IrYiAWd5bwEgFkAkmyrJHo91g7WomnwUUenILDlN+ShHyq40YH8v419mh9f2MT6o1D8FLFLupGPkbxCcbQQJQZBu6rCLVveFoX3CS2J8/uGvz1rsZHQA2fNpQeOVmxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB11624.eurprd04.prod.outlook.com (2603:10a6:102:50a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 08:39:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:39:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net 0/2] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Wed, 11 Mar 2026 16:41:03 +0800
Message-Id: <20260311084105.3982037-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB11624:EE_
X-MS-Office365-Filtering-Correlation-Id: e9506c3e-31dd-495a-eea1-08de7f49adca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yuPDpAg4bO3iKzH4hch7Okpt2pKFbU/XmQfhvqUuWkT20Ypw0PbHEHyKaI3niXPCnKlxzNJFvN/iNaFiTIPScHEf56HfrWPVVYAmWSPQW/gMOmq/f7ppu21lx0JV+4z8lzb5YVTSrbWVMzWHJeFuFNXwVNot9m8aWeYBj98xrQlLX3rItmETWUf3fkrIvk16OclbQFyGlHmd4xklJoQ9wDtLyEnz5B7jwn8HpB8DxrjPjpGEnAjgXBn20VGXAuxnKdqQhxuvK0yOb+s8qsDRuN0CTcmD5b2QRu4TMQ34pggEvvEQREw4tvd50daOhI8ZJSgBY/8lxeM0xxWnRWSlT7bIacI8AbLN9xE9tYc5fb4XNFp2HTdPeSvyri0HVnAPhV2dSn8tq1qOKJ1zgRZlLnaUxr4dOaMX9FDWxHoGub6eM/lpGp1xvO0hFSuAZw98iOtafXvf0ooVujCaNM6v64AnHyM5YCesoNFRIXHx9C4ZmJg2I3+RacHlF6xm5VYloEfQ9Yi7mYwHH+Rk9bVa/BsxY8bxPYGbeRI7HSvaDyivgSf9OVPvr4yENYz1g32a0wLBqDNdR2TWiIrP9/VwAkfYCQTSroMogWfH1mrKfPrvnxE92WkPwvYsqFfGa3hmcyBOx80LqRekzxpTXq9vqYTQvAFKjJ2GBHo0r4rXZYbnrivSVlB+BBnsyTn+1OaRoL/D0+LP5KY+Q2EQA9eTL00pETR88k7U2XZooTvrMOhPbj0N70xwqfL9juogEUg8Q9BfLjnDI8OK7q6EWeURm7dYqobe6OJ/Ap2cXcpO5p5zY54IbZrdtZ4zYrlX4lnP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4SVNFccIX1VatPcO3rwotFXG3Qx+9hrn9zkfrBrz8R1wKoM8nQSFIHpoFlgC?=
 =?us-ascii?Q?2Dmn1I0ERWjllGWaPOvAbU6OJxReq/XFZ3AK1Mkr8YbsIc8Makp+rxCw9+Ka?=
 =?us-ascii?Q?AxEfsJuDT9EqASvRFTG2bLpf/KkcCZZTwKddHrDhrtaCRxKM8q/zBGfGa8UN?=
 =?us-ascii?Q?e2ZqLnUXyplbB2sv7+rkETFXZBQSsBv3QPdbp0DqO6kYbHnIzUAv/4wUpeH6?=
 =?us-ascii?Q?vSp8xkSHY89VnCeUoJ4qevONeWQ72ojPcYudovbWEPHDSOXyjsuaE/k4UsJ3?=
 =?us-ascii?Q?AmkSV5XhAUG9NorlXJl8325/bZn5/fLtKtrf+Jw9VHNGtZloL0FbBGvMuZoK?=
 =?us-ascii?Q?ftFR8Lj5fAVsnDckdi1MP5e36M4TVnvVCvwYTZQJKvjMwjV0VV2Q2oD9nDMe?=
 =?us-ascii?Q?syOQgiDuA80PEXvh5bgvGIZb5G379A/mKbrDcB0jCcOWalJrDa40VAnII2+Q?=
 =?us-ascii?Q?ou4IajJidgDlHiQkARllRScU6ZypxRJjU2R3hmNFLxhOgaVIWjV1/IJ77c/i?=
 =?us-ascii?Q?OCYkWJACYzIdIzmmTC/GZJem/zMJyIrOFSXM7KwSGRTPFfFH7SRvZ259xtEi?=
 =?us-ascii?Q?Z6opF0i9w6Y6LHkR9GgkWRgorX3IOjw8WjGMK8dlAzxQ7mmDeZLvV5WIrhcP?=
 =?us-ascii?Q?anBO04Hya7kpWVpTWD1k3nFDx2amsxTIrf4IjX9KJu3HTgEUIbkA2LRxc734?=
 =?us-ascii?Q?A3Eff81oNJJlTnW3zOLVsq5jerw++6HBeYki/Wzjsg5CunShlBW1U++4Gq1a?=
 =?us-ascii?Q?/nSMDVcR1pg6MBi7KVd7Y0DLAehQO/3OaMueg7eAwfKEcM2JL+PwQ0gIpqNR?=
 =?us-ascii?Q?QnKWiIIoO0hnk63cDIeTxGd6vPnTcIf1w/6rlTizMQh339HSrSXhHutyFKjx?=
 =?us-ascii?Q?Tk/KlSekQKRqEci9IpxoZOwfEMHfpqusyGnU5X4eqi7mxF/BvdadFggBYC5o?=
 =?us-ascii?Q?k3HUyZ8QCvInLJ662z9XApl/VBulTNMLUL4r23RpsHfu9EkZAJFTfMPFMrK8?=
 =?us-ascii?Q?R7dZGifbFQSopSVc1PEsu0fzV+6q6r6CzhbyGwuaR76q3hB8R1Jfahk0PfvD?=
 =?us-ascii?Q?crb9bIquLfGljh8SZGj91jCuCMp3jULM2LrqkBqw+NAQvxhAxJTVVEDLvtZp?=
 =?us-ascii?Q?YIJFislkJszW1E10W4/CsOkrmB0Df9T6I9Gmv+Exnc0CM+rk71XPexfj7DPn?=
 =?us-ascii?Q?NovjAE0vPbxB0du9pIbVt5640qbB059E4hUDBp1qoe2CUASL2Y+8PMNRmH/E?=
 =?us-ascii?Q?AiKJPQKxfCrB8DNM6XZCm1CK/3Uwko2nlVK5gC9O7DFa7CGYqJRDbgaNSfp/?=
 =?us-ascii?Q?lUcz0Ygkb+Nzqpepeyfz/Vgxi24uAHfhj4A5APcWupDrgotWsaGqK9GKQ4mn?=
 =?us-ascii?Q?DZhVdzrtqgc3E5QK6SLcqMni6aDuSo7hPtPJ86rmvCJ92qNj+q1YhKnn4MEo?=
 =?us-ascii?Q?iW/zHcb5CHL9CBborHrXVROfPtT3idWI9M59kuOiocSiYVOlJSQTDDD4TbWS?=
 =?us-ascii?Q?YIq5BHxZ7WLuJxIfgnYsGwECGCMFTeFWXiegrpRYcTGqVrtUHuJNPtye3WLT?=
 =?us-ascii?Q?2x6yYRAw4yAUT6XHMzveSy6zflu3ydD2jr3dL7vkblQq3nBGW9/XTji9fuCD?=
 =?us-ascii?Q?l1lmrVf2nkB/R3k8Pcmf7Hn2CTpe+P3pdEpHIjz36e2qmS934lKo7ldohLd7?=
 =?us-ascii?Q?D5aAp+99OXmkKQCHRt7MFQM1gV4RpqDxfvHM8kTLszVK0LJP98AKOLN2VAg3?=
 =?us-ascii?Q?GIKOEOFpxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9506c3e-31dd-495a-eea1-08de7f49adca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:39:16.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPiK4Xih9iPIt/ZnVEkhLGvwvQXtC1AdjnjX6E+k+JNE6YhAO92rJE74EaqJu40IcWGDRLhXAwCaesQAUVntBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11624
X-Rspamd-Queue-Id: 692C925FA8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266539-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work perperly.

Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
the driver must reset them if they are not equal when reinitializing
the TX BD ring.

However, resetting the PIR and CIR alone is insufficient, it cannot
completely solve the problem. When a link-down event occurs while the TX
BD ring is transmitting frames, subsequent reinitialization of the TX BD
ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
not safe to reinitialize the TX BD ring at this point.

To safely reinitialize the TX BD ring after a link-down event, we checked
with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
Therefore, add the Ethernet MAC graceful stop to the link-down event
handler enetc4_pl_mac_link_down(). Note that this patch set is not
applicable to ENETC v1 (LS1028A).

---
v3:
1. Split the v2 patch into two parts
2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
3. Use read_poll_timeout() instead of the while loop
v2 link: https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
v2:
1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
---

Wei Fang (2):
  net: enetc: reset PIR and CIR if they are not equal when initializing
    TX ring
  net: enetc: add graceful stop to safely reinitialize the TX Ring

 drivers/net/ethernet/freescale/enetc/enetc.c  |  13 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
 3 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.34.1



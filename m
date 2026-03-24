Return-Path: <netdev+bounces-270889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBj/CtItwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53242302C8A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88FC63024EC5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EBA3B3895;
	Tue, 24 Mar 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHWEQiXF"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD933B27EB;
	Tue, 24 Mar 2026 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333175; cv=fail; b=jvCwTdQbl69z2ZKptiMhQHMHwAEy1NrAGXRfNOQcCEH/9oT91RPN1XThX2O6CRWjxM/q/PMFGvnrY17Ak+skOkm4KCvWw/bQ19ztZkIdOvlneQfiFsaMmGpqgfTxaodOPF4ao6LVwh6DeDMmkXvxMdLzMCvtBp8gzeIE8Fxi/QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333175; c=relaxed/simple;
	bh=TsM1d9LpRniQ9BMMXrC6lxKuIIhBYaJfoGCmvD7Zf8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xwp3YiiYWvTKd7kQjuIi9Kebd9f1GXsRGJ8pq7oWh1h0C6p4fzVgNH1d5ipblQjmfORxa5/A/uYCL16WWtgibGK7Q7ESmZFCjbiXXEPEZ9aESwAKXPMhJvcg4UK9+PKjg9cEU/diPA68w8rgLPjjnUt2VhhEll6czamPY8A6pWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHWEQiXF; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBjpO6s3BDd4x6PHSQeTT8W631jqxNksIQSI+Hu0CcdI8LIkqaR21sbRD6pXJJbdyBDeA7euNfQOfzsUhxHZg2y0YP5NaIzdlkR1aRLmczkNVencRjK2moBTxiXKhJeQfKetMwYdbAu+isjkBfZ6WvO0HKRwl/BU0mJdGFO+AqNkzyrkLjM49wqikFnhlreyyAOmj2tdnRujKt90BAN2HecOuq2xwjDHYcCOL8bAmpYQIZNszG2wRmuoVmshqsYSpi0gcfrK9OwaLrSFd+hirvzJsYy/tmytsdhfDr3tAa5GaBBFXj+ZFPD/VMKqG/FQgBTVg6qtbSinvVrkO8whqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MNSZInjLtx3QPY6fpAmfhDr9zq0NRaBwyRNui4MGOY=;
 b=pYQ7ZPKW/oZ8yMtD4zZPst6rJn0+5OZVctCluB3TCEQxHOQDCk4OU3OSL/E2LZT3ub6/u0Qb6EKALN2ZznvKx02CxK2yNrakOXgF/XUq+MLIEU7CeQrIZ8TeaSST35UGgMApexRCR/O701DCqNT1La/NI+f59mWo+4OJGKXxiAMk0oOREG5F+ZWsbBAgBd4lp07v39RxnsJwfqsnVohQNLL+IKh3iy+qoP8KLYN0fILCAwkfSn6iHtgo1W7f339wjZMbybhSjtHCOcoSlL7QTxPQ8VVua2nvKXBoBucrVzjPP8Pnl2Xp2RxNgwMlURTopD0vJ7PaF4Ne7nkEmSMTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MNSZInjLtx3QPY6fpAmfhDr9zq0NRaBwyRNui4MGOY=;
 b=iHWEQiXFhAHQ7bKzAX9h8nxGYeSRni1PdGAtKEI/tdM2Z03O3VoCbRLd9osjZe5zEKEZ2UTEaBGzGZXb0hTl9SO/9kHz/O7+aOXopVR/2i0mw283hfbe7Z5Eg7nwO8z3UPwLQ/SDqsAeyrlIrmAkSedcq7ISutXRe/b7ax1Nmmm/U/7LYB0waClH+uT5t0j688Jc9M6NnS6Z1MV9XeDblwiReUZzl/MJfviJBjJz+NerFJlWFIsIPUT0O70Dgmzd8qFdd5n3fgd5R9M96j2opqDkWLDgcOZq++qQcv6Qsi6GX4q8N9v/mKqVkHe6wS7IyyEwHpyX7J9p+A0HiEMxmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 06:19:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:19:26 +0000
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
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 RESEND net 1/3] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
Date: Tue, 24 Mar 2026 14:21:19 +0800
Message-Id: <20260324062121.2745033-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324062121.2745033-1-wei.fang@nxp.com>
References: <20260324062121.2745033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8539dbd1-9b40-487a-ac76-08de896d4c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nvxPCnBnsw4r+0aXCxoqaxKBoiTbkGGJ6ovIGmNr/4YxT8ioX/8nlU9fk7mRrM5Xyy+KbneXmV0s7MJ5hAtfzdhcMDRNuT+f5y6S9svaaimO1zV6PDrqfv62R8iA6fS88dtnhcYqzgHJy1dPJKaSMU7sEaPDK6XEMZ6MghNCzOcLrUQ6j4ydvMb63UIy/+rAUAabF91d2EnlMGLa5nvDkxDLw9ktqz3z/aoYndKWBKEKPnJCkxRgeZ459BEP6mk65/scdsDk17eqXUkKlApSyn178LV51I+sOACuQqEGEMmuRfVrzrdvrnmjnJoEf1CBleNrqDqC7fNzXzCc6iqmlJMdW3Uyx7FFa7zLQGNzS7OwYFQcSVFWcCs2jaVq7a3mKYUjkeBzdN/Yrql5bxei/yoyt9Sb648EBlb1PKYvMA9pn1O3v3sXI2pnq+DViKRWFY8uXvY1WT/9mTOap+dqC3Q8gUIi9jZXi7IX7pHaAW05iVlP4EHopXxhkEys2BE6QIelly3kWzAqo0U+tSmSJuQ8vRlWceeoS0i5+6ybfLplFSQh7OMRUrWlyV5JK0cOev1cjlOaxFOgLIlrcSDCkFzJsxkNj4An2S3KfKsR0mS3hRAHZWPf7Z80ogSICTQ6o/t5HMFuYFyMRv9Y3AfXl9fyD9ENlnZ6qMyfpWCAMlOCxWlkQ1pPBosys5u6Eyhs3lwLEnvkMdk+LhXm+aNK+TAA/4/XItGQ5DiiSDE57diQAOU6/24hhHEbe2jOlIkCCJ57cRpm5GuJQtFBMSESO3he0V7NG2SuplL4UztMqjNsICDNsOYHY8VU1qlGO72d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCffuDNHgL/bSiGu+7Ai4MSBxnTu6+5v4M/Ai4lrdOtg542gfSieV9FNATPr?=
 =?us-ascii?Q?jxThLWqubBV8HZfp8o1MnwIunV7VcVwsGrpod0s/XCAhwsSpwTwO18JJ2Spt?=
 =?us-ascii?Q?MA3kCHpXw+adFlwLC+Nb9bSW9iQdFXS3+lnhbez/2sicRkCi69Zm9n+36tME?=
 =?us-ascii?Q?sDEL+5eStmZL0yfTgi3ahaT94twIU5ox0ulLNUhKKXPDWKaMcGZjZYRX2zFW?=
 =?us-ascii?Q?FXtmcfk+Xs/RY3unc4HYQ6SZkGLrA0ytMiruRUKwMlCjvhhOi1BeRKpksdiw?=
 =?us-ascii?Q?kbwS+mxIBJS46udLQkqttoI0MVko0P6XX0S7oBFqs2CqfKswH6pNH5MZALgB?=
 =?us-ascii?Q?DE0X5O+ksQUN7IpUJJi1PNGFCYqnLqWxf2b9OV7STCwsV4VWBH8/UREpmdKZ?=
 =?us-ascii?Q?xAfgZuRWmswQckeiDqXqHq6TjNuyiJKQDu8o7ZDiYDK24ttVzSg/chltZYtD?=
 =?us-ascii?Q?tFlVkJftuQ4L+Q5TngpFaAac7IcEKVbJP1eutk4XJUQcaPy9h+Np/x9dsdOi?=
 =?us-ascii?Q?TfUaAQduBIdH9wIVRM5m/opjRMs1Q5TPnOBnazjvixkph543R0OKgNWmxmD1?=
 =?us-ascii?Q?jfhnu1fBjyJCrBicMfj1jGgrFIWM9Bk369G1h7eYKYU2EuLtxGY8mPmWBy5y?=
 =?us-ascii?Q?5qWqCOc1Bg0KO6+8VOcAxtvU0hacORm7jAJXKoaCOzWqtM1L+pbNjuD2IQ2U?=
 =?us-ascii?Q?WT462axClnWmyHzcnfegluE1Ft0N47y3U2kc6xQzlAIXwM0nL6SLh6M7xtm1?=
 =?us-ascii?Q?hodpXiULrXNZ9NlxBGpkPypeNvpJE+Tcbxfve/sjPb/6A7S/PK92IaN/VI78?=
 =?us-ascii?Q?jtXj9KQc6D6Ez5m/WL4WnK13vT+ior0cz3LwvmYfz4Q6IEcX4VZ2XpyG2lk3?=
 =?us-ascii?Q?VSyvEzSuWPcP+LJt5K2REWCj6dOllBg8rjviE6vTbOoT43DRRN3hjNxwzpmY?=
 =?us-ascii?Q?A0Mv4HjHLa43sAxirip6LCmHmeAqUpvFNG9ZGxjsuygtBrBuemS/JnsgW7T6?=
 =?us-ascii?Q?yMN9hF/4wq/za623XMEvXF2q11Mcz1Au02zbx/D3iRp4Wr/fczFKlCAmXeJv?=
 =?us-ascii?Q?HnNK91K+X8A/L4geno93JU+5kuLPSqJe7/PBr3uADv0U5kOkHMWf9u4SdQDD?=
 =?us-ascii?Q?VwCrFHBPL1n3mUqGCq5lmsVBANetlpwVtDAMb7DcyrJ6OqVr13uqW/x0JK2z?=
 =?us-ascii?Q?nRKbGs1RJTCPoEjY4RrbpQhDkQ+x9FvVbBgJnowdUChkbU1FAMxR3uVMZxau?=
 =?us-ascii?Q?OA5HSlQsM/QS6hVtAujW9alwmVwacNu6CutsDDRmD2sUM2I/MWRS9SvGt1wc?=
 =?us-ascii?Q?fpO7R/pOlsFc43U391LL0gxzpjisode1BpeLIPSiOw6+u4RQXGDVu4NHODBZ?=
 =?us-ascii?Q?PVKd3DT9PhoST+61HT4IgBPksOGty5ZGsj9WJowF8qM3eEGSth010gEOwtGw?=
 =?us-ascii?Q?d5fq+YUn2HdnAu8hvM1HWAteYGRU4hc6v1Oek6kI0zSrSvZgDCeVO/X7jkuX?=
 =?us-ascii?Q?sIRl4uRvn/9BpBG6HvBilzSUPCXYz8joX3bWaE0qWsWa143fjkw3kbA/rhm+?=
 =?us-ascii?Q?AmhCF1kSLy2+kjJQmQvTeLjP57E9ppQmuWqT+ucThJqwJGiLDCEOgyJCPCZA?=
 =?us-ascii?Q?F4JBOWbl3Gros9HC0Y/oxQDhylnzr/sfcmjr0SwLOGUkU3GigEm51JJnr5Z/?=
 =?us-ascii?Q?OvZEwhM6K6O9VpRgxKBXzKwji6su/aO9V/aketWh/+1QVKow9hqCGZDMC+6z?=
 =?us-ascii?Q?9rrCqvdkhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8539dbd1-9b40-487a-ac76-08de896d4c58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:19:26.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpS2MCzYnorW+KiWXv7fpQ+Sr4A8hrjYsB2Kh1qFS0sKBwIdsgkl2Tmv5pMW+bk6jzXBhcXMPmZ0dpg6vJWRsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270889-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53242302C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work properly.

For ENETC v4, it supports software to set the PIR and CIR, so the driver
can reset these two registers if they are not equal when reinitializing
the TX BD ring. Therefore, add this solution for ENETC v4. Note that this
patch does not work for ENETC v1 because it does not support software to
set the PIR and CIR.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a146ceaf2ed6..aa8a87124b10 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2591,10 +2592,20 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBLENR,
 		       ENETC_RTBLENR_LEN(tx_ring->bd_count));
 
-	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
+	/* For ENETC v1, clearing PI/CI registers for Tx not supported,
+	 * adjust sw indexes
+	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
-- 
2.34.1



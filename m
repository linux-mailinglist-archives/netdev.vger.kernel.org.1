Return-Path: <netdev+bounces-256128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDClIbOGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:25:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417DD4A68
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4201D309B403
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DDF36606E;
	Tue,  3 Feb 2026 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1EbhM6V"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6503570C1;
	Tue,  3 Feb 2026 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096144; cv=fail; b=laGgv74JcK9TEXF4zTle2HZkOIPWlgLue6MTQA+5/LHMz5sItELu8v45w+7e1CmVEVZoCVy6wZNyK7CWhjkoxaXo1Oz9g6BgPIaqZbYLuP13aVuVs++cufvT0oUjLVo8LewqyANjIv2mRxkjJKTJWC1XvSAXbagT+U6dUvDtOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096144; c=relaxed/simple;
	bh=2fYvpnfGhZ3xJtPxsiSMKIfjWAdZBPdM8EyHIEGNdjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYlTtuUBk3RAytbkCF9xdRYS0evyikH9eI3nOES65hQ7TcOtk06zyt05IJP3+4lG5lWnbx6mn0NiIeHh9nQJXkJVg646ROyBw9WMLvj2m7+wqm0JX32/fxD/R2VNndvkWaHKFrDLsInj8U8gmz7baWKhGlFAKV06tFv+lyCLCT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n1EbhM6V; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOBXtty6Ln6NwL+h08vjqDLzQDEwaP8CGiSBlgfUaWc04j/rnzHg591vJ5SstEA5WsySk+cvegcmQcCtFArQCBYeqGxaIkZOa2GbgWHNpxMRRrixhfuh59e9atOzU6c69qHGuZjEFZFSmvrkxP37c0LB/P26vmikWTFiMlqbLuC1sil2JrLePSu//VnNXU2P5ZLOzmITHwabS2IML+JJkhwIF6YPxIlwkwN2TWVI1vdKbRLkNluQy3VQXBm2lxxXJw5roP0VIRiJRmi9+QNvIQFsbrgKPa1X3jAvvH9tIwRblj3HeLnj/or5I/u7BLDq3oacCfZ5parAzEx0c3BS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=eMCddPrbqvecFWtWENqxUPQs/tccBoOwmUbELBhwOUIeAxA131uglf0/e2ztCN2Yv080sjLZfw4DytatsJORqjlxT1Vm/Nt3Uq3sOz/y/id76nkdAk4ybIFwIMVMdgbH/34YJqQ1wHtVqLrHOe2UIHU/sl3PkK8gVCFh6trsCz5CZtGy+ijANjy7opHib+YxHNzNo9hx2Jp1v41u91mcIY7KMjCxGwcQlthoILrDKLI7Y58WbH6kGXFDRv+n4o+x+NTFYpaev8eCvvGdTfeg3ezc9DVcr9D09wlMMiPUDNGiw1ExRXtWR5JdW0oeJ5dsXXu4mp+72LxUXqJNAPh7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=n1EbhM6ViXcS39R+5w6GC6U7HaEHhXxVsn7Qwmy7HqIIGJIA8f/h2NEvvixd+rVcUK0ZZxnqRUNliD8lLmIyOrWAkuEB9b7HKHQxhdRWPZmMo0YN/xsntcaZkeFh58U6GEalyrS6Cv9GiUmOxGXo+7tqRVmxmSUtMqELo4NAhInwAw8xPD9m7NFlf7p0bXXH4egybBNe159bqFGSWjnaYTmcmRIKcqXRmwhnXL5GAioO2KE66Qsopvj7x+oydgqfgi7fkAOydZ6D48fozb7RxyCQvH7oM82ygj4NcSrLUZ0Ob7JBBLoKRobJtP+ZgmBym2Zi6ZQhDdJMTCiM/gbDiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 01/15] net: fec: add fec_txq_trigger_xmit() helper
Date: Tue,  3 Feb 2026 13:23:15 +0800
Message-Id: <20260203052329.1085444-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ee58fa-8f96-4db3-bfd5-08de62e433f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?laPmWRnrCjRO/KtFRd5tAu8efW5mcQBmLdY3OoTPZz7sMjSu/oYJmCvmWVRs?=
 =?us-ascii?Q?UYNJp7RCDDJZ1v0ecjUJGOhDHy6r8d6V0u2MVzmYys8z3c8VFBPGC4nw5kUY?=
 =?us-ascii?Q?XCVsCeCzi3LTk95aH8KC5fWbn01cAurt3K1Zs9C/LAXPI1926dmJLhQGhboe?=
 =?us-ascii?Q?2Oz0FmSgPfaxgEOAtU/DzUGo/6/K+OG4N2h0WhKRbnvR3mQjUlO5RlMs1i0f?=
 =?us-ascii?Q?xU0+mlZdJntry9Tz3JEMC6Gm2pxf5facSr7wL/5WEgtTJAPpZdt0llKCI9Qa?=
 =?us-ascii?Q?WjjpDbOiCcUBFa62ykv9IGhCfZAsSAhd5YI9TS+bQh+/rbbS/kIccApNvK8I?=
 =?us-ascii?Q?tWYU+C1Tll4EWtBl+ionBEy/OxSNjVb91CxTncaG+6eQj3SmwcWz3W58PhWT?=
 =?us-ascii?Q?ySztBhMJ5Quc/UHLktP7z1uERQ25UuBmQHnH9w78+YZykpu/BH7aURV5uQ+D?=
 =?us-ascii?Q?rRsrtdcHY2ZZx1nqsfOMzw6xmDeoelpZOMAjj7hDckGGqv7MxZoopgDSqxU2?=
 =?us-ascii?Q?2s9qfdc66kHxF+U9XGCVeZg0HDpH45EOj+vSarMBgLbJoHaS25FPLDVlveHB?=
 =?us-ascii?Q?Wpb4I0PA/qrPU5FJ5IY4OsQJuTE5HnAbg5Mi6YZUfKlR1RJ4lFhZv9Ti0v3M?=
 =?us-ascii?Q?WUtfFdEOOCLDebGLanOuATGmcYZK7f5PRCb7w3vfreVanrSz6xuSeYqeJNKC?=
 =?us-ascii?Q?M3IF+TyeyGmHkO/uSfxWtCtNQY4xUHMirnvIA2DRVmeFzHfDu31QAbAEYWly?=
 =?us-ascii?Q?2cCdY14mmmPNaUfeWcVteE+mDacrZHdlwzG9Lubg2niZ+YKGdkiUWUHi5WHT?=
 =?us-ascii?Q?sHO7P1EIghAdeH3n4nE0TDXM7R3Cw8njXajBpQmNzmVaoAUvm7gS4dt5toZh?=
 =?us-ascii?Q?FOhpm2cEZPM67S4g2pS8xBy9EUjMhEYkHym61eTAY0pPAbyJwLVHSGzbOaW1?=
 =?us-ascii?Q?Bn/JfMAJfG+I5j9sqTJa7jg97PWmzakHzpbDJH8DsZKerlz2eEjC6VAomvS7?=
 =?us-ascii?Q?zLSsOWCchOdnTjReVeqfK0osYjgNbP9SpvPE176KV1bqVy8JpBIuR2q8LlF3?=
 =?us-ascii?Q?ro7CE1Xp8Cl1a7SJVW1M80dzS0bRBQe/U3bsda7v+C9dqVAju+naofW99v8z?=
 =?us-ascii?Q?AqekW37MrrKJGmp/7PZ5YkjzV3U+JjH9kKSWqie30b/xZYLciccZNd6Z5jR4?=
 =?us-ascii?Q?O+xr4eQD9qnEbQ22Pdg/F7sgOamvtxu3xYB0ypGubzN7FDbccnnF7JEhDApF?=
 =?us-ascii?Q?z/ocH4Nl3NtEtqz1f812VhpxOLWc8jKyIxKpq+SjwoPGHIZuEDgb7gPMK6A2?=
 =?us-ascii?Q?Xc5QEe7pC+lYrDiPH+bitng5uwSZSshx1c6nJYA3Gq0jJM6/dKq4zck1JkNG?=
 =?us-ascii?Q?Z71vJcf32aWOP4ZZqH0UY1wfdPYaWnIOhFv8aecEZI91u/kaprpRfYB7FL9g?=
 =?us-ascii?Q?kOsdZ6jySiwZv+tZrBQENJNPFRCj5r4/6bKQ0bhFQc+H7qgAObEQ//NvliqF?=
 =?us-ascii?Q?UOjlTStcl7rGKx0/Ho/lJRtMQPnl2kP71Yv537h5eUUFOmD6mt7W2xU135fx?=
 =?us-ascii?Q?OEyNsSE3a+vCX/UhwvWdTIPaJfbO12op8cNJan4XMNZrf+r31QH2L/HER0Qt?=
 =?us-ascii?Q?a3zZ0CBrVRmFIa7dtuR7RavQbPY3NwX1xyyV6gjRe5bJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kls6DHezhLvvAgEdw5sEucDp2RoUd0G1k2dQ4+9eKRSOyJzDyrNCPpfsa7VQ?=
 =?us-ascii?Q?gMQCwKQO2uTtlXaO+4ihAz1JGGRassyTQJOrQBF0nEhRiqBAokzRDbwLG0eP?=
 =?us-ascii?Q?O3vi71DpwkYPime3qahVpmHQ0eBprjkBOonmE6eaDHlnGnpiy8K6IbB6nKhk?=
 =?us-ascii?Q?0elS78IQ3axxl+5VqhSQcFmSAM8tzJ6IfT4JP/c+1yM2icJ7kODuHU7yNVen?=
 =?us-ascii?Q?NF7/kROHNm6OdCKN51cDq1WuzYDSkR9t4InGuInGrETKX/DjTlLAuHfY3yPQ?=
 =?us-ascii?Q?n/xWtMqKQiToWGLx5BTYHshPL6gc4yK+SEaVw3FtbnKaDZeDV6dPh6xhSbPs?=
 =?us-ascii?Q?bvEAUWoC31Zs8lXwCDf5S1dAgizX0mFhAvvX/jwStF23YOHh1zpn6C18BW8l?=
 =?us-ascii?Q?A9l6yiY2ooIllfltr/VYBin48WTtcq99qJx+Estnm5JyBgiLNHNARsZ3wiQ0?=
 =?us-ascii?Q?eEJlc4OGqnIWC98IVwnhP/IE8nuWcXaRjabUNOCUWkVWeI70HhjI/OWUWM7j?=
 =?us-ascii?Q?uGpL7efGoemCP+Qa0XtCr53q8agaYKTIsVtFeYNErcCkCk298tyCacuNxNYW?=
 =?us-ascii?Q?5dou2z7D2ScAweT1th5x9RuaKUkN4O0KiM6ZFEsyE+1gw7wJy6ecWBOA9P3o?=
 =?us-ascii?Q?Iwz307IMmo5VQKZRZdSt8GsMmo5R4m5v08ASjaMqrj66cr75LAE7SdupLJ3t?=
 =?us-ascii?Q?KeKvls93yTFVk6MjZYue44Nq1U7qMDiOOqTZ68amCYHzuNxlLH8pCrmIpBOL?=
 =?us-ascii?Q?e2MsA5kZClABDImkmXqhdYr8NcwN4HLLMKx9hLdZd3t0hGTuVmBENTKxKrzT?=
 =?us-ascii?Q?CAazsspYWgpo4CAMNSeUvjObAEReGHkWkUsRrBTZ39DjmLgAAS8EhAk3PKCw?=
 =?us-ascii?Q?UKTcu754YtcZvqD9lNeavGHc1WOBB3DcxGNFiMB6Y0bflsV0F1D7pR3axfVP?=
 =?us-ascii?Q?jjkz8vCVWo3SQ4sCd/w/PzGkMD4S/kg+VknUHqvjBYVglyaUyUcps/0EDRap?=
 =?us-ascii?Q?pamnM9H/zQ9yL1t6EXKFfAzFvPe0yu+B1zGZk7JP48jLlRN0egGAF2vB8gOL?=
 =?us-ascii?Q?3VIZqupgEUMF0lZg93RBMSYAxhqHIoaYOzSBc1CDCOA4YDuwn4u3lpTREAcR?=
 =?us-ascii?Q?QPsGR6E81HYdqyQ2UnCd6z+wrWFPqRQZpvZo0NyQ5mIcD3Lnj7hH93HOruYF?=
 =?us-ascii?Q?yy+4OG3Ug4U0fkXE2hMqPwbbTGMnP602pKOBCm2mca9BR7CJl6+lzoPU7PUH?=
 =?us-ascii?Q?7z79kUWcTF7qVTWk2O8qLwc+8tOI1OZWEzjjjQ7kQNc1Jo/TXhU2mT/UvEod?=
 =?us-ascii?Q?qQapLwK+gZkmkxc4SyxL8eeiEG6C17FViJaFAsl2QZGpYhntHeSonMCcXQzu?=
 =?us-ascii?Q?k5EE4/zLaIeAJQl9jNEFXEB+fYebHKTo0fimvYsVWLVoq3pI1EvDOMSQE+kc?=
 =?us-ascii?Q?JV8PzwIqFnBc6eloBerRN3gEPX2hYyAsiWE0FS82RhpRP20zfDsj2RALk9fs?=
 =?us-ascii?Q?lwu2SgW20gvljMolBAirwMkd+BT/dlygk8Xa5SHNblniQve7YYVGUdI1alsx?=
 =?us-ascii?Q?FnEnpzZalvYIkolyPodwyBYH/UodTG+4jvHHfr2x+uOYridz7y47l+xPunB6?=
 =?us-ascii?Q?st2DxHhjrx58qM2hPlaFiiPPJPG8y2/jcAl4NNxLFbKPy74NZYKqHXzE9vt2?=
 =?us-ascii?Q?27ug1FzVaXI9aM3QaenMjGevgtK21LBkrxxeVURrWoUpw+zQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ee58fa-8f96-4db3-bfd5-08de62e433f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:19.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIHW4k29MIL/GNy+k3/6Jcg12ln0rMojn5o3XX1wEflrZs9WTviQf3Bthcffie5KZt8yaVgps5ET3quu2JS/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256128-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 0417DD4A68
X-Rspamd-Action: no action

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a1405c928525..ce433af02ad2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	return err;
 }
 
+static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
+				 struct fec_enet_priv_tx_q *txq)
+{
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+}
+
 static struct bufdesc *
 fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 			     struct sk_buff *skb,
@@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
@@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 
@@ -3936,12 +3937,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
-- 
2.34.1



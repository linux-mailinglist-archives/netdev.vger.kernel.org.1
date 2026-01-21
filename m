Return-Path: <netdev+bounces-251747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAXAJG5JcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:35:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6665073A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89CC75A3A3C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624E366569;
	Wed, 21 Jan 2026 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E7D3bKL4"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05795365A0F;
	Wed, 21 Jan 2026 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966471; cv=fail; b=Npa8QjKzyiPQpSJJAKcmASFEzjPwesZITpAiTF7v787jp+0MTlNFd679oDtgCqJZdJ3MgZKm8ccSjHl+Xcws7bcQJ3q7hWsgiNhnh30qOXm8syqmlQFjZxJJq0YQBSDQ2m0L3uLFLOlGltKKwRJEQiu7g+huUn6LOcOpQ2/ltI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966471; c=relaxed/simple;
	bh=U0A+x8QYh9ktZt48s4Xj/yNkUNriyCjzn/YD/YzIGus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gb+NWOs5C92udXXiiXGFBusx+nvAEF0oKi2hTD+NPGFUmpBavG+vfzX6/oOFbOkHDFhs2DPnQo/AnawqROSMzJAWsn9mwGAP3lcxaMWcGb9jAIp94NM6KwcwfbVxLhXwjb8FeqSsR+nYjnTR3hSIh4sKJuAbFYSPdKeyu5K2QpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E7D3bKL4; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddpnmRpq+V9JDYjBTskQWwN52OsD0f9oGVkw+1W3Y3ZOGdKB8KTDEJorJQKUg9RqHehWEq9FFNTK9OEDfM43/J9xFY4ZWtq3/UhFM7KUEygM5FVxnlgcUuRjLBwChXjnjWXPmVwcvaEC4XtEZyDJfly0w02REa8mkJJh7VJbNcHTQsXPVcqcgqTOv+HMNx2ChXyMBm4B6iVAEKEo70klAEaANgbP3eRv1kkJPObiE2iDNJNF3ao2gZwk5mdxXG/PYyXtL741nMfKJYp95CURDT/jZ8dwT6sZlqRfDUx3sSvjD3y+2EpCzLs5euD4Bviubug26Yx4nMsoTB1Bg9WT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=CRYeP+467SoA+Dc8kBI89IJwcxja1JQheIa7ncUf10k8F9x05jv+iCcOdfOOiQlKaDNK4PWHlbDDFcaQ3GX3/qur164FiaL/HhVzELGde28UimPUsv+207MAR2AYs6tBld5UUP/91tgZQJ3MIIEUzMoBpeuIBE8hY95VgdwpNPkcB/fCToaLsCtI27cUOH6qhC3X8cbpFQCjrs2oktYvPtTrAt2aazCzG2BKOGdFSem4rmNliO7l8hZuCmGn9F1d2b0WobiVTuQ5wggoEbKrYnJZIRhYu/dINdTH962voYOFQtxu0WWGtAvHKWxGWqDBGf6tfFO6KFYvnZW5yBHcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=E7D3bKL4ZBfQRcrUVodX58g0LE/jD/h4QhgZwOMQK9yDFgapn/zRgg2goB/UAORmEso8mqqaRWzpimmRz2XzMnOkJsOwkZDCzoKOBL6qQU1FRCNz+p1C8pjY6fCr/R34n3Y9LQVOdANxnwavVE4fTiOxVMq/CKU2X+ydkzAKYFleHRjr1OHWe+62l17ODMfzHt2QyI9oMEHLPMCesmc1IfZahMeP0Jk6NCiU4IR2lUFELygtu7vv25XebX458pRQWzVtP+lH+25gKXwr0kMv0ZN77zqcwCcv94UPf98vw57DwxGV2lotMihmIZLPVSc7FWNLHTDhb1FX+kSQTXns0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:34:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:22 +0000
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
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 01/15] net: fec: add fec_txq_trigger_xmit() helper
Date: Wed, 21 Jan 2026 11:33:43 +0800
Message-Id: <20260121033357.3261464-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb0fb97-f11c-4956-e0d6-08de589df7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RddlCTBfGIuZHNcDq/0qnoz7NSgbPIMghvsBf4QAjK/QckiTNp15f8Byy+H?=
 =?us-ascii?Q?toL6e43hW+WnLw322bOKWlQ8Rt482hrsaV6JXkgzVfoU1N7BIH49sDmRBb69?=
 =?us-ascii?Q?vCLs2zLHWJCDLXtNIB3wcosdiBEiea4x1mjmGnKxEArNFXFk6jhxBI0xjE6M?=
 =?us-ascii?Q?qRUh2baljEpAnX/0l+C42op5fG1WvfNAXFq4HsRnOwS1G5Ym2PZBqyAc0Pqj?=
 =?us-ascii?Q?U88FrUtwmrYzmNEqNNOhNhCvOEurh9rd0XQyATtJxHjeXIQTumT1+aQmzNBK?=
 =?us-ascii?Q?ExtYRr+wT8YKP1u0cSv6gA7qOZdXIuENdIX22/GSJNW1eHCiGChOanWpn4x9?=
 =?us-ascii?Q?ONWq1rzqgHgVYwoXrlIgh8GBH0817/beyfg20Orx17kj8n1xc3U3tE6fBLAV?=
 =?us-ascii?Q?GRdsa/vCJgL7bJOXt83wgFB7Wa8zxWs07emCBKDDaPOgUp0X2tNTIRcKH08C?=
 =?us-ascii?Q?pxlibA1vvZ0Y3w5s4gqgSOH8cSBjo1WeIzv4Rv16R8EDIM5DqDDb87OcOC3Y?=
 =?us-ascii?Q?qakbeyz1KJ8dviZcJsLs3xmI9shAKhLxZWFRydk8uBsey+LPRtpU9079K4Kg?=
 =?us-ascii?Q?2pNzPVdMczcJ4HVrnRA9auYNZMP10l74gGvspYL24JxDPiw70wfyyitFV+rr?=
 =?us-ascii?Q?2OtLvna+69y4ZgI2fx5NC4pFITrihT2tg8nx1AMP57Zt4pt3csdWGg/VoLej?=
 =?us-ascii?Q?c5R3AUZS4ylOdIZ+UOyv6FVh0kNQz62EMWW8KeCf2EzV99YoPLWgarkEcAkL?=
 =?us-ascii?Q?qYRQhkHeHPSRUK+NGGiUSmSxeyOUYnp+68g3BG+KZTuxgZtzlyz6jZG6tKnw?=
 =?us-ascii?Q?V2WhSfAGMxturft3+BXBvF9kYROe9Bh/RyrmUZRsfrJ5rMm894OEiRXgX9Cg?=
 =?us-ascii?Q?yW5negmOcdlsyrWBGxrSx7OS5dluJda4kpcvelOMDbLPQ8Ev3w5FllMFRhek?=
 =?us-ascii?Q?6BQrvDjjf5f2FvAHWuuj4wopXBkLC8vxCXoQLis6NCVdyxBzE6/2nG1qOOzt?=
 =?us-ascii?Q?hGsyt8JUTycbtJRFgjcBJRMW5DUS6zzPbsod16n4ewXha0XzZjfS+cWzypqQ?=
 =?us-ascii?Q?eGfg1Mltnupw6W1n861SYtXVXOyeVHQ4XiRNNpF0h7uS2n/Rhu76vg2mrgfD?=
 =?us-ascii?Q?U32cxhmue6S/Xt+UfvMLfZwcoTNuKJU13Cbw0InNqZoCyacTfFyhK1k9qHQx?=
 =?us-ascii?Q?oPNISX7rR9Nh6jjDifnqQt3nO3oqZkzgGcUKyeEppXWUD30Fl2rfIWRY8Vmu?=
 =?us-ascii?Q?2vKsxmKL5CN2/MIblWvZWO/mpMEWBSxRWtuPBRk2ctlNXPKAPDZsnTJ0N79U?=
 =?us-ascii?Q?47rQfm0SfeF0IAoXLHNjU4GYqwbmD8K0MPujtSNrTklptNOtpfiNHG12Q0Ec?=
 =?us-ascii?Q?ZuKuprFxgzoAaMBFcSfs39h783i1YitjaHz96CWoo9C/KBI9nxPsG23gZu/z?=
 =?us-ascii?Q?8aGEuSDANxfwekcCZUneNXUq0ujwk51JYe1f7vetpNHaX8C3JyVP+H9CjEYR?=
 =?us-ascii?Q?cz6QIHcFuNlCbtBFYizj1Ek+RHyOer0rDUdAyT8BUXnTF7xmP9NOesVamIE5?=
 =?us-ascii?Q?v12mA8o+ye46KfMwbmp2oUy6vXH9xiE1UbFjUh1lOXWwy+T38hLQBng4Mr3s?=
 =?us-ascii?Q?A8T7f/IMBDab+/MAdAmlrzOGheQjh5ouwMzbYQOHcEMl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+FmvCR9ojwel9HixK5N8/4mRfTx+4fG8WNmZwhWNTLqYn9ITCj5qR3wQ+A+?=
 =?us-ascii?Q?zEv2y5f0R1Be8lsCCRRt9w6RtPOaxO/GJGIPMUFseiSKx58/2HkMmI4b+qGZ?=
 =?us-ascii?Q?asmqwuV63/jhhdpPlStURKcfDCaaJqPrqGtj3m/xtAn6MaXOBrz0tAvd/q/F?=
 =?us-ascii?Q?LNjkgcH0ozcyA18HztDTSBnKhAWofOwTzsgDVyEj4CHxlV/zU7MYOWH91P5p?=
 =?us-ascii?Q?Opj1Lc2ZxnrorExxZXZry7pSxfz3Czuk4XNkghMV1pfCngKRrcUINfmxjVz2?=
 =?us-ascii?Q?9Gk2KQrIToBOeyrjrP7MVPHGLRjKY58gPjVNfZX1oXl9hqyozV5YnCoKIw4j?=
 =?us-ascii?Q?/8UBa4O+eWppY+gPYPvykegLAArtW4QUirGN+B8KAFTAOszHRaZIpLDi1fQG?=
 =?us-ascii?Q?ZOYyjaiVg52HmP4Z/BIuYbwLY0f1gvzm4FuvLqX5vUK3ou7atV3/xfBkYKhG?=
 =?us-ascii?Q?TpxuqPEy/xMIwjqvn0fksyQvGuYWABgYUEr9FwH7ZTu412kFbCMq3aA8OYh3?=
 =?us-ascii?Q?3oGS3zLND24apJzG4E1BXZ90JhXmE3IPp4CJqBJ77BfraggJghGoz4njMNHM?=
 =?us-ascii?Q?f1Vi7JY3HbN++UEteo6PTkXrW/Bxj0q+J2j5vp9zC1zstfFvkMhhnC3ogGVk?=
 =?us-ascii?Q?isFUcNR8MxT1pakfsafICziuJxi2zOiz6V7nLpfnjW9SstLIeSEWYurq5s5n?=
 =?us-ascii?Q?lQFUSthLxIvr4saDbYNhoNouiznY03nWbcl83mRFqS1BfSsiVETfcfkzxwgc?=
 =?us-ascii?Q?4KbahZRG6bfTLyXSfDL9gVDEmWVBaqlUBh85AM4lHU5AzgdEKxsb0omwZz8m?=
 =?us-ascii?Q?P+pLFAnQfE1PM7vgAtmv8ucx932C42Tgh+ZcCnhlBb8MBrKuHiU+DJdpGWaM?=
 =?us-ascii?Q?m8vH+te5BRPb8kGUp9EbiAcWeIcRrZX+ksRkIrasem35GSvwvbSqRQPfMTJ0?=
 =?us-ascii?Q?mnuaWbGM6t6FMOLaERETwk7By0fKBBFmA42UrDao2KL0RaJTspts41dge4+O?=
 =?us-ascii?Q?HjoJ4EdtWii5L3Mz5a3kg0se/navPyGUYIcDy+3oiKiUqHlHymI76mTLlAAm?=
 =?us-ascii?Q?ra6ooq5LEozQffO3nRyoE+wzez7byj/8OxGYLp4kSgWah9onAKZPI7flYCGJ?=
 =?us-ascii?Q?Dl0x7V90DmdfPttBNv4O7Trb4JMWEAPiOSOT71oO8oR1Lbki8yHUtMnTRY3z?=
 =?us-ascii?Q?m+uQEk1NoCCnYuXWX5DeVott/LETbW1Ez4rHoL7WseVOICmk6ujfOOvniKLq?=
 =?us-ascii?Q?yLgyNCezqRZ4sA1w7ZP5tsH8Oue26sFfuMnZOPnHD0KjTk9DLEA+qr0M/dLl?=
 =?us-ascii?Q?BvZOQI45y4MnBRQY9mcaBV5SR5N/wEsETOMg04/fLBZi16C3oxwDCDbjjnyt?=
 =?us-ascii?Q?CP8M14gaDhkRlUctk9nOWodoneZXFsiejRGodtG2Uc3MIiIN7Al8K85gLKaM?=
 =?us-ascii?Q?IG2R07efWI8SzNWnYNHiw9CU1otgmhL05OlxbusIc1nEzV1XSl1j2rqQPwHh?=
 =?us-ascii?Q?UBWt3LR0i8IutsfycEdJgpPzFHQsRvL6zfEmjukAvmBmthCyD2s62hhVm50N?=
 =?us-ascii?Q?MCN2ouJm0qtVntAYPspN6bGlGcii1KHbdO5/pEslMF38Arz2YbEmWfmA6nTv?=
 =?us-ascii?Q?BHdPCfDFrndG69Hu9co0hJq2+gOFA6OrDeHB1W/k7EyKnOtpPyaHjiLbkCDR?=
 =?us-ascii?Q?6G5YwYmUfRA/qDLuB5a/6U14IptvJg8BVK8udb9PR0A2Q3qGoPVsEZ3aP4t3?=
 =?us-ascii?Q?vLuiXaRklw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0fb97-f11c-4956-e0d6-08de589df7df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:22.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teqMu9eWH6xN4HYwCpJUdqCGMENg2CjPCaONRxzrRHchyDPR7R4pg2faZBUNdB/5e8f8vJGyBQrC2ZvjW2oHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251747-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2F6665073A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cfb56bf0e361..85bcca932fd2 100644
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
 
@@ -3935,12 +3936,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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



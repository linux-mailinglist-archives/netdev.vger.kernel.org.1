Return-Path: <netdev+bounces-257054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFGPLEhbhGl92gMAu9opvQ
	(envelope-from <netdev+bounces-257054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:56:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B6F01F8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91D44300532D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF33366045;
	Thu,  5 Feb 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MpV7uLqu"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74C362150;
	Thu,  5 Feb 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281787; cv=fail; b=qGAKh4zyR45VWjXKnh7CanQg6gao32Nd06x2JG37u/lttYxK8FOzwqmLu9rDWI9wY1vI0W+lOoJcFKq0XKvDEROXcd7HPTOk7babHImNpoJ1Cd6m5zVONqPzquUVMdnXUkjXF/D64DoIF4RpMmq3qUQ5XAnZTeL5s2Vqvc17hqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281787; c=relaxed/simple;
	bh=2fYvpnfGhZ3xJtPxsiSMKIfjWAdZBPdM8EyHIEGNdjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebmRS09v7YJbl4gyXPNpUGuQ0+zvqdMBgU2wugVSnRkvwMCyDAcu9aDGKYByWRaWTje2lTTwqSsYscQnb/8f6X0oG0YcdvsoeJCn3Cu2LTJWT3SAYqxD/tvlhIEK+AqJiGMGT0lUhaFMHQLmbp9ZYE7LOt/R4iEm5gOUBpArHgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MpV7uLqu; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbEjhfZNcBESM6rCu+DEcpadl2Rnky6MjoM7DkliCqxFJa+H2zOOarUgx6LBhrF6dH5Aqj6ORl8ng0y6AMQR/40xQBFZGWhYpd6O6m58F1b3MOaOtxRsaTr18Nsf65iPttWrEgShEmtxHX/v+GtY17QsCpglTdn5YOeGhA+qjUbD266s4fZxDZGwCtuookpGruHwgDBfdC3yIWVwHCIHbeBbGI+DGlLiiSPB49+HHq3iSgIIvnFcLsNrj8NljG1twNlpb8r8UkhCG1/TpPR0fKamOPrlalzuE2qGvjC2ajDr5BG1Vu/fAHWq2SozxN9NbSxaoHLSJdx/pwN4jRY61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=gdoBl6GYnbunQ0R42mF/ubf5aFgy4MCxdTcMCduno8IwW1WIc3FefQxhCfbYZXpem7oJOL84gintSmMWJwvAxwDs/0+qebsR4cmBcM0S57Y5uPpPW8+l/hZiqQ26y0JK1dWbXYUPNCD8i/FdYT85V6OcayMApINorYnLBtb5fF4W01MChiln1Hq2QUb8X3u9dQxkJOS1loef2VncrS1jMtV4mghfBiPnOGVassBE6U/6RTXJofmjanMb7ZIRwrrp08YUOIQpVKJGQsZkyB5+jIetAGLGebaJo25EKca1QMYEsuXt+6SvS2RgPnxdbY7A3V9Bt/6YVvnHmpWoX/8CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=MpV7uLqueVs8OKQqDegwf96NlJuG6sLwroevo3xOxTWO39cfawdhND3pN3mq7uZ+pJYSRW0JYHVWRmAUUA7xV2TqlZTYdXFrMfwM8A/HkwnA4BiuxC7YGW4OdQqAVLog+fq8iWSQdqvRubFZ48oxVSPrX0qYvH0jr4DQqtexsTidab9xtB1Rnq/YrkCwUnahfsRnL27eQoQ15KKJKSJd49pBvXBipTsnq4Q0Isit4nrDOlOHd/RI37JXRDUEnGQSkGrTvYU+BvktUuk1sNSo3jCaA6ifqAyyLOIohG5aAoO/jkSzue8QCdPRBzl2bMgdUhYrgHomsR+iGE5MEIwdXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:21 +0000
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
Subject: [PATCH v7 net-next 01/15] net: fec: add fec_txq_trigger_xmit() helper
Date: Thu,  5 Feb 2026 16:57:28 +0800
Message-Id: <20260205085742.2685134-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 021f607f-8668-4083-c242-08de64946efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcrO6NVTMAe1q9qQukhCPrrro/Vt4lKc6BlDI698s0epziMVsACVIQm+rP76?=
 =?us-ascii?Q?8oLbNkDI9j6SrGSV1Qn2Tn9C9twCNZiHNjw0WXH8OiJQzO1Y3w/mTEXlj1zb?=
 =?us-ascii?Q?eRi5TplWSzY3e/TJmyM++lIKBpzlMFnWAaotr711qvs27KYs1ozB1yUuAUf1?=
 =?us-ascii?Q?XqMpG7wR/V9D4y8tG/Lec8L5nqRtD7nhi1XN5hDyrivqgwTyi9O5HmSjKbdM?=
 =?us-ascii?Q?bUw8twLptiRj5soCRzZMLrs42zb34crcQhSO4Uoe7SmwdCkRk35cNdKZWVT/?=
 =?us-ascii?Q?tVxMvz6N949AlEuQiBPwFCDczEPwJ+jvlah0g/yzw4lNi7vFtc5scu+fXioH?=
 =?us-ascii?Q?JxaEUOfM65oyIURAcitnCRE0JXxZgVhDp2AImfO2x/l60Vqemx4JufX26RaU?=
 =?us-ascii?Q?fDijUiCNyzDuYFOekqdtoSeuCzOuQr+I7UQh64wYAzp/cx+jfSkMoJ24du+t?=
 =?us-ascii?Q?teS6YXaI53EbG1c1Js44g93lT3k3Ri36NhTO+nJbbj+y3wmZfxhxdFRg9GGf?=
 =?us-ascii?Q?d14czZOjs5kt49t6/lPGVNGIdNsNqIsRNhSzBDx2HryhYzcbZtkRd9znWwMF?=
 =?us-ascii?Q?RvitwfdKqst94z2YzRegofAcIL3EVyCc9P1NrkR7XWj0c8TDqpcnIS8mGono?=
 =?us-ascii?Q?SN1anpjhRSNJz0kXWdoU1ZP5y4426OpopT5zkJsPY4ATXhyGvu5HRFk4cmV1?=
 =?us-ascii?Q?Ei7sTexwueskAfUz/AVGLMOm0I26kCqLcWG9tbNCTessSnxjBregjUy/cIg/?=
 =?us-ascii?Q?dA2j0anwZpxfXf169YyTtWg3y6Wkl3M5KpHRCOIgcVG1PENtuY3W9iooBErT?=
 =?us-ascii?Q?zQRusre6+GUC16BJdXvGjs6H7U+umM/GwdunTlyOOhlP/fdCNEKXyl61OdPQ?=
 =?us-ascii?Q?/47cLI4xyV5nO/HkQV1TZ30b9c4II8AkHrT5RcmSQU+cu9b4TjMbjZw+Jo/j?=
 =?us-ascii?Q?cPeAwcxEBPU6PqyH3YaL79BTYUCmsbqjlgEIABlq4dRv2qnkoD7ARjulXyVT?=
 =?us-ascii?Q?5njU27fIp+65bljgBZ2uMEHb9FnksB1OZpHxzCHq0FS87xP9Rn6C9mP3YMWA?=
 =?us-ascii?Q?boqqYHDDlMEzXEyj7vKjwxYB/mUBJm0vKc9bN6DWq0qxlzOheCRanL+NiXYw?=
 =?us-ascii?Q?xjOVESnbxYTcZSjyfBG2jZxFAjYaOgnvLkshQACPXwsk7dCK+7IPsilNsCPk?=
 =?us-ascii?Q?4reOhvjurUWEFn5vK8tf+gFS7lY0eN35edgzAS9gjVaWFoigTGpBHrlY07KO?=
 =?us-ascii?Q?4+gode/7TTREUkZqJNWXv1YYWnk27x3OG+uDYT62NclokDgbTFPA5AyUK4LL?=
 =?us-ascii?Q?blNDGHNaFCubPFJhKLhan1+rXQ6hg3WdCSJp5sz+SWWMG4na7hrK7TQ6cmOx?=
 =?us-ascii?Q?JR8gEdFZLxxjhVGaR20aYIGua1F/XBeYG+OUXc72tMZaV1jvPM1S9EuDmUYw?=
 =?us-ascii?Q?vClQQlyGdWhvpbmjt7MS9N45c+ufcaCOBaJ+0euc8ruafMc/cv93v2y2UeTf?=
 =?us-ascii?Q?4gIyj06JYQHaUqXZIcY9BZKPhElM4WskzKrkYQrtB51/eoKpx/ZjQSjxMixv?=
 =?us-ascii?Q?VcfAnGLYh/W2QpTXT4oijyeNi2uzktJKUKQzKFXzuXpe5SYFIPO7TdGM/bb5?=
 =?us-ascii?Q?Fu7SgoH+aRM0hNiYw4cxjl4IC1z8UNHbY4MnBp79tEOc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUe3/lsJrtBUUj1WgcmBuwp1mXpWnBKoKC13060dw4SYkcmpODc9tmORZ8Vw?=
 =?us-ascii?Q?wShiE27MYlFR2ccQvF0ALOS5s/ghMjG5SUj7065BZCR+QO4ZqaPfVNp8a8Qz?=
 =?us-ascii?Q?8sWW1YuP6JhT+VOwmYaZaHaQzhQTD05A4sp05vwd88qirgRDTytNpHVrb9UU?=
 =?us-ascii?Q?0vljtfypWPrHfOtiOAHut+ua5lAduLg4gqJjult2Lx62gfC1pBiC/w+ejPUF?=
 =?us-ascii?Q?rBBZLi7+Fcj80kNAdtKkzdC/4KVVG5ztY/3fSzfQ/G+F7AuMlXRUws1B7Jq8?=
 =?us-ascii?Q?R3+oyudXqSVRbxV9psWl6OrQ3jq5PbRitTxDUG647EVIDynjqZsjoOxynEcz?=
 =?us-ascii?Q?ruyOu3ZxqsnqBr4W7N5s0hCZ1vKIpNk+OAmyEZyHLAbcqeZZTkAxHAeGRcH4?=
 =?us-ascii?Q?XerKs/hXHEtzRQnyvmODDrGTDRiJAZAs1yTfMb7fUqe9dP7oRWGLo0IDeb1C?=
 =?us-ascii?Q?2gcZu+VI5BowZHHPHR/hlbI7ES1Rs5LHVBp/HbQr0AyMRzDHIKo7gM9gV8yY?=
 =?us-ascii?Q?4qhrm6CoyGPHZ/5SmF3rACSzsWkM3hpJdpfrv9fmoRoRsIfJH+SJuasOfYOg?=
 =?us-ascii?Q?1wCObnz1zP91bvdOj25iqlHt1IaPaEdvOvV2krj1MDJx1b2maLlIZi0AZqmS?=
 =?us-ascii?Q?y7kbUrLlbz0km9NmtYr86hSaFz2gl2Nqov9cIi+i/mD/A/V9hTpfSt+yAjqy?=
 =?us-ascii?Q?BWmuBytc8qfWBibyDkqDwM3EBev7VG04E4fRu8ynXYL+ECJHGmiJPRRiMqKJ?=
 =?us-ascii?Q?+05yMIBTmfVMMGw86JH9ZU4fFCAzMzQ6XwM6MyX/0YPsFvnCHLk2wdhwiD1A?=
 =?us-ascii?Q?+oZncdiSgcjT4CXZpz3DHbUo+0r6iQ7UrTy8Y7DAmxPlHEmsorL8ZR2EPc4h?=
 =?us-ascii?Q?UyvFjG09hXPAt8BAu9rLORQFHKr/LQ1lUXR9w5Mjqdap/fQgCSnpHyIQHui7?=
 =?us-ascii?Q?MU2WY16ivZ6OQ/SIuTUDpTntPo+OxwLMlgEtOADD0wDTYp2GFk+c+mKcwNlU?=
 =?us-ascii?Q?7RLPhseFMZWrBi3Gxpnw/ElL0jSgATxrWmQk5g8PTph1MWwBLYHbQ/xuCwMq?=
 =?us-ascii?Q?LBhIz2hn71wlzZyeStu/KAs31mANuNMxtxEW4Y7QKp+dC5FYOjdaR1p+ZhXr?=
 =?us-ascii?Q?H/s6OSFYbYudCCyCVOFmk5frGDLbKQr42s7RgJqI29okggLj+SECfTs2LjLF?=
 =?us-ascii?Q?ns193a0VWsUWGYcbp0xW/Ev5YEWFoxGUK8Bh10x7O98Igsz2aHfjdobLGDwa?=
 =?us-ascii?Q?1TFTB68rKMkiammZ45l0vEQmDodwei3oMD/7OHdRpd9uRoASj0KlcK1TzMpT?=
 =?us-ascii?Q?b71hXoxE8r0gmdHHAvYfo5ny/kGGClsZNqvYNw2r7XkBB25WC7NfAxALONjB?=
 =?us-ascii?Q?yttlB1cqQ47mhqkAB7jNtHrIgshIbRzQGdGYkALefwazkKHzFMDdnG8IX6d0?=
 =?us-ascii?Q?aZXcp/RvQ+CAqRk+MvAXpjjAplMC6bHqeAgtovpEQ+fAzz3dQPuYJmE8nlqA?=
 =?us-ascii?Q?EMXNCgKYGIdvENwx1O/gv+yymFE5J/kzVivc6hx9V+Kdh75srTblnMr6fHTi?=
 =?us-ascii?Q?2uyqfLETI7AZyEOHBeoQoBhpFX3mjChiEbBfur/b6BpWCf6oXu73M01yiGzI?=
 =?us-ascii?Q?CLYTYlyJ0QsqpeNtJ6WRhgCObrXJmP0y5kY0Rzf8fC0isBVMkKKQgc4NiUpf?=
 =?us-ascii?Q?0ZKx9E6mjjTS0WDnKP3CSoMdQxkmaDZ0j0ssOLecQ/3NPFMYUPCSV6s+PlHs?=
 =?us-ascii?Q?7WINBmEYWg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021f607f-8668-4083-c242-08de64946efb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:21.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0hyc9aA3MLWaUNiZ/sTohdYiyhP7nx9ju3Zba3S1+iiZmB+SwKGuvJf4PKZVN7cdnp1E61iGpPgKTbkbr3JxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257054-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D93B6F01F8
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



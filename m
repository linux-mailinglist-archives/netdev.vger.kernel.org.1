Return-Path: <netdev+bounces-297570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cAK/H940KWptSQMAu9opvQ
	(envelope-from <netdev+bounces-297570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A86680CA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=fEy2Qhr1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297570-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463783160315
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B93E2777;
	Wed, 10 Jun 2026 09:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7893E3169;
	Wed, 10 Jun 2026 09:46:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084789; cv=fail; b=KLH5/Fw4qnqyuc4wiP0xC/fqbC+1hYPHzLLFf+GF1uhtb7xhTkwvN6viU4D5zhnrZNUgQejIlxSd11TWcqb7mOKpUrkEHE+MG613EKGJZqOzvTOM5BWbWzqZqKkfoLY2bnl+21bAp+DcJAwAfHoTVbuoiUMBaHyElLxd4tsIlGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084789; c=relaxed/simple;
	bh=5BL+M1xB7GNAePsGbwnCLnabvS0DTru4999UAKVLKpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fq3nB+kWRh7XSh+a9L2I4MB+f08NqoWFTBaLyI0s5xZyIOe3w13JfDRuVlnITLfQr6c1bXdvy8wPQ0jzlvfpqyvF42vQ0kpfeq1VWh/U7R+8a414ynUGfSoQI4P6/9SE6/jVxjg395c5gJHNVMA09qMORIFdv+UUMpaAtAvlkNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fEy2Qhr1; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1WAAfkdBsfadOCZb+1DTgns9Yf+71vmebUiHLgvipxjDLBHlmdLX4azO3a7hIQesAvUKr7cyVX6TipRRFpdfODYUMjfs6hGHqu/vPhUczR3LdRinqPVXeO6aKmh165PXcvDC7jbXf46iNFRmsBoeZBU90COLMxp3YuZBeKml5coXAtW6Fowsl9Fn2yYH/Nlo/ef+/Wl8GxZvNEkHslfTIPuyMubbQxOgqLrMzlE6wT/r/QkJA7/hdQXsCiz8CkAn0G1lCWTZN+LoHCFrmKIIHQiHllSiF2ssASCQ0H0eRYGbqslG7v9pd/UZPxJ4H8F6R8ESm1cE+WBUogUNNgPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtmOMewGN/ZOagJjUxXBLUyIxBMn5Aoa3vzDb47TkEg=;
 b=lCQalHSRVOemL5EKxLhbXzg7heZlVSncTRkbx3sS7vTZj9YOMWxFv88+tvOCmWSsuMborQ4CT0g8LYbMESJweRB1shCghTZ9OWTPw9cyJ40eiVmlJH9deZmulLzvgnuUJQBtK43Qe73AZLdNYdVhv3oAxIcMLV+ZjbDeIT2+9mJZkrmHII8c2HL5PDPrbDqj08KKTnSlu4zksKmuyRHSOMLMU+rw1H14dU0wWeVZDHgwlx0DlPwzmR/lQ1nn2FX69nHkNISAXsbEIzJx6uYp1h8bPwPLHfLKaDnEPxACVYfBzPyUcLdw3VbWqyOOrtxv4rvckW33IJkcd2HxK0TVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtmOMewGN/ZOagJjUxXBLUyIxBMn5Aoa3vzDb47TkEg=;
 b=fEy2Qhr1HnfxabongBvPiSqluJAnSOOWOqmwu4djzS2AS65VDfBadRS2Ufrrg5VSXXKfXdG0pFJnVZOv+s2rAKunHIPzDv59/v39UUrNPIbJRR2yTTGstCzUj6kYZTbpXI27QygGMnHeMeZqnbqKaMZHfc4wdm6Ei93GzJH0UPYmCIsANi3FuvaRXi0Hu8Se9vuiansNRv66mU8aj5aR/RSLSDHLdX1YuvkqT6Ml3VtutlZmFiWsrVoMaRAgGYnJqGVf4espL05GE52HadtydjxONMO5K0V1WqCo1CIG979mWWZ9YR89wpPLXcDyhjfu+4WoPW/9XbfMMdvi9O1vhg==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:17 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:17 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 03/15] net: enetc: add link status message support to PF driver
Date: Wed, 10 Jun 2026 17:18:32 +0800
Message-Id: <20260610091844.3423693-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3a650c-9192-44d3-5414-08dec6d51e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|21046099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Mxl9zndOrl0RTCTb41KAoSC5o2wTEq/xNdDCXAE1DQ6z81P2OLOGMDOXIMzbqjSqgjm7xkMXFYcTJmB9YCfNH8lxi2Dcyi2OCCxaBjb7UBFjXQHTRepHjiV4sgwwGy7N1fy4pw4L1lh7cfGBM5g5AlvFIMbw6W7wTWuvI8h26dM9KtbsoA70PTIDUItLU+uILre94aAsPYMQiJ3DaHHTPFYbsua93XXZCPa9RP/jHpHFz/nw8N+nh605i234eIY04cizsdW6G0sinZHVrR5cwpnI9v4zHqAlg58dHSKN4FpD8kfl+xGJOixgUpxkhmwzFN1WgjGidbvP0+DKziltpXH48CwRj319iRnJ3qcCjUYbrbDotqiI3hFiPCEODaPqLNKg1H4OnwaTQo0aj9G+j7+DcdNzIaCAF+/nNv0Jz+KR4Wcueo8pllrMGzBNsanuyhIfCoYiQY+rgpSIi34K+3s+5WTAjX8Qag8zeci9ARFOGwWmgF/KEK8YFnwHFJAmJB3BKCGwS9JBLF0kTewVt1dfQIKCbeEGFoXtNgqT5v2uGmL3tCOoXzlNn6WnKW64zMxX6qwe/I/RxL2VgvgmDK4egnsE/OTndWveseyP8s8h4obTmtu7jX/pWtIOK5lOM3rSZ80ATc3Pg2VfOwtLjiqhLFO4S8o0s7ttMlr7DfpBHJ5vS1O2TOvmfMz2u+mADY43B5oy3AFStU5rEUXbMAdNHZi1b7WFSZP1wpoel1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(21046099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loQjdL2bHOLldAuW7kepJGuq+zuaBVfSNCsIy3rsP9eXtaCObFm0OuNdki7a?=
 =?us-ascii?Q?bl3mf4AZJT+V3kfKUpGNs7cGx6FgTmnpwkR5axvBSmmEf6ej40SEwyBV8tK6?=
 =?us-ascii?Q?CiC7//fjLTV0xy7yrFDz0xVjo4spT7fTD9G6OFyjy0aRrcvr5pP9Q1DukKIl?=
 =?us-ascii?Q?ixRovtBk9WvqnkxWngs/a34S+h0onMDxJZqWtOnZ2Df4MNJ7WUZKsRB29WmU?=
 =?us-ascii?Q?cvqS5NPcKijukyhVGPQTLHaVMKPDvYuKbkQF8Z2UR0MJxJcglkXwjuuHCV59?=
 =?us-ascii?Q?fr5oIt7kAaWt++I+l6KBbdHBK4gwXAICUEhckb+3A+o3RPwvu9AAoZ16CN6F?=
 =?us-ascii?Q?5nZcQwe4lIPFllM+ILWYf8xuRedMwcK/aiz3W9un9pVjVsoAYTpTJPGE0GGS?=
 =?us-ascii?Q?kOqOqHoTI1t7n2AQexChYELtJbUSg5qO7kiVyinHzBPWd4jW+j2q0YDZ0itb?=
 =?us-ascii?Q?PUHmtXKh0PXCfFGT5+F+O1XfUrFKHWHsjm5LMnJgKU+fYGt6y+mYZ4TcX5hX?=
 =?us-ascii?Q?42mKeImSvteVHoocl0m8/Dbycb/UiQ/aGuBDQ7ceuR9jvP0lcD0orj8yR5ku?=
 =?us-ascii?Q?n2s1bq1Sb5OcgB3QR5ovdkM6GCajYdxq+MhnqHszcrzPprppNLPIjdHjpQkP?=
 =?us-ascii?Q?kkyGVnOa7IgGo/lcR8IOQbLNYPjGotvVcnLPlb0OFSVrl7u59dSleEEx204K?=
 =?us-ascii?Q?COBgpRnEcph7lHTTrqNCskj9kc+vq4H/vUUNDpyz4E/eMVl8XZ6n93MUBmQm?=
 =?us-ascii?Q?y7zrip92ZHmTmPhyxiM+5ZcCoxvWhBs2X7dc6V/en3ZUiTwlIQvBdoayOwZ+?=
 =?us-ascii?Q?MEsiUto6JtwPDEXV7jIZYm+xxE0PU/T82SuZ3ZFEkB997d2l2hqOGg0470mw?=
 =?us-ascii?Q?Rj21WBPQWNVm3uRzXSjEXK3WIMhyWpnjOsBhyT/YvVoFYJyrT7vtfPj5+Yr7?=
 =?us-ascii?Q?VuaweH7IcuBGsL4ridOckR2rL+lUOZd4gS3+uW/Q5RiDFn5LLRsWVsGyNDJN?=
 =?us-ascii?Q?0Nu3UYjwrsKlvrm+8aTdWBh/qtnjumJSPNicKXwswPTRE7Epe/0SnbzVMIvD?=
 =?us-ascii?Q?nDs62kZ4pSEttK5PbBAHTt8pq9ub93xVmS6pZOc4SJmvzdDekBwZIzrc290R?=
 =?us-ascii?Q?Lfwc8uKVvfFdKDZPruuPNna6KBkuiYHhTHvSEFaCUJrfJn7xqmfb5e2D2Mzl?=
 =?us-ascii?Q?rjmW87ioG3mNWhw0p78d2Nd4nRSFNv/XTYbLcyTH3bti6bQBqeCheZ4ZQKbs?=
 =?us-ascii?Q?PtWjkCtudTu9GNVTHP8CBq9Wp3q7Otneoy25HvhAlFJxp1Dsthg2wWbj59Lm?=
 =?us-ascii?Q?catH/6+Vx1kJHFq6djjSVI4jabKM0Z4WrARNpGyx7Qzu/fLKKwpvkv//1T8H?=
 =?us-ascii?Q?V5kren1YnlhcBcCjBk6mjiGiEyCW0JA8lQM41S/dPE/aCABge+GW6ZuRKGNH?=
 =?us-ascii?Q?m9m3YFS4qvVy9+O4JZCcwLGUc/bKmY6P7nyeMRABa8yyhr+pvG8ST6M699/j?=
 =?us-ascii?Q?DCtJf8iiJIH3qkZexyq7r32eQ9+C7NKYbj5fTo3gqgfDg6V0P9kvvi1Y+yCn?=
 =?us-ascii?Q?S6riKKhCWR39j/m1on+JYW8RZIdvSapamMhViQPUT8vCLZ4cmxOX6k3ptBjU?=
 =?us-ascii?Q?tE6YOQ9OLZCu77wairoZnsm8Pj3tHhF4J75H8RvJi6VMgnj3FmelobJw0NgC?=
 =?us-ascii?Q?/eKR7U0yr6izGZtd1Y8Rf/rnOqkgT+GoCUJ0hwYnSP+YbcrW7Z99+FRlvesr?=
 =?us-ascii?Q?Kt5rtDEzX+4yFj8vwJkMvZy/87avFKnklIjmlzAUsfews3IlFCdm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3a650c-9192-44d3-5414-08dec6d51e52
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:17.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajVaXRpyoQA9W8ZAcsjOe/akBmYob26qqgGgYdHCFgbL29g4+wTJPPF6RHLk0nTzGH7V0zoBiKJQHEHE232vD/O/IwYgqk1wVi8zXgRFw1WnX9bxQHRfSINqaJ2YV2tF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297570-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C83A86680CA

From: Wei Fang <wei.fang@nxp.com>

Add link status message support to the PF driver using three command IDs
under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):

1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
The VF queries the current PF link status synchronously. This command is
not used by the Linux VF driver but is intended for DPDK-owned VFs.

2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
The VF registers for link change notification. Upon registration, the PF
immediately notifies the VF of the current link status via a PSI-to-VSI
message, and continues to do so on every subsequent link state change.

3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
The VF unregisters from link change notification.

PSI-to-VSI notifications are sent via the ENETC_PSIMSGSR register. A new
msg_lock mutex is introduced in struct enetc_pf to protect concurrent
access between the phylink callbacks and the VSI-to-PSI message handler.
The bitmask link_status_ms_mask tracks which VFs have registered for
notifications and is cleared when SR-IOV is disabled.

Two functions are exported for use by PF drivers:
  enetc_pf_notify_vf_link_up()
  enetc_pf_notify_vf_link_down()

Through this mechanism, VFs can accurately perceive the link status and
report it to upper layers such as the kernel network stack, containers,
and virtual machines.

Note that currently only the ENETC v4 driver supports this feature, while
v1 does not.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   5 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  18 ++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 201 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   4 +
 .../freescale/enetc/enetc_pf_common.c         |   2 +
 .../freescale/enetc/enetc_pf_common.h         |   9 +
 7 files changed, 235 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f7c532758e1c..4b69c19b2319 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -944,6 +944,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
 	enetc4_mac_rx_enable(pf);
+	enetc_pf_notify_vf_link_up(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -954,6 +955,7 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 
 	enetc4_mac_rx_graceful_stop(pf);
 	enetc4_mac_tx_graceful_stop(pf);
+	enetc_pf_notify_vf_link_down(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..7b66c5be1ccf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -80,6 +80,11 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
 #define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
 
+#define ENETC_PSIMSGSR		0x208
+/* n is VF index, which is less than 15 */
+#define  PSIMSGSR_MS(n)		BIT((n) + 1)
+#define  PSIMSGSR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index d9677da38989..43b9ee2ab3e4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -107,6 +107,7 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -118,11 +119,23 @@ enum enetc_msg_ip_revision_cmd_id {
 	ENETC_MSG_GET_IP_MN			= 1,
 };
 
+enum enetc_msg_link_status_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_STATUS,
+	ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
 };
 
+/* Class-specific notifications/codes of link status */
+enum enetc_link_status_class_code {
+	ENETC_LINK_STATUS_CLASS_CODE_UP,
+	ENETC_LINK_STATUS_CLASS_CODE_DOWN,
+};
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -161,6 +174,11 @@ struct enetc_msg_mac_exact_filter {
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
+ *
+ * Link status message, class id 0x80.
+ * cmd_id 0x0: get the current link status
+ * cmd_id 0x1: register link status change notification
+ * cmd_id 0x2: unregister link status change notification
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index a89a5a418a23..eac71f90d80b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -136,6 +136,148 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
 	}
 }
 
+static u16 enetc_msg_get_link_status(struct enetc_pf *pf)
+{
+	struct net_device *ndev = pf->si->ndev;
+	u16 pf_msg;
+
+	pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			    ENETC_MSG_CLASS_ID_LINK_STATUS);
+
+	if (netif_carrier_ok(ndev))
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_UP);
+	else
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_DOWN);
+
+	return pf_msg;
+}
+
+static int enetc_pf_send_msg(struct enetc_pf *pf, u32 msg_code, u16 ms_mask)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u16 old_ms_mask = ms_mask;
+	u16 ms_status;
+	u32 val;
+
+	/* The MS bit is set, indicating that the corresponding VF has not
+	 * read the last message, PF cannot send new message to the VF. So
+	 * the bit corresponding to VF is cleared from ms_mask.
+	 */
+	ms_status = enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
+	ms_mask &= ~ms_status;
+	if (!ms_mask)
+		return -EIO;
+
+	if (ms_mask != old_ms_mask)
+		dev_warn_ratelimited(&pf->si->pdev->dev,
+				     "PF cannot send message to VF(s) 0x%x\n",
+				     ms_mask ^ old_ms_mask);
+
+	/* Writing a 1 when the bit is already set is undefined.
+	 * Writing a 0 has no effect. Sending messages only to
+	 * VFs where the MR bit is not set.
+	 */
+	enetc_wr(hw, ENETC_PSIMSGSR,
+		 FIELD_PREP(PSIMSGSR_MC, msg_code) | ms_mask);
+
+	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
+				 200000, false, hw, ENETC_PSIMSGSR);
+}
+
+static void enetc_msg_notify_vf_link_status(struct enetc_pf *pf, u16 ms_mask,
+					    bool link_up)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_LINK_STATUS);
+
+	if (link_up)
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_UP);
+	else
+		pf_msg |= FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				     ENETC_LINK_STATUS_CLASS_CODE_DOWN);
+
+	if (enetc_pf_send_msg(pf, pf_msg, ms_mask))
+		dev_err_ratelimited(&pf->si->pdev->dev,
+				    "PF notifies link status failed\n");
+}
+
+static void enetc_pf_reply_msg(struct enetc_hw *hw, int vf_id, u16 pf_msg)
+{
+	/* w1c to clear the corresponding VF MR bit */
+	enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(vf_id));
+	enetc_wr(hw, ENETC_PSIMSGRR, ENETC_SIMSGSR_SET_MC(pf_msg) |
+		 ENETC_PSIMR_BIT(vf_id));
+}
+
+static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
+						    int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
+	 * need to set link_status_ms_mask and notify the link status.
+	 */
+	if (!pf->sriov_enabled)
+		goto msg_unlock;
+
+	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);
+
+	/* Notify VF the current link status */
+	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id),
+					netif_carrier_ok(pf->si->ndev));
+
+msg_unlock:
+	mutex_unlock(&pf->msg_lock);
+}
+
+static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
+						      int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	mutex_unlock(&pf->msg_lock);
+}
+
+static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
+					void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
+		/* Currently, this message is intended only for
+		 * DPDK-owned VFs.
+		 */
+		return enetc_msg_get_link_status(pf);
+	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_register_link_status_notifier(pf, vf_id);
+		return 0;
+	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_unregister_link_status_notifier(pf, vf_id);
+		return 0;
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
+/* If *pf_msg is set to 0, it means that PF has responded to VF in
+ * enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(), which also
+ * clears the corresponding VF MR bit in PSIIDR.
+ */
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -211,6 +353,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_IP_REVISION:
 		*pf_msg = enetc_msg_handle_ip_revision(pf, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -236,7 +381,6 @@ static void enetc_msg_task(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < pf->num_vfs; i++) {
-		u32 psimsgrr;
 		u16 msg_code;
 
 		if (!(ENETC_PSIMR_BIT(i) & mr_status))
@@ -244,12 +388,14 @@ static void enetc_msg_task(struct work_struct *work)
 
 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-		/* w1c to clear the corresponding VF MR bit */
-		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(i));
+		/* If msg_code is 0, it means that PF has responded to VF
+		 * in enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(),
+		 * which also clears the corresponding VF MR bit in PSIIDR.
+		 */
+		if (!msg_code)
+			continue;
 
-		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-		psimsgrr |= ENETC_PSIMR_BIT(i); /* w1c */
-		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
+		enetc_pf_reply_msg(hw, i, msg_code);
 	}
 
 out:
@@ -367,6 +513,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		mutex_lock(&pf->msg_lock);
+		pf->sriov_enabled = false;
+		pf->link_status_ms_mask = 0;
+		mutex_unlock(&pf->msg_lock);
+
 		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
@@ -379,6 +530,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 			goto err_msg_psi;
 		}
 
+		/* As PCI SR-IOV is not enabled at the moment, there is no
+		 * concurrent access to sriov_enabled. So no need to use
+		 * msg_lock to protect sriov_enabld.
+		 */
+		pf->sriov_enabled = true;
 		err = pci_enable_sriov(pdev, num_vfs);
 		if (err) {
 			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
@@ -389,6 +545,7 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 
 err_en_sriov:
+	pf->sriov_enabled = false;
 	enetc_msg_psi_free(pf);
 err_msg_psi:
 	pf->num_vfs = 0;
@@ -396,3 +553,35 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return err;
 }
 EXPORT_SYMBOL_GPL(enetc_sriov_configure);
+
+static void enetc_pf_notify_vf_link_status(struct enetc_pf *pf,
+					   bool link_up)
+{
+	u16 ms_mask;
+
+	if (!pf->num_vfs)
+		return;
+
+	mutex_lock(&pf->msg_lock);
+
+	ms_mask = pf->link_status_ms_mask;
+	if (!ms_mask)
+		goto msg_unlock;
+
+	enetc_msg_notify_vf_link_status(pf, ms_mask, link_up);
+
+msg_unlock:
+	mutex_unlock(&pf->msg_lock);
+}
+
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, true);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_up);
+
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, false);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_down);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 07bb9aab89aa..a5c13a4cc197 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -60,6 +60,10 @@ struct enetc_pf {
 	const struct enetc_pf_ops *ops;
 
 	int num_mfe;	/* number of mac address filter table entries */
+	/* Message lock, prevent concurrent access */
+	struct mutex msg_lock;
+	bool sriov_enabled;
+	u16 link_status_ms_mask;
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 44c546b77d3f..e3bed5580d17 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -458,6 +458,8 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 	for (int i = 0; i < pf->total_vfs; i++)
 		mutex_init(&pf->vf_state[i].lock);
 
+	mutex_init(&pf->msg_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 5bf7c20aba42..bbe21c739cf7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -26,9 +26,18 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf);
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf);
 #else
 static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	return 0;
 }
+
+static inline void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+}
+
+static inline void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{}
 #endif
-- 
2.34.1



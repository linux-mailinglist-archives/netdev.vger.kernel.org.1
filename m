Return-Path: <netdev+bounces-252611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONVzJLDdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A006FA65
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4E6303C534
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30838B989;
	Fri, 23 Jan 2026 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gkb8a4dI"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72663876C7;
	Fri, 23 Jan 2026 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135078; cv=fail; b=S4MvqZRg/AZxh7g7kCth3hYQQ/GeghEGVVhZMb9Nri3+DtZYIhKuzY59AvpvyAgv8Oewd2ecYW1CcQYd3N6ECpNgwqIW7hYmjJeEzyQgtGaTUGzUd+Rq7wO6IYjBffnJQkybIWMn6jEbL6dVtQcM1vOA4wTxdljngaCTsRD2Kgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135078; c=relaxed/simple;
	bh=nmnr8WXQJZZbzk5Xh+fdWh9kUX7kgdnP6iYq8plSmrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uM7ztR4PqrZc1QkiIytRfhQusFsIoBLJn71oGqEj+D4u2RF7Io1QLWLXlynpBrNGxjaPR8Ca1gkuvfR8RWjqicwccLLf6g4fRCMQHhpjn2Qb+piRjX2NrTwoRYghAtBzUziUIj2oFKlFOI2Snn4yhQNbhMclHHevvScUvtyBIcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gkb8a4dI; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEJWQlylkg37sVrRX1YynyhOJ5U7k4MEOfAhKH2m/L9RoIiq4ZoLmffiqFvuCI2pIaZ9eeqzIbNAVie+B38RDVDZAX8rXvMuSrVldDW8Sg4K/eGmaB5r8RiY/50ehk3fkQ4Bw7x5tkjntUL8ExRKDR+RbADkZO7YE8bvfR22BVejIlB3bafm2nIaCGHwJv4/DKcn1yEJM8O4SDSzvmnL9x4fHNnRt5AJcChRn8bX0mRkV4zWpE9l6ZlhlGRXCO8uVjnRl7codG6ilOls9bBX8a7t1jYi8euwj4Azgpbp0Jw4kdCPmAxn0YUfRsJmYnXJllvFRrFoSe2aSvXpubiREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl2ZK6HUfn9ngvABJCFwenjm2BF/j9qYGh4O3B/Zn/M=;
 b=dDFWplA8scPE+YcPJCnQHlQ/Ts+lDTscGHXT6r+VK3tCbUDC7qD0B5HIDhd0A8FzrzTeASuN7FOd5CGN4ORsaSLsX4eaaGbFoImdCEZmU12WKt5z2xxebJWzolGpDYxBjdlfTyj5S1Y1fM7phaMqnFpBq5itIrR39o1BfS5S8Rm76d/H4mEebhNIYhN/2Fa83cRltSlsN7qPAUzbIAd1C7zXnm7cA2V111qRmqowF+hpZRbDMSqZ1b4Y30KQLroObgAfVIff4VOwY5DoSxDx5lOwB0uoLQEMGfNViVZclPLHTifwmhXGCVbskvHaKGRG1WIPFD+nO74rbdG42pW/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl2ZK6HUfn9ngvABJCFwenjm2BF/j9qYGh4O3B/Zn/M=;
 b=gkb8a4dIc90pBmmWpL56cKSWBK2kqA/apf8mo+ihuKSvCv6ZjsVS60b/984IdQmC64pjv+GImWH1h1Yp/3QDZhpsPP7+kj+Jp2eWJfVbmNUrHwPL/cwuCvfnAeKJ3nOCvNtLnC/XdVPRb33Y+ROoxQaUPmHE9by4N/4SnQydLHLPkLR371iAMdDEWZPs+DGoQPKQ2XYd+fjSkUu/ffgKKCkWNdWBdEm4UvzHFUwhPJitgvB+2pN14isAi2V+pQpe+/sB2UhSb9DZPRO8lIPwgNN/zn6+nEFWiWZrVtHdCsCQafsrK/7w/tf3jDYozU0nUxvJQItpP0AhxoOrdun5hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:54 +0000
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
Subject: [PATCH v4 net-next 11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Fri, 23 Jan 2026 10:21:39 +0800
Message-Id: <20260123022143.4121797-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c688bb-e2dc-4bc6-82e7-08de5a2650c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCI3q/JUjIILMIbKEI0Q/To063s2YfKQgl+acGKqQszrTFwChNLtS6j6NdPj?=
 =?us-ascii?Q?/wgveJqdZgpAQPhosnPCVOV7tgh+0miPOVI+Uaded63i/HTPeX4lggaUdUDC?=
 =?us-ascii?Q?peHzc6jctLDGEHjC3VE6cnFEjFfKRGMfVyPR8caBL2k89zoB8GidjpfRX/QN?=
 =?us-ascii?Q?SndnE7jtWeu+JwQPT2h6+ThTmbX8/nCEz5PV/2+X07nRvg4BXtD0fNq5h1Da?=
 =?us-ascii?Q?11jtB5oPJrtA42YfF2lgvMwle4NqF6k3gVkncnomEHYrGMC1BgilxQJTyDjg?=
 =?us-ascii?Q?kl1nGVFbYXrRFN8J3t8s5Y/rSaINl0ledjx3rEFd02VoFR1kWE1E5dEjNEGP?=
 =?us-ascii?Q?y1IjZ5eg1nGwcF0GqtrbUpUDc+Li/f67ABL2QpGJ03H2O0SA9PlolyTNVy0j?=
 =?us-ascii?Q?B+zPqwzl+P/hSjvm9yJq1nSosfdL3YJut6Lw0lhaeIQwJA86Kpq+uWhTmM8s?=
 =?us-ascii?Q?mNRQ+ZZP43OOhKAXmHiVA0ZwUl3OdLbv7HyYO1tIoddQucXpAyLr7nwodpVE?=
 =?us-ascii?Q?RSq8Gw5Yjy6zpH9Wv2PHzUxjBEH3QaQfDz6ODCqeglzNQSfaTfrdCnXBM7pc?=
 =?us-ascii?Q?OkrwR6JRIB1zIKcBo0XxZkeqG/GscsyYcSX96Hm3+MjwbmcqPo0eLRnTbPW4?=
 =?us-ascii?Q?uNK5PmXlSi6EZXHqN6ltjXEA5v7QYCwAEGrdcS0u9lg/+3vJ5Q0rK0Ydks1v?=
 =?us-ascii?Q?cUpmP2C3KRn85tgUxyIa3hyI9EmCTdlIlNDfjSQVsgoVVwvShbW1xOEUjV+7?=
 =?us-ascii?Q?LEarotLtZdgc+8WrExFA1YPxQGsj1PYe+sFcdo9yagwUMWrpClFx4WfmkYmL?=
 =?us-ascii?Q?+LYT0FO0fF7tfWDnyk/c0X+CkPY06cAKes3z6XFmal05BdOl19d3LnKSiJWO?=
 =?us-ascii?Q?4luoEHj+kK+wRcakUZeEhQoNdixghcbqhhajJEtsE65pxm9YXeslQTued4Tv?=
 =?us-ascii?Q?JgL/MkGa0OJhuEsiM51yAHedMbyL8faj0vgelmvL4B4LTTsZ6mCGbJbbdu9L?=
 =?us-ascii?Q?3aq9pzexpdIJb8VwR64z0P5mNcTPamUwvaj8JepygJSJRaDk5jHMTjI5d4PT?=
 =?us-ascii?Q?KUIq7ORZsuNNVXhcOzgHpd3aRr6T+LvQTu+nOg+dcAQiYw6hZ1uFVVxjR/4b?=
 =?us-ascii?Q?wuYP8TEHOafWfm0ikerFlGMWJBUq9FY3wFwkk3IXIeBeypqAlHm3E59xr2EE?=
 =?us-ascii?Q?OUSSoS9zn9kgl9tbx/yntO2J7TsbuWPXu2RwOIKXaP6NqeRm3mB4l1fTTgGy?=
 =?us-ascii?Q?UX9yQ8GEkPZs1zmXhw3L2UBM6+HokVbMdcUywASRAIV8KWyKIg2bDJLdFkex?=
 =?us-ascii?Q?m4A0c/YjAKxTTHePPaC1kfUu7yrjPt01LzRXXrt/dSEa3O2kBynPG9zeBI6V?=
 =?us-ascii?Q?KLJ0T5y4WiLUaYPvFyUXtjft2DnAjXGXXciJ0uFS1eiz97+cJgCLX6/LeprN?=
 =?us-ascii?Q?SVkk9ACnR7zBfTXYLsOrqt6/fRBWEczEiC0faHsY8ln/1tfNUaq+rlzKwQTZ?=
 =?us-ascii?Q?YpdJDQ9WaSWEShCZ9hfByihoMLmh8ESwMel7KDydClZXp/I5U/J1fptjaV31?=
 =?us-ascii?Q?Q9seXTCOS/M3FaZKSkb3H6+za0zx489uhqcLLZCwITtEs+jrgExOuW1hVbik?=
 =?us-ascii?Q?+F+SVcSYCAXb/AvHq6W7CGRwAgi4eSwtnD/KPmfkNLqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKXYkiPGvvtK60dE1vsPkz/viDWHKf3Hz18mig90UO5PXkBZ0cppb5kxV1hu?=
 =?us-ascii?Q?xnqNxM3WkRzAY7dvVjVJpbcrgB0v9L/lbxbEB77Pbw9mLQSDfM/kRgbvsLdt?=
 =?us-ascii?Q?1Rl9eUJTiWfTaGTic6ff37WvX/8i2igDutCvthz+GUXRqJp4xfthARQ1UJT8?=
 =?us-ascii?Q?342Sq8J1dz8aVsRLSpXBXuAmv0GjoABhvFduQTk3sfAfIFC+qXEqHUFInXgc?=
 =?us-ascii?Q?Du1ncYEwD9KcUFCombArQN3mUcUD1aySRMDzUf09MmlE5dU4VdtxJm7/Mjiq?=
 =?us-ascii?Q?7U4N6IdmsUGcjDNe8mhBqh9Eyd+YRI43CjDyEqg8n9ad8EEuTba0AgUeuejH?=
 =?us-ascii?Q?vaK4vbIbN6nz9dGoluFTdK81VmIGinmMqrDxtfc1/mGmIJ/joNnHTzhRNIcU?=
 =?us-ascii?Q?3hGnCMlT+ee7T6tKBCRebvw4woCWxAfAOXql5tPI7tbOWtcYIcCp++RMbCOv?=
 =?us-ascii?Q?fPmphCM1YchMIi1iZQwgSgZnJRUerviuIDxD303ebeTbuAkMEA0vhpxQHG1J?=
 =?us-ascii?Q?/ft03ugp6cdIFx9IQrNS0sDS6+SPNN98Th4PaR6LgywFZcae6ugY4mxPFuu0?=
 =?us-ascii?Q?BYDb16zk9OmruUgN5vhbqQyBLSsCnQVx1C4YywqyZZ36iKnleMKQLIwsREdQ?=
 =?us-ascii?Q?wd7zafFMYX6oMNAg9nC8RYZdUGiZFthmQH3nutp+Mt4r38NCDonV3phHTG7S?=
 =?us-ascii?Q?lZZNuJJLyNFCuBtx20ZvomP9orDxQO7cQeIOGopDVduwP5lz/K2LziuuGErP?=
 =?us-ascii?Q?EAp8032pCkogWKd98NDb4DnDx4lDz3iejfaZ0G/72ERObq5bk3v6bSP25jzV?=
 =?us-ascii?Q?WlL6CdS/m9HAQ+qrovqxgi1MEFrVAr79VqFIJ78MjxD8oKKhlXAaMk/WNxhl?=
 =?us-ascii?Q?AZRBxPuNXyOfzx+e9i0SevzC8/ERz/jlVbJP35dRptHJTJXsgP9fzAnYmVaj?=
 =?us-ascii?Q?t+11UhCjxHEkXIWai8FT5KJdWx8sBNpsoDvr6Bd4pzXm+uk8ryPEZKlHLbNH?=
 =?us-ascii?Q?U8woLycN4LSu9KL5A7M4TL5iPvk9/lHv+QFCa34R0OTAho7DOP1hDx5M6V02?=
 =?us-ascii?Q?pXshWWFyP51oAgFVhQU0h7G8Omyc4bK0VfyV+t2lkft9S+Xp5WhFCnxTTh6j?=
 =?us-ascii?Q?XedEKbCTQ6sM/5kmSJeD7ANuKTP7F19KgzeWHikEXr+lcW9uZv7YwMkVFioD?=
 =?us-ascii?Q?GJ29CMAeRV9DPPTeKzjhRCBgHvLFqtzY4LSwfQjTw97BUwUzt7jGAr6huPnt?=
 =?us-ascii?Q?2IabhV5sYwbO27EHs4ZotdxbthMOIyKsizsV+w6KabPYnwZFO/9hky/1Pif7?=
 =?us-ascii?Q?pomHT9B1qn3djJKFpY75xoyPdTABDCDwQ8R/N1HbKibFQs+UtA+veaoMClOn?=
 =?us-ascii?Q?z8K7NDGtx1bYWLwjpPJuXEdsWWm0iVLBg3Ae0cntxtZp8C3UXX1xr6qsw56u?=
 =?us-ascii?Q?eyiCiaN72W+7Pm8rv9ryo+CbPzTipzzx7Pe/DQa6g5bJLvBJsXC9CV1mJeVI?=
 =?us-ascii?Q?gAnXYcxfpApa+brzs0OqbB6nSYylPXrQRitHaoMQGAPrUzwjC6myJZUaxNFB?=
 =?us-ascii?Q?DHEjL+Ya91GPAmMYK88X77wsbV2ci72bs5VBsF1o/Kqgoa/SnK14m4suPzYv?=
 =?us-ascii?Q?Agh9m18uUTwXDMIGb5iH3dwNgL+AcZfmAcFgvmfpL/ajLX+RR5MKvqD3zArp?=
 =?us-ascii?Q?uYpUDAgE8x04iOFW4eYiNEDNU4+mPlykKfEJireoyEzYfcBSyeSFGkskluF/?=
 =?us-ascii?Q?GzgjqELQgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c688bb-e2dc-4bc6-82e7-08de5a2650c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:54.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd49oCQ5UpUgZ1HMV3JLaySK2lIMr7cmOyZ8sNedG0+eH+uezXUdFZboWTjJYqCVrbvtwhPRO+Aj5iba2GNZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252611-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 24A006FA65
X-Rspamd-Action: no action

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 25747b9aac28..4f230767dcfb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -467,13 +467,13 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 
 static int
 fec_enet_create_page_pool(struct fec_enet_private *fep,
-			  struct fec_enet_priv_rx_q *rxq, int size)
+			  struct fec_enet_priv_rx_q *rxq)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
 		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.pool_size = size,
+		.pool_size = rxq->bd.ring_size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
@@ -3552,7 +3552,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 
-	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
+	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
 		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
 		return err;
-- 
2.34.1



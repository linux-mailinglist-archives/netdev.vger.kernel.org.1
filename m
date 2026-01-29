Return-Path: <netdev+bounces-254726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IP1Lv85e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:44:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92FAF021
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF71A30780E4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD6388867;
	Thu, 29 Jan 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ciDeym21"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AE388863;
	Thu, 29 Jan 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682942; cv=fail; b=L0FFyvODdnUSz5/mtZ8yhnN6uUvjp+Euk6Fqq8viuxW7NIqwwijAw2/woQEGT/Kj53P4qGSDf4iWhkC7MoSfkQPSksQu+4YdsVtdwCHRGJPLkQm17ZulPFuGImcqHeRDyOhGm7RUscOLk5h2lntOSDp3OgWAGhx7/iqfBIedAaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682942; c=relaxed/simple;
	bh=VcFh6zONcvzvqPvg4GTcx4kSpwjdPF60B8c/oFScvV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNMYtjoQenE7nwODR8/EuO/v7Z7TglZd+yU6kzOu1XZ5sRUri60f0SKVY0d6zQ1C+tb8/i6Sad40dmf1e4bMrEePchYJ5amqBG44yMNkW6MYlFnOAy3cfkhCBj9VGZnI8n+B9IDiYlMZG0WsqcYl7eqGEIlkLAchGfv6Pvo5/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ciDeym21; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL8XYwZQfIXprgPfzrVDPdLYohmkwCuUGMx29gRKF71K0pvXcRZdN6hyM/QZWzL0gHc+tWmk9P6ssMu69u3Bv18mnwol1QMg4pqhDW/5Nv/aDd7uKRv2YkUxfZqZX+/zCg3tIH4b3f37tajoXWlOGfeJbvsyL+uQSqDEpEFwjCWLZPpA1Qp0t81O2ISFKbzPI08n67soRu9e2w6mRwgTzaExk/J/GpwIuuNVu6Sdxgcvq+PEjlxlPq3d3HHk56f6ZJWai3OsXAxGAw3u1wbMZXaICzk5xWIgHbAiKOFwPH1AT+TvoJwvHBV6+59nOjBD/fpguH30MLEJjdLRJ6qpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDlMl47rIxeIUYVTrIyK/MkbZ67PZ+kApkqBPI7b8jc=;
 b=FyIsGLHldI+JBWOf0uoNSi3xJi4w39M5m/TuYYzBRgbLeXpClioY8NKa5WCwsUT8MdZ34vCZB40xoQmNi5pD1lCYc5CNB2pId8ZzI33rGrZzk2e6tkTN51+GOZ23GhCmlzVjkt28p9jCUMxL78Pi5tPbpEqvTOk48kcRGogPcFh/PyxR48MhSSFZqs527+bbRo3eKSF4DHO+sAhcfT2TBRaiymNI3fAOE4rIc5PtJlLN+zKeMa9tE2VNKkbkKPF/hIuyr97t8+lM8XbQOL0c4oAw+4YbFDupxK1JUGH2CKuqO/EJ02LooKRxHI5z2lUfTO0jTISJ4KFpQQ8Q5GWyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDlMl47rIxeIUYVTrIyK/MkbZ67PZ+kApkqBPI7b8jc=;
 b=ciDeym21D4/QdA7eOatKieDpffZzyDBObkPnpf377Gf8+wpguh7EYCzFTiyAoQ0naM/J2RMEdwBz+0AUA7UzEZaOr92UTSGm6jLJDBa5l5TPcdBJl+S1D/dk1AibZLvTXERBcSrC3KKguOYiZff+N7bnl5BNtJTC9dZr6jjot3NMkZ743g63wG4FYikX4Ne1Unf5wYhMYSQ4DzbV5vJgm1aI49AqDluHwdUZhwUgquCo8FbGqRCtNK54zJHInnmJXcaOziL/9dwBK6bzPYOgFiQdzrYr4+mclgnzsN2ET3eErNBz+oWn8/DmSNM3cj1ZeRKgWFfcYbYGMxJWl9YVTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:37 +0000
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
Subject: [PATCH v5 net-next 07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
Date: Thu, 29 Jan 2026 18:34:39 +0800
Message-Id: <20260129103447.1893129-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c82cbf9-d5bd-412f-081b-08de5f22241b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPHqujnmWljgd6GJS5Gs1S2D8XHCkk3BewZ7y+3NgS5vMB5Xl5BMmAN3dnxl?=
 =?us-ascii?Q?q2rf9xbV9acrrqa+bjiDxkX7PJrisQlpt6TPGhK+EGhcO+FcJHsdM0gKbczt?=
 =?us-ascii?Q?zTj8ZjbeV4B6W2p+ku3cy471XV58HqGjrte7Tmvq4KIU41N8nVlJeLDaZC9Q?=
 =?us-ascii?Q?3WGtupCfB/10JBcWHmPMB5qG4Iz/me5ihvWQarsBsIMdBmHdGfFyHFzFRVkX?=
 =?us-ascii?Q?YhLNWCh/cJJ0AdUi8J+VRPdJRLo3q5JrpiPM/6X2tmrb/8n7s4N5tEz6WK1l?=
 =?us-ascii?Q?onQ07FRm99zkIj7MGURbTXzkQxxDBRuiG2TpPLIvI1pF7/P6gpg2X5b72x4E?=
 =?us-ascii?Q?Yl9b5Vza+wo1UODFGxYlMZyAe14GwP8bCIYLIm0ObAbanQ3I5yYoI6hM80Iu?=
 =?us-ascii?Q?akK/s2GHN2aLTpvX4PnblfVofdUnCEa+4eOTIc9neGeEcqAdchaDcNmnc3pZ?=
 =?us-ascii?Q?C742xUlGXcWIJM8Wps3kugji8Ev1+11vUrHEbGn/cM+hzHj3bB11fRUk5R4i?=
 =?us-ascii?Q?NMhaGThpdi7DwJsHrNVrV/dwpK0Lmm/wDGCthY8QEdgEyJogZ5ojNDCZznG8?=
 =?us-ascii?Q?gHL4zHabNtYF2x0zl9ygYL5nY9fObWYvN6DcDJSkUp0fAVE74/ntJ5qmfDf9?=
 =?us-ascii?Q?Uzv4PkdacU4a6NBY7p2G4RWxBi+bA0rvHBH/ZYcrsWPLF2NAO8GTAgchebia?=
 =?us-ascii?Q?kaCRlNTzcquwwwJMiRL00s9kxi+1V8jp/011kAoANrPewmOe07uNgHAr7/TX?=
 =?us-ascii?Q?/zT9tQ6DnhVQ8VCHCg51FuE1mfAPPw1aqj7wT9MxPXsjCQLCLl317B/bFJIQ?=
 =?us-ascii?Q?dDxuC58mCxX4rsXykvCSr5EjOHtGu15PisIqKMSILvEbBX5MSZLYlmvlrg4I?=
 =?us-ascii?Q?fgypcGWRx5tuyQAhW3JhbUK66VSmdbcM/cQQpMyUQ3vre3Gp2SqJMOCo1kbE?=
 =?us-ascii?Q?tbBWb4i8Jw14bHtQvj0hQ5AVcpiyGggdaRLj5+0zATCNsr+yYGYu4goEw+fp?=
 =?us-ascii?Q?o/wZIxIDg1pGJj9Q0fm7kVU/ouY7WH+zcoo6v+Spwg/1u+rrCPtdV6fYX1Bz?=
 =?us-ascii?Q?n6i5c5hca9aeWhn2LjqkV49OaniwMPL8BPyGmqRVpP1AqL0gH2l9ur2jdRsS?=
 =?us-ascii?Q?XmJyNqsH/k9si6TV1LEIqFpRA66KOAlV9OLNHoSBJ563E1GsjVQ2YV+li0es?=
 =?us-ascii?Q?7SsIAD+vnWgWpUE//3YAy4QDb2xlBsALycQCRFpP175Q5/YG7oZ9/Z7DkeWE?=
 =?us-ascii?Q?YfxzrnVCiIjmnDA1E10LnkSTiVCsRXVEUMoPyhY/RLtY291zYIg6FufSXF0C?=
 =?us-ascii?Q?VVT8RzJ6B/N+5uzTKvOkajZUL4sGgPDKZBHjvXD5DlvkNXDYZhatErCyBuwo?=
 =?us-ascii?Q?lDEeGCRyUVck+sf0GMRZ/ChgGrk0Y3SibJoBB3Vl13Wytt16phU8Ql9m7ABP?=
 =?us-ascii?Q?9dqizfVgYhRc09I1FGxLbZg4DbIlN0MG/LisJXsSu2z5USalLcwfxNhjpnmT?=
 =?us-ascii?Q?Jxa7Ns242uBVARfQ86BXX3BinUYvum0LZKjDdm61bRCVf4DeFPSKL04pDf3A?=
 =?us-ascii?Q?ar/i9pWvHm7U9QkUg3P57fJizGuFZkJALSe4VivnuRtM0+wLjqxblyAPOylH?=
 =?us-ascii?Q?zKzNAEeD0b8UgYHx4zma/Og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEPWS897O+GSQhdhT2+APU7IMEKNDTQodmgV+U95BfnYfK7sqd5IBExe5zEI?=
 =?us-ascii?Q?e7bJ8OjHUijVm2a5sSTWiAN9mVfgWJFl9Z2hjVTNdVFIhNWLMzuIWrVq4piA?=
 =?us-ascii?Q?2a6rAgbRF1xycShxd+v/rnLX96NngmOQ1Y99Xj1fvMfJXJAxqtNjhIIZsNg0?=
 =?us-ascii?Q?TVHC3poUGhLmOGvxXEooNJmjcjTl/9TJFr+84nOu5oruhzw2yRiiEUSlKbW7?=
 =?us-ascii?Q?DBm6I6BOr+TX9+05rEqboy5yUdynIBCWIcWNo1tiH+bYZ51vyDp/0C3VRKaF?=
 =?us-ascii?Q?/Ko4v6URntXKwHjEXXuQMbd8nBnsYPM/49P17anGgZ0oDyxNnoNKCjgMSBfF?=
 =?us-ascii?Q?K5NJt5/HM+P2vc0rkTZDxQbsaos8QC9TpDo7VW6aBoynKcrh6ZL5fQtSuLYv?=
 =?us-ascii?Q?8qArTKk+ovsn47gT6ZTddG+83ffSxGk0wEhZ4NX+xFqmtIE0yuZx4eFDte4Y?=
 =?us-ascii?Q?9SoQsAi+H1d11PAKLZgWu+v3it2ncEE1ijO67n/qLtIs0nWMGjDQMmG3ao+w?=
 =?us-ascii?Q?2Ol+bqu6tLkkEcqRaTL2VV9b6ArZxZ6f9llqdTeIbzRPIDZg0eUIv4/ZXMsi?=
 =?us-ascii?Q?5A1Dqmpp/fycqtsPIasOo7PRgbTRH7wuqgLPIroG/maf7A79BfGkuVYM4OyZ?=
 =?us-ascii?Q?ReLbF25E+0yA0/n6+8CsCUHjdkOQEJcbPC99Gjw8uc+t3hB/H+Bls8/Law8Z?=
 =?us-ascii?Q?rx30EFbcWTPvGjYJbzr6CC0NV4TEqoOGS1iNiqlIsdSANMFAV7+9js+heDRX?=
 =?us-ascii?Q?902XpCo31LQ9mSatqylw4Ta+bX7OGoJYHUW278hHWSDnsDXek9bwvUZ8UPZz?=
 =?us-ascii?Q?zf6IsECcxzdLlfTrCsCnVOjJiZscaKOiTdkQ1UYck/UJ8rxVU+8/mLNPo4mC?=
 =?us-ascii?Q?1BmsbdEElct8LmY6DRLk6k3YjHVSRrHvDmjUckEuhvLSxpKHbSMxrwrl6X1o?=
 =?us-ascii?Q?6iPjgCWbxHw6BwaiYjwoDfUBlVc3LGpXbW0zhK3JKdv3L20t546EwE5/3Vvr?=
 =?us-ascii?Q?mklWgAPeA/zSWZxDQp+Um3ZfEzCBAWWn0EKx5dGn+ilIOACneg5yYKDkvyy9?=
 =?us-ascii?Q?e1IFeUds8Tb/lY8Fn6QBtnyP3IIx9gObwyKn9uq5Igb+XEbgIMJAgZq39Gjq?=
 =?us-ascii?Q?I6A/lVf8B4NVtaxrFNN3ryF9+mB2U1nUKJrV4FbxVtOZaa/lA8Vja5VMMCyE?=
 =?us-ascii?Q?Zdm4QAE2OK8Nc0LxxefZDPA8oILWRO/8GVVHXFbMb07EB2tF1KeM/4B59eN5?=
 =?us-ascii?Q?J0fJPcU/DL5OFs3gf+YWF5m4e6pu/kn/A6H2/6UOiqdMxZlMfWydqRL6yPjd?=
 =?us-ascii?Q?2+TbWMuOIPbXovFNb/+YY+GxekODGFdqDOIsmrp91WtIsVYz1mNZe35btMlc?=
 =?us-ascii?Q?qB6ttfr+kQKhylRTTwumhrLZBafy/Up+q7OmvXxBj3T52HGcRHmawLZ2gNG+?=
 =?us-ascii?Q?cT3XQ+uhTp30c1QSmt9Uj+xpY4Ne7f58x/u21H823h1D4qKfsfU7bsN7lmW5?=
 =?us-ascii?Q?ofA70o3YNT7nzz6RpEo++456AQ3J64PLzJwJHxb/5rrxWunskQPqoOGKAg9+?=
 =?us-ascii?Q?uKOykOzVSxyQEd7fsKKLXE1V7kIV0S4RM0oFyd0/aR3rAclZhHEuHg9umN/m?=
 =?us-ascii?Q?dhoOwU5kOxCwoWKxpf3xkfvn2J2JBS0j9mQP7X74pcy/IXw9I8SMJ8ky0kCf?=
 =?us-ascii?Q?TjI0OsRrGLu5F9uizJW3m3efW0O0qH532aR4jgcZtfOsxrO9p1L+9qNzK6Qb?=
 =?us-ascii?Q?JS1EhHAmdg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c82cbf9-d5bd-412f-081b-08de5f22241b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:37.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R89glDtITIs8X/KbNVbE7GrWi9SJ4USiFoMOclIvmwABq9Z0rzpYoL9kE9w3DxSmdzxaKoFhSWwIKBuaLHe7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254726-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 3F92FAF021
X-Rspamd-Action: no action

Remove fec_enet_xdp_get_tx_queue() from fec_enet_xdp_tx_xmit() and add
the tx_qid parameter to it. Then, calculate the TX queue ID for XDP_TX
frames in fec_enet_rx_queue_xdp(). This way, the TX queue ID only needs
to be calculated once for XDP_TX frames during each NAPI polling. And
since the number of RX queues and TX queues in FEC is generally equal,
the RX queue ID can be directly used as the TX queue ID. In exceptional
cases, fec_enet_xdp_get_tx_queue() is used to calculate the TX queue ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8601b0a581ed..38f831da78de 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1890,6 +1890,15 @@ static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
 	page_pool_put_page(rxq->page_pool, page, sync, true);
 }
 
+static int
+fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
+{
+	if (unlikely(index < 0))
+		return 0;
+
+	return (index % fep->num_tx_queues);
+}
+
 static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				 int budget, struct bpf_prog *prog)
 {
@@ -1903,6 +1912,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	struct sk_buff *skb;
 	u16 status, pkt_len;
 	struct xdp_buff xdp;
+	int tx_qid = queue;
 	struct page *page;
 	u32 xdp_res = 0;
 	dma_addr_t dma;
@@ -1917,6 +1927,9 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	flush_cache_all();
 #endif
 
+	if (unlikely(tx_qid >= fep->num_tx_queues))
+		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
+
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1989,7 +2002,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 			break;
 		case XDP_TX:
 			rxq->stats[RX_XDP_TX]++;
-			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
 			if (unlikely(err)) {
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
@@ -3939,15 +3952,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
-static int
-fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
-{
-	if (unlikely(index < 0))
-		return 0;
-
-	return (index % fep->num_tx_queues);
-}
-
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
 				   void *frame, u32 dma_sync_len,
@@ -4041,15 +4045,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int queue, ret;
-
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
-	nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	int ret;
 
 	__netif_tx_lock(nq, cpu);
 
-- 
2.34.1



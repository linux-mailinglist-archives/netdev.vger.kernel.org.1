Return-Path: <netdev+bounces-252614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4tNMfdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6F6FA89
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88B2A3058AB8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504237F750;
	Fri, 23 Jan 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E+AOvF4C"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465D389DE5;
	Fri, 23 Jan 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135108; cv=fail; b=mQ9cufNozBXeZMLaFui5N3Ehd4g/V6Slovqshc055V3Bi3F+YuEmeZcud9+HLmDiID36S9YWJkEqUblUCXzq6zwpCLEKt0yU95hra0pgJe1HZfdeFMWykjU11XBLVxh+fhS7LxSGLZbAbb7D0qzeyfhew7/tg+wTmZfoc1gqUSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135108; c=relaxed/simple;
	bh=Rm+hK46f2KR+G74UE3oghx9H/1kPHP0YHSjaLNMH/Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pshiFq7cjjqHNjU5HUgKIh19RFfUmpHGvr6H5e1FYHF+a+sK+O9qZwaQNRjb2JS9DOAcn4ip9J9AjYHFSUZogOtgKiOto7BsuxvYiTHmU+ipBUgquAOA7kHGXb1aIjYfLFvUi1udg+GqJcZyvutY12u3Aa79lbrdGopoModWNEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E+AOvF4C; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esykxtBDYt8vCO7QBn3GQv9yT+xv+4wLQB7j44v1P0G8DmhQwajLnMZ0Zt5J8mSnA7jTqOzaQawXgNgDi0bFaJV0Kg5fdF0ThkbXZITAesxuVHAGpe21laBSkIw/LSjF0gAYgQwlO00cHCTCeTWr5XoH203zXHy3hP3AeuFNTHA6rgXCLq3ZYDc3x6pPsV9GLGzxv/hIFTwL2vBxcH0rYeNXORfjvr1qitJtkCC/8CBeQWsGFX8u8JlsjLA5UQULe2riABnCDJdAskIndKJQe1D/s2i+9crj3qAeNDWN/aruXx1nGNeKMJ3JcYupFIP0BCijSufc7RIsUJ6ZpJPWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xjuNu3qzM5vQ0KPk+X8Z3eIkrbf+GjN843AbOal3QY=;
 b=oH1dW3YGl0dY9VHN4p4ST51bxdZH8MTm2OjDSYe8MRo1NIriQN40zqmKVL0kQ4FZf0nmyQo7fbHYUYNBn1CzABu892Ebo4kWbu2yNIODWpZwi+ZBa9uMhHdSu3jHiP3r6n4IBGUofSvOo4kzTdilXMX6IVGn3AiOf2O4CGzprHBzPXq8O3ta9iWyiUXKmMMcJiM0oTXT9sC98eZhkmSQUtJPdn8b2o2ctUhp32Le0XwZEfqvj/vWtk0jLN9CkZgcO/R1NcGbuB9+BlsJtOiFdov9VIdpWU8Ai5yqVZFJmwORdI+2LHUhgqRoI5eDbHHKpuLWyUr7J0Nb9vWc0OqJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xjuNu3qzM5vQ0KPk+X8Z3eIkrbf+GjN843AbOal3QY=;
 b=E+AOvF4CVPuGUYug9fNqdpsMo73U33MP7m0D2Kytz0hjgrPGUvxjr9CLcHbsHcR944bZt7SLEwvEmCKHPC+3OorJE3DU1XPpj3T/Gr5r48cTQr6PvyUsfqiiM0qwAoO1/4ku10x1SzgGsPwXw3vr7XkLAWo7rYNp+VlZJXkrGvziKsctz8VwmUEf0PDb/C7InHccCKXi/2nYv+aoWekbgvrjFHb0FESH/z/uzokrvXBDx4zD11X5RocRP/MDg2ue9RvvpJbBN1ZhJhE9G5J6MNwshpYnIgpTfXexf3GC19oJFzB7r0/dXhVO2hg5wMw9PatBpgW3+8LnHgb+ZZYmcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:23:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:23:13 +0000
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
Subject: [PATCH v4 net-next 15/15] net: fec: add AF_XDP zero-copy support
Date: Fri, 23 Jan 2026 10:21:43 +0800
Message-Id: <20260123022143.4121797-16-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c68fc768-a0ec-4ea8-ca9e-08de5a265bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LwTRqJjzpFJZIrWTNgdVwOaEnuW4CNwKSPHql/vOgbWgyEieSizejhMAPBi?=
 =?us-ascii?Q?jjSm9s/V/zzn7SOwXBoPhFOMRXG4j1dS+H0w0MyAkQyRU2PeO7yOQ+SJRqV1?=
 =?us-ascii?Q?+4Rg8CpSA4IHOSAUNMH6exiGSM+lH+F6q45QgRIuQNdwOVhAwigVSJez8qOK?=
 =?us-ascii?Q?k/MUMpgqDizn3kv8Y5UrbBtQKa6CTl5Ofd3BeZlJDqlMDnHvOqhVDVDxKiqr?=
 =?us-ascii?Q?c63uWLeUeqe8qB6NuM2TiJr+qgOOonMOVF6gouCLLhbA6ekFDE6pgT4yJl8i?=
 =?us-ascii?Q?I8qdYKqZ8wy5Zzm3zZQOAgau5u30TQ0hMz7h5gV2ow9IlRdYpj3zc7MAYXn6?=
 =?us-ascii?Q?fgL2WVecjTlw4MFsylaJ5FCyyIzuyJ/+7pIo98oq/z+2bW9ugb1siRMGYZjD?=
 =?us-ascii?Q?/7o8hI7+QDrmscfyA6Fb1vC5O5IiReoCLkarbfxszgDwAkiOx5A934t0EIor?=
 =?us-ascii?Q?bZoZUDr8lv5A6V95UG9Oe65us19Mvb/3F4Bar3HsQjVgUmd06odtnazQXd4O?=
 =?us-ascii?Q?SG9WDU7lnU29U0adGXS+O3b3qmew7ADh298LpjDzaV35Eurf1a+OLw/vDAm+?=
 =?us-ascii?Q?ezBbHAXV5mVzBweSYIQLbdF4TfBv2ivZowu8Kjd348c2mqPguz+/PYO6VUbe?=
 =?us-ascii?Q?H+Ja5toybZenzzvQ3S7r+uaUmzRjOGiT/JlMBXE+/MY/EK2Bu/bgFAfi/Mgd?=
 =?us-ascii?Q?YoK2aLrMqemILA01ZfkT4Ml/uGKmPNKW5Q1HnSseI5JXzUr7gN1ci93PS5yL?=
 =?us-ascii?Q?Tw9tWQIWTR96Va0htOIa5Igmig9gpZsoh6m0+4CrVQukxL7hJ0mLyV/3h3Xy?=
 =?us-ascii?Q?8u5YlL7cOuLip3JCFcVRKcazmpekiABasEdn5OjlSaDrNDJz9s8pP5Vf7XUV?=
 =?us-ascii?Q?4J1sWkRPqdz5b5Nus9zRNttmODsSkaIV4wRDUsvn5yuJiDcPo671/5UbFEqn?=
 =?us-ascii?Q?192o1Hl3wTs8PyWD2jomyiMj57c/1sjRzEEBHl+m9iJenhImOtu4Naz19ydK?=
 =?us-ascii?Q?uEFnZOoBoEUl74hfnCtSYdAsERSKUvKY7bzGS5oUl3Q3Z28o+AputLJ5xrEe?=
 =?us-ascii?Q?d0/nMXSfiZSrGQOYN6HR9SbOmEGstzH3G21T1sSbcjkPyozILkySvtvacqOc?=
 =?us-ascii?Q?aMzD8SVOgoUEfW9EdGYJ0NvpcNWjpptSG7BCTlpKMXPw4G38Ns3Mm6T0SMaN?=
 =?us-ascii?Q?ijHDs/F8uUiBHD9asvWHJ7d0uVZyheo/WqiECgPEOzENR5eQslAFbNGbpG5H?=
 =?us-ascii?Q?48hV5jgfscyfiSCxEspl07irmORgkpWjCqiKA55xP5zCzcT8fvg1YbKINtnx?=
 =?us-ascii?Q?VxPjo20ch39fBWNRnPAx7RH3wOgKRpLqSujc/xxIApnldfRcWq7a4wVOE1lU?=
 =?us-ascii?Q?KDrM7S/Y35rLsqzmRRn+9Vqgx0yWDlLG8pJ1GVdpCXCfbRzdqxGiO95xNDVT?=
 =?us-ascii?Q?jnYwZ5ivI71Ltx4mEeTtGMd4XhKVex+tPTN75Cf21nprx7bAlrFEyCUOp8de?=
 =?us-ascii?Q?1VfZsHJCUVsaM6vIfkoKavaZy/mZ26ZvTu1VZkHXuKBv0n4m5At4+LjCLU/j?=
 =?us-ascii?Q?9pkP5Gt5Sy0sjN9139quv6hdM3Xj8yY+FOL4LdGluO3zBEEk5Hn2zlRZ46mc?=
 =?us-ascii?Q?KcoHhItjVD25JcP3yabp8UH92O/AtPRkV3ShF30WF0nL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCmxsEBKjvL52ooMdyvLjq3J/DP2lJ2KUlpMATuw0jUDP9+mmlDSZwiLEYZI?=
 =?us-ascii?Q?Mrzu+uf5dSsrVHDjUsjgy8TbMJqpmd8JnwTf0QKb1CLcnsCmPM658b3D0aN8?=
 =?us-ascii?Q?mNnh6ZXCj2o8yRNbajXMvGHM5mc2vR4Gvak7NQZ6Y4o0gldALgQzEaw+8j0p?=
 =?us-ascii?Q?ArwFbBHa7Z1w1GZnkvhpoFi1RZoXsXwaFOz/rrd2ByavS9fZh8YaciKZzPEw?=
 =?us-ascii?Q?boBCRVG8RXcmAgEW6Tr6pNJlpk7GKF1BoZsL92tDwh0hGSqwToIUsBaR0hAi?=
 =?us-ascii?Q?GpqR6nb9Jnwqx9IOloBrCrik7qXqzrlSkO6D/fx/oJMtRVIMTUf/on7rexxB?=
 =?us-ascii?Q?wtw8/mQ8YQJ8cBuOQforJ9ECSGhy6Y8n7jchRL8AwStWCMyJZd707jJ5kZR4?=
 =?us-ascii?Q?Kkl5IWOLMQJoBz9qNnowxMM52kuKkxjht1Uela08CqNFLWtPx8tQfUsbdLr6?=
 =?us-ascii?Q?KLVc3CK90I5/XBbTELGeovm+0E81HMCU1gEikmy6vvJe6GqJF3EaxDlLt9tE?=
 =?us-ascii?Q?fBUaTg2IpFSS0Q+n0pQD7ZODHIlbPEq9W8QysQmntM1RseeOElSPLmxQE0si?=
 =?us-ascii?Q?FX0TjZ7EIpwC0WIMfQqO54vJ+2aoHYlzdNlUBK8Fm9MKBuF0q18Qv0gkHRHU?=
 =?us-ascii?Q?bMO3Cq6ntbv6X47QYXLPgduJJdNJ1V9Jen6In2g2lVcTjfFSclliVaOCuXso?=
 =?us-ascii?Q?cKiVtGypzIScubpjtcDJm9BIEUEc6U4oYy62flUrD0TbpbAElvUsEpIUS5fg?=
 =?us-ascii?Q?PJsfRZd7RiJuTeuRW89A6iRXG40Sv1847LJ+y3MRAQLBTf0uzsZSn9se/3K1?=
 =?us-ascii?Q?V54nrGDgyis0INn/CODM0M50bspZzRWbqnX+SWHhTB7fqpc35egU1ZPEoRuK?=
 =?us-ascii?Q?+iG6BNWNIM+MG3awil5Nu5Gpr+h1fmjzu9SoLknIkxKKwc6VRqsYh+sm8ggL?=
 =?us-ascii?Q?iJwlbhAf6Un2Mg5ZcHmWC+7CnV0mpCpJCDkli19Q1Z2lYNM8NLDwf7oN51I/?=
 =?us-ascii?Q?hJ67oHvLGscbqeNup2E4LHnvyjCW7jl+5neHdpoF9h+2Vzir+60bVZ7Pevlk?=
 =?us-ascii?Q?VfquNPeNh0wfh6ZqNzv7GTcZMRH58HVZA93S5bjZwcOrm5/QynFcwfVlRUHP?=
 =?us-ascii?Q?i5zqDR1ngdG8sPmT/pNnDtOjOcxHUpYJcYAGS3W9lEltblQ2vq8hpQHjkVIp?=
 =?us-ascii?Q?2567lnOMsvwMU3VtrPov0RK1m0VYxiEu+TXwZWFhOiFn62+bCNy5RtZSCzEx?=
 =?us-ascii?Q?oE2S9ps0dBBaQNt8m7bT3ay3//n+AUnZjE7ufbnSbemfMcnKdPDu2/CmT4I4?=
 =?us-ascii?Q?oqtCYYhNugDJpwwh1H5pwFhGC4TDb8qPlhx1v2lhc8FNYkuhuo/cvMheJcAu?=
 =?us-ascii?Q?+jgJ46DLPTDqe2sFdUosnqaM6eOvam5/8tukaiiid8SfTBBNwwV9l50QWydT?=
 =?us-ascii?Q?ZOUufHApLEGASD/mOtAWROGda1kb32fTB+pA+FWRR/UnY+FBJQWBEdTX1xK+?=
 =?us-ascii?Q?7veEoz5UO9XuChhaDxG7v+cJ719CkBZ/jI1r2kozDjV/bXs9Zp+WyHs9ncFc?=
 =?us-ascii?Q?NkrHQzyljMRSMINkeiH2S7kBZfPjB/33eaF0I4wd51Ve33EnuWXJQDMt6jXH?=
 =?us-ascii?Q?5TtRizvbbue5C6CXFFkCgm50PLPd6aq8WVie35D3HGeWzU4SOXzmgSBG/XE/?=
 =?us-ascii?Q?2O2tHEm4jTSlZjB3TBMMYbEpPfXO/CsZ0lpAdLB1JZPFPA333ZP3rTpPxrII?=
 =?us-ascii?Q?HjHoE3RNRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68fc768-a0ec-4ea8-ca9e-08de5a265bcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:23:13.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDvyAj5Dg9C7O35IYrnyIJme4gnmD0n4vurbgVTrLcuta7TxaMvfO1kPjejiYMygJm0zFr8fok108J3shq1cLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252614-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,imx93evk:email,eth0:email,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 5AA6F6FA89
X-Rspamd-Action: no action

Add AF_XDP zero-copy support for both TX and RX.

For RX, instead of allocating buffers from the page pool, the buffers
are allocated from xsk pool, so fec_alloc_rxq_buffers_zc() is added to
allocate RX buffers from xsk pool. And fec_enet_rx_queue_xsk() is used
to process the frames from the RX queue which is bound to the AF_XDP
socket. Similar to the XDP copy mode, the zero-copy mode also supports
XDP_TX, XDP_PASS, XDP_DROP and XDP_REDIRECT actions. In addition,
fec_enet_xsk_tx_xmit() is similar to fec_enet_xdp_tx_xmit() and is used
to handle XDP_TX action in zero-copy mode.

For TX, there are two cases, one is the frames from the AF_XDP socket,
so fec_enet_xsk_xmit() is added to directly transmit the frames from
the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
other one is the frams from the RX queue (XDP_TX action), the buffer
type is marked as FEC_TXBUF_T_XSK_TX. Therefore, fec_enet_tx_queue()
could correctly clean the TX queue base on the buffer type.

Also, some tests have been done on the i.MX93-EVK board with the xdpsock
tool, the following are the results.

Env: i.MX93 connects to a packet generator, the link speed is 1Gbps, and
flow-control is off. The RX packet size is 64 bytes including FCS. Only
one RX queue (CPU) is used to receive frames.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  13 +-
 drivers/net/ethernet/freescale/fec_main.c | 612 ++++++++++++++++++++--
 2 files changed, 583 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ad7aba1a8536..7176803146f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -340,6 +340,7 @@ struct bufdesc_ex {
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
 #define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
+#define FEC_XSK_TX_BUDGET_MAX	256
 
 #define BD_ENET_RX_INT		0x00800000
 #define BD_ENET_RX_PTP		((ushort)0x0400)
@@ -528,6 +529,8 @@ enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
 	FEC_TXBUF_T_XDP_TX,
+	FEC_TXBUF_T_XSK_XMIT,
+	FEC_TXBUF_T_XSK_TX,
 };
 
 struct fec_tx_buffer {
@@ -539,6 +542,7 @@ struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
 	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
@@ -548,9 +552,16 @@ struct fec_enet_priv_tx_q {
 	dma_addr_t tso_hdrs_dma;
 };
 
+union fec_rx_buffer {
+	void *buf_p;
+	struct page *page;
+	struct xdp_buff *xdp;
+};
+
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct page *rx_buf[RX_RING_SIZE];
+	union fec_rx_buffer rx_buf[RX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c19ae60b04d7..d3e54dcf6a4c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -71,6 +71,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
+#include <net/xdp_sock_drv.h>
 #include <soc/imx/cpuidle.h>
 
 #include "fec.h"
@@ -1034,6 +1035,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -1467,8 +1471,91 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void fec_enet_tx_queue(struct fec_enet_private *fep,
-			      u16 queue, int budget)
+static bool fec_enet_xsk_xmit(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u32 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xdp_desc *xsk_desc = pool->tx_descs;
+	int cpu = smp_processor_id();
+	int free_bds, budget, batch;
+	struct netdev_queue *nq;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+	u32 estatus;
+	u16 status;
+	int i, j;
+
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+	__netif_tx_lock(nq, cpu);
+
+	txq_trans_cond_update(nq);
+	free_bds = fec_enet_get_free_txdesc_num(txq);
+	if (!free_bds)
+		goto tx_unlock;
+
+	budget = min(free_bds, FEC_XSK_TX_BUDGET_MAX);
+	batch = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!batch)
+		goto tx_unlock;
+
+	bdp = txq->bd.cur;
+	for (i = 0; i < batch; i++) {
+		dma = xsk_buff_raw_get_dma(pool, xsk_desc[i].addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, xsk_desc[i].len);
+
+		j = fec_enet_get_bd_index(bdp, &txq->bd);
+		txq->tx_buf[j].type = FEC_TXBUF_T_XSK_XMIT;
+		txq->tx_buf[j].buf_p = NULL;
+
+		status = fec16_to_cpu(bdp->cbd_sc);
+		status &= ~BD_ENET_TX_STATS;
+		status |= BD_ENET_TX_INTR | BD_ENET_TX_LAST;
+		bdp->cbd_datlen = cpu_to_fec16(xsk_desc[i].len);
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			estatus = BD_ENET_TX_INT;
+			if (fep->quirks & FEC_QUIRK_HAS_AVB)
+				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+			ebdp->cbd_bdu = 0;
+			ebdp->cbd_esc = cpu_to_fec32(estatus);
+		}
+
+		/* Make sure the updates to rest of the descriptor are performed
+		 * before transferring ownership.
+		 */
+		dma_wmb();
+
+		/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+		 * it's the last BD of the frame, and to put the CRC on the end.
+		 */
+		status |= BD_ENET_TX_READY | BD_ENET_TX_TC;
+		bdp->cbd_sc = cpu_to_fec16(status);
+		dma_wmb();
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		txq->bd.cur = bdp;
+	}
+
+	/* Trigger transmission start */
+	fec_txq_trigger_xmit(fep, txq);
+
+	__netif_tx_unlock(nq);
+
+	return batch < budget;
+
+tx_unlock:
+	__netif_tx_unlock(nq);
+
+	return true;
+}
+
+static int fec_enet_tx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
 	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
@@ -1479,6 +1566,7 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	unsigned short status;
 	struct sk_buff *skb;
 	struct page *page;
+	int xsk_cnt = 0;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1552,6 +1640,14 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
 					   0, true);
 			break;
+		case FEC_TXBUF_T_XSK_XMIT:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_cnt++;
+			break;
+		case FEC_TXBUF_T_XSK_TX:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_buff_free(tx_buf->buf_p);
+			break;
 		default:
 			break;
 		}
@@ -1611,16 +1707,37 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
 		writel(0, txq->bd.reg_desc_active);
+
+	if (txq->xsk_pool) {
+		struct xsk_buff_pool *pool = txq->xsk_pool;
+
+		if (xsk_cnt)
+			xsk_tx_completed(pool, xsk_cnt);
+
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
+		/* If the condition is true, it indicates that there are still
+		 * packets to be transmitted, so return "budget" to make the
+		 * NAPI continue polling.
+		 */
+		if (!fec_enet_xsk_xmit(fep, pool, queue))
+			return budget;
+	}
+
+	return 0;
 }
 
-static void fec_enet_tx(struct net_device *ndev, int budget)
+static int fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int i;
+	int i, count = 0;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(fep, i, budget);
+		count += fec_enet_tx_queue(fep, i, budget);
+
+	return count;
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1633,13 +1750,30 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_buf[index] = new_page;
+	rxq->rx_buf[index].page = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
 	return 0;
 }
 
+static int fec_enet_update_cbd_zc(struct fec_enet_priv_rx_q *rxq,
+				  struct bufdesc *bdp, int index)
+{
+	struct xdp_buff *new_xdp;
+	dma_addr_t phys_addr;
+
+	new_xdp = xsk_buff_alloc(rxq->xsk_pool);
+	if (unlikely(!new_xdp))
+		return -ENOMEM;
+
+	rxq->rx_buf[index].xdp = new_xdp;
+	phys_addr = xsk_buff_xdp_get_dma(new_xdp);
+	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
+}
+
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1794,7 +1928,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -1924,7 +2058,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
@@ -2039,6 +2173,250 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	return pkt_received;
 }
 
+static struct sk_buff *fec_build_skb_zc(struct xdp_buff *xsk,
+					struct napi_struct *napi)
+{
+	size_t len = xdp_get_buff_len(xsk);
+	struct sk_buff *skb;
+
+	skb = napi_alloc_skb(napi, len);
+	if (unlikely(!skb)) {
+		xsk_buff_free(xsk);
+		return NULL;
+	}
+
+	skb_put_data(skb, xsk->data, len);
+	xsk_buff_free(xsk);
+
+	return skb;
+}
+
+static int fec_enet_xsk_tx_xmit(struct fec_enet_private *fep,
+				struct xdp_buff *xsk, int cpu,
+				int queue)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	u32 offset = xsk->data - xsk->data_hard_start;
+	u32 headroom = txq->xsk_pool->headroom;
+	u32 len = xsk->data_end - xsk->data;
+	u32 index, status, estatus;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+
+	if (!fec_enet_get_free_txdesc_num(txq)) {
+		__netif_tx_unlock(nq);
+
+		return -EBUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	dma = xsk_buff_xdp_get_frame_dma(xsk) + headroom + offset;
+
+	xsk_buff_raw_dma_sync_for_device(txq->xsk_pool, dma, len);
+
+	txq->tx_buf[index].buf_p = xsk;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XSK_TX;
+
+	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+	if (fep->bufdesc_ex)
+		estatus = BD_ENET_TX_INT;
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma);
+	bdp->cbd_datlen = cpu_to_fec16(len);
+
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+	dma_wmb();
+
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	txq->bd.cur = bdp;
+
+	__netif_tx_unlock(nq);
+
+	return 0;
+}
+
+static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	bool wakeup_xsk = false;
+	struct xdp_buff *xsk;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	u32 xdp_res = 0;
+	int index, err;
+	u32 act;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		xsk = rxq->rx_buf[index].xdp;
+
+		if (fec_enet_update_cbd_zc(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		pkt_len -= sub_len;
+		xsk->data = xsk->data_hard_start + data_start;
+		/* Subtract FCS and 16bit shift */
+		xsk->data_end = xsk->data + pkt_len;
+		xsk->data_meta = xsk->data;
+		xsk_buff_dma_sync_for_cpu(xsk);
+
+		/* If the XSK pool is enabled before the bpf program is
+		 * installed, or the bpf program is uninstalled before
+		 * the XSK pool is disabled. prog will be NULL and we
+		 * need to set a default XDP_PASS action.
+		 */
+		if (unlikely(!prog))
+			act = XDP_PASS;
+		else
+			act = bpf_prog_run_xdp(prog, xsk);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			skb = fec_build_skb_zc(xsk, &fep->napi);
+			if (unlikely(!skb))
+				ndev->stats.rx_dropped++;
+			else
+				napi_gro_receive(&fep->napi, skb);
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xsk_tx_xmit(fep, xsk, cpu, queue);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, xsk, prog);
+			if (unlikely(err)) {
+				if (err == -ENOBUFS)
+					wakeup_xsk = true;
+
+				rxq->stats[RX_XDP_DROP]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(ndev, prog, act);
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			xsk_buff_free(xsk);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_res & FEC_ENET_XDP_TX)
+		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
+
+	if (rxq->xsk_pool && xsk_uses_need_wakeup(rxq->xsk_pool)) {
+		if (wakeup_xsk)
+			xsk_set_rx_need_wakeup(rxq->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rxq->xsk_pool);
+	}
+
+	return pkt_received;
+}
+
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -2047,11 +2425,15 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
-		if (prog)
-			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
-						      prog);
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
+		int batch = budget - done;
+
+		if (rxq->xsk_pool)
+			done += fec_enet_rx_queue_xsk(fep, i, batch, prog);
+		else if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, batch, prog);
 		else
-			done += fec_enet_rx_queue(fep, i, budget - done);
+			done += fec_enet_rx_queue(fep, i, batch);
 	}
 
 	return done;
@@ -2095,19 +2477,22 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int done = 0;
+	int rx_done = 0, tx_done = 0;
+	int max_done;
 
 	do {
-		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev, budget);
-	} while ((done < budget) && fec_enet_collect_events(fep));
+		rx_done += fec_enet_rx(ndev, budget - rx_done);
+		tx_done += fec_enet_tx(ndev, budget);
+		max_done = max(rx_done, tx_done);
+	} while ((max_done < budget) && fec_enet_collect_events(fep));
 
-	if (done < budget) {
-		napi_complete_done(napi, done);
+	if (max_done < budget) {
+		napi_complete_done(napi, max_done);
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		return max_done;
 	}
 
-	return done;
+	return budget;
 }
 
 /* ------------------------------------------------------------------------- */
@@ -3398,7 +3783,8 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 				struct fec_enet_priv_rx_q *rxq)
 {
 	struct net_device *ndev = fep->netdev;
-	int err;
+	void *allocator;
+	int type, err;
 
 	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
 	if (err) {
@@ -3406,8 +3792,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
+	allocator = rxq->xsk_pool ? NULL : rxq->page_pool;
+	type = rxq->xsk_pool ? MEM_TYPE_XSK_BUFF_POOL : MEM_TYPE_PAGE_POOL;
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, type, allocator);
 	if (err) {
 		netdev_err(ndev, "Failed to register XDP mem model\n");
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -3415,6 +3802,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
+	if (rxq->xsk_pool)
+		xsk_pool_set_rxq_info(rxq->xsk_pool, &rxq->xdp_rxq);
+
 	return 0;
 }
 
@@ -3428,20 +3818,28 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 
 static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
 {
+	bool xsk = !!rxq->xsk_pool;
 	int i;
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		struct page *page = rxq->rx_buf[i];
+		union fec_rx_buffer *buf = &rxq->rx_buf[i];
 
-		if (!page)
+		if (!buf->buf_p)
 			continue;
 
-		page_pool_put_full_page(rxq->page_pool, page, false);
-		rxq->rx_buf[i] = NULL;
+		if (xsk)
+			xsk_buff_free(buf->xdp);
+		else
+			page_pool_put_full_page(rxq->page_pool,
+						buf->page, false);
+
+		rxq->rx_buf[i].buf_p = NULL;
 	}
 
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
+	if (!xsk) {
+		page_pool_destroy(rxq->page_pool);
+		rxq->page_pool = NULL;
+	}
 }
 
 static void fec_enet_free_buffers(struct net_device *ndev)
@@ -3481,6 +3879,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -3597,7 +3998,7 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_buf[i] = page;
+		rxq->rx_buf[i].page = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
@@ -3621,6 +4022,40 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 	return err;
 }
 
+static int fec_alloc_rxq_buffers_zc(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
+{
+	struct bufdesc *bdp = rxq->bd.base;
+	union fec_rx_buffer *buf;
+	dma_addr_t phys_addr;
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf = &rxq->rx_buf[i];
+		buf->xdp = xsk_buff_alloc(rxq->xsk_pool);
+		if (!buf->xdp)
+			return -ENOMEM;
+
+		phys_addr = xsk_buff_xdp_get_dma(buf->xdp);
+		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+		}
+
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	return 0;
+}
+
 static int
 fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 {
@@ -3629,9 +4064,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	int err;
 
 	rxq = fep->rx_queue[queue];
-	err = fec_alloc_rxq_buffers_pp(fep, rxq);
-	if (err)
-		return err;
+	if (rxq->xsk_pool) {
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		fec_alloc_rxq_buffers_zc(fep, rxq);
+	} else {
+		err = fec_alloc_rxq_buffers_pp(fep, rxq);
+		if (err)
+			return err;
+	}
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err) {
@@ -3954,21 +4396,83 @@ static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
 
+static int fec_setup_xsk_pool(struct net_device *ndev,
+			      struct xsk_buff_pool *pool,
+			      u16 queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	bool is_run = netif_running(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	struct fec_enet_priv_tx_q *txq;
+	bool enable = !!pool;
+	int err;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	if (is_run) {
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+		synchronize_rcu();
+		fec_enet_free_buffers(ndev);
+	}
+
+	rxq = fep->rx_queue[queue];
+	txq = fep->tx_queue[queue];
+
+	if (enable) {
+		err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
+		if (err) {
+			netdev_err(ndev, "Failed to map xsk pool\n");
+			return err;
+		}
+
+		rxq->xsk_pool = pool;
+		txq->xsk_pool = pool;
+	} else {
+		xsk_pool_dma_unmap(rxq->xsk_pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+	}
+
+	if (is_run) {
+		err = fec_enet_alloc_buffers(ndev);
+		if (err) {
+			netdev_err(ndev, "Failed to alloc buffers\n");
+			goto err_alloc_buffers;
+		}
+
+		fec_restart(ndev);
+		napi_enable(&fep->napi);
+		netif_tx_start_all_queues(ndev);
+	}
+
+	return 0;
+
+err_alloc_buffers:
+	if (enable) {
+		xsk_pool_dma_unmap(pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+	}
+
+	return err;
+}
+
 static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	bool is_run = netif_running(dev);
 	struct bpf_prog *old_prog;
 
+	/* No need to support the SoCs that require to do the frame swap
+	 * because the performance wouldn't be better than the skb mode.
+	 */
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		return -EOPNOTSUPP;
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
-		/* No need to support the SoCs that require to
-		 * do the frame swap because the performance wouldn't be
-		 * better than the skb mode.
-		 */
-		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
-			return -EOPNOTSUPP;
-
 		if (!bpf->prog)
 			xdp_features_clear_redirect_target(dev);
 
@@ -3994,7 +4498,8 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		return 0;
 
 	case XDP_SETUP_XSK_POOL:
-		return -EOPNOTSUPP;
+		return fec_setup_xsk_pool(dev, bpf->xsk.pool,
+					  bpf->xsk.queue_id);
 
 	default:
 		return -EOPNOTSUPP;
@@ -4143,6 +4648,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	return sent_frames;
 }
 
+static int fec_enet_xsk_wakeup(struct net_device *ndev, u32 queue, u32 flags)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+
+	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
+		return -ENETDOWN;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	rxq = fep->rx_queue[queue];
+	if (!rxq->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&fep->napi)) {
+		if (likely(napi_schedule_prep(&fep->napi)))
+			__napi_schedule(&fep->napi);
+	}
+
+	return 0;
+}
+
 static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
@@ -4205,6 +4733,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
 	.ndo_hwtstamp_get	= fec_hwtstamp_get,
 	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
@@ -4332,7 +4861,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT;
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	fec_restart(ndev);
 
-- 
2.34.1



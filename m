Return-Path: <netdev+bounces-256132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMW6JP6HgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:30:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBEAD4B79
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC1A312CAB5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F936654B;
	Tue,  3 Feb 2026 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhshOO3z"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1307366063;
	Tue,  3 Feb 2026 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096165; cv=fail; b=qqaNUO9FVtYwFABTU/yel9m/ZEgKemsa6QSpnhmtS2yUUtku+2DSg9ImNGYCgWZPf108YJjsuJcehtxfwVEYSBq6YVteKSgmU8fY4Wg0WNd0nAJwrHM+xKaILnY0tBhqjGDAFsRRF591rB97Z+GlLIgiTYAb924AxIGA3V/IYQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096165; c=relaxed/simple;
	bh=g1tpGud9ARagXiTSxvxU0kUOZsdNCHT+0CKsbfiTcfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaZmfMqBRGSyiz4IHeGxa0QnmS8Wx1RqnUFw3XtkTihP3lpHOjJGMbX3YxvPs+ZmlxuaKW/JbMyIEl2mBQ1g41Jio1ziUT4CC8prlavxU7JqsMU5uklIDKtzwlppkLrPMQrx3915TJfbCPRfnkSwQiwOJ2/E3SaWB/wNnRex1pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hhshOO3z; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFBv/NLMT6U8fKxnRF/+d1AQcVntGa9Qo05yvutPaR2FoVohi+RWLvZDVNBeSknNmtKbcF+HRTycUzWwIN1dk4JfNip7Oeh/xT03jmxTGbh+RpqrAjuyAH/Jcak34eG4aOWbT3FCqUxSlEefzFhFXTI1BUEPKQPOR8bFxMcCkII/57pFzbVu8CU6W6zlIUiMq24fFfZ479ebeknc0hxaD8tF3/OP++IOfEnjaB34lvCv8lBFwQjM7XEn03lqIgN52jNzBiWeVc0kcTtMET9I4HW6zzG9Xp7CBvueEFjd2t83s4yIdRyRe6c3cHRw271Zh2PCoEnLnETrdKJ0CXQ3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=uyhiudgzZf2IENs1EhD0O/b5Sqn5OVI9jj5dEO326ZdBn25FnqWShKAPIpRK2Z2DM0ZeiV5duZ7ZKAQD95jyiw5SHxdBcDPCpCdWKFw14YUb5Bvhwn79sSgMvZeVOaAiGxfHdbUpeMh66/TMJXfLxyjVa8OiMe/UUkKteN5h78DxkkLpEsg97W8hOfalW6Aux2FLn7xMRx39tJ9Y8TWACMNa/9X5iit5E7tFOYZihhDDMQuLhIsC2WAq7ysOOK8wNEtCDeB0i88RwX29aqGOCbLajkSfdijo56tyitQuu6JyE5zeg8q/7ukFYoVFY7gSap/cTBpzeAJF409mbHzPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=hhshOO3z6rvdKm0ahjTD7cJ4Nh92mkC/u7w4pMhrXsUNF/QLsFILXVYwh3KrV0YeUS484C1xGa8dzTKPYp672m0sDtC/GqZkDoh0r3Ez2u1gVpzy/oWBc8V2kU/bnBevhv2NVmPqvWL8Q6okb6QOdRjlP4lyVB0qRdvhLS5BfVGUl1IQBL1kwQmKyBHdtAzL8ZDcpeueBcN3yy1NLxzH3YSijVUrYwAZz9O1bSl4LnDTI+1kWJY/pTq+USJ178H7K5xArxD/3OfFB/IpFVmREQAzzUXeGV90KgGRE7fostXz9oYuEIWdDKeBEgoW1gnr0LHi/BZBuOp2E46D9LTFlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:40 +0000
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
Subject: [PATCH v6 net-next 05/15] net: fec: improve fec_enet_rx_queue()
Date: Tue,  3 Feb 2026 13:23:19 +0800
Message-Id: <20260203052329.1085444-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1cd0273-3ed4-4489-04e4-08de62e43fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HsqgldkI9LzxKGqKwbM6x8nLmzQtYGn5vn2ZQSW4ky5qp9rlzc6zt/snJ2L?=
 =?us-ascii?Q?cvg3QXGmVbOgrjg9FPtW+EYX8EW5Yy8BzNE0rui/lS8gXlD0D+v8L7M2VaB9?=
 =?us-ascii?Q?rAqMXMz6fNxo1XBdakVr9/Lkmi7pL2mC8CZKPh5vYNX3sOnUpXkgm5nTqyCZ?=
 =?us-ascii?Q?xClSbH46MM3ILzkK8V5oN/yZ+SiqByNm5yaPERbZ2GBto7jLkk4dM6JYbGau?=
 =?us-ascii?Q?LayzrP7hs7t3aVV15rAWEIwNcgigKTH1RyB22PjSC21SQheB/3w2RN5VB+A9?=
 =?us-ascii?Q?gNdjCgWlGKBEGrQ8hAt4I0j6kb+H69o2VC3C8gZDqd4Kc2mY1EUQTxnAQ9na?=
 =?us-ascii?Q?W3MlsDOp/n+Psv/36m+8tXHtMkrXIR60+gADTabPf/KXKQrjBFMC1cRBa8OL?=
 =?us-ascii?Q?VyyQRK4y94kmEpJUArh5Ud9FJCGhuk1rbLgtfDOnYSatTDTtfsxGOLB+7PHU?=
 =?us-ascii?Q?4odHjtOqgGYUEWiHS2lRtrTjuESQPN4vnf29npn2PEBr1LpXnmygx1kpFEqh?=
 =?us-ascii?Q?i2l5wPvpAwbIXP4dmqGTI77WB3wHzuGA3/Tc98/MA3rvGDlFtcOw+M5Vy70n?=
 =?us-ascii?Q?/dwM1PdnXkXUKhZzpRfq2MrqCPmEEqAYCOT9gz2kYSvGwlW+jPelmEW64b18?=
 =?us-ascii?Q?1DpmHISRg4je0kN1Eg+HBB3OdwRjxyMzSD6Xz+0BPVzxf5iokDO8mNp0WoNv?=
 =?us-ascii?Q?s4m1wrqnLMAGzC4I2uztQmF66W3RREhdrTDlI+2VAo+JcOReoVSO1/sTJAue?=
 =?us-ascii?Q?4oGoOE4qOUix6gm6CbCr300THtaAr9V1zEdMeW4hGydcVZkSyJEYirwlN8PU?=
 =?us-ascii?Q?BecM5WfB8j/9FJHPm+c70F66p1LHhdah6vk9sjJv83Bysf8zPklnKDSY9HeU?=
 =?us-ascii?Q?ru1TxJjJbBZM6ohHWD/+AJyDA3Wb9b6XQlwKpgWuys1/2ojQQCYtSbjmob/s?=
 =?us-ascii?Q?V6hPVmMj0DDbk4F+c7h4zXsRDGHrVbT3SzKsWqL3vt1EwaeRMn4dk0aNZ4wM?=
 =?us-ascii?Q?7bgTPloO7ecuUQNHohn6ECZqQrX21mcmvp+2Yh2P/Y8Nvkx23RhZg1FJLxLP?=
 =?us-ascii?Q?Fk0m3iuTYS1oiioTPbVwrDw+9TFm2eF6Cvu9waGODvpxyi4vSEMwSnN1Rgdr?=
 =?us-ascii?Q?0i7odCHc+VJ8psxQ6PLAi1G70wdp/u3lqbtnnrbcV0dVG6qmwb81we52B+hm?=
 =?us-ascii?Q?VJ2cNizDTTJpsda9F63Ez9d3HVbF7ZzFkLeb8FsyOYR5X8Q+hdNxWb/6JWAk?=
 =?us-ascii?Q?unpFfTlhPqXYEvj3OyFLKMaRrmcu5Ds7zrC6BiOGQ70Ak7xD7rpDVoIOErJY?=
 =?us-ascii?Q?oRTBQwHepBq03Ps9/YvwZnzYdHStVBFRl2aI5vHDFehC3jxwL8HKagv0xlIG?=
 =?us-ascii?Q?4ik335Ay9ykVoNlUKiFVt3FX1C5rK3xokNqR9ourDuU+wLeMmYbPU4XYiJqh?=
 =?us-ascii?Q?uqFxwv4w9qI3l3vEjbd3+IsJBjp3UG+7ak/faCzdCp+f6AwButrfucikZI9Y?=
 =?us-ascii?Q?FY+wO4sIuXLRiweyIILYk0NJkzhtcgH8htpEpEhyQcHObSzxwdFi92SJBmYv?=
 =?us-ascii?Q?DeIHTKdiHyxhornKwQstIHUOQOtl1mPfscuiWJmobWdUUYdgJkkPGBkorQ90?=
 =?us-ascii?Q?hagGu4+LsiihO0iVoonJr1vdZo6FGSaKNlgCl/iU5PP7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dC2hW45pi/YgNkpO3vIcz4ZpI9xpa0JLpl51LMx3jNGdpsgyLAGoFXbcoD/E?=
 =?us-ascii?Q?XkYf5v05pkdtBxfifu5HZWjOy4Zi4yHyiuEdodQGBN8BsDkjqEGMg5AhK+vc?=
 =?us-ascii?Q?+qYwTVL7skPZ2SztuspJNuEKr5L4cB58o5qON8PHUY9Gi8Fwpv7eo3PPubA1?=
 =?us-ascii?Q?wd3sf7o0XYy9nkBARkpPw796yUGzijwlr4mJhpSDhfJ6yNqlnEI4Wr9oKxej?=
 =?us-ascii?Q?XpiNf8TcRfdX/mCxwBhMFQsGL7lzDDmUNTjswxRYYmIsKy6NDXkNv8HYug16?=
 =?us-ascii?Q?aY5wAy7CZe5CEUPtwEFdZanmamu/FBwiD1mK/VjRbu23vQCaO2lbqDgNpgIK?=
 =?us-ascii?Q?ou/gB/Ydh7F4bmxfMjssF6YvYR8VP/yNXwcDipEaaOI79xHTW61XjF2YNifR?=
 =?us-ascii?Q?ls5bNMALntv9qFZMCa2K9dWL7apiqzVE2Q7YAB7dM0pxJSjRp4+2vKyChyI/?=
 =?us-ascii?Q?sqTGinc8oEqvqc2UH8a35gH5slwXpSHwH1WwjTlQqJsIxpluebP5HJTmBnYY?=
 =?us-ascii?Q?/WNRq4Kcq3Zf00nt5lrqN911PTkvwzWr8DiHDJ71ZmyUdAvsI9kvdUqzjcMS?=
 =?us-ascii?Q?1Frga5NETVrX2Bmh+/5TOScYzPq0gE+P4LozSHtSqGLG36hjq3Ye6vVa28qg?=
 =?us-ascii?Q?7RuxrzjuytlW2ilYYcBWW+Qd3cAbYfLw5OhmI2qRsLkMuxesN5YWe2RlhD+m?=
 =?us-ascii?Q?PN0Zowg34HU5eKfGyWIGSBCmdS7lP9dnW69VgKIdLvT6cXkvfbqFVAMiZYxe?=
 =?us-ascii?Q?encuCDz1zRh5AGIkFD8esl0BusBRVr/K+0jXYPJYCsyGRukotvidcEaQBrbf?=
 =?us-ascii?Q?s3345E+xtZwTwCnevBjjMznSq+MlKvuZV6YER1lclK5jYq6UMfb8yxNroaMr?=
 =?us-ascii?Q?quwmI01vWUkc8BmfEeCzI39vay18mNws5sOERCUu6krjMy4o5dg703OwsEvi?=
 =?us-ascii?Q?0shOSHiQw9HS1LUS8SHjdd2tbePFDWRDEXDpgUwSI5oz8UFKz9r88+7l7CSo?=
 =?us-ascii?Q?YeqvtOn71dhkWT4iwXVYwVz9J8q9I9SFT5dqoFnRhNVU4bWshduHqac6jIab?=
 =?us-ascii?Q?RVZbY4bQG6j8EdpKoudizXOQALwsVaY8F6ABSgA4t9gA0iVFhwhOj6cmLS/L?=
 =?us-ascii?Q?280A2OraKeTmx4zMF367xXcFV4sEFkI96rsvuUGFg+5StOkL6ZgctO2ix+Is?=
 =?us-ascii?Q?mg05GOdjQgbdLyNfZinW44aIhHj7GR9NyhRZmuxleBXGcJe4Qib5QbYDlG0j?=
 =?us-ascii?Q?xdBckv/CggnhssFFVArnnmLyvdkZfQYrTsZSucT7/AsGdvWf/XlbCPc4FxeJ?=
 =?us-ascii?Q?sR7RgzcHiXJOvBmoE2D2LNV+XqcY6KjLxN5mR2+VP/t/ESfwvCoNtonliBDT?=
 =?us-ascii?Q?0uDOQ7MwD7x+GqaIIydRedUSasIw7YGbcd/3uIeG+LHFobKr2XQkHxD2rDoW?=
 =?us-ascii?Q?DItbHYLHjlXWblsDE4Nn1QY4dBqjBYSKqEvZG0pOj9fopHO+ZTNlDCDgui8s?=
 =?us-ascii?Q?vKIRQqoqoNVvdm0DQrErVeqBZTSkR9ZPr01Gvj0SlIzw5P2IZ/AHW4DFCKy8?=
 =?us-ascii?Q?iutcuYJkAxzdDF3ffvAkIlh/3q3h6NmFfdYEH+EAPKY2aGCv5co7DxqcEHCm?=
 =?us-ascii?Q?98Ctz+lBIVKaSzf06loj+jH9OAommmbSidjsUV38i8XW2iUpXh6J4JNmtv6S?=
 =?us-ascii?Q?MuqmsrNGJ+Qn3nbSY8fdb9DzM0h2gUmSkGvrTzYjnaiW/2Fv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cd0273-3ed4-4489-04e4-08de62e43fe9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:39.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwYKY6mbkomZh/e/8hxDW89QoWejGNg4rpMuFrwVrjb1Hlwh8DfV+KXdgJmsWurBhQ9sI8yEZ7i4E0ydmt5L5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
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
	TAGGED_FROM(0.00)[bounces-256132-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDBEAD4B79
X-Rspamd-Action: no action

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 851608d04084..7bc2eac01e6e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1840,26 +1840,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1868,12 +1867,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1882,7 +1879,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1896,15 +1893,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1980,7 +1975,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1



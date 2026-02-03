Return-Path: <netdev+bounces-256137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECaAA9yGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:25:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A15ADD4A85
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7DE3010B62
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0E36605F;
	Tue,  3 Feb 2026 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l8nQzS8n"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1A34D4F9;
	Tue,  3 Feb 2026 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096262; cv=fail; b=IaHjn2L1fx5Zox6BwxMqMnZfcTAfhhgDa6nupFtlOFGLChUkkLhQnzgnDZZbHaZ2sMGpU0fsJudde+k6QU+Tay7kPB7JMwa4WIoORNxXoXiCgkJE4KOjrs/+lbWIb3rLg0P9wiJwJKpRCAl2V6+8CbzLVWBvOL252mFw2pX/74M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096262; c=relaxed/simple;
	bh=KVtQpxkMzZZIdtwFGgTNdHlOoXnMmYCrSznUzsgqfGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0SF/g68stVWB0q/WVRuzVVUPiMSfY8OQZzJqgZ2JvcsP4uOdMHazxaN3Lh9RHtLPhSbOEGumPG86s5uOsacv35+kPrQOptNciYpk0d1f8ErSiHY3I/4iWfkdlCk5IfHEheRCTn/hFB09bI9+CEuFJPNaarNKeu95mH+TTa2IrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l8nQzS8n; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7rTd4F6gGZy5KSe5ACnU9LJt94JMRSLxh0sfoqFjwBnNp2m0VFMt027dYKtr1gSFvVxu1R7yq609eOin9SppjXQm4FcHcwozFWuo37quFD78ZkkzJPvNUehj1OJ/bFWpIrMO5Inx4s7jemL1wpV56fIx3XRgGgv5EZfbqU9lweyZ8J4mPPnDz4gXFkkqSfHIEzAEjHg2gI/pwEYxfQCpdnLdbvLhH9hwqJwHbMs+9Fnny24/vyTGGWpNnBMq4G3/Jidi8HGviPbHMESuwnCvzv+SAiKgVXT/jwkzPKJewScOMwaEmRib26XZ2UobxMxySTIM4AijzTAumfY4v5jSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ksD6j9QvphF2mVJlQ0i5IoQcLMv53/HD1nS7JWB/E=;
 b=JcUCTEkcSw0U7fUQrlse4Tsu3vy55u7ySwCdGleVX7nwC58pYJDfh1UwDGAIIRFZBjIwL4uFF54yon8H57dXcC+jpUGwVhYfud0YgkdjAwVyGC4DQUHSwgn9idewcuUF/16j65LDYZJmL2//SuPwfHVL/F642Ez13H9nm1ekrA57KsriHMVIr9wjwMAE+mS1RT9aW5HszjjcRe1yLXajN2hADgXXd6rq4o7BegIu9xr1TEozrg7ZF5oAGxRKV6/KC+s4EAlyT2VB/YFyR8USvKUr1pOktmEbCynDgzaahhFcRJUHfObFyRG3z1LtEpammA/B4aHJIMRqVXejbeG8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ksD6j9QvphF2mVJlQ0i5IoQcLMv53/HD1nS7JWB/E=;
 b=l8nQzS8n9jthGpDwhRnnUjgM20RkE9dfuVdr6D/MVTFHRMZQq+w2MTX1S6wtNuO4LSa+B91sa2QLSZIUJzZGbLDpkc6k/+xn5ezQWorlAno/3/Li9wKkgHq8V6FWEa/C8slaaEJ2c9TJWNkDY0hmzsKEmlFDFH3npL7Jpn/nC61AiobuzajSkrHGlKHkEBXSbuGxE9pEyf+GhHoORtCf7sowUxTX7/I2uiU1rDuOjhGUs1sdnNxkRQwCvu7z4gSVvQOc2Qw8YUTVR5/SuzZv13/EjxqSHuOFfMyp0RDS4TITbRhX1LYipnH2uu7gPbjiDfEGxD/wdPjNESk1vdom/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:10 +0000
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
Subject: [PATCH v6 net-next 11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Tue,  3 Feb 2026 13:23:25 +0800
Message-Id: <20260203052329.1085444-12-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 174b5f55-19ec-4238-94c2-08de62e451d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZD5Rx5sJTQs99axEBk+W3U+2UogX4XdWDQZe1qcV10spDcnyutxYjphrMCVi?=
 =?us-ascii?Q?NUo6542vnxiz6gJpqaPZeGB119eR9E2GOarxxsLZZYp6pomuArlJxFWbyBuj?=
 =?us-ascii?Q?2VXNnAuMyGuFRUmmaIBjnZgdIuuSeII9dnojSHSR26Q0KntYjcDo3FoMlYxV?=
 =?us-ascii?Q?Om7vIjUBJViwhUipkAN7PjuxP22j34IrIvYdz9W8Ko7fVsUnIMmQUDFTTlgT?=
 =?us-ascii?Q?0nYsb3xPP/f2v36CjFweDY6lopIMs9krJkJqCbB9L9nbRHiEcZREiP2Vee8m?=
 =?us-ascii?Q?MS6388bTalCWVRtsjD1eQngWcrRACghGAgWYpMSe8oOKJNktw0KhGKkcNZKE?=
 =?us-ascii?Q?euv0x5Bnw+C5evieD3WU3wt5kDzVpdocQEi9z+Ea7qGft9xxiCP/BUihLxjQ?=
 =?us-ascii?Q?hxP225vNebchNocFWa19BGkRMs+/NrASZ/Uv+0wufUTDkIpweK+So2Jqz7rA?=
 =?us-ascii?Q?a3jFeNv8+XGgm73GV2D6XEA36tsqyZcogbCIqGU1kMW4xMR+KD99Jr5x33w7?=
 =?us-ascii?Q?XUH0HyigzFBb9Dr6iZtQcAWnbOKo3ibd3pADdeyyoyMFqh3Je4Ixl3zENxCw?=
 =?us-ascii?Q?/PzZdExxVV+Iz0vB0p8xhM7Fj3NZrWj/LQLBHRKp81VZm/+fSwneJg/74Pj6?=
 =?us-ascii?Q?aPowd2pcSdsXxlhPAtoyJ1nZxQ9XNcIH8bsVvsveESqV5BdjpJkL/wiCoxv0?=
 =?us-ascii?Q?okUh7XFz3co8QMSYsiiPIBqd/xR8hbHU92MMhk9b3pOTk9g2g035268jj1at?=
 =?us-ascii?Q?zqU8MgJrphRjL4S7hmHJQrphbth87XKIfDGj8G18b3Mey4QzyAJdpLDE9uZe?=
 =?us-ascii?Q?rr1NYA60KfjxZrRt9aQvGgNCdN5Z4mIscvsDs8cgx1492BK0rtkhMYEK1SVh?=
 =?us-ascii?Q?CzezhIPWykuQcKZpy8uapSuxVlDf01uGljRNt4uOuioN6Ljb43CsMa/uhTH9?=
 =?us-ascii?Q?+x8QpKFR9zgGBFqHTCMyBlz11O0LH46NcyHIkxsf51/2LPfownnLvWV+EYkD?=
 =?us-ascii?Q?gVguJnstO/+Ene5TBoNyvMKy4rYd9LsdHEIX1rzVdN6IHFZegvemB1OAqr5u?=
 =?us-ascii?Q?ekzuZTMwqKwbfMqrjnQNCBIKa6SYg1IU8rb4MJ/5+LXFQJv4GAx+SomRdu4N?=
 =?us-ascii?Q?33OpK8k0+RXVcOUUzKPitHESMMXO6viYa5ClJn1UFO8Jn1oH8tUkgkdOaI1Q?=
 =?us-ascii?Q?EWZswuS5zS0LLKenjGQU5vuiuwreoK5+bOnD7QUZzLQ7F4lw6exAxOciq8+0?=
 =?us-ascii?Q?GXNfrsLJ1pLffdTkzK0Dsook8JFasdc/WB8ZQUxAUr4Me1n2sPBWZyXdOvRS?=
 =?us-ascii?Q?i3roj9butmfUE9TG9uLOCr3BjLpHmIsy3M40jUQSKpP9JjNqdytBffcTNXMF?=
 =?us-ascii?Q?dAZWN9kOvGYcNAeFgHEzSQdRvpl2KKZXj6mG7J6bQTFYRcJ1Ix/2f7aXDh4q?=
 =?us-ascii?Q?K0vO7CdHPciiPYfKfItL7wPujXDdWfIOBwYZtTBtxswggq+XvC6KTEgmF6JJ?=
 =?us-ascii?Q?fnLvGoh25K0Z31N2sNoXTXmRELjBPc7z8O3iEWIjFF919zDwM2UcMRp5yoFc?=
 =?us-ascii?Q?WQzhvh/+FekhjEP3Hq2bwi0Y0P47uGcqGHqj5OXJX2pao6xtHiMgYE2Ao+oY?=
 =?us-ascii?Q?Pix9Vh6KnP7qkResKw4/GwJJrfrevA3/4LDXexpX26W4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fX5q2GQYtZ5u96wuMbI3QhrT5iw1TXQfgxmsl+yznZ6lbCQYI1GWnAqn4wqi?=
 =?us-ascii?Q?pbbcvkDDIV+VPC8oYeiGTBOjLH67mGPhU3rwDa+8VqlprUfgOB9yGlAToRVs?=
 =?us-ascii?Q?UFn5n9wHK7rG8oIv4ZcgZPR4joKu1ie/tkgjA6Yy0oaagFCkv97F8ifdwv+o?=
 =?us-ascii?Q?4zfvIcm3O16ejLWM//7VU6WbJ0bP1Rc6yzXw1d0tb0VPiZCC/JOsi/H4AA8I?=
 =?us-ascii?Q?INj+4u7D4VYCTNtGcKqnXO/1uKibbbimRKy7oQU3dXoLogepXeqi2QfOnkIa?=
 =?us-ascii?Q?e+Ey6dN2pYEPQBflTnEIupsQdcmZLr4QjRpjD4ETCyKG9n26ZWhfTdVhrXP9?=
 =?us-ascii?Q?edNdy8goKgEOH2aF1Qg4BBfgZz8TX9TA0/JFcegC3a68SDEr37Aho8HxaXHp?=
 =?us-ascii?Q?K8HKcH6uWjLUPcpwq5ps3m8dt7DFVE8Zz3ekCWdYHbzq9fgRoZyLvEPkJNSM?=
 =?us-ascii?Q?QuIj9XQdBSmnqdkcg38jaIVqxHs/ppcE61AeIS4YOmVfaIbVAKre/ncR9GpY?=
 =?us-ascii?Q?AgVgIHfSjZ2+1s/Pt2sTgEYaTD0UWuj2tlD6Pa/pcqLCMkAnwgqtXZ2ZhBwz?=
 =?us-ascii?Q?wKp5yhx/FyFWCAwdeFzo0DilS+BDOegXZwO3GCOAKdknTEzRTlcw7+HsHzMx?=
 =?us-ascii?Q?FWwg5aocvypBBwdPMSxG93EABFpqIg2UXV4NIbRUApSXxx7dwGgjVpRFnekZ?=
 =?us-ascii?Q?h+KOsjf7wdW+Tk3VtoYoIJ5GT3ZyzZeQV192B7045vCbloWfKrjKCwI6oCaW?=
 =?us-ascii?Q?sGvgWFiES7R6aTj+KU/E/lTL3nqQglmIPJLc7WLUvmyD+gTnx+aBtMlF3S3d?=
 =?us-ascii?Q?/KWWyPOBvlsHOdV62BhUvgxVcIu684pnHM+4bhjHnueHOakmsB9DT4m+Ka9G?=
 =?us-ascii?Q?H/z+RQzzTaYOkpX973MLVVOHGsdKBR1Ta2T0HyjRDAEGwwr/G77qswBPG8sG?=
 =?us-ascii?Q?VgslpLwhqD3jSwKAGhHWlUr37shS0vfWbVsUE8jCJaPovv5ZlrnuWXdQc+3+?=
 =?us-ascii?Q?Q0loyVuvHGnzNmO19kOItKbI0cZaZn/QNk5QxMM0EL7DGoekk3QX0v87EThE?=
 =?us-ascii?Q?BAO5pPsDas8Ng94qRGeQ2cH8m6Cq834BTMP+H3IR1zcOcUL2OLrMTBqXM1tS?=
 =?us-ascii?Q?3RTwDZRGXSVZZgN6BbiMFgptF6kyoIKv4DmAI0kr6yeKaCu0o0sbAAHklbue?=
 =?us-ascii?Q?5wyk8aPynpZ/MxXUkfjm8DuHeLH3b6bmdnaZ0UsRGdfKN2xlKE5BB3UaS8VV?=
 =?us-ascii?Q?M32jkQgYv8E2PpX5Mm7Xi3ccXhP995pxyv/uODxWz2xOdkutktM/WrH04rzH?=
 =?us-ascii?Q?V0w2FztEHW4HSffh3OC9m94fDda7zRu6u4K2eqjsoQY5b+JdDOxJIBl/G5VT?=
 =?us-ascii?Q?EtqNazBV23omGRHwUVSKAOn/I+NVqwxcwdFT04Ba3ODb60gX5FiE7xRwObMi?=
 =?us-ascii?Q?s8ZEd0QNVNePQSrdWJaI3P6ChL3pvaz+hxUCsFX+ttR81K54s/k/Irj4cb/F?=
 =?us-ascii?Q?GGZyPtlyj/zpYZh0vAd7c2K8dr2vAfvlYPO+Cc2rqUmuDd3T0Sc10UEK4MyS?=
 =?us-ascii?Q?iZDX3+lH29LCU+fIerF1uOwf4gVIlojYa4DCnOxvH/u8kQjtNgyQl6WDPiPS?=
 =?us-ascii?Q?5yqfItCDF2wEXq3DhFFa1CeAkOycCiJObUglL5uw6Lm0K74M4Z+9M8qyPU9+?=
 =?us-ascii?Q?SZnvguVKbKUGOPWEHq+rWjywF/HI7YtMtPIJL54QH/sB2Ep9KhcpYNVBCjJS?=
 =?us-ascii?Q?tkQXYxa7ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174b5f55-19ec-4238-94c2-08de62e451d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:09.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0toYba6c17OBLEL5EYS0vZG8mmN8dKuof2FJDGFIm0GL8yLpMATqW+s2VWTc45hizU1qsQ5cemI/WArfqUcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256137-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: A15ADD4A85
X-Rspamd-Action: no action

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 61bc267e0a5c..e7113ea971ca 100644
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



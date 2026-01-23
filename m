Return-Path: <netdev+bounces-252608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBLCA3dcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:29:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867086F9DD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F21D3021D0A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381A381703;
	Fri, 23 Jan 2026 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PUUsGbzY"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A6385EEB;
	Fri, 23 Jan 2026 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135058; cv=fail; b=JMMJq0XfwdczlOuMftnotrKhdSxfHxz24/AxtHCOghdCU0Lms7MpVYnWl5/uVmyZZHpC81lbKJYJzuhdL70IACm7wxAah2qpe7l/mRs/RmNyR+jL8mFV+EC0LnlHysAPMaZJqC5l8ttrP+ZyDhsc+/dWaIPlKf1bPT7aotbypkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135058; c=relaxed/simple;
	bh=LJaBZDLGsVzkUnV6jwACgYaMtntPfS7ZS8lGzsZ2JzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL37VsQbp5UQkN79EgS5qcShdmgmglKLsReSSGbgQYAsuZWr0IlVQeDj64KmsYksZWEpj1vHGpsWr0SBeFYfbQngAxELKVG5j6hfwxjCZIB0posBvpRcOSLjTggw8zY5qJ8p6tEIFcl+U3XTKAu+yVuL2Ieb7AAwY5qxbspiOgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PUUsGbzY; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqHbtzEX78mjbcJ+h07UT7mTkgVaJJR3E2xK/Y1UwJTa9dwTWVeJMRO0CvVSoyDRbgAigtZo4nxuLazs3lO6A3O1drKnRZZhjG2OvaBiuIBVsxznMVfeKSgjjXjFbBU7nL+J69MzuPjfzVOdbdKE3WSHQLrtROMrc0c5Gwqjop0XblQACGjIT9kBA3fuqGT68Rpkrn4oFYR4tw0d/j12xdD6hP7nKXl6qrcxXpcumo/LqHpnRCIBglqtj4r+DLX6s24D/4tUCCq+y1YKi5DV4RUJr7ozx76Og0oIkANfojijDzoPvLOINM3bQkgYnC1lQanwsQ47yniiZcwV/5LLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdKx3aTF4+M18OkMCC09P25K94+un9kL5OO0k9sQQmw=;
 b=RDy3nm64zS70zV+x/DGngSgVQWMN3YFAZFcwHvHXoE2KfGtbkCL59wJXgl19aJwOZrgU5/TdGpMWFE70YK0yyctIbLIljeo58twMTHH/Cxc3QPIp03B11nlXUPuqxSNbC4WuDytWB9KNj9+RZiqW901J90mwjp7mIxazaov9K4t4NEHLV82fSJG5s3gcvF2idYr7OIjDU2O9h1ggEK1xmOQamikRzj5zBGZNjgDRXnDgbxTvsWZ8VhcozDHDU2m3bTk1NTTALRGCzfee9NYqSHtQP8qg3xvkVC2iWlh3UQWi5tTGPR7ArD+kg125t5Y4c6UL0SYYOnf1ASet0v/0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdKx3aTF4+M18OkMCC09P25K94+un9kL5OO0k9sQQmw=;
 b=PUUsGbzYNh7oc3AdAkyYWWrOjpvC008CeUqPf4V2b6m1VZeYTMboLv6/3OihuF4gwcFc8kZwdR0KVBhy7GmKuekQvSQuQEFkVQndvzQ63zpfajQiLmC0JfrMUbuHoSMgZUQIosIRTgKFDJaOjoGLXGjxLyRGr1klsNA6LFdXuW3Wvgly6+xdMHPmsg45MKgq+us6G6zPqR1Fmbev46cxp/QEp9PnCILaK1R013rzu8tarA1G3ytVCg2KeOLMw/4x6tuaVYOWpRGWFXwoulrPJomtJIJLnIrUrUbmrmn/QCqiRe3TqW2dzA7m/kZLd3Tdb3YBGdpREvO40c0Gj/bg3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:45 +0000
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
Subject: [PATCH v4 net-next 09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Fri, 23 Jan 2026 10:21:37 +0800
Message-Id: <20260123022143.4121797-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ae95e03-fe96-4484-00bb-08de5a264b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HplasFhK77Yr2uxOBEhTm7CuPhsNL5cHF0Lq0puzgrF/g/MIFv8FhLtYQpQh?=
 =?us-ascii?Q?azoAgW96n/nhZMyQJsl+ti6SJ7yUz9Ejw29myP0CpSlrQjjWavV89e4wzcQp?=
 =?us-ascii?Q?k29mpddeEn6CpEeg1oPDqAsHtLSX1P3n+8rb9GMf6goLeVp/ieWjdgoUlH5+?=
 =?us-ascii?Q?WgxCWxa2D/5TRE5g26yTf06VQaErleJMxU5yBQKa9tqXOGWhPeL7JgcvdpiG?=
 =?us-ascii?Q?sRiZkYBGt8252/OmH3Fq5Tjbv64Q1mSpdJnEBcI5/G2yLaa90OB5Rr6uN4tV?=
 =?us-ascii?Q?xHF1dq5R+20tjqs17HGe9wpCnToLWXxRrxjEKKHt6qYwX6OQIOaUXVF1uZwn?=
 =?us-ascii?Q?bFqMbXPgz3wg1Ebmyy0RgLwodnVqiJ2/3uUuapHERjWI37VzcGpES7idau/J?=
 =?us-ascii?Q?bQo4SspZYGX/qZYUCVJ1neArIh0/SjxuMnroiCaGpxYnCH6ds+NhfZyEUrdp?=
 =?us-ascii?Q?0Srr54asLHTMttIYDof4xSo3kh24tOnTvlhKSOjgMJCsJuSPS4lzflyo5A54?=
 =?us-ascii?Q?Rv6dATW3U9syczsjbh5hBomAofKbAgsjYci6VUSeYqP7Ck2eRL2pJVljoV9u?=
 =?us-ascii?Q?Wl5in6FSz/ZaeyjF13g5FeHaBLIS25W78xiiOUzTPnpVhanEo+nkH2uVh13c?=
 =?us-ascii?Q?rthcRvGLMQH9jeSCB3ZmdIg0CzADuzKEwO5bdsq+HF4sgGYQDygVFSlDW3Ty?=
 =?us-ascii?Q?bmNTCe35AmVM4C/kEPQpW/EBC9fbD5Uql1MUgJzVTEvwpihmVf6AkAYYQWt9?=
 =?us-ascii?Q?zM7/xd+aVNCyioc05gEeIz9gjW1Jsdv8XaJQ/2D4QNhgpos6JO2YEA9KThxQ?=
 =?us-ascii?Q?imE0Du0OEdx6kRVj4/NtaqBOOT+e23QiW/oveYf2ewfd6ldL/IZzvFTxvdsR?=
 =?us-ascii?Q?XE6KeCNwtmIjTNvnP1TuIe7VKjjyLBbhkz5b3VdNuUSUWIo4YkHKfvuJsT6Q?=
 =?us-ascii?Q?6xdKYTo4l0GNi/r736H+PEoJ3hxXPgqL1OKmxLXelAh/n7jZocgW+QrXVPJO?=
 =?us-ascii?Q?F7iQltwnSmpE7vGZhr98z7IXyWCIlkHXYbhyOkmdG0WcgG0gBSNr8m8R7GkJ?=
 =?us-ascii?Q?43wG2W4J2yg0XppfgjE1OCOAQ27YUwl1FwwW9fsO0XD4lKNtyLuLi/saX6iw?=
 =?us-ascii?Q?fo7H2+w4r5RqrAahw5wEUgstflodtA8Bgl2//7SH7IUXOvBD0jWIwruPzskG?=
 =?us-ascii?Q?6qDOQP32p8GxfZ42gEJF+rMmlnhLV3KS9YJGClsWqaGInjZ3uiqtbFDofK+7?=
 =?us-ascii?Q?c1Q5eRxuIU8Jk54fXXaLQnmEFMa2z15egrC8ZMJ3YN/F86HH1t3bIba7Ag2V?=
 =?us-ascii?Q?miMjZ52elmpqHJd1pYcheOXda9AYQ7DmEM7yfinyP1p+mmVEDBDj9bFy1ckR?=
 =?us-ascii?Q?rdtcSi8VHUrdbrchJF/SSgFJI3hLpSV8SKxueC6H8iET236uidoGv+AWJ9MH?=
 =?us-ascii?Q?8ANFkD0VjzdutIhYKejZ75H1TtUKk7DeadXp8+iAfvbJUsSOtsaXpmol5e2E?=
 =?us-ascii?Q?HS+BnNcENwKt1kspgisbTT30/nK31cJ8w7mjVAqE5ij6r3oLLZW90DVi/xfb?=
 =?us-ascii?Q?bLDiaYViOTR/HXC3x4g3zJr6SGtr21Mz3GmgnkhtTULotT2KM7uzpnzkhe4K?=
 =?us-ascii?Q?pwr0uJRXvcovv7xrTPiXce8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAj5A648LklnivQre1ycWwhMfRdKkLgaVt4yl8RK8rztgmK91d8VPLpQqSyD?=
 =?us-ascii?Q?sG1vrw4fVXSi8Ll8u8hC86E+hOypUr9ZSUQ+cFjbh+MSIQKg9tcMRjU4Kkj1?=
 =?us-ascii?Q?QpQ3zdda0bagogC0ILgEhWLzSPBMWXRRGiEQdQ4aSyzqgfuA+pw/WAST+Bqg?=
 =?us-ascii?Q?Ky89Ifa85YY9r0mUL56q0bcmVuXQvND5yAhyddllwihLpK+aKDAignrPYy+1?=
 =?us-ascii?Q?JdS/TAn5sYZwn/heGe4TsG8vIYvxxVH++3fL7f/c5QGN7tWMAhsgHFGjyITm?=
 =?us-ascii?Q?3xiQ+YzZKLei1R3ldFZzTfbLmAYwptPtpm1XJtWF0k6ZnAYojTWwLQ5+FrQO?=
 =?us-ascii?Q?+P/Xlm3iAMudCAstaRtgXjJ2L+w4plUM+IyJD1vpMdZDPI3QKfqswr7I245S?=
 =?us-ascii?Q?CEuRoH10kyAbB9k2PXnT74VLTR0h6RHSwtQbGmTI6YNwn7gW8mtQF9Uno/8n?=
 =?us-ascii?Q?w+H0x88RZMGXhrc3NDWu0K/J67q/AE5o+fxVHxnwJASA+FWgzDlRhsALxQH2?=
 =?us-ascii?Q?M3eccTUkGVmFE2KxFHn04uQg95A0LHdQHQ2wS4ttsw0dgDRC3SpOy6e7+JP4?=
 =?us-ascii?Q?msimJzPsVmkI7kc/BnRpmj/dmseGprqdYZPdeFpTMM+dP+Sv+7TYNUfEtUJF?=
 =?us-ascii?Q?qSyuGtGYKzeb0+leLkmRwe2ufERUXtKrhS7CXJAvqlS3f+I0iudPDcxm0/86?=
 =?us-ascii?Q?Fb1ZYvESQtizo+I/n5cgTE020d+nR0RhJZ8Z4Lpu0Er0ujHdYgvyjL8sTEwV?=
 =?us-ascii?Q?j8j6QmU5Iz8TasVgiZQ2YeHyBkgk/w72X0VQUXQ8/ktAxNRySwmEGo84Xwlm?=
 =?us-ascii?Q?mEixRIEshE6HdQaSNf/kFuBW7wSP12v1/JyIf6JDFxXQiRncRJqR/+M54jQR?=
 =?us-ascii?Q?tdVgLPwP1k4PHdyqoYOFRmuiH4Ejk+6vySgLyBKSk7gENFOD7J3PSggfG0WE?=
 =?us-ascii?Q?cs5HDl7wacOSQwdjgs2B9ECTmOGmOacgxSdQOWu3GspSgvQkcEescZvc1nPt?=
 =?us-ascii?Q?wYxLxWqUxJve7zFNJ01On7cQzgmmjhpi4ekVNp8yC+GDk50kFtKoymz2hFh4?=
 =?us-ascii?Q?KXTGj7o0TwRlpmEfjspInIKmsEMj48Td1wbq+hpQUxyfsuE6lVDy3sf9KFns?=
 =?us-ascii?Q?QO9rOOShAHZulbSXSOj5FQ0w3yF+6I7IEWjLNm7BIByTGDvA816b02Od1+td?=
 =?us-ascii?Q?WPS/v9/GMZPD0mSKiD7OKca/nx9DWmxqqCKWUK9bN82fELW4rvp7woaI5DX1?=
 =?us-ascii?Q?X7NKGuuSnuz8GjpAeq8hiFDZ6kB2s0e9CCs9Je8ZsvuxT+icrCU2Vry9fE/t?=
 =?us-ascii?Q?zgv1ctjvzwBhCm9JRnkMBxaQ57ks5ReLozDgOuUNoUA+h//k4oLXvEkLR3Oi?=
 =?us-ascii?Q?lwVtW4uQ1wS82JxjQFeXBb8kDHI669MtAdjR2BteeYj0AV2/P1K8wh9k5A3d?=
 =?us-ascii?Q?Os1jI2q+oEpM/e8yEf8BhmeplBq35ST6tMKmIuwBLDX/lyoGjcZFlaewSYuO?=
 =?us-ascii?Q?lBMxSEqwgS/KN1D9eZt83b7sBSUnfGyK0zXskUV/mzsvVkQ/IeKREVI0sXhB?=
 =?us-ascii?Q?VcANbBpwkFxpBFAZNEsv3iTRajdrUQY8FklGLL6nnE+Rzv6UL9Lwx4CalI3Y?=
 =?us-ascii?Q?EKRlvW/BTTjJPMiSNKt11wgP6nhEWY7lDXH1zbT2LX29uAhksXhW0f7uY4DM?=
 =?us-ascii?Q?39/4QqsJa6oT7qAezYMR+YEu0JJFoshKdPBa/cCV7OxyEbZBony0pdT3+esI?=
 =?us-ascii?Q?4yQ/KUFfBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae95e03-fe96-4484-00bb-08de5a264b2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:45.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3jJfwxRy827dsbub9SSFdqy6SWC36UaLqNeyA4Y2Twl88yRowEUkHirVPDOjB/kJQK5cJXbTt49jP2pmNdjKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252608-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 867086F9DD
X-Rspamd-Action: no action

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c927ab5ad8a8..2d486a62c178 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1537,21 +1532,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1



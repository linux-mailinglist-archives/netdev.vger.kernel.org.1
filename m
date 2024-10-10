Return-Path: <netdev+bounces-134197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF128998599
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC92B20628
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C51C231C;
	Thu, 10 Oct 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="cdwpPwEq"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3318FDBE
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562142; cv=fail; b=FDkbybLxu11fXBtIDp6MwtYtYNK1dk3Minzk1qWgxAKOzLjKqtgssX2jJCBpjAmO97VISJv7MGaX3ZxnLBqSYZ0QnYqGBZbTIjwO1hc/zp6yccN2URBbr/BbM7JIcrDcWNvYQWrDVhtRGcwt3YEB/6gm/n8SvW5UsTzlp6RmQJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562142; c=relaxed/simple;
	bh=WrA8w2ILkGsuPmVSAToUf6XXA7wtgJKvW68YJZ1uS/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxMgiiFUmWvaRiYhfbfVdloo6oy0V9w7Xuj944aRFwkw06CjqmmgMXqQM3CRWaZB7Ws4nC3SC318xMtPNk9ZJQSvmXz3BckhNqEMkoaXbPl4/5A7dkfeiY/zpSomisx0E7Zd4ohm+7ItNh2SwL4kP/0l8Oxd7aPTonmr+PpzUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=cdwpPwEq; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 941C781F17
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:02:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2172.outbound.protection.outlook.com [104.47.51.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2D9F11C0069;
	Thu, 10 Oct 2024 12:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q93c1uHhUzmSnJdK1fhwLUPR6uB6JNybBHjrFpn8TgMVWwZK3UN5k6vfzKfPkzy9ATkp65pzFba4CGMHIgjOusHVtsAJu7FDzfPEH9zg2FAW28t02yR9KqlYBX0oEn/HL51cTULVBJ7qqXFCXQT8kwNkkxENfSV8O/fuhuYTvGnMapUnsTwpohf72/yvjfTh4qdcr7I3PKtlqWY4KLDVAOF5I/D3AuE/oWJOU0nTXP8fV4YFZK+z2uMdLvtZMyQ3DfkdTvLfUvs9/pxT5DxZZ9spfHhLIjR2xMAVIp4Qqw1roUIi9Si7PtTHYoTW4Ae6+EikqPBlJ+5MpPCv5HJlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPY1WUwcjRFpHnFs+gTnXNFx1d4DwjQK2tAnxFIrAdM=;
 b=WipSoq1QwmtETmPtWlyaoQ1ouACqZkmqU6EkySFxOPJv2icoveKCuie2CYi1JnPqYeGrcnTtUSCXz1TOkyIKcFNC0voATMs3xpeGK4MFwtppLxrmLtFdx1shoToVGUJjPR5LXZQEo5Yrw+wrz7ncXpClVYAy9w9VV2Ds+G0Du1FFzP+dEQU2jmoC8dfhZHMwD5lq4fLsmdufSEo5oRBN047qw1fOe8SkzjIObKTEw4zcQBsHE6FxaW883U86N8YXLNa1r7dtAGtJA/Y4bLF0YBbhzE/nnLxpbJjPBzXfWQwD/b3hM30cvlI6O/RoAF374jZesNXy1Yeg3gvqXrJSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPY1WUwcjRFpHnFs+gTnXNFx1d4DwjQK2tAnxFIrAdM=;
 b=cdwpPwEqv4cesfQkki0USe2iVcIkUSz+A4+ReUOSMb6VAc794b2odI5X7AmrO1QfVXzaR4n6AORva9U2AeX8pGqn1l/qYPpVTmXwL+Wu1atqTCCH4ebZE51sgyChBGwXntCCzPZ9TN8o2g9GOednSCaxpZwX67+DG97BTeYxo5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9909.eurprd08.prod.outlook.com (2603:10a6:10:403::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:01:50 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:01:50 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gilad@naaman.io>,
	Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v3 1/2] Convert neighbour-table to use hlist
Date: Thu, 10 Oct 2024 12:01:24 +0000
Message-ID: <20241010120139.2856603-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010120139.2856603-1-gnaaman@drivenets.com>
References: <20241010120139.2856603-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e22231-f3b4-43fc-56b9-08dce923529a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzgVMfyz5YkjzauuEN1IN6gLjDZmLhkb/v4fWoM8av2HSEZ2KrmjK8WJ5yev?=
 =?us-ascii?Q?lBOdctIeCxU2h0B3WSJxvyf9xA1WWaIgKrSVCxib8cYZmHOq2yKqi6SxhP+Z?=
 =?us-ascii?Q?VxiQGlLfYu5ca1F0ecdfM0Xv5PA9kW3KueNZdtUeGgvg6POzYiTAaqvElQVL?=
 =?us-ascii?Q?vDudpbf8n4//vk4sJDqmLrLTOmX3yKgem+mh/N2LaMOg/GDS4NP/Qc0oH47U?=
 =?us-ascii?Q?vMIo8gXPy3lawsmeYt3zlHH89zi/zrfpLhxXkTHu4HitjvpXDyR3K8HWnB4z?=
 =?us-ascii?Q?SDAIZgx/cZluFVTnduruPtVEa17WpfkpDdlFAsifsqLlMBCxhjL1J7VrVY6n?=
 =?us-ascii?Q?w4PaYOFVnFdyF7BSuWtT0wo4MgpAVqyXjI8Wq46sriw11GSJgtmoRB1L9O9W?=
 =?us-ascii?Q?siPCSGZ1xnvBuOPaAtn+8NO0GzD7gps8+BUq+yTnjeCDxu8EcBTlLWzl8hg3?=
 =?us-ascii?Q?L/PXwDpY/62rGSjYQ7iKLyoZin3hd6vgXw6EN4zgplBh0KC9mbKddG2YgZ2H?=
 =?us-ascii?Q?d0WiPT8pKjkX5HTuEV5IA71DK3OqlUNShn40giqngB5USFznFF05RS0q4st1?=
 =?us-ascii?Q?6ZolzmOWX2COrOIhxwOvMDFHkCpW3pAf1fe4gfh9w5ylKNaJzSJ+95ae8Y4l?=
 =?us-ascii?Q?coschqbjAUbq+ardf2Bire+cgWMRQeMbmm9jQQu3V+de1E2nI+nF68YDSA3I?=
 =?us-ascii?Q?Xg6TG5OcF7+1xzm4aPVK7+hb7k9TPm6USPHOAByqaG1KSGamE8gxbGZ/EpUT?=
 =?us-ascii?Q?g8XEAKrFiM1Yob8Ifn3x0N/lz+pn7MJZ6DJgm2DX6GnztlPUv3qH4AU1pQFC?=
 =?us-ascii?Q?/OFFqhbkTmvfR6ykOf0W2qHYlahxmGA0aK6tGRpRwzdxGXMpqfRSRWxf26W6?=
 =?us-ascii?Q?bqMFboeIB2/i/jp9S+5Zuez+1voJHMtL50R6cnoHDSfhQx9Fb1twdV/AtJcj?=
 =?us-ascii?Q?APnTmtQpvzvXaRp9CFcqI0/CVR569CmqViNTadx4pTQrBLKKmtQ7zddTW0t9?=
 =?us-ascii?Q?XCwp8rI8TsamU92R2KPkKyw+5JUqc7rLaSKzgBdbv3CpS0b0ilLaCMRvrvul?=
 =?us-ascii?Q?3HDPEoaP7xeWnbQUM04TRInXlPjPmD1qFe3gEFkgy2G3/Wo2roFcwPc9sDiH?=
 =?us-ascii?Q?NOrkO07B7ecepBVoiT30YlYsbBigXo1TncIJ9H06r96OwySV++2Rwhdg8Pr8?=
 =?us-ascii?Q?dKXI62m4TR5yn8Dek2T21mLeo5jD14ZSMzPc7iV3/EaXAZG/wwguld9h5/ly?=
 =?us-ascii?Q?0N+cUSQu/fRFvd6oFmGJT6GZ6oQEjBMIoF8QigrIH00ZASrU3LjYtRRLXHk2?=
 =?us-ascii?Q?8D47Fi8jl3TFn/PS0/gdnFDgUotg/MNQeXeD/EgLrqDg/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uu6KNyhB6C8KGvkKQsphyXxlBf7FfEQwYF7uMizwqhEmIXaRcrLdqUHfTdoc?=
 =?us-ascii?Q?TrW3zxeTM9v2f6o3ls7qtdZARJUiwrLjoPXtcQ/zNA++RwzFpozahL743lhe?=
 =?us-ascii?Q?Xq3V3SGOUYLtltVVoNGh7MIRS0lTdaR+b3wkBqs/DE4fH8dWhh8EwA7Ay9wM?=
 =?us-ascii?Q?EqFktmuoZrzCl7O5RCsDyyQ8OnEaoAr/UDr+I3PD93PJn4TKojKOxexyWPHS?=
 =?us-ascii?Q?vpX3B12vYhe8Q0Yx2h8Inj26G0imBabQChlmaciVG9xC15TU7dQWfKNMpO9u?=
 =?us-ascii?Q?ualxQx9H4hQJWUHLyDZO3X/vgLzri4m+9zdaQFZgtaGptY+QLpQ6VDFurSOx?=
 =?us-ascii?Q?skwWN18Dh/L/LfcYmq67ocnUg37Vb+ESD9GJ1ZexgJB+esS4yf4Ms3iCcyIs?=
 =?us-ascii?Q?rC0dtrxvs346r4UqUKbQ0OZopcLdkwkhEtIV0Z/UvzFglkFyp2bWnUesd/jE?=
 =?us-ascii?Q?YmRBD4pwdbqINsb2WI4vBQhSAzOrDPbBJw3FatbVcKHYpUGBgbMFedodSTV/?=
 =?us-ascii?Q?ViTtmtbRrTTQmXiOIsdXBD/PJc/ne6qMU7Wa13qgc3vYUgwtQxHdkj+/eg1p?=
 =?us-ascii?Q?DHycqeSH07SfH6SjtkFDN5DC9giA4a9+OhOEZrwg4eZx0015zWgpbJ330mmo?=
 =?us-ascii?Q?AVwOd9LwGA1sGmzm3S0GtUQBbKv/+OzpUltbkoxgnMZTq3TI2DdCGhYGFyJV?=
 =?us-ascii?Q?2IWQkR59X2VVercUcR5soW5A5nG820UeJaOYStSAdUT3BuaryCVSCU/FZ6YO?=
 =?us-ascii?Q?TcEB0yONzIV3rtW6TCbGGJmtECja7pQSEVRmiDciQsaMf8uUOHS3FS7u9FR0?=
 =?us-ascii?Q?/mfq7WEMlwir2eK+KGsWshbkUUNlr76wR90ge+tB8KooN5PsUcM6Qm3ErM0N?=
 =?us-ascii?Q?18xDVod4cfqzE23GpV1mOQtAruHonosR7dNIUmBqJTVA24gSoHc1SsSwy0lw?=
 =?us-ascii?Q?s7QAqppTMvnua1BDIj/VzvSlXP4dPoFjgvktMeC6MYu9CCsPGzkNCttnAvuU?=
 =?us-ascii?Q?uRmvnjPgOnncWXNHyGF3snuZNCLa0Xgl2PUoqcHvDysRCZkNSyg4BabN8tM/?=
 =?us-ascii?Q?xZJC91r2vFJVmNnpgo3mk1ZzgWbRPeuShJ2/yIoS6r/AzV0ugE0/f8cxgHnM?=
 =?us-ascii?Q?/MS09Ju50FJaSEFp1r8VRWUEvhjUOXOdwThoXjJhTCVvy86IdZHK2eRJc1Um?=
 =?us-ascii?Q?ZCkPfbAojSy/1D5tD1k+/hWHxhKSZz8CxS9slfxrJm1nJlgqCF1Stgiej5nR?=
 =?us-ascii?Q?NjkFnciR23lPf+HnbQmORU7+NfmEkd/hhynKO8ohx4zmDR/pFUffuuDuJMp1?=
 =?us-ascii?Q?Xhynjggms1xaTU4+xQWmDmnFcXm7K6VfmOF47OkpeDeIsAdLW6FlCM6fDoS6?=
 =?us-ascii?Q?lhT9EhlNld7TJKRhLbR2hghprrwHIpgB9iMVn1FZ+RGuMLg/Gf/JcNfrFRV/?=
 =?us-ascii?Q?vqq/4ZeBSx+eZosRDteaHvjNzxe1iCXD1XpXdWxnyEt6rEx1CQQVcDT1h9Vo?=
 =?us-ascii?Q?GL2Uv/OwymjUT/eeLepabI5dknGu/P3WwzGCD1ioZQsLt81m8C9jD/aYORtj?=
 =?us-ascii?Q?YDChcvRmtZHBhCYJgTGccXGCTSgPb1kl0NHfaEt3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I3HYWzpMfEar4ZFrzh4Fdzk898YbVZCtrbwaMMI9Km6iGFu3/oyY6OO9ZzF8Rrf40ODwq0E7UzPIzaOayv+opz1Sf+mz/POQqooxidFfxYSl4M6fSyGjWgAdY6AAab2B8746PnNI8wsZgQAWgm54+KcDWUPGCgOQkdcFtIq55UhHHTD9sq1lJTRIxcTaZv6mYNmktJ2yvneevY/EbKHFB1INZQ/0VyHT61+4z35Y2erd8+1bjeGS05Vu7ocY0wgrI+SBVSrQRdoaNU8t5s+84T4lAr1Od3p3ExAujMnQZ8FOZSCLnUedq6PLzjT/MitSyrZkqVGXp3ZI08AKzz9URdkQtTNnhRBFKb3cpeGuLdrM7FnjUxYnl9im4LnyiBdm71R+oj98XHyebYUK9nkGiUnnxrptVOtaHjhOiOeJchQd4YyX4I6EpGo1LfkcT2OAjEAj4TDKW+QDoLCLhtbRnp2AIaBcQ4mX2U8FbORm1pxH73uK750uwZx1SNm4yJfElyE1pnslcy5g03ddnOIak46us8tXQZTbDgXdUa7cK6KLS0HY8uCMmUFfHTgDSAKqUTcivqDVz1xMU6d4GY6SH7Sw4vd2qsH+SxqZKoyLvBdliNSzAiUCHObreHgnhtXf
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e22231-f3b4-43fc-56b9-08dce923529a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:01:50.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7xnU/fEXuli5Z2OVO/HAlV3JVk7SaCm07VZgm1SpHdwQGA00A9G7U0bLlSQ/RhWwhHx3mAV9DdFezJDbQWgjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9909
X-MDID: 1728561712-tenbvlfJrzFP
X-MDID-O:
 eu1;ams;1728561712;tenbvlfJrzFP;<gnaaman@drivenets.com>;2328388050003780ca43480a2715a176
X-PPE-TRUSTED: V=1;DIR=OUT;

Use doubly-linked instead of singly-linked list when linking neighbours,
so that it is possible to remove neighbours without traversing the
entire table.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   8 +-
 net/core/neighbour.c    | 162 ++++++++++++++++------------------------
 2 files changed, 68 insertions(+), 102 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..93903f9854f9 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,7 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
+	struct hlist_node	list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -190,7 +190,7 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_buckets;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
@@ -304,9 +304,7 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	hlist_for_each_entry_rcu(n, &nht->hash_buckets[hash_val], list) {
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
 	}
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..bf7f69b585d6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/inetdevice.h>
+#include <linux/rculist.h>
 #include <net/addrconf.h>
 
 #include <trace/events/neigh.h>
@@ -57,6 +58,26 @@ static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				    struct net_device *dev);
 
+#define neigh_hlist_entry(n) hlist_entry_safe(n, struct neighbour, list)
+
+#define neigh_for_each_rcu(pos, head, cond...) \
+	hlist_for_each_entry_rcu(pos, head, list, ##cond)
+
+#define neigh_for_each_safe_rcu_protected(pos, n, head, c)		\
+	for (pos = neigh_first_rcu_protected(head, c);			\
+	     pos && ({ n = neigh_next_rcu_protected(pos, c); 1; });	\
+	     pos = n)
+
+#define neigh_first_rcu(bucket) \
+	neigh_hlist_entry(rcu_dereference(hlist_first_rcu(bucket)))
+#define neigh_next_rcu(n) \
+	neigh_hlist_entry(rcu_dereference(hlist_next_rcu(&(n)->list)))
+
+#define neigh_first_rcu_protected(head, c) \
+	neigh_hlist_entry(rcu_dereference_protected(hlist_first_rcu(head), c))
+#define neigh_next_rcu_protected(n, c) \
+	neigh_hlist_entry(rcu_dereference_protected(hlist_next_rcu(&(n)->list), c))
+
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
@@ -205,18 +226,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -228,25 +244,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 
 bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 {
-	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
-
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
-	}
-	return false;
+	return neigh_del(ndel, tbl);
 }
 
 static int neigh_forced_gc(struct neigh_table *tbl)
@@ -387,22 +385,18 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct neighbour *n, *next;
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe_rcu_protected(n, next,
+						  &nht->hash_buckets[i],
+						  lockdep_is_held(&tbl->lock)) {
 			if (dev && n->dev != dev) {
-				np = &n->next;
 				continue;
 			}
 			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
 				continue;
 			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->list);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,9 +524,9 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct neigh_hash_table *ret;
-	struct neighbour __rcu **buckets;
+	struct hlist_head *buckets;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
@@ -541,7 +535,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		buckets = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
@@ -562,8 +556,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head *buckets = nht->hash_buckets;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -591,7 +585,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
 		struct neighbour *n, *next;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
+		for (n = neigh_first_rcu_protected(&old_nht->hash_buckets[i],
 						   lockdep_is_held(&tbl->lock));
 		     n != NULL;
 		     n = next) {
@@ -599,14 +593,9 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
-
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			next = neigh_next_rcu_protected(n, lockdep_is_held(&tbl->lock));
+			hlist_del_rcu(&n->list);
+			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
 		}
 	}
 
@@ -693,11 +682,9 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each_rcu(n1,
+			   &nht->hash_buckets[hash_val],
+			   lockdep_is_held(&tbl->lock)) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -713,10 +700,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -948,8 +932,7 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
-	struct neighbour __rcu **np;
+	struct neighbour *n, *next;
 	unsigned int i;
 	struct neigh_hash_table *nht;
 
@@ -976,10 +959,9 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
-
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe_rcu_protected(n, next,
+						  &nht->hash_buckets[i],
+						  lockdep_is_held(&tbl->lock)) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -988,7 +970,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -999,18 +981,13 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -2728,9 +2705,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each_rcu(n, &nht->hash_buckets[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3097,9 +3073,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		neigh_for_each_rcu(n, &nht->hash_buckets[chain])
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3117,23 +3091,19 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
-		struct neighbour __rcu **np;
+		struct neighbour *n, *next;
 
-		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe_rcu_protected(n, next,
+						  &nht->hash_buckets[chain],
+						  lockdep_is_held(&tbl->lock)) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->list);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
@@ -3200,25 +3170,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
+		neigh_for_each_rcu(n, &nht->hash_buckets[bucket]) {
 			if (!net_eq(dev_net(n->dev), net))
-				goto next;
+				continue;
 			if (state->neigh_sub_iter) {
 				loff_t fakep = 0;
 				void *v;
 
 				v = state->neigh_sub_iter(state, n, &fakep);
 				if (!v)
-					goto next;
+					continue;
 			}
 			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
 				break;
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
-next:
-			n = rcu_dereference(n->next);
 		}
 
 		if (n)
@@ -3242,7 +3208,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
+
+	n = neigh_next_rcu(n);
 
 	while (1) {
 		while (n) {
@@ -3260,7 +3227,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
 next:
-			n = rcu_dereference(n->next);
+
+			n = neigh_next_rcu(n);
 		}
 
 		if (n)
@@ -3269,7 +3237,7 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (++state->bucket >= (1 << nht->hash_shift))
 			break;
 
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
+		n = neigh_first_rcu(&nht->hash_buckets[state->bucket]);
 	}
 
 	if (n && pos)
-- 
2.46.0



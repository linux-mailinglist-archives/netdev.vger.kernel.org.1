Return-Path: <netdev+bounces-130700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22498B38B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670B3288B6F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 05:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7A1A3BDA;
	Tue,  1 Oct 2024 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="JrIfzzO7"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004E74E09
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759461; cv=fail; b=WrsgB1HBFS+oo4E5kX0woM6nD4fuX0ZGmkqYhGGb6ZJxIhN1aWxNPFy4dGMtr9CsQ4eiIUjeBFRc0v258ZKIjiWU0be9OtqXoLhbkbr/7wVMNpm9Aj2ROColxDYeJIfchzd31GUGeLXhQbXggxst9TA4cyaKoKEwvR31hx8lKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759461; c=relaxed/simple;
	bh=ks7zZbFweDTIv9OkogQ7mxhE6ymmVuWNzc9LDxRmXbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpbVM/aMg06omkgzSnWp2IkaMXDKDyHj+6nE73jpuXvZWTg/cU13bh5TeIt/CD4xmggm09oodhCvbZ8YrfMzSR4OJM1NnCxt+yMZ3nyvsm03Tk69Y86yEvQg8H87w/bb3OJWB8JQijUI5TTte9cQuWuJtvQzDGZi6L0HCbHoM20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=JrIfzzO7; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9C60834142D
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:57 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BEE156C0070;
	Tue,  1 Oct 2024 05:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPwxpBSmnRvUfHZBFNm+QF2yaMS34K8ZmKCXlrM3lrbmX06ZKY2eMGu4VDx2Tt3bdxUo7DBalT7c93qMu10S/YACWxcApqi8vyIarq8Yqalon+/8Yp5e6e5xaetzDw5ShsUMlZPTthVrl9JpXgm8g2ipSAaxAA4vJNY7vKDM/cB+ddD15iy0GIj7ytFI2hDQkYKr7FppiPAZ9kgtzT7BA04YscvhYAAUg4TmaEQ+B17aAfpbLtQIGZcuTV3JIfPo1eKigpJRDjnd0o0cfud6TzYUhavJts5pKfRoFf64d5TIuFF2kRSSQ4KSDe6YRTC//9fk9i+tvgl/PXD6qYKakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx0nRuNn0QPurRKzvwe0jVz/sDaoxnUb/N7O32L8GHY=;
 b=OjkHoT+FbbOpxsxkW+FPvdQ6nPoOc6+iSoWrx/EF6Wdxsc60XRD7cvtx4gslfeYWt++ydMffAxosjNuGyLVyNcD6bma6Y5HsVtBvfG7IYnIbaQXGD+qs8L0P1bsDWzntTJWF2RJEIyK+Offrz9xW3Yz9SkLEOXuQEfo2U/Ury0RONwi54R2IT+oi4QD/ScdNdvp/eYY4lz+mlpCfaImgtp2loI0iW4v3gk4IjzQdRNLTsFCyYou2mQE92RcFl2JIKBUc/O8ztkZj0PtYF1Aib9cnphiyoGPmnvjxmIJy3KHc7w9O1pv/h48Qosdss1yEHf182MVJKjyqJOfE3sb0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx0nRuNn0QPurRKzvwe0jVz/sDaoxnUb/N7O32L8GHY=;
 b=JrIfzzO7n/0uVHQ9nIb8a6WJ9zMJ/xq+2mabkF/wfe9DTu8dAOy3gfhxfGc+uAATvLaz7QGOcnFe0ytEG+qagKoppRCDrltXG5TxGR4pUIqo4tTuPSA2Nkf23FV1ig5fMG2Zl+2uaQaXVmz9QoHHeOoQDcoNb41E6pvR1WUbtdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 05:10:47 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 05:10:47 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next 2/2] Create netdev->neighbour association
Date: Tue,  1 Oct 2024 05:09:57 +0000
Message-ID: <20241001050959.1799151-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241001050959.1799151-1-gnaaman@drivenets.com>
References: <20241001050959.1799151-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8e9823-5a0b-4814-b26f-08dce1d768bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGdt9O1uh8UoygGz5eRmoe8ltK5yGNxo0ZZlN2jXGxw7z9oouRzcVCA02oNB?=
 =?us-ascii?Q?bq6l6eWjolXocOielqL2RNuwHyqQEZyQ4OForXwy6uQH3D1dehe7LOXZqKvQ?=
 =?us-ascii?Q?vrRVpNc+obrTa0ZkDb8zK1Mag0Z9JysXGZjlCtzz3qOgGP0sbQt5gX9z4pf8?=
 =?us-ascii?Q?ob6xBtZOTHu2KDhUklkoM/Dtd+zLPJR0vUVtJN2yvu6OkC3fvtyKbWOf2nEu?=
 =?us-ascii?Q?SSPi64+JBzgynNUe2XGsiW3XmcPgGBeilE1s0gKj4TV/ZNf31tQBR4GrC5Hy?=
 =?us-ascii?Q?ngULbEFzk6lgDee4NTBD0O2QQhvhEnr8WBNa5rAH8AMJzLloEmKebmHsQh5B?=
 =?us-ascii?Q?BWCK76SPRHQNm7lONhQ088UAyfLtJLdWJiukTaAUPOzBzS2EnZesuoJ/18TN?=
 =?us-ascii?Q?a9jzdRjP84SWZHJG9+4OUNbuDrbVhobfuo+X9vcghj7HJwi/3MEFOpdTt8cz?=
 =?us-ascii?Q?fv2grDB/ih4OU3l0C5sEA2VfNYH67fdiRe1s7GV8dycNgd1UOm6Eh7JlKE0N?=
 =?us-ascii?Q?PiN2m5I+jeIRYCfXplMs3NY7QOWMg7rcJSz+EfrnMprxV9G0FTaWnHafaFKD?=
 =?us-ascii?Q?m18ZJVy3Hbe1/j85JfgS2POVsX1J1KKrQnMPj3NU1L+dioT/rkSRqXAC2FN0?=
 =?us-ascii?Q?kSGxl4pDDpG6eRzig6Ec7+R4iUkJgaW3cDuNjjeNWnb6M70L71qKp6dXxTDd?=
 =?us-ascii?Q?BPrVD3Ff6yWI1qG+gIXDVe8TAcjkwzBqvungvJeGBFoyNOcxp1kVnvR2B4zp?=
 =?us-ascii?Q?h7QhD92M2dPQ2j+ad9GebrRTjmsb6ShP6yAesySyo/qm2NQqZOi55p2Z5kYo?=
 =?us-ascii?Q?lSEDg0OqFZrYUU3YWD8IJ6SQImRtZS4V3IBBPYyz0qeEiO31UarpoQBr9Tkn?=
 =?us-ascii?Q?ZgYxQPDZshnGNH7mNlc1njf6zyuI/p/5y+fqhshCk2zRrLFzfmdTinKl4MYQ?=
 =?us-ascii?Q?+jUITMZvCHiQKA0rSuXAwXAEhnACreSOdt4CnYfu14LsrdznFSayQOr1g1xF?=
 =?us-ascii?Q?qiVBkkTHc6gk7kk4z++IleOimu7JvITLvCqkGaXRp0/cGAAcuIOd2o9VZmIK?=
 =?us-ascii?Q?SJJekhsmkxIaJIxLzpehHl+UjpQYrHj5IqMZpWaLByHXi0cvlfDPARuy3qnq?=
 =?us-ascii?Q?cBHAqTDE+B4D42fvuJveuXfxPClsvAunCcN82x2wbl+U5mAnlX2/o2nfMmPa?=
 =?us-ascii?Q?riBYoeaynx1Mhmd/hk1gn+oVrIFjAahXbowxG+GdWzUf/lwXn0vKPewHO2C3?=
 =?us-ascii?Q?WBlzDzvhQwOhgMEpiZq86+AMJemPl1aG+XB6DoyJQyimi7QIE5ofLDhddUNl?=
 =?us-ascii?Q?4gCN+bgGtFQGzvk+kwlBNQr7N/rlEy+pof6szQbxhONOlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lW7YktwZrZAU9zAPdt0um4HevgAWfy2oWG5qERbLCH5BZCKoDLfIgecdIPq5?=
 =?us-ascii?Q?vnglhzmRocYSFYq3q8DansdwsIC9opePQk5EonPMI/PtPM1Aw4lngTr/El55?=
 =?us-ascii?Q?4P1TZ5NkMOfonRlmY3ZLjRE+TG5QWe+eoMg2uTArWM10wyPz+ySafINdHMYE?=
 =?us-ascii?Q?+KQS9V1uuhCbTTDfOzPit3TwdFkvPNZRRKJ/JHxDa5ZClfdmHLaYIVJ4gc9T?=
 =?us-ascii?Q?JmdoQ7lgcbXK1vdlooTIIFkcOuXu2jsMgA0FcDGzjEv7gq5qD1Uq8dUbv7GZ?=
 =?us-ascii?Q?VUBkHNsEBJK69wEapWzzzgZJhoWfHcGTGRhC+4XHLTfiSZ7frnUJOsdQGrMP?=
 =?us-ascii?Q?3BSjGjEI4L2zEqVh9vVGNysd3pn/xeHEBfU9cVpSH1fIh84YsbLP2nPiDcaz?=
 =?us-ascii?Q?U5tVuK6ioqlgAGF33i5x6KAryne95RtYKSrwwl5ukVZgOv9hEONYUFT66rFc?=
 =?us-ascii?Q?kvsm1JLATA5CWMcT5GZqq20EjvXPKG8u2BT8okpzb5yXxq12RxLy/nTqatD/?=
 =?us-ascii?Q?4kXVbNbwFxUBYpRv89pD/9Ph2Efth+jGb13JCjqtuM8RpnRGN6L4UlvzU/9g?=
 =?us-ascii?Q?KcV4xB7m1KHBZ2lYHEqFJhP1qHyRI/kee9GO2LVrKNUQa6Qq+u4bAutEBFMT?=
 =?us-ascii?Q?2y3Xv5tik+dJn5ilgvtDWj3OYW271p3/FFIAHfrV+WvEV8kk418uAkxdPqum?=
 =?us-ascii?Q?HqhSE9OsYO+cEbzAJ/JHGcFvx//lJ0T91AYDbbBhhxvPfhpL1GHi8ODk3T9R?=
 =?us-ascii?Q?+Xr6ip/XlI8TREROUlBGMerqG6AeBrFWpU0u83k+/eJmOkvSG+0k9QnrB1T0?=
 =?us-ascii?Q?GA6hFwOEUbZeLNeaLJMMdjekVz5epY2ASVWTZ95L94uctmNticomxitFBNZq?=
 =?us-ascii?Q?eTIpV6VCVh7vMAVr2bO//Ut8G9+19Gt4codZkPckGM0W4nEpbzvhRm46Y3Nn?=
 =?us-ascii?Q?/jKo8U9/qF3Qi7z2IyCi7ZUDps+xqbay6PxGllh3Y8ictazC0OXHp4vJtmsx?=
 =?us-ascii?Q?n63L4MmLTJXDLSaJdzded3rrhMS7wrIdVECTMrzlLvWdPMauzwxbbe35tk4i?=
 =?us-ascii?Q?X3AtHMB4kctAMMnrTVwYod3BucNgrmXRdiFDCOZpeVc70vYrj6mc+9/wfZpx?=
 =?us-ascii?Q?W+MZ2Pm9AvYaw4izA9hcr+TX/A69FEy9vX87tutmZKLHDmAgyWAjI9AazEdJ?=
 =?us-ascii?Q?5s/Vx7xIUM2Ep/IymYIorKvROPVrBJHJqotKTPJA9z/33He5Wb9kE02A/2Ab?=
 =?us-ascii?Q?SJiB8S/62U+u60nfnZvawu3EiZVRCmBtCDvbMPOGZ36zCYuO+M+FPxzm4+JQ?=
 =?us-ascii?Q?3winPKA7INm0atCAbsX03TKXOHrskZvxYFwUOQg3DlN3vV99ylgCKKAe+hU6?=
 =?us-ascii?Q?tKUL5fdYuTqvip2pbI7JpuPAmBftps5jppUQxeUbWdlKFXQm6aTd+G29VisP?=
 =?us-ascii?Q?kuWHc4eidrtlcqfb/s/PIcNGpo/JfOnjAj7H/4hPYjZ3D0Lpw9floZsMxpOZ?=
 =?us-ascii?Q?SeevnXnjIkqYYjNlx0Wne1fru9M8vLJv54kTy99fsq1L4+dw0nY0zYB6a4pQ?=
 =?us-ascii?Q?tazZsT5zZ4KlZ4xBhu1zv51dNLuzcNNwOJzB1UP3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j/r/EXjUhmQrxUTFcms1BghUOFBg2j2lpYNhS1owi4uflRwloyc9R1m7TlO86yFBzdN1iOnzH8lK1YDktPpAadRSGQRFR5Cwk/ha36mfasPV2bgKJltsXewUzstVJI7RtvxYywiJ+vWmDjQFlyHAjaseMSlB0s10ZBpF2cgH4d/LeiZXoDKeben6t2MjlcENu9vp9e07TLQ1CQSePKTFnD+68U5Rvz8a5+rX4IS0qnh3NAOZVhjIExwwKWjrKxGhGvJEmwhMjyTOoJfv+2WDfe2FsIUen0D7Shnp1e3SFFqGOr8mrIo0Fxh0eB4UU5VLyA34Wlr+0TWu6mrkIsMmXxVa08Bt+0akUsj3D+Kv0KVRVOh2r8V5LGLe2pS0Z2iD+/wyBYPnusYUswg3DelYN3+n0D5azpbPy/skZy+1qWjtpfdwbwNdlAA7HD1YrdVFIrzDeUyKpUIWi5JLZWhYzRgcmxZbA9uPLzGlHmpjJv5KkPS0SC+ylD/W+bK3Yf6tsLwyA8r0E6q4Z8GuWxJBfbHUZIC4F5FoeKQatycxFtCLPbWGmCIn+44oHh8puSqxGtskfOaaiMVlsNB9GTDRpQhmNCOS4FeNgEmdvhnrmVFf6krgMryAbkb7TATqggRu
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e9823-5a0b-4814-b26f-08dce1d768bd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:10:47.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7zeFD7d34Nx7nNmO/ba3EusTUTnlDU1VmF2katq8mr6IH+zMrRTe6+DPlku6pAt759WC7UId6Xdt0KFGCeGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
X-MDID: 1727759449-WF9eeZ3av4kB
X-MDID-O:
 eu1;fra;1727759449;WF9eeZ3av4kB;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   3 +
 include/net/neighbour.h                       |  10 +-
 include/net/neighbour_tables.h                |  13 +++
 net/core/neighbour.c                          | 100 +++++++++++++-----
 5 files changed, 94 insertions(+), 33 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a..510c407d7268 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,3 +183,4 @@ struct_devlink_port*                devlink_port
 struct_dpll_pin*                    dpll_pin                                                        
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
+struct hlist_head                   neighbours[3]
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e488325..7b24a792280c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2399,6 +2400,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 77a4aa53aecb..580c2d00e4d5 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node __rcu list;
+	struct hlist_node __rcu dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,14 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..ad98b49d58db
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_DN_TABLE = 2,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5b48ed1fdcf0..f3a9a220b343 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -62,6 +62,20 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static int family_to_neightbl_index(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return NEIGH_ARP_TABLE;
+	case AF_INET6:
+		return NEIGH_ND_TABLE;
+	case AF_DECnet:
+		return NEIGH_DN_TABLE;
+	default:
+		return -1;
+	}
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -213,6 +227,7 @@ static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->list);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -355,12 +370,63 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	}
 }
 
+static void _neigh_flush_free_neigh(struct neighbour *n)
+{
+	hlist_del_rcu(&n->list);
+	hlist_del_rcu(&n->dev_list);
+	write_lock(&n->lock);
+	neigh_del_timer(n);
+	neigh_mark_dead(n);
+	if (refcount_read(&n->refcnt) != 1) {
+		/* The most unpleasant situation.
+		 * We must destroy neighbour entry,
+		 * but someone still uses it.
+		 *
+		 * The destroy will be delayed until
+		 * the last user releases us, but
+		 * we must kill timers etc. and move
+		 * it to safe state.
+		 */
+		__skb_queue_purge(&n->arp_queue);
+		n->arp_queue_len_bytes = 0;
+		WRITE_ONCE(n->output, neigh_blackhole);
+		if (n->nud_state & NUD_VALID)
+			n->nud_state = NUD_NOARP;
+		else
+			n->nud_state = NUD_NONE;
+		neigh_dbg(2, "neigh %p is stray\n", n);
+	}
+	write_unlock(&n->lock);
+	neigh_cleanup_and_release(n);
+}
+
+static void neigh_flush_dev_fast(struct neigh_table *tbl, struct hlist_node __rcu *next,
+				 bool skip_perm)
+{
+	struct neighbour *n;
+
+	while (next) {
+		n = container_of(next, struct neighbour, dev_list);
+		next = hlist_next_rcu(next);
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
+
+		_neigh_flush_free_neigh(n);
+	}
+}
+
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
 	int i;
 	struct neigh_hash_table *nht;
 
+	i = family_to_neightbl_index(tbl->family);
+	if (i != -1) {
+		neigh_flush_dev_fast(tbl, hlist_first_rcu(&dev->neighbours[i]), skip_perm);
+		return;
+	}
+
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
@@ -379,31 +445,8 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
-			hlist_del_rcu(&n->list);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+
+			_neigh_flush_free_neigh(n);
 		}
 	}
 }
@@ -686,6 +729,11 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
+
+	error = family_to_neightbl_index(tbl->family);
+	if (error != -1)
+		hlist_add_head_rcu(&n->dev_list, &dev->neighbours[error]);
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -969,6 +1017,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3092,6 +3141,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			} else
 				np = (struct neighbour __rcu **)&n->list.next;
-- 
2.46.0



Return-Path: <netdev+bounces-132467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F73991CC6
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70081F21DEC
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5466166F34;
	Sun,  6 Oct 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="m94177Zz"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3A166F3A
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197307; cv=fail; b=i/TZi9n0vjMKrLrAKimvYF+yCydOoxu1tOd+/KXupDQvHEKob6zMu1bhA8TG+kX2SX3amNG+ko+eY8nVvcvnLCjC6+GDSSL0gQ6zenPYjLAVWy+e9QhnaLHYKwKAmLiTcwhBKL1v4JHFoNiVYIn9axfj1Jv5A1wgAiucEkfnTcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197307; c=relaxed/simple;
	bh=6zrPdnJSaOB18zh1gWu3etTXSvAJWWbhmr7A8vagfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jm1xyOD/IatpsFFjwE4a5qNEnH5BoBcgsUUituYg5Cq6MvwwhHn8rFMYpvcFIJXNsjI7M6IIsCwcwIEgfNxOdjlPy1hmDsTDP+7qN6uYAft0gB84rmlzqUnDlN0xh8Qen5bKixoI5/AURTtCF47PHxMjgD23vWSy9VxHeePhvmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=m94177Zz; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C350F740051;
	Sun,  6 Oct 2024 06:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kgf3zPcnH1fh1sD2MjNz3mRa523ZZhxENJhmpNiHYZ9MAhh8aoRFbtKp7n/bRj/9IgCaZZRl86CePt7DfzDKebZ+c8MuTn2WWWTGTXqps8JVIaU8iH8oX+pEyik8xyCLyx8L/wGu3pI+hGWTHn9SUfst779xxTBB6ZyOlMrPnvoMk/yOuyrp0c41vMOa5uEw6WSLEDCu5a3xoBtUvTtmLEsTz/UFHVN6EttsGdpNS2JJ/ePyF3S+Gpz9xIee3dps1fp0LeYcD2MIDQ/TJGDDDHYgSWRTc7h8o1wp/7nFH1GQAvdeg1Kq0n9146E/zuoNm9ufi+Ay/VdxyQXaAbgxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9sm9WQ47iK0f5AGUcxm+4XDJfTzdsSG7fioEiSKrBU=;
 b=LLDdIXHPX0BOMCJ82CqEonIWi4kkYYCH9IQlNE2cWZBwHF8xagpGIcCPanQvF+GHOCt566Jx92HMstt8q4oTxVGar4abpcfJ4IN45opg8yUltcX/wsrVyTOy3XKDiD6w33Sf/egMriLu/GRPkLuQSMj5oLeAx3Fg1RbErpDIyY/1pVQ9+tdwq2Fj2eVfs0/qZV/4aLUGYf06H63od3CQFHlNL1dcp2ogAE4JFO6f1nw2wktQ+Ip8WwMMxHBaj+OFfvYduuTg/sZU+xmiIWAlSgWWdZXaWnTsgy/j79piB3VAAZ7S0t0AhNvDmoz1n+jynw/oKi84kcyP/ginZCl2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9sm9WQ47iK0f5AGUcxm+4XDJfTzdsSG7fioEiSKrBU=;
 b=m94177ZzLQM72ymxVHDC7HTOhuE262JJn9Ph8jBgDI4oofbXo158KQ2QjTkwbwPA9XK2q9Qbeh6n07uGReNdqC11oYZom7rDDyjv+8v7PIwPzdSnAOrTZKSko/sFi++IMXMx7QfZnoY6QGebHBaulscm5OmjRHQHwrnE3C0xoic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB6324.eurprd08.prod.outlook.com (2603:10a6:20b:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 06:48:15 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 06:48:15 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Date: Sun,  6 Oct 2024 06:47:42 +0000
Message-ID: <20241006064747.201773-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006064747.201773-1-gnaaman@drivenets.com>
References: <20241006064747.201773-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdb6785-4a8d-4e3b-a81d-08dce5d2dab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARKR8seuFpInFTbOjAGUMDl1TjLYacpk68SAdMBmHMlI9TrT8J92FD4aUjTa?=
 =?us-ascii?Q?dqhiQWQYX590luyg7NfhYtmzSz6Su+iIpIc+anR5P9Eu+6PrTnAkEsC36G5s?=
 =?us-ascii?Q?qO2APVYP3olFSTVnVuRS5aoJWWdajabKAsFM9o4sATHLmGZ3z31mfQy614VX?=
 =?us-ascii?Q?ak0EIaEexjeXqxtkT5aIokh8IR/AvZRaNa0yAAoFV+XsCi7E1CUbhwOaCUwW?=
 =?us-ascii?Q?+ap4ENDxrIgW0XJabuvTMaz9OVKhprooaajdDYF0cvoA6P9ZpLsstNZu+FrE?=
 =?us-ascii?Q?nY75vq1yK1DowxDy95ETCDTKb7YJ3aBUZS3N+u2mTg/neP8g09KULzRRPVnt?=
 =?us-ascii?Q?jb12hMGiAvH4HzA5QomS0RP/8v8g5fqRG6fEjZzx8UqGpDWlTOoqTvlrRogC?=
 =?us-ascii?Q?pYZlJxumOquIzQPL6s61yNFb+NefvloFh4FBi8tFA10RplAkBp+zuWA0hDcA?=
 =?us-ascii?Q?L2otE+IG3pClyAA0M5bQ/1yFxssWF7FGEmP4g5euNhsUCMg8huo4FstSkTyP?=
 =?us-ascii?Q?qr2D2G/icuayyf7vyDb4k7ezPZDAs5JfTPDkRj8Oq9toRxivTUPJdjIJ+I/3?=
 =?us-ascii?Q?N8NEuPcZJnFfcMrolekCaEH2HVe0XZVApR6QrigFEd2dXTJun916oVZWIbSb?=
 =?us-ascii?Q?V9nhiKR07AKBPDQtdhdJXDfaTGdg9J+i5BQkoQ/NjmhWd74MSilO2h+STp0J?=
 =?us-ascii?Q?8SDYm8AN3OO/kgRs3nKzfL2L3FlIG4h9XtQLcIu0OeKlwGjie6m6T8wv2xbu?=
 =?us-ascii?Q?75m20VOZGgnLZ9ITxTksJGq2j3pbuE+myoP+ryAmEUdyVkgma3jrIm65bcHp?=
 =?us-ascii?Q?+wEgRCeYwXfdBCHdlJoO65dt8NHsFi8lZ+fHYRGxDmVfJB1nrkEob6t9Zb/A?=
 =?us-ascii?Q?0jdw8epsTnElTODVMqKKQ6B7L7F6BxBGNMYPjAik6qVFMTViewlxzvyB83A+?=
 =?us-ascii?Q?rBQ7SsWu0BdbEKWTijZdKAwqZJw+WYAMbsVNQ2E+CTDDGKyeDzi7gpzjLKVT?=
 =?us-ascii?Q?kUTzLAkCr56RWlEerOGswazHIXF9YIcLr4l6Mh8J2jXb4fP80SEEFd9C3xHQ?=
 =?us-ascii?Q?0IXmYj+Tk/eMeQwMkMNEg+YBjrMwa4lEx+fPSVDFHNH5Vf+IiO4aUupfIDJO?=
 =?us-ascii?Q?b2T0mMPV93z4qahvuSCLWzullGSun6U6k+qRaqaQbO7Ia3XcNhCM2ZGtpCNU?=
 =?us-ascii?Q?JuAGS7MfXHtgs1UZWJ4iJQXzytV15zpx8lT1VHefKavVYmp99sPpWV+dvvpt?=
 =?us-ascii?Q?rLqC+sZQQ9yk2OlSxJJ8Mn0mjH/wAmNraLciiCYphC99/8I+fuB/dFBVblst?=
 =?us-ascii?Q?6xY+x7DnHolZWApt8uB49YR3CxWQUhuRJxdtl0pyX1RxFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M12+km5ezOG+0AGx/27u6VWL5+qmlgLbPmIEI+RNm3Wa77Igkbc4bi5/B7LE?=
 =?us-ascii?Q?agri4Mkg7ueAU+Eb2qbY+TembraOyTUKoV3yKrUxSPoStWEBG7VelObaqoDo?=
 =?us-ascii?Q?w9r4bVeJDIdorjpXz/rQDE5/jwg94P7rOtGmBocX1Kqy1tFWhOzvSCHQNzM9?=
 =?us-ascii?Q?c3NNtFiLDTiwocGvHV7lO7/1pECFwOOK+2CnefPDVrGJKV9hezAE9u7VVLRW?=
 =?us-ascii?Q?HG5TLYO8OyMZTPGKbX+VS5/lzgugCY4NPQkEsol+NJRoEKy0JJ8l16AHLmzE?=
 =?us-ascii?Q?jAl7489KiW6nsEYAZGO/a0XMA6JyfnPRUO0qvyXcRT+NrJfy+/PbfvWuwEC7?=
 =?us-ascii?Q?XS9iLhRmL3J818PGlhnwVpnL812j6cDzmj0gBVh+GyHqVYKvnCV+FHLw/aDZ?=
 =?us-ascii?Q?mt9WjGlqsZozm/+MpuTrt6MRfKr47mzd6b3jpuMlbSNGy6yrmqniIjJaCSQ/?=
 =?us-ascii?Q?Cpyu3VePurG3ddcBO2L/a8lDvirRwxSeEdibweYe7crQctkQDYgg4dIEo8B+?=
 =?us-ascii?Q?vcIfDw/wJM6khyCYsYEq4EbN4bHDGEGrM0OjgeIaq8+NYfX3K/+eXx7FMVoJ?=
 =?us-ascii?Q?96+R1a7bqcSZnAckqGj+golSl7myNMt1rBXEHgvoXucujEd9dqx0IQVWV0Dt?=
 =?us-ascii?Q?nYlWfaDBZ6rBLCRdKa1LUOWvpSZwpEAdeSg43DevRw4ryrvdOG/qtccLUyDG?=
 =?us-ascii?Q?G0HMpIBuWTPgDdmSWrPJxkXpzVx99tumDMoymJXrHgxMJ7C5I+ay+qPr1pHB?=
 =?us-ascii?Q?NgrGj/Bja0BzGrWAPcy7hEK1ojypWrDX69z/QTXCWuhVlWFw5tBwZTXfNE1j?=
 =?us-ascii?Q?oadSU7CBN6aLFqChNwAJ5ii/GhgFpf0bkb3DyKFmFCLpjA0bbImKc80q5G7x?=
 =?us-ascii?Q?gUs7RcUSdF/8H7Cwedf91Vlp5ixEpODf3LhfOf8JhvlmQ1ApIMYeKiYLYKU2?=
 =?us-ascii?Q?LFEwXc5MqQN1P2fpdoUrzkPZAQcFWdJ9qm3BSW6/TuYXejOFp/Qf/jx75fKB?=
 =?us-ascii?Q?/YCPUjIZr0Vk3388wxw0SAIZt42PgNKU384H1BTFVLowyaAFZz8VTyvVimoi?=
 =?us-ascii?Q?cUOcL29Yz6Ni5BNLE6UvsR0dKcYFCmwkEpOvAIqb42M3y3b5bVOCwJn7+LMS?=
 =?us-ascii?Q?Yel4cz9fb5UZLzQwPXFloMlHr34YVc6N/XgFwPNaafc+5ZpToh0LKZBffgqe?=
 =?us-ascii?Q?OzRpVFo/J8yyuMCA11kj48PRof2D+Bchd8DvbJJL1//7RrDWFJ0h3VJCkBHR?=
 =?us-ascii?Q?4fGUm9t847s1Ko+H7S2pqHBWWasIJPoWfuFOo1GsDrVVdsffQcZHpNsBNT1P?=
 =?us-ascii?Q?IY8EonaS/s/4Zd/qqgzC5dxwA1bPOh/GN2D5CjnHSToZjV0/prgqMWu9zIEG?=
 =?us-ascii?Q?9G0dGfYLR0WiuKZECkk7kADXTG9xUqCLnh46YSvFLSLDqom3CJxZJu+EXIMv?=
 =?us-ascii?Q?UIrkLUjYHjL6ZXbcBuTrK3SpMMjG86hDcZ4sY/pxDmJO055MyyGLbTYMpFI9?=
 =?us-ascii?Q?IIbhDDibKQ4fGPuGdhZpYksXPSnzlIkmZJIcK/QGuIsxsBjNwyWdwglYUbz4?=
 =?us-ascii?Q?RhY6PMG5M3hDQcFyYcqc+BJ++Elksj7RMMNAtqqRIPQqrVOWA/G6QQpKEceU?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AnYxlGtb1CXy4u89/DV8xbbBwhJun70th9ldiNpY+qml37Gn0DCtrrtV0sqLjs9RMVVw2G3Mda6G8g1aPZ+l1Q+wBqmi5dkckuQZt4fMXc9KCbMY6flZd4Bki1dnolB369WOMufUP32rFKLDh5gTUXbrSIkoNIfFzBtqDQ1E1n+TwGUewzA0GTdjYEzP4m2C957EH2D1bcEYBOnHvO90x32SOlgodwfhUA5yfO5UVdoJPm54CZQ8MbXpwlMODP6NJRXdp4UHZCiwY0elzWQgplevkV1sW4vBFrWWuEMI3wa/uKqMTvModw82E0CUiavHfjKDp3X/OJwnPfnPAr2taki1+bRiss6VF4hF/oTTHS63OP/vX03Rva4FlF0nP4TEP0lHFa7oEAQvp80JW07QQrPjJH6i32CpuTtd4AwUOPGPPu+ypwsjPSo/n3XAu+dvu1ZEd+u9Li/XIvRQ7Skx+FZCZarfUxfiactA+jpKQP2g2J4TV7trP6vGyyjGSsdfU6gHYUcZoLK2RyGfrpXCMJZPS2/N6hTk63BVztMEXi4DuUQjUyz1Qki71P+CB3iILYPtYc8lSjbLVHvMF4fFxvZxr3tiVxmQBwnJdib+d9agNJystcWfrG0B7/8rLxjq
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdb6785-4a8d-4e3b-a81d-08dce5d2dab2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 06:48:15.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1gW5oA6RwssmzKkpoD1I0yVCesYnowXXblgmZU9ddQJFxxMBr4/Bq/msy5oYoatBejUrWcJjg+nyWJ1FCT1/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6324
X-MDID: 1728197297-Z8IKJYolTCJc
X-MDID-O:
 eu1;fra;1728197297;Z8IKJYolTCJc;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87
X-PPE-TRUSTED: V=1;DIR=OUT;

Use doubly-linked instead of singly-linked list when linking neighbours,
so that it is possible to remove neighbours without traversing the
entire table.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   8 +--
 net/core/neighbour.c    | 124 ++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 86 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..5dde118323e3 100644
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
@@ -304,9 +304,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
+	for (n = (struct neighbour *)rcu_dereference(hlist_first_rcu(&nht->hash_buckets[hash_val]));
 	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	     n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list))) {
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
 	}
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..86b174baae27 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/inetdevice.h>
+#include <linux/rculist.h>
 #include <net/addrconf.h>
 
 #include <trace/events/neigh.h>
@@ -205,18 +206,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
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
@@ -228,25 +224,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 
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
@@ -388,21 +366,20 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
 		struct neighbour *n;
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct neighbour __rcu **np =
+			(struct neighbour __rcu **)&nht->hash_buckets[i].first;
 
 		while ((n = rcu_dereference_protected(*np,
 					lockdep_is_held(&tbl->lock))) != NULL) {
 			if (dev && n->dev != dev) {
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
 			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->list);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,9 +507,9 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct neigh_hash_table *ret;
-	struct neighbour __rcu **buckets;
+	struct hlist_head *buckets;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
@@ -541,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		buckets = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
@@ -562,8 +539,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head *buckets = nht->hash_buckets;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -591,22 +568,18 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
 		struct neighbour *n, *next;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
+		for (n = (struct neighbour *)
+			rcu_dereference_protected(hlist_first_rcu(&old_nht->hash_buckets[i]),
+						  lockdep_is_held(&tbl->lock));
 		     n != NULL;
 		     n = next) {
 			hash = tbl->hash(n->primary_key, n->dev,
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
+			next = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));
+			hlist_del_rcu(&n->list);
+			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
 		}
 	}
 
@@ -693,11 +666,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	hlist_for_each_entry_rcu(n1,
+				 &nht->hash_buckets[hash_val],
+				 list,
+				 lockdep_is_held(&tbl->lock)) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -713,10 +685,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
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
@@ -976,7 +945,7 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
+		np = (struct neighbour __rcu **)&nht->hash_buckets[i].first;
 
 		while ((n = rcu_dereference_protected(*np,
 				lockdep_is_held(&tbl->lock))) != NULL) {
@@ -999,9 +968,7 @@ static void neigh_periodic_work(struct work_struct *work)
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
@@ -1010,7 +977,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			write_unlock(&n->lock);
 
 next_elt:
-			np = &n->next;
+			np = (struct neighbour __rcu **)&n->list.next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -2728,9 +2695,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[h], list) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3097,9 +3062,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[chain], list)
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3120,7 +3083,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 		struct neighbour *n;
 		struct neighbour __rcu **np;
 
-		np = &nht->hash_buckets[chain];
+		np = (struct neighbour __rcu **)&nht->hash_buckets[chain].first;
 		while ((n = rcu_dereference_protected(*np,
 					lockdep_is_held(&tbl->lock))) != NULL) {
 			int release;
@@ -3128,12 +3091,10 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->list);
 				neigh_mark_dead(n);
 			} else
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
@@ -3200,25 +3161,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[bucket], list) {
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
@@ -3242,7 +3199,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
+
+	n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));
 
 	while (1) {
 		while (n) {
@@ -3260,7 +3218,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
 next:
-			n = rcu_dereference(n->next);
+
+			n = (struct neighbour *)rcu_dereference(hlist_next_rcu(&n->list));
 		}
 
 		if (n)
@@ -3269,7 +3228,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (++state->bucket >= (1 << nht->hash_shift))
 			break;
 
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
+		n = (struct neighbour *)
+		    rcu_dereference(hlist_first_rcu(&nht->hash_buckets[state->bucket]));
 	}
 
 	if (n && pos)
-- 
2.46.0



Return-Path: <netdev+bounces-137877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605C9AA435
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22175284187
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3319F110;
	Tue, 22 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="WOcNLexU"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000B19E97C
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604651; cv=fail; b=Tp/1DbfH7wq/OWFIv8+yI8o6oEhnN781LGo6WO/9gWodx4+gZER2Qy/MPQy2NP0cwZD+qqt7RJeNJu9lx9L4ebJxG5egVcfkj+p2ZhOpl1xMQbOkQJxiPgCunzqeOu5tT8hacDeb/gUaYSye0T1vv30kcOwm7c1X7Vtobr81Nio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604651; c=relaxed/simple;
	bh=Vej1c6mEEm1DDopDmadYwsUKNEaKer1nKBW/GZq7igo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPssV2LJoNJe092ujme4f4FqTADg0g2BuWw1f3R9YafLSb1y+Tg13OZ734C8KQ+zs0UjNg0airrl6bVszYMtCUKUz7zCBJ6kxpky+9HCNZWXo38LY4nYQflf/Q9Gab5tcD9W0XzMVJ2VhKfngbIrNHmGsWRcdBfyHlR0u4BYMMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=WOcNLexU; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2813C480063;
	Tue, 22 Oct 2024 13:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ8Bg2eHk/MHX27fMLr/CGX2cbqySiuV671GoPGWIbGG31DHG59Rw6xBH+5wl6v1tpKYNd8qQXdqtN0DSc1d+ddBh5tt4+agHOi8YmuU38jSY7MyNOWTXl78VPUDyfKpUpXjxzECYONb3moHD2EjpLCcI/R7w+E5jAPw+wcmu7AnbRtxhLj4jGQgJbq7HD6XhvBU7cOlnSyQ8b+flu07ciZYOBG8fBHnyEQ3qk6sFWseQ83mnFhNVavhZw0LEp8peSRhC0BkkL9GPFK/52jf7uA2pD0llIakAl92a3FpOsguH5qtU3vEo2NnJZKBKCpTHMAo08ymtiIv0GheQohfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EdaahXXGmmv6NwV3IYLc1ucddY5sEKmvznadCTwOXA=;
 b=T+tGdOiusz1X8w98oUv9chJCZq5lf6PeDSZK+q/5Fn5yqURjMSg5ASYYQ1owZZr3MkatiBTVf3wTU2Gku9DBGCkO/zRG95JaW1PzeTY9+Qz7EVCHavDvoEak7ZhsYr+7DTfW6z2xqIYqKyiatg7849qCK6eP4IZjLIDYZydt8vn01sWJFi2DT/QjDipUE7kua5Pe2tSQsoH1WR52rIs9XU2jIFqUsHBX0kKF5riJaMteE6CwaLsLXHEbO93x8ZmubrfklpLslso3wGdRVC+9J1XJOROCJ3frzleagGGupA2VFTCXRIbs7PthD9mDw4WIU3iAFlZ0/lr7fUzmiShRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EdaahXXGmmv6NwV3IYLc1ucddY5sEKmvznadCTwOXA=;
 b=WOcNLexUFY+i/BUDOe977xZqI0hjqsRdW3i/RxLkXRl5N1gDPW8icofAiG4VTsBh4XQfAtCofZr4FU7AE5AJG+8hvwA1NjhtM18g7M66e7PtbCdpeIhgkjDEVvP+wxoLxrW7j1faA6+rMKiQHknGXFrL3uvYGNKpKHP+nShCnk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV2PR08MB9928.eurprd08.prod.outlook.com (2603:10a6:150:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:57 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:57 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 5/6] neighbour: Remove bare neighbour::next pointer
Date: Tue, 22 Oct 2024 13:43:40 +0000
Message-ID: <20241022134343.3354111-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241022134343.3354111-1-gnaaman@drivenets.com>
References: <20241022134343.3354111-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV2PR08MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 235873a6-204c-4f1b-8af8-08dcf29f93ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvXXySIBlGrweHcLfWnM8BngnLJVXxltL6N0Noh4OYxuYBRaJ58P6UCV1Cnj?=
 =?us-ascii?Q?LB19TWUqXcZoawsXNURJIjnd5KImc6oBiPvZv+fWpC8pj3yl6ysNChMHAjwY?=
 =?us-ascii?Q?KzmhzzhZvtjRdW6P8yfiliYAN2QNg/wqv5F8G7or9fdImm8hMxZS1Uitoc/2?=
 =?us-ascii?Q?EP975rMQ8htvO6KbUXWymuJV089Bg442vavAa9kB56omIliKbW/pUeksycGc?=
 =?us-ascii?Q?wDIEqUXaNXXuLDuIiFsEvkpS8actGSodocAI0p6n+fVwDMimIrkyRT81Jlvo?=
 =?us-ascii?Q?yDVbbkyeeLUX2aFAWrCP8+TBGpv+acg4rIfIiBe/hwCOjBhhOuAVwa5ZQEgJ?=
 =?us-ascii?Q?w4pgeoQUZr28R30uhP5knRrlPPektyAOj4CuyBuSGYg2wSTdq9jaq4BtllBy?=
 =?us-ascii?Q?QjwSICNSEetS+V32JsOLix2JdnJU23eVsnELfzlo4q/yGBsOK1xYmhQTNo9A?=
 =?us-ascii?Q?PXcqW3oUEA9p3Tkt7raEodBDFclO+q4QmM0BPdf1ManfREYa7RmAmfy1Zzrw?=
 =?us-ascii?Q?qMY2hzBEfAHepoNNADt4u6mAaPVan9F1wntxR0e8+Oa66n6bvf5km0DkRvxg?=
 =?us-ascii?Q?heACWkQAI7+1Gs5WFl2huejjIpO7CwaEcNGC5WxuhiMQk3omxHLVIXn2N1G2?=
 =?us-ascii?Q?svB3pmqB2WLd0tnBCmC31YzWW/9K3lMcYtnt6ouShNHfu4Rt5TCFK4EXi9uw?=
 =?us-ascii?Q?PCbYZfBmQkpJ59qCwsN2zKlPrt0bZl3v3nN396mhBmGZlYR2GLhySzRB9bBA?=
 =?us-ascii?Q?0PNJDOIx9aRUOVwZ5AWz1QwQ+IGBVH6rXjuJT1V9gtgjopg9tC1uWOjZAh35?=
 =?us-ascii?Q?UmBIu72WbxJ4Jl2QLv+/Ek5MaVSC+1u1IAMMa+6H5cKVqZ3eBiaS3tQgvyUO?=
 =?us-ascii?Q?j5nUhEfYesxY9zgkzxCl1WVHkpgPlhWtudyrMvm9WWoYvw9dQEViqHA4+59F?=
 =?us-ascii?Q?awz8WxVGVwSMnBZciBnTnlLEDRcIXDI8PcQC0gHQYRuMII44IdtNSOPMrcyj?=
 =?us-ascii?Q?f99jnzPFmi3yXpGE1OiRPiCJ9IHKtIRq9cwA+dSdVoErDxb+jUy6yAJ26t+f?=
 =?us-ascii?Q?8fwTnfDuBn16dfqO2ZkIjALOPili0y60YNlzu+YGUABRjHvmMtJXVKENZiGo?=
 =?us-ascii?Q?9CGLv/aoRrsw2UrbRoXfYXL1am4Uxl//iyPBQx+bwUbNeIen+iCOVzFAXsVl?=
 =?us-ascii?Q?bbcGr3zKhxAeDtkQwVoqviADPGoSSR3mbLc1dzv1KOI1306tTVmcJtucbs9L?=
 =?us-ascii?Q?foXgEIvTMePecrltixN8HaQl3nSoaW49+yqbB9RBQYK4vb1UXKKPTHce8QVx?=
 =?us-ascii?Q?oopXXy2Hd+vcVATG0JQ85XvwKR7vUMM97b9lmWAjvkz5ovoBC/jVhm5poeQa?=
 =?us-ascii?Q?VKSJtPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFMRxi1DVH5/S5x8QlEYtmuQJ+erHA/ny9109xrDM7C8bS5Nu3/ywwsKUQYw?=
 =?us-ascii?Q?ZZDEdMwg99eqRcy432nU5hSF6eNIlXY4fQEBGmJZo9Ei+TmqOOzJg4+Qh3xo?=
 =?us-ascii?Q?VW6v4R96ZJw5Ij3Nkn6I3qxhSC5KQF2kn6Aire1CSPuVpuSKaXAHRwqE1aU4?=
 =?us-ascii?Q?UzVPfPBOy+YdEKFzVNxpKFc62NLbgFXdf6Jq2rPQtLJLx8mEpu13e8gq7oj+?=
 =?us-ascii?Q?koaIUnsGWibSHkDGKwdltQ0Krzk9zh0Sd6v2AZslf5BaO394QLB6PW7LZCzN?=
 =?us-ascii?Q?aVBzmKl9HGJnwESRc0HjnQkQLIYJlufCR29N5TdIowE0QQ/1a9J22SFkrT/g?=
 =?us-ascii?Q?EUKKJigW9lYBjIL6mI5yc2a8tTVl8fuT14zE22IGgcleFLeeINGt4tdaDZQb?=
 =?us-ascii?Q?4vOym/s73ZdIfgCjXCYRzhuIc2QnAn4GvYTx6tnaUe0lJWZeps5em1Jo+aCC?=
 =?us-ascii?Q?CXyLBXjhKy7ywBVEEoiHYcgh500lgbO+b9GH22GUOaIuU4KZFYtgRVhOzpaS?=
 =?us-ascii?Q?KlBexZsLjTZXDsV9Lal9wqlKIl7uNatzE7C/QKnReucOaYjtwQcpZG278Kj6?=
 =?us-ascii?Q?Sphl/pe0yOuIEQUA3LDJvnljtNmpJAECJ+aHhRVeQzALDo/BY3OXHS74Gqyz?=
 =?us-ascii?Q?gnROFXwOcDx8PvkkXa7ZG01QF+9itqrPKcIBnV5ppEmpxKNeLeLTe1XJTN9i?=
 =?us-ascii?Q?+R2kTa7CkLJQNYLzZsmo0s4NdGPkwIX8snDzpE1YQeLy0NsrZalFb+vAaUl3?=
 =?us-ascii?Q?yr9DmehbDpC5OZNPS87pSLYw6VjRFI986JGmtOtE8BCoEbB39DEIEIRMhTCU?=
 =?us-ascii?Q?Y8RBiB77UGaywbbbGjpAGRI6cjuEL32nSN3BGVQyKs7+LcGH2S2rGGmmfBjI?=
 =?us-ascii?Q?MatdWx7cpGe/uHBF6os9uieoQCFAyoa5/664Diph3VOQXcbSv/b1KXx1XWk/?=
 =?us-ascii?Q?SF6RoeRnCp+/BEftVKqTuY7Gd7EhGVvGH1A41NhYv5ADFrMBEPFszyK4x6jc?=
 =?us-ascii?Q?qByp4JX0mnwg9n2al4C+r2N3f5zBiQ+v0MKZVNnJ9BMdLLzc3ofwdAg0rz3h?=
 =?us-ascii?Q?vCyZHNBlah1OoWT1wC+gbiIATfx/NrY7nxhlBTlRhlEt21XFfbs1fdzG+MpR?=
 =?us-ascii?Q?jnAsmyndM+xYdBM90s5hHyP3J+y6+aFSScFG+DkPRWduPKYyyyD+zOpMHCth?=
 =?us-ascii?Q?DYNgDMk2/mrIuK2zd8UkCAQxvvG9ulB1rdFafwn/R2omCZ3i1fNd/OHzIDw4?=
 =?us-ascii?Q?0RZpvaWlKqBykbhagJIaM824wOBpmE7+n1hYeVNCvLZAP5FFyAhTqeep6de2?=
 =?us-ascii?Q?nGan59wR9E601upcuyZg5D3hmJD7v5jytaEvXKsiGitD8CHNaSGM302ZfDFn?=
 =?us-ascii?Q?Jb2G+f9PJaQJZgMGqP4ovR5cY6YKXU9FT1EcMwAmISHUsPZr2z55wvQcHKcH?=
 =?us-ascii?Q?y66WtC1GnErVgKxX1km85TwO969OuqNMuTyvzTsEHKLi/hGvxt0Q4YjKfMUW?=
 =?us-ascii?Q?4Ytxi/AjJDh8KhgdXQHxItCc7nANXGOKPOEn9B3MeoGo60se/e/H1pat6mfa?=
 =?us-ascii?Q?IR0MZxqaD9pUdWcUP5z0ig9QQlFpcv1cere/iqxZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WBNv9PrXIrUNm0Kn0CwLLdFYC+kNSgsptdHmDFQPhayuZjHWNOnxAb9ZwTjwEIB/zm+sy4z+oqEinVSqPC01NUxdVkTI4oZQuzSGJfvDoeC6n5CeeML/RCpjh9cCmUzHPmqZBAd9teWWxVlNah8Tsmut3wcLxxs66YWuEZWGmiO9N1J7lQqKox4w6OHV2blfY6DMOIr89OvyLSCTS9wYjd1WtkzShGALSmIWuDgDFVGWxca1xo6loaEFRVYvKqc49ye81pyK6n+up44+KHAit4Cidrmbo9DpNdObTiZWgFd9nOb3Yc8stJO9/lxTmb1od58JmPU9YDM4vSYq6wCpLbEZ5l2nlDpDt3Z/LueFLegMECCI8nJhljqRgb9SteM9FYygI1xqYaqr+BHliIm/fIk2dLe9rzoFnagK+wYBl2q01oOKpktdMPBFckNiS82AZ4+/p5d3Hb0PRWjfDREM4p54CJtU2xHl4ra3aGr3RUnznFI9nrgEJaKksfvwGU0qElsFj1KR3XwODuIeG+8aE4sMVAjTV6utlQmmjhGmXGBqOvlQ/xqeCEViUNE1iUjuLGVuV4H3KjyMobxgKedekkrc/fMNM/5PufUiPiKz5RboYsW/mw7xabtWR+fg9RgO
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235873a6-204c-4f1b-8af8-08dcf29f93ad
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:57.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MljDt71aN+yfWRlUXN5UqTZUAx64N/U9ZnrnWgvO1anqY4CB61eeCpT6i9/U4lCp7qWj8XsamAUCvNsH3aYUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9928
X-MDID: 1729604641-jd6bYiFu9LVS
X-MDID-O:
 eu1;ams;1729604641;jd6bYiFu9LVS;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   4 +-
 net/core/neighbour.c    | 120 ++++++----------------------------------
 net/ipv4/arp.c          |   2 +-
 3 files changed, 18 insertions(+), 108 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 68b1970d9045..0244fbd22a1f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
@@ -352,7 +350,7 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb,
 int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new, u32 flags,
 		 u32 nlmsg_pid);
 void __neigh_set_probe_once(struct neighbour *neigh);
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl);
+bool neigh_remove_one(struct neighbour *ndel);
 void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev);
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e2f7699693f0..02bc1feab611 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -205,18 +205,12 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+bool neigh_remove_one(struct neighbour *n)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
 		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
@@ -227,29 +221,6 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 	return retval;
 }
 
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
-{
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
-}
-
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
@@ -277,7 +248,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				remove = true;
 			write_unlock(&n->lock);
 
-			if (remove && neigh_remove_one(n, tbl))
+			if (remove && neigh_remove_one(n))
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
@@ -388,22 +359,15 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -532,46 +496,26 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets;
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads;
 	struct neigh_hash_table *ret;
 	int i;
 
-	hash_heads = NULL;
-
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
-		buckets = kzalloc(size, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
-			if (!hash_heads)
-				kfree(buckets);
-		}
+		hash_heads = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		hash_heads = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
-		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = (struct hlist_head *)
-				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-						 get_order(hash_heads_size));
-			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
-			if (!hash_heads)
-				free_pages((unsigned long)buckets, get_order(size));
-		}
+		kmemleak_alloc(hash_heads, size, 1, GFP_ATOMIC);
 	}
-	if (!buckets || !hash_heads) {
+	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -584,23 +528,14 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads = nht->hash_heads;
 
-	if (size <= PAGE_SIZE) {
-		kfree(buckets);
-	} else {
-		kmemleak_free(buckets);
-		free_pages((unsigned long)buckets, get_order(size));
-	}
-
-	if (hash_heads_size < PAGE_SIZE) {
+	if (size < PAGE_SIZE) {
 		kfree(hash_heads);
 	} else {
 		kmemleak_free(hash_heads);
-		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+		free_pages((unsigned long)hash_heads, get_order(size));
 	}
 	kfree(nht);
 }
@@ -629,11 +564,6 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 			hash >>= (32 - new_nht->hash_shift);
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -738,10 +668,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -975,7 +901,6 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neigh_hash_table *nht;
-	struct neighbour __rcu **np;
 	struct hlist_node *tmp;
 	struct neighbour *n;
 	unsigned int i;
@@ -1003,7 +928,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
@@ -1014,7 +938,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -1025,9 +949,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1035,9 +956,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -1984,7 +1902,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     NETLINK_CB(skb).portid, extack);
 	write_lock_bh(&tbl->lock);
 	neigh_release(neigh);
-	neigh_remove_one(neigh, tbl);
+	neigh_remove_one(neigh);
 	write_unlock_bh(&tbl->lock);
 
 out:
@@ -3141,24 +3059,18 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour __rcu **np;
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..cb9a7ed8abd3 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1215,7 +1215,7 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 					   NEIGH_UPDATE_F_ADMIN, 0);
 		write_lock_bh(&tbl->lock);
 		neigh_release(neigh);
-		neigh_remove_one(neigh, tbl);
+		neigh_remove_one(neigh);
 		write_unlock_bh(&tbl->lock);
 	}
 
-- 
2.46.0



Return-Path: <netdev+bounces-143652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988489C37B9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31895281035
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A94D7F48C;
	Mon, 11 Nov 2024 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="Ruxlcsxg"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3064C74
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302511; cv=fail; b=cdV4miXoneO6Arw4OT8rZG3rijUYbLMQ9K8wGQ4s1WSH9EM3NIwupzRb042lSKEdnEKpjw6EEJGzEotSJWa4mm+/aAXkeMQya7mzS16qxmaJlMAN7ac6kGMPAKRRcpcf/WF0R2+5l1IVospr4jH4CrOej2D0JE0iDwd6n/LMVBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302511; c=relaxed/simple;
	bh=4s8X6IDfDItKDvF0lbUuJYWK8kMRSyjD9vfpuN75COY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VNr4c3Gsv1yQBH9yC81Gfl8ly/ZGv4SfZc2dwDvlJ0EmD7d4wBNsQSR5wJnQVTZsiMYnaMePZzWaOA1ehhBSqhjKkx5f+opcA7njjyGm8s3T8vS5nKHoSDduBz1CdMKzb1SEiKAe4F2kdOlJFuHdEXCDXVZCFAGVwy6tz8ZEDqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=Ruxlcsxg; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D1113C005B;
	Mon, 11 Nov 2024 05:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+R6R8qPFRoqc159dZsoFpQJriObmbMmhdO3kU6NhXyiikgFbp3hJpY7XodOP4FJzfikLBh1X9LNRmG8ZdYB/JxM7RWN8IRkJ4QrWcvD0yuBupYYMfKJ46NvZCiDCQoWLUZrUrUChmVPNHLgH1NjjMClyjXIw2JCqWEIOgR1hNA0VkAt14q5YnrxpwdMtJtqsXIVWNkQGlt+GnD33StE64ZJWggX3uOXsIQH0UpTEirzsdMHea9NF5dMk02VuCGMBO2qvJPDB24gpmj8025lBBvjVsd85kpfRto49bzicnE66d5kgqkDaNIB8g2IlKmNu4tn/4Tud6LrpZ+Qq9a75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJDd9Fgea1jgrQoqD6A7n+uSCXGowwQ0y/6Di/o4HZg=;
 b=iuIhnsYDQpEVKagdLAFA1l5pEtjz/svgJmj2ByEYquvSQL0IEM/NKS/uraEvYifoqXDhOpXTyIHZNt52h+v1QnRwaO4Pe/uzfG3aLCbqI26It9CsC/9PdI8AIE+yILZW1zedvF5lsLfno4j2IuuT3wx8JX/FzWPVANLD4D2kcHXWBsn9wHcaiBjncAumwSCcNf3106nOUXuBPqzXjAocoL8BB3GKt1F99kK4SSmjBzt8HPmVJrYJyV965jKxuq0VY7J/JAqYf6QasPms9ea1UkurbbZ1xxdA9wJUPeyAWgPatNFyb53LHzfKcsTx0M6iJKxVnHoQUtzUXevCSFHR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJDd9Fgea1jgrQoqD6A7n+uSCXGowwQ0y/6Di/o4HZg=;
 b=RuxlcsxgoH+RYvDUHgzMZdFyCroD1DD2um7m0ufqHJB9VnBpvV67efqf1uzN/xxaBQbQzuq+jcoo3Jfii6SKlPJ5W3WVJqab8IgUj8NIqMNr+uwuVI5HhV1RkwpinDezsk3mqVeWY9vyluuZf6rpXotKzq/HthKk7J7rot+sPGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DB3PR08MB10335.eurprd08.prod.outlook.com (2603:10a6:10:435::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 05:21:36 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 05:21:36 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: vadim.fedorenko@linux.dev
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
Date: Mon, 11 Nov 2024 05:21:24 +0000
Message-Id: <20241111052124.3030623-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
References: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DB3PR08MB10335:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ffea85-b4cd-408d-5bd1-08dd0210b673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LlAWlBeOeuUwHFGbGgBGoNwriOskrkzyJbmkC7K1VPfKpJ6qrEobCsG5Cm8z?=
 =?us-ascii?Q?qRzplbBWdNy4VMGUWGkEVSNK+oXDSph9QvxK2UeC/ShYObCDXXspOncFA7an?=
 =?us-ascii?Q?6rYIACsbGhibbn8rNbkNfRIHNejQosz06dPFQej3sJHafCt8Q+EBBsf1j0Yj?=
 =?us-ascii?Q?4+kieud02IQdA2EMmBdW/4n0CvA3hVbWRR+zu1gqLGw2DOVLCawSfW97LVv/?=
 =?us-ascii?Q?hRLWcDPobQ6W0cFS4atNC4Q8yt8+Xz0PkDp5vzAvlDd/HiMh/xFywlhKO4oN?=
 =?us-ascii?Q?rZuLZCpLMJcPuQqpR79TZzKS5BkF7advUUlq/Hm4SYpFk0lvRIpGo9IrdrMY?=
 =?us-ascii?Q?40UFbhZPPYAc3xcRWiyVwtlDCnnIsn7ovChlJhAypB7m4DMQ8kOruYRiT87j?=
 =?us-ascii?Q?DYXnYPh7dgOTjoCPaUdm7g3WQILnmeTFNeFLCPBUDYL7axwIw4Q8V2Zl4gg2?=
 =?us-ascii?Q?wY3QUCjavJ6x9L2hTkPTD3Mj5jltNtjqkDZJKzMhSbR2Qcxnksz5EpAgg72A?=
 =?us-ascii?Q?XFhRn4OQnjM6yv+SA+U50w47x5+XnAiSdY0B1cSAa0DvEieKYgE2ZCLECD+i?=
 =?us-ascii?Q?1KBcZysOkJ+P0BljJ+30RzTRMGGJOpnjyLNTHUretOLYxKONeyutjBkYRney?=
 =?us-ascii?Q?IHAHDstCb04t+n+QqutNtpmBFM6VwFKDAr8JvFVTjz7WsX6dYqKZgeSdknIX?=
 =?us-ascii?Q?MlibwYzImR949vazihuzqbacVNTDwavMYShKdb0KJoCNsISj6I3EgU9IN8s3?=
 =?us-ascii?Q?sQMIW0w8eeqSLvVacXXtMAGhYJvRL6vm4fOjBrPFQRG6+yQuxO1LtW1iazVz?=
 =?us-ascii?Q?6jb3FB1QvWQd+JsEhELPMjgFkbnB30wkH4L8R4bkoWiNWMtUh3GbuDiYi+Kz?=
 =?us-ascii?Q?Y1B/kZo+dQWxo1rVfowUGB/QtMAVsRyGfUIr6Wtb9sVb52VQpfpMTct2R8Gk?=
 =?us-ascii?Q?d8b8j+hrZ+RSF7a731P5SrnGNY8+W+xM3yNQYJrYXGhvYMQ/+dFG0gEoQrbN?=
 =?us-ascii?Q?yQXarK2J+XiX9ODQyY7R0nOmHrbFPW3lpcGDX6ifpGK1OOunxDU4izUCtsbS?=
 =?us-ascii?Q?MExM7mxa/CoHuwupfQ6pg0toCg/T5PrieGnCxMaG924Y3a7iOhTq7XP5YJ4Z?=
 =?us-ascii?Q?skHD7FvVsyykOEwepvDjLMwIYhH/IpFwtoryye/xsU0qEUheWliYZ8oDAmnZ?=
 =?us-ascii?Q?m0h4K2SfOF14VpEfAJxfDLYRr1xrI1npScAARovP8g4iumzPGzknKOJWICwa?=
 =?us-ascii?Q?nANymOteVrvh/yVYhMHptsP94GXY3382RKJ2Mo4l4N/+qFa9piwAMf0Zzoad?=
 =?us-ascii?Q?OdPUqVhs3+8GFXPhJPrAnGuHRkdw/03LE+RHjVPmy5twYw3zKbQXqDJSfM0q?=
 =?us-ascii?Q?oGzRDXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUSAWoThi9b+EHWRwePxJomJ8eh2LJCpEC9f6Q9vPATT5xSuMgfAEA0oEvVI?=
 =?us-ascii?Q?1D5wMHfUlIZ5huVXHKYm+0YaZBOmLTTV2qGhXk6K5E5u/O+GDGg8TLow1OdV?=
 =?us-ascii?Q?x6qsLhCH5ROy2lD7g7f/925nuhj8UW+eFFNlJU17U6U+poaNkGHYqBA4E5mV?=
 =?us-ascii?Q?6kERXjSplk2ATUfywWxR3Hy69OBCz2iZDYfgg8F6u937S+SdWqVzfje8hCSN?=
 =?us-ascii?Q?NinArr8r9AYSu/QmM0tOmuhTxKMWCwdfzZr4+H0QlrneJX3lEK840HPMLHXY?=
 =?us-ascii?Q?nHKNPIe+YvzwR/W2Psd5ig5PRVKlMjl/qaL6Ni930SZ202mLH8rZ6PWomdGj?=
 =?us-ascii?Q?YedwM63jwhtt8JGKg+qPr0gQrkF4wd/gKv1Nuf8dGASnt3JViykXgW4WpT5K?=
 =?us-ascii?Q?O2AQcJYi99FbXV/r4DJlqh6+ZAJg/JPNB/zf+vkIKr5GmDfszqhb9Yq2YgQp?=
 =?us-ascii?Q?yN8naJEDDrsaX80UHlzWB/aJ+SMz7MwCdiisnQoZJYs5c1Ei+ymmK5tOhRYB?=
 =?us-ascii?Q?TwtRvTOmCicO2JucRynjr0w0zGiRtbMEXIe5rKCW9l5o2nRwTmu07XJXRsbM?=
 =?us-ascii?Q?E4fGDoVfSDz8OuyKgwF/wEAFGnwdCf0Bh0MKyyzzodniyYMVpTrqYhUtq/sl?=
 =?us-ascii?Q?W6ueU0we+njFTFUX+qX5p7LMVdcHQzw7ky1GXDMPQIkGEB5B9Co0sqBhBDcX?=
 =?us-ascii?Q?ZWJ6koqenZ1seR7jzbciihNGJ20cUTtbwm4cEJJLlwR+fltQob7Q9msxNoQl?=
 =?us-ascii?Q?DSco3S4xDFymTrQj51tRM/DjqAMLpGbr0mqzeQRcdrMmQAFcN2l9N1QlGYuG?=
 =?us-ascii?Q?M/7J/wEyO+SGuZbzd0XesHYgbspEcaNtuRC1MbUKzmg/HiHQ9hfqOOySIeBB?=
 =?us-ascii?Q?Nof0X01VdpEe8J9HjCU5UkbS0wMWYOehlJVMv+5uJ+MTRcF9kqfZOzeM+JPf?=
 =?us-ascii?Q?iPpMGWEm40frx6kn1uUb+p0DdiZwgyW96WPz9UcqFBXoECslrWKxqizKn4+z?=
 =?us-ascii?Q?wlxXZ+1ZiYVyKLIyfJWwaudK+/2JjbKjnJ3xTuwhWjFFUhrlD7ZBGZZ4wvKO?=
 =?us-ascii?Q?zM6zz6b2PNgm9hpu+uNGNqYVbkUf2RoPnlC3o7SxdvPu0bSlhezgQQNGy7+5?=
 =?us-ascii?Q?Gh5XxkLUkYatCpxyFhnqSegA+EWi0GwU9E7ZYfX3O8KQwyKtgP4tdNhm8rbM?=
 =?us-ascii?Q?b35VVXROePZ6qgdhZzE1z8PGgU+Jdmf8wz5PUEcfTLECXT1h1ytDjZovvKNH?=
 =?us-ascii?Q?Idp+sv34cBEdeAMrQPCe6e3J2Ft1HluPVdtdzlNBHdXj29M3sJ9g+1kquAU9?=
 =?us-ascii?Q?lB8xRefm7mZtE94c5qDDqGLNT+lZ1O6eGY61nsQMdytSovpRd6Z0GcizyiCg?=
 =?us-ascii?Q?FD2sJMQtctHNabYuHsgO8dQffpe008Fa/g/L/tRekCbq+W+GqrDTee1fzyPI?=
 =?us-ascii?Q?2bP0Gefk5bJbZ2gfLph/ODKrH5DjpvIFeQBY7mUvl6Jbtc+w5NiWOT0uBZpk?=
 =?us-ascii?Q?vy1WBpmCRE08z3H99E7ewVLJVBrR4dKGqDRVM2JgYZNgKznRHPW3vcsUWwYa?=
 =?us-ascii?Q?uV0zINrDjxitm6KrIle06z5fMyEv1XdZb40fMT3O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+2qtRSXr3PWafyhHbnOiYUuDEIPf/WqdfzuQchM9UvzSgQOxw897j01z66DsQQHBy0qsoDulgKJ0ChYUvHHb/WBDMOrxobQhWVjxvOJwymi6Nh2LqupVBVCAHAyH9n7hX0M4euXhDs7sIClYCdXjqNjko3xKOp5aCd5h5C7y6+Qcup0qHmQ9A4DMV7c8dy/5bH90A5e/TLcLvHnQ+JqncUYWr53dAZI1Wr8bQhr3XujMwjgzk8/Zja9e5WC6acbzxTsz+3M63Lp4HgFGFvIGgGIsJp9gP8FRkFT5jJPvtaJe9rPc4+tJbcQxj7UtlzG0XcvUfnrvzM4C7pwCtTaF7ZRSnQ90VlAjmYBq6RY8X4HR1RpOuA3jrcuclhur+NHzLxn+pEYugm9mvwFyjVt0x4maXnwD0FY5odf2hpzorFMWwvB2yOnIpb9ixwdRtn0IhRiu1fIqV/JFL3KEPeLimeufmHzJKH6ZdHOHLmLtgHq6Xb3Xy6QJW2i0zKFDBcAhPrXp2P4DWaRaAXw8uIkyPR7MoMbo3xAP3Grq0VIPUkKIf7oV5D3+k6NPC+FC3DMScZi1Vg++17y+G99q5n9sYD5vv4SnFqnfcN59YSOS0HzkAPaFfqj3Uvwi8RktDxi5
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ffea85-b4cd-408d-5bd1-08dd0210b673
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 05:21:36.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44XQkhJYLTh/znogerrKcC/+F/Qmw2addANWEMeYrjENw8yGEZ4bMMUALsSMnLP6y7orjHRMeDsYyVK5AiZjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB10335
X-MDID: 1731302500-CGXfwXhsaaCd
X-MDID-O:
 eu1;fra;1731302500;CGXfwXhsaaCd;<gnaaman@drivenets.com>;152b7a609c5631ab3aa4b4b3056c19be
X-PPE-TRUSTED: V=1;DIR=OUT;

> On 10/11/2024 06:53, Gilad Naaman wrote:
> >>> -           spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
> >>> +   list_for_each_entry(ifa, &idev->addr_list, if_list) {
> >>> +           addrconf_del_dad_work(ifa);
> >>> +
> >>> +           /* combined flag + permanent flag decide if
> >>> +            * address is retained on a down event
> >>> +            */
> >>> +           if (!keep_addr ||
> >>> +               !(ifa->flags & IFA_F_PERMANENT) ||
> >>> +               addr_is_local(&ifa->addr))
> >>> +                   hlist_del_init_rcu(&ifa->addr_lst);
> >>>     }
> >>>
> >>> +   spin_unlock(&net->ipv6.addrconf_hash_lock);
> >>> +   read_unlock_bh(&idev->lock);
> >>
> >> Why is this read lock needed here? spinlock addrconf_hash_lock will
> >> block any RCU grace period to happen, so we can safely traverse
> >> idev->addr_list with list_for_each_entry_rcu()...
> >
> > Oh, sorry, I didn't realize the hash lock encompasses this one;
> > although it seems obvious in retrospect.
> >
> >>> +
> >>>     write_lock_bh(&idev->lock);
> >>
> >> if we are trying to protect idev->addr_list against addition, then we
> >> have to extend write_lock scope. Otherwise it may happen that another
> >> thread will grab write lock between read_unlock and write_lock.
> >>
> >> Am I missing something?
> >
> > I wanted to ensure that access to `idev->addr_list` is performed under lock,
> > the same way it is done immediately afterwards;
> > No particular reason not to extend the existing lock, I just didn't think
> > about it.
> >
> > For what it's worth, the original code didn't have this protection either,
> > since the another thread could have grabbed the lock between
> > `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
> > and the `write_lock`.
> >
> > Should I extend the write_lock upwards, or just leave it off?
> 
> Well, you are doing write manipulation with the list, which is protected
> by read-write lock. I would expect this lock to be held in write mode.
> And you have to protect hash map at the same time. So yes, write_lock
> and spin_lock altogether, I believe.
> 

Note that within the changed lines, the list itself is only iterated-on,
not manipulated.
The changes are to the `addr_lst` list, which is the hashtable, not the
list this lock protects.

I'll send v3 with the write-lock extended.
Thank you!


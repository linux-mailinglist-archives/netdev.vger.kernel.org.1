Return-Path: <netdev+bounces-137631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3329A8FF3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B735B2168B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0383C1CF5FF;
	Mon, 21 Oct 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="nKD5mezj"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BA1991AE
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539397; cv=fail; b=fUTynyyxYRKgiQMbkP08uAdt0X1+TYl3qyMkD2bJeRGkP5fm/Yv1LwYT6xuUL3ATJmSFVSYWPDrTg8JwrA9wRanPDNh40vykW14DlssBM7L6U6861IWp52aCJpb3un11WZ9wU2SGJBHubCoZh5hz4em5ueFVcpz12S/zkfXw5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539397; c=relaxed/simple;
	bh=t2a+t/QdG5rVhndRQ2m37tYjqg4NY+1xqmuUg9PTATw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkhBNW5GI3rz8IMFnXwDHogru+lRtWqi/SEJCb9gFjmgL03LgnCNqZVUg7zuGJBrKZbFmyM58Mh0ROv/EQWdlhpYCWNWrJ0pNp/La6JNeYUKN8dzBPWP32oU5MmfsPPhz0oEQgWaXa4cXJagYQs++N3NyAETfRTjnb0afxTb32c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=nKD5mezj; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 67CBAB0005C;
	Mon, 21 Oct 2024 19:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqRmdbmRN1gCik8oOXsgSm/TdyaDORes0HZ1kF1TT/i2Ex0VsjU7UJohkgfMZ4Iw5H2e/PeArD2SxDzeELcUmMeVF2wKJkjjAnNcVTfzCObnaN0cELhW1lkYIeSN6Bo3jDHUssk36J74KxHL8Iyzd6IlaJ+sK7yoPiKoGWv3KABsHOXST/GNcLvZovgYjV7wxQKjqgxuCXAtJ+yWl/2v227EO+F1oaHnu/CQ1in8MsKbCE7IjcDs8S6N9lDCJTaTKAOKCWh6f1jrk4V19SVukY5OTtSKB78jityT96ZCI3f08i3BT9pW2XcWBTTdIKG5bFKiJC0aapxl9MfgeL4qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEAwiV4JRR0VwmPFi9BoQkf3H1Z0nFRcLsOxq/oQGiI=;
 b=v8BrYVpGDisFkGhJDxUGFiMvBHd2RF+jaMD1WYKyX4VFFpU8lVXp2Ps/kVUupOlHKj5oiif/b+Q05v0xHEu5O/qkwkoqayYh9W8bNlW4rQNLTbhhswSUnfCVzl6SEjnwSAGuaO1vM0Nw4MvySQpO4l5uTHMKT35wo2EEkcgY9Z7GfEAWR4gL+AbaIJYLBhGCRHvYJOebZbKswPXOMTpb/zZzU9Iajp2NKlDX4s06aoGYxQjY5bt4xNxyOCOnrMtMFQwNIw/hUVNEaEwOjkxGzItL1wveAUmYrjr01uhA8M2LS5MS+RA8jaduEp0uyqTmTkms4gemXULiRi8TXZCmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEAwiV4JRR0VwmPFi9BoQkf3H1Z0nFRcLsOxq/oQGiI=;
 b=nKD5mezjpMNWoiLa9VdQBAZNPd946Q7ju2umpYOGoxtvApDWUCd3WO064XEbH2RMv5bgveTpPedlCEkV3TCHKM+l8qcn/Y4AfyjJwPuEk7D4JuAc/YKiDW48nfZTE1OMo5/zwejCGDi4mrDXuumVMivgTaDqXZbZeT7tElCPfyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:36:30 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 19:36:30 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v6 1/6] neighbour: Add hlist_node to struct neighbour
Date: Mon, 21 Oct 2024 19:36:22 +0000
Message-ID: <20241021193623.2830318-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021191100.84191-1-kuniyu@amazon.com>
References: <20241021191100.84191-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM9PR08MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: c822f8e2-9392-4016-d556-08dcf207a974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ExP5bCQbIM7hkEOJDXXfgtfKQhHaxcchTo2ILE6qLt9Fdm7VugdA5q4hvfG?=
 =?us-ascii?Q?AKpWiZFmHPWG2ZqiFmTNZJLihgyMqAWWPq4T0KSO8hCu6RYNjRzlzcHE84wT?=
 =?us-ascii?Q?SnvGQ3zxgVn1iOYsbpcO/DVVDOXNuDu7NF/rRhPi+c/eOGr9YPPkUjuOETRz?=
 =?us-ascii?Q?0+IFDidUA6katVtJLL2o/cXkPtb/aogKy+bcJy+/mEeqW9o557kP4OKcxnTi?=
 =?us-ascii?Q?E17dc06rWz47Im4JGsblzfyR8WzMAlcyBj/6JqMZiKkCbEaFcXvgIb0Ld1R8?=
 =?us-ascii?Q?+3CLjxB+/HuCcRHRqIV2EZHTH4KrHZoB0/c1x/u+m5F99cRbVwIxAvDQB6BQ?=
 =?us-ascii?Q?Z/jIqbDLroC7C9ei5U4y/MjiqrbrdclKT9n+Ov1HQuJ1lidk2she9WakVUDZ?=
 =?us-ascii?Q?6smWax+G0nh770usWZjKDdMajd84cUo/9XDO1fXbzPV7daK030dWhiZ5UTXU?=
 =?us-ascii?Q?erXAvfoohWYnAnUahq1BobC+YDKlXjTH4jrOOOH6x1SIT2Zx+zDipTRv9Luj?=
 =?us-ascii?Q?PFqD628TNN/yHuqQJxYJ05K6OzPvL8mPQD4T+2NIM+RdWqJIdvR5iog+bWhP?=
 =?us-ascii?Q?4dsWOvs9UNhza7Ve8cnBzBwTKlJME1doHYMGhzNTnbDsH3QESNs+XQycThn7?=
 =?us-ascii?Q?BNulTnuh+LyOR+QLqOWppkcdo/HzhVYdTUOfoNADUJytrp/SbUbRZymr5qOF?=
 =?us-ascii?Q?v2S8tcl7bG+Z6Kx4xT3/ZtcEoYlhA9uMhGX3DcDW70IBvMtmaEi8sE/JB3g8?=
 =?us-ascii?Q?NhGlKk/hO00gzJ1EPwqOoSVhrXaqC1NlgrMb1Gg+8INQ9fJ3WTAZW5QcxujQ?=
 =?us-ascii?Q?vHX3yulG8QwyWUsZBPebrIexQthkol9DSQPcO17qN27ie1SzWY8uXt8wph6m?=
 =?us-ascii?Q?Fz0pj+a3SIaQ1tFwv+fPZSvzN7x+me28BY+dOgQN5o4J2V+z9bTDkmKEiUGT?=
 =?us-ascii?Q?Ral6G6Lnio5pDEt57Tig/N0urkWE/LPngXkzoPHCYFw1f9LXj5XBgvSV+Pmh?=
 =?us-ascii?Q?TMD7Rfnv2JXg1fT9pUAFi8AnmB89gY86jby9pBHjtT6eEjBdXWs+aFM5CaiX?=
 =?us-ascii?Q?f55NNJxZfdR1/eZD9sYZ7pnUJ+Bl2yghmNWf+zoU+xC7JLo13uFXJfubq6Lx?=
 =?us-ascii?Q?5JV8OApxXAo3fUbO5yketo9eQ1EwoRCLdOAWiVXVzTQ5gylZAug2f7O1m4dS?=
 =?us-ascii?Q?2Aoos9VP1g68BwVXVMY/8YDB7e0XqtgzEvS5LiIHW0kHkiyFDZAsBhsK72D3?=
 =?us-ascii?Q?njudXbrswjemN/Clfnlyw9vR4z5mdZZczbia5RSmZNTWGGJsV3zQvYLJbfIN?=
 =?us-ascii?Q?Ij2A02LVkHPUmcZEHY8pTz7m4Jnu1ZVt4yHVtCItOWrjjnyBe+LAX4FmTt1Q?=
 =?us-ascii?Q?1x4zliA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOE++uUP5jadJBsY2u2j/sOR3dWcId8s9s10aDNPtTL/Dig865CHdo0+OMM7?=
 =?us-ascii?Q?EgPJPWUFcoOnn4PIs0v2knB82TE2n0Zbqapb69lHuzMfiOTxsuSo0K7gv4+o?=
 =?us-ascii?Q?IkfPvYLgkd/iofSsMv4QMYUNhIZWyQOkhXPCmL82Sm2uXrDAf0M6V2rpg9+v?=
 =?us-ascii?Q?A/QjJx9V2vOFZi73a+60Z8Cg3037b9p+9sHIAZT8pasahEWHwJ92aAkDfdqT?=
 =?us-ascii?Q?sV120nliEjh7qHgP1Q7jEwFs2aOs2TL6OFdv7DiB3Aym1n6YPm2A46zCH/Fl?=
 =?us-ascii?Q?z6uTB+vRyv65ZXGKujSM7yusnIQsXYnZzpI6PXhY8LhzgBH6tSINHPx7TpSC?=
 =?us-ascii?Q?zNMHQJSfrlKU/mbFygjLL68RIdwZkpbHH4c1vvdaTwLuf4zJgBQK+PVXu1Rz?=
 =?us-ascii?Q?q2952G9+4XCUl12FFy0xw+SwOTToYxaYTMAnZIDyaNedXTkzUG99PjbU3N3z?=
 =?us-ascii?Q?XRPpaOjCPQWXi7K0woxlw5wKJLbXgPkYKZLqaOZoVwYLUnPhcHSuN9tYyOcG?=
 =?us-ascii?Q?XuH96bmXZ0rDhcZUaLwhf05Ysq3yVcSADzGvRkV0T3s9VLIwYpbAKXRokpOx?=
 =?us-ascii?Q?vZCdUfurBbY5I4sJvG0qXQlh1IP7bEqbcqr/56Fj8AFl6BGUeXe4nDRTSI5i?=
 =?us-ascii?Q?s8ko7h4uZCB6gOGbQ1vVlk6MO9LdDwcO5U9KVGAb9Nlx+K9m75BXMxlmgMwi?=
 =?us-ascii?Q?4CqZbeh2fuucYYXxf9VZhLo3jIYtr5zjC+7W5w+kQF7ZWiFd+jQuq/jSG+ey?=
 =?us-ascii?Q?LHxp/oLYRgGfHjOgoZcIlY1Me4O8HsMolYX/PoTsFn0CdUoANsRPsfNl38tr?=
 =?us-ascii?Q?Xo19fy2RgtXxR3WgGVFXhmOdT+LsErkfATdTLKu5pNYOlyzlYO9I1criZ4r5?=
 =?us-ascii?Q?ZZSE18VKClo/gA3KPhbrU4TSXIsmv7nAxcpUJztdTso+B9YdACUucnmlL5Da?=
 =?us-ascii?Q?0ANCLNrSTrg/5BG7r7+ar9YjKtK4JBwhUtZJxlH3Rf6YrdlhdvmTsxtTnVu1?=
 =?us-ascii?Q?+PFJ3GwECqYqh5RxviAM1aKlJZoqCl8aKL+yhOw7NuZGg0qz5fE4ztdmKjgR?=
 =?us-ascii?Q?eGtie/Z2z3hGvevW/1xJmq8qmOCeJhGXOLw0DaIfWQDq5l5CXROhj3xAqwqW?=
 =?us-ascii?Q?dtqtmYtxoTphy+KZyab4xfAL+1fw0Av49C4Q3a9vZoq21Jg2uwVMPeZO2L+F?=
 =?us-ascii?Q?L7R1WD67L07cPxTa6UBByBo6mfJcm88MbX0QS2OUeq1XCKHe6f5naHHebl7W?=
 =?us-ascii?Q?Npi5hpxfwWXu7zwV5vDN7frm5K3LdY/Wyt2mNdS6WB8+e35gE4WWJWnKfRo2?=
 =?us-ascii?Q?faJg+8tCtMIdBe/edciVYnHQoUNOmygW4wZJVGmAH11kxcAtjHy1hWAFT6qR?=
 =?us-ascii?Q?ealVKKFzsc8XAQ3eMLYt3ZWuNcDqaJk1AdE0dpwGdlPDDlvhID96NqI8ZLjW?=
 =?us-ascii?Q?nSL7XUBzr/uy9j8gZMvven1vWYAdMKIzrSgQCQ/Uw/mJw3ya8zFvoqvZXJI/?=
 =?us-ascii?Q?fAE44fcHVIdpYAdw434MxKKQOmsf1KEvfRzJWApyIkGBSQ85YMpn7t6JxQrV?=
 =?us-ascii?Q?MIafPprQWJBpKQJ+w7rH1a0JQxCQFIIX1vLL3VA4qga7bnyDZCp41FdxL1MP?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ty1JhGcmT/JRxPJaQlqO62v/e5FLmxMMJ7NhgFnqNAU44+Zeh18Fh7EoC74BUssRUP4lf0Eup3m61bKBsPBcTD2Ulw5MXeNuC4zYA76yaFg87iHfamyA0w/J3uo4dsd7HYq6meki6PIHSVIvVCA/QNSxt5Y4YV8P+mzdpENADc517EnbKZiZ+7LNgJkrHGwdwPLz+KvHeCEj0MpsshmJP5OleZhm+J9eQM7F29NsaDjqqWCjllBRQT82Ry4jHQt4rptrh/aiERU0NVQ5l2pP1GEnT41BPjwyTdC6zUthtOh1tFdUR6YXFk3UNfDmOTc5/NOr/SQF1VUPdlw/29rlIYgvaFWsgRrsvz8oi1VkWdWz8aV4FnO5i+U/LvEpq5ezbnwEbCV0MKIxj0TJZMtUtzGcAGWfW1CpiW/+zpDCdiq6zA56yFIpXYGQHzH9dvT/5OUBdrZmUETnUaQEz5nWcgeJxcZgXaLg4kbkPzGw9Sa9lxp1yprAT4AYPx4l3iQ4E6oMuf+HkUFkUZv98hBZ2O58VYFPpi1SFQgdR78KTEpIQ9SZxHVPo96kGtYhWlp5nLZfZkbrl9fGDaoUh81m1bBaxXWoys9dUHzSRzuCu8u0Al/1Lhqi8Ts+LbTONAyc
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c822f8e2-9392-4016-d556-08dcf207a974
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:36:30.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQdcM52J/R3hEnIPoRL5pLrjYWew1eDUyh+MrXNCDNBj0TbOeqBzTuPPRNnT6AnLffEPGmcUJB09XVfCvSqWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6034
X-MDID: 1729539393-u_O16v4KUMPN
X-MDID-O:
 eu1;fra;1729539393;u_O16v4KUMPN;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


> > @@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
> >  
> >  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
> >  {
> > +	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
> >  	size_t size = (1 << shift) * sizeof(struct neighbour *);
> > -	struct neigh_hash_table *ret;
> >  	struct neighbour __rcu **buckets;
> > +	struct hlist_head *hash_heads;
> > +	struct neigh_hash_table *ret;
> >  	int i;
> >  
> > +	hash_heads = NULL;
> 
> nit: This init is not needed.

This is needed in order to prevent unitialized memory access if we failed to
allocate `buckets`.

If possible I'd prefer to leave this as-is, given that this is rewritten later,
in commit 5.

> > @@ -564,6 +586,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
> >  						    rcu);
> >  	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
> >  	struct neighbour __rcu **buckets = nht->hash_buckets;
> > +	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
> > +	struct hlist_head *hash_heads = nht->hash_heads;
> 
> nit: reverse xmas tree order.

Apologies, I thought I squashed all of these, I'll be more thorough next time.


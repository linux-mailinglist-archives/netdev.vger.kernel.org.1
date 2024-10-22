Return-Path: <netdev+bounces-137880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432779AA454
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC9D1F23ADE
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B521A00F0;
	Tue, 22 Oct 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="YCcgnjfj"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413C19EED0
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604653; cv=fail; b=WxvCkGpqylzdVvE2QvEnuL/xkDerS+EjTC/kY5OZvUR2T86bdQ62VwIoZR+y/1TV5lUzZvmmg1JRaR4NJ4lcvdQn0VbrmF6GAFEFVhqCL7YGYYDoHHXqb3dqrBsQWb+VAlNVtBkxCkGjSvT3ZDKy5sihNuNaFZaKr6grloeDoYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604653; c=relaxed/simple;
	bh=SW7NHBWvw14tlTZSJoxluwHNg+nG2tk4ZZ+/uA+uqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJVpr97fbkpj48YFJf/jwj7WA52U0wLZnMDecJarmzE3Adq/CxxL+q2hSDWny2lvAc9d66+1Oaa3jAlp3aj5v6bQmZjeq4jH3nbnwl4+s0+CDRt7dF6dOnblRjA0zginOQNdp9wruqi+62cRntYS7+Wth56D/1X/ZjBTCf2IUTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=YCcgnjfj; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2239.outbound.protection.outlook.com [104.47.51.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A285E200058;
	Tue, 22 Oct 2024 13:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMxQajFzNWZm6CC6Zxp9iuN+zfk2hPyB2h4MNN91yJu+jx00RVcsC9QmESjXJ+h8Vm3eOOdpypI7HtQQDzI1WQrXsFB3C2kYsHUa8mE11lkEv3GLwCWbXAmi+9BjbN4O7+oZQZ4CyBIlEAHJj9wA3nZk0caviNgFNzsyt6r90dyoi7Htvlat8uO2R8vcyuZjxthrT0d9zM2H1N4InOhseu2/zPg7c37sYUA+3z5sperrr5CXuHxkruMvfJiSpse+RtQdQX2YvlpXj9fem6zC9RHhTvra8dcZqY6wkkmRm+Wqiwu/LQizLoTJaXs+Cn7ybIwzi7sqP+Xqc+SVfzJT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cylQm6lZRUJ/JcocrWyTx3aP0fgE/+335oaJiISgVbE=;
 b=QIQkNW1P57UyGC7QncjdQUNu5cKOcbBorS0LStAQMjxCLfX87h/l/O19w7C7GWcUkSSuPZY9LBwsXafihw8BlKvd9Dr38MmmCZhD+GdyzSR+O7QeYRqZ8oL7TJK3frgskmqdidxteuHXQuumqsiBLw+JEg/Ui5mTa96sP1cypPzmhhA+eh4VS+XXj3J4UFbQ8l+b3j58ZBVt4J1dSzfas1etkLQlIzdc+4oPua2FHmbCDS9CVgTLtSYZMYtNFHgx3VhbiYg0V30RruLTMnjy2vZtIX8/AROgDuTAL6dZOG8qPOPjNsCffmRDUgEfCxSBgb0KqIgusLgQFGAlyZI5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cylQm6lZRUJ/JcocrWyTx3aP0fgE/+335oaJiISgVbE=;
 b=YCcgnjfjq2Ij0Qd5Td3kaUQuV57qBZY4/1POlECBxfWf0Red+rjlBpek6NCaIncVWu77gwDAjCkY/+swsxZHZ6rWxlW65UUC3zM9SdmaktpDdoC4ZCljT2Z/WygD5etPJ57nUWlMuWbqPU7hZ9CUEHmWkIC5txkXSSlhAEIrLGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9077.eurprd08.prod.outlook.com (2603:10a6:10:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:54 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:54 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 1/6] neighbour: Add hlist_node to struct neighbour
Date: Tue, 22 Oct 2024 13:43:36 +0000
Message-ID: <20241022134343.3354111-2-gnaaman@drivenets.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 347707d3-9a83-4e35-53d8-08dcf29f9167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UpX7mf9mDFXoF4zbq9gqj9BLNszikoAiud//6Ja8fT1NbMrTILS1E3z1gvG?=
 =?us-ascii?Q?Cy/X/cu/mrHPE02mACGd04nt6tFJM4R04CXBaXA1ScFXdRNwlnV19Llk1WVb?=
 =?us-ascii?Q?zksVY5qy1FPL3Zy1gpkhwdvQDHwlslSUTNNsz74o1NvY2d19qtV/ybhtnxVk?=
 =?us-ascii?Q?lzcA2T0gEp7A0hv97eGal8VBW8plDFht6eZza1SlnAbPsO1H7z9tekPaKIyL?=
 =?us-ascii?Q?0Bb2kk2e21UenDtmJNzwM1SBhF6yqz+3o6bVExhhCy++tOrUu8eLB00IWe18?=
 =?us-ascii?Q?XIwPZh9Mh2AtJuP7mKlE2oaOBYuv3jwuCIES7xL2dmKPvyzVnVN9+Saqb02O?=
 =?us-ascii?Q?JeyuP/U4GSir6+T+YyMVmTNWK9hgvKGrSkLrEEXhwxuL7ExDkDKRI2d8bRk8?=
 =?us-ascii?Q?DVcIA/D+grS2/4uV8w6PbWTNGeEuLC20sDO05uq6Hh2hmYk1MgEG8FWSf8Ko?=
 =?us-ascii?Q?vlQKpBdhSSC7z7JffkwxpEnrRf0zz7N5cdEQwHND2eM2ODKUNL7OS9zXdIuf?=
 =?us-ascii?Q?9JE7F0aEZoCEa7MUqEEqq500+JvLZRq9rVr5IoG8E05l/ywYpSezw4ObrKzf?=
 =?us-ascii?Q?IGSNfIYTWJzkqALNMf3fD+DtplVsBQHtHIxJpu8o5ryO7dZYR2GwtLrrqVsI?=
 =?us-ascii?Q?aQKt9WJcpoovdczRXStfg6hK3HIBKkQaIDHyDmPsplX5I9TvHLplDdGdcaB/?=
 =?us-ascii?Q?1LnZiPj8T9hPbmhTcEjJX5SkHX8P29I66USGVwZh+oKGPLZE8xaOY/KFra4z?=
 =?us-ascii?Q?sHGtFFErmLvyNIRc7X04Si12gvYXLdbrRxPM3NjWl64CpqcuTYY7B7UJeLQ5?=
 =?us-ascii?Q?axi0NPdhLQs90Y74fRqcdHjnEYf3HCCCil5gKi/BDA6y2beOYrTMU/zZJu7k?=
 =?us-ascii?Q?dxw1ot/WtL05PZuMu3ZYYNVykguch6Sg5GFsZRECUGmEZzfsf2WM9VOXrV4C?=
 =?us-ascii?Q?ambrC+IrCOTH2wWIB0BmI2z0J08szRYUe5bm8LVaIYd9ODnUyYGizzFCLTTn?=
 =?us-ascii?Q?SrAXchNdDJMjlQyQ8xjn0th4ZQdTqrLJxeevPC0OaHmOC9byPxyT5ytG1R+H?=
 =?us-ascii?Q?iO0sEi46w4GLOm/fdDJ/fW/03AJ8S0PvCgBEfuj2///rQI5HIPO3kKbTAlll?=
 =?us-ascii?Q?5Etr3bcFqHt518roKAApDACtS/+2L1OOKexet7bQR7f7Yk32UjbqmTXkCs1W?=
 =?us-ascii?Q?A+2W/JiXrNJtzI7OiJi0FVKFJJHIfRtoJEGsjytT6X90HxrLImnBNE74vEa+?=
 =?us-ascii?Q?3hLYSMTMHCv1dDUqbceqBlhEEvQ+kNdB/yZJRg0ZLAibPhkSaN/KGZb4J/Zn?=
 =?us-ascii?Q?YCZsCSfB+p4F1KhMjC12TPnDtw6GozQTs9vOxn1JjhhUj2oL1CXR0ziA+gae?=
 =?us-ascii?Q?64RXlTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+Gu3ZOWrez39qo2TtAiUOcbGhSkH/vDkAMGfTH8lbVTw62ETfxBQJrwi379?=
 =?us-ascii?Q?J8HjaSK/quHTZgxIJhW/Wf6jnV3FUP7TswMrixeDNw6zvdmYTwUK1ojHBf4z?=
 =?us-ascii?Q?9j0zU8BbreVAF2y9gngsljL6bl/Cl4Jz+GbzaEotOefAQ+sQWQlmT3tgaLBP?=
 =?us-ascii?Q?L1B9zEdvegO40PrH2gh3bxlOjfbTKS6vasZjV1/sNqcAe4HuYR2sbsnxwOOE?=
 =?us-ascii?Q?jFzC8Ulp31ADzOeeqx7SfQ8fqtUspo5mq0bDP/OaKRqEgsXtgvvu3TmBA4k3?=
 =?us-ascii?Q?YXUJC5A0S2rRsGIVQEhevwmMdY7GP87orLwdi+XCmmEzmLXzM3diTCwtVEkv?=
 =?us-ascii?Q?SmYUzb9GdSz5suyWYdJTekxbX0VZQ+frt5iOEf7LJD2AH99VhFHGUYWFnk9i?=
 =?us-ascii?Q?r81V0nxKJnKAvo4mR/diNY+f63x1+wONZgV9+0lGf15hRZ8ggvugTzWZB3Sn?=
 =?us-ascii?Q?mERggdk5nBE09+6JhDSU1CURNpV4z6IZLxHNqG2eRJ7coEqaHn3RRbOraKHL?=
 =?us-ascii?Q?V1+v4FfW5bAJT4ERQrEDYXSoxtRsfKrGEbKec3uh4HfcbnjuOe/2ONFhraMc?=
 =?us-ascii?Q?PpUpAs0Zknj4wJjtDeH9rSggbUbc20exf3bEuNmkafSkNowV+VaqC+1ouxAd?=
 =?us-ascii?Q?WT8cS4/UILFbaFDEYPr1rloGa8QgLcNIt7kSi5fDOcsy8t43TIQDLKV3FCbJ?=
 =?us-ascii?Q?iwI6JPvsscV4mcVDDIvd4nS1ITwtlsW8OptqVfgLNWr66CwY46tw5D2GtUzr?=
 =?us-ascii?Q?FV7Kq71yqsziRjLHClp5ClaPjXNCRf0teLW9w6R5eO4zZgxoTMuMtVNhvAm5?=
 =?us-ascii?Q?CeZLZxBU15aPsir7oCV5VP/UZ/pUyjeMUy14cHzCmxETvkW8xFjubNJRmz1a?=
 =?us-ascii?Q?mLgXed0Pf/3DO19Ava2fz/nqp6WlByk1GloowGADNndtwN2IdnrXITOFjAlN?=
 =?us-ascii?Q?R2nWPDF/p+VFm9rKOB4d5mRUqHXcAoGfYnj8DNKG1T5JqrdC5X9O0DULfX8Q?=
 =?us-ascii?Q?FVXxQQ6Oje0eFgrbYrbwF00maTCz2EsAyzw7YOxL3BJ0aG20KlHD/H8REYQf?=
 =?us-ascii?Q?ks6GivTaPyW94q68t/pz4pQu5mK6P2xP+3p1Po8eh68hNuC9gS+BAiCskGHO?=
 =?us-ascii?Q?lTnspKU/MiM9peSCEmS7mBhpu57WZ7H8xgxnCMSI9gvWj/W8eX+8rmDA+qqh?=
 =?us-ascii?Q?P7W10Xvf2rBj92S38mEX44HbzFHtm/fbovHaqdZxiq84ty2YsMwGmzFo1j+f?=
 =?us-ascii?Q?kcBLU5gcf/y4OnyKeY/B87KBgc2Nc2U10om/S3/24h2thHOvNQUVE3A2gTeY?=
 =?us-ascii?Q?ycHRiycp4GmOGD3LYj5oNSrptkg2k5MWUnN7hPKh1t/2LtfHaUJjKwijl8K6?=
 =?us-ascii?Q?Cekl77ZyXwEbh95pnpktlAuyXzfGeYTdOoYqZudEWW+JraDGhCRfzqd27B4a?=
 =?us-ascii?Q?xcBaIk7TXvzgJ57wBcx8F+GzKgKHxbIq5tFLFbkouyk+CEcWKw6R0UiZIIc2?=
 =?us-ascii?Q?Ie9272p3/2XNChddwb5wBwXufnnt2fncyo5T94r/o5wKSjrTS2ZBeKcoYdlm?=
 =?us-ascii?Q?Q0Ij7wxaA4sF8QEZ1a1vlehhfzBS7c9NYIbtDpES?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZzDVbMGjr5YW+o+5k6vilHoTScJwLnMu1vJKCqjIUUfJmcZ4fKNUscr3lGzO0OcAIcPq8z3y9T08I0mBGess7bZSAAx8b3CazwZAqbnEaSDIb+xli5rxzken8zzdCkwS4NQhLVOaP+luCI+U3AvViV5Ez4ZpjOdSnoMG0Ysc25mCCCgbYb9gVHL/BNasJxFokHYBc4jzpPO6QwIFvLrmnSr1vI74u+4c0kc0pRx0fTvdIU/DOnfoxvH7tBw/WftdbRelTBtJMhtLnYg75jpOb5+2pvMmAH3wLHtalYHMwyJnIXdN2JLl2u+/Zoyvp3g+TJkHPj7qy5MQnKOK1+serK7bdCViiN+ZUcfRKTQY4MVEfuqGdISBavo2D5b+jBkABDuyLWBw3sKjSRzLXPUmtetqJ5vIO5jVr1KrHgAgygpvZfT81vejHkzLzX1CNj9cQEOjPeUG5ULoDLMYgA88sfGDrOnxe7TiJQ7zQGVJEPHPQYT8IC2nSjqVDeJpCVURQZtAnYZl1llW/pRNu5MebXIY3m36hwjYgFhc/Oy4XeAY5uvF3pqFtZXxBxbuRnYkU0CbdpO4iK2+5Tih4AV943cHzICdj5iA/muRP8d4weoB4wOMP5iiadJ1BLh9jgUJ
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347707d3-9a83-4e35-53d8-08dcf29f9167
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:53.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C7U8l3mJ1CftZ9m4ypZ9c5c21jf9gW6ZLJZOZaMn3x4e+zMtW5SNvL7p0rYdkIl0J74pyiZe2qPIeyRxzNqoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9077
X-MDID: 1729604642-cJWXA_s_hfV8
X-MDID-O:
 eu1;ams;1729604642;cJWXA_s_hfV8;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3887ed9e5026..0402447854c7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -136,6 +136,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct neighbour __rcu	*next;
+	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -191,6 +192,7 @@ struct pneigh_entry {
 
 struct neigh_hash_table {
 	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395ae1626eef..7df4cfc0ac9a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -217,6 +217,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -403,6 +404,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neigh_hash_table *ret;
 	struct neighbour __rcu **buckets;
+	struct hlist_head *hash_heads;
+	struct neigh_hash_table *ret;
 	int i;
 
+	hash_heads = NULL;
+
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
+			if (!hash_heads)
+				kfree(buckets);
+		}
 	} else {
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = (struct hlist_head *)
+				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
+						 get_order(hash_heads_size));
+			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
+			if (!hash_heads)
+				free_pages((unsigned long)buckets, get_order(size));
+		}
 	}
-	if (!buckets) {
+	if (!buckets || !hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -562,8 +584,10 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
+	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
 	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
 	struct neighbour __rcu **buckets = nht->hash_buckets;
+	struct hlist_head *hash_heads = nht->hash_heads;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -571,6 +595,13 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 		kmemleak_free(buckets);
 		free_pages((unsigned long)buckets, get_order(size));
 	}
+
+	if (hash_heads_size < PAGE_SIZE) {
+		kfree(hash_heads);
+	} else {
+		kmemleak_free(hash_heads);
+		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+	}
 	kfree(nht);
 }
 
@@ -607,6 +638,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -717,6 +750,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -1002,6 +1036,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3131,6 +3166,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.46.0



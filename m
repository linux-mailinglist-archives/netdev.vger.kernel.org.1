Return-Path: <netdev+bounces-304011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xi8wCmIRRmrnIwsAu9opvQ
	(envelope-from <netdev+bounces-304011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CFE6F41A5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:21:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NYwurSyF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304011-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8DE7301E821
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2693905FD;
	Thu,  2 Jul 2026 07:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227E388879
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:18:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976725; cv=fail; b=cIv8rTUMLEViKRTG8JQ4D7YGkAaNtXe2wsPls88P7Tvssjz3ximb882EZn9oPie3rbb2O4KWWAnl9llWiY/gNHr+s/yhKdzYoaeyjHYflz7vh4kl3dcftrWKHTtthXFfNgiN8BSFFu+09vc5BUihh+sPxtZnhaNieqXFilZ+Sl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976725; c=relaxed/simple;
	bh=eBj3xQzhYrIkME0Qt7sJLr5sCf/9n7qlxBKGq0kSY0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N/l08x5eZVv1HAjuRk6csWBnQXbM+rXJHhS8ZKfk1bVddEXGXeAOM7CLa2DX0qBqaSbxwzdKdLknrIJu//iWanRWuegRkN3XT119rgqh3vvo57LCgQ1Qme8s97GPW+DItsI7lCWAhVtjLepr5XVYxj7w8joihNvFm5FAfZ/+kHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYwurSyF; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWXeCryyHnn6cTBQ292WjfFFY7Pum1nwTw1cjxqbkCG6g1samKbxijCaWe8vc8LBrmjagVm2lja8ZesSh8d7WAXj8Uh5k4hi8Vxc++VFMwUFvoMXhsxN08RNmXOaSryjegKwEfJolo+9MTYXpJpoGC4evpVFGspm2RxMCd4TtmFop9NGG+1Yv4bZ/J3NnclVODARgliiBZPKa6uBjvWPYXOhV93VTEheBfmZBlnQIfP6qkpwKXvadAeMgKTABkv6CLXL0dtSpcHtkZ5fODrYO2xkRRuPh6zori5LTrb/SqmnU7GJ/XbRplmuALZ0E9gOs3NB2mlkvEFDvrCHbPx/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RljawS6R5VK5n03TBdmt5veBBWWAhUn3ZmqUdLZOyo=;
 b=Sfnw5ouYAecfORTnlgTOy+PzpVqTEUUyG2jJ88kc4a9PWHposxTevEcOD+ig00vRkd46MvjJvdk51r0WBJtvYeJTvR/pDt3C+mDS0WI9/T8PjI5aO4mD01ySlmR4upxJbXDi0W8PWL48TN852MIh8Kn7y48ruENujFZpmX9RWVeANfkYy3b3zjsHrkpWZJTTiS84vUGKyqQMjLvKUJYxvA9xfjdUQV5+y2shGFPgplB698OuVTYf61EOrn/2otxBl36wC/+5f8XxHiPfnGFxAMN6jcgR3iQ4JqELRYGOP47FPaU4ACb30zgjrhRUOsiu87CSHBTaUCLucMPbh9I1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RljawS6R5VK5n03TBdmt5veBBWWAhUn3ZmqUdLZOyo=;
 b=NYwurSyF3YdlvXdUubgLCQfZVwm6YP2s/W9SL9q/zrDCzjfMw86sRPzZYpy4jWY2TDr9/CseqRSxSs0m0nlrVT59n9R2ZB3BXI15rpeoW4LiK11m5B6uA/9ZbckIqQH+0hzrG7O5BLjh/YEWsTIG/R628FAgpO9Ayh8WNf8mCWgJCZkO7EGde8+Xm6vftQRSI/izHZlPCDK49yQYW3aVclDURE96st85h9irI3GZw6nQ3IkyjAji4+nOsExRADZ4zDip1PR2gkSnUN6j6ynpbFO8chwnEexi8Q/5sdbVdic0VEuQ/KWVnAMSAVEKY2t7O7gAPWD6TPA67Rd/fVFs+A==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:18:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 07:18:37 +0000
Date: Thu, 2 Jul 2026 10:18:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 2/2] net: fib_rules: Destroy ops->lock in
 fib_rules_unregister().
Message-ID: <20260702071826.GC1544468@shredder>
References: <20260702044437.591864-1-kuniyu@google.com>
 <20260702044437.591864-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702044437.591864-3-kuniyu@google.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: b01ece59-5fc7-4896-6262-08ded80a228a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WRX1AEmyJBtPZ0nJoAMJtBFGL8NIaoTdzcWvmW9fRFCDvZDf2x05AyS6OCm08dCiyVYguKOXC/jsgVLg/0LA52BS90zTJfeRvz0zRFmiKSkdGYWqDSSXMBhylHJdGSzo/MDR3XLXWmy+2ytlk8G5kajTC57BQ7UpSx/RuAWRVNPkLAcKpb/PX4czcyjiDdeEpzl/Q8SCkrhn4D8ZQ6pHWXIbNJssAUkuUTWJrZsl5IX+JfZvA413jkHGUg5wXtyh/9g+fv9T7OJpYZtXkj/uySigxpcyz+1Jrb50ZcS6Drtf+CcGzbnG+3OpitjJlq4dhuVHBNTrc5vIJc7oTqi1TzIC5JVwQfDvx99qA2o1Tlbm7i3DTgGk4lsrVv7GiVe+Be7DXxVshQu7aWhgbTKywOkW38/2jquGwSUsTZqGwyR2PH885Dsc7A3k3VsXq3ql4SOD0+T2Q4XiMu6+Jj1Zcljbamx1C4TWK1cW2AJUfmUakHikx0XRO7GYdzUNdujs71XnpGIKJgQTeL9BImt4wKE1SArJC4AjB4sqwlmdlqY2HkW/cUqUfbHD7KZgcjZxL/QiIxHhhkhqiSuJsS9jrOu0wJJsln0TZbi0ktOwPOyt6SgRCbI98GVvJC5UPaglhsiddqrXh2qSqYyj3ENu5d1txMhmtpF6IiO0VE7yKEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8rSa9Op/naCOTog+zyiJu/NNvLmDOpGUh/z6W7+WDtVRPfB9gUOdQtBMDFC?=
 =?us-ascii?Q?uaxT0pBfDHtZJE7+ZrKMcH8Py0xzX9PA6AJn9VbsvD18iRf2KyEtUgaFNkIb?=
 =?us-ascii?Q?xvQqSvfMMIjd3zPdfwbyqiEoeT6coHFoP7wrMjtNGCvEQelg4o6PJhyscJkH?=
 =?us-ascii?Q?DXiuStk9fsvgOkkCp6cqnxDs3OAZ+/hDZCWwL8dMs/Mp2NMhQSv/+3QiaeV9?=
 =?us-ascii?Q?OAVItTbrExusyuzM0IwOo9qGQiPdZmCOAliIVEmZK6RNlWOVNikSBxWdGklI?=
 =?us-ascii?Q?D02bm9Mf6SyhtTDEpcSyR7p3VqygA4T2YFV7j5AEkAarO85zsGxL2iFbHQ+R?=
 =?us-ascii?Q?JQwhpoDYD7mJXA4LSlmX2nJ7jPOwOrCXg7yLJDp86WNgrhuhcf31FRMlYkM1?=
 =?us-ascii?Q?UVwDNCqyEqXrQQ5mYKMaMfMhBE5a3E3nCBXNsQLZzBYRwe3wzoc+oL4wXrRr?=
 =?us-ascii?Q?3GDCDSBkGFki7/lzLmOQNhApKkqbi2JW9foReD0u1wpHQNlMQNvn73FOau+d?=
 =?us-ascii?Q?eH8LK1thZ7jGEH1fXtFl8YlOplAWwJXS31CcPpL6Qx/6IxcEF05i8VapZ22D?=
 =?us-ascii?Q?HuMqeZ7RNI2P94+wbwftrNr28h/cDyjfWZeZQO+rpxdexh2Bw6UHUAWGFbaO?=
 =?us-ascii?Q?gctjVFxd5cgbhOMXYVEKcvFQxtMi50NwZDg1YC0dgVVivQQrlUtwXMjMr186?=
 =?us-ascii?Q?piTjpXfktGtSMvK8mLtTg24f2Nq8/0rERqZi7453s04ov/xDfN8q1ImMcc/6?=
 =?us-ascii?Q?vd9L3NE3qo6zNmmZNKmlpZDhM1FvJutwWg6Hlfh2dIVaN8QGNDVz6rXv9bcX?=
 =?us-ascii?Q?3EYoLN0I9Jq4snEjfXj7mXzz/JrLZMLxEYMNJMdU5rCrgjH+o1N7ieRXY/3N?=
 =?us-ascii?Q?hqmm1rpO3Jx6XAwZ8q0DKMVpMU0eUAnV+KnRI7OBTC9kOube8sbWLYWrpc98?=
 =?us-ascii?Q?8v/rP84SnW/hjkAjtnweJ2EBCTzpmlnCZYC5BXn5IWAHuTd75YfUzfm64IOk?=
 =?us-ascii?Q?JrgzBMiwMRdUQFi4HSaFw2g65scDILA6qV61ddkypYqsfWJ0c1TMOV+yRNK6?=
 =?us-ascii?Q?ynfJk75WSvnodtDB9Hfc1yjhtvQ+bUwj6tGiHNFdFaK1mdjzcFfKJKQ8aC9O?=
 =?us-ascii?Q?/lNmICmoZXwdiXgcOoxFXqfwB5heLm75rnXatAoryrb5cn8/E/F1ZBOsMd2c?=
 =?us-ascii?Q?+L5cy9Zc3F3c6AxJuD1m58iHSaRSM3v4uaxIgaf8GevTdItoVxPc71aO/I7r?=
 =?us-ascii?Q?mnn8dpIl7ti98akzfrz9H2eUyatz3bQM1WCigZ75fKCCDlR61L2W3jOp4l4d?=
 =?us-ascii?Q?KuJF/Nve/oRIiKjUIVLmYvOSSCQv11H+19x85KhFozixmV+F8rfpuBOfWq8k?=
 =?us-ascii?Q?uAWfrn4w7bAAbK4bhRJNs7Nj+tI86R7y9V7YVfSO0BGpR5WrZ3lnqCmdK9n5?=
 =?us-ascii?Q?avNhv8KYlylXeL/MZo/gjYZufWo2qc67wh9R0EdKEQxzgQ6IFGW946+lRVJK?=
 =?us-ascii?Q?74ceua0921gflCvd7ZlU82cDsenx1z+OFdt/QwQ4NGNDUk0wxa85LC3wXp+U?=
 =?us-ascii?Q?NITRwhcPJ30EFn2tpiOTh1yrkrWiiUdxQDjhvkC+526cbmi44reIaOPPims6?=
 =?us-ascii?Q?wSF/AZTgw5OtU/Dq4eLWOusB2dpljvOqhj3IPyqCJMuWCcbGnle3cOyTfxrH?=
 =?us-ascii?Q?D8nIXtFlksSLygLV4W4pct65gbOCBREIpr5AQLeGk++zh8fb50gYRpQk3EHu?=
 =?us-ascii?Q?UbOIXRtv3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01ece59-5fc7-4896-6262-08ded80a228a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:18:37.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW5YE8nLQI0mJAzuLc8e+UnxEr0K3TkR78cZ3nraQH3+MbgtF13jE2h3tsy8HF3yzs8b3yHzwWrBpZ6vbNpzjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shredder:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24CFE6F41A5

On Thu, Jul 02, 2026 at 04:44:15AM +0000, Kuniyuki Iwashima wrote:
> Commit 8e133ba99cd8 ("net: fib_rules: Add fib_rules_ops.lock.")
> added mutex in struct fib_rules_ops, which is initialised in
> fib_rules_register().
> 
> Let's add paired mutex_destroy() in fib_rules_unregister().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>


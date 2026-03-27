Return-Path: <netdev+bounces-272424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCI0FAw1xmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:43:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3EB340914
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5B231BF680
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC633F37A;
	Fri, 27 Mar 2026 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtu05Bza"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85A146D5A;
	Fri, 27 Mar 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596780; cv=fail; b=pc4fnfDMwVE7s0N1oGl/QSDw2Z1jrPB/9wa11EWoBsAvCJCJF9bJHuAE6SKKQOM+kkKCb9pkycXaPa4vdGMAt4HvP5DFd1H6rG9RfUEIAMvzV0IcyCdT6Y7ogU1ZnkJBWpqWZG65CZG4MKwtZrHoQyQRENaVZLeMWQo7DL1DUFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596780; c=relaxed/simple;
	bh=eTxk8NAXh5d5/Lt8JqK2Iz9ooTuH+qdvXU4SQNHyO80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axsHfA8H964fgPbxBp3G3vEkR2dBBr4iBrp3gYg0/zQe/I0r8mo+E+BazJ4sitrSS4NcSLXxDVagCkF9nY8xQeOOHr97DQ0jf58f0WgJV6JTaEnX63oiKsuaYqxIeGJWEmw+WlX6WfpB5Si8OZQjcJlntJC9K+35zuw0sPmavUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gtu05Bza; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L19XM1csoomrMBmg3YMVKWraKzKkqfM0IbT0ETL3mYvHYvpoVp0VcsxS+5SPiO6AqAY6rd5MEFK7NhiLvNUtcRaRVRrIHk6Ben6tjom5BEWbQc1Rl/nmoAIDMu+BwynZgD8h5r3x0XZ6s9x13bF/gloX5GcYWnVyjkJf1YHS4ccjQn+iri6A1juSP7PAhBHUlrWuhmQbrnjjkIrn1GgtvY/TKYpKHWNc/CnjU5Y2e0ULEPJJf600JALrCobOoulF2V++99q4QyId6vH8pDp/Wor+0rWDGeqnJf/RkXoGagpx8D8k7SMXJ28xl+Ork7NeP8XwDh4SRJezDCr4uQ511w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+0WVPTS4Ns6YaQEeGuTWqKEajN9JJp9Jf3A1IGxUFU=;
 b=Vv69yZjBK0n+gQ05qb06bc/7nJ7+EQazc8+V5Mh+DT4OSei1kSU8vdFvCdWgZ5f3xB540Fk9+eWaPI0UHJVpzvvN215lD73Ke3Ss1UhpqHbs3zpH8ks3JKL8cZN6ZU+YZSUWMkfl+6YV57ye2zbxyYruHSb4kWHL4DciCaA29nxHJKUQViAAI2U9o95+U/kqnwHasZVzijbuQZ+MIxuaWWFKK11U/fOROEP6/eLCWEjW/xLl5nQKVUm9tJ1JzOqEELDsaGTE+/J1ZLThhre942U4lD28yoU+Fkhz4FGMnLqipYuwdH+l4UsvJDw+4uG1zgbdfYIE74EvOKEqzPVQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+0WVPTS4Ns6YaQEeGuTWqKEajN9JJp9Jf3A1IGxUFU=;
 b=gtu05Bza2HGy7GN9tqL9NlNDW5AuIqCndfhUbZJzVjcbz20POkNdEBMUFoMD/a5VF883Aiy2ClST+RoM5ncL9xmVQwyveKZI47i5xYmVcTexBqb6d+Dc9KkF45tb5uXSOop2cVhtDfp8UHEAmflShGXvqcop+OSenC7FpoYozX3bZ4CHW6nhzbEBZvkEo8iesM2lMXGFnsz0620vyrs+HlG8h13E9PQhMWgw1L1AJvVewYCn0fE7Ypcd6qaVy+iy8TdjtqAEWS0Ll8pHAxJgzboRrJaWXC+71cmgdi98o80whrN/QYG3CXTPEpv4725pBGegvG+jCvqHVIbJ5Fnbaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 07:32:50 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 07:32:50 +0000
Date: Fri, 27 Mar 2026 09:32:22 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	petrm@nvidia.com, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] selftests: drivers: bash support for
 remote traffic generators
Message-ID: <5cuoazp2svgjja5h663zc34dafkuqa2grrm7lzpuunvrjogydf@43mryp77gq2q>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326120342.6429fbdc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326120342.6429fbdc@kernel.org>
X-ClientProxiedBy: AS4P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::22) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: d37326a7-d68f-449a-cea1-08de8bd30c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IKcR4htvOiZl9hBBtOw8/hHaRD4ZvtFF4MrlI0aaQq4N926KFODV44oCpi9toGQgA+pHljdqslE6LNR/EEwg1+fI7Ph97nvwWGce50ogIceeLrPR6JMS2GJP+JAt3plUKKHpaRNjnMjMdz92UeC8iIrHBOQZiveklVzxxa22BoJ0ZVuuimVybzgXxncffrULAa3sdZ16v5JxXAiN91HJH0FOOz/TTqN0saDCDVrVswDL9yz+/MkaWpoet7PmqZAihiBAu06W5tBz/Hk6yxLZD4QY7/cS5wT0lbJZ59lG2YiiG+IwKFyt7bwgYVgG4KKigPLcC6qjun6MQcE+p9U3YnB6+4t0dUNZ5dCk51lft0CjfGtZ0R7PwAvjmCP8B68vrsla8e1eRt4XwwZ3bYjfQL5PkAj4gwd2bhjjv+K+Y6Hc62IJAabLGD9XYg6N+uJyCRNmX5pseBH6KhEh55mh17KFa0OwiJocm+2sgtSqE8ZmrecE9gGIq5OuJx4pFNrmEJYsitD72tro+tHrORNGDCAmda6EuZr9Why1AFIuNr+0bMrtJKs+bREYzxh2+mbnfrGHKT4WuUORAvs5/rDdcqVhBxGaXJO44aEXJ5RKB3HP60IvjdYBI1vdpHXy/+lzs+g16Kvb+gkrsuEY7koErqh/qlxeYHMHnPlB2+S0Vrje4I0fp5pZctjnfxk9Bi9C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEJh3+El2T8gjGJ6hKFdY8AFW1R7/OvIkCEnuN9QFTlbShB6NbXJhGOb82sg?=
 =?us-ascii?Q?QdemqsxKBC7ylCAc80pqVJjnedAP0SGROAhIXYfAYnMpptYCbfVP1JvN/4mx?=
 =?us-ascii?Q?26qmTM3ycgZnXCvAZ+uFiO1gcfezn/9HcHPuNxqUu7ekiNSuPBjlu57tO8Xh?=
 =?us-ascii?Q?uRvoB0KDhToE5Ue9hIsB2+6DH07+AYZpiPJia7p1Hi+Nk/y+y2fJ9eIT784h?=
 =?us-ascii?Q?GshHOEEKRK6bLLUaOdVF52GYmodw+06ucrjKDVJq4chE/WLiXqR4RFt5FWpi?=
 =?us-ascii?Q?Z0dv35694PCgk4pm4rqEM0W+AgUr06Ht8PTa+jGXIsMyeMdIyExi6cwAOtVi?=
 =?us-ascii?Q?8WgaaaRrw0AOh+S6l4mtuC6S2DN95wl+zO1TTWYp4x4zb/y5svBonqE0XAeJ?=
 =?us-ascii?Q?WEdlebVM+qYKGtukDDXYQalUmfSlGuKqaLWhAj9q+py7lrRVogSKKAr+jcFW?=
 =?us-ascii?Q?P/o83U8pMauEUr94LgyZ7BXvK0aEjTdJgDvAMa7KQvW99Jiw3+q6/kRTnxKS?=
 =?us-ascii?Q?sGia87A3D8ap9SXwZReqgR9S/vk9VzcEt6m6Qb6HtLrPt/M+Itn9KN+U7Lvp?=
 =?us-ascii?Q?Sw0aYs+lzlQ1zI2GxRgHZsoSxSEbeij8NFlIJRSm6Apn3kETlItumS84CkGM?=
 =?us-ascii?Q?v8PNrAAkJFKnTEyDdj5RjugOXIWL6XGNa3f8nlJ+pxyXXfFVUKsklXPGSNlP?=
 =?us-ascii?Q?J5NT0D8ltrW5alO6QfR+G2CMxDxSBNnj6kHOiGtQeVA1zKrQgVLj+X3wmiox?=
 =?us-ascii?Q?4jSK6TF6mnVe7+kBtScQjT7I4p2drZNQpYqwFEr4U1S9RYkedwboM6cJHVPj?=
 =?us-ascii?Q?O1FspUxvxN7Sbpu10yxRnnSr7uzMmBrHg3v/hZ+6F8UbyAeY1t5yZendvAdX?=
 =?us-ascii?Q?7qnYZf1SRtjioXRwdPMGjOGhcZV73M/fIfsI26gWeY1GFLwEvVIUS3hA5NTx?=
 =?us-ascii?Q?5Xcw2rPtN5n93MAOliYICzkj1zbw1DAIxC4F6QeWHcTQ3yzX4waBdUDufnWT?=
 =?us-ascii?Q?sEkO433mI+7L6y9MoK9D3bumiEE83W+w/fDDC2mycd4PbK6gLfwSrSWrAXOI?=
 =?us-ascii?Q?bW2PcvlS5uy+Qvoz0/XhVy1kAdb1AZfJKtstAvpdJjFsQ3U9YenEDzJHLCST?=
 =?us-ascii?Q?4pSChpMkyv8mlJyW0vyR89cBxjDg5OuMJ7wIewxijedalmXQhiSTvhw2M/Gj?=
 =?us-ascii?Q?TGSY//19doKaQNaDZdZ9EboaeOs4NCB7O0MUk3nmVjSzsKnM+4PeeczO5Sbe?=
 =?us-ascii?Q?OpE3Q2L+3Oq6YAj7j/pd0OK2LKwSEao82ClAeuu0UM6qgy5O9BWvJtFsJknG?=
 =?us-ascii?Q?x+Ze/m2OA+l3+OAecvc814QQlNS8HCAuPqWszZGVgN/EBTzZuSM5yKnWdGKg?=
 =?us-ascii?Q?ZGFz7grGXLAWxP+gcd1mYcVXaAGJm3cuQ8hwW1aCNY2l5OANDPAiz9uOk5Gk?=
 =?us-ascii?Q?kz9LMQ3I+IASp4Wf/gZg6xaPQ8C++XXrWtEr/mDTZcs2vRczwdCtZC8KnM84?=
 =?us-ascii?Q?grYwZEeYCOZpw88Lws7T85gr4qHG5Yo9vU5vQNXqsH/eqQohmSHcHleFNuVi?=
 =?us-ascii?Q?aADTW1VyEvyt4fHsK7R4wZzmKU2mi319z4Znung6p7TB8dHgb8zBdGnEJ093?=
 =?us-ascii?Q?xC0OSdEYtb3uitHrnwCXX1GtUDC08iKKdJMvw0AAOL3e/oWXywBNQvh8gtrU?=
 =?us-ascii?Q?3sWt0mve3j8gCpLuTwP70LH/lqZFNhMIP6dP0V8p0Xsitj2vB7pRCGkiUonT?=
 =?us-ascii?Q?GVjyJAGW+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37326a7-d68f-449a-cea1-08de8bd30c8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:32:50.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmwQLSN0dDpIhYG+G5OXU5cYjMJizz/m4p5ueiFtnbNFZbvW3IBlFu8e4ClBwMe8/AtNBCGeMAOQUMG5fOK9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,nxp.com:dkim,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,local_termination.sh:url]
X-Rspamd-Queue-Id: CF3EB340914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:03:42PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 15:28:18 +0200 Ioana Ciornei wrote:
> > This patch set aims to add the necessary support so that bash written
> > selftests are also able to easily run with a remote traffic generator
> > system, either be it in another netns or one accessible through ssh.
> > 
> > This patch set is a result of the discussion from v1:
> > https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
> > Even though the python infrastructure is already established, some
> > things are easier in bash and it would be a shame to leave behind the
> > bash tests that we already have.
> 
> I think this introduces a bunch of regressions, eg:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/575622/4-local-termination-sh/stdout
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/575802/18-netcons-resume-sh/stdout

I cannot reproduce this unfortunately. For example, local_termination.sh
gives me the following result with the exact patches that I submitted.
Any idea on what might be the difference?

 root@localhost:~/ksft-net-drv# ./run_kselftest.sh -t net/forwarding:local_termination.sh
 [71318.022491] kselftest: Running tests in net/forwarding
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: net/forwarding: local_termination.sh
 # TEST: veth1: Unicast IPv4 to primary MAC address                    [ OK ]
 # TEST: veth1: Unicast IPv4 to macvlan MAC address                    [ OK ]
 # TEST: veth1: Unicast IPv4 to unknown MAC address                    [ OK ]
 # TEST: veth1: Unicast IPv4 to unknown MAC address, promisc           [ OK ]
 # TEST: veth1: Unicast IPv4 to unknown MAC address, allmulti          [ OK ]
 # TEST: veth1: Multicast IPv4 to joined group                         [ OK ]
 # TEST: veth1: Multicast IPv4 to unknown group                        [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: veth1: Multicast IPv4 to unknown group, promisc               [ OK ]
 # TEST: veth1: Multicast IPv4 to unknown group, allmulti              [ OK ]
 # TEST: veth1: Multicast IPv6 to joined group                         [ OK ]
 # TEST: veth1: Multicast IPv6 to unknown group                        [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: veth1: Multicast IPv6 to unknown group, promisc               [ OK ]
 # TEST: veth1: Multicast IPv6 to unknown group, allmulti              [ OK ]
 # TEST: veth1: Link-local STP BPDU                                    [ OK ]
 # TEST: veth1: Link-local LLDP                                        [ OK ]
 # TEST: veth1: 1588v2 over L2 transport, Sync                         [ OK ]
 # TEST: veth1: 1588v2 over L2 transport, Follow-Up                    [ OK ]
 # TEST: veth1: 1588v2 over L2 transport, Peer Delay Request           [ OK ]
 # TEST: veth1: 1588v2 over IPv4, Sync                                 [ OK ]
 # TEST: veth1: 1588v2 over IPv4, Follow-Up                            [ OK ]
 # TEST: veth1: 1588v2 over IPv4, Peer Delay Request                   [ OK ]
 # TEST: veth1: 1588v2 over IPv6, Sync                                 [ OK ]
 # TEST: veth1: 1588v2 over IPv6, Follow-Up                            [ OK ]
 # TEST: veth1: 1588v2 over IPv6, Peer Delay Request                   [ OK ]
 # TEST: vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv4 to joined group       [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group      [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv6 to joined group       [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group      [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: vlan_filtering=0 bridge: Link-local STP BPDU                  [ OK ]
 # TEST: vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv4 to joined group       [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group      [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv6 to joined group       [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group      [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: vlan_filtering=1 bridge: Link-local STP BPDU                  [ OK ]
 # TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
 # TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
 # TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
 # TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
 # TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
 # TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
 # TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
 # TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
 # TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
 # TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
 # TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
 # TEST: VLAN upper: Link-local STP BPDU                               [ OK ]
 # TEST: VLAN upper: Link-local LLDP                                   [ OK ]
 # TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
 # TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [ OK ]
 # TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv4, Sync                            [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv6, Sync                            [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [ OK ]
 # TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Link-local STP BPDU   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: Link-local LLDP      [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Link-local STP BPDU   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: Link-local LLDP      [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=0 bridge: Link-local STP BPDU        [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to joined group   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group   [XFAIL]
 #       reception succeeded, but should have failed
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
 # TEST: VLAN over vlan_filtering=1 bridge: Link-local STP BPDU        [ OK ]
 ok 1 selftests: net/forwarding: local_termination.sh
 root@localhost:~/ksft-net-drv# cat VERSION
 v7.0-rc3-1494-g8122e23405fc

 root@localhost:~/git/linux# git log --oneline -11
 8122e23405fc (HEAD -> 2026-03-04-net-selftests) selftests: drivers: hw: add test for the ethtool standard counters
 120c98910361 selftests: drivers: hw: update ethtool_rmon to work with a single local interface
 67eea516922b selftests: drivers: hw: move to KTAP output
 4dc0de1901c8 selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
 adf6caeb2d0b selftests: drivers: hw: test rmon counters only on first interface
 1ef526c90f90 selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
 a5a27ccb4231 selftests: net: update some helpers to use run_on
 ca2fe56c8938 selftests: net: extend lib.sh to parse drivers/net/net.config
 dc88ab221117 selftests: net: add helpers for running a command on other targets
 8bc9c8a32701 selftests: forwarding: extend ethtool_std_stats_get with pause statistics
 b08a76290c4e Merge branch 'net-dpaa2-mac-export-standard-statistics'




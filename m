Return-Path: <netdev+bounces-299890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q69xNRRuMWqFjAUAu9opvQ
	(envelope-from <netdev+bounces-299890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AB6913DB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pLAKnjOo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299890-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299890-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A88230995AB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DF44BCBE;
	Tue, 16 Jun 2026 15:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA344CAE6;
	Tue, 16 Jun 2026 15:31:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623890; cv=fail; b=kkWaEHqpsMz3KJrlYoq+LTEtFBYhmzyWDd2fob6WuSrfniKRjB6YX4oABwkvuYGFoPdUY1Nhja/QHsdo3cQRg5hz1qk1bQeGUQvChXAgrzka0QTfl3p+Bt7WYZ7q3C+pHWuuDNXuWsXtCKbacPcOkzLhv0EUWTFGAKYYqs0Zmz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623890; c=relaxed/simple;
	bh=Vchzlx6X/W8dDmqwxc0YV1js/5DjHsiI33PbmYM12eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=anPqVszUNwMCTFOiIIHDv2fH59TvkPuorQZbmQ/WazQEZ4AwbJCrjFCWkd7ecjgPzrtHjgjNlc2K3XzWe3+sBq5EY8OZOjNu01EWWfacbbMvyQLmb9WJ1KDfxtVvmR2wqXiuEp9bxozloCSYRgqnlQfhVRwRf4CGKJPwb748Fwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLAKnjOo; arc=fail smtp.client-ip=52.101.57.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk5x0pVow1mbEOaL7BCUmnNLfyOn8n0czVpLcahzxgIprtwWpjITtc5xgZJzbOeVBpU0EMdfVsQVkvnO4EuenY+cSMIUCMj71bSul2fnGufN6jGVBvUHroeZar8GKui1VN4KKY4iuXBqpTpN4FV4oYvoYrUW5+RHV9HT1CEPy+tKR5EOeEX8FcvDlbNYZOEy2UdIKIYRPaDHkNkOOW3yPV79Fm9U4FfAYG9NJ3P77Jm8QBbnk3UpaQJnZm9r2k6K9aY45391n2yQwkRa0B21N342QV/7pYDuYHWUt4NPmyfuHp8QkocLyPLL7ROmi4t6WKpZ1XVK3dk8b9u4LLRx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nrAfmW7WqlkmhZmn/lyn8ILkhOZHDeLEwQQAuoc9C8=;
 b=pak4wTlzqy5vwvKIusM4ViCYBSSSDpmCVeYIe6/BkGhMRkR+WVOJqMNH2/359DowOfv/xngtEkt33AaEC7uau3vGxqecitoPwjZg10hi9LIfWrj8VNKErLwesOImAUsJxb8LTvwbBzpNAKdJmAf6RAwl0PyYNqSlZuXPwnfJUxg7s2PV4zQ0FOnZACrNPAwfI4kSxJ8hE1pCOqq41wkbANImey/NXRdhBRD5ksKRceAejCiOeSyhjE5kPVbM9pLWtx91kDUr0PKK8DWdmDpqE4ZC2xvaqvBLr60365tKRaEEcxXaGnKHxNU0Nze18e477Pl4wT2vFokJFJmxjuzFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nrAfmW7WqlkmhZmn/lyn8ILkhOZHDeLEwQQAuoc9C8=;
 b=pLAKnjOoQ5vsUGy0NRXa3p2LtAfLRcW0lvE7TJnW8s6dNi3P32Mm9o3q28z2PyIJRi4ARv89DChxWVurE1Jkj9nh8rZpFQDbugUrT50palVzjdJzngiEgFwBiIicKaneEWhu6ZWFCQAq889XJD8ReCysFYZCHiQ4fN7rqjXrzJenww4AXIinVH3SwbbTkz40Fau5DZwAPdwKT3wj2rl/f0fp6bX/vGeeRSV5CiVspQrDw8zKicTYzm0z5LI/AfnQl5owOi836Dw4JKvfT58ZlM3qPusMbqvdJvkRJC8cv8mSWhBWZoE6sSi+oyAoyk2lpDrxJF9ApGL+Yq6LD7qm8g==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:31:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:31:19 +0000
Date: Tue, 16 Jun 2026 18:31:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: syzbot <syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com>,
	kuniyu@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 fib_rules_lookup
Message-ID: <20260616153110.GA876739@shredder>
References: <6a315824.b0403584.28d0ff.0000.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a315824.b0403584.28d0ff.0000.GAE@google.com>
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a01854a-8bf7-4a9c-e1a5-08decbbc5054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|11063799006|3023799007|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LmCgAwBcUOCqs7xMMw6ePh/KuIbYsjz3s8Qn6ILq+hMzSgpWuMksjRUpH54542oWRVdLvC8WrNXKVAcJVz/kORnxUrRkMeIy/k6ikK5ks5Fr1Rr6mTaxw5DXs4v65SyPOrkBhYhrabz5szbhrOIXp+OA1TPYUjKIJVPALEf36l3Rp0jAvNrVbYPsG03tCgRAffeLrAo4WoQzUycmh81j5PW1PwWb8b0wlmFHXiJIQBaTKscZzA6iKJ0rE4iCM6H1XaeAF7AvBHSsStNEq7zhCk8pbHBbtNX59wBkC7MIWn6k1/Zsa0CDpD8McLMq7pk9430aeZqnZ8nvjGJeHHCJV0mTo6BTeSEs2LWHAz8TgB1uyl2R6wj6FoLWM0VRn3t78NmvptPgXtGz8ojrrDS55M41W0OHSL18sUoTjjfPHL9pkUKBh8yxlfDuMbr67lSgQIvh7eRVfn13I4GYdPzFB+UJgjXW0UKYSfEjs2b9cmH4ZEui9T2VRgINE/LyKzrRggw3Fvi6QOozq1PkCA5Q4Huqz+p4s7s5ZORd71AxFRX5gVbTcfZL1dVmLjsx04r5AXz6xhU3ikI86NJVRX3Rof3HCr2SrXtCQ81wTtEOsu67DwbIYgOr0Mh5HF0Nf59/DLxUjVxBtz/XXc+TZEYjim1Qmabri+y2g1B4v1e/BzXivaQ+Ng6z1YvUPhqsGOBg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(3023799007)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RIZYY0uIa6bdLzpCWAkBVWq6hVR5wsk2bHJZol0cgf7YliEIfckZP5stMQf5?=
 =?us-ascii?Q?bLhDlmJtq8sI2DaE9tWfc10uu7hk87YMOSOzMkuwK4exXKeR1tgQnwAOEwcx?=
 =?us-ascii?Q?KKRe1xd2p7NhBBgWdZXSM1g5Wo+3bG+9y8aUtpiUROYYmZtAUxKt/MGL+QNN?=
 =?us-ascii?Q?HYX9ft8hMuIDEXpkcZRsvrjFvD6gujCI9rI8mYvVwlozOJKtErCNzFkQudRl?=
 =?us-ascii?Q?Vpb/Wkzc5tVtzztL9wtXR93I1XP0jzm49hSmAi3zpkC2vfIqVBlO0Z97H0nD?=
 =?us-ascii?Q?zCa7RROZTHgR/niTfKqn1eJW4gaqMSvge3bxw2U5pfFNZUgItZbEBZBDFlTt?=
 =?us-ascii?Q?wuGm+yLuGVlzdh7YER1ti0QvrrTQhCd9GS2dReWM9dAOECXVK4tqmlZiZbHX?=
 =?us-ascii?Q?i3W1p8MUBUWUtm4/E2f+tRgM39GIZaNfM/v81vAdwxwfvP9HBWjQ1DC2lI8Y?=
 =?us-ascii?Q?1gxgKTBjlMKoxmVsG3bwJLe9MsKaayUL9YWmxpC8IJwf7cFMeCuroA3KK74v?=
 =?us-ascii?Q?nC6XSsO5UAQL9FzVGpsE+F3P5m2T1d75SIDvg3xHebsNDcm1nj3I02yao4tD?=
 =?us-ascii?Q?uj4RaMdYvftrYCXGSO11U42PaKLiDguptop2f0ej20k6cv0wLTuGQylq6ZMF?=
 =?us-ascii?Q?QT4IEc7x0oW1ZCRHr8tXTDRXIGWlR1F1t5ZUBQl36raCm6cqAwfbXppYU7vb?=
 =?us-ascii?Q?YiGpTQWj4HJmcfT23tjHH9PKPfDVmaeecwitbmKkUscTt1qpt+ja7BESkaEW?=
 =?us-ascii?Q?GfaBfmQE5/RTNepLMuHvPkBPa6naP9wDkbqHEFM2F2rw8BfsGQfRVuWJShbc?=
 =?us-ascii?Q?bYgHlIwSpcIUsEzFxxE6TrOK0O+egoslRvi9dd0wDW8GHSvTup1NXzQuoOwX?=
 =?us-ascii?Q?dFQ/IU2dPEEuGduSJUfych6bgtjBhCYjXpYU/mb2Ybm5hQe6NBtqHk02DNs1?=
 =?us-ascii?Q?G9HuazMAHqD1lGdG5xqJW/oVABkJlMzPJmAqaq95aYojXM/wvBpg6DH3r7Sr?=
 =?us-ascii?Q?TjFlGubWVN2TWwL3iUbohR+gP+ZBZiEsrY1ax3j/V+YBse5DOlbqBNZpyZWD?=
 =?us-ascii?Q?rTUsifpT1czslBxSNQS3bY4810qYrfLKddgKT4nSfbKGBKYD1SO/85dIymHi?=
 =?us-ascii?Q?Z9y39eGAb/lZrvWyplYn1pPZ+n9Xr2lwr8LAWlc+MYeXcWls1yFl+i4JiuKY?=
 =?us-ascii?Q?1Pr1Q5H3zwqxpPt0Nhdj/Z4Fl0TJAgmDoRa6azK6cW9Uc/lljc8zUpNxn17d?=
 =?us-ascii?Q?ZwYgl9lr6g665GVOThGWbfWubcxxZHR7DOEcRQEVZA8nzDLTzGnRRhEhGBsj?=
 =?us-ascii?Q?6LV0YPPDV/TRH+bVJxpfN9qK0SUEACz3eZBnH7XzfIAxRWUH/6HlpIaHVR50?=
 =?us-ascii?Q?0v6hmRiC7U/ORHAsRbEkw6jpLHV9MH0+kWjQSwdwFSjEKeoodZneeq0/kPdz?=
 =?us-ascii?Q?asrznZ97c1tv/CqoN9YAY9XyQl7uXYMUw1Q7Anc4uFqL7eyjFm9CJQc+jr6M?=
 =?us-ascii?Q?sIHqCzPaFHxrzHe7C5v/7oG8vNSd2zhUosjOSEjogFvH+pS77179sVIpti0h?=
 =?us-ascii?Q?+C6LmgO8IMB/Xz0cdl4+sPm7nQaFx0hdaLxtKdY4gkboYFu8/LcfuzQ9KqIX?=
 =?us-ascii?Q?6NvC/3fvDr8gLELtS1dPkZGEunkq2ElWBDE9nW6ePI/bB7tU/EX80y5OWpOP?=
 =?us-ascii?Q?W9vY9mbd3EOxJOr4M7cfIBQMIY4ZmHS05pyFufDhg4PgGDDc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a01854a-8bf7-4a9c-e1a5-08decbbc5054
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:31:19.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEMTGaR1pkWcpyfzW8avyJJ3IlNe25ChfAjSNi8/t+Ngq23Y6MMMJ9ni4jZbFa1QsAwiSoUzb0EUmOfFI65/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299890-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,storage.googleapis.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,Nvidia.com:dkim,goo.gl:url,googlegroups.com:email];
	FORGED_RECIPIENTS(0.00)[m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 715AB6913DB

On Tue, Jun 16, 2026 at 07:05:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    72dfa4700f78 net: dsa: sja1105: fix lastused timestamp in ..

This includes commit 759923cf03b0 ("ipv4: fib: Convert
fib_net_exit_batch() to ->exit_rtnl().") that moved ip_fib_net_exit()
(and therefore fib4_rules_exit()) earlier in the netns dismantle path.

Kuniyuki, can you please take a look?

You can use this to reproduce:

#!/bin/bash

while true; do
	ip netns add ns1
	ip -n ns1 link set dev lo up
	ip -n ns1 address add 192.0.2.1/24 dev lo
	ip -n ns1 link add name dummy1 up type dummy
	ip -n ns1 address add 198.51.100.1/24 dev dummy1
	ip -n ns1 rule add ipproto tcp sport 12345 table 12345
	ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198.51.100.2 peer_port 54321
	ip netns del ns1
done

Thanks

> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15794bd2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8
> dashboard link: https://syzkaller.appspot.com/bug?extid=965506b59a2de0b6905c
> compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d4e16f50a97c/disk-72dfa470.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6cd4a736e796/vmlinux-72dfa470.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/548b0011c8e8/bzImage-72dfa470.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
> 
> bond0 (unregistering): Released all slaves
> bond1 (unregistering): Released all slaves
> bond2 (unregistering): (slave dummy0): Releasing active interface
> bond2 (unregistering): Released all slaves
> ==================================================================
> BUG: KASAN: slab-use-after-free in fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
> Read of size 8 at addr ffff88804ec4c680 by task kworker/u8:21/12641
> 
> CPU: 0 UID: 0 PID: 12641 Comm: kworker/u8:21 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>  print_report+0x58/0x70 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
>  __fib_lookup+0x106/0x210 net/ipv4/fib_rules.c:96
>  ip_route_output_key_hash_rcu+0x294/0x2720 net/ipv4/route.c:2811
>  ip_route_output_key_hash+0x18d/0x2a0 net/ipv4/route.c:2702
>  __ip_route_output_key include/net/route.h:169 [inline]
>  ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2929
>  ip4_datagram_release_cb+0x89d/0xbe0 net/ipv4/datagram.c:118
>  release_sock+0x206/0x260 net/core/sock.c:3861
>  inet_shutdown+0x2b1/0x390 net/ipv4/af_inet.c:950
>  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>  fou_release net/ipv4/fou_core.c:562 [inline]
>  fou_exit_net+0x17d/0x1f0 net/ipv4/fou_core.c:1230
>  ops_exit_list net/core/net_namespace.c:199 [inline]
>  ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
>  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
>  kthread+0x389/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Allocated by task 19121:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5296 [inline]
>  __kmalloc_node_track_caller_noprof+0x4d7/0x7b0 mm/slub.c:5408
>  kmemdup_noprof+0x2b/0x70 mm/util.c:138
>  kmemdup_noprof include/linux/fortify-string.h:763 [inline]
>  fib_rules_register+0x2f/0x400 net/core/fib_rules.c:170
>  fib4_rules_init+0x21/0x160 net/ipv4/fib_rules.c:508
>  ip_fib_net_init net/ipv4/fib_frontend.c:1578 [inline]
>  fib_net_init+0x17a/0x3e0 net/ipv4/fib_frontend.c:1628
>  ops_init+0x35d/0x5d0 net/core/net_namespace.c:137
>  setup_net+0x118/0x350 net/core/net_namespace.c:446
>  copy_net_ns+0x4f9/0x720 net/core/net_namespace.c:579
>  create_new_namespaces+0x3f0/0x6b0 kernel/nsproxy.c:132
>  unshare_nsproxy_namespaces+0x149/0x190 kernel/nsproxy.c:234
>  ksys_unshare+0x57d/0xa00 kernel/fork.c:3242
>  __do_sys_unshare kernel/fork.c:3316 [inline]
>  __se_sys_unshare kernel/fork.c:3314 [inline]
>  __x64_sys_unshare+0x38/0x50 kernel/fork.c:3314
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 12641:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2689 [inline]
>  __rcu_free_sheaf_prepare+0x12d/0x2a0 mm/slub.c:2940
>  rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
>  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
>  handle_softirqs+0x225/0x840 kernel/softirq.c:622
>  do_softirq+0x76/0xd0 kernel/softirq.c:523
>  __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
>  unregister_netdevice_many_notify+0x1874/0x2150 net/core/dev.c:12445
>  ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
>  ops_undo_list+0x391/0x8d0 net/core/net_namespace.c:248
>  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
>  kthread+0x389/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> The buggy address belongs to the object at ffff88804ec4c600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 128 bytes inside of
>  freed 192-byte region [ffff88804ec4c600, ffff88804ec4c6c0)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ec4c
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88813fe163c0 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 13856, tgid 13853 (syz.3.2144), ts 351172300879, free_ts 351133053454
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
>  prep_new_page mm/page_alloc.c:1861 [inline]
>  get_page_from_freelist+0x24ae/0x2530 mm/page_alloc.c:3941
>  __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
>  alloc_slab_page mm/slub.c:3278 [inline]
>  allocate_slab+0x77/0x660 mm/slub.c:3467
>  new_slab mm/slub.c:3525 [inline]
>  refill_objects+0x336/0x3d0 mm/slub.c:7272
>  refill_sheaf mm/slub.c:2816 [inline]
>  __pcs_replace_empty_main+0x320/0x720 mm/slub.c:4652
>  alloc_from_pcs mm/slub.c:4750 [inline]
>  slab_alloc_node mm/slub.c:4884 [inline]
>  __do_kmalloc_node mm/slub.c:5295 [inline]
>  __kmalloc_noprof+0x464/0x750 mm/slub.c:5308
>  kmalloc_noprof include/linux/slab.h:954 [inline]
>  kzalloc_noprof include/linux/slab.h:1188 [inline]
>  new_dir fs/proc/proc_sysctl.c:966 [inline]
>  get_subdir fs/proc/proc_sysctl.c:1010 [inline]
>  sysctl_mkdir_p fs/proc/proc_sysctl.c:1320 [inline]
>  __register_sysctl_table+0xc02/0x1370 fs/proc/proc_sysctl.c:1395
>  neigh_sysctl_register+0x9b1/0xa90 net/core/neighbour.c:3915
>  addrconf_sysctl_register+0xb3/0x1c0 net/ipv6/addrconf.c:7396
>  ipv6_add_dev+0xd26/0x13a0 net/ipv6/addrconf.c:460
>  addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3679
>  notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
>  call_netdevice_notifiers net/core/dev.c:2302 [inline]
>  register_netdevice+0x18db/0x1f00 net/core/dev.c:11474
>  macsec_newlink+0x706/0x1200 drivers/net/macsec.c:4218
>  rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3905
> page last free pid 12657 tgid 12657 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  __free_pages_prepare mm/page_alloc.c:1397 [inline]
>  __free_frozen_pages+0xc0d/0xd20 mm/page_alloc.c:2938
>  __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
>  tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
>  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
>  handle_softirqs+0x225/0x840 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> 
> Memory state around the buggy address:
>  ffff88804ec4c580: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88804ec4c600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88804ec4c680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                    ^
>  ffff88804ec4c700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88804ec4c780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


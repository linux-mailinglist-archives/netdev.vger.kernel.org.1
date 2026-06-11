Return-Path: <netdev+bounces-298184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SmQrG63ZKmpTyAMAu9opvQ
	(envelope-from <netdev+bounces-298184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:52:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F5673363
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qvPGqynw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298184-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBECD34D4D38
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551E3939D7;
	Thu, 11 Jun 2026 15:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97A2D593E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:47:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192857; cv=fail; b=mp4PAWu4hbRZbK3RBgeScsIjDJClmzjsZcdhsHSIa5ePgQqgZlibZR5g6DTfZrkN368ytDbwaEDXO9wYu0GKbONqW2Ds1Dv/VOIqQ33NpZKiIqhxNBNYKZFgvKIlsgFo5YP/NsSu8xJvaCUAXSnsSllqMNptjdRTK9hvysW1mP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192857; c=relaxed/simple;
	bh=7QXewm78Tstp+9cdZNGoLUHYbxd8JycOKudeqsGeLB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoAxinjPuB+B1Tc7F8/ERAXEAjI0+mAgYzxgxljGLF9aO5fVve6paHr8eb6+gseaXetf87fOM2jLMuf7+dgYpyaBFbGkq0O0HWpPQ9/f+tC4HQg/PPBgiWJnxMEOpVune6g14Knn+OS4Aj6/Jz9cCke/wssaQoPiI2qKlCTwrQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qvPGqynw; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxubdhoWw0H+oJWYxsMF9lSj8cNwp4LK3GNq2TvF/ZUN2O2MSYfTnnc/avGGFEHHy9jesWHXXmGINh4m/0G8nZ3BME6XhsZcd6RTR19EAvc+5LAnuMX7NWEhnl/K6Q1JI3gk8OSRiXRxX/xgGXHwv1az9BHgOzEfVAxK4n9tFoSUWJ2K4JBhB46C9jUsOxKoiXacmeXf7AYn4zpU+ovxFQ3B16ucvbjFjhNZ5AM1EU2iBxHPWY9ENquG/hP1IMhIdXq5JsEC4CMeEDxRkjAWEBeDrzGUbTKLTpM+xem3ObWA0TybZA3il9bXQ77Ihs9H0ncS7fjL7z121TIVrh3ofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IINMGwiY45dl0CpufeX+PmSnNBD00oEsfd4f3IEZ+os=;
 b=T/hWxRlbuPkfHtXEVCkdsE9FHC+oLpOYCVvpphvY4uHXPRT7OGzohO/U4DVv/oIX3o/RH4vs0aa3K58vGpCLlWaBx2ov/rJdyL1jBN/UifasoOBFLxIFlbwcSz9h4U4c+QaaVw1g/Eh4aw8cScP0Nvqw7M7Nve9QPgRfwQL6BcLvsnqvo+OEb4Kq+tYwkEVY3TLsvbA07/zMp0Hq0NUuCSMNoTBv4WhTzoo2i0mHK9q0eGE2YLXjZswtZ6jIUjTkLkdhY4kmZ1I1QLOH2WDJzo8Uq6kc/SL8vl1v7pZK6/RPoIFQL6SgD053V7nPJPt6Sv8XUXpN6u07Al8/CwOFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IINMGwiY45dl0CpufeX+PmSnNBD00oEsfd4f3IEZ+os=;
 b=qvPGqynwX5Fn5/XgMKUt9DeSUl2lSmEnUEBbxOnP9+771leBUdbOQKpW8BrrCq5nzj8zahVWR68Zs2qBjikQtoCUhu0cBcLDDaf8ZReJNsGLwQZikhp5loycZnJFBlv/Y0YGeXkRLasiHfaWLbOg0PUvcNxrOs/gBUWildbKl70pdbG+B06cF1kgzK4tLYm1aXRmZ0DfbgAW/95+cuVnTc26ews2oAElBzKS4ktkUVw6ySvql2q2E/9Py2RWTq04tUVuE2X0/Q7ZeIT+SGsYSXFsa5iJ9FLEhCmoic/FAjh0hfzSfEV/gWvnKOx0vNF2rNmFHBcH1WBDqPVjOx/3dA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:47:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 15:47:27 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 3/3] selftests: fib_tests: Add test cases for route lookup with oif
Date: Thu, 11 Jun 2026 18:46:05 +0300
Message-ID: <20260611154605.992528-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611154605.992528-1-idosch@nvidia.com>
References: <20260611154605.992528-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: da8c1a13-2c70-4a74-b5e8-08dec7d0bcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|3023799007|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XFgjnLAMlzBTjoF58ubsNjcg9MlwkyxPmQdaZczQ1ZZCXI1I1Yg5GwpvuapkdyyaKZMhIkVtSQzaHNLfvJQ7j0/1QqO+bHyQaha3iD3VE6IdlKwXLAWnmxs7gBgrqecx5Bgqf4ZdXLhLYaJjPdak35r7NTo8X7M99pT20FIbwl2KVMTOP1UyBZ/Qq2jBQJRqnE+MXxICYkHVgZXS+AIU8inspDCCQEca1nwQeAR+Yspi9SKcxo6hRJwkPa+gF8gPPFs9PoWyTlX0kpDuZynDZjaea63ECHGWFER++MA5EJCWWaoBfeiOpQHBY89ShJgoeLCs8jXnz0Fy6cPzSRIum/1dPET1P3x7goaOPxpSGFMZtoqfDZwriJi3gPaqj3oHsihozQrCa+uCu1qqtOau4Hpl+BiJ3rSUiMtg7yrXtfJxOc529vKW8mJbg3d6AyODusHmfqBJxRV2PmLPmer24FyfGgLzKYZKmvVNRfG/qH+XvoH8bOecACGfhOuTN8gAkf3zGwHZusY/R4c4Ehlo463Wp3Q0T5MuNkQgjqYKW9Bn5O3O5LHJpcGImN9KEQF+fanXgLXNID1rz9XTIJkE/gwtKxd5dUVCa2u8ait6ktEx31p8Xv3YfZaF8+fOcVDyYAeM5fgFHR1nSDcN7uzHO/nsRadFhRzZK9fR+zO3b2QToyiHRAo3Y3G5aqVGZFhS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79wMTonTGNX6SPjA+VcGe9QOz7SH/JQNSnZCglqCkzg3aylm2Uo+7Jfpu4bx?=
 =?us-ascii?Q?QUjmxxkwxTl5CHQHjesiZ7/wa0QJpdusDDbltWPegYcl4x1bUp0NwFxn9pGk?=
 =?us-ascii?Q?65iKoL9aGfE0X6qvDDgHhh8FNSs02eQviArwdm1PqZ1j1kbg9NzjNiiHytOt?=
 =?us-ascii?Q?mcQO8NbvoOJqDIXn03qiB4iCZFBdz32U+lNa0CA0DnO4wRPqOAszYvzSjbCX?=
 =?us-ascii?Q?8Wen/VgV789D+YDHj7yHVCIZsbpfbpZ7wT7Tqkc2pk35T/chyQeyPwhpcSFp?=
 =?us-ascii?Q?ovNKW3fplMnyrwDcmjYhnl0TtkLxAkT7+EP6FgTw41NEmHFkmalhJl47kRPV?=
 =?us-ascii?Q?Om5wOhjnzFPASnISUEnV4DK0/Rh/hFZyjkx8G9t8qRSGAnmwwzo0VBvqSoLh?=
 =?us-ascii?Q?ZpzCf0Ehd6jZBpZK6UYwST5stFIF+lH42hn4HpmvfS2kvWHFYZ96iItK/guM?=
 =?us-ascii?Q?REvcBkO0yn2LQFuBjCUdwoev27olAUm/stGH5s/12J+n0wZlIMV0al+HOERz?=
 =?us-ascii?Q?+Jem3wBuwI10+P2RNr+X2QGpkST5H96mqc6YWehDaXXds4/GrHUjoXWvy1Xt?=
 =?us-ascii?Q?mpRnCq3tE6de4Cl6UW/LEDt1QuFA+BkYVbOFQKlSCwyVG5hL7XRB9ohdHncp?=
 =?us-ascii?Q?y1cz4oGnaFqq6upGMqxG1YzdvD94RqWr8JtF2f+iuz9GN3IbZzHY2/5qYh+5?=
 =?us-ascii?Q?67WrGOzbmzoiHk+GcWGZrXyHO49wT5BOM4m7FgvBTAke7xi/EyuiuKrPfg7s?=
 =?us-ascii?Q?9vxw+f6FXOma9lN/korMDAnNBvCgK13EbvCTApEn38Jfc+CBytNPk5/pfjk9?=
 =?us-ascii?Q?unDJIBLkI73u9CUs1LttAqxPY5YE0KBzkRHO64sP4pedfJIX+7nU/Dk+1gNf?=
 =?us-ascii?Q?ReSQsphx4XjcA3kmasUfvb9hmcEcgnbPUxMCqmJoiP6il0UWofVDCR5SnUr9?=
 =?us-ascii?Q?zMo2+FhdjLp3uDVhV/roTrAdy3JGeDgXHryLtuWvrJnqGkKV4OU7eQyWPH0i?=
 =?us-ascii?Q?3LsiUXhHsRBamH0mplHzUk7xL8WWjWR2UsW7NZurBFE6KTvJEF9iXU8aSBE7?=
 =?us-ascii?Q?pPxiCKxYSoyJGF3F8erEeQnIYCH31MCUBtkRX7RTFZQFMKDEJs4SkrzBDDuG?=
 =?us-ascii?Q?A0g46aCs347fDq+S9bWYSYTI2rkO4+xXnWF32Zc/kNqWnSYejaMPgISH4yQn?=
 =?us-ascii?Q?GRNDi9E9H+nzXUkKuHCA1wkByjpfxY//z8YPoPFWaN4jFkdbTHayl0Ars8vI?=
 =?us-ascii?Q?Yw9Ax2kYWEexnmwJLoZbxrINa9HVtnbAOMOCG7o0LfVzh6VntIe5LwkTQQXR?=
 =?us-ascii?Q?14lTKiop2SxrHp+SJobv8X2nADRdnqd2DT/qJNU/0Bvcj4wz8dc/URPVm1zM?=
 =?us-ascii?Q?1R8MjR8YDLL8AAgnmJxzQk+FhfJtxu6NytDbdhuTcJGec6bJbvvMpa9KUBd8?=
 =?us-ascii?Q?aCuZFiwjTRwEmCSSytXldJ9ABVlog163BxshgfMXyTXbK/1ldIFALAa5dGTH?=
 =?us-ascii?Q?P/F8lphjxEYKSWqH/V9BHQf1FZbPNVLAVM46LbXn74d7oeT973C/Y3bYuNCq?=
 =?us-ascii?Q?/UiGde0WpCzKJ89Ie+k6fje9uk4VghYSuafP1uPP5Yg++R46D3hbfK2gbFPq?=
 =?us-ascii?Q?/tChV723dMUTX+CwMFQ2s2UbETWfYoboIHObWwqGl/VjxTdqKyA16r5FLfM+?=
 =?us-ascii?Q?T1fVcACpzJl50XgG5Wjoyf4eRCtos/8D/tqDAtYnvmj6k4Px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8c1a13-2c70-4a74-b5e8-08dec7d0bcee
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:47:27.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw1iBhFpU0tA7Tp9/svkvgo/PSLrBUerm1787FzUbcOosSFZiqwn4eYqjeop1N1MzXFiaQokuWOugV0RQGOBBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298184-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:willemb@google.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC5F5673363

Test that both address families respect the oif parameter when a
matching multipath route is found, regardless of the presence of a
source address.

Output without "ipv6: Select best matching nexthop object in
fib6_table_lookup()" and "ipv6: Honor oif when choosing nexthop for
locally generated traffic":

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_nh ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with nexthop object test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with VRF test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 IPv6 multipath oif with nexthop object test
     TEST: IPv6 multipath via first nexthop                              [FAIL]
     TEST: IPv6 multipath via second nexthop                             [FAIL]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 IPv6 multipath oif with VRF test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 Tests passed:  16
 Tests failed:   8

Output with the patches:

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_nh ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with nexthop object test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with VRF test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif with nexthop object test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif with VRF test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 Tests passed:  24
 Tests failed:   0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_tests.sh | 251 ++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 8f10de0eb985..b338bfb196a2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,9 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       ipv4_mpath_balance_preferred fib6_ra_to_static fib6_temp_addr_renewal"
+       ipv4_mpath_balance_preferred ipv4_mpath_oif ipv4_mpath_oif_nh \
+       ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf \
+       fib6_ra_to_static fib6_temp_addr_renewal"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2971,6 +2973,247 @@ ipv6_mpath_balance_test()
 	forwarding_cleanup
 }
 
+ipv4_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 203.0.113.${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv4_mpath_oif_test()
+{
+	echo
+	echo "IPv4 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev lo
+
+	$IP route add 203.0.113.0/24 \
+		nexthop via 198.51.100.2 dev dummy0 \
+		nexthop via 192.0.2.2 dev dummy1
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv4_mpath_oif_nh_test()
+{
+	echo
+	echo "IPv4 multipath oif with nexthop object test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev lo
+
+	$IP nexthop add id 1 via 198.51.100.2 dev dummy0
+	$IP nexthop add id 2 via 192.0.2.2 dev dummy1
+	$IP nexthop add id 3 group 1/2
+	$IP route add 203.0.113.0/24 nhid 3
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv4_mpath_oif_vrf_test()
+{
+	echo
+	echo "IPv4 multipath oif with VRF test"
+
+	setup
+
+	set -e
+	$IP -4 rule add pref 32765 table local
+	$IP -4 rule del pref 0
+	$IP link add name vrf-123 up type vrf table 123
+	$IP link set dev dummy0 master vrf-123
+	$IP link add dummy1 up master vrf-123 type dummy
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev vrf-123
+
+	$IP route add 203.0.113.0/24 vrf vrf-123 \
+		nexthop via 198.51.100.2 dev dummy0 \
+		nexthop via 192.0.2.2 dev dummy1
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 2001:db8:10::${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv6_mpath_oif_test()
+{
+	echo
+	echo "IPv6 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev lo
+
+	$IP route add 2001:db8:10::/64 \
+		nexthop via 2001:db8:1::2 dev dummy0 \
+		nexthop via 2001:db8:2::2 dev dummy1
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_nh_test()
+{
+	echo
+	echo "IPv6 multipath oif with nexthop object test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev lo
+
+	$IP nexthop add id 1 via 2001:db8:1::2 dev dummy0
+	$IP nexthop add id 2 via 2001:db8:2::2 dev dummy1
+	$IP nexthop add id 3 group 1/2
+	$IP route add 2001:db8:10::/64 nhid 3
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_vrf_test()
+{
+	echo
+	echo "IPv6 multipath oif with VRF test"
+
+	setup
+
+	set -e
+	$NS_EXEC sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
+	$IP -6 rule add pref 32765 table local
+	$IP -6 rule del pref 0
+	$IP link add name vrf-123 up type vrf table 123
+	$IP link set dev dummy0 master vrf-123
+	$IP link add dummy1 up master vrf-123 type dummy
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev vrf-123
+
+	$IP route add 2001:db8:10::/64 vrf vrf-123 \
+		nexthop via 2001:db8:1::2 dev dummy0 \
+		nexthop via 2001:db8:2::2 dev dummy1
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
 ################################################################################
 # usage
 
@@ -3057,6 +3300,12 @@ do
 	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
+	ipv4_mpath_oif)			ipv4_mpath_oif_test;;
+	ipv4_mpath_oif_nh)		ipv4_mpath_oif_nh_test;;
+	ipv4_mpath_oif_vrf)		ipv4_mpath_oif_vrf_test;;
+	ipv6_mpath_oif)			ipv6_mpath_oif_test;;
+	ipv6_mpath_oif_nh)		ipv6_mpath_oif_nh_test;;
+	ipv6_mpath_oif_vrf)		ipv6_mpath_oif_vrf_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
 	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
 
-- 
2.54.0



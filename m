Return-Path: <netdev+bounces-264794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHDXAFjZqmnmXgEAu9opvQ
	(envelope-from <netdev+bounces-264794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53412221E91
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F84F3132D21
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A123988EC;
	Fri,  6 Mar 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfyJt3jd"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748A396B91;
	Fri,  6 Mar 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803668; cv=fail; b=H5IiXfTpEdBifHVOF8RWGrApKajAi5wU0ecDhF3niMKdU1jvp4vlid5Zpq/cWeIrfrtxwgrD4+/juDQBLz6FaEvXsn29Oh2NUhQ3zpg/PiPNPIuGzDQ0P6EiDE+R3KWm+PyUfQjREpNZg6j3a+QafhKaab+kL/78cqro3K0OxHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803668; c=relaxed/simple;
	bh=2p59o7wPo9VQhl9LoN9iASI63nmAkKTfbExtcgSvAyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbb2PGbWCZ5oIX0rUbCi9CRW1u4i6neJMRf3pKrg/g/ouEuY+F5kz2Kj3Z6NJloXwQl9qPxcEJEOV0wINc7maLqSIR02G+vh9cNe88o8cr5Jl8htNRTGUOV+3BBdF8et+UIgRtoPTFLPC8qq+d4vEz6/W4d49n8UOYOoNXzhK1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfyJt3jd; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRL7EFOv1fjBiVGcVGJlvBYoD+C+F5WkNxDROVA9a/XEmcvOdyGHWFt/miWC7pbLK3yDmt5CjZxV5MMdATqvKe42uxfNHrTZlSUobU78idVhoIGe0sc1fCsfuy17WjNqIUG9/O9vbkWX2AqWTnqRA/g5/fT5XrlmcvZsBqG1BdsMfyWiA/CXBGHSlA2RrgNyZ0uR3PjAGocYStuR2U+kDqlKCaJXiKiKAblNTQZ+IfejHtLXaGjH1aVSrg6NxBic1Yv94bD6iXXMXBV7tv5gaPfie9sY7H/1x6NF94R0XI9ttAnIUoMw9exfDNqIczEE7arREKOBS2h26aXIYGffXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dioA5g4/dxZEzgv4s8M3w+Z/sJ7dL6C8+iBVcEinOPs=;
 b=KbgRrIhGvIHVvRPpDMG5atOfzx8xXGmLdCBjUBQxbSBbiHo4jOfHizbg+XJzz5F56oMGcva186VvoaODk+UhqAFxyj+bcigN+GIDeTVdB42gqlDkNf2eDTk4D08KbFwDOnxGaiAb/U0tyQ6lJqXSQy1/Mb8Mw83ojhHg2jqBHW8Bx+WSHEHkhPic3/OGvBz7TA/SNuUihJs6clQkZt3XZe/nFAaX+HI23StkeySBvP5U2Rk/B/5CwJo54/ueFDbHj3COxK/5nbO/1/FDugZY4Ylsh4/U8uU0epOXKZvnIaXhJrz31eCf2LhZZpjQNDM7Evci78WzLDcTqbWDYaq2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dioA5g4/dxZEzgv4s8M3w+Z/sJ7dL6C8+iBVcEinOPs=;
 b=cfyJt3jd8QUCWmg/d5lkjL0WYTSbMJJoNVnzT+g8SqysuMCMStG6s43DAHJ2J67ouFT81KdmzdkdsFhQt647t1QhfVHowA1ijNXr6OiWEcrt/D5/kH25sOL2ve6BA6drAwGtEM7YDDweCg1DztZndqiHfpfLWyVLjx2HA95mVjBaGrc5TrppeusE/Rqf5Pb6smzheUBtyuIkgPWXc2HY1xKNECqhk+VuDWVyLuGqWfa/YyKHtpgoY55krYHIoBez2S+IzJ7r9kdgnCjme80X8+TxTQxnYwsqN7I6FuMAxzNbZlUf9CqvSZ+hdwp8fN61h1/ZfsZcw5193xeDc80S6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 13:27:42 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 13:27:42 +0000
Date: Fri, 6 Mar 2026 15:27:32 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Nir Dotan <nird@mellanox.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: net: forwarding: fix IPv6 address leak in
 cleanup
Message-ID: <20260306132732.GA1477080@shredder>
References: <20260305211000.515301-1-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305211000.515301-1-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d13ba-469b-4891-f3bf-08de7b8424e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	OC3NY5mSPN3G1RlPuhfBXYQWyAOiI8jfKlJiKq9NBvCmOE5NUwEs/65raYPlrtu/FTUEnqs3QTa95Wmr90VOK72nr4KOxIAjbH9At1jS94AoFhhDSpAS30er6UTfBlSUCQ6H6d6ELCsiH2hSlFro9M9zpbIP5C711tZnFFOD0g/aYFkX2vgY+gRB4FAeQwxfNbAC55Am/If/IaxAJroHrjfE70H9G3ZkThHqyFLGquATE3S2/g6fp7hOSjiFoXa9k/dfBts/juKKTl8QIziW8rQtjoaqVdlAHz46K+B4nkNh31QkprZ2yNl4yRKsNpbH+M27TQbyOGGruFiOtknWuF6TmjJCo2UeHwSTYMJDbOZSmwKu6A7zbgmNzjZbp1rVWlX4ZLdI2Vj9nAy5TAEWsHWZWahfKngX9WXJK53bgiFVoxWyJmnk2+SEWszdfIA8ozNQnBFtFm9ELeFxZTn6mV+mz9z+1jHSWNrLMLZw1iQm5wd3VbV8qhRmqq2EoV6sLlk+CNy1X3+FOMYA2T1Gw9KVMWUY9TDZr5xZecnooAZwLNjzy6hCQgRi6EiimwjV09FCbn59IKNcnm8hY8Phjf5ugxjuK0TlsVb5PBJ8DPui6yD6WvM056e5qIchXv/HtZL4Url/V8bJih6dv3WFfRCFRkI3a2O/3OhB+vq2sx9YFuAq3eGHH8aCm2XtzCgaM4EICCbLDvlbwsJzrPGXbzaw0nkauOJhspco9QMhOns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGHq+B68Zq5t+AfD/9KKfzrPRiuqNbgVbCZj0OARFhfLihAY4Owpsg3NtVsy?=
 =?us-ascii?Q?odQdd/yjHGjyL++HvKfRaEFRIq0gSdSU+2cdHdszj4yJKVCt3bTr1dc7QK8f?=
 =?us-ascii?Q?C11Ma0d5aQuhwAF5SXk2xrw9YtjLSTYGwM0pOzwGQuTV/K5IXUBgGoSTgn6o?=
 =?us-ascii?Q?ugXj6ApqiRv2zxcpc1iIjaOB4eDzkmKpUOhzpxiaKUTMrW90i5uYEudIqyx0?=
 =?us-ascii?Q?bd0p6uDW41SiKG9TNGVdDA/4s6pdC3JsN/mpmKEoowM1tWp4Z6A3An2FBSnx?=
 =?us-ascii?Q?YY/K27SxEWhT7Pu8QBzx+pLF63psnVM5fwPg+QWD65FZLX7OMciZ1OvoRACY?=
 =?us-ascii?Q?/rweo3iKVJm8ApDFNkbzmevYx6JUVsckTaf0McFezj/A/xTtUWcrdcYEA6OL?=
 =?us-ascii?Q?qxJpDjAGQ4XzF4Itc7BsM3eR0xWdpNeDOnzlmN6jqlVjD1xp6eOs5KqwHyk9?=
 =?us-ascii?Q?6bD0BYARAJUAVY4OI36CnF0UuH7zNZDg7XcfLdNQ7uvEabBC/KhZ/TCMCQCv?=
 =?us-ascii?Q?3EvkFTS/7x/UuWIccuHZ/V4MOPwmJcczAQO+/Ne6zCSd+k0vPxGjxYhk0NJL?=
 =?us-ascii?Q?Ycr/d6L0r/ANp9Gw+COUa7QkXuX6uReINam9Lx4TNcRVjv7Bd4LOUknXI39+?=
 =?us-ascii?Q?dEbefEcH+iaIg+4FrRSYPnRS91TQ431NVL8CdNQcJ0bgIWb5si2hQG9UWeLk?=
 =?us-ascii?Q?PywfW4nTBo+Hka3DixhQbmBiIB/wzNQKdcw5kI8rekfI8z3HriaUAs58lBJ8?=
 =?us-ascii?Q?jvHbY7e6NIDavdMEFw/F+zNBrTnti1yHRi2vsqxTy2Mpt7cuIINg0WC6n6Hw?=
 =?us-ascii?Q?r3nopGPG8EUtZjCs1u35iif/dxxsN4w0nCBu5kVZ3JpvbVmk7NPTcDBP0wu/?=
 =?us-ascii?Q?PCzlWN99RgXbNGKm05Byq9XcTe0CpmfdBXOvrJvq8fQrwArL1TUpptVet8NH?=
 =?us-ascii?Q?8zIO0cBzeV4+bN3OlM98tlq4Lu3izdXvnozDQVLFKfKqv3nqrncRlXgkbamF?=
 =?us-ascii?Q?+TBkb+YcTWPpAoX+m38d0jRZbGtk4Iql53iwEZ6863aFHWGalL6+PcyP1F/6?=
 =?us-ascii?Q?1lJK03vpIyTeRmHpmJl4/Rmmt/oDJbgkubLoxO5e3TzPIIjy5ZUoMmOfxHkV?=
 =?us-ascii?Q?4lfY90PcglUmsLUwLggwr+Knffdboo04kG19mg/lMgp+APFP8NpwvW9h5AnH?=
 =?us-ascii?Q?tWT4PUX1Ac+qUYUD3VVcW/OGyq8lj1e/d0NkfttSaFo1tqtt0Gga2nGwbiVc?=
 =?us-ascii?Q?xA+FZ80eB/wL85TtaO2Qe2iDO+jLWFU+Ljw0icTXQH2nSfVN+VB7CI1Q48vI?=
 =?us-ascii?Q?4dedbJI4FhbBiDXU8uhIhmEppF+R7voVBmfIpBRodSSZBrQM/XNIssBrogVe?=
 =?us-ascii?Q?WmNvIGlgl0W4mUGssasKJ1cyLAXB4OUfWnP9WEN/1OJXSHt4ajICieyrrRTD?=
 =?us-ascii?Q?Ls0TS4cJd9CpZktPdaV1Cve2AE3u/pxVkaazCRlLQLMsyFo7zpVjuT6stCpW?=
 =?us-ascii?Q?U0aK/hshvdhSg03jIVt1d6lp/Z8/CMu8yOPWlCyQ6PKs7Ubui5hthmZrQTcO?=
 =?us-ascii?Q?Uyq8AfRd9vTjvFleIvBY/3FvfG3J/H/AI45EiwWC0hvP2fK8S9VHjM1pnG0o?=
 =?us-ascii?Q?q2oqD7DCIjcapHME8w2DoYySn4Cc6uhmdN+D05l65E3clkCBY5Gr6ksFKEkn?=
 =?us-ascii?Q?jq2+1uyRlEM2pMBBtd/A4FdosZliHfWJ1muyjM/uAAMHukoVg8xCFzlzEIJf?=
 =?us-ascii?Q?HrpUfjUmAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d13ba-469b-4891-f3bf-08de7b8424e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:27:42.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzUD6e8NdoN41LOS5vPY06TXOovGKXCqEYsI+87NPGZudz/KcypSZnbZvgvVmC7fxDS7uTxhurF0P9ezbjOWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
X-Rspamd-Queue-Id: 53412221E91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264794-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipip_lib.sh:url,gre_multipath_nh_res.sh:url,gre_multipath.sh:url,virtuozzo.com:email,min_max_mtu.sh:url,run_kselftest.sh:url,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:10:00PM +0000, Aleksei Oladko wrote:
> Several forwarding tests (e.g., gre_multipath.sh) initialize both IPv4
> and IPv6 addresses using simple_if_init, but only clean up IPv4
> in simple_if_fini. This leaves stale IPv6 addresses on the interfaces,
> which causes subsequent tests to fail when they encounter unexpected
> address configuration.
> 
> The issue can be reproduced by running tests in sequence:
>   # run_kselftest.sh -t net/forwarding:ipip_hier_gre.sh
>   # run_kselftest.sh -t net/forwarding:min_max_mtu.sh
>   TAP version 13
>   1..1
>   # timeout set to 0
>   # selftests: net/forwarding: min_max_mtu.sh
>   # TEST: ping                                                          [ OK ]
>   # TEST: ping6                                                         [ OK ]
>   # TEST: Test maximum MTU configuration                                [ OK ]
>   # TEST: Test traffic, packet size is maximum MTU                      [FAIL]
>   #       Ping6, packet size: 65487 succeeded, but should have failed
>   # TEST: Test minimum MTU configuration                                [ OK ]
>   # TEST: Test traffic, packet size is minimum MTU                      [ OK ]
>   not ok 1 selftests: net/forwarding: min_max_mtu.sh # exit=1
> 
> Fix this by removing the unused IPv6 argument from simple_if_init in
> tests that don't use IPv6 (gre_multipath.sh, ipip_lib.sh), and by
> adding the missing IPv6 argument to simple_if_fini in tests that
> use IPv6 (gre_multipath_nh.sh, gre_multipath_nh_res.sh).
> 
> Fixes: fed926d4f64c ("selftests: forwarding: Add IP tunneling lib")
> Fixes: 902280cacc03 ("selftests: forwarding: Add resilient multipath tunneling nexthop test")
> Fixes: 54818c4c4b93 ("selftests: forwarding: Test multipath tunneling")
> Fixes: e035146d6560 ("selftests: forwarding: Add multipath tunneling nexthop test")
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>


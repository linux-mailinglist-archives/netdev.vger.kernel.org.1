Return-Path: <netdev+bounces-265532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PguGgi/rmlEIgIAu9opvQ
	(envelope-from <netdev+bounces-265532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:37:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B908B238F48
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4463095319
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3B3A63EC;
	Mon,  9 Mar 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CAVz3KiW"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36233DED6;
	Mon,  9 Mar 2026 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059485; cv=fail; b=ZRh2xohpJoHRg3RsPgGwsbZRGKGFgNJLTk85dWL4hrx2hKUgd+ezLNk1+S2ewhWITMDIa+anRWOVzM4viTl5MOEiBoRmdfKZ8lGtXuheipuyqcmA59nq24MnnQSE5ntIYxEr0+HAvRuM+hqGwu+2SWmQ7LpJPKTvPd/YHBzlG/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059485; c=relaxed/simple;
	bh=yKlhKmJbzhCCU4dpITaqpoRgIETYGbLTLeboLrbC4bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDncjWyIMBUWO4iZLhSkyVssq0jILefg81u0K2IzZ+TH6GiDVidIIzEJUFTYjSLZmUwBRrm+HRUacPaMSJu35PR6pFfO9m0jjZ+472zhwUrNEOmIFYojmuS6vai8wvr2wmoWwb2z5/VEIdp95bQg5pjJNiuerR5SgCkBODnJlkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CAVz3KiW reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV6wb79foCTjLQ/1RbHJQ+jLEjdRyg5mvVxBTRqynvHBu/7502j+bV5MT+2ockUKIQTGnQ6ThEbgw86aHEaAza1A1lGsGUS040+lrzxMtsRBQIQ+J1v+Aw+WXD2OB3ORx7XEQcptjMtzlzJvAPAhgSuq+yxKBbq/70sJROxiapj7R/F+mU6EGlv4aXGF/8dJYjddciMMKpMpnr3qHF5jFkWLGx5lMSrmWmVrHLig8ch+BAz5WBxhSIud5w5aTybANrpjlaeLm2tujRNfUemiW7QinTcwUwQAv0M48p+/Rx24eaHmf3i7ek4EXkLo+EJmTjO0eH3ZxFCz2fkTNs0SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Domb6dxE5FUA8v/gR3qdCb9XPX/gt5uil8SU1RTf61w=;
 b=DgJzSFXTIPZW94+Yo4kC6JttSMwob6EJVcYxtzNldkipC4UuY8b1Pi8DCAdU2kh2m6fNpI55NLLIUNYJgiB5plDY7gzRNxMHSjps/vxS6ZjL9phXZ5Rq4pqLEigrgmtHwHbwN6n7GAIwcRp3fmA1muaTLbVLNmS0jgyKNutcadOdSBb9LVM91V7nojKu342l9qOfoQXjVk2morOZ6Gwq/cmLElsbsS/3e2NWS4ueVIHMB6Bz1R1Pms2oXFrs/iLyEHJcbXJDwhdrPrfEpEyUQGGn8kPbu7AiRMhoay9ZdVZKEhwYb+gwJAdnSDMpONIZ3UOj8dPksJ+qBhk7ARFInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Domb6dxE5FUA8v/gR3qdCb9XPX/gt5uil8SU1RTf61w=;
 b=CAVz3KiWJKfbVHjCPww5DlDcMnGzMt5/w+8Uz5fKUf5DC18qDhFESSIDmAcK5DT1v50+eLUpEdYDEZMoWZRRU1ZMXxn3sSAldWbY5iXws3XHYeN6pY7dfTsYy+O55URUB20vDt/NbwosufVY7zhusZYwyr58l5kdhJ04HhERhmAsT57VLTIGyvQdyihsdL1FmsJhFY4NrRdWMnmcyzsatzS8QTtWE0rrAeqoK3hsVIaRdd/zZ6rolfYP7VQFn3tzlJVUuwLmeWpZK35Krx23C1YBa2+NTrjA1JU/Hu6nZ4a/HeDDMuk5teZYhfWGnXWB42tICc+UgimSEUbaN94nmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 12:31:19 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 12:31:19 +0000
Date: Mon, 9 Mar 2026 14:31:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v4 03/14] net: bridge: mcast: avoid sleeping on
 bridge-down
Message-ID: <20260309123109.GA1919092@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-4-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-4-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 21461247-3a10-4174-0342-08de7dd7c3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Fd1NMnXvsHALDGZgzItvt8vKNurOCglMleiQ1ArhlZH2HnfYa3iDp7ZGhvvPVoJSJF4drBwyrg9/PvNjCdWE/MysobLq3jc48+y+U4ZOb3qMp24lVhNa2Ew9jxTRd1BeiHHfUEp8JIT1sbvQNp5RsqcfVp0eTUHvAZkHfCko2m4g/w4uLdMN1aDglt8xK/TCKmNLzw6X9GloZZQTHmnqOrPm0EoUk1PfzflWVedho6ql3Wk90Oz017mX8H+8aLICN+Uc/wCVG456n/WV3ttZsE3LuSkMAGsEiIWWHw5rXR7FpLy/ZWdXvz2R90d+Mf131TxdBo/vEam+nihrJ2uQ4dkgJvdsld3yU78GJHFDCE0OFIBUeBNLKxs50/CuXdVUOmHkteoUTHGACBzotcfcixue8gnW50R34opvcO1X+WaF/91esav36X7vckbeJi/5k51sfktdzSfiIwn8DiA4ypft4Y2gxN0KMzRwOGMb672rktKUZnsQUfKIS7tj2nSWTYyW/1/Wf1T8pHj1doym5i7aFKrFiC7grV96sL3KXrl926k8EMOSv1P4Q+9V4Z8IP7bS2ZGZUNdcNGRGLh8QDzgFsSRIalJW+GAuwlXeIc30hB8gNmwmKQwFSA6c4U5KknHU+Ve8JdKHg2fQ0AGX6M7L3CLpjN02m0V4mNJ1y5393kbLuiJhpqxZm3+K+T2hWMLHu1V1KyPB/oe2Xitce9mHyz/57Bc8j3VD18ybTY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YGA3/oDwDl8DpHrxDGFtUD9kAiCLxe66CZqLp7U5KZW10WPhOqliD3Gdsc?=
 =?iso-8859-1?Q?cfbqWeBnQjZ+AyPvBuEZpSCbFrzu7xuvPPNr0vwKw4Q8CaAUN7yvE8yEDZ?=
 =?iso-8859-1?Q?WmW+aMPvOKUeehjOgJt1PRekVsQwiRoSBhKx5f4++Jk3oXAULng1ZxThO0?=
 =?iso-8859-1?Q?07leOjjzXirlfZoW0aywVlXM8JVBcrENWRTAtu/9jmdVRzJXdQTgq5P92C?=
 =?iso-8859-1?Q?L19aD1EkraJiWVscwzyWnuM6zp1ROQNezWA5JNKh9EAcJ97lhnzLnr9Keg?=
 =?iso-8859-1?Q?Vn0P0LXWWg9qfmRWhnOALQgBoWHs+UpXclED/DTQ/irV3O68LHdMyp7D3/?=
 =?iso-8859-1?Q?VWisXNQjvwvko4KXNQ4H+bFne+dsKSpY/C6Z2fqXHIgVM51F8kCVUpRiCy?=
 =?iso-8859-1?Q?81cJIqmTVhFJA2JmZ7UQhU+/pP0X4OGmjTSA752JDwygGw9AIlrHLQn9Rg?=
 =?iso-8859-1?Q?fXKX0tX4/rvHEr7Wip/2j6JD6SYWJFaByOUxlbnOG07xTHxgxGsJVj6bc6?=
 =?iso-8859-1?Q?CNUlKrzQ1K2brYMJk+SdYvJ0vLMHGuy8vv0se5I4PDxjf5I9Q7wHFVZtXa?=
 =?iso-8859-1?Q?bG6UD/1SFFrA/tRFvoIDEwJGaCXrV5rr2CwS0Q+wmNA04Ahf/9Q8T2gr95?=
 =?iso-8859-1?Q?tstJdWXZ3bxXZvTUjL0B5Hn2Kioyy7Arxc2ga/BLBRAcolGFVmkiNHu0Pj?=
 =?iso-8859-1?Q?xGaCQFAzW2Mn/Ydzb2L3Lds/iztwjgSp4sczYOUcQiate54BKxe0VwUGTh?=
 =?iso-8859-1?Q?wTN/gZa1u2rCWLa6q8bEQm+BCoJpr549eX8bSQ/jvZsmygjw/9+Y5PfuLD?=
 =?iso-8859-1?Q?hViDfl0HZuEhAsBcDKcRfanQ/CccIuBvsfqEPcxJo3k3TJyhJRsdYS6oOV?=
 =?iso-8859-1?Q?yTWijUxDFa4CdfIfKs76wAOe/rARfaB5+YC6qQDdiAhjNsB9RnCfuYpk35?=
 =?iso-8859-1?Q?8lxAjQ+SQNgiOCvKeF41kJsNMPgRaKLnmlYqOkY/azylHzNcWbtW9vCjv8?=
 =?iso-8859-1?Q?+jDbri/x6781mHDnjNtPqkVtHAKQdDIw2DLkam2jGFeMMr2s4J4AGKQPXE?=
 =?iso-8859-1?Q?kkjQGXigMZF2x9fGXfPjTe8eJGt2FlFlcfVfIvexMOBiDnTDE5nP5aS2bB?=
 =?iso-8859-1?Q?PmMzqJhYFu4t26jLQXkilpVkK8Xrdu1vCrK26YP69yOpcE/MT7GhsYhSDn?=
 =?iso-8859-1?Q?TdOKI3TAU71Mk6jqHrmp0V/hngRVV6Q60tFiZPGCz51z3YqI2USCa9OA3G?=
 =?iso-8859-1?Q?ZJX0PcpatBI6933z2cwbkt8vNAYoB8f2gKYTmi5UnDG5DuYmLPpZKfaAg2?=
 =?iso-8859-1?Q?07E+Zr0z5VxWXAqV86/ZMpCns3XmE+mO3iMN9NBZ75maFJ1M5G0WnCQbB2?=
 =?iso-8859-1?Q?XBBpoI22wcM+l+o/1c9oN/qdMShMzCGpR8Wlbv6jUHgPrHXx11JUO+LIHo?=
 =?iso-8859-1?Q?i9LgV8C1bK1c/155PnuGGsjzNX8xvgX4Wxa7kENkxBVgaEO1JyTPLBwJf+?=
 =?iso-8859-1?Q?U2M7BSv2ObzgM5l9Iasx1ixz3/kwaU+iZ750plwJSLBfbzlNfjokAMLTEn?=
 =?iso-8859-1?Q?8BPAt5AyncptTo+mUvRhf+SBty8p6R5A1bzv5hBXdC9eMzlTmSL1pnqhJh?=
 =?iso-8859-1?Q?rzaocc6yK5ACjn5il6FjMaHylXzRADBqVRDaLsS2gyWsLg3tc2X+yA3UYz?=
 =?iso-8859-1?Q?RV4uPbtqGDcDYhY92uGXwVuIHqgu6TaAZ/Uk2JKu7yGXJoo4F1nIrHGaph?=
 =?iso-8859-1?Q?772pB72t2ba5CFqM4MIn2ivRDYHN0DpjdT19efX9IJQy3Luersc0AkNUHS?=
 =?iso-8859-1?Q?AqoGJxcf1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21461247-3a10-4174-0342-08de7dd7c3a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:31:19.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6fMB1veI2LnQKhHFtXrukzsz3Fmt+Ed3p2tNjwPU9DysuIctNXUAPHAd6aAOIrAyLjVs3lyD4qWG9HSUvu2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-Rspamd-Queue-Id: B908B238F48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265532-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.269];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:37AM +0100, Linus Lüssing wrote:
> @@ -4111,29 +4123,40 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
>  
> -	timer_setup(&brmctx->ip4_mc_router_timer,
> -		    br_ip4_multicast_local_router_expired, 0);
> -	timer_setup(&brmctx->ip4_other_query.timer,
> -		    br_ip4_multicast_querier_expired, 0);
> -	timer_setup(&brmctx->ip4_other_query.delay_timer,
> -		    br_multicast_query_delay_expired, 0);
> -	timer_setup(&brmctx->ip4_own_query.timer,
> -		    br_ip4_multicast_query_expired, 0);
> +	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
> +	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
> +	timer_setup(&brmctx->ip4_other_query.delay_timer, NULL, 0);
> +	timer_setup(&brmctx->ip4_own_query.timer, NULL, 0);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	timer_setup(&brmctx->ip6_mc_router_timer,
> -		    br_ip6_multicast_local_router_expired, 0);
> -	timer_setup(&brmctx->ip6_other_query.timer,
> -		    br_ip6_multicast_querier_expired, 0);
> -	timer_setup(&brmctx->ip6_other_query.delay_timer,
> -		    br_multicast_query_delay_expired, 0);
> -	timer_setup(&brmctx->ip6_own_query.timer,
> -		    br_ip6_multicast_query_expired, 0);
> +	timer_setup(&brmctx->ip6_mc_router_timer, NULL, 0);
> +	timer_setup(&brmctx->ip6_other_query.timer, NULL, 0);
> +	timer_setup(&brmctx->ip6_other_query.delay_timer, NULL, 0);
> +	timer_setup(&brmctx->ip6_own_query.timer, NULL, 0);
>  #endif
> +
> +	/* for non-vlan multicast timer callbacks:
> +	 * they are set on br_multicast_open() instead
> +	 */
> +	if (!vlan)
> +		return;
> +
> +	spin_lock_bh(&br->multicast_lock);
> +	br_multicast_reset_timer_cbs(&vlan->br_mcast_ctx);
> +	spin_unlock_bh(&br->multicast_lock);

It wasn't clear to me why special treatment is needed for the per-VLAN
context and it's not explained in the commit message either. I suspect
that it's a workaround for the fact that br_multicast_reset_timer_cbs()
is only called for VLANs that were actually added on the bridge (i.e.,
"brentry"), whereas the "other query" timers are used even when the VLAN
entry is not used for filtering.

This is related to my comment on patch #9 and it should probably be
handled in br_multicast_toggle_vlan(), which is called both when
multicast snooping is toggled on a specific VLAN and on all the VLANs
(i.e., "mcast_vlan_snooping").

>  }


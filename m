Return-Path: <netdev+bounces-282867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNBQMhVc82nm1gEAu9opvQ
	(envelope-from <netdev+bounces-282867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CE4A39CB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545203008A5E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F7421A14;
	Thu, 30 Apr 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJdPWW0G"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736A12F585
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556260; cv=fail; b=uUcWlSmL+Mvs2gZ5tU5x6Zh9ozrOQFkWPpQnprS0fJ3JT+bvkwPMtFx/RLLoKST1x3SdynZByq8txf1fa0v+p8QSKHUbVLFLbGluuigtiKHNU5inFWvIFnyGvR8f+z8NxGXw5WmSfC/totSW3WpqQF6l9/d0CG+XqILqQ5Q8BG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556260; c=relaxed/simple;
	bh=JAUE7I5NWpj1CqbgtRVA7BkZEAzAv6q2TDTgsJFAkwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HxYsCiUWWBhtbJKj3NyPGy5PO2UKR7yYjBQNPiVI3VOOm+To2FMJlRNB1XAZzaKV9Zvx65XTVkDvJhZiQCQeB6dCQHrZt7fHwoEaOOuXQrXQGz+aEt8KlgTdDEz6ywP0K5E0wkvEFIL+n3y6dumFX0I9rO9EN0h03W5bIE7zlmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJdPWW0G; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Lcm8mTrLLJ8E3MtPgdBT2bE4GvIRj407e5zl862QDp2hLUAG5Fvw57o0Nb8jWBilLurmO7hhjraSBOxzcu7DbgV8yFDBl+M6jeY6vP+7TZhJef8EoRF0I6iJIVI/nTb23drTaulkH/jMyYvmIpYVpEWJyX7j2zzCa6wWcQDKMZhYsJ83eoau8PJrD+TYnYHgWoLYBjp4qWhA9yfkXUxdKvqMGpt3qWp5JDfVaTPems7rbr8ju7lm6HI1N7JcKf/oxV2NL/ZJ3TQ6L+xNGP7QAYpCGEebTHvBONDdW6wOn49UxoJjRIrCqjCluMgVYaC686Jqf8emkAMmjO8IcOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqbMUZ0rTlFoHiPMFFTkCZKW2dWDeitzc6R1fiZ8R4s=;
 b=yHkCtiqa00RkQeEOV4S8kASCckgmJpCUzzqx37Px38uE7zxyqc/sGioxIwcwNTR+WRZ9HSn2fiXlzZGUS5CXRZ03EIlYD9NVN5hi9o6aauLHq0voCs0Lk7CuHf21Q6uXMfpFWmgWjpJ/gMHCS2B5zcWdr2gLtSWwOoPpIJbLGU2ia6WS7F5kBj2xzZ6KQHzhCRrS3SU8xwXOoW8N9Iqsdnu3eTj54zm+gv/6yA0FskOgwwr3xvL08NYGNbJ3G0Hpg2dWdgJQ9fDsOU8AEV1IZ7Sx9A+GIsV+VjOKP6wW6+mmY0DI3MpWqlkMR8vufVkMZhURsAUEoWHbSc0i5VzfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqbMUZ0rTlFoHiPMFFTkCZKW2dWDeitzc6R1fiZ8R4s=;
 b=EJdPWW0GI7SkgfrJo32bSRRwSijp/je6VWEryXBELXXrTqKyAyVyqOzWzHFVexUMbXbMAD3YaRRpu2/clB2FhH1d+azXJhV5N/DmUX37t70gOkqYaAAew1DoPJ3RJFtC1xEPwkOmX2vTTXEDZTolFoWSMe7swau6bZcw20izCGFH2p9jxK/IUn5e1VZr8IA0fB2hHoQ234Z9HG986Morid+KAqRnVYh0SwJkeaeobnizaBhrM34b9tdDJjcPvQRSBhP15EUVdgsnufmnH/MFCQMRukXI/9XBaanD/+w54tVUtZiFaMp9+lVc1AA9TaVo4D7hUz1J3uESqJHhYdMVLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 13:37:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:37:21 +0000
Date: Thu, 30 Apr 2026 16:37:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ip6mr: plug drop_reason to ip6mr_cache_report()
Message-ID: <20260430133712.GA989184@shredder>
References: <20260430074004.4133602-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430074004.4133602-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b940fb3-c1d7-4688-63b2-08dea6bd9af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gzLSIH/iIaqGb7lE5i4dmyBpgTOf+1zuZpt6D6b5vmNEYZUxxfZ6DlfpZiNkOIf0aeaI+kXFWKvt6cldGv+EFzNo82vN94/Rdb5pgQzHANDIUBaGEhlNTHpR1CtaElPAQkQ+6MjrJg2osgmoIFNnbVfbK608aTh8fWL+VJcjXSQChESiVNjL4aQZsnPded3gvKwYSS+vjK4j2wjTRUmPMAr3idY/5ff3pPt4JPhGuCRTeGj5qVBDxGntFQXaxvWJyqwycasaYTU12t8OYbpKQXWkvqiospw3B4GLKf/isp9hk75r0kC4d1m7/CbV2R7djBra06UAbJnZyxynZ7Ge0ILenm1bCjuIwtr0SsXNLVjmrdil+ys0P2x/zNn5ysACUcgkZUfwZmmfgaMSakq6nb2VNqHPezrLivLLvjN0xqP/gKCxh3GUkdWGddgySmQbrXOuLdBh1PRM2H86/lWG0YH8+OnhKKlQI4BJfmm/XjP/iXM6ADNtObe/TyVUjUUBRzN3fFjbULB4X7S8zHRz1aAUtb0ajg5M77AukWOCOEo/Wvoc/yZ3xzORRfGmY1GPbL4lLqWMvBGMYWrv3bkFRu+BFk5m+f4L+fUMn63Qhc8T45LWU4VKMNNCwdM7xwjSxXRIUguGHqNT+5Ef+KKkhl46bmhroqnIKKSSSQKodKn4nx6Alm1K8tT71Ny/zQrMK3InL2lOEaZDAcddUFuKZJhrpzu2oo5AeBj7GG+4MMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XAiZmKB1rnY1zQ6dHGg43N+PPe4oKwefuZdEelpDmIX8ZNw6+DydQW/7WXh?=
 =?us-ascii?Q?udDO42x4lDq6UhpDvyYbuD/gERXNvF++t7gSE+6yEcQ3lXQbhNoCojux41SR?=
 =?us-ascii?Q?RjMH+0zsRSoTZAucfNQ6o25RYeR1RAMfyWUbdS3z3eZvcsx+/js2lgjzoPic?=
 =?us-ascii?Q?PP9744eywBiQoCfY58RdIFrP2AsVHWW/zPrvoOB64NZimrmodueliu+9zw7E?=
 =?us-ascii?Q?4SA6Ngve6BWrIU65OQ1Esk9pYpU1WKP4Ce8w5b0/VBAhBbj5OgPyDtN35T2/?=
 =?us-ascii?Q?PYtpsuSR+x0Nt419bw//0eyS3U1OVjDV7fc6RhjCmqZbGQCn1Y0SerdLikeU?=
 =?us-ascii?Q?I/yLN37fYTi03AZT2Rg5ahhv165h/klfNWcAL+Gf3t+Zb9GKO38bIQ+leOMM?=
 =?us-ascii?Q?rkljTiO97VioCS8XNohSG1y+b+FAHmfchKUAok9jMwAvFWxseXX+tjG/4KA5?=
 =?us-ascii?Q?ERwDMIQhRC5iiI/1t4kBrRreFiHj/L3HdJzf7FY13pnI76onXicIO6YjEqMT?=
 =?us-ascii?Q?WWLzm0ACv03ZRSSHixONdDsxfW8ZiA50mRyWVUlYX1RAzYGvvLom0URM+QRz?=
 =?us-ascii?Q?NBBREtVm4sisqVNws4pI5oKlT3lfjbP9D22qerUulRXuWvAF+UL1Ty0ShLhg?=
 =?us-ascii?Q?1c4jrHIELI0dpWz1khTKeTZo3/aQp1aznjYXW9HCDuvBPGMXFOn1wh8ybkvq?=
 =?us-ascii?Q?1J6RIbg4Pm+fGv4416lERG6pQjs/9eh2l1oOqve6PxbYttn+QkYCal7+EuDm?=
 =?us-ascii?Q?GtSdguujcvQUoH5nLLy+2j6BbgkYRiEjD4xeI5XDsmWomIRCaVCa4W9bX38l?=
 =?us-ascii?Q?BJw3p9dzf7XSa9rlQvOfu2biI8JKN9XRVfMCxERSInxr1Doux8dWVhxNz2Ig?=
 =?us-ascii?Q?bM7YQcSYyOc2BCPH3e5J9dDjzmRrKnYJUR/RnzJvA1Gg5PLeWetyxVv2TyKG?=
 =?us-ascii?Q?qVUXfHHKDYqTT7rLX6YEyXBlKExo/KMYOZAeeYnxfJKO+quuCxm5lZ1ZnBJZ?=
 =?us-ascii?Q?/bnPfvlVRKpUIAsTvcQLGhqQWn8FzjUW2GVYXTjZmAkeVKFvo4HD7/+I1Zrh?=
 =?us-ascii?Q?SzZ7frXDXQ8Io7GJ7EqYsGYmE7wsbCpu2UTIuzVG4Al//Ho89bxihrc2FvZn?=
 =?us-ascii?Q?hH2Xu5nd8EN0emq9QTZFL1RddcM4gWWZKJk4CoLW627Dhux4qO7Gc/2qTP2a?=
 =?us-ascii?Q?f+besVlNY9C/018iZkuK3L5nRjRVRPNS+f4ylNzSiFzwolvGybMPTOxvICx7?=
 =?us-ascii?Q?FnWgEf8Hc4XGDT0y5eUOADhXqCxX78tDvRx4Jo6poQfwBlC/El+gP+ALNNcI?=
 =?us-ascii?Q?9GVDaA8Ln3YcQd53NNJZ+yrw8LFMKqjeJ7vpVcaBiNJeGLj8OysL5nQlktBQ?=
 =?us-ascii?Q?Z+p/Zq4Ijfy/xFU7nhGUapvZI453dlCxcvmLPNyAr+ScR3bR4iWPl/kzgx+H?=
 =?us-ascii?Q?C5mIUCsqoYahh5WNAIup0xsXZlBsbDtpkGd/SwF2KZy2XmFSnZX2JXmPCNXX?=
 =?us-ascii?Q?06gRqfYq+uuxi12cTYO9BCYAolOz+ughFTcaTR7kugpK/cotRFP6tVLBongg?=
 =?us-ascii?Q?81GNsERY+it7JS7/gfOk6NV8b2Tp5L6yV2C4B1VK/RKds0eP+dznUpRY81t6?=
 =?us-ascii?Q?yPKO+C/BjcviAtAL+baIk25COOyrg0U76ji9RJXK53kgU+IXXrfGfDpaoqJo?=
 =?us-ascii?Q?RsSSLMh/cET5wIbflus0vCsdusvsQz1LzuhelO5EVkO/PXGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b940fb3-c1d7-4688-63b2-08dea6bd9af3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:37:21.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sj6bxE+JUTJ24bkJ58SKulPTPumpp5VMEUN3Rsqzx21zqwGKaEMWLzMMKt8mqd8uR7XCd+t9TEi5Hdan7JnvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Rspamd-Queue-Id: 7E8CE4A39CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282867-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]

On Thu, Apr 30, 2026 at 07:40:04AM +0000, Eric Dumazet wrote:
> - Check mrt->mroute_sk earlier in the function.
> 
> - Use sock_queue_rcv_skb_reason() instead of sock_queue_rcv_skb().
> - Use sk_skb_reason_drop() instead of kfree_skb().
>   Note that we return -ENOMEM if sock_queue_rcv_skb_reason() failed,
>   as the precise error is not really needed for callers.
> 
> - Remove one net_warn_ratelimited().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>


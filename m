Return-Path: <netdev+bounces-265337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGfDIE/arWnV8QEAu9opvQ
	(envelope-from <netdev+bounces-265337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 21:21:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF92321CC
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81B2300CC13
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1238945E;
	Sun,  8 Mar 2026 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyWMken9"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE6387362;
	Sun,  8 Mar 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000784; cv=fail; b=MKQzo9ovppGTZnfUuBNuXmO1WLX9gqT++CpWPj8jPnuNLmx+WRfvVXJjC4+5kI6kcimDiiKqPxRNEaujthUsDqmKILo7JiUpmaIirrBDY/saMgK58eno9AYwElrJEu8XV+fisz3Z2FCjEWkKaMG1sEr7vz3Xpqs97Xq9Pu1GV+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000784; c=relaxed/simple;
	bh=uelAa2WjUMehXSFm/H5ENPgvi2AVlKS9TYhFSHvx3+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kx6Zao1PvsjXcUNbgUgWs9FzioWtbfEzRihMWmwjla4a2eTQev4THMI6hUIjaw22MjTCJ2LtQCvUpl8K+Z9zkHso30RF+78SH3bEKUS/G4tya4KdWggPXmvrJG1/fzVsvJcaQVYfmeISgFLms2eYQoIvqgPdC3RsbDUkw0A7wEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyWMken9 reason="signature verification failed"; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Andh9qq7iN3UhaNd+UPTL/9xIp7lcv9d3uTTxWH6FzLNRtyeo9SyAJK94HEs+4YafQaFmOAH0GcV+2irhLcp7NiLispNZyrKAU6Mq7IyDCj8vqw1P2SpRPtdFQ5yU8Ml1fHXcIHiy8UDhgu6vT6DwqJ8Nnmi/ZXSZ+2X6I2s1H9aIfCvxQxYqzdeNTdgPOfvwANcmuM7ktjBAECKMaG+T7wPzY1+cbLPfwotk+lLVZZPQtsA3hJ+fsVSdvxe03Am1AE8bU0wAu5f03N8ssjH+lX2ZocacdwppmLR/KR2u3DxRTfEZOTubh5fhKI5hNTbg33ICCzOuxJZRIdNYSqMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfkCrTTy6Bk7OuxFYMsn+ncHFLrXgj404+5Fw4zt3As=;
 b=ijzIKk1PrhC4AJ3l0rz50DvyV8t7Aa08hB2JNdFqV+Q89hwhCMXjFaqRXyw4UEEW2a3fjVDCLmZuwIwQdLzQh/3NqUtbAMFkhIP+8Q1uejp5WkWA52eyJj7OTU26xekeh2W6wrnQfKnoDOOxdMQeDLFybApeR7pqNnmyWxPTYbYNPEUGGsex3RqcYa6OvaqCMFaQ/juNxV8VlLNaAzNU1EQkSmdltfac9Qfm6boZ1lkdgV4ZRu0mRIZtJwMq8AeFQ+DyHT5m2gfyyQzm+TD/XNqXoA0mB4pljqT2kp20cfF6Yn/ZvX8iCeZwLsjyXZwHhJ8dBIzTJOsFXz9SiVgOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfkCrTTy6Bk7OuxFYMsn+ncHFLrXgj404+5Fw4zt3As=;
 b=OyWMken9vtJUGQROoz156aAmAh8sH2vV9O1GfSlS9eG7GiejE+8hsbSag444l/IOBexrbRd0GJ6e4lrcMlDJgs4DuWO4x+AuYrfj08V1ly7ayqHFX53CrC+F9sfhySdlLkyC+Dmktt2gg+OSYUm4efKUbl0OWMhfDBiqhzecIoH28GyzkrUBiT/3eHUfys3dZzscPMGIuVyYC1bNfhNEZA8D29pKgjTOGOHt3o7XaPmSE/327dTYUJAL8i4QklPqaGF+HFvBT9y9uD3OGD39EPYWgcwM67X+T5v7sNKe4zW0kfS5EwMKOgnsMxZG50ORvSfEYqc111ckdr0Wzy5i0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Sun, 8 Mar
 2026 20:13:00 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Sun, 8 Mar 2026
 20:12:59 +0000
Date: Sun, 8 Mar 2026 22:12:50 +0200
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
Subject: Re: [PATCH net-next v4 09/14] net: bridge: mcast: track active
 state, VLAN snooping
Message-ID: <20260308201250.GA1806274@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-10-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-10-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: d07ab970-6ba7-4a67-6e71-08de7d4f1851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	Aus5bhEBDhA1uubTpTYr8fG5gEasmxFbX5NGY/Do15gG5pp3fdLJfCSckkIjOc0ZpLDbxDVi1dP+FUPv4jZ8jHKAnn7LFkYCgVlE+xhFtFRZsQlNL4r4emalCbJcDIlSkX3JQuUU3b63hD5uOR1dBXr1iznyB8r+jqsdSC5u5vQofJ568TJSqY6oB7x+7QhQG1o6NiQaO+gFhSt0OkwXkYbOfodcBooZCvQwRDCkJdca3Q2D7I7NLJzy0kvn0yT9XvFmeHzzYoj6dYPd/4s0wgBm+DEfxmbRJiqBqiXqJE7DLk2NzKWAEMZ/bAypZPb0e+YGWgDyzwCBZNglPHY/s4BS4qV9mtI346tfnd4zwpC3d3oMvMf2IRBSdLfVQUC7oRj0f5GdDZbkxrtV57oDOlA0jaNASiYAFqeepaNGxZ0kfP9djoEv2JXU6E1i5tpSfUv0pXoP4LTet1amrnKXfFxhc+GIZDSSfFMMjmVljQ3FqiuKjTEAOVcJMR9aXwpP7OIuzL/ocrlNFs/nhP6m5okPoaogG6fsDJ9/yJOf/Bgygld4UAijbjJPztJyTd40vtskRT9KhVfoyk4dYBy1iqb+25yQptKwqIdAvjibT+UD3nzZbF30kmXA2L9wVbXVXSqOIL0HUAmsOUIoVqbtE4gusOtNk2OT/O41q/t/Y/3fEgnE0e6UHFlYFOMn2YZQ2QPnhJNGJ/v072xhMDBUzhy1zewJ58gKZD6bwrWDjzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?lDKFWm8iak2nSsDno3jAE08i3veLw6DR7A2tu2Uao5wCnvVPD0dVaVtDi/?=
 =?iso-8859-1?Q?cbKvpKDcZzpYuACthGrMUJP/0T+GSemOlY/m8AfysjonBFfbGbq2RjQfx9?=
 =?iso-8859-1?Q?77XIJYV/Hv96hIW9oovKDaTh0Dyh0pn1xssD9aAqF8mrcxawb2hCIHnO+S?=
 =?iso-8859-1?Q?qoba4Z4crveOWmCIuBVG6Qg5zp4Mf/cF5d200dFiB86UiJUJ7qUOdNU3vO?=
 =?iso-8859-1?Q?4HWF6n70ylW7OX9w2vgTrsyfmSCrEav18uJH9qX1C4IFH91LVXd5aWJ6DD?=
 =?iso-8859-1?Q?WlheYNu5JwotJk1XFcueLHR4JqH6i4xiksGeIpy3IHt3zwbfSkZ6YvFrfP?=
 =?iso-8859-1?Q?qhME5ukea0FsRJ1oPjl9FwVoUan+1DfbiN5YgiuBmkCl+eoXJMMfZ4D5Wf?=
 =?iso-8859-1?Q?Soc/Twxo0ffMxCcP06nomhDW7vUnSaU3uhBOFUvC0SkAxglZYEJRv3MeZV?=
 =?iso-8859-1?Q?RInel9SfwpJqtryV+2bo7kK7MsRb9L+Lq+NVqoyWXHIXiruQSZOL6xo7pW?=
 =?iso-8859-1?Q?MQ27TsvMh/ya0K7MDRjmRzSaKTaa1rBMIw26wlLlyGi2DBHMffW90HwniF?=
 =?iso-8859-1?Q?n7vn5QKvfP2R9/eiJXloGY5uP1Y+eQXdTETmEZTdnLy5iGy/IcmEtLroty?=
 =?iso-8859-1?Q?3RAKoGLjwJaQ3adh1G4X47WBeJ9gnfryujcbEumWjKgU2JCYVb8r6lTun7?=
 =?iso-8859-1?Q?AjtAtL8JNvbBBuxwmocm3wyw2hXZ5U3aJ2TRpidly/gGgXiCNhYvRgx5m+?=
 =?iso-8859-1?Q?bui/Qf0jk6IzfYRYwz8A6EzqdN8lOc4n2H7BIORH8eUDGGtmmms5416LsV?=
 =?iso-8859-1?Q?LLvNSChwsghJ8fjxDFusGmRfdKYd8r1IOC7uCBJvhBe0lSY1JiVAcD71E9?=
 =?iso-8859-1?Q?Z5dYpJc7QVb2nx+d9Wwij+EhYrOh30Xw5zD7jhD2iRZwJBKmQ96+8Bo28Q?=
 =?iso-8859-1?Q?4kg+K+SRpcq27ybavEphHQPGT3DWD5aX4zt3agsoVh5gzEL6lz3FTjs/Db?=
 =?iso-8859-1?Q?ZfJ4eXHGVJC67GYzPM6xhoEsuJaSAqUwwkBF7eh2y5ucCuErW6UB7GKniG?=
 =?iso-8859-1?Q?DnUb9ScuJEIr9PeRkYe2EyMs4BR2QYprl7A/QEpm9YpUBjjbsJ6jIdS0jK?=
 =?iso-8859-1?Q?RiIMtiAJASamzROrshnSpZ/PW97DTslsyaX3LQ0wlQkCRLxku2oI9RDRXl?=
 =?iso-8859-1?Q?d57x/us12NDdDzE0eP1sW11T3MazhC7QICuycxbg4ZIv51a/afDY8aQO/b?=
 =?iso-8859-1?Q?wJbt60NYb7i6Bj3RTKay3fVOvrPP1r7JphckmE0cE14or59xFGaNm7Jd8M?=
 =?iso-8859-1?Q?uqtHBPf+Wttyfn2wjiVNTL/wyDgwkEs38FFoCc8TGV73++4JfI+KjVOasq?=
 =?iso-8859-1?Q?vdxD1MUE7XXI+z7bGELL1/g0rIvjVuQFmmDhzz8bOzC7Z9ky/FUis8wkyM?=
 =?iso-8859-1?Q?vn4hjjbu7zjOYfOhBsPzNFKpk5rAyxV9ODDKnJObNXXkQCe0hLWSL98Y6S?=
 =?iso-8859-1?Q?1mSCocppg/hS4fYZMLaDdO50SYPNP5uTqFzKFFhBs1WtEaA1otOMPBHotO?=
 =?iso-8859-1?Q?YZl+f5/ZGYiqKP6xftNX5oMB2sY/32MxhUOd990a+0qy8OcDssKWJt1Lwu?=
 =?iso-8859-1?Q?Hav0axO+TCY/NEGxl0y4rWOZKbheB3FUupGq6Q7JtPDzgsxLYX175hVId9?=
 =?iso-8859-1?Q?zb3obx92/KJ1RB7eQaHhnKtXO55l6JDkSyE7qoi05vfzS7FqJRPS3qISAi?=
 =?iso-8859-1?Q?Ozk0YZdFAhtprmZV6J8YYgMSV5kYUf1/8405BzQQ5h6yyFxphmIYEHMgZq?=
 =?iso-8859-1?Q?h/GRMINiow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07ab970-6ba7-4a67-6e71-08de7d4f1851
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:12:59.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wENB3+5V6dHJb0alNbc5apqED3mmhDpg7CgaPO1tKu7kqBMPbiXkGhY9UDima019I7fHAYJnPrAsbsGKNQzTeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
X-Rspamd-Queue-Id: DECF92321CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.332];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,c0d3.blue:email]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:43AM +0100, Linus Lüssing wrote:
> If VLAN aware multicast snooping is enabled then we need to perform a
> few extra checks to figure out if multicast snooping is actually enabled
> for a specific VLAN, as there is then an additional per VLAN multicast
> snooping toggle.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index cdc921b97243..1059984d8147 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1142,9 +1142,31 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
>  
>  	lockdep_assert_held_once(&brmctx->br->multicast_lock);
>  
> -	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
> +	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED)) {
>  		force_inactive = true;
> +		goto update;
> +	}
>  
> +	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
> +		/* with per-vlan snooping enabled there is an extra per-vlan
> +		 * toggle to enable/disable snooping which we must check
> +		 */
> +		if (br_multicast_ctx_vlan_global_disabled(brmctx))
> +			force_inactive = true;
> +		/* with per-vlan snooping enabled the non-vlan multicast
> +		 * snooping context is inactive
> +		 */
> +		else if (!br_multicast_ctx_is_vlan(brmctx))
> +			force_inactive = true;
> +	} else {
> +		/* with per-vlan snooping disabled a vlan multicast
> +		 * snooping context is inactive
> +		 */
> +		if (br_multicast_ctx_is_vlan(brmctx))
> +			force_inactive = true;
> +	}
> +
> +update:
>  	br_ip4_multicast_update_active(brmctx, force_inactive);
>  	br_ip6_multicast_update_active(brmctx, force_inactive);
>  
> @@ -4505,6 +4527,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>  
>  		spin_lock_bh(&br->multicast_lock);
>  		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
> +		br_multicast_update_active(&vlan->br_mcast_ctx);
>  
>  		if (on)
>  			__br_multicast_open(&vlan->br_mcast_ctx);

I believe the active state is not disabled when snooping is disabled on
a specific VLAN. AFAICT that's because br_multicast_update_active() is
only called when the VLAN is actually used by the bridge (i.e.,
"brentry"). Can be reproduced with [1]. Please add it as a test case in
patch #2.

Will continue tomorrow.

[1]
#!/bin/bash

for ns in ns0 ns1; do
	ip netns del $ns &> /dev/null
	ip netns add $ns
	ip -n $ns link set dev lo up
done

ip -n ns0 link add name veth0 type veth peer name veth1 netns ns1

ip -n ns0 link add name br0 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1
ip -n ns1 link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1

ip -n ns0 link set dev veth0 up master br0
ip -n ns1 link set dev veth1 up master br1

bridge -n ns0 vlan add vid 10 dev veth0 master
bridge -n ns1 vlan add vid 10 dev veth1 master

sleep 1

bridge -n ns0 vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 100 mcast_querier 1
bridge -n ns1 vlan global set vid 10 dev br1 mcast_snooping 1 mcast_query_response_interval 100 mcast_querier 0

sleep 1

bridge -n ns1 -j -p vlan global show dev br1 vid 10 | jq '.[]["vlans"][]["mcast_active_v4"]'

bridge -n ns1 vlan global set vid 10 dev br1 mcast_snooping 0
sleep 1
bridge -n ns1 -j -p vlan global show dev br1 vid 10 | jq '.[]["vlans"][]["mcast_active_v4"]'


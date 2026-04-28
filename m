Return-Path: <netdev+bounces-281814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFgbMuGq8GkOXAEAu9opvQ
	(envelope-from <netdev+bounces-281814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D88484FCA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CED431652B2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68A3B2FFD;
	Tue, 28 Apr 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDojY49O"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307973B27FC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375945; cv=fail; b=q8Rw59V8ZUOffVKzcxbBb1PsMuHgdIQve+05574T0Ez02Lv7/Ben6XkuJTk5Rk92qDsgFIy7Nv/nfvaUO/RPFbV1qcWpTNs3TmebmaEp2f2e1fegEp9hrTiERKR53NEVADNZwyMtCRRbmtxI8tKJ2Eu+B5pPWhyJAoY5fF9SRo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375945; c=relaxed/simple;
	bh=3eD2IvJT7Osvs2Pm7RSdOCOQxcw14fH2qvEiV4+BCjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmoojQL3iECWJ4bM++10fISTEzoBeRdvIDo6T/I7/MPSAC0VOS8/PpcXNCsd/NcQKGY287MJivoRz5asycIAXmKrgXYEuNJYXb2Nz8meDCRKvUKEvNLrYKAv94yDf8OcgYVl2Yh3WEosYxHn5tyf92TwNDIOp8OG9m+MN6p0poc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDojY49O; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te3Ej4C67KAqK5a4zPE6e3LYUXos+CSPv/GpLPljxQ0aGXVEOfT+B6ZPNpVkasm7AsyAGnuFtQPzGINiWPAearFACCv7gizNX+RH+NBH3GvOxnFj8WXe1gakzrq90yiMNKXmagMRvcP3/ZG6VAvqLmlooJ2yOrNGkj0R2wHU3EzoyLPvJ4ar5J/UMorRTOmYYQWABr2hAkxu+z+ZOvbX5aTet8UqSl+tO3o5GcDOAnIF7pREJ3E3ARbahpg3QXKyMuNVUwPs19YY4XkWMdTVxkZ2WjV35w96eVAK+iCWHWxfiC/K/AJKUbLzZeTg7iZaVw8ed47s5U7o4KGBkZowHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ce6khURArsxAeUBgo88bS34+2nUKVgj5kKSFJ9w8U=;
 b=QHI+zneQwCnjLZQCCJPjg1433LP1G1oJLg5tqgpBfU8O5oOFNTal2Aunsbx3hJhNqXB/amApQxmuf9FuPL3Vpg5Of8MhJltIc3enPSy1EYL1vOfAB7ikABgWUZT1gvbbQszwC3ONxDaqwatg5FNxpfSXJY2x0hrbX+DA3ueOdxc9XctEdFmDI2adDOy00RczljdjePEwG+0gGw883UKpz45uS67RNKS6DxUisRVBouYGrr8tMz5+kILpb2EH+JF+BrM6+h0BdNgTV2NVvgUIbFueLjiYVa97n5JQo2zx3NviOQspZtq3mKsGOqcw5DFR5M/ibbW6mpbJ6zw4P5E7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ce6khURArsxAeUBgo88bS34+2nUKVgj5kKSFJ9w8U=;
 b=gDojY49OZtL3MfNOog1tn9/ifu8ZvKWLwzlFpqSkwFqwnXTT2Fu9iLYayuhZjErvOANafAd5PdxZ3uidmSW4qMM9bOo/pq/u+s8sInCt2UUaVzRSz4zwe4w7rfp5SzgFHcuJ+DIwAt/V4Nv7NwU/lCwXp3DYjpNkWtiC+1OWrgpOz0Tczii9cnYJNqC/3krba3bY0HmVUN+FN+2RqW3MfFCrvT4nnnMGy+e9TYn+MB602LC+v3brLdWJVMVWX9t2F8eSQZPNbfHzKdcZhQgXZNqhoc+sdIUTt363KRozd0GpVx8EoWlCC7U1TkS0Bm4lu70agomZUfGJltpKfxs3kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 11:32:15 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 11:32:14 +0000
Date: Tue, 28 Apr 2026 11:32:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: bryan <bpliscott@gmail.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com
Subject: Re: [BUG] mlx5: VLAN-aware bridge drops all traffic in legacy
 eswitch mode without promiscuous
Message-ID: <smso326cbzjbdl2dxipi2q3uxks72dnygvyfoexbin4dnvezsn@msf4gwz567mm>
References: <96b4d723ac443f3a42680fa1c8b94b929df39da3.camel@gmail.com>
 <1126aa35-1924-492f-8d7f-072c0dec9bde@nvidia.com>
 <5d5524e8077bc3f169ab5ce6ea267d344efd3336.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5524e8077bc3f169ab5ce6ea267d344efd3336.camel@gmail.com>
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e652d1c-7d0c-4afa-1ca1-08dea519cb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SEKS0Fh+ZeIUvtJAztX+NBH/J2iiprrlwRCcFUD+JYsPqmRBWYzceEo+xJZ5o8m7rcu6sltg1ENQoCerm+NRKs/8G7Ew4EzYed4Fp4GMfcANNmy2fqM9uCUp5+rj+Ss0j00oEakDO5Xp3fLHj9GZR/QMDF2/Aydr4XGL0sC0wLpEE8cbj3jMi4zNBLAJaCg7z2/At51K8j19FzbeiJU5QPn8VDbCkKmjcSkFdfpCCRK+f1JXoDTmsLB+lT+qJB7cO8hQWsMLwlZmJ6fte8Yi9CSpEtyjELv4eaI4IJo996jva8XY5B2xtG8PeDydle5ScZ/qxScnTrOVxI1OXplkGkY9dYWo9+lMdBDB2TVDr3vwjTIh23Rm5KlK2TXcjqfKY/Cnys92kPxJoVpIBw23EzpxbpZORHTN4WxhaaGHtf2FjSnxQI3ky0T/5aQgRwntSc6Ih6LBJYYZbJZgT9C8iVa+xvTZXxmyCHHBWjcNnzcA93ceS5JXjgqjEBd/tsJyptINoFzCy/5XY1QFN9DXHiK03oKcMVArA7Wm1J2o1k8ilc/AlBHwZI6KQO30Bnsn1E/muzV86kw7TvgX89GVJPv95nNs1+++l3IO5fyVHoayLAdl23vOQoCFQKYvsLR21ePlIaJsqiueTUbce7B4jCU9qIc2Wb24ymlisLusx+GgLe076Mqc7bhT8EllPOAZdasKz5PnYpAiJGPuHHY54gvotvR9NJgi/3kiczQwTfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YBijrtPjSmZ4j3Z6zEWs/FtV10kHBFFuDnW+WC3KNy6LyiRriHy1scRKEMC?=
 =?us-ascii?Q?Y9rENGGzWa9W01WuCpkpvmzArarLWVXIcLWb9H43pBgjuPOkl0xJTWcv/tdX?=
 =?us-ascii?Q?GJ4hDZgvc4Sr/Vx7vzlWlaWA8S5h9jJu1L+L7KTj7u+M0jSKyzHWlM2h3pJk?=
 =?us-ascii?Q?KLW0ClyvrwN/caLZge6c2Uggaxm3aBLUjND5TZnp8DHgIQXEYxjPSTuwkwqj?=
 =?us-ascii?Q?YtPB4EBSaha+mHnH2hilLZ+D9vhR7KHAK8IAp44U8mGIein+wyvzyhed2z5B?=
 =?us-ascii?Q?MOOILRgFJEZfDmJ5UefIiVy4phpoaSy19Dx8TkfVnY/48TUWaMi1GlP+zDrX?=
 =?us-ascii?Q?DZz9qGLL4e7sfChGXsrd0ReUTF2r2lhhbjlImxJdLPJdpbmbkUmd1rSYUet9?=
 =?us-ascii?Q?A7/YRNWpZ8uIJT8c6HSEsKIpjRbUmhsfiwBxJdOCRf1kxKrBIDe2MOEpcFyz?=
 =?us-ascii?Q?S3L2CRHUu+rXnF6s/086PLcPQ9JPAOMnxhSfKanVzChJRW96I6Lu5iGa9QNE?=
 =?us-ascii?Q?6KFXU+Y9F1nyRZmYoMhy7lcFIrZSpOQLmEJP3BXs5VhJV8NMWt6YwFRI3IuM?=
 =?us-ascii?Q?HsjfVcbo3ISRw5cdg7mjsPenwenZZOKyEiodr5hnuEmMPtkphjOwTqXbtdof?=
 =?us-ascii?Q?cvWlkDfruqluIweXSq7/ZlfIc+c2VzpzP6Y4YpovjLpblKRYWMgteuewY1PJ?=
 =?us-ascii?Q?Ogkf2Qji71m0ONuaoo8L0q+zOAXCJVqc4fYHkzZFv3swcMXC8DpUgxPdCoUd?=
 =?us-ascii?Q?/tDIggXlJtnRq0OxDebBzUTrc9m8WnCt71XuWSk5QiJP27R3NYMrjcvoEkzj?=
 =?us-ascii?Q?e/HlWeqx9EUv0F3cxRWtjYy9OkjiUG1tADTHeCnvhMiwAudbro72XItKQAA8?=
 =?us-ascii?Q?CL4j1yItAA184LRfKzlvXLu24MDasLVM4DJglETOoIUjhzRY5l7XoOSAMRyE?=
 =?us-ascii?Q?PSk/tj1hgNI9SahQHCxdWR5bNn636oyqD1SEdGWB7PPMcQ6jTi5fSZmDXTtD?=
 =?us-ascii?Q?CjiTtd1zS5pdsZKtykOAkqMJRtkiD+lTL/+1hoI5+AI4hnoDfraPNv3WE5gM?=
 =?us-ascii?Q?iY3U0FdV7RzWo9X4224rQ81RBY++JatFDlrZFUsqqnsN/8XXuUY2IVmY4aZV?=
 =?us-ascii?Q?rHW1CCN9mIVaCUqxIJHN790uF1ROS8lBGtqDUcp894TMBDGTyvCLpB5721gY?=
 =?us-ascii?Q?eyDhOwTZs92n8jXDilhK+I7MRiJJ79tRMqWn1kyCoJyFEpI3KxcPmJQJpRFU?=
 =?us-ascii?Q?JmVmLFHAmUcyYXnJEl5RrVXNLl5naLh/agk4anX3QjDw4Lc6KMDOpiF0yknG?=
 =?us-ascii?Q?G3nThBvUc8/tl911AiWGkO6SV2Efs/eDp1IAfkTp6oGUVkgZYEumzwgfzoae?=
 =?us-ascii?Q?CigTYBER7AlzAlBt0thHELlVK/yihezzQTT/14Qqs1po9em4jRra/D9FgOeF?=
 =?us-ascii?Q?HezTI1MRqewHYf/i6LnjyCGsqyCPvU6ht6sgbOBBLwL0HAZjBk7HsiGCqdJ0?=
 =?us-ascii?Q?5AeStWYkH7ehyQee4C+NntZu7O53pU8Maid45N+Xk3wO4XYzbRg/EvEtAB7z?=
 =?us-ascii?Q?v5pbqAnjaUnaoR6QxDoGc1E6mGOXsJo6WaEIbNSKayMCIQYE4BBJZJ8COyK9?=
 =?us-ascii?Q?jksptu2FW7v2UAArV+4+xdyTL7u8NYmz8occucT5vxNgIP0KkItd2qWJgQNK?=
 =?us-ascii?Q?k7icHb8Q3lTLyp3sCLmKSwYaeHTfNFfyv21RZxjNxh2s4ltJU/1bVEBQO9n5?=
 =?us-ascii?Q?xPBPwEr8TQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e652d1c-7d0c-4afa-1ca1-08dea519cb74
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:32:14.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHGV7pUBCC8N+2SDTbJjRZgGDjAhd+jpbpKK+T+M0mWDShr4pQolb5MtaAdBGYILiH2ESUOcXk1pIDaVg8RFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Rspamd-Queue-Id: C4D88484FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281814-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, Apr 27, 2026 at 04:10:28PM -0500, bryan wrote:
> Here would be one example config (sanitized). The promisc on link is
> what allows traffic to pass - I disable promisc, and traffic stops.
> These are single-port CX4Lx cards. nic0 is the physical interface, no
> VFs configured, SrIOV has been disabled as part of testing and
> troubleshooting, Kernel 6.17 currently:
>
Is this a distro kernel or a self-compiled .deb?

> auto lo
> iface lo inet loopback
>
> auto nic0
> iface nic0 inet manual
>         up ip link set nic0 promisc on
> auto vmbr0
> iface vmbr0 inet manual
>         bridge-ports nic0
>         bridge-stp off
>         bridge-fd 0
>         bridge-vlan-aware yes
>         bridge-vids 2-10 555
>
> auto vmbr0.555
> iface vmbr0.555 inet static
>         address 192.168.1.123/24
>         gateway 192.168.1.1
>
>
> iface nic3 inet manual
>
> iface nic1 inet manual
>
> iface nic2 inet manual
>
>
> This was ported over to use the new nic# bindings, before this it was
> the standard enps0np0 naming. No difference in behvaiour.
>

I don't have a machine with ifupdown available but I did a similar setup
with iproute2 (note that promisc mode is explicitly set to off):

  # Bring PF up
  ip link set dev $DEV up
  ip link set dev $DEV promisc off

  # Create bridge
  ip link add name $BR type bridge
  ip link set dev $BR type bridge stp_state 0 forward_delay 0

  # Make bridge VLAN-aware
  ip link set dev $BR type bridge vlan_filtering 1

  # Add PF to bridge
  ip link set dev $DEV master $BR

  # Bring bridge up
  ip link set dev $BR up

  # Allow VLANs 2-10 and 555 on $DEV bridge port
  bridge vlan del dev $DEV vid 1
  bridge vlan add dev $DEV vid 2-10
  bridge vlan add dev $DEV vid 555

  # Also allow VLANs on bridge self port
  bridge vlan add dev $BR vid 2-10 self
  bridge vlan add dev $BR vid 555 self

  # Create VLAN subinterface $BR.555
  ip link add link $BR name $BR.555 type vlan id 555

  # Assign IP
  ip addr add 192.168.1.123/24 dev $BR.555

  # Bring VLAN interface up
  ip link set dev $BR.555 up

On the peer where $DEV is connected to I have created a vlan interface
for vlan id 555 and I can ping it without issues...

> >Is this even with one vlan? I ran a flow on a CX4LX pair with one vlan
> >and vlan_filtering set and traffic seems to be flowing normally.
>
> I have not checked with literally only one VLAN, as that is not at all
> the use case. I can absolutely test that if it would help! Would you
> like me to remove every VLAN but 555 from the interface, and leave the
> rest of the config as-is?
>
No need.
>
>
> [...]
>
> >eth2 is a PF in legacy switchdev mode.
>
> It was my understanding that Legacy mode and Switchdev mode were two
> independent modes, with Legacy done in-software and Switchdev using the
> eSwitch on the NIC itself. Please excuse my ignorance if that is not
> the case. Would you be able to specify if you used Switchdev mode or
> Legacy mode? because Switchdev mode DOES function as a workaround and
> passes traffic (but in my case results in system instability after a
> time).
>
My bad, sorry. I wanted to say legacy mode.

It would be useful if you could provide a reproduction using only plain
iproute2 commands (ip and bridge) like above.

Also, do you see anyting relevant info in dmesg regarding the interface?

Could you also provide the following:
- ip link
- ip addr
- bridge link
- bridge vlan
- bridge fdb
- ethtool -S nic0

Maybe we can get some info from there.

Thanks,
Dragos


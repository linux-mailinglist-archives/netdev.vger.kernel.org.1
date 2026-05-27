Return-Path: <netdev+bounces-292176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBl0C3uqFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2FF5E10CA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3278300E70A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8C3DC852;
	Wed, 27 May 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTLlb4sZ"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD493DB318
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870328; cv=fail; b=VGalSXi49MXM9BxBYAWxjTK4iA4VA2vQWIaWEoPqcQflkPTrfEJorBlLsQEilLjPs7mGJ/DMMBzau1QFh3nGswUWyoRPUVE+//pQV7k3EcnuEMdZSklkjBq/K5mj0+wQgwhJkIQ7QLPsddpz+NitRiLtCorPe16945rXxcyMGTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870328; c=relaxed/simple;
	bh=GATDsyqNG9Sc43CAWseqD1nlPXRuemQ0nPXo2OzvIRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oyrtDARWH21sLS59+OeXt3aLEowboWi9+sKnw6L/8AopXBxmm9qQeHsn7UVAgobAF7oxXrfTffUVx6KMynPywr/ZUc8RAUoQQGs5KQ9mMVxDYk5ZEK3BSouwOMFwvoyfTVNoEhsW9BeyigybfB9nlFlXBt7ZCxMpPun70I9xfCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTLlb4sZ; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPqsPtgk33dV4EIoOD3Hn4IB8fvvdkUvah929KBqZdNV+be2oE8F3N7JupLhH5aRFU0L+oznRy3esZx48E3tnxJiui7BIkHjDIROeAGPzPMK/OyKVHKRgii1184/qp8f3kJ8rae+RjKn/XpBH5M+wDm5eBz9xtLr6owxKjLw8EQtGZAMH5aV+dqTAZ9qwEVoqthxC2w8xA0ctdN7O+e2JdWT7z7BJtlm2w2CP5Vri2J/S3D7BJbpTd1qIY4QjcugIFroDI3mSail0xayjneX+2qeCkJTwI6bvmPfrztgQMF8zxJoMU7d0HO08hXCjP9aSo1V0KcuwXYHfUcpdemSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifx4ksxmDG1blEY0i8jkBiq8RrOK/WPKhPlY3H2EpeY=;
 b=vd+KIQFjgZIkcLIxfTcQcdUZW+QzctIZHMDym0llvoOWt03q6mTq+4CqmxGnaD+sOnHtSFoH0oXWzdln7gZvFFz92vx5KljPuhsholOIRlvgzXU1O6+rd5Ri1x2AAwJ0/dPZrxnyR6kOsdNbHk9In9fm5WaSFiPcPJl2NnB64Q1PUC/9wstcMM/rj5ff0q6Er/VYhsLP9Bt9qio3RyK9LX9SGoJqfa/dE73z5SWMMlsW4te4SV/waEuoVk4XZ19faVi/2PEHrMxGQmkaPhczp9k9+vP2ZG9/04KFRG8KfuNHmVi+Qb+6/Nh/dQvJY/IrWs2bSe75VJ0LJU18gYktAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifx4ksxmDG1blEY0i8jkBiq8RrOK/WPKhPlY3H2EpeY=;
 b=MTLlb4sZ9Sk29vIP5XjDgPikVIChvysVKVMYhcsNYfKX15tZp7ayztcxFs+UlzpyE37UyVJjJfLWcVMi8v9I7TleWzTcJs7wCK2+KaNn2tOKdDxjc2WNSh+F5i9jFQbVf8XYwtGCr0pK7L0JCuociTQAGrcFyHnuuUukGGyjlmDbULpKBroIuVotXy1L6RALjtVKGjweD1JJw15qHxK0CjTWHhSv1hwMdLHbi7RzQv4R9NV4p53UddECk7lSNsUd0Djjp4siiRE8OFj5uOoWPKvC2rUNYXM+MYJcvpixZ6/V+RWaM9ebelKH/m6lZLNWVmkoL8u6lad2cR6asYJobQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 27 May
 2026 08:25:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:25:23 +0000
Date: Wed, 27 May 2026 11:25:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org, horms@kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net 3/3] selftests: rtnetlink: Add bridge promiscuity
 tests
Message-ID: <20260527082514.GA443143@shredder>
References: <20260526064818.272516-1-idosch@nvidia.com>
 <20260526064818.272516-4-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526064818.272516-4-idosch@nvidia.com>
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 543c8025-6d58-403a-4362-08debbc97f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LnF8mGS81nd4Tm+kmzQinYZ/6H1KUTdpfL6NkBMjXIU3pO630s2INmlu5bsXI39Q0t0YVkIkOTD2rQwxGVVfGe1lHN6SHcf92sGDAfeEpxyVHt97hzMN0nIFWJ4qmOaE1fNguA+h1F1PGVttq9lyUXRf7JnP3CD75cmYNQqMj12bOuAnKwdStGxpKAh2BuJsCXrY1Xn8qI+647fn+5cnBqNU9CwWXWmv4rUvXglkVOnxXlz1Jmfa/AaTDBgUkV9MPAWd0xLPFsk/oFJWarRKZHlcmKCvBX//AayMRIqNZvzC7UtczdQ9QzgS1f9iIY4RJSlnqK550jXyXTThYPCSOd0JHCsBzgk+C8k5g4fh25lykvOFlblwHoupi7Rgstw/MG9YdNB6o8Rml1JDhbNMAKLTzzzjKzd3P+8qRe0VQFxkjiVsigcssj3qutGEZVb1HHMpBpJ8nbeNfrdIOIv67COOaeRCJPsuB0buPq5y9ARW8dXcI2BFCM1TV8yW12L7UCW3KNTb5Ehbv8FeqHbGgjt7ztuldw08hi0M0doJpJ9TKxi4gZKa3XSd4XgMWTkL/hQO4LKRWtALqxEPsYxIX2VogtHu5iTYOm74WASCcXbj8Gh2XMEz5p1kZDKIhevsEPPVQBAkJ1MzucWvFZtkY8n9X8oqSkBLIJhrp/+NbTcJryLOTIFxMt7o5AUT2LmS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfQjbsweZvIamcoqCS64ul3nx0q1HDKPMGl5FqRuQSpz2hdGnmyj90Hmi4El?=
 =?us-ascii?Q?seBpPD0r7pMZBdAGMhHwYEhHT05D6+bqaA6TW/7GRUQoYI9v+x24NqSpJQdV?=
 =?us-ascii?Q?mM5KgQxcTEUj2Xn05qvoBtHR2xWd2hKOQgMw/EnXGAS5/RI7bY/4YyDNhj5v?=
 =?us-ascii?Q?yS5eG4sqIWuYjc/AOTjztKT3Lx+2lsoi4p9Mur3Qsv1jEQUTsNIlHx0+xZiA?=
 =?us-ascii?Q?gytriqhTD6AZX1zA1tfLIzH174pL9OLB8iNWA0buxKicegqsMAz95l6Iqcwh?=
 =?us-ascii?Q?zrWXjvV4SCdxa5b53l7eu6Pdo18WLFDvKQ2gq8brfk44SW8iI1DBh20pkdBi?=
 =?us-ascii?Q?FLp4pgXqPma/G5Ni9FMhgg32F1sOZoJWOfN8t2b+pNS8efz4dBFAZvWpfEX8?=
 =?us-ascii?Q?APoIIt4EAb5EZkOJLV9BOIlSl/GbBZF8Hha7JyrXnHOIxiNp68myeZxW8BN4?=
 =?us-ascii?Q?4AVJd9MeS0V9Y1GahpEHcDlLZPyMLLqW+jFz25aICBZ+j08qlV0aE9w37rjM?=
 =?us-ascii?Q?kiWV5GMwq1NOnIVjtNUpNNsRoi2VeRRP31H/kf5GZtCz0bQUmggOEQxCSsx+?=
 =?us-ascii?Q?eFAvvJg/3ADtQ5hleHFMBtqfss1saW0yVGUN2ahV2FaNLG+bA/bE3icg+HRI?=
 =?us-ascii?Q?uynjnPmA42NXZwtLYNC4XnLPXGFi6H7uzcZurXA2Q1sLmRoo3plIsoYrAMop?=
 =?us-ascii?Q?vO3bwucyzY+Z7R0SfzEg1VdfRqOmvT0ZTFgnqSSYhCTePTjoVpSrtdFGEpha?=
 =?us-ascii?Q?hK0GpBV+mh0PQsw79pIvRT7lhHc2YFRKHgEw7wAu1lMASxTZxvgHOQvlesPN?=
 =?us-ascii?Q?W7Vyj/8kcYT/o3aSwZzUZqFCxaC4RAS2yJTt+waY1dLc+nR3gCu12WrVdlAE?=
 =?us-ascii?Q?4LMMenbqTQ1j6la3O7a/PzGLP50HWBArdclwxlQxY4OwgpsxxV5fGGC86gzW?=
 =?us-ascii?Q?ymkXjMciPLNcc/7hBBp+2bxnMgTFoCC99+SLesbC6Bqg1CDu2dLFKWJCB1BR?=
 =?us-ascii?Q?KE/bHBSCD/VF1wFwFdXosIZw7C0juZj6eTWh+6etTRsC8OqyelG6Zt7Bed4/?=
 =?us-ascii?Q?RLX86IfFtzzKf120GV3UWwpfRx9yHE4FIaj0BxpUlXg9Z7gvpy+KsFBJ10eB?=
 =?us-ascii?Q?dn4YS8BS9pGunIROBVvL2VAzhoHyCyhlLOvd1jv1a7XZsYGr9IF5kaPJBWAc?=
 =?us-ascii?Q?Dd8EfT16qL2+pbBJeFgUTK+Moj1ER/hJqWNfYRiL6m2gobVg91qO6LATCDzR?=
 =?us-ascii?Q?Lzqzg2DvGfz3g/1p5Yd/OqwYE+dBIt7O908Ilukrzu9tVXOkfLSGp0ehUdxV?=
 =?us-ascii?Q?0xUYDt9FZIIBLV6meOUW3YSDM5z0lUlPh59vD584a9Qyj+Rg6WGS89FYCUwn?=
 =?us-ascii?Q?Pv2Ldm8Coo2qTtJWLA5QNquglej1XPj/6GGjVEKW6TKbIE8sqorUCSD8VGS2?=
 =?us-ascii?Q?bqtTK9iQZmFkQmtGOown1t3paHE8BsYEzZYxi6UZVWLEdxfdX4GR2DjudYrE?=
 =?us-ascii?Q?+bQs7D3jfLJlXVxDUbxIeL7TiM7l0x1I8B0jg0EzljN7Jd3DLDCbptqNhQNk?=
 =?us-ascii?Q?7a1DwMwQMf786Z3HTFoONpPUOq7khy9ybPp4ACclIB47Zl1UatzqlfHEbeDT?=
 =?us-ascii?Q?8e2G8/klGjp6DgHpTVGWWHVroGxtx59o6CmQNxIEyeisj0L4uFQ5rBY58zse?=
 =?us-ascii?Q?VgKwiT4j2hmtcO8RYk1CBSBioamhZBykXDNDOcZMG2xd97do?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543c8025-6d58-403a-4362-08debbc97f7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:25:23.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUp3+QMeH+tuwXTy5s8uEmubhxtlAG93vcbUtV+y5u+IyN4k5yH6JAueZZxG6p5S4AGV7QB9vqhB3djtoET5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B2FF5E10CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:48:18AM +0300, Ido Schimmel wrote:
> +# Test that changing bridge port flags via the netlink path does not sleep with
> +# the bridge spin lock held.
> +kci_test_bridge_promisc_netlink()
> +{
> +	local dummy="test_dummy1"
> +	local bridge="test_br1"
> +	local team="test_team1"
> +	local ret=0
> +
> +	run_cmd ip link add $team up type team
> +	run_cmd ip link add $bridge up type bridge vlan_filtering 1
> +	run_cmd ip link add $dummy up type dummy
> +	run_cmd ip link set $dummy master $bridge
> +	run_cmd ip link set $team master $bridge
> +
> +	# This causes the bridge driver to sync all the static FDB entries to
> +	# the team device (which supports unicast filtering) and remove it from
> +	# promiscuous mode. The call to dev_set_promiscuity() can sleep due to
> +	# Rx mode inlining, which is a problem if the bridge spin lock is held.
> +	run_cmd bridge link set dev $dummy flood off learning off
> +
> +	run_cmd ip link del $dummy
> +	run_cmd ip link del $bridge
> +	run_cmd ip link del $team
> +
> +	end_test "PASS: bridge_promisc_netlink"
> +}

Both Sashikos complain about this passing even we failed to create the
team device ("for example with CONFIG_NET_TEAM=n or an iproute2 build
without team support").

We have CONFIG_NET_TEAM=y in tools/testing/selftests/net/config and we
can't assume we are running with ancient iproute2.


Return-Path: <netdev+bounces-291200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEvXHkwfE2ra7wYAu9opvQ
	(envelope-from <netdev+bounces-291200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 17:54:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF475C300D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E074430036F4
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FC3955F8;
	Sun, 24 May 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBYzEJYt"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05350258CD0;
	Sun, 24 May 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779638088; cv=fail; b=o3VSAJUSY2Bpx1pgL1ZV0Omr+sHj0D36CVC9k5N7GBTV20xBWlqeHxRm5zXE2wTvk+uCb5S6g65HBvLolvSE8r07BrB5TqT2UAG/YO8+hcPfUHfYUxspftZOO1cLweAz/E7TArfE3czhGVRK0DcWlH4oeZTS+tzpxzRIn2UtI9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779638088; c=relaxed/simple;
	bh=CwuTHHlnq9uky+j4dQBVMoIpTnswmBxTH5KhmEpG5X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlZv2DHl7UKMIJlDIEheLS8yDZhcYD0txQaow+tQzMb8qZyPa7WXoLfZ0ZIkrumutcyzT+a1GKpbJBu3P3mNhp6Rd64/KmV0Hmvw8z19I+3C40jMvXCAHi6BCENSnUHJWP5qvbBzTrm9UlYlQGwkLHXXW+GUSr5A5uv9cj0ZQq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBYzEJYt; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk/gY2y59GsI8Bbn8elSHpvvKGBj6/JAkoC12pN1ZqTQeEkqo33FyZO0KTHNFph/5CD80UXZt7uPGQiJgie6bPz75UXXGzC6FYJ5E8YHR1fUx5Ybvys4zXCFH6G8UtcUj5dRNqpHXuL7i5kD5wJfX1HhHk7wMjT8KY1VVJF7Cg2/2y880xUBiiobAtfLstholGwBVhfjQ4gMxzCNSzzqyJQnxQXpVd6Rfv3lUF/Jh1IndHLJVf+AoppwAr1MlJQacwlF6qQd47uw7P4Pe7WGahczwWWdVckvqG//597P65fJ96HhajoT6mNbu5j1XwCHIHxqmJyysd/Ui0nfaTT5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi+5ivgusP++4atwmu3rlblexAd6i36anp2857QyqdQ=;
 b=YdtFjqYWjjV5SCmS4WfjfPJObrdK8CB+O92iMNfDYaABqAZGo/BRk/xKnXOaPArOCT4LKkyYbQZBby2lFMIbwQJXoM6q0lPl+ZxltP9QBn5bqM7ewCfmF/dAbjK1GgOMkdb4oDF4X0HUPosc8eibO71DaILEqC7hBNMKVDZVbScJ1QnP1l7SdV9K+xDpStgQQCBIBV4iH8mHSzdfXA29jMNWd2OiwxKBNp37kjYRC7gQ5ShvYOmBqUyRGfyLtUBvWdt5KC1BLBlN2U59R9iJRRPuHkmgTajaz3nID7zhVQa8SZ6DL21EqaIIFD/1ZcJHFBzpu8a04XUBu5z3ntpvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi+5ivgusP++4atwmu3rlblexAd6i36anp2857QyqdQ=;
 b=tBYzEJYteaJcJbed1w+pikVJpsPI7itk0XYRXyEcpxrlTSlc+mGjtutwLWlA0wLgidCRUZNQLH+O/uiO7eeZnKv/dXEHY3lpEahUUj/0jHAN7N+0yLF2WZu909KE5Qru5x/8rph4QGE4LDhH2LRE9u2GKewaUlUe8Kv2OsDfR5DYD/9txAdJzVOEr8H4LqIMAlnvCGYcYi5rPugnbMUH3/bsGpaGR45hHqTyXUWCobnwjyU1u6sspad2tjvS4vGzE4M0RcfYqLH1iz0d7AjIcXIKBD5g2knajDggRVnc3hbdbofTHGHOXlvBmHQ8CwlgjTgR8FrPIM2gOiBVD63l9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:54:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 15:54:43 +0000
Date: Sun, 24 May 2026 18:54:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: List iterator used after loop in mlxsw_sp_fid_port_vid_list_add?
Message-ID: <20260524155433.GA106863@shredder>
References: <20260522154125.121895-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522154125.121895-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: cf10724b-4e1b-45d4-2b90-08deb9acc5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	A7PmxKK9cLFHkCCnE6H8Xyh250u3OjBaPAI96Kn92Roh/486RUkn0NqItdn9ELa+GG6b3+BThK5Dt8TBm90/9BXO3jGA2ntTs67uUgaco3jT3XK2+WhBkBhe2T65NmzyP5VwAtwtu3efa+0UALMaASiu0zNZeBMmYmxX3Z1SNs8GQVpEfRPK1GH5ponwSEYmzQB4DDcYuJzggu7mssxV9sUlBDpIGPkrBChlaCBp6uUR6VWtCQc87uDdHqneUGa+nf+XIM6XY0zSTVVZjiuyTOmj0jmFGbk3fy7Fn1YnTvZZ1j35ABcMZBBgbJSR7tuZWoE0bMpD8dgrlnWzuaLzCiZwYp1zJmZkwmGSrj0Uvj+6aLKvDxK5jF4hGeJ/9w9lTC4VjAk0boWIu+4Rg5W2dPj0XPoBoWdPneT9UpV+rcY0DQEntVN6kmKSEih8RxeU8F3B4RWrXDkUliI6/CDKYrPSaE2HnBnHqGN/f4d/uXvjFap6+GK/KSxkNFSO+aS8Kgy6gNwu7dQGVIx5L6NQWP8SC2RQcvK8LgCtCXpYNIUw3N+A9Xoy/5K3png/y6ydBvz9W6AZ4QQ3twkQV/A3qJAHcOP4pf8fCAG/9bY0Z2cGlIMcq8FC8QzHiDNK6Hrjy02YK08zZMsMUFaWH4IKFdieowzeIe7fA7tixVD33gTUxYO6WGPeTpufkO0ApEOk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6olNvDERR00ZFWAY9usZRMvP5S4C1UHaOpzP8VCP9F+1cJIwTDiBIXTjglxb?=
 =?us-ascii?Q?yGmvss5BsnQrGcY3ZDewoeUN+KnHlVaoFe36KxtRYU94Xqy7Xjn9Cee6y200?=
 =?us-ascii?Q?JBVOgTZ7KY7SUYh2XMMkrZumyuntx/OYhJkM+5RBY22A4dDT+XRNP8xOYmFX?=
 =?us-ascii?Q?KTju1OVc5La7vqYoaBVa5YubhoAXQiUHD6sVtUrq3J0WSwQd2DB2pu1HsHct?=
 =?us-ascii?Q?iUBGXJLJua0XSjsETozwVqTQyPno7PeU21EXkKHzxfjj8C9UNr5aKsag7dcQ?=
 =?us-ascii?Q?WRrCWjZYwFj4WfUqApCSIlEH6TTSUtq1gzXPj8CXjfTn8SIuvTLMpFApkBFi?=
 =?us-ascii?Q?yVN2l3+BS617KnDQ5fe+U0UiuarsChJ7aQZJts2Q2c0tv2smQ1OL2x+nmmY0?=
 =?us-ascii?Q?neiwsjJBheekO8dcVzorwUa7zkb2qdjXY14YOytuEeOFaMoEljqAM7lrNL95?=
 =?us-ascii?Q?Asey2EbRvB1N4IBsC8IVGy2bKd/Y8cn++DMl+9RnIYgpK3R8V53uxC6fmWdm?=
 =?us-ascii?Q?jPX1dYuzKUozqpBSto7la4OWn0msy/YPoocmudoWKBcXSEVklfQaGMiXd05M?=
 =?us-ascii?Q?wvEiCemC4loKJr0xw03VI2wG6IRea0mW7SiqFvh0GN5bju/xEv3b8xA9Sopf?=
 =?us-ascii?Q?xVTz7QfzHz+nOXkXaQFm+LAYq7B3DHTZv37RK3upLybpMzk75OGqs66DbANx?=
 =?us-ascii?Q?gShria65yDeYNU8wafJl4L5YoAIiiYEJT/OcnKf7rg237ffQCl8uG8NfXNDg?=
 =?us-ascii?Q?hmG4oDNdX0JBtrsHrlISrwvVK0hqfzuR9Ni7iivkXClsSRQrkb4xi7UpwMw0?=
 =?us-ascii?Q?qZTSJvmfcYBFDX2ycKXPYU99xYGJ6kSBDsNLzPLFT+9fLAcziljLeRMcO3R7?=
 =?us-ascii?Q?e8N9Bb7NfHxZyP/WOIv+wNxmXeanyENW9tdUM3xkIMu6HrDyOac3IEeskM0r?=
 =?us-ascii?Q?nadAUrPnDiW4KWxwzp6arXo6dQt11C0xYqedrV+RbcYxMu9TabQg8E5jU12P?=
 =?us-ascii?Q?sNZI/mYZQTjsxIsLpMVPFpGX8bLQMc3EFncuFXcqqo4pzaO2SkAAm9hr7S/G?=
 =?us-ascii?Q?TnYKEZVYoAImbmEqQ/RPIMXNTOaapo2pKJ65KKgd0aiRGlPp/WFJYSUX5Rt+?=
 =?us-ascii?Q?vdD6zRxd7/Om7yBDfb54itaFwsuLeWhQU7sBQXxOvHD8qaRHgc7sIfJYHyfZ?=
 =?us-ascii?Q?F8/S8wDA2V3VZZio72HkCM+fE59cAVrRUpFJQGbW/pgqnYu85lMYKhqMdkq2?=
 =?us-ascii?Q?xHgAZRizirhTT0urNg4374ynURuFVPVcxjkSBy3QjFgLNuDt1JF+BM0Kj43w?=
 =?us-ascii?Q?EJEieZZC9KuRkwIGnMjVyJ7xB+Uf6zxafUNWhtSY8TcZDDaj2P9H+IKwZbFU?=
 =?us-ascii?Q?79hyE3auZwAYB8qbSmW+NfVy5l25GNHy68WtGz51dYmBjETVubkapM76WlxA?=
 =?us-ascii?Q?vcctAElJXwO24XzokJerIjeIGSi81FAGp/FBJdxcIXyZM3Ak590uUdcUoIXY?=
 =?us-ascii?Q?lcm9UkYu5OAxEe6azSqoOhuZPD2o2+SWGahQLJHdpU/IIj4ZpM1v5tbsI/Fs?=
 =?us-ascii?Q?+oyrgKUkq/fyKrxUdBZrUQrdbztaqx9GRSQZ8hSFbPbBujASNH6T3hxstxp1?=
 =?us-ascii?Q?l0qmeSgt3CyFvmb4rh3d0GZjJ3tCW9w4HVRS/McUHOyuuMuCNFNh64vW/PZP?=
 =?us-ascii?Q?cjNX3KjKjEd9MKWm0bQzQx9MHAQ4W2JINF5EMkDFWS3qq9+A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10724b-4e1b-45d4-2b90-08deb9acc5b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:54:43.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CloqG0rl0klqUG3ctINeKzwmvFjKX3em5WQbTxtoVidPWn0R8e2GFWTfXx2R8HxAxemzfxgP9U9Hq5hng3YCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
X-Spamd-Result: default: False [1.34 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291200-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: EEF475C300D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:41:25PM +0800, Maoyi Xie wrote:
> Hi all,
> 
> I came across what looks like an iterator used after the loop
> ends in drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
> (linux-7.1-rc1), in mlxsw_sp_fid_port_vid_list_add(). I would
> appreciate your input on whether this is worth fixing or whether
> I am misreading the pattern.
> 
>   list_for_each_entry(tmp_port_vid, &fid->port_vid_list, list) {
>       if (tmp_port_vid->local_port > local_port)
>           break;
>   }
> 
>   list_add_tail(&port_vid->list, &tmp_port_vid->list);
> 
> When the loop walks the whole list without break (the new
> local_port is larger than every existing one), `tmp_port_vid`
> walks past the end of the list and `&tmp_port_vid->list` aliases
> the list head via container_of() offset cancellation, so
> list_add_tail() resolves to inserting at the tail. That is the
> intended behaviour for the case where the loop falls through.
> The dereference of the iterator after the loop ends is the part
> I am unsure about. Same shape as the Koschel cleanups from 2022
> (99d8ae4ec8a tracing, 2966a9918df clockevents, dc1acd5c946 dlm,
> and others) and the "controlled container confusion" pattern
> described in [1].

By "`&tmp_port_vid->list` aliases the list head via container_of()
offset cancellation" you mean that when we don't find an entry we get:

tmp_port_vid = list_entry(&fid->port_vid_list, typeof(*tmp_port_vid), list) = 
	container_of(&fid->port_vid_list, struct mlxsw_sp_fid_port_vid, list) =
	&fid->port_vid_list - offsetof(struct mlxsw_sp_fid_port_vid, list)

&tmp_port_vid->list =
	&fid->port_vid_list - offsetof(struct mlxsw_sp_fid_port_vid, list) +
	offsetof(struct mlxsw_sp_fid_port_vid, list) =
	&fid->port_vid_list

?

> 
> I drafted a candidate fix that initialises an explicit
> `insert_before` pointer to &fid->port_vid_list (the list head)
> and overwrites it to &tmp_port_vid->list only on early break,
> then passes insert_before to list_add_tail(). The iterator is
> no longer dereferenced after the loop and the diff is 5+/2-.
> 
> I built spectrum_fid.o on x86_64 with MLXSW_CORE + MLXSW_PCI +
> MLXSW_SPECTRUM + NET_SWITCHDEV + VLAN_8021Q at W=1 and the
> object compiles clean with no warnings. I also ran a small
> userspace mock of the two versions across seven scenarios:
> empty list, single entry with the new local_port above, below,
> and equal to the existing one, and multi-entry insertion at
> head, middle, and tail (fall through). The final list ordering
> matches in every case.
> 
> Does this look like something worth a [PATCH]? Happy to send
> one if so, or to drop it if the shape here is fine.

Yes, please send the patch to net-next. AFAICT, the code is currently
correct, but fragile. If we ever tried to dereference 'tmp_port_vid' we
would have a problem.

Thanks!


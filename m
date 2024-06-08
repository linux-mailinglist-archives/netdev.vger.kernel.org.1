Return-Path: <netdev+bounces-101999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4F9010E7
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5391F21B61
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC717D35E;
	Sat,  8 Jun 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmqB7I4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03117D34E
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837314; cv=none; b=PAaIyAvUJhapCI2MBQ/jEZXP6B4Iu16MNC1GUXr2pyOuDXqJSX5kGf/m7gyeJzFqjL7TBQ4DuqT4t1FLT1tZGTPTQ258JnpQctDEKJTU80RTiiqiu7GfuoPtrITSXHjjv3Gq3vqMkAVGYtf2sgpXPGe1Hp6Dpzxf/aGu8WJLMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837314; c=relaxed/simple;
	bh=8JZQ3J6N4yPHAn/Ii/fcbQ1ADz1yJP7osgQWyIvN4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WomqXgPX96Rn++xJlh9Cj0XmCmSWiEukaV8K+NChJP2irLXz7StRrGfwsUiKBjT7/L3z3qr3MpDqQhgC/E6gaotcgONtoT9j3/oWZeEaIAIcYYiyEZPEI7u09AAhgvHdiRmqm33INlToOq4LdZan+i7kAcZ0oaQV0pMY9efHTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmqB7I4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F24C4AF07;
	Sat,  8 Jun 2024 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837314;
	bh=8JZQ3J6N4yPHAn/Ii/fcbQ1ADz1yJP7osgQWyIvN4xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmqB7I4TUBkvEF6hoyEAuD10howINWVAlDsLrXdeTOFG7a/20oGUQxYU1vEnbwpt0
	 l8+ES7/kUqCK3n1XUREPFay6deheQYfOYihSzF8JQN/Zc1gsMn4wqsGOHUyDeIcR5p
	 HfSRcSJ0+Ro/P0q0TnQvUKkZs5eJs/Mn/GyRaJv1bie5zCAch62mzzjzOs0Q85XDGJ
	 mmzg5fVi+JA6emmZzoNw+3cNPlkmn6vAqUDfXxmdYp93jyiTHLS6F03BeflKHsOwYK
	 O5Be2HeXNkydZgnHLEJkwyt+sRobiu5X4bmvEhO6zpOK3KDFtluyqCNCgNAA2E+qS2
	 /OHZkyxuqWMpQ==
Date: Sat, 8 Jun 2024 10:01:50 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 5/6] mlxsw: spectrum_acl_erp: Fix object nesting
 warning
Message-ID: <20240608090150.GR27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <c0c27909a09b9a47e03beb643b83784f75c7952c.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c27909a09b9a47e03beb643b83784f75c7952c.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:42PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> ACLs in Spectrum-2 and newer ASICs can reside in the algorithmic TCAM
> (A-TCAM) or in the ordinary circuit TCAM (C-TCAM). The former can
> contain more ACLs (i.e., tc filters), but the number of masks in each
> region (i.e., tc chain) is limited.
> 
> In order to mitigate the effects of the above limitation, the device
> allows filters to share a single mask if their masks only differ in up
> to 8 consecutive bits. For example, dst_ip/25 can be represented using
> dst_ip/24 with a delta of 1 bit. The C-TCAM does not have a limit on the
> number of masks being used (and therefore does not support mask
> aggregation), but can contain a limited number of filters.
> 
> The driver uses the "objagg" library to perform the mask aggregation by
> passing it objects that consist of the filter's mask and whether the
> filter is to be inserted into the A-TCAM or the C-TCAM since filters in
> different TCAMs cannot share a mask.
> 
> The set of created objects is dependent on the insertion order of the
> filters and is not necessarily optimal. Therefore, the driver will
> periodically ask the library to compute a more optimal set ("hints") by
> looking at all the existing objects.
> 
> When the library asks the driver whether two objects can be aggregated
> the driver only compares the provided masks and ignores the A-TCAM /
> C-TCAM indication. This is the right thing to do since the goal is to
> move as many filters as possible to the A-TCAM. The driver also forbids
> two identical masks from being aggregated since this can only happen if
> one was intentionally put in the C-TCAM to avoid a conflict in the
> A-TCAM.
> 
> The above can result in the following set of hints:
> 
> H1: {mask X, A-TCAM} -> H2: {mask Y, A-TCAM} // X is Y + delta
> H3: {mask Y, C-TCAM} -> H4: {mask Z, A-TCAM} // Y is Z + delta
> 
> After getting the hints from the library the driver will start migrating
> filters from one region to another while consulting the computed hints
> and instructing the device to perform a lookup in both regions during
> the transition.
> 
> Assuming a filter with mask X is being migrated into the A-TCAM in the
> new region, the hints lookup will return H1. Since H2 is the parent of
> H1, the library will try to find the object associated with it and
> create it if necessary in which case another hints lookup (recursive)
> will be performed. This hints lookup for {mask Y, A-TCAM} will either
> return H2 or H3 since the driver passes the library an object comparison
> function that ignores the A-TCAM / C-TCAM indication.
> 
> This can eventually lead to nested objects which are not supported by
> the library [1].
> 
> Fix by removing the object comparison function from both the driver and
> the library as the driver was the only user. That way the lookup will
> only return exact matches.
> 
> I do not have a reliable reproducer that can reproduce the issue in a
> timely manner, but before the fix the issue would reproduce in several
> minutes and with the fix it does not reproduce in over an hour.
> 
> Note that the current usefulness of the hints is limited because they
> include the C-TCAM indication and represent aggregation that cannot
> actually happen. This will be addressed in net-next.
> 
> [1]
> WARNING: CPU: 0 PID: 153 at lib/objagg.c:170 objagg_obj_parent_assign+0xb5/0xd0
> Modules linked in:
> CPU: 0 PID: 153 Comm: kworker/0:18 Not tainted 6.9.0-rc6-custom-g70fbc2c1c38b #42
> Hardware name: Mellanox Technologies Ltd. MSN3700C/VMOD0008, BIOS 5.11 10/10/2018
> Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
> RIP: 0010:objagg_obj_parent_assign+0xb5/0xd0
> [...]
> Call Trace:
>  <TASK>
>  __objagg_obj_get+0x2bb/0x580
>  objagg_obj_get+0xe/0x80
>  mlxsw_sp_acl_erp_mask_get+0xb5/0xf0
>  mlxsw_sp_acl_atcam_entry_add+0xe8/0x3c0
>  mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
>  mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
>  mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
>  process_one_work+0x151/0x370
> 
> Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-185416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33515A9A429
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D240921177
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A12221283;
	Thu, 24 Apr 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3JH8gzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A195221275;
	Thu, 24 Apr 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479851; cv=none; b=SEGfFaASqwxXuJH3WLlAaXCRGF8flhZwfXwA5VP0OhRsaLvQarLh/OfeftmWP0ZN7d1vO/eOo2PgW7g9YYTZPrnaKsOnQGc8TJ+jotb9m92mNPzysK4aUy1vGtiQZIw6q9GcpO3gw7eBHipxp9cEngcVuwscVCTcOfu1NnYylYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479851; c=relaxed/simple;
	bh=5pu5utthE6h9IbcDSytc6jmqH+VEZNH56iXjmxeE4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWl/hcVLWZOuJI+fbFWQgPYI0SRwB4yBjwEOGAu5OVgD5Lr4Ta2x4idOlNuPM6WiuCfK32Pd/nBGjecMEUbHmRRPYzw8tq1Q3QRKQUF2NC/pR3SfJheLIg6oE5cJS7UxVAEWD9FqXC7Lg2/xvcTP/Nw5kFGJkV8BrsOjVo0zBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3JH8gzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59924C4CEEA;
	Thu, 24 Apr 2025 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745479850;
	bh=5pu5utthE6h9IbcDSytc6jmqH+VEZNH56iXjmxeE4eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3JH8gzLvkWoRojiIZRAGpAJ6A3P5yH8YCyCu66APW2Sx9m6ftHdKxhzUE+ZLpxZv
	 3aOCjbdcjvxW1fsjOjIEDcmiOfiN149b0TYrlLSl0XXapchFnegLiUZqC1QRRqtmTj
	 2kjCy+ApKHgiMF3NzxgauzvRT4LxTrbclQY0d3GZzmj6qdfVcgJz2Z8pF6Nmkq94T2
	 LPYdC39b8yj/RIlcItkORhJH2mZvUK//mNXDGwpZNrn8JeP9isZ4E7qlca30wC9J/o
	 7kd1++SaVxDJffhEAGPsLkyiQX9W4XKOJYphsrY08Wpd49IkEHF5Q9OO3qKpCUU6/j
	 aYoSKxLQOqeQQ==
Date: Thu, 24 Apr 2025 08:30:46 +0100
From: Simon Horman <horms@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org
Subject: Re: CVE-2024-49995: tipc: guard against string buffer overrun
Message-ID: <20250424073046.GA3047450@horms.kernel.org>
References: <2024102138-CVE-2024-49995-ec59@gregkh>
 <1eb55d16-071a-4e86-9038-31c9bb3f23ed@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb55d16-071a-4e86-9038-31c9bb3f23ed@oracle.com>

- me at corigine.com
+ netdev

On Thu, Apr 24, 2025 at 11:41:01AM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> On 21/10/24 23:33, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > tipc: guard against string buffer overrun
> > 
> > Smatch reports that copying media_name and if_name to name_parts may
> > overwrite the destination.
> > 
> >   .../bearer.c:166 bearer_name_validate() error: strcpy() 'media_name' too large for 'name_parts->media_name' (32 vs 16)
> >   .../bearer.c:167 bearer_name_validate() error: strcpy() 'if_name' too large for 'name_parts->if_name' (1010102 vs 16)
> > 
> > This does seem to be the case so guard against this possibility by using
> > strscpy() and failing if truncation occurs.
> > 
> > Introduced by commit b97bf3fd8f6a ("[TIPC] Initial merge")
> > 
> > Compile tested only.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-49995 to this issue.
> > 
> > 
> 
> Looking at the fix commit with more lines around the fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6555a2a9212be6983d2319d65276484f7c5f431a&context=30
> 
> 
>  	/* validate component parts of bearer name */
>  	if ((media_len <= 1) || (media_len > TIPC_MAX_MEDIA_NAME) ||
>  	    (if_len <= 1) || (if_len > TIPC_MAX_IF_NAME))
>  		return 0;
> 
>  	/* return bearer name components, if necessary */
>  	if (name_parts) {
> -		strcpy(name_parts->media_name, media_name);
> -		strcpy(name_parts->if_name, if_name);
> +		if (strscpy(name_parts->media_name, media_name,
> +			    TIPC_MAX_MEDIA_NAME) < 0)
> +			return 0;
> +		if (strscpy(name_parts->if_name, if_name,
> +			    TIPC_MAX_IF_NAME) < 0)
> +			return 0;
>  	}
>  	return 1;
> 
> 
> 
> both media_len and if_len have validation checks above the if(name_parts)
> check. So I think this patch just silences the static checker warnings.
> 
> Simon/Dan , could you please help confirming that ?

Thanks Harshit,

Looking over this with fresh eyes this morning I agree with your analysis.

I can't be sure what I was thinking regarding this being a bug when I
posted the patch in August. But that it was for net-next, rather than net,
and had no Fixes tag, indicates that I did not feel that it was a bug fix at
the time.

https://lore.kernel.org/netdev/20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org/

In any case, I don't think it is a bug fix now.


> 
> Thanks,
> Harshit
> 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Fixed in 5.10.227 with commit e2b2558971e0
> > 	Fixed in 5.15.168 with commit 54dae0e9063e
> > 	Fixed in 6.1.113 with commit 80c0be7bcf94
> > 	Fixed in 6.6.55 with commit 12d26aa7fd3c
> > 	Fixed in 6.10.14 with commit 2ed7f42dfd3e
> > 	Fixed in 6.11.3 with commit a18c7b239d02
> > 	Fixed in 6.12-rc1 with commit 6555a2a9212b
> > 
> > Please see https://www.kernel.org for a full list of currently supported
> > kernel versions by the kernel community.
> > 
> > Unaffected versions might change over time as fixes are backported to
> > older supported kernel versions.  The official CVE entry at
> > 	https://cve.org/CVERecord/?id=CVE-2024-49995
> > will be updated if fixes are backported, please check that for the most
> > up to date information about this issue.
> > 
> > 
> > Affected files
> > ==============
> > 
> > The file(s) affected by this issue are:
> > 	net/tipc/bearer.c
> > 
> > 
> > Mitigation
> > ==========
> > 
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating to
> > the latest release is impossible, the individual changes to resolve this
> > issue can be found at these commits:
> > 	https://git.kernel.org/stable/c/e2b2558971e02ca33eb637a8350d68a48b3e8e46
> > 	https://git.kernel.org/stable/c/54dae0e9063ed23c9acf8d5ab9b18d3426a8ac18
> > 	https://git.kernel.org/stable/c/80c0be7bcf940ce9308311575c3aff8983c9b97a
> > 	https://git.kernel.org/stable/c/12d26aa7fd3cbdbc5149b6e516563478d575026e
> > 	https://git.kernel.org/stable/c/2ed7f42dfd3edb387034128ca5b0f639836d4ddd
> > 	https://git.kernel.org/stable/c/a18c7b239d02aafb791ae2c45226f6bb40641792
> > 	https://git.kernel.org/stable/c/6555a2a9212be6983d2319d65276484f7c5f431a
> 


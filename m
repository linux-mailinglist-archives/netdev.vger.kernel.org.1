Return-Path: <netdev+bounces-183768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F25A91DE8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0FB174F7F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B4E2459C1;
	Thu, 17 Apr 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atM9hhj5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apbQAm/f"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88355145B24;
	Thu, 17 Apr 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896337; cv=none; b=n4A3Nsm06U1R/nSHaIIAmRsHRev8jMGtv8dhabfFUm+I+5gkkrITkaEWUV4SQ/4Fz5JE/6S5XRPtzSjsFao9Q6UBTcffirrmdFz3uKAR6EJ22gsCyLmDjkTxlCB9+wB7iQbZEsRDlxqRcfCPLDvw5lClE7yzhM/7UnTsFYE87gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896337; c=relaxed/simple;
	bh=q4NaoZ7xo8oEWEmB7VZfKkCNv6lU6m3qRhv6S7Jtzek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7F7f6pVKb9dBePZkj80HCkXJXPhnfQzIXRJhSsF96EbiJ5JHDM2sc2TKoOOAuQtOtLYNfL32ZpvBYLO+nXaZQ2LXCCjcX/dGn0e3oYoHl3/TTEqgSRdooC3r6ByKlFB97W8OSKHY3QsMahCiWO9/qb0IuCSY7Q3mjYnnVSvEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atM9hhj5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apbQAm/f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 15:25:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr5wU54Em1g7dKQEZ9qB5ewpkVtvVqUjyzBHzxBb3tg=;
	b=atM9hhj5lPTJyR/eGBDgoSMwq2J595tlcLd5d59/iJGNDj4f0+4i3LB6cTsb8MQUESpKyj
	xVEK56OAPKXLYcwvEGmb4r+y+3NemSIgGX6IUoekkl1x3yBLab7u3uJkDcxO4+mynmLxIy
	jcjusRa2pFMeWYeiy9aeM8l7wjIwdBfi1DVGEjYGTspjtYNtaXYZ6Ka9TPgNWpWn8o25ys
	cSfIiqWgp19CiMplq6DiYoma7bKEtYIJu5rg2+ZrmC0p2x9FeZy7hXVM6KwNsrHcVDQh9W
	mLA31UlKU6mZr+YgWKU/elODr9bw6Fua7yF5ingCYbcQP1wKniPKGwXaHtajvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr5wU54Em1g7dKQEZ9qB5ewpkVtvVqUjyzBHzxBb3tg=;
	b=apbQAm/fv5JshfD7bvoxqlQ1OxRVIYnQD2RXMNAjoT+FfwnFDtjbpU+02tQJcP5CrQIfCG
	sXABnWYuO3OykuBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/8] ref_tracker: don't use %pK in pr_ostream() output
Message-ID: <20250417152453-5cb4e42b-ec66-4150-a8f8-4ec7b4e06cc0@linutronix.de>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-1-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417-reftrack-dbgfs-v3-1-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:04AM -0400, Jeff Layton wrote:
> As Thomas Weiﬂschuh points out [1], it is now preferable to use %p
> instead of hashed pointers with printk(), since raw pointers should no
> longer be leaked into the kernel log. Change the ref_tracker
> infrastructure to use %p instead of %pK in its formats.
> 
> [1]: https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/
> 
> Cc: "Thomas Weiﬂschuh" <thomas.weissschuh@linutronix.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks,

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  lib/ref_tracker.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
> index cf5609b1ca79361763abe5a3a98484a3ee591ff2..de71439e12a3bab6456910986fa611dfbdd97980 100644
> --- a/lib/ref_tracker.c
> +++ b/lib/ref_tracker.c
> @@ -96,7 +96,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
>  
>  	stats = ref_tracker_get_stats(dir, display_limit);
>  	if (IS_ERR(stats)) {
> -		pr_ostream(s, "%s@%pK: couldn't get stats, error %pe\n",
> +		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
>  			   dir->name, dir, stats);
>  		return;
>  	}
> @@ -107,13 +107,13 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
>  		stack = stats->stacks[i].stack_handle;
>  		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
>  			sbuf[0] = 0;
> -		pr_ostream(s, "%s@%pK has %d/%d users at\n%s\n", dir->name, dir,
> +		pr_ostream(s, "%s@%p has %d/%d users at\n%s\n", dir->name, dir,
>  			   stats->stacks[i].count, stats->total, sbuf);
>  		skipped -= stats->stacks[i].count;
>  	}
>  
>  	if (skipped)
> -		pr_ostream(s, "%s@%pK skipped reports about %d/%d users.\n",
> +		pr_ostream(s, "%s@%p skipped reports about %d/%d users.\n",
>  			   dir->name, dir, skipped, stats->total);
>  
>  	kfree(sbuf);
> 
> -- 
> 2.49.0
> 


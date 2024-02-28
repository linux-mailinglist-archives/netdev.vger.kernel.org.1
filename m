Return-Path: <netdev+bounces-75554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781986A742
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A5928BDDD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D3200B7;
	Wed, 28 Feb 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCHSZhug"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08041F945
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091573; cv=none; b=EgJeY+C5n6gYDwSgU4fsoz8oyNpiUr+MuMJ08mNvc8sEjdh+1pyLuYKSOEv+W2IoQgBNe/MiuFxwrS6wul+iV3fQYUtarwXFAg76NCs2idalX6m4hsGUAXcwmPTJ0Kca18DWT1aw3sSjLoe56Vt3Oapy+Y6lZE1LmL9/XfAV/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091573; c=relaxed/simple;
	bh=0hQNEMGibcGE2Z1TikKygBSwxKm8ByArQghhA0ou+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVkiTDxmhMWaLQAzV2eLkvZuC/kCPLjKb/DBv0yxvtCi+8kmJ1N8xe9ERC7el5xkatqgJ/e2LVxAQZ15wl7EqU7Fe1P8MJn4gaV8sPUDldkebgZEOQrcOwivU05wwUrgGzw8BwBF9IbR+EynFjjgWomEi84L8adpcWkJ1O8mEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCHSZhug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14DC433F1;
	Wed, 28 Feb 2024 03:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709091573;
	bh=0hQNEMGibcGE2Z1TikKygBSwxKm8ByArQghhA0ou+ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCHSZhugjWJL+hlYAoH5sllco33hBHXiqiII2phO3xuMsruCSU+o9rCGLpcx9xwTW
	 k6PIYHcxA4SCuuOTctEj3uplFrIe0yW8Uaf6ZKZnLMWjB/NzQP/4gDeJrfCPjRuI0q
	 3xQaB9/Tr3VlPAI8ODxHMeLMLJ7sr9M893Sh0KuME7BPJzlh8vFuFD1oZvgHn5nQ2j
	 ZxZeAoiXCY9GtkoENYSbXMi4CJ5I76ItooJYT2OVGzhahUIKYOh5kxDwmIdGWZfowV
	 BmyvGvu5LIXTURVeJyZOCfRshp6bPu3YojAB5Wn9BIM+ee4CffhRySHPm9YtIZkQ5F
	 QIO7nbjN8Ojjw==
Date: Tue, 27 Feb 2024 19:39:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, <mlxsw@nvidia.com>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH net-next 7/7] net: nexthop: Expose nexthop group HW
 stats to user space
Message-ID: <20240227193932.7762464d@kernel.org>
In-Reply-To: <001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
	<001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 19:17:32 +0100 Petr Machata wrote:
> +	if (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats))
> +		goto nla_put_failure;
> +
> +	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
> +	    nhg->hw_stats) {
> +		err = nh_grp_hw_stats_update(nh, &hw_stats_used);
> +		if (err)
> +			goto hw_stats_update_fail;
> +
> +		if (nla_put_u32(skb, NHA_HW_STATS_USED, hw_stats_used))
> +			goto nla_put_failure;

Something's off with the jump targets here.
clang detects nest is not initialized and you'll try to cancel it

> +	}
> +
>  	nest = nla_nest_start(skb, NHA_GROUP_STATS);
>  	if (!nest)
>  		return -EMSGSIZE;
>  
>  	for (i = 0; i < nhg->num_nh; i++)
> -		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i]))
> +		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i],
> +						 op_flags))
>  			goto nla_put_failure;
>  
>  	nla_nest_end(skb, nest);
>  	return 0;
>  
>  nla_put_failure:
> +	err = -EMSGSIZE;
> +hw_stats_update_fail:
>  	nla_nest_cancel(skb, nest);
> -	return -EMSGSIZE;
> +	return err;
-- 
pw-bot: cr


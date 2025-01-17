Return-Path: <netdev+bounces-159233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED4A14DE0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842371665E1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F71F76AD;
	Fri, 17 Jan 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if3YGguh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAF197A92;
	Fri, 17 Jan 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110620; cv=none; b=TeT3VjiwEtNd3973xu/ZRsci7xlMwxLF7hLdmkrXfUTuBnx4+yGCkzDp70Xol5YelEhjPyeU4OJ8rt81xVtx/Vynj6Ne+4eBE1NBWJ6iGdEUhFkKW1EBIiU2rtoCCQNALTwVNT0o9QJuvmdh393Ei0iOF0voCJVUJx9spRkasBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110620; c=relaxed/simple;
	bh=YnL9Lry0apWXg6yYJ7GRxiM80aTmM8mfu7TQwviwweY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7hlBkWUjFYojxh9hZu8aLbe3cGRXG9rmoD6OMCBXuHh/Uni5RZOTTtQMxE4k2agZpXoJYP9PM1k3N3D/g1hFkbLMNtgM38n8U8Uv9EpCMjcfC7T44RLZrsFuuu80iCy0RP6BUCMhAHyJGAdz0RRtc8vFhkOh9YJkdaja/v0dBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if3YGguh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5450DC4CEDD;
	Fri, 17 Jan 2025 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737110620;
	bh=YnL9Lry0apWXg6yYJ7GRxiM80aTmM8mfu7TQwviwweY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if3YGguhUrb5dFaL0wV2Rp7B1P6FSDamjbGEhZu8bAwlibYRz/jreWfO0o15NZ0mh
	 yOhTgl7dz95hSJVk3EKwJcgAoFwGLx4unL53ValKEq6ns7gVojWAYmM1Ue12m4yWj4
	 eKDFAcLksYLlY+cS+3/dc3WssYzLxUWZ9aAS7cFt//YIgkDGynDqtR/iIzCgaoW+id
	 AKX2KOBQRDQMOd5UzI/HhIXlnm8KLZDpSJeIi+wN4HJqP0zp5A6uW06lFfhwv3dToM
	 ZIq9r8sLmoF+SODZstrgiKg+sRr7ZSO9DxP8E/uXRjOtBY6uTWb0FVuB0t9wviPN3n
	 SE74rpSaG0Kuw==
Date: Fri, 17 Jan 2025 10:43:36 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/15] mptcp: pm: add id parameter for get_addr
Message-ID: <20250117104336.GJ6206@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
 <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-11-c0b43f18fe06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-11-c0b43f18fe06@kernel.org>

On Thu, Jan 16, 2025 at 05:51:33PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The address id is parsed both in mptcp_pm_nl_get_addr() and
> mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
> 
> So this patch adds a new parameter 'id' for all get_addr() interfaces.
> The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
> it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

...

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 853b1ea8680ae753fcb882d8b8f4486519798503..392f91dd21b4ce07efb5f44c701f2261afcdc37e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
>  	return -EMSGSIZE;
>  }
>  
> -int mptcp_pm_nl_get_addr(struct genl_info *info)
> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
>  {
>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> -	struct mptcp_pm_addr_entry addr, *entry;
> +	struct mptcp_pm_addr_entry *entry;
>  	struct sk_buff *msg;
>  	struct nlattr *attr;
>  	void *reply;
>  	int ret;
>  
> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
> -		return -EINVAL;
> -
> -	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		return ret;
> -

Hi Matthieu and Geliang,

This hunk removes the initialisation of attr...

>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
> @@ -1803,7 +1795,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
>  	}
>  
>  	rcu_read_lock();
> -	entry = __lookup_addr_by_id(pernet, addr.addr.id);
> +	entry = __lookup_addr_by_id(pernet, id);
>  	if (!entry) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");

... but attr is still used here.

Flagged by clang-19 W=1 builds and Smatch.

>  		ret = -EINVAL;

...


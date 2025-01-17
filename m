Return-Path: <netdev+bounces-159493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282BA159E8
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A3168E06
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F01D8DFE;
	Fri, 17 Jan 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3VjgzKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82313B2A9;
	Fri, 17 Jan 2025 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737156493; cv=none; b=qSj+Y2rXTEnntqwTZr7GAsrpbIf72TSwqgg0gc2ll8ZRlvyLtd2aCQ3cUxOjoUMTuBnz7iXEkdyNLdnWJx0mytR2tlyoqgvzmyy4GV6X5phgWmDfdmx7c9H6mDZAddRXYvAilALb+J5MeA3QD5y5UJPgIIZ/aufxwWbM9Y7XDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737156493; c=relaxed/simple;
	bh=LP93rSSFnxX0tUZIlbQFQ6C41OJO+7z15DIUPT5O0x8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eS/xwRLb3hFQDJmJyQVLqoYQou8uCEEzmwRdvMWmU5QTzMOw5AsDhkKCg9dpJXGCX+FUjzFbnhXNE+sQk/Q6I6lGl+RRJq1Ze4/UqPmObdoOy+/ie8P+B0eCFKkUJCWGcw7NUZIi8KHX/OiH8YpAPNs64yeBtvGVzK1QsvzYm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3VjgzKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF3DC4CEDD;
	Fri, 17 Jan 2025 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737156492;
	bh=LP93rSSFnxX0tUZIlbQFQ6C41OJO+7z15DIUPT5O0x8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=g3VjgzKmcduqWMBudcrmcX1NrCB3ev7rCO0LlyT/C6b50rxsjeDjGe8hFfOCefbLD
	 Notcp9+I0qZPBv88hN6RI+RZo0l2B1bh2O3qHiSIxnJyv9pJShdllK3k3yNmb0KQfw
	 98rsXcx0xzBQ7QCC/0e5NxKdBIkKjsDywSps7PFHqqVo8Ol8DcIhxvwO0bsivIUMKT
	 rqX6ACqbCkJyJELdmYZOVBWSvv+P+2pTwd5i/A1VgGoh/oZH1OM8v/0qKYQ8kdOflB
	 QfnTkkoOJKVun2yztZp9/b8FEo5K4wfTLrVSRKLf2AUIEDnfc4buPkFqsEPnfCeyd+
	 vaMRblNDJmJzw==
Message-ID: <ffa8b3d7fee95ab196fe35a3a3d855653fccfb9e.camel@kernel.org>
Subject: Re: [PATCH net-next v2 11/15] mptcp: pm: add id parameter for
 get_addr
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 18 Jan 2025 07:28:09 +0800
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-11-61d4fe0586e8@kernel.org>
References: 
	<20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
	 <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-11-61d4fe0586e8@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-01-17 at 19:41 +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The address id is parsed both in mptcp_pm_nl_get_addr() and
> mptcp_userspace_pm_get_addr(), this makes the code somewhat
> repetitive.
> 
> So this patch adds a new parameter 'id' for all get_addr()
> interfaces.
> The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then
> pass
> it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
> - Fix 'attr' no longer being set in mptcp_pm_nl_get_addr(), but still
>   used in this patch (no longer in the next one). (Simon)

mptcp_userspace_pm_get_addr() needs to be updated too.

> ---
>  net/mptcp/pm.c           | 20 ++++++++++++++++----
>  net/mptcp/pm_netlink.c   | 16 ++++------------
>  net/mptcp/pm_userspace.c | 14 +++-----------
>  net/mptcp/protocol.h     |  4 ++--
>  4 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> 526e5bca1fa1bb67acb8532ad8b8b819d2f5151c..caf5bfc3cd1ddeb22799c28dec3
> d19b30467b169 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -434,16 +434,28 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk,
> struct sock_common *skc)
>  	return mptcp_pm_nl_is_backup(msk, &skc_local);
>  }
>  
> -static int mptcp_pm_get_addr(struct genl_info *info)
> +static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
>  {
>  	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -		return mptcp_userspace_pm_get_addr(info);
> -	return mptcp_pm_nl_get_addr(info);
> +		return mptcp_userspace_pm_get_addr(id, info);
> +	return mptcp_pm_nl_get_addr(id, info);
>  }
>  
>  int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info
> *info)
>  {
> -	return mptcp_pm_get_addr(info);
> +	struct mptcp_pm_addr_entry addr;
> +	struct nlattr *attr;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
> +		return -EINVAL;
> +
> +	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> +	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mptcp_pm_get_addr(addr.addr.id, info);
>  }
>  
>  static int mptcp_pm_dump_addr(struct sk_buff *msg, struct
> netlink_callback *cb)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> 853b1ea8680ae753fcb882d8b8f4486519798503..f7da750ab94f7bbffafb258cb0d
> 6ff01ad59c0b0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
>  	return -EMSGSIZE;
>  }
>  
> -int mptcp_pm_nl_get_addr(struct genl_info *info)
> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
>  {
> +	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> -	struct mptcp_pm_addr_entry addr, *entry;
> +	struct mptcp_pm_addr_entry *entry;
>  	struct sk_buff *msg;
> -	struct nlattr *attr;
>  	void *reply;
>  	int ret;
>  
> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
> -		return -EINVAL;
> -
> -	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		return ret;
> -
>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
> @@ -1803,7 +1795,7 @@ int mptcp_pm_nl_get_addr(struct genl_info
> *info)
>  	}
>  
>  	rcu_read_lock();
> -	entry = __lookup_addr_by_id(pernet, addr.addr.id);
> +	entry = __lookup_addr_by_id(pernet, id);
>  	if (!entry) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");
>  		ret = -EINVAL;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index
> 1246063598c8152eb908586dc2e3bcacaaba0a91..79e2d12e088805ff3f59ecf41f5
> 092df9823c1b4 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -684,9 +684,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff
> *msg,
>  	return ret;
>  }
>  
> -int mptcp_userspace_pm_get_addr(struct genl_info *info)
> +int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
>  {
> -	struct mptcp_pm_addr_entry addr, *entry;
> +	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
>  	struct sk_buff *msg;
>  	struct nlattr *attr;
> @@ -694,20 +694,12 @@ int mptcp_userspace_pm_get_addr(struct
> genl_info *info)
>  	struct sock *sk;
>  	void *reply;
>  
> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
> -		return ret;
> -
>  	msk = mptcp_userspace_pm_get_sock(info);
>  	if (!msk)
>  		return ret;
>  
>  	sk = (struct sock *)msk;
>  
> -	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];

Needs to keep this assignment of 'attr' too ...

> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		goto out;
> -
>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg) {
>  		ret = -ENOMEM;
> @@ -724,7 +716,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info
> *info)
>  
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_userspace_pm_lookup_addr_by_id(msk,
> addr.addr.id);
> +	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
>  	if (!entry) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not
> found");

... since 'attr' is still used here.

I just sent a squash-to patch for this to MPTCP mail list.

Thanks,
-Geliang

>  		ret = -EINVAL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index
> 7fe91a2e170dd40a830c4301960b484017fd11d2..e77920c932442ce1d317fcda8d2
> 561e11d0c2a12 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1132,8 +1132,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  			  struct netlink_callback *cb);
>  int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  				 struct netlink_callback *cb);
> -int mptcp_pm_nl_get_addr(struct genl_info *info);
> -int mptcp_userspace_pm_get_addr(struct genl_info *info);
> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
> +int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
>  
>  static inline u8 subflow_get_local_id(const struct
> mptcp_subflow_context *subflow)
>  {
> 



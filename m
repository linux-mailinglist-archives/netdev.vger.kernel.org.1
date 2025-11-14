Return-Path: <netdev+bounces-238669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC1C5D305
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48E613529EE
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FC23EAA5;
	Fri, 14 Nov 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ghEVhZwM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNagvqi4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D045212FAA
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125015; cv=none; b=BhyX7enbMBFkdX+bgJf7x60L67HSu7VKkDjuaUyPW/fa7zNDLucBz0not6a8NWEtpQklqU1E0ks5P+8/6e1qszZSyq17yK6tJtR/HDBlZmj0K6FH8owI3aGokIlLBz1JuUevDs7Fdn0XFSIr2a+HFLfcmuNZ8igGQYBur1edLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125015; c=relaxed/simple;
	bh=UTku9nwDQaVR+pu1XDF7Fe1Y4umnqy/ePCHiKbXkjaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlgVr2degWtEmvqKjQBtWHHUMC/5hNCBMXAOfyCg16OFBKdadj2Cv4OzyruuUKWh5mkYjX+q7SyF3dkf6c/PcuUFvk62GMYAgJb9TbHSbM8CRwK3M7Kf+Nt1yza5Jo/H8wnu1bG4jtFSu+kd5OePETf4kny/j0kMqBW53jBrCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ghEVhZwM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNagvqi4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0382E140009B;
	Fri, 14 Nov 2025 07:56:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 07:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763125010; x=
	1763211410; bh=nozmRXu+m5XI7HSVkIswlrEu1gbQy0lrGOuBuqN2kUI=; b=g
	hEVhZwMG7gyRxsWBHlZ8PwZ9tZ6AI2TI3Qzc7V1fQeQSigEm9kiV4NoPL5uBTcrF
	DF3jXoLsc74kQ0YupEkNQhtr7caRGgvpeeUH8TlxvlshVo6pACSzusuuyx/X1Fux
	3Il/r/9vAcAJxMyRR/PXSPnyjH3WKwRIrgvTFZV/h6yWobyvOQhH32vpnJHfokGs
	Kh7Ekpf00OlMrQE7mXgMKBvvpYc0M1xUnlniZgdpn/qkG6Qa5fkj6mCU16Rz3v9U
	ZwuIdXjilLNrSAjy5da3mRlA/uUjHAxrEshXrJtK849k3YmHs1XTn7CA7OZgZxxf
	65tHJTf7xS6CTCkJKdaZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763125010; x=1763211410; bh=nozmRXu+m5XI7HSVkIswlrEu1gbQy0lrGOu
	BuqN2kUI=; b=lNagvqi4JwHkwwNCQPVqao45LjOzBhDKS7amVgpHWIQ6Dmd9n2U
	Biq/Qq5IjNVaCq5Kr+jmT92Fl7jKhOgZ6hLW5dOdMH83WEctZec2WIkDmsYvODDh
	TD1NyUYPIiQaVo2o18JPFAcMrd5PCeOTMB/8KYWn2YlRCJ3GTsBlc4ntfI4shWWY
	CsUGxleV+ZAcgGd41BzOiJUDePptI96AGJPU4ne78PPCKCOkkjFurTAN9dEjQ+Bt
	Ykei0ZtATu11DXohYmKl5vkqDxthVf8gOJ0WJ5iKgSeP/CiKVtWkgctdf6pzA825
	VvIVVw/sTwqUEaLhYn7iWbl6Xg7jadnz6+g==
X-ME-Sender: <xms:EScXaThz1e2NJcV8RBQBtBuPPwpnpntGVcJnkC5XWc9BNfgdWzV-zQ>
    <xme:EScXafmdJG8Ai6dCvB4fhVcRWwhOgsAnjA8lULiLFGjD_WSj7HcR1nK7XZDZb_Kr0
    5BfnHx9LKR5lr1Bg6i_VHFGYdUCrXpxcGHC_UOId4qRSE8ckY9J6Q>
X-ME-Received: <xmr:EScXaXaMjKrSWDZIXr6nq1Kl_xPYhq-AxtxJFjVFLF6KaKmtu6Fs_dvPEhv5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfidonh
    gvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EScXaSxSsvXOcpCDZRv6zBYyzE9pv2UU_DZD07wWIuiWkeS_AxLpVQ>
    <xmx:EScXaeYVDP54Dmvd1-m6hefbH6KyObanM5ImpLZNNbb6E9b4XZ6QKA>
    <xmx:EScXabwLDzIYY6WNl7MVSQeXSfSgOq5ThUwpLF5zS-Yef_jOrFqmaA>
    <xmx:EScXafGGCVt9Qt3wAh9ZQUr-JHT_tw9s4JIMlYUkxQFtPBKK4dx3Ow>
    <xmx:EicXaX_7G2FqpEX7eriVwScRoi5L5ncGqSmnCyHuTmCvXt424mDHeYJ->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 07:56:49 -0500 (EST)
Date: Fri, 14 Nov 2025 13:56:47 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH ipsec v2 1/2] bond: Use xfrm_state_migrate to migrate SAs
Message-ID: <aRcnDwyMn11TfRUG@krikkit>
References: <20251113104310.1243150-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113104310.1243150-1-cratiu@nvidia.com>

2025-11-13, 12:43:09 +0200, Cosmin Ratiu wrote:
> The bonding driver manages offloaded SAs using the following strategy:
> 
> An xfrm_state offloaded on the bond device with bond_ipsec_add_sa() uses
> 'real_dev' on the xfrm_state xs to redirect the offload to the current
> active slave. The corresponding bond_ipsec_del_sa() (called with the xs
> spinlock held) redirects the unoffload call to real_dev.


> Finally,
> cleanup happens in bond_ipsec_free_sa(), which removes the offload from
> the device. Since the last call happens without the xs spinlock held,
> that is where the real work to unoffload actually happens.

Not on all devices (some don't even implement xdo_dev_state_free).


> 
> When the active slave changes to a new device a 3-step process is used
> to migrate all xfrm states to the new device:
>
> 1. bond_ipsec_del_sa_all() unoffloads all states in bond->ipsec_list
>    from the previously active device.
> 2. The active slave is flipped to the new device.
> 3. bond_ipsec_add_sa_all() offloads all states in bond->ipsec_list to
>    the new device.
> 
> This patch closes a race that could happen between xfrm_state migration
> and TX, which could result in unencrypted packets going out the wire:
> CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
> bond_ipsec_offload_ok -> true
>                                      bond_ipsec_del_sa_all
> bond_xmit_activebackup
> bond_dev_queue_xmit
> dev_queue_xmit on old_dev
> 				     bond->curr_active_slave = new_dev
> 				     bond_ipsec_add_sa_all
> 
> So the packet makes it out to old_dev after the offloaded xfrm_state is
> deleted from it. The result: an unencrypted IPSec packet on the wire.
> 
> With the new approach, in-use states on old_dev will not be deleted
> until in-flight packets are transmitted.

How does this guarantee it? It would be good to describe how the new
approach closes the race with a bit more info than "use
xfrm_state_migrate".

And I don't think we currently guarantee that packets using offload
will be fully transmitted before xdo_dev_state_delete was called in
case of deletion. But ok, the bond case is worse due to the add/delete
dance when we change the active slave (and there's still the possible
issue Steffen mentioned a while ago, that this delete/add dance may
not be valid at all depending on how the HW behaves wrt IVs).


> It also makes for cleaner
> bonding code, which no longer needs to care about xfrm_state management
> so much.

But using the migrate code for that feels kind of hacky, and the 2nd
patch in this set also looks quite hacky.

And doing all that without protection against admin operations on the
xfrm state objects doesn't seem safe.


Thinking about the migrate behavior, if we fail to create/offload the
new state:
 - old state will be deleted
 - new state won't be created

So any packet we send afterwards that would need to use this SA will
just get dropped? (while the old behavior was "no more offload until
we change the active slave again"?)


> Fixes: ("ec13009472f4 bonding: implement xdo_dev_state_free and call it after deletion")

nit: wrong formatting of the Fixes tag


[just one comment on the diff, I'll look at it again if we decide to
proceed with this patch]

> @@ -533,36 +535,42 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_add\n",
>  				   __func__);
> -		goto out;
> +		return;
>  	}
>  
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		/* If new state is added before ipsec_lock acquired */
> -		if (ipsec->xs->xso.real_dev == real_dev)
> -			continue;
> +	/* Prepare the list of xfrm_states to be migrated. */
> +	mutex_lock(&bond->ipsec_lock);
> +	list_splice_init(&bond->ipsec_list, &ipsec_list);
> +	/* Add back states already offloaded on the new device before the
> +	 * lock was acquired and hold all remaining states to avoid them
> +	 * getting deleted during the migration.

Even with hold(), they could still be deleted (but not destroyed)?

> +	 */
> +	list_for_each_entry_safe(ipsec, tmp, &ipsec_list, list) {
> +		if (unlikely(ipsec->xs->xso.real_dev == real_dev))
> +			list_move_tail(&ipsec->list, &bond->ipsec_list);
> +		else
> +			xfrm_state_hold(ipsec->xs);
> +	}
> +	mutex_unlock(&bond->ipsec_lock);

-- 
Sabrina


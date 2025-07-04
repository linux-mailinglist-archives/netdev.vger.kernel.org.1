Return-Path: <netdev+bounces-204157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B111BAF944A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7A66E3E27
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14F306DBE;
	Fri,  4 Jul 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlB64oJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7079303DE9;
	Fri,  4 Jul 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635811; cv=none; b=Isx999XDm5ie4Q3bhEGbnjuppr+BawFi6A221NYhNDbg8nb4ESCLw8jf1awFNPq+Dw0HAIODesJDC08qkXxqF7I6hLPT5O4DdbDxs9U6v1XcO2M27JONG6Mfsf0dvn87DYX3p4BhEcjmRLpNeOl/8yukgALKEZ8XV8LCZ4G8NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635811; c=relaxed/simple;
	bh=3TJShfcgPgVDiAOqSjcv6639c1g5yfDzdsKl4BnWeDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAVk3pAJy37zTVTHnOd4PS+AsjrYKxmRtziGBt4iSZ2lhUMyTZms6ZeWu3Ro5YHjgIbbLcnmNHbQ6sA/9dYyaVwae012h1kwdCvixNHkjlthDS4INxJYYzb9kjwH6cJXNe5zm5sQ0FguXv8/f0j6hUEzTE00CR918wFHFDnV1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlB64oJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F4AC4CEE3;
	Fri,  4 Jul 2025 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751635811;
	bh=3TJShfcgPgVDiAOqSjcv6639c1g5yfDzdsKl4BnWeDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlB64oJwHLb+6t102HcThFDTSceZXKq6RAhkl9YnvcTUj1/48ODP+AxTn4AIhi5SS
	 wgqg+glsT/bLoPm/jhdKp6MIJlDsO+qDp9Ax8SK5jLykl917XmiJv69YGTgVJXxs5o
	 XgUwyh8qpAQLI4KTBA0FFpCd0YjSoVPEvmX19+UG8ABPqeug99sqDYHQjvyc1mk7oI
	 7ZLJZ1sN6m9Dr8+PPYo4iRejBuzAa84q8F+5DBhaEltWxDOGmkYrVtI9GiziBT3bRa
	 2ZRQhuBWP36bOJkYnlvcF8CTaliy5cJUOCpo4RQ9hJmHx5ALw2pUvuZnMD0f676coD
	 WEz3lMLVJcHtg==
Date: Fri, 4 Jul 2025 14:30:05 +0100
From: Simon Horman <horms@kernel.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	florian.fainelli@broadcom.com, kuba@kernel.org, opendmb@gmail.com,
	pabeni@redhat.com, zakkemble@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: bcmgenet: Initialize u64 stats seq counter
Message-ID: <20250704133005.GN41770@horms.kernel.org>
References: <20250702092417.46486-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702092417.46486-1-ryotkkr98@gmail.com>

On Wed, Jul 02, 2025 at 06:24:17PM +0900, Ryo Takakura wrote:
> Initialize u64 stats as it uses seq counter on 32bit machines
> as suggested by lockdep below.
> 
> [    1.830953][    T1] INFO: trying to register non-static key.
> [    1.830993][    T1] The code is fine but needs lockdep annotation, or maybe
> [    1.831027][    T1] you didn't initialize this object before use?
> [    1.831057][    T1] turning off the locking correctness validator.
> [    1.831090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-rc2-v7l+ #1 PREEMPT
> [    1.831097][    T1] Tainted: [W]=WARN
> [    1.831099][    T1] Hardware name: BCM2711
> [    1.831101][    T1] Call trace:
> [    1.831104][    T1]  unwind_backtrace from show_stack+0x18/0x1c
> [    1.831120][    T1]  show_stack from dump_stack_lvl+0x8c/0xcc
> [    1.831129][    T1]  dump_stack_lvl from register_lock_class+0x9e8/0x9fc
> [    1.831141][    T1]  register_lock_class from __lock_acquire+0x420/0x22c0
> [    1.831154][    T1]  __lock_acquire from lock_acquire+0x130/0x3f8
> [    1.831166][    T1]  lock_acquire from bcmgenet_get_stats64+0x4a4/0x4c8
> [    1.831176][    T1]  bcmgenet_get_stats64 from dev_get_stats+0x4c/0x408
> [    1.831184][    T1]  dev_get_stats from rtnl_fill_stats+0x38/0x120
> [    1.831193][    T1]  rtnl_fill_stats from rtnl_fill_ifinfo+0x7f8/0x1890
> [    1.831203][    T1]  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xd0/0x138
> [    1.831214][    T1]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x48/0x8c
> [    1.831225][    T1]  rtmsg_ifinfo from register_netdevice+0x8c0/0x95c
> [    1.831237][    T1]  register_netdevice from register_netdev+0x28/0x40
> [    1.831247][    T1]  register_netdev from bcmgenet_probe+0x690/0x6bc
> [    1.831255][    T1]  bcmgenet_probe from platform_probe+0x64/0xbc
> [    1.831263][    T1]  platform_probe from really_probe+0xd0/0x2d4
> [    1.831269][    T1]  really_probe from __driver_probe_device+0x90/0x1a4
> [    1.831273][    T1]  __driver_probe_device from driver_probe_device+0x38/0x11c
> [    1.831278][    T1]  driver_probe_device from __driver_attach+0x9c/0x18c
> [    1.831282][    T1]  __driver_attach from bus_for_each_dev+0x84/0xd4
> [    1.831291][    T1]  bus_for_each_dev from bus_add_driver+0xd4/0x1f4
> [    1.831303][    T1]  bus_add_driver from driver_register+0x88/0x120
> [    1.831312][    T1]  driver_register from do_one_initcall+0x78/0x360
> [    1.831320][    T1]  do_one_initcall from kernel_init_freeable+0x2bc/0x314
> [    1.831331][    T1]  kernel_init_freeable from kernel_init+0x1c/0x144
> [    1.831339][    T1]  kernel_init from ret_from_fork+0x14/0x20
> [    1.831344][    T1] Exception stack(0xf082dfb0 to 0xf082dff8)
> [    1.831349][    T1] dfa0:                                     00000000 00000000 00000000 00000000
> [    1.831353][    T1] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.831356][    T1] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> ---
> 
> Changes since v1:
> [0] https://lore.kernel.org/netdev/20250629114109.214057-1-ryotkkr98@gmail.com/
> 
> - Rebased on the net tree.
> - Add <Reviewed-by> by Florian. Thank you Florian!

Thanks for the update, LGTM.

Reviewed-by: Simon Horman <horms@kernel.org>


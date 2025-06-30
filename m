Return-Path: <netdev+bounces-202560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D965AEE47A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0E41897795
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44844290D8B;
	Mon, 30 Jun 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkhtwQUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE4228EA62;
	Mon, 30 Jun 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300513; cv=none; b=pMGJ5RX52JyQrgXDJzGRVQqMfaQ5Mk5g+f54LDVuzCI3cMXFexyAEDb4c+SWmx4iUstXaVvtoJknvQSFsPoKqiODbvZpId/PRBdfX2mVQ4XvbnQ5uBXXS46uKf/mk4cwxMxQUoRsE8BX+hwnVWAypoom1fwBBxdj++h0bcr/wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300513; c=relaxed/simple;
	bh=aAJcl85h1GGheErFIPxRdYDG+JyvOJnsiJ610hkUTcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/jnVWryT+lnCOhqCiSi5OicStt47LZmKilLjangHw9XdCA+CFJX0m0pBFFX5S+0iqYrNE0WdONiow+eQDDVslQL7H+IQlyrDJihQKxuPosAQpfORqYJ/tbRFBgc3d5HGnXEzDwWYxz9J5eh0qx08jlJHZk/CbRH+wOjzKSeMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkhtwQUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA8C4CEE3;
	Mon, 30 Jun 2025 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751300512;
	bh=aAJcl85h1GGheErFIPxRdYDG+JyvOJnsiJ610hkUTcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkhtwQUL2DIZItcDoic3fTQmvzgkvyLY9kS0rA+3OlrcIMVbI+/RSYf6VxBy2tYTc
	 6S9i4M0vuh+GTp+OGzRSDJi2jtCJXHKuohfEPqI/Tco2mg2zdcM4BYkGwzvl7Jgqio
	 gTeBZBkfdo92/8cqGo3sf6qnSL1wDnECSdywyWvCkNZnpEYSPugwNxjvXT8Esq33VW
	 HXvZvNECUpQGUTvyEx45vZ+dGv2/naKGoTe50z1ZP/miZaw+yDF4G+aV8YJkD72VOc
	 +QyhfKURvnjJkpgQ85tD1+x4AlQD4eHWZMIouM9qV+HRUH67pIGPe44k6pPNTW+efD
	 tyMysMMIIXVYQ==
Date: Mon, 30 Jun 2025 17:21:47 +0100
From: Simon Horman <horms@kernel.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, zakkemble@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bcmgenet: Initialize u64 stats seq counter
Message-ID: <20250630162147.GJ41770@horms.kernel.org>
References: <20250629114109.214057-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250629114109.214057-1-ryotkkr98@gmail.com>

On Sun, Jun 29, 2025 at 11:41:09AM +0000, Ryo Takakura wrote:
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
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

Hi Takakura-san,

Thanks for your patch.

Unfortunately it doesn't apply cleanly which is needed by our CI to process
your patch.

Please:

* Rebase and repost your patch on the net tree

* Target your patch at net (as opposed to net-next) like this

	Subject: [PATCH net v2] ...

* And include Florian's tag in v2

* Post v2 as a new thread

For more information please see
https://docs.kernel.org/process/maintainer-netdev.html

以上

-- 
pw-bot: changes-requested


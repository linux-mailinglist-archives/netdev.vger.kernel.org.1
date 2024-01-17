Return-Path: <netdev+bounces-63912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE418301F7
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C48284F36
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00914003;
	Wed, 17 Jan 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oks2QhI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B013FF9
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482907; cv=none; b=QjiDL/s6tq5p4ayO187JcfAdBIP5KlFSUMyP/zPdcohyFcy7FH0dQSpmLjQM+SXBmCgebqtfKk2OUyE14q5nLGNI68dHkCq5BYCEEaX/+LhU6GVNFAkoiub7Ss51ejG1MfXtVyR49cMMnIeIfc550NDoTUoC61+AQgai3EEuiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482907; c=relaxed/simple;
	bh=UXWsvKC5Ik05m7M/0JlSdizVyiSyYUfxefm/9W3I0MY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=I5Pz/4fDOy38FKg8Kn278OJmUfcXUIMgikVbjnhPzLZLgfeO8KthimPH+SAOp10EBKGgF5YICSQCuSk2dqVjGXk4yybLQj0pxIjhDNqGQHZ7Go5HhV0ZJqqO94fB5lwlsW86YbEYogwJf+y4ohDBp5URarsQ+A+PHqDq72/hF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oks2QhI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A6C433B1;
	Wed, 17 Jan 2024 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482906;
	bh=UXWsvKC5Ik05m7M/0JlSdizVyiSyYUfxefm/9W3I0MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oks2QhI8e1Z7tWng1z43t8KMvlYGTUo5Zzn9r0NzgQECyiIv7YTaAaVwub8rUTUuk
	 S0erVvQ8D7FsJwyHVqepxOmg4nz6wqL+6iOUTATqa0ETABbsW/lxXS8PqA9QuNlAMc
	 nApgOmlFDUK6WR+/WCQ3j3X5d15KQjrF5Cmap5Tw81F8R6zQMidZBjh0KYnHxP5JB5
	 QAMT1WyVWvs9NXAAzhPnl6kGKE0TWZYW6Ci7ZEp3atPQNm8S3U1VbzOz8IOlKhNVR6
	 fyNcV9/kYAeDc5vPsZnkwhFh2oyRGNTmkMXL2+Xg5KpWkyRgmVk/CnFTAPJFVgliox
	 LtPlROWOdvF0w==
Date: Wed, 17 Jan 2024 09:15:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH net] net: netdevsim: don't try to destroy PHC on VFs
Message-ID: <20240117091502.GJ588419@kernel.org>
References: <20240116191400.2098848-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116191400.2098848-1-kuba@kernel.org>

On Tue, Jan 16, 2024 at 11:14:00AM -0800, Jakub Kicinski wrote:
> PHC gets initialized in nsim_init_netdevsim(), which
> is only called if (nsim_dev_port_is_pf()).
> 
> Create a counterpart of nsim_init_netdevsim() and
> move the mock_phc_destroy() there.
> 
> This fixes a crash trying to destroy netdevsim with
> VFs instantiated, as caught by running the devlink.sh test:
> 
>     BUG: kernel NULL pointer dereference, address: 00000000000000b8
>     RIP: 0010:mock_phc_destroy+0xd/0x30
>     Call Trace:
>      <TASK>
>      nsim_destroy+0x4a/0x70 [netdevsim]
>      __nsim_dev_port_del+0x47/0x70 [netdevsim]
>      nsim_dev_reload_destroy+0x105/0x120 [netdevsim]
>      nsim_drv_remove+0x2f/0xb0 [netdevsim]
>      device_release_driver_internal+0x1a1/0x210
>      bus_remove_device+0xd5/0x120
>      device_del+0x159/0x490
>      device_unregister+0x12/0x30
>      del_device_store+0x11a/0x1a0 [netdevsim]
>      kernfs_fop_write_iter+0x130/0x1d0
>      vfs_write+0x30b/0x4b0
>      ksys_write+0x69/0xf0
>      do_syscall_64+0xcc/0x1e0
>      entry_SYSCALL_64_after_hwframe+0x6f/0x77
> 
> Fixes: b63e78fca889 ("net: netdevsim: use mock PHC driver")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



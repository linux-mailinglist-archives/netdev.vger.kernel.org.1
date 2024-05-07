Return-Path: <netdev+bounces-94047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9A8BE027
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65FD1F2354C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE614EC77;
	Tue,  7 May 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH0y71ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645F502B3;
	Tue,  7 May 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079027; cv=none; b=oeUYNIUh1KJaA7ivDI+gTYLRXHMHqmz8Z7c2LZeJlh/O+e7XplNgEO2tewm1eSAluhIyEHrYVXKXe/+aoBVzzg5sgkeqwdasTWuYWf8MQsXXWk0KXD/qPrBQRGDFcaaK5KjcjmycK/UsKZSQ0NDxbIPIjuUVByrmJdcc0j4+goU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079027; c=relaxed/simple;
	bh=k7OVsW1CLhpS+Sgr4gaW6u0i/WxY3RLczvnY1bpnXJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cx5eRPTKO0zqr/jfVHBq5iZIXBfqlBMMiAGCjYGFuuDYg8aG+86m6JfAlmyIqwUbwlDVjLdX1x8nZ1w6x8QNkVQGxwr2G3DdDhyGsRquBzqRYvOQX5cB5JSBuFZ1TW0x9KdCj/nIkdswMUl2n2zHUL72GeShARMXhg6AzpUjIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH0y71ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A333C3277B;
	Tue,  7 May 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079027;
	bh=k7OVsW1CLhpS+Sgr4gaW6u0i/WxY3RLczvnY1bpnXJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KH0y71eySxSSRI3mzAnyQ/eExmgX+b/8gskMdb8lLE81Xr0ltANmmilripIiFpvwf
	 S5oOdFTRP+zp+vM+e12zZc34OCUg4Ns5oxufBmiB17745Dy3RFKrh3WER7bQmbRjWe
	 hAYX06cHPCGTSwK67M3ZiJPZXzxAhV0D6NJseYhVLrDc9sP53MD1NeA8ZLy+fTufmP
	 lnrq/ZlbalLSgvX4QsgCU7F4KS77V7R7fFEDnauSslGrtUpRjt6aNtK0vh4Qxji9V7
	 u4n7WS8+yzNfuHIUFEMe5veuvH9csRYfitoDKFegbbiZNiy/48JmZdJyCtSRn7RV9j
	 vmFcTX25kzB3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A519C43331;
	Tue,  7 May 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] Remove RTNL lock protection of CVQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171507902730.3484.10843035496334670534.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 10:50:27 +0000
References: <20240503202445.1415560-1-danielj@nvidia.com>
In-Reply-To: <20240503202445.1415560-1-danielj@nvidia.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 3 May 2024 23:24:39 +0300 you wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
> 
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] virtio_net: Store RSS setting in virtnet_info
    https://git.kernel.org/netdev/net-next/c/fce29030c565
  - [net-next,v6,2/6] virtio_net: Remove command data from control_buf
    https://git.kernel.org/netdev/net-next/c/ff7c7d9f5261
  - [net-next,v6,3/6] virtio_net: Add a lock for the command VQ.
    https://git.kernel.org/netdev/net-next/c/6f45ab3e0409
  - [net-next,v6,4/6] virtio_net: Do DIM update for specified queue only
    https://git.kernel.org/netdev/net-next/c/650d77c51e24
  - [net-next,v6,5/6] virtio_net: Add a lock for per queue RX coalesce
    https://git.kernel.org/netdev/net-next/c/4d4ac2ececd3
  - [net-next,v6,6/6] virtio_net: Remove rtnl lock protection of command buffers
    https://git.kernel.org/netdev/net-next/c/f8befdb21be0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




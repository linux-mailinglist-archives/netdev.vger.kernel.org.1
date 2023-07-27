Return-Path: <netdev+bounces-21712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50B76455C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438C01C214B4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B62538C;
	Thu, 27 Jul 2023 05:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79593D72
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44950C433C8;
	Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690435221;
	bh=nixmqmz0SCMUSGv4N/J4Quar1kf4vv7lNBNc5my/Fpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCZMERSfojTbTsD3y55DbQ99S1RNIBO1XzufCASIxPaMbTcDDRtxKYk2aMfJAtq8l
	 sjlsFrHZ64I95d3lCX9cWHzJAIMIV1yITlePpsUtTejXzt1hXBIt3bY6GcTpi7uA1H
	 TLOtsu0/BlcznPU9zq4Ynh/nF0y9kuXCLDUC2kjbu3ag9lXW6YDSchJUDw0xZs6ENu
	 Ab2OYvbXY0XvPwWgqNo3EMkQUwKcNRoJzK6K72E/6wqACFETKPuwgvolUpg5VIzlj2
	 OEEX+XRPs51BAT6Ni9ZIimdx38fd560tWuhtxo/qmibR+OFi6L1UT2ffKYfnR1pZ9D
	 je8aLz100eWMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25E0FC59A4C;
	Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043522115.2558.14440034474051213901.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 05:20:21 +0000
References: <20230725072049.617289-1-jasowang@redhat.com>
In-Reply-To: <20230725072049.617289-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 03:20:49 -0400 you wrote:
> A race were found where set_channels could be called after registering
> but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> moving the virtnet_set_queues() before netdevice registering. While at
> it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> not even registered at that time.
> 
> Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] virtio-net: fix race between set queues and probe
    https://git.kernel.org/netdev/net/c/25266128fe16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




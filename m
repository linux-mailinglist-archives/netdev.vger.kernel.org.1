Return-Path: <netdev+bounces-56879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248AC8111DE
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEB11F21425
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3642D62A;
	Wed, 13 Dec 2023 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIz4zDMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C52D610
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 12:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F453C433C8;
	Wed, 13 Dec 2023 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702471825;
	bh=eFhC9O2Gy6i01NbLtXmJ7vBhmoDN24YEW6c4/cSiYHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qIz4zDMUeXFN3WpMmqq8l5nJ9a53k6zUcIMvrJbp39N0TJkDVdMu8Q5TBsHYcTl3M
	 Q6jYnafwiiVfnWFP3tVG08XFDQZR4sni/O/jJ+9vp0oL0PISW4KKHkIuhx5r7qqTZQ
	 SfbTdO3Suh0xD+ob5Qrzx1xRQdbK6UjpyiZFi4CXBiF0IOxQXKxXhYKvoGX3pUfCwy
	 LCRC0ZXuiXFXDYadQC4jcmN2oyvHuciHThJ1zAhZSb7Uzb6vZ68uURZIiGfMg2G/u5
	 lwlrZdMJE7aAi8s5EwAMbeBebGY8jcvA2BX/dT1L1R76Nc4+PxqEtKDGlzys2+BmuQ
	 zNeHM3vKD1+Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87278DD4EF0;
	Wed, 13 Dec 2023 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/4] virtio-net: support dynamic coalescing
 moderation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170247182555.3175.1682697276950472639.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 12:50:25 +0000
References: <cover.1702275514.git.hengqi@linux.alibaba.com>
In-Reply-To: <cover.1702275514.git.hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jasowang@redhat.com, mst@redhat.com, pabeni@redhat.com, kuba@kernel.org,
 yinjun.zhang@corigine.com, edumazet@google.com, davem@davemloft.net,
 hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Dec 2023 18:36:03 +0800 you wrote:
> Now, virtio-net already supports per-queue moderation parameter
> setting. Based on this, we use the linux dimlib to support
> dynamic coalescing moderation for virtio-net.
> 
> Due to some scheduling issues, we only support and test the rx dim.
> 
> Some test results:
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] virtio-net: returns whether napi is complete
    https://git.kernel.org/netdev/net-next/c/7949c06ad9a8
  - [net-next,v8,2/4] virtio-net: separate rx/tx coalescing moderation cmds
    https://git.kernel.org/netdev/net-next/c/d7180080ddf7
  - [net-next,v8,3/4] virtio-net: extract virtqueue coalescig cmd for reuse
    https://git.kernel.org/netdev/net-next/c/1db43c0818e2
  - [net-next,v8,4/4] virtio-net: support rx netdim
    https://git.kernel.org/netdev/net-next/c/6208799553a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-61398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C88239D8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2745D1C24A38
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24982A2A;
	Thu,  4 Jan 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuAMuZal"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296FA47
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 00:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E4BC433C7;
	Thu,  4 Jan 2024 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704329424;
	bh=b5XyLaUAcZgSfEmT8O24P9aJLs8IpAEE7sNn62S7fbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uuAMuZalwkljpomD3Qewb+XptH0QTQQ85Z5en3bd90Z01BM8UqvdVKB2kOF7YR9fV
	 FCnL/wHVlaCwN0aguqqaP+/6nNh4o0iLzpqVFVstZMzprS7GpoHzOFeZr8q2eezWPT
	 t8LEeEqTqpV/A7/5kZWShojUsYCgjnT+ES+hd2MddxYplK+OEVKlynhDRHWeGG1y3f
	 UbY9xMJZhDcQsz5xQE9PWcusFZAUWUv8qzsll1LPN/ypqPjEwkKO9+QLbZwJNMd5wn
	 5LbA+QJIQ++ek4HLYK1E1GHrwnvvHl6pDnsLIm3PhHj+zl8WZ43AJ3gBQX/Lk9bRZ8
	 Iby2acuqoIJMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A6C5C395C5;
	Thu,  4 Jan 2024 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170432942423.843.16857792975524817110.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 00:50:24 +0000
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Dec 2023 17:43:33 +0800 you wrote:
> For rq, we have three cases getting buffers from virtio core:
> 
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
> 
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
> 
> [...]

Here is the summary with links:
  - [v2] virtio_net: fix missing dma unmap for resize
    https://git.kernel.org/netdev/net/c/2311e06b9bf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




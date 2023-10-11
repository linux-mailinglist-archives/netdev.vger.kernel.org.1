Return-Path: <netdev+bounces-39879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39667C4A5E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E9D1C20F09
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30A1802B;
	Wed, 11 Oct 2023 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebca44bT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74CFC1C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36BE3C433C9;
	Wed, 11 Oct 2023 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697005226;
	bh=PZ8Sbi4PFlSj/5kE7cayHGNrIQkZ2CKQkNdYT5efJm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ebca44bTxn5pFSwGOS41AeDWEPt7x3lV4yoxzGauqRtFCkjEwL1wH8OBfrVfvDek3
	 o8yL023kBcXRyps21uFcepHOBuj2CKqYuPT7kQEq15uo9rumiJ+s1SxyYlhGIkiw/6
	 1VCc4/qPKky/+W4zMlTM81CKw5GLannQZiS6THs3hc8Y0ACiOQPxq8yJCDwrqYJm2i
	 bEZ9iwGBMNYWPn42LNf6L9qnjRXePts1Ulmxr5n2evEkMTuJ2CeOXpcwoib9b3dgtL
	 ntDsNAyCJWm+11t4InGfF5RSDH2605nTdVV+JdtExkvA0RDZbRJIySDGpp5o3Eckqb
	 QPj25uVxoDobg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B8B1C595CE;
	Wed, 11 Oct 2023 06:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/6] virtio-net: Fix and update interrupt moderation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169700522610.29366.5456934830457693913.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 06:20:26 +0000
References: <cover.1696745452.git.hengqi@linux.alibaba.com>
In-Reply-To: <cover.1696745452.git.hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  8 Oct 2023 14:27:38 +0800 you wrote:
> The setting of virtio coalescing parameters involves all-queues and
> per queue, so we must be careful to synchronize the two.
> 
> Regarding napi_tx switching, this patch set is not only
> compatible with the previous way of using tx-frames to switch napi_tx,
> but also improves the user experience when setting interrupt parameters.
> 
> [...]

Here is the summary with links:
  - [v3,1/6] virtio-net: initially change the value of tx-frames
    https://git.kernel.org/netdev/net-next/c/3014a0d54820
  - [v3,2/6] virtio-net: fix mismatch of getting tx-frames
    https://git.kernel.org/netdev/net-next/c/134674c1877b
  - [v3,3/6] virtio-net: consistently save parameters for per-queue
    https://git.kernel.org/netdev/net-next/c/e9420838ab4f
  - [v3,4/6] virtio-net: fix per queue coalescing parameter setting
    https://git.kernel.org/netdev/net-next/c/bfb2b3609162
  - [v3,5/6] virtio-net: fix the vq coalescing setting for vq resize
    https://git.kernel.org/netdev/net-next/c/f61fe5f081cf
  - [v3,6/6] virtio-net: a tiny comment update
    https://git.kernel.org/netdev/net-next/c/c4e33cf2611b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




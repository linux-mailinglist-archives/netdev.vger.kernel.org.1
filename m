Return-Path: <netdev+bounces-21942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67E76557F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53C11C2168F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C427174F4;
	Thu, 27 Jul 2023 14:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031F16439
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E973C433C9;
	Thu, 27 Jul 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690466424;
	bh=2bTNQc5MpfY+nu6lV4GNaTeixnSKuwV1CMqEwjHRwgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTwpe72B41/7l9PPJq46UHg9VhxpuQp+1HgOtzSDX7XFMbGmLvBEXK8NdxGSWT8QI
	 rYzXEB+GJaIKhGfpcZyZR7xLF64cDgYC3FqhRXjw2Xqyja31M6m/dAtOwRfvdzlb3Z
	 A0e5+K6m0+m4ebug4f5RDGSIXarZs/sbl3Rfk77Wnoqd05dk4B0WlZ/Wm//pkwWfet
	 SXBRShxTFDEmUI6MoUDp3bRP62dkokyU4ZKy3u8oEl5WQ4YxhdbbgTX84zzxx/z4jy
	 5wKnenpcCSgKukAtlmEhI6oxDvZyYodg+ODqL1PBg4NGFb4zF2UkaEnzQpvu1tYQJQ
	 THeiDMHDdKS+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80D93C41672;
	Thu, 27 Jul 2023 14:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] virtio/vsock: some updates for MSG_PEEK flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169046642452.7106.8460568966889675148.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 14:00:24 +0000
References: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
In-Reply-To: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com,
 avkrasnov@sberdevices.ru

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Jul 2023 20:29:08 +0300 you wrote:
> Hello,
> 
> This patchset does several things around MSG_PEEK flag support. In
> general words it reworks MSG_PEEK test and adds support for this flag
> in SOCK_SEQPACKET logic. Here is per-patch description:
> 
> 1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>    1) I think there is no need of "safe" mode walk here as there is no
>       "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>       queue).
>    2) Nested while loop is removed: in case of MSG_PEEK we just walk
>       over skbs and copy data from each one. I guess this nested loop
>       even didn't behave as loop - it always executed just for single
>       iteration.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] virtio/vsock: rework MSG_PEEK for SOCK_STREAM
    https://git.kernel.org/netdev/net-next/c/051e77e33946
  - [net-next,v3,2/4] virtio/vsock: support MSG_PEEK for SOCK_SEQPACKET
    https://git.kernel.org/netdev/net-next/c/a75f501de88e
  - [net-next,v3,3/4] vsock/test: rework MSG_PEEK test for SOCK_STREAM
    https://git.kernel.org/netdev/net-next/c/587ed79f62a7
  - [net-next,v3,4/4] vsock/test: MSG_PEEK test for SOCK_SEQPACKET
    https://git.kernel.org/netdev/net-next/c/8a0697f23e5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




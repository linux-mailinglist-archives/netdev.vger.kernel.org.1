Return-Path: <netdev+bounces-41071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2307C98F8
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B1528187A
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCDE63DD;
	Sun, 15 Oct 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUz+ocZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16D63D3
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 12:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63950C433C9;
	Sun, 15 Oct 2023 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697373027;
	bh=i1YcrOqbwjKT/jMQfm28HMA/2YUC7i58f8iAS5jZh0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LUz+ocZc5wTID/nfn03/wnOkcADgmXIsDkR0/28y12nztBMcO7eG5uUN2SRzUWiJN
	 2IXM6dukmCdPC0fJa0b8Kt0vus1jukQj0Id9fyJy4UeN55s2JKowKitzDlOo5vBRxh
	 HNiwlGdTEJBI5iq4JWHio5VS7gF32HMpsEQJFTTEg2cwzR/931NZW14XJmyc4dCtE8
	 rY0HylHPxtt4Rj9sPIGFhipxrONFTCbwMyrw04N/Jmh+20TQfv+L86LY+kB+vmaxX0
	 z1eTdFf4/GTZSYvsgsFisN2Vwq97lNa+/5RAGbP1mdR/HuPeiMIXvOt463+Uj22B9h
	 QXdc08sRs0cqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4945AE1F666;
	Sun, 15 Oct 2023 12:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/12] vsock/virtio: continue MSG_ZEROCOPY support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169737302729.30024.1645018070157688379.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 12:30:27 +0000
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
In-Reply-To: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 22:15:12 +0300 you wrote:
> Hello,
> 
> this patchset contains second and third parts of another big patchset
> for MSG_ZEROCOPY flag support:
> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
> 
> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
> suggested to split it for three parts to simplify review and merging:
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/12] vsock: set EPOLLERR on non-empty error queue
    https://git.kernel.org/netdev/net-next/c/0064cfb44084
  - [net-next,v4,02/12] vsock: read from socket's error queue
    https://git.kernel.org/netdev/net-next/c/49dbe25adac4
  - [net-next,v4,03/12] vsock: check for MSG_ZEROCOPY support on send
    https://git.kernel.org/netdev/net-next/c/5fbfc7d24334
  - [net-next,v4,04/12] vsock: enable SOCK_SUPPORT_ZC bit
    https://git.kernel.org/netdev/net-next/c/dcc55d7bb230
  - [net-next,v4,05/12] vhost/vsock: support MSG_ZEROCOPY for transport
    https://git.kernel.org/netdev/net-next/c/3719c48d9a20
  - [net-next,v4,06/12] vsock/virtio: support MSG_ZEROCOPY for transport
    https://git.kernel.org/netdev/net-next/c/e2fcc326b498
  - [net-next,v4,07/12] vsock/loopback: support MSG_ZEROCOPY for transport
    https://git.kernel.org/netdev/net-next/c/cfdca3904687
  - [net-next,v4,08/12] vsock: enable setting SO_ZEROCOPY
    https://git.kernel.org/netdev/net-next/c/e0718bd82e27
  - [net-next,v4,09/12] docs: net: description of MSG_ZEROCOPY for AF_VSOCK
    https://git.kernel.org/netdev/net-next/c/bac2cac12c26
  - [net-next,v4,10/12] test/vsock: MSG_ZEROCOPY flag tests
    https://git.kernel.org/netdev/net-next/c/bc36442ef3b7
  - [net-next,v4,11/12] test/vsock: MSG_ZEROCOPY support for vsock_perf
    https://git.kernel.org/netdev/net-next/c/e846d679ad13
  - [net-next,v4,12/12] test/vsock: io_uring rx/tx tests
    https://git.kernel.org/netdev/net-next/c/8d211285c6d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




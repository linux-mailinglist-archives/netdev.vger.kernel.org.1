Return-Path: <netdev+bounces-34359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C107A36A4
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516E01C20CA1
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E663AB;
	Sun, 17 Sep 2023 16:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB95684
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 878ECC433C8;
	Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694969424;
	bh=75bPTpm9wsWhjLLscRsZmKkJmuZeVrTEofm/5LUVa2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mVZNe/ZneTCYdDvVZIdtwikaEPKu+9iz6rhIwinqo/LoWIkmLRQRdNYH1J9IRzkVp
	 ZVA/QCoZs0wQnaJ720Zxc03r0xF6fJWiAqvEwmhSQGwUzRuPhT730htqxtOH7Ykzrj
	 g58LLdmTPsxrr2f2ujZA+sdIprQ0f5PtCNe1sBT2N6OLmgF6tFub6rpGqm45SKiXFP
	 qsgf2p8rn4lozEdyCXFTikTJzEVynS2SBQr0XIIFxuXb3iWXo1klfubWgqFCfnUeaR
	 L6TjDwE1rf1gByJBuEA6PHuRIpdD7QnTLgItXIMD2DLE79UPX8+FaJ9/Owxz5RQkXx
	 aBxzkTPAab7nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71BD0E26880;
	Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] vsock/test: add recv_buf()/send_buf() utility
 functions and some improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169496942446.18728.7629668615433862698.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 16:50:24 +0000
References: <20230915121452.87192-1-sgarzare@redhat.com>
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 avkrasnov@salutedevices.com, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, bobby.eshleman@bytedance.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 14:14:47 +0200 you wrote:
> We recently found that some tests were failing [1].
> 
> The problem was that we were not waiting for all the bytes correctly,
> so we had a partial read. I had initially suggested using MSG_WAITALL,
> but this could have timeout problems.
> 
> Since we already had send_byte() and recv_byte() that handled the timeout,
> but also the expected return value, I moved that code to two new functions
> that we can now use to send/receive generic buffers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] vsock/test: add recv_buf() utility function
    (no matching commit)
  - [net-next,2/5] vsock/test: use recv_buf() in vsock_test.c
    https://git.kernel.org/netdev/net-next/c/a0bcb8357716
  - [net-next,3/5] vsock/test: add send_buf() utility function
    (no matching commit)
  - [net-next,4/5] vsock/test: use send_buf() in vsock_test.c
    https://git.kernel.org/netdev/net-next/c/2a8548a9bb4c
  - [net-next,5/5] vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET
    https://git.kernel.org/netdev/net-next/c/bc7bea452d32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




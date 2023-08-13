Return-Path: <netdev+bounces-27113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C561B77A638
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F9C280F9A
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADE79C3;
	Sun, 13 Aug 2023 11:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62705399
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B5B7C433CC;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926222;
	bh=c8lR1VkckMUblxvfn52yXRWq2YtEfvbINH9lexG/jtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TlFs6RIr1YH7Kt7j8EpYAwhRvfYfpiqX4Ae28Swle+ZWzvqeOs/8ZoSzgwFgk0XBE
	 wd6CSOdk5tgpAgxnSqMtP7lfw7K1oAAldToW7+7YxZdgmF45T8zbaAgTjxGHg8KPbY
	 7Hf8g6WDhVwoidXVFrgwNblnbotUoANz8rdRsH+vPBPBV4l+6zfJNxvR7hjLUS5A5n
	 FcLyZ/7sPCF9a+Gq2zgrzRLWQU3QzJG6GVzr62fC09CKbmctwGrthMnmW6JEBoNunl
	 x87YuA8pWstRBinhqf8vPMiQEvHaKuussp0YjLlt5z53V8pwkiGzC6D1HDzsv4VsEZ
	 tH9PKDwSz+9MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EC3DC595D0;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] net: tcp: support probing OOM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192622231.28684.15945374352153132817.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811025530.3510703-1-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
 imagedong@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 10:55:26 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In this series, we make some small changes to make the tcp retransmission
> become zero-window probes if the receiver drops the skb because of memory
> pressure.
> 
> In the 1st patch, we reply a zero-window ACK if the skb is dropped
> because out of memory, instead of dropping the skb silently.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: tcp: send zero-window ACK when no memory
    https://git.kernel.org/netdev/net-next/c/e2142825c120
  - [net-next,v4,2/4] net: tcp: allow zero-window ACK update the window
    https://git.kernel.org/netdev/net-next/c/800a666141de
  - [net-next,v4,3/4] net: tcp: fix unexcepted socket die when snd_wnd is 0
    https://git.kernel.org/netdev/net-next/c/e89688e3e978
  - [net-next,v4,4/4] net: tcp: refactor the dbg message in tcp_retransmit_timer()
    https://git.kernel.org/netdev/net-next/c/031c44b7527a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




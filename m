Return-Path: <netdev+bounces-19344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F775A52F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886791C212D1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA52106;
	Thu, 20 Jul 2023 04:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7B3D6A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBEC8C433C7;
	Thu, 20 Jul 2023 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689828019;
	bh=9lv271cgwlWDs4wr1HjkFOPA6jE3isrnGdNh8AFIWrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r6hv3uGg1+wAxnGQwjDI+6XR4gUhrhG1HVm2bpRw2oYLASiNSX6GMctIdt7C5AFIq
	 00iV/hNjItEQy2xTYOgZWPpSOyGFZGnANbWeib06Jv7RgGRbVNx43T3UUwI0NBLIe4
	 asPKoWcnFJnvUdtLdw4/QRVzuG0RPKkFf22vKhvpEv5bMJDXs/bImHVFUlxziiXXxa
	 yFQK1iw7DTEqf21RjKUMXFD1P+HYnWGQVAc4mX7npKx07jUNFkNZDdGYNg3yBYSVpg
	 iNSJURdJCXMOVsrpnVKyu/bFlG2HOkjMPrnedMj4zdDTBCvraestnd8A3kMBd8DE3S
	 GqzehW8Rito9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE6E7E22AE0;
	Thu, 20 Jul 2023 04:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: tcp_enter_quickack_mode() should be static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982801977.27392.10393897576226795716.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:40:19 +0000
References: <20230718162049.1444938-1-edumazet@google.com>
In-Reply-To: <20230718162049.1444938-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ycheng@google.com,
 ncardwell@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 16:20:49 +0000 you wrote:
> After commit d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP"),
> tcp_enter_quickack_mode() is only used from net/ipv4/tcp_input.c.
> 
> Fixes: d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Yuchung Cheng <ycheng@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: tcp_enter_quickack_mode() should be static
    https://git.kernel.org/netdev/net-next/c/03b123debcbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




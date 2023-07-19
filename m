Return-Path: <netdev+bounces-18940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B6759263
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABA1281700
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676C125D2;
	Wed, 19 Jul 2023 10:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59775107AE
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF98C433C9;
	Wed, 19 Jul 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689761420;
	bh=uN5Jay7MKpbUM1GRLyRl2cdt0YFB0Pis7GeiMlnYI84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IB9JwgrIvLgcALCglDKAMO8nH21yU+oQMGyWOAXSaG7bMzw+9O47eaXbqnzegN6Io
	 uG4mlf5wsKM5y0jdCpOJFROS0Ou57L23MA0hbibsOGud0Fc5ccBsR5JSLExinOp1F7
	 YaihazEcVfT47eCfIRTgI3l5kA9Mw3mWa/JE6+47f8TW5DlS88m59nZOhEMi32ZYNz
	 EfiZhED6u5/NKrGDHh6CxoEPia1N7lJtEUNUQncfTyCpqunlFmgW8f+rRv7zrDy32d
	 THBCphb4cECSOycg7knAV4Y+nHMv9FseIStykfTN5ELKXGgJ3bzKIX2BUHJMocZ9ao
	 bAnEG8DDlMfTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE00E21EFE;
	Wed, 19 Jul 2023 10:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: ipv4: Use kfree_sensitive instead of kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976142051.5988.8551185918272775357.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 10:10:20 +0000
References: <20230717095932.18677-1-machel@vivo.com>
In-Reply-To: <20230717095932.18677-1-machel@vivo.com>
To: =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@codeaurora.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 17:59:19 +0800 you wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  net/ipv4/esp4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net,v1] net: ipv4: Use kfree_sensitive instead of kfree
    https://git.kernel.org/netdev/net/c/daa751444fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




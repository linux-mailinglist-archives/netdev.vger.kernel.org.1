Return-Path: <netdev+bounces-25778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88677571D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC4E1C2114F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A2174E3;
	Wed,  9 Aug 2023 10:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9A17724
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2413C433D9;
	Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691577021;
	bh=qbspp0328vZLcetH1+KQHBQwIOPAmGQNXoLuQUhJeyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aq0FBdt9UhZOiZxSQ8y7RoSNrEFZQbk9LfIBk0gVNlugSC0oSC/LihHfrToE630Sl
	 NUdW5bSXHixzwmQrsdZElUu6H4KP7+dYlYn8W974Z3SDbJdEMONG/L7HZ8RZpLtJDj
	 kVwtpxUV2d6SJ2D1eZdFOH7qJd5+GFZOVYF8EIWOUmxjAIlM5jBE0A6fC47f+HVhBs
	 uyFOM0k59yH4tdwdwD36K7RJ352bdVbU5RbTdE841sosga4y6WYzt7PIXtAgIULZXK
	 Gy4xa+w4iZYU+AazHbhNSB5PuVnADC86rS1hTZHnGQbyNmA4NUjmXLt8E4/1lgv9pp
	 q6D8pOTfSrlTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CB60E505D5;
	Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169157702163.3448.7851235321094476296.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 10:30:21 +0000
References: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
In-Reply-To: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 15:45:36 +0100 you wrote:
> Different MT7530 variants require different PHY drivers.
> Use 'imply' instead of 'select' to relax the dependency on the PHY
> driver, and choose the appropriate driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: mt7530: improve and relax PHY driver dependency
    https://git.kernel.org/netdev/net-next/c/b9b05381e5d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




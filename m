Return-Path: <netdev+bounces-29917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D34785314
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0C28127C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3810AD26;
	Wed, 23 Aug 2023 08:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD7A922
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD98CC433D9;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692780622;
	bh=2XtfpRtDnIU/IzTymjZdBOGFulqWEEJEegtUUR1ce9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7z9mvY5R3DS5mkLH5PZtEUIAFTM05i2+DoUbuKfPU3yAIQoqbDmQPWhvgiPzPbYW
	 Pm//3oXZL/nMrPW/u/nXdPP2IPRpzFy7VUWo20p6R0ECA60iG2r6FqM62N5YWneWCf
	 CzaAzOIukbdjucIAK3utBZ0Z0CfWmGIL/9ueBTRLwo+TR4IwcbI5edM+U4gnlRAtWR
	 uHfM9iivmawwgnCvErdkm7xKrV7gTfDxGPnt9fcSXAWwZ/7COIBOEz6teFYtWFzgOR
	 w/OB3Sssah1IbxJ1Z6my723fnZN51lWJsu50a6wv/JKaLkkW2S7pDZo9k3niogfh0q
	 07/FxMFywcDAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF514E4EAF6;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: rzn1-a5psw: remove redundant logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278062271.13745.4624932060918576814.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 08:50:22 +0000
References: <20230822084112.54803-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230822084112.54803-1-alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: clement@clement-leger.fr, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 milan.stevanovic@se.com, jimmy.lalande@se.com, pascal.eberhard@se.com,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 10:41:12 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Remove debug logs in port vlan management, since there are already multiple
> tracepoints defined for those operations in DSA
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: rzn1-a5psw: remove redundant logs
    https://git.kernel.org/netdev/net-next/c/2e0c8ee2b56f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




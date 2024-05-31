Return-Path: <netdev+bounces-99623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DB8D583D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6572891FE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FBEEBA;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiQFP/7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E431EAC0
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119633; cv=none; b=o8ddDnpdW7DfGyzcUuuBXzzd/7WiF74xPe8uVTc/AInUHuCLtrbr8rBTTIEbMjI0ihk1VeXMpjAWP6ZhM+byvP2Ivjd7YTZmSKx8GUzcoxABu7j1eGxLsiptQD+P6yQQD70JBSU9ugRpSemHOEuO0rZorKZBQAU37ZhncC/w1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119633; c=relaxed/simple;
	bh=4MX+4QyA9aY/3tLLMNgCFcl/V8UrJJEv3wyQpCxZSU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCsKkBTdZeOm9EUMHeCS+6CRdf5IRamwpBzW6HRw9l9rRTXovblpRcZY0WYgBE5pPT5kqRJW2jIYRqnrvfF1UWRz8cOgorWg3fg+uEOd/2xr2L/RZY8jlQBlPBDnjXunyJg4V/k1sDDvrjKzAOUimcHOqi2GMAZh0DpqK+rfwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiQFP/7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06EF9C4AF07;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119633;
	bh=4MX+4QyA9aY/3tLLMNgCFcl/V8UrJJEv3wyQpCxZSU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tiQFP/7AtYOHf/cmqm3vzihtMQcTIPTfwMDEgiwMVwrzWqJWlNKA2EVwvxpRDRQ/d
	 D8lYvBABhsjsiVLB1N8lw8rGKLDFbU1Wn8qEXic2Xd0y9eSVrRHcKpWwRzBmpRKQ4j
	 dHKr7gEuAL3pBtky6ftDw4CUhxE4N5EdU3btjRLq8J8pvCj8Pb1lqXQZ+eCQyjrUsX
	 a2XH+33UKSwuTyAHHMnOcp1VSDZ3HdZB54yLT+hglhtuXo4fuLpOw/IM68J9sLMoQe
	 YwO+OP1brYj3BO9b62UPOlZSRwNC2GxSdz2BrtrGnATPBKm2b9WJO1TBheDqBPbT3/
	 98d0ORFyrdQlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB8B2D84BCD;
	Fri, 31 May 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: phylink: rearrange ovr_an_inband support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711963296.18580.14971727622513760852.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:40:32 +0000
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 joabreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, madalin.bucur@nxp.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.anderson@seco.com, ahalaney@redhat.com, fancer.lancer@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 14:28:42 +0100 you wrote:
> Hi,
> 
> This series addresses the use of the ovr_an_inband flag, which is used
> by two drivers to indicate to phylink that they wish to use inband mode
> without firmware specifying inband mode.
> 
> The issue with ovr_an_inband is that it overrides not only PHY mode,
> but also fixed-link mode. Both of the drivers that set this flag
> contain code to detect when fixed-link mode will be used, and then
> either avoid setting it or explicitly clear the flag. This is
> wasteful when phylink already knows this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: phylink: rearrange phylink_parse_mode()
    https://git.kernel.org/netdev/net-next/c/75518b0dc9d6
  - [net-next,2/6] net: phylink: move test for ovr_an_inband
    https://git.kernel.org/netdev/net-next/c/fea49f065c1c
  - [net-next,3/6] net: phylink: rename ovr_an_inband to default_an_inband
    https://git.kernel.org/netdev/net-next/c/02d00dc73d8d
  - [net-next,4/6] net: fman_memac: remove the now unnecessary checking for fixed-link
    https://git.kernel.org/netdev/net-next/c/5e332954e760
  - [net-next,5/6] net: stmmac: rename xpcs_an_inband to default_an_inband
    https://git.kernel.org/netdev/net-next/c/83f55b01dd90
  - [net-next,6/6] net: stmmac: dwmac-intel: remove checking for fixed link
    https://git.kernel.org/netdev/net-next/c/ab77c7aa9388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-117165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5094CF3A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08FD1C20D06
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC0192B6F;
	Fri,  9 Aug 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z50ORPdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235F16CD05
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201832; cv=none; b=EXgt49/Q7GGJ0myb/6S4ILDQQLfEMv91btXGK85mWuhtRNRackI0SbP/q3+5mOLmbZtg5u7lkg//sKYua6NHUmS0OMRm+v/8IxrvJVqcXUkdEZb6HFE5LZI0qJ31ccvsOU2xxfdFXeuCVx223SnUAHNvxS1ZfQqynkDGH5k0ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201832; c=relaxed/simple;
	bh=A8pQsQ6di4rD9L/EtXjxtoFGHujFl5v3FeWshS2LU6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FErFeb8OkNc2gvf/A+lYCW58qtau0Lh6ivKECq9b6lus0M/Fg0kkuufUSUm1s0AavOsGV9uum8hkuf49uccLAe2OUsq9UwiPJ4YD8SDwlnuaAG/0jdWjtYgMch8nwKHy29eUKj1GO4pLJxfC0iVY9rX1f1+QDfzHkuXVKJZCmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z50ORPdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBC8C32782;
	Fri,  9 Aug 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723201832;
	bh=A8pQsQ6di4rD9L/EtXjxtoFGHujFl5v3FeWshS2LU6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z50ORPdgrK5Py2zz2Sxk1PQx+Pfk661LL1zGqRGUSzpi2lyFVM8UehEQ/CaFYzRVG
	 hHIpaN7XNgpTG/GnFWXYbM36ZJZ6ZacyA0minomXvXA8uu3XQHP5Va0bFk81rW2iIi
	 p/QMx51gAKVKlK31E4giBgQ69XciQV3Jsb2t9ryGQ0JvQRR5YjpJbaxNIJxYdMFFgk
	 JciulCeQ3XHJfQfnyExiwl2gdEX0SIlj+AaK9Z31Bo0gepYR2Gp8nCM2gWrJIXYb1S
	 0QPpqjvyBlzo2lAmFJlXyeV3SGRy2mWF6y6UtYgm/ZuVRQxP9jtIPwsAW0/4HqPXrR
	 wzuvkMZ0D95cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDF382333D;
	Fri,  9 Aug 2024 11:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: xgmac: use const char arrays for
 string constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172320183099.3757285.11855803483879000767.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 11:10:30 +0000
References: <20240806-xgmac-const-char-arrays-v1-1-8d91ec885d45@kernel.org>
In-Reply-To: <20240806-xgmac-const-char-arrays-v1-1-8d91ec885d45@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexandre.torgue@foss.st.com, jirislaby@kernel.org,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 06 Aug 2024 11:52:01 +0100 you wrote:
> Jiri Slaby advises me that the preferred mechanism for declaring
> string constants is static char arrays, so use that here.
> 
> This mostly reverts
> commit 1692b9775e74 ("net: stmmac: xgmac: use #define for string constants")
> 
> That commit was a fix for
> commit 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels").
> The fix being replacing const char * with #defines in order to address
> compilation failures observed on GCC 6 through 10.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: xgmac: use const char arrays for string constants
    https://git.kernel.org/netdev/net-next/c/36fb51479e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




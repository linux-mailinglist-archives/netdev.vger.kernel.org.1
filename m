Return-Path: <netdev+bounces-139713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF59B3E45
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D2B282F64
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A220200CB6;
	Mon, 28 Oct 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAIacROg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB7200C99;
	Mon, 28 Oct 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156435; cv=none; b=pgcX+m60Eb6ws0fdk4KXl6/M0kP1SuUQnHvVKXcql2TE8twKHsq4vFiRIAi0Ge3JzIdWdnPsecPJU4NLF2FMPNd6/6VvZK3rSAbzHRlLVTTnLo/UR9laXUaXfJIZ3XQLwtyqmCl6uCUOHmo2SnQri+b2sEV3HAlghxblI/GnuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156435; c=relaxed/simple;
	bh=ENlzoJYfFx7FaBf0oThCRqau9ZFmBMcmjwk1wrLkgBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMUarNFanPJ22EhFoYsAR7EBzLcyC6neuG6G16lw0aU90lAWgQc9bH/3X9DHaIRv596sscboKKOXFJFzHfzOraYnJxRyciDaZquMz+liHJN6Zo5csdGibYikWFh6iYE29rSw3+YLIA8MU/a2VZDBinzgnX+Y/NgChr25zEzU560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAIacROg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F7DC4CECD;
	Mon, 28 Oct 2024 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156434;
	bh=ENlzoJYfFx7FaBf0oThCRqau9ZFmBMcmjwk1wrLkgBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAIacROg0Xoa2sXvk3Eso8bentd2zv7/xlp2viZFs7S5hhEXmkpIvz/5JLf0x+WAX
	 +mfJ7xy8psBxRq40GJS4sqJfY9slYS13uP/mD2W7N2sG1ZPFKL+z04S0yzcN4e75Az
	 9HaG1bGFc7ASP2vQ35FYriIxsdpTqpx5marAr5nwH2P2IyZAeegwhOQaX0fw0zWP5u
	 Oi/b8p3iaow1BFKj8NQXe6el7SfZ3MoNioYIgCedInhrQpFZJAg3tisSZSJ+lLU6h7
	 PRN/Bxd5m2UuzB6nR7YDfUjloYKBdfJ0G4TDAXjHbI+YhgbtOHS9pXmlMC7zXlS2k3
	 mKszLSnqAgGbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD0380AC1C;
	Mon, 28 Oct 2024 23:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: systemport: Minor IO macros changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015644200.206744.11510242764690126577.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:42 +0000
References: <20241021174935.57658-1-florian.fainelli@broadcom.com>
In-Reply-To: <20241021174935.57658-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 10:49:33 -0700 you wrote:
> This patch series addresses the warning initially reported by Vladimir
> here:
> 
> https://lore.kernel.org/all/20241014150139.927423-1-vladimir.oltean@nxp.com/
> 
> and follows on with proceeding with his suggestion the IO macros to the
> header file.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: systemport: Remove unused txchk accessors
    https://git.kernel.org/netdev/net-next/c/890bde75a236
  - [net-next,v2,2/2] net: systemport: Move IO macros to header file
    https://git.kernel.org/netdev/net-next/c/e69fbd287d5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




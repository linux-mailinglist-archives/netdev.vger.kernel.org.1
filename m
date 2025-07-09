Return-Path: <netdev+bounces-205224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD428AFDD44
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA35580A8A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701801A23A0;
	Wed,  9 Jul 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm+yJ3At"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B389182;
	Wed,  9 Jul 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026985; cv=none; b=qHWlOaICtwvQ+Ltd5JhmOBbjlvqWUMntoiG/LtnxK7fk1UTasKxWXNPB6VVQDJm/w9BOEhHsjF3vJtt0M3DfofvNnUJAydhgc0pMHLRi0EAiD8KmCA/Xqc/PSOtt74Eb+HECCaOAlezpZabph3UcPiTfoGUpibhNzqVlrv7hQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026985; c=relaxed/simple;
	bh=Tge18Np48taeWjJACOO6TUJgmCjNPLeql+dotgV6YSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZQMMG0awpdL2mwDAbOXERAAuP5MUiTi8cUaKUMVKS9ZMpjqbxKALKIuGRNyGBj45QXMbbGLmjvyRnR6lV5eVmHh4KzIPJXsp3nJpANo8Iw6kJepjnQu5JT/UZMGHdzw9zpTiCm4fNri3uehpH49oqFwHjyRyuiLZBCsKsG6wHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm+yJ3At; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B7C4CEED;
	Wed,  9 Jul 2025 02:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752026984;
	bh=Tge18Np48taeWjJACOO6TUJgmCjNPLeql+dotgV6YSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dm+yJ3At23CkipXs+0O1nAne2zg2jFc59qtDHBiNtXDjGIP6DETAAsgcFtZXRSqyD
	 1b0PiyePUBi9Sf2nCD1rcnU6gDOoUdeaFqkclFOkDQhfsDzITDS+los819gXHUMkiV
	 kvKz8Z60vQ7jM64QXUN361WZWha4m1NjeVHLEs2CbaghXbh+rgKDRSCMOybTcOzBy1
	 RkT/wYuChpdk538c6UeN+TZsHqsp3cJuoD1+02dXsXp3uV7a2LIdONOa2WILAWpkTl
	 5JTVCPL/X3W+1XQkGiTPoWy/ayLrJ49o1RFtvChK8FLEbg2t298+pZnCXDFXUkkeiQ
	 DecyY+/T+Fq+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9605E380DBEE;
	Wed,  9 Jul 2025 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems
 to
 iommus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202700747.194427.6933538958086222973.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 02:10:07 +0000
References: <20250707154409.15527-1-matthew.gerlach@altera.com>
In-Reply-To: <20250707154409.15527-1-matthew.gerlach@altera.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 08:44:09 -0700 you wrote:
> Add missing 'minItems: 1' to iommus property of the Altera SOCFPGA SoC
> implementation of the Synopsys DWMAC.
> 
> Fixes: 6d359cf464f4 ("dt-bindings: net: Convert socfpga-dwmac bindings to yaml")
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems to iommus
    https://git.kernel.org/netdev/net-next/c/8a00a173d1a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




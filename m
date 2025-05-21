Return-Path: <netdev+bounces-192119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15562ABE937
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC24E0CD7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0D1AAA2C;
	Wed, 21 May 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrzBD5D8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2D1AE875;
	Wed, 21 May 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791598; cv=none; b=kkLkoOc3kfFUQ8qrmh7qqRC35wHCuVOPXgLpRUoDV0jUCSlaBgD8pLkOTy4KkKf84XnO/ZozbN7RrF+Kzr06+xUJ+go3ShoJYUut+RNcgI3gZ/MbvkQLatuukfVihLaUrvxrNgpOJ7SgttpKGdVjAdOyb4scep0QyWRFhbW19Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791598; c=relaxed/simple;
	bh=4AtQcRMMFt/TxSF9wLGYAAdGE1Q6TOLHf7/oWt7wMNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oVK7/OKZAQKGJ0T2uoTyvB29iC1B+ZrVJmIINpNDXQldJsOJkTPhZOtulA5tg+bNZW2P0r1IRGQYHdNgPxWaqoLWZxDDt23LrHr8E10FRRTIku5tUKhtsldRN+dbCURQvf67KIQddtoTc3WReeZMW55RSTabc5G2ffYV5XXqHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrzBD5D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B7C4CEE9;
	Wed, 21 May 2025 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747791598;
	bh=4AtQcRMMFt/TxSF9wLGYAAdGE1Q6TOLHf7/oWt7wMNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MrzBD5D86GqbY5ifWbOU6YggYpbHQNSgCkXze5Bu9fzQO5SS/DExk5UTQwLOdSsiJ
	 EMrSsaLv9ESxAmGqDHC72KWDhdmBh67/1z4O13WFi/bZdgbr/cwgAZrG2WRlyCMDtR
	 1tXp3O9vZYxJFxNZ4SBj+wGlhfNsq889CoSYfPWeUVxmRyI0bLPTr0NJ27FT0pI5MO
	 vXaI2SZ+u/VGrURad6CRJayZWizaZp0Yc75vKIdkfZNzCuewZjkvCnsce1+nlXusDF
	 Wz762sk2s6eJPVfayfTU16kNPE7q3T4hM2HQo1X7guM01kxirEL7hZ3kv6o5gIkdLF
	 XBfQ3JKcIun2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D0B380AAD0;
	Wed, 21 May 2025 01:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dwmac-sun8i: Use parsed internal PHY address instead of
 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779163374.1531331.18316141953380951353.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:40:33 +0000
References: <20250519164936.4172658-1-paulk@sys-base.io>
In-Reply-To: <20250519164936.4172658-1-paulk@sys-base.io>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, clabbe.montjoie@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 May 2025 18:49:36 +0200 you wrote:
> While the MDIO address of the internal PHY on Allwinner sun8i chips is
> generally 1, of_mdio_parse_addr is used to cleanly parse the address
> from the device-tree instead of hardcoding it.
> 
> A commit reworking the code ditched the parsed value and hardcoded the
> value 1 instead, which didn't really break anything but is more fragile
> and not future-proof.
> 
> [...]

Here is the summary with links:
  - net: dwmac-sun8i: Use parsed internal PHY address instead of 1
    https://git.kernel.org/netdev/net/c/47653e4243f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-218437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E0B3C75B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6961C84A36
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3D255F2D;
	Sat, 30 Aug 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJWHjV5I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9530CDA5
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520403; cv=none; b=gorDfskDT5j531KsZEjKPzxwGpQ+HAsPhzWgYOCjthQTGq4NhNGkCIhNEfrfbrwRZMGuIdJj+nImVFNKBWmbVdtmi8Mww7MfmCYVCTSt2LEM1ggY3Zgfk7eMnbpfKqWpea2Bf3Wb2vppPXIvlbab3SQ5rSLJ8ry3AJreTFJ5e/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520403; c=relaxed/simple;
	bh=mfQEgV9kuR2hw0/9fDmxvcBKQZZlsSDfNBOeynamu14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wf8EAyvn5E0NvAbIqvxHPVrB67T7jPEwng4GQQytVCEGn+U5giVpG+rbmMkrggtBFdU71MXnst9gKLU5s6+dVYTZIaw6UYJia/oKczqd5Fkr3i7iH/0z8tl3craVRohXGm6cAtI8LepYlH4mEWx+D8D0m35Zx60/tyLfnDnxlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJWHjV5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2216CC4CEF0;
	Sat, 30 Aug 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520403;
	bh=mfQEgV9kuR2hw0/9fDmxvcBKQZZlsSDfNBOeynamu14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZJWHjV5IcR3xapp7YVQYAY/1tWo7lF4jL67zvfu/OTOdPOISggJvspuhVjOREcerB
	 FDoCpvrlnM+fiIDxUDCB56xYAwmDVgfUCWKWp1DjAsAZ+meayVTm9leemMdNj3FNMq
	 uGrNRt/rGY609hcGMfODPKJywdEKHvNbSv7q7r+kJksqFIB7yVGnYfIvfjU9+UJUoE
	 xqgsiNLM2cc/pkJdGliBDzjDgzg8Xgzp+FZLrAc7h/5uv9607wfCCQRUak8jcwXVHs
	 enZqngvWprTx/XOaWGQ0jyF029CnGnH13JBkYUk73Vr3DzowI6M2c21GTnLUKwALyd
	 Lr0e07pFRQiyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC9383BF75;
	Sat, 30 Aug 2025 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xirc2ps_cs: fix register access when enabling
 FullDuplex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652040950.2398246.15475699661279507232.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:20:09 +0000
References: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 12:26:43 -0700 you wrote:
> The current code incorrectly passes (XIRCREG1_ECR | FullDuplex) as
> the register address to GetByte(), instead of fetching the register
> value and OR-ing it with FullDuplex. This results in an invalid
> register access.
> 
> Fix it by reading XIRCREG1_ECR first, then or-ing with FullDuplex
> before writing it back.
> 
> [...]

Here is the summary with links:
  - [net] xirc2ps_cs: fix register access when enabling FullDuplex
    https://git.kernel.org/netdev/net/c/b79e498080b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




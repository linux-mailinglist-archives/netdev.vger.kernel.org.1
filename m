Return-Path: <netdev+bounces-185354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB06A99E60
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C52462A80
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C01D5CE5;
	Thu, 24 Apr 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSUDLobA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108878F2D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458800; cv=none; b=bpluTxBTwKfIFpNVs3v8iStXHN0WxtJ0h4wqCRC7uQZG4pCtOpr9NfUn7/ZAm0xRa5jX6F9MEFoOam5rta2JZPtJprXvHqJeaifFbHlGBO33hbR/ACsz6uS+yQseFNMw28mxyWLt8R0TfhMLdc2vZ6cVteBWDvpjSG6DGVlaC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458800; c=relaxed/simple;
	bh=ZKgjhxIMyGxAxeTxMLI5wiSTBBUIEAa72jp35r1NOz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q3Qg8ztTBJ6Gi2b26EIt+w2zc99Nu5vZD9Ka10WvckzdRzzSjCb/iouZ/aq5BBFklE+h69wCOPiT6xPSBJ6U2iYKAtV9DI3jfvBcHW8QAudxSdVb5ldINxCXj7Pcv+bB+hztwJc+Fmuk+jMkxRunjjghIBlcXwRWGmrmRb4ffJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSUDLobA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC70DC4CEE2;
	Thu, 24 Apr 2025 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745458799;
	bh=ZKgjhxIMyGxAxeTxMLI5wiSTBBUIEAa72jp35r1NOz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSUDLobAhjDGK1VYAcXceGLHcy2V7dHxMnyB7wlJDCFPsjlMhqjytdkRzt9oKTAsN
	 hLTXRKMf+q8gPj+fknYaeP4HxoMFIdIQhOmzfXcCT0wd7c/PQ5WYLSj4apiiC6giqF
	 ry65BpeIlp6GWeAv7vpL6XmrBZew7ifJocZiGJV0xYItSKzhXh38AP06COtVi9RhkY
	 W8eI8r78iIRA1FVvmwKf7zB/J3ED+9IWJeOpNPNl5DOaO3jYCog9uNg0cMLcOsZ6MD
	 t4hGjYRKUEIw0qAzQSqKzhmbu2k58OxOqb/2DhQ70+7Rj71ipZ5hKCrcyuixe9ORZD
	 LXB6y8ybK5DXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE6380CED9;
	Thu, 24 Apr 2025 01:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Enable multiple IRQ lines support in
 airoha_eth driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545883848.2827090.1763902859739390548.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 01:40:38 +0000
References: <20250418-airoha-eth-multi-irq-v1-0-1ab0083ca3c1@kernel.org>
In-Reply-To: <20250418-airoha-eth-multi-irq-v1-0-1ab0083ca3c1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 12:40:48 +0200 you wrote:
> EN7581 ethernet SoC supports 4 programmable IRQ lines each one composed
> by 4 IRQ configuration registers to map Tx/Rx queues. Enable multiple
> IRQ lines support.
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Introduce airoha_irq_bank struct
>       net: airoha: Enable multiple IRQ lines support in airoha_eth driver.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: airoha: Introduce airoha_irq_bank struct
    https://git.kernel.org/netdev/net-next/c/9439db26d3ee
  - [net-next,2/2] net: airoha: Enable multiple IRQ lines support in airoha_eth driver.
    https://git.kernel.org/netdev/net-next/c/f252493e1835

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-227239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B421BAADAC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF0A3A39F7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66380433A6;
	Tue, 30 Sep 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPg4yJBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66A2A8C1
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195213; cv=none; b=COm1TCWiKaiSMIbCX2c4Z9sMm4lCSRQxzMu7rBg3U4WNaKEaPEYT+iIW8DGVvNxfJiXfPRZK2XX6U1UEksIoHmeNAJWTSl8Hj/VDdRWe6MEQui26uJKnbjiruxekzYySYMNFZqnDQTLdRTiW4QEh4B/OzzOBYNFfHc7hSKDAY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195213; c=relaxed/simple;
	bh=vW/qv32iV6ZzB2NB6kl4fH250rO7rw+BNVLWzFarPPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IPH0Kdj/W0PbqzUtCcmPs60YLh97tH1x678QMShSrXz2ye5Lpyq1cKoBc8ZH1yy3aAPqCGUnVE1Mf7OmTCPTe85JIVG0ktEm9S1b5EdhqJvBtyPUo5UcpW91p+/NjECBG62ghxyCvYgRQxULxUz32AfB4GgmiWFh1pOP+49+Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPg4yJBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13244C4CEF4;
	Tue, 30 Sep 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195213;
	bh=vW/qv32iV6ZzB2NB6kl4fH250rO7rw+BNVLWzFarPPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPg4yJBfdRTytISjvdFTweEJD4B5wwCYwJMS7dSBi6E84IM036cMS1FmfmXpGQNTB
	 1vnn2b4vjP9bplivwzck4hax7p5KbbITQJJ+qqAc7CdsoFX7iLe83oHuhsKzbOcQ18
	 CAYK7ig9pV3ydEfkbOIx80zAg4qLf9NnD9kju3jw2X0y571g/nADP474Y2+wpapmSX
	 s9pmqO0btvGsFF4q0rwjwc9OE2/5Apm1mibiVqRCWa0KSIsvN4+PmicfgqSflNa+xR
	 BSzEJ6Eug+VHSjgRfcgJmMDjh9Lym+rMXBvEJRXrHf3PgIWib7J1h/7J2Wf4NVh2E6
	 RLCQhCszqjjlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3B39D0C1A;
	Tue, 30 Sep 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: fix mismatched free function for
 dma_alloc_coherent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919520650.1775912.18298480194325200871.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:06 +0000
References: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: krishneil.k.singh@intel.com, alan.brady@intel.com,
 aleksander.lobakin@intel.com, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 11:02:10 -0700 you wrote:
> The mailbox receive path allocates coherent DMA memory with
> dma_alloc_coherent(), but frees it with dmam_free_coherent().
> This is incorrect since dmam_free_coherent() is only valid for
> buffers allocated with dmam_alloc_coherent().
> 
> Fix the mismatch by using dma_free_coherent() instead of
> dmam_free_coherent
> 
> [...]

Here is the summary with links:
  - [net] idpf: fix mismatched free function for dma_alloc_coherent
    https://git.kernel.org/netdev/net/c/b9bd25f47eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




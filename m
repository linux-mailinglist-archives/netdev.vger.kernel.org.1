Return-Path: <netdev+bounces-204775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FFAFC088
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC73AF2C8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB522259B;
	Tue,  8 Jul 2025 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPo9N8pX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D121883F;
	Tue,  8 Jul 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940622; cv=none; b=Lcpuj26v0YFzwoqS6hJVrfl8oEnMtNpkju0kndpQREfKrSUpb2UI+X59Z3l56g4Z2D1dNV6ygKGCSWXevQdHFADLHPU+xhgLEYC0K2UKCh3B558NWU2ay01lZhy4wELxnLvnrxOhIsmrkkf8iaqZvqibCInl/U33bIZHf2pDg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940622; c=relaxed/simple;
	bh=D1XosDQD7NQ3cebl06yz9aWaBYeGK4bi2jdbXCc0FqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ioKfb2/oqv7pPdakJTbzwEB9NTEEgc+9SLk4Dtc9eMsWO5I9ZdlpRIiqImfTiANEwXMMidrFWYuk5tNAG1OmKzTXpmuziHuLuMZJ8NOM81ffxih+31uvES/X0b6mTDcereQA98z5qjgag4Igy675SCkvI8spmSETVY/+yB4wWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPo9N8pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD7CC4CEF4;
	Tue,  8 Jul 2025 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940621;
	bh=D1XosDQD7NQ3cebl06yz9aWaBYeGK4bi2jdbXCc0FqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPo9N8pXtB+a2Xfyj3rgjziQvPp2gmVwHKHmYOg9C98XteSVjkrwdHuejFMRTTgQH
	 KV2Va8Prx0VsRg0oAqdExnXE+zCPvT775rRLgQTWJQT4nSpNI1NHxLZ2RA2T/Nkxuh
	 /sDtGmKcCZjQWCplbgkxTHJc0Ii3mVY8GZbtg/cxUHNuhlz6CQtSupYJq7fOIov+Mz
	 XDqvw75pTqHCyrzPxZwVRHZrMWSyn5TX0/tvC7VUsYdMGOKWU6Fet/oGamTNXvR2xJ
	 Vp6KHva4lYR5z1Z8Du6dH71CJW/jnpr4w5GcIKlDJTvAxpudjT20xry+9tE87xmO6q
	 LMP1mFYeL3S9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9238111DD;
	Tue,  8 Jul 2025 02:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next, v3 00/10] Introducing Broadcom BNGE Ethernet Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194064425.3543842.3986154137074104629.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:10:44 +0000
References: <20250701143511.280702-1-vikas.gupta@broadcom.com>
In-Reply-To: <20250701143511.280702-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Jul 2025 14:34:58 +0000 you wrote:
> Hi,
> 
> This patch series introduces the Ethernet driver for Broadcom’s
> BCM5770X chip family, which supports 50/100/200/400/800 Gbps
> link speeds. The driver is built as the bng_en.ko kernel module.
> 
> To keep the series within a reviewable size (~5K lines of code), this initial
> submission focuses on the core infrastructure and initialization, including:
> 1) PCIe support (device IDs, probe/remove)
> 2) Devlink support
> 3) Firmware communication mechanism
> 4) Creation of network device
> 5) PF Resource management (rings, IRQs, etc. for netdev & aux dev)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] bng_en: Add PCI interface
    https://git.kernel.org/netdev/net-next/c/74715c4ab0fa
  - [net-next,v3,02/10] bng_en: Add devlink interface
    https://git.kernel.org/netdev/net-next/c/9099bfa1158a
  - [net-next,v3,03/10] bng_en: Add firmware communication mechanism
    https://git.kernel.org/netdev/net-next/c/7037d1d89796
  - [net-next,v3,04/10] bng_en: Add initial interaction with firmware
    https://git.kernel.org/netdev/net-next/c/fb7d8b61c1f7
  - [net-next,v3,05/10] bng_en: Add ring memory allocation support
    https://git.kernel.org/netdev/net-next/c/27544c0ecb4c
  - [net-next,v3,06/10] bng_en: Add backing store support
    https://git.kernel.org/netdev/net-next/c/29c5b358f385
  - [net-next,v3,07/10] bng_en: Add resource management support
    https://git.kernel.org/netdev/net-next/c/627c67f038d2
  - [net-next,v3,08/10] bng_en: Add irq allocation support
    https://git.kernel.org/netdev/net-next/c/18a975389fcc
  - [net-next,v3,09/10] bng_en: Initialize default configuration
    https://git.kernel.org/netdev/net-next/c/3fa9e977a0cd
  - [net-next,v3,10/10] bng_en: Add a network device
    https://git.kernel.org/netdev/net-next/c/13a68c1ed754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-201717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67192AEAC10
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE43AB021
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBE126C1E;
	Fri, 27 Jun 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWc/PZU6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346E78F4B;
	Fri, 27 Jun 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985997; cv=none; b=pqa4QoWV1msgMvChQT+0SI7UarjcG5pLD0ZSFyzYib5+StAcFbpSt/Eyt/Zaj0m0eNzrN+j49hixRuCn9HxC6wkE3oJMCNidiYQG+aNrhf4hi/LXYpusrPuTtY45XxIXAa0HmkiDyJOgAgTeLhYeS1ftOEa2uMSjvDzN/hSklUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985997; c=relaxed/simple;
	bh=iI/zzfk64FcgLTY38mikcNrRrwupijjrajz2ix5O+OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXRFmpH9yrVP4p3sa8CASqag7TVD2dkgfyypnUFLWKbeSWkeyjorsDysq2wT8VveUdU43RVjgfNGOFXV5EMbe8/nl3Rg3Keem7dWuL14q8qT3zq+yTr+v60xx+8vffraJoShmyZh8dPlhNK3KeHvrjJtM3g/7NPglAt3FxxzMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWc/PZU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5B0C4CEEB;
	Fri, 27 Jun 2025 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750985997;
	bh=iI/zzfk64FcgLTY38mikcNrRrwupijjrajz2ix5O+OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bWc/PZU6aLpzCVK9rQdURMJxdHUwbuPD0Xq4u1LESr1anMfD1nM27UKXH1ax/2ppe
	 3sl4wJFo48Hq00MgLkyU9l/BHnA9mC24PqLJG6tC22dyYiUHd9SQH/Iu6MqzM5egCq
	 +IU+IwaO5bDXdc7rLZbT/eJzHoxC+ApGEJvsa5/JFgXXWXl1eWtijl6sYNBja60+1p
	 msVcgQxqZE6yQuhUjc5bXyqKyXWD0XbD6HZUt1vxNEESfbiMi6KaDEr8WaWZhOiGPU
	 CDMDOL/8nau/4rhHqWdDbNEcFz6mUttpnJM6MbZDHtgJ8U+fPkIwjIv2TWf6p/y6Ox
	 hZcPcha5uCdVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC93A40FCB;
	Fri, 27 Jun 2025 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch V2 00/13] ptp: Belated spring cleaning of the chardev
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098602350.1388943.11928357091837145355.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 01:00:23 +0000
References: <20250625114404.102196103@linutronix.de>
In-Reply-To: <20250625114404.102196103@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev, pabeni@redhat.com,
 kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 13:52:23 +0200 (CEST) you wrote:
> This is V2 of the series. V1 can be found here:
> 
>      https://lore.kernel.org/all/20250620130144.351492917@linutronix.de
> 
> When looking into supporting auxiliary clocks in the PTP ioctl, the
> inpenetrable ptp_ioctl() letter soup bothered me enough to clean it up.
> 
> [...]

Here is the summary with links:
  - [V2,01/13] ptp: Split out PTP_CLOCK_GETCAPS ioctl code
    https://git.kernel.org/netdev/net-next/c/7ca2ac4953fd
  - [V2,02/13] ptp: Split out PTP_EXTTS_REQUEST ioctl code
    https://git.kernel.org/netdev/net-next/c/f6b3e1bc6ed3
  - [V2,03/13] ptp: Split out PTP_PEROUT_REQUEST ioctl code
    https://git.kernel.org/netdev/net-next/c/3afc2caceaf7
  - [V2,04/13] ptp: Split out PTP_ENABLE_PPS ioctl code
    https://git.kernel.org/netdev/net-next/c/47aaa73d25ea
  - [V2,05/13] ptp: Split out PTP_SYS_OFFSET_PRECISE ioctl code
    https://git.kernel.org/netdev/net-next/c/e4355e314c94
  - [V2,06/13] ptp: Split out PTP_SYS_OFFSET_EXTENDED ioctl code
    https://git.kernel.org/netdev/net-next/c/37e42f8dd07d
  - [V2,07/13] ptp: Split out PTP_SYS_OFFSET ioctl code
    https://git.kernel.org/netdev/net-next/c/4b676af26e9b
  - [V2,08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
    https://git.kernel.org/netdev/net-next/c/b246e09f5fe1
  - [V2,09/13] ptp: Split out PTP_PIN_SETFUNC ioctl code
    https://git.kernel.org/netdev/net-next/c/d713f1ff64d1
  - [V2,10/13] ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
    https://git.kernel.org/netdev/net-next/c/6a0f480478a7
  - [V2,11/13] ptp: Split out PTP_MASK_EN_SINGLE ioctl code
    https://git.kernel.org/netdev/net-next/c/745e3c751c4d
  - [V2,12/13] ptp: Convert chardev code to lock guards
    https://git.kernel.org/netdev/net-next/c/4838bc9e279c
  - [V2,13/13] ptp: Simplify ptp_read()
    https://git.kernel.org/netdev/net-next/c/b66d28142dc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




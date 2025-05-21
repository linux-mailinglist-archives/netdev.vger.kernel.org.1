Return-Path: <netdev+bounces-192143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C841ABEA34
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08594E22DF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5622B8A7;
	Wed, 21 May 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc5ZV0bf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C60482EB;
	Wed, 21 May 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796994; cv=none; b=T6ckSv4ufEc8Y7A08jQ7S1lxyBO5XhxUoGB3Sj9yn9KLwFyLPixdMgza3MAhMby0uHo67Xu8Uu+sGcHUDx92tpx+XhQWAXbtNNpOkhpIEjdMx9v6coiJpwDlZAF783ojIqUKlJiab8BlGn16JxUcbXgOfc0B00PI4KxW1TrzV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796994; c=relaxed/simple;
	bh=F+puhdI3No49rSJGnDkplElOEJNBDiO/KKVkeqE/oOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aqg1pywnTKq8w8Z5XZgvKylt+T5QjZ5mP9yN0Y2m4wVm9J7eIYZRxU0VcVMqMFlwlQOrI7hRKDMXDJeA8O1VkjazgkTLnYC5HDF8pgX/GSoNz+VKfPYn5V6fzRkYzJ0tYpGHxT3iVxQuy51kvzl0XPHB2cUaG0RLCefpVy2sRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc5ZV0bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247E8C4CEE9;
	Wed, 21 May 2025 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747796994;
	bh=F+puhdI3No49rSJGnDkplElOEJNBDiO/KKVkeqE/oOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kc5ZV0bfdPsCS9ppRQmIbJYO/4LpR3P3oC8vMaVWogRv8UmyT+QlZc3AqlyJgoMCt
	 /0WzV6jLpG8+DxXVJqEwjoOyAFzIiLMuWxhbAKQeiVf+Hmv9gJktCB9JuGcMXcBiaC
	 8QS4WjlOcaFI1gvAVmhvuLS4uqhoaTGkKbcBRHyk2TYojVm2WL2ua6pEtdgaZwp4Ha
	 JB46AMqeKRXn2IHzvCVZGfVb4FHaWXiKbeOW81QMmijz9ndOwWWls6xQTAVD+p9hRm
	 yYwOrghWun/95CN1kYjta3t2pLYqD9HlEw3i3+WqvtgJcmDVamLIbjoXh2E5BN8L/O
	 nc/IPOLJPkxlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2D380CEEF;
	Wed, 21 May 2025 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779703000.1552321.978530482238663159.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 03:10:30 +0000
References: <20250516035719.117960-1-thangaraj.s@microchip.com>
In-Reply-To: <20250516035719.117960-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 09:27:19 +0530 you wrote:
> SGMII_CTRL register, which specifies the active interface, was not
> properly restored when resuming from suspend. This led to incorrect
> interface selection after resume particularly in scenarios involving
> the FPGA.
> 
> To fix this:
> - Move the SGMII_CTRL setup out of the probe function.
> - Initialize the register in the hardware initialization helper function,
> which is called during both device initialization and resume.
> 
> [...]

Here is the summary with links:
  - [v1,net] net: lan743x: Restore SGMII CTRL register on resume
    https://git.kernel.org/netdev/net/c/293e38ff4e4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




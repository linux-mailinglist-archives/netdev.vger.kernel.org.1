Return-Path: <netdev+bounces-187257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B0AA5FA6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D161BC395C
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715BA1C84C9;
	Thu,  1 May 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODgtYAQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456891A238C;
	Thu,  1 May 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108592; cv=none; b=Iz1GvL8Sn1GMKgdBmO3XNSuTcw4RBhxpunJJYt6yUXqXJXyFvra/2m7+PwyBvrn49hVU8lJMdZ7mTaC9a4uJqos8fQP+r71tm+c53eiWkuNhFGJqC8k/W8g0BGJzRBta4TyAwom0xrvJWQayoo6FyXFwoczY5FFgJgqFZsQxjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108592; c=relaxed/simple;
	bh=CF13hRABM8ip6XS/EPSkYDPCeIAZdV3HdE2DhLNrjwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hxsNbPZjpfQxS9KqyR6A8Kicz1g4uch4PI5yUGrJGCjcY8OuMPMGqegTrqye7V6F8llUTG2fDmEDt8g9AsvucRb5wpkP8tpLCMTrk5ILNS1DxwtHO0WT4xJ/+vEcjE5ZVXfifVxgW3QZ+Dnagfz6OwuwD6QOlPizjD1FWdocn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODgtYAQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A5C4CEE3;
	Thu,  1 May 2025 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746108591;
	bh=CF13hRABM8ip6XS/EPSkYDPCeIAZdV3HdE2DhLNrjwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODgtYAQ6ERLANNXtS0sfh6C+l5SCNPjuPwKI1QunWR+mmC2Bx3flsdBx9EMMKf+DB
	 yHE1QIdt9JdHZ1XjcOV2huoX1O82NeEGoRAF4s8cQ98z2msRCKN73S7ZaujIboBiLb
	 jHXLzA071+yqacmDgVQTBhd1xUFd5vYFuhJQjmCn0EYZhJ0H9Wj017PjH/nRhp9r5s
	 2TDILa8WR54lwB2hCr0JhlwQ2+u6qwwggMyxGl4oo6tYoNdvEFROSouQCMAucYxqyf
	 IxoDLGpLi5kuDksT2M88yyTZBtpUPzEIMBOv8NHuU69IyOpkxxZ/bJNy5am0Z12q3B
	 E6R77SaJAI8xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02F3822D59;
	Thu,  1 May 2025 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610863076.2990404.16647937333615810041.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:10:30 +0000
References: <20250429073320.33277-1-maimon.sagi@gmail.com>
In-Reply-To: <20250429073320.33277-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sagi.maimon@adtran.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 10:33:20 +0300 you wrote:
> From: Sagi Maimon <sagi.maimon@adtran.com>
> 
> On Adva boards, SMA sysfs store/get operations can call
> __handle_signal_outputs() or __handle_signal_inputs() while the `irig`
> and `dcf` pointers are uninitialized, leading to a NULL pointer
> dereference in __handle_signal() and causing a kernel crash. Adva boards
> don't use `irig` or `dcf` functionality, so add Adva-specific callbacks
> `ptp_ocp_sma_adva_set_outputs()` and `ptp_ocp_sma_adva_set_inputs()` that
> avoid invoking `irig` or `dcf` input/output routines.
> 
> [...]

Here is the summary with links:
  - [v2] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations
    https://git.kernel.org/netdev/net/c/e98386d79a23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




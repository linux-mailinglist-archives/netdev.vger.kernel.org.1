Return-Path: <netdev+bounces-196767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C0AD64C5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C835189591B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6243164;
	Thu, 12 Jun 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2egijkt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A742AD02;
	Thu, 12 Jun 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689407; cv=none; b=uyXQrHbvQiXKC5K89txt0tY42ivj3bCtJ2ovQihPkY53nadM1qYnw2VokU88YVreCv/b26qoqOT1mBGLEzbnEh+hB5048G4u8R0Jq0QluMPpGO37oP/Ypu7TdC4qL4hIZ41qObZWtwvi9wFqkzwC5QKoRlQksQSbtPiPj9s312k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689407; c=relaxed/simple;
	bh=jQuca2ikcMezuKUhO7CCmQATPFR8UGh0rqCRGlqZ7Xs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TFJosrDzHjPyBPrINqKS5/jTcdg4u+dhUDlmwtGeTnx/RGq1w3EtzSaBLr/P65X2+VM2C1Y6KKvnLtFDTHgl7C/IbscixFFgPEw+4ukO/4JEZE5hCLUDPARt1kckKo53HMJFeGBtciFmRBg3uk0F8S+4R8etNmqM6s9oaoKbOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2egijkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B439FC4CEE3;
	Thu, 12 Jun 2025 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749689406;
	bh=jQuca2ikcMezuKUhO7CCmQATPFR8UGh0rqCRGlqZ7Xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2egijktEiuaxPpL585YyXJnF0oVY6UJMf/kiYQwtcKyYuMjTWg4n6t0GYNRUtIh0
	 NAsRxKLBroBfXv/zSqyNP1w6DXq5+Nn1rIk0CgUWdbSkFkThsF/peuiR2tb/TV4ZFg
	 TkzA06dGhfPBFhymPmHHs0W2lttXahJHC23Esz+EY0nSZjllQI30hYoLN5+8KxXueg
	 OjX942cqv+N5bHrgB72BsH5MGsvyvgylIcewOGDtKEOy7nh5Cu3LZdqRY3+i8XeU1Q
	 7p0j3ahgD8YzN2epfB4iz63xGgEe+8cqEURWK351Vvvfr3SbM5ddkSLHeamtGY3vIs
	 GDEiuqfb4R1WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9B3822D1A;
	Thu, 12 Jun 2025 00:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: bcmgenet: add support for GRO software
 interrupt coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968943648.3552664.6839713720894047365.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:50:36 +0000
References: <20250610220403.935-1-zakkemble@gmail.com>
In-Reply-To: <20250610220403.935-1-zakkemble@gmail.com>
To: Zak Kemble <zakkemble@gmail.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 23:04:01 +0100 you wrote:
> Reposting as requested here https://lore.kernel.org/all/20250531224853.1339-1-zakkemble@gmail.com
> 
> Hey, these patches enable support for software IRQ coalescing and GRO
> aggregation and applies conservative defaults which can help improve
> system and network performance by reducing the number of hardware
> interrupts and improving GRO aggregation ratio.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bcmgenet: use napi_complete_done return value
    https://git.kernel.org/netdev/net-next/c/28ed9bed5fb2
  - [net-next,2/2] net: bcmgenet: enable GRO software interrupt coalescing by default
    https://git.kernel.org/netdev/net-next/c/078bb22cfc65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




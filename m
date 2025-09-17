Return-Path: <netdev+bounces-224193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01693B8224D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580771C23FC6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E930EF80;
	Wed, 17 Sep 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw09I1uC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8B30E85E;
	Wed, 17 Sep 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147624; cv=none; b=jUnGdugzfCWmbOrWN7RIOcnkjOWrxmkNYYCiP06grYCpu+upTDsGdau27KdHzlzeA16vskxNdTGEh2oHtT9Dg0VNYpF0YVIc8UIxVY2Cm2RW+RPbL/b0qFwKbqdMovwfDEUY79J/fsteFnj9cstHycz3M5Zvwgjz/ZPMz8FG2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147624; c=relaxed/simple;
	bh=UAXtTYSSZXwRncb6qHR46TFy6fZj+ssxz42YvkNnIos=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YT9y5wPXTaf3HnKDfR2dJDQOlFts+LvZx7SKOavfX3rGgy7EgbTudVjSdATH/qLtIxEXFRBqg+2/NFm1V/9ypVbd+AcemCGpG8G//6LZKJKtT0IHYOyudZxy88+6y5yEC2M/1N693pVczLXXzcavwNGpPIx6yxRMN5m5Z+7eKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw09I1uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E17BC4CEE7;
	Wed, 17 Sep 2025 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147624;
	bh=UAXtTYSSZXwRncb6qHR46TFy6fZj+ssxz42YvkNnIos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rw09I1uCNEqwlDcoHmLxffqhGJuSYrqsfILM2GsfGu91XQDQL69XpD16n5/tCEARD
	 kSYmvF156axjFpN7K6cstRnL8OMaZqHJ/asvKIe31HssvMj4mqYzSNZzxL+iqnK7vH
	 CNoIIl89cN0GOr/ve7Cz3m4c8nzcqjeNrv5hpU3TG1P4IPlzkg9EjF/oVj3ASiVCeU
	 5ez0vme/bXEhj7+PW0Q0BCu922cvFc/r0GKwxweaOqq1Lju8qr7ceqV8s/T8As6liD
	 UzfAOcYHGfMKswCLzF6aWeIDjnuHiRpsq1XWSS7Lhikq5z/AE2F/WVyT3NYNXY6J9L
	 fBnS8LG50mqtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3402D39D0C3D;
	Wed, 17 Sep 2025 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: cadence: macb: Add support for Raspberry Pi RP1
 ethernet controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814762499.2168096.11472987759617415372.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:20:24 +0000
References: <20250916081059.3992108-1-svarbanov@suse.de>
In-Reply-To: <20250916081059.3992108-1-svarbanov@suse.de>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, florian.fainelli@broadcom.com, andrea.porta@suse.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, phil@raspberrypi.com,
 jonathan@raspberrypi.com, dave.stevenson@raspberrypi.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 11:10:59 +0300 you wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> [...]

Here is the summary with links:
  - [v3] net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller
    https://git.kernel.org/netdev/net-next/c/dc110d1b2356

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




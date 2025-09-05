Return-Path: <netdev+bounces-220192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1EB44B6A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D131C24CBF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED721ADA4;
	Fri,  5 Sep 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keIR4Mol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7431218EA8;
	Fri,  5 Sep 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037602; cv=none; b=lanKkou5H8UvmdVO3r/DaTKt/feh/0iEWVz83Hrp5QfJYqMDIeou6j/QDD9M7P5on1SuLyGL6/uMPYXZnWU6Vtkchrb3d1pFeZ0elfUF7QY1usRCeBWK26VW0FHXO4XRgMoyrDaymLjC0/jketykiQRvjPWJ0gZOYyifgND0u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037602; c=relaxed/simple;
	bh=6WrSKGMcklSN3roHjGk3yFcw/fLf1SGPFW5yr0SuEYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rj0lnkkIWRUOTqaDoI7vG180I2cV0lsQPIr53cMH80NZmILaeFmUFEhArL978ahEKTLFg1zyiChZVo6LqKZmYcrcLfmfV+Fpp9y5nYyAC2k88+gL6O56IkzCEfcqw0Z9PHE91BJziiJwFiKDlmpaIfSw0WZ6aHeyWWNouMFYzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keIR4Mol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EBC4AF0B;
	Fri,  5 Sep 2025 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757037602;
	bh=6WrSKGMcklSN3roHjGk3yFcw/fLf1SGPFW5yr0SuEYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=keIR4MolXDCuDAQ4tpQuRfXkj9XNWYKqGDp4fRkc61kQInngXYCgqRhI6cwQ+G2KI
	 WHaiElr2nXUMWbBrIWQAHLGc6y/JM7K0tIvmNAehAsJwMt2fKui0y4RljvXxBefdxF
	 +1j5Xj/d1fJIHjCaUpOcQVGyh/JS5B5bHVYBfK+jxbrEdZhgkQnyfBxD4S/UUSPdYI
	 ton3QP+6YF/XdXMfaYrOHwC++lCqsVGyIZqMdmr7vu6sSrOunyn3/K51gk6W8UGK1w
	 VhdIkXlGWz+Sz1peFjS0rQXq1PYYNKHIMY2h4OqY3hDZP2WopJmHUKRIl0SSge6WCV
	 RONgPnl0iGlRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEB383BF6C;
	Fri,  5 Sep 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175703760650.2006573.13109159782302004132.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 02:00:06 +0000
References: <20250822093440.53941-1-svarbanov@suse.de>
In-Reply-To: <20250822093440.53941-1-svarbanov@suse.de>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, florian.fainelli@broadcom.com, andrea.porta@suse.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, phil@raspberrypi.com,
 jonathan@raspberrypi.com, dave.stevenson@raspberrypi.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 12:34:35 +0300 you wrote:
> Hello,
> 
> Changes in v2:
>  - In 1/5 updates according to review comments (Nicolas)
>  - In 1/5 added Fixes tag (Nicolas)
>  - Added Reviewed-by and Acked-by tags.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] net: cadence: macb: Set upper 32bits of DMA ring buffer
    (no matching commit)
  - [v2,2/5] dt-bindings: net: cdns,macb: Add compatible for Raspberry Pi RP1
    https://git.kernel.org/netdev/net-next/c/d9c74e6f8125
  - [v2,3/5] net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller
    (no matching commit)
  - [v2,4/5] arm64: dts: rp1: Add ethernet DT node
    (no matching commit)
  - [v2,5/5] arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




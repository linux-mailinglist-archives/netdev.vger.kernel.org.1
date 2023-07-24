Return-Path: <netdev+bounces-20286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751175EF48
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19041C20942
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997106FCD;
	Mon, 24 Jul 2023 09:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C396FD6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86463C43391;
	Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690191622;
	bh=aCk3Kiy2QCtNYRS+NGG0CWQ85CV4s0YcclLSlSiBxAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cKgs6IdjIl6fCfKMxEVhZ6czA0HE225jI06xbuiUTCN5N6KoDyK6sosXXDiJ2UP8s
	 Lo1EEWUjrD4aYHqNKWvKixq3wUcqNwpi7RgaVCF0ylucH3AZNPfbO4K/BM9D6oJcwS
	 BXk1DWnMYUUVWUZtgaupBO6+mpBKG/Xb4QgjRIPp6wiA/MIVPXmDRfeaPN94lbM1DG
	 rpoRRK6q5MkTNW0GAxRz9robddCKaw6cRIHPr0XRR1smDLwHv/xbBlReB/t3dU8ebT
	 LLtBAV+ii2VJw7SOfaSDzG0wS4/IkNl0o7apBNzGYztmnQd1jIRWLShapZMJSFstnn
	 EskO9OxnG6riQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70FEDE1F658;
	Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Add motorcomm phy pad-driver-strength-cfg support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169019162245.19399.3902145269811670300.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 09:40:22 +0000
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
In-Reply-To: <20230720111509.21843-1-samin.guo@starfivetech.com>
To: Guo Samin <samin.guo@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, pgwipeout@gmail.com, Frank.Sae@motor-comm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 yanhong.wang@starfivetech.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 19:15:07 +0800 you wrote:
> The motorcomm phy (YT8531) supports the ability to adjust the drive
> strength of the rx_clk/rx_data, and the default strength may not be
> suitable for all boards. So add configurable options to better match
> the boards.(e.g. StarFive VisionFive 2)
> 
> The first patch adds a description of dt-bingding, and the second patch adds
> YT8531's parsing and settings for pad-driver-strength-cfg.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
    (no matching commit)
  - [v5,2/2] net: phy: motorcomm: Add pad drive strength cfg support
    https://git.kernel.org/netdev/net-next/c/7a561e9351ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




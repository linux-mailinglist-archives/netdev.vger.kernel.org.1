Return-Path: <netdev+bounces-21705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDA76453B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873352820C4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB520EB;
	Thu, 27 Jul 2023 05:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308831FD8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3E10C433D9;
	Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690434021;
	bh=FFH1pgMbxUQkbi+W6prTc8hoMQARLRPlW3fqf2rZAL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hU+QuS93JAT1VG0BV4/1vkXRtYNlsPiMDnZMIJMNrUGBhTQwago6dU7nrctIYJNce
	 zOamyaphbsrFVLn9XRR3pNzthZgCf8KNTCPxgAg/K64xZAp+LCTwa1Fp1RUczsxAaC
	 PeRFdbKCAIHS/R8PsiZB6QYO/nw9y4S9rsRENzQJrQwsekdtTrviTXA/QRHm0XGUaa
	 nIcvTNRsHXsB+MEfm14XY0IPxfIV/r4aNysr65kT4uQQAjV8HoE92Yq37Lz5gbaY5n
	 hhgTYhPkdLaRoR3WZSIDv68Pv5h3xUMRByCrFFPCvpoO5NE1/gnSO+8bOHHgl6A9NU
	 GRoBBxGMRj+Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BBE9C59A4C;
	Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy/pcs: Explicitly include correct DT includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043402156.24382.3029642693015868159.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 05:00:21 +0000
References: <20230724211905.805665-1-robh@kernel.org>
In-Reply-To: <20230724211905.805665-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 15:19:05 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - [v2] net: phy/pcs: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/ac3cb6de32b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




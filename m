Return-Path: <netdev+bounces-29494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78637837D4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C7280FA2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBC110A;
	Tue, 22 Aug 2023 02:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5010E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF374C433C9;
	Tue, 22 Aug 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692670824;
	bh=WiuutlKZGSfnMqcEk2Hi4ACANiW2639zyoroXwPM8rY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWwXRsyzXz/KvxTnNXQ9LEanWGs786Wm+OXoPuh2fuCHLLhwhBE8yyKxOB0xk3Wvj
	 qDfNH2UoUt2j0sAFtlNTwJZwF/2DBvjBgyf+4wpsO+ex5Jc2laV4fuPavls02355Ki
	 MTg6o6ODcPUVQm2aYtF6GXCB2zp2O9IXm2CzInxd0WO39M7KaIwsJ6TAJhh1jsgoIJ
	 yu3HQat2zAsLmpM1pA7v1MEC9nfyT85wY1PuueulyBpaDQC5S3lAAFxKSd7hImXWak
	 O5ShNTCb+xbbCva0BjuzdEWmYhIuyITcTiWUYgDWSVLl2SUB7KtpcuVMhosMCNMY/x
	 S6noww69Hm7vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0B5BE4EAFB;
	Tue, 22 Aug 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: lynxi: implement pcs_disable op
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169267082465.27540.3832216650125518638.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 02:20:24 +0000
References: <f23d1a60d2c9d2fb72e32dcb0eaa5f7e867a3d68.1692327891.git.daniel@makrotopia.org>
In-Reply-To: <f23d1a60d2c9d2fb72e32dcb0eaa5f7e867a3d68.1692327891.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lynxis@fe80.eu, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Aug 2023 04:07:46 +0100 you wrote:
> When switching from 10GBase-R/5GBase-R/USXGMII to one of the interface
> modes provided by mtk-pcs-lynxi we need to make sure to always perform
> a full configuration of the PHYA.
> 
> Implement pcs_disable op which resets the stored interface mode to
> PHY_INTERFACE_MODE_NA to trigger a full reconfiguration once the LynxI
> PCS driver had previously been deselected in favor of another PCS
> driver such as the to-be-added driver for the USXGMII PCS found in
> MT7988.
> 
> [...]

Here is the summary with links:
  - [net-next] net: pcs: lynxi: implement pcs_disable op
    https://git.kernel.org/netdev/net-next/c/90308679c297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




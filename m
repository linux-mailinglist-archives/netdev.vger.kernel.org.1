Return-Path: <netdev+bounces-121971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A895F6EE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A4A282DBA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6D19925B;
	Mon, 26 Aug 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ZFQKs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A57198E9E;
	Mon, 26 Aug 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690435; cv=none; b=qPzrXWSApJ5KIKy39ztk29T1JYZ+bZvuos8UasVLunsEoThyuIdHuaGoOvoy3kzBxiYiRB7OOxWos49jAFZUD2gADBsFzCpUBInRw2AiR3jNFL3Ha7fcEryRwfHCgdh0AVcvk+g943MzTlpO+LbNl5baBotiYiCQvpuSmZnGvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690435; c=relaxed/simple;
	bh=3iWgdOCh6iRF/1t12dsWt8DJU+1Xkvhqd89cpK+/ueQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mmp/hfn42ztCoEGc/o1XbuZlYITGcmBZ9pkn2GtRGeX3UrGXFQ5ECFZ8BToaoNZC334c/15cc45CkR/oV0bbBpZ3nquLZhPrZOrjlwNA2HJvEAE7gBwOM0zMl/oDQnBSpAzBlIgmFofQ8DSJjzfjSg+PiJWt679zn/Ae5EoHIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ZFQKs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6667AC52FD1;
	Mon, 26 Aug 2024 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724690434;
	bh=3iWgdOCh6iRF/1t12dsWt8DJU+1Xkvhqd89cpK+/ueQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+ZFQKs8glEPExfpajfWZhFktsvTaCF4/llTefaarRbW3kDgi19+s9DWmSCOmV94R
	 BtuYWB+GhVwBBRctIBjMcBXjtgvHhqL0enPMAKimfuvZ1McStAykr/suOwbaQ9hzeB
	 /rWeHYbT0fxlJ/7rKGjQuxnxOJ5mHYZI+5B0xZGoQLEvvxcT1FPmaEzFf+0M3XZSug
	 PKHVGMZh3WyUuZ8Rn8ipZO6dnn8d7K+D3TkvX4MkXzCa/TJMXCj4WCc16kct4DW1VU
	 iChzvgSL+UnSt5CW51sAjGXxuk3FwHUehyPyl+YGiLtOZwan+3C0PFquOFy/6L6yd/
	 dEOgYl9nLkeMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1B3822D6D;
	Mon, 26 Aug 2024 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] Add support for ICSSG PA_STATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469043449.64426.15089058970884587892.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:40:34 +0000
References: <20240822122652.1071801-1-danishanwar@ti.com>
In-Reply-To: <20240822122652.1071801-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: s-anna@ti.com, saikrishnag@marvell.com, jan.kiszka@siemens.com,
 dan.carpenter@linaro.org, hkallweit1@gmail.com, diogo.ivo@siemens.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, rogerq@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 ssantosh@kernel.org, nm@ti.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, srk@ti.com, vigneshr@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 17:56:50 +0530 you wrote:
> Hi,
> 
> This series adds support for PA_STATS. Previously this series was a
> standalone patch adding documentation for PA_STATS in dt-bindings file
> ti,pruss.yaml.
> 
> As discussed in v4, posting driver and binding patch together.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
    https://git.kernel.org/netdev/net-next/c/be91edc81b09
  - [net-next,v7,2/2] net: ti: icssg-prueth: Add support for PA Stats
    https://git.kernel.org/netdev/net-next/c/550ee90ac61c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




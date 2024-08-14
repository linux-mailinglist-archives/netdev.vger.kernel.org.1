Return-Path: <netdev+bounces-118261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31D951188
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE5285AE0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFDC1BF53;
	Wed, 14 Aug 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs3TfiGz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA621864C;
	Wed, 14 Aug 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598433; cv=none; b=T/tH6dw/ZP8DJKMZW8E39EnEkG7cgBcYh2fTX6uCHdNFOpI3PhEiRGgOKBPLfX4R66Yeb/qcIQbiil5pdG7Vbed1J7Q49E1mq6Ruli1wNUdJ/pcqI6wI9Hk1jRgk1t7vU3G2eVrbqI45Y8c6FBC7x6shkn6lLaZOiypMOJGE2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598433; c=relaxed/simple;
	bh=CbSTNChG/7usi/L4xT2p8Vq+mHUjwbSjnAPNoSiIvtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCflS6iLStEzLwa8wg6QBlfiFkFWRxlgiBJubM6EP7OT2SyypmQlJ92xW3CIlSu6RRwGu1CKTZBJk8YJpRMgNJrqaoGsERGNNaqBAaSPXgrmujdShvnAV/KCECz/4YGjehNY98amLO23c9RGtHVjb1inaHEvFnWpZcmu52OfSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs3TfiGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF22C4AF09;
	Wed, 14 Aug 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723598431;
	bh=CbSTNChG/7usi/L4xT2p8Vq+mHUjwbSjnAPNoSiIvtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vs3TfiGz84cOTRtm+gVypeRnILxvGKMP5x7GbzLw+j8DJX7rAfORb5UmmersMvW1e
	 gizBpk+3j+IM77b9Vk4wWaZSvQdKaO8GEAJSJiGyzbO8rPrkPJ7hOxINZ7TLQJUIFa
	 MTsercWnqSx36XQWEUHbaMC0RTxuP8pJBNR7qZnfQVqvEusJuf1BOam2SMYAn0Jidc
	 UvqBxCPdq6JwJGPQWNGbOO/RJ1mvbJeDkbMN0fQiT4xQb7kgtNaLTzSSuIcOY+s0F0
	 yi8Cm1uScuYUFoKRRAK0ncBVICHvcgAB97LxBpK4cEOkgpNodd0l8/F5iAysUvgL9Z
	 +ccjUyngry2Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9C33823327;
	Wed, 14 Aug 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using
 unevaluatedProperties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172359843050.1830772.5023113302454466803.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 01:20:30 +0000
References: <20240811184049.3759195-1-Frank.Li@nxp.com>
In-Reply-To: <20240811184049.3759195-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ioana.ciornei@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Aug 2024 14:40:49 -0400 you wrote:
> Replace additionalProperties with unevaluatedProperties because it have
> allOf: $ref: ethernet-controller.yaml#.
> 
> Remove all properties, which already defined in ethernet-controller.yaml.
> 
> Fixed below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
>    fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
> 
> [...]

Here is the summary with links:
  - [v3,1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using unevaluatedProperties
    https://git.kernel.org/netdev/net-next/c/be034ee6c33d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




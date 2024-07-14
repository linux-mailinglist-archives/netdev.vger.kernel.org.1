Return-Path: <netdev+bounces-111347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE8930A71
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7911C1C20B12
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF03E487;
	Sun, 14 Jul 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbGfa+US"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A222572;
	Sun, 14 Jul 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720969232; cv=none; b=oa11/dMkBlRYDoHpevkxJV1NigfUKRIoo5Od2TtrjmYgvPDBAp1FkZhOBYtSltzWWm2ASQgIovGDJEWcGBpPCL1AdxpGVaV76TpruY6nuMXg9rehcwGl7PZX5fmFXzcuE37Ykdr2vHUv0bKAqLQwDGoCYFsM5uzHBmc1dzqrg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720969232; c=relaxed/simple;
	bh=+cPb97wAZfM32zRElZFBPsLMdUjvjSl42lJfGFMxxR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ysy5WJlbIT0g/OUzJAyNTg6aYdYS1oshyhJqPr17bG6egWO1+8tzg/UGnQ8P8e2LX8vxoBg1x6yzArzUoC2fgRuQ6QdxmAhAC4G79qpDmOw86j07TLmEn4PSGyX2sQp4Y9fqMXXZVOABbe95vbuw4/VfBOxlhv2uh9cg3SMSgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbGfa+US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3578DC4AF09;
	Sun, 14 Jul 2024 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720969230;
	bh=+cPb97wAZfM32zRElZFBPsLMdUjvjSl42lJfGFMxxR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbGfa+UStMlJktycJpDvj+0FfpCFeD5bE1wKhc6HSa4HDBcwAgGlHuRZBzrjWdL10
	 7mFrxwhaYKsUp2nptGJqY1U/6k+392MPiinGdiKu4Ods5XknXCJQsiUhGum8Ubcmli
	 Hrt+sy2lb7O1iRCqKhhcrLS8YON8CWHwmkCU+H+cdRMtefA3NJwS3LL/zZE+Kp+uzx
	 uAvolQveUH1YfawDaoiE0asb4DgZs8Q8vUJHTVF0ovqTiwJGggRCNELxttmDNsQn8j
	 RyIjGyFla7AQC9X9XyCxP00GfOLX0GiFN7x8rVgvzD6PnqThHfiSPRMQSDNZENqhMk
	 qGKnubOube6Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 212C4C43168;
	Sun, 14 Jul 2024 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 net-next 0/2] Introduce EN7581 ethernet support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096923013.10852.5740628662029215920.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 15:00:30 +0000
References: <cover.1720818878.git.lorenzo@kernel.org>
In-Reply-To: <cover.1720818878.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 conor@kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 benjamin.larsson@genexis.eu, rkannoth@marvell.com, sgoutham@marvell.com,
 andrew@lunn.ch, arnd@arndb.de, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 23:27:56 +0200 you wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
> 
> [...]

Here is the summary with links:
  - [v8,net-next,1/2] dt-bindings: net: airoha: Add EN7581 ethernet controller
    https://git.kernel.org/netdev/net-next/c/6bc8719c9dbf
  - [v8,net-next,2/2] net: airoha: Introduce ethernet support for EN7581 SoC
    https://git.kernel.org/netdev/net-next/c/23020f049327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




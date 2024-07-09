Return-Path: <netdev+bounces-110411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C492C398
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D60B2195B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94128182A58;
	Tue,  9 Jul 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJFzDerB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35C182A4A;
	Tue,  9 Jul 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551722; cv=none; b=W59UMZnwKsQnLT93A0g3MyzLCs6d/Ou2TmzluGQhbzDfzsYvBOiEoSFKCCZr4NKOhkU8eVg46NDEGgU6ir+3ny1wQg/4m2gAkekYB55pE1PIkB+7C7thG+zliblT0Fh9/OuMdEHjQC+e3O0LrJ2otkNIh0BK5MX2k6DRVvz0V+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551722; c=relaxed/simple;
	bh=3ZZ7DQEKNnruhiUNY73zpvLr0deMx91HrqS4mL+RFKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nfdZK2K3mU39ysGsqIfshFW4hAfuQiFk3s6r2WFUEEM2rN1sbUfSJ0F/NaIxcW6A28t0cI1YGmPHMKhFqrGY7loq76hAQKKBor3Q7Zx0kbPYXCZd+hGl/MjLoV7bpVAnFF3x+463wsE4v98HOEi6po897VHdZz+fK745X33vqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJFzDerB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD1ACC4AF0A;
	Tue,  9 Jul 2024 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720551721;
	bh=3ZZ7DQEKNnruhiUNY73zpvLr0deMx91HrqS4mL+RFKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJFzDerB7RWVTBoUS8duP83uuKUWvlPEaIPb/nanYborBpEDO0Hi7yQRxY8wb3Sv0
	 yBRjMZiUTBQxEcJWfLL5Y5ui0Wcau9z7GQL3WKLEPnkstBaNkxFoOJw2iZI2H9iR3l
	 QU8R0qBY9TsjmeAJIRfCGO64Pv802Hrcb5YT7waZ4XVl3T84k6DlUOtSAk2u9YgECu
	 qCR6+VvyVCLA7hkHHhSWXVS+T8iP/JOb1ydKjRzjfMTa4oZqx+rj8mMKK6+bMZgJvx
	 wEk0yzX9boaNNz2qypPRsZ0uvTIyAHA3MjeFtZf2pLYnygT8x7zDUH58bHVFjTOWDC
	 HLURNEm6yiiVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE605C43468;
	Tue,  9 Jul 2024 19:02:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] dt-bindings: net: fsl,fman: allow dma-coherent
 property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172055172184.32169.14387199835490742511.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 19:02:01 +0000
References: <20240708180949.1898495-1-Frank.Li@nxp.com>
In-Reply-To: <20240708180949.1898495-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, imx@lists.linux.dev,
 krzk+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 madalin.bucur@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.anderson@seco.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 14:09:48 -0400 you wrote:
> Add dma-coherent property to fix below warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: fman@1a00000: 'dma-coherent', 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/2] dt-bindings: net: fsl,fman: allow dma-coherent property
    https://git.kernel.org/netdev/net-next/c/dd84d831ef27
  - [v4,2/2] dt-bindings: net: fsl,fman: add ptimer-handle property
    https://git.kernel.org/netdev/net-next/c/5618ced01979

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




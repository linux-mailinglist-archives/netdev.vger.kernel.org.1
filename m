Return-Path: <netdev+bounces-105524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF0911909
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5201A1F22008
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768F12B177;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtkyt800"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40871127E3A;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718940629; cv=none; b=ihCFw3etrne34u63aHMzNuTPD7qxR7eachbTJuPElx1lyWSgeDK32lC1LEu0IwezLKwX8js4xQbWby99hNnXJ68rVnInrdyXjTxB+HEBa9iVDNGTb6VN3rVfpIGOBZ/rd9O0adjGQvyl6R93S2QEKq2ILvuuDaE1eKfb9j5xcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718940629; c=relaxed/simple;
	bh=2mYMXjX29fi55D5g2l2UWjNziXoIrhfZLtU4atjQj3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ka7Qkc5cMiwAwbLrjapKhYfk/7vDABL6khaloTMOXUgP+GiqWAlEVo6XQ/FNxM0RpTMLjwvBVebXOE9Xyr+QXoHLusRJnM1004uPatb7BDx8SDx77iI7eafer5Pbng9LvaJbCNvUPSFzOH6I4KncH0if+NBWqjMbvx2S7ytBBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtkyt800; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9700C4AF0B;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718940628;
	bh=2mYMXjX29fi55D5g2l2UWjNziXoIrhfZLtU4atjQj3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dtkyt800TWF5rvw0yMW7HAxIL76cK60WbsGYYwkEY31q9yKvlgnxmpdqhAY/0jGb5
	 ahXoGYOhdbUPBq5bcK2KcxvIO3ezBszpKny58VsynDcq2u/oxPaYIq2qHwe6lVPXqC
	 WAZlb3e/xmlkImkyJ+gckKtPXU4QK16bJZD4/scXLlOWCT6rzk0XBnTpHkSS5DDUDE
	 cohA9iJFmd6Yo7qC3EFv/oEr6cMde2WLFsA6yl+rDNdz1R88YMm3kgqhv6RzMxUezc
	 Bp+ocsTArpzJSKNZMvDQF2xA+ENM8yqt3EpjBilrNrcThP4d6N8tT/QVkQ6JSGtHQu
	 SCNEpcFTrxsWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3916CF3B97;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] dt-bindings: net: Convert fsl,fman related file to
 yaml format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171894062873.32761.11046723510194235646.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:30:28 +0000
References: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
In-Reply-To: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: yangbo.lu@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 madalin.bucur@nxp.com, sean.anderson@seco.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 17:53:44 -0400 you wrote:
> Passed dt_binding_check
> Run dt_binding_check: fsl,fman-mdio.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/net/fsl,fman-mdio.example.dts
>   DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-mdio.example.dtb
> Run dt_binding_check: fsl,fman-muram.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/net/fsl,fman-muram.example.dts
>   DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-muram.example.dtb
> Run dt_binding_check: fsl,fman-port.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/net/fsl,fman-port.example.dts
>   DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-port.example.dtb
> Run dt_binding_check: fsl,fman.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/net/fsl,fman.example.dts
>   DTC_CHK Documentation/devicetree/bindings/net/fsl,fman.example.dtb
> Run dt_binding_check: ptp-qoriq.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/ptp/ptp-qoriq.example.dts
>   DTC_CHK Documentation/devicetree/bindings/ptp/ptp-qoriq.example.dtb
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
    https://git.kernel.org/netdev/net-next/c/01479f1b912a
  - [v2,2/2] dt-bindings: net: Convert fsl-fman to yaml
    https://git.kernel.org/netdev/net-next/c/243996d172a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




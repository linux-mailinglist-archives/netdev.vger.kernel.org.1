Return-Path: <netdev+bounces-200445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2DAE584F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B5D1B61691
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF2170826;
	Tue, 24 Jun 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIdQQ3Zl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC1158218;
	Tue, 24 Jun 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723799; cv=none; b=AIr2jHC6EtDMIlEQYufoDRgsjc5i9c8qnDx5zseQagGmGjFLzG+ZH0E0b7uGSvTpV1cibAUdlqIGiDh8qg6aB7kUF7X2khfOvChE3urqRdxrR4O/k3yD3aFxibJ+t6+pWMtDymwgSu34XSw482+8Q2O/8JR64N45vMBfP7FpVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723799; c=relaxed/simple;
	bh=pW95yHEMeVn3jqyr3o19XpeEtpyPZ5xPH60sWih6rNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QwIrfEn5mYdN3n8LpoJLf3rYM0qOD64nMqTLq5OhuKfmIYaxr8S9Jrwi3fPK+jq6JQS2hVZ9lFyLpfiNvZPBlZ0Pb+r4ZJR02joIoHqP0rdzUe/TFev/E6UZ0NKtlp6IUDSqnIRLIOJmpL95IlHSlkTepLCnnvBT9KamUeHNqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIdQQ3Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69746C4CEEF;
	Tue, 24 Jun 2025 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750723799;
	bh=pW95yHEMeVn3jqyr3o19XpeEtpyPZ5xPH60sWih6rNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIdQQ3ZlSgkRTvLmxvRTWgcrsAdZrnzyBBn5KYMrIIEoM3rIdBnNjvY5t4nGcnS6b
	 jXOjsB4M/J8jdBijuWYgMALfmkITQtHm4lWEqfOWrgyT+RNabNMhK48GijEqRI02Ge
	 nusssNnjIzn3dxuLpfmgglWTIoPj9QqBrhB/CZK3keI2Fl8x/aFOq7+ynBH/GY4wf2
	 asHj654lUO4m2qO6iWm0dmroXVjwMcVXGT+Mg63Hu8lWRvDRKZLjXrwPlfGxAsm2Yi
	 nePgetepVtxdba0BamkkDn/bdITuy31jEyRnd/l9oj+jNyO28BT4nFeyQWxAH7yyFT
	 FZjSafKtSBm8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4839FEB7D;
	Tue, 24 Jun 2025 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072382624.3339593.9446372641368170641.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:10:26 +0000
References: <20250618184417.2169745-1-Frank.Li@nxp.com>
In-Reply-To: <20250618184417.2169745-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, wahrenst@gmx.net, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 14:44:16 -0400 you wrote:
> Convert qca,qca7000.txt yaml format.
> 
> Additional changes:
> - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
>   ethernet-controller.yaml.
> - simple spi and uart node name.
> - use low case for mac address in examples.
> - add check reg choose spi-peripheral-props.yaml or
>   spi-peripheral-props.yaml.
> 
> [...]

Here is the summary with links:
  - [v5,1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
    https://git.kernel.org/netdev/net-next/c/bf92ffb0d332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




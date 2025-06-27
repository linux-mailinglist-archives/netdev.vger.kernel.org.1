Return-Path: <netdev+bounces-202062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E480AEC251
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9042A1696A9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DC828A3ED;
	Fri, 27 Jun 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyU5z3NZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA71FBCB5;
	Fri, 27 Jun 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060985; cv=none; b=VTC1+keLqFZ2cJfVwysRKg0wQ7uDlzDyBuT3qwsMqmedIfsDLl/J8ZPJRAvQHD4ceGydFsBXBXLvT8K808QED0OBkQynBGCih9drKdJCUNutkFCDF0LJWlddtrDPyDszacm3sF5XV3vxywR1EGkoSN2LFTVyyJNLjmneUUO5a3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060985; c=relaxed/simple;
	bh=hgxUL7xiwE4tUa2rsvfo7VjsWj47kenno+ivK9/co2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XurXetwZH/K7rg6OfgMtZ0bk1Ux0uk7RMq8K/wVsM/I5lM06fL3/CLEd4Ol80nv0D4UpST2Fry9nwLa3egv8T1OrPpv9K2veeYp8ZZBlQ5hpIluAG8HXBLbz52wagZHBAvMjAzRUOqd35lr9Fd4r9n2/6Z5DYz0dwszoYIPXzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyU5z3NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796E5C4CEE3;
	Fri, 27 Jun 2025 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060982;
	bh=hgxUL7xiwE4tUa2rsvfo7VjsWj47kenno+ivK9/co2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QyU5z3NZtnm1FUgsQrvzhTsvTdZLqZBMwPMpdbjFsh2KRiSZbCAN4cviBuHL2qAXA
	 5jeC5SJa3AqZ7P2S6oXxXzXN6uxWQzW9qKavhW7+TsH7d23RQHhIH9vehMqkx4Xqgw
	 Y8MQaFJR1okqo//v7I5dXNQTOQU9Tayok/yyog3WSHmyVDguXzA2DQ75WSIRQVltKv
	 mA3qtnqrs5shvB85pW+EdaQw+QZu34Ogbs5TFxmEGNpsqd+zGNEfbCb2cOraEdKOpF
	 4OXRKrHmKu0m/UoMN6IduKgaGBAVA4oF2H7cubOi/3+uU2+a4Y6K7Ct2GnxgOXQw1i
	 Jw2OLkBYB9qiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3838111CE;
	Fri, 27 Jun 2025 21:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-bindings: net: convert lpc-eth.txt yaml format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106100851.2070276.13573893060080860455.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 21:50:08 +0000
References: <20250624202028.2516257-1-Frank.Li@nxp.com>
In-Reply-To: <20250624202028.2516257-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 16:20:27 -0400 you wrote:
> Convert lpc-eth.txt yaml format.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/net/lpc-eth.txt       | 28 -----------
>  .../devicetree/bindings/net/nxp,lpc-eth.yaml  | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/lpc-eth.txt
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml

Here is the summary with links:
  - [1/1] dt-bindings: net: convert lpc-eth.txt yaml format
    https://git.kernel.org/netdev/net-next/c/cb70b1bb73e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




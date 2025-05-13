Return-Path: <netdev+bounces-189947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1418AB490E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D2A464095
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE119D093;
	Tue, 13 May 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iseWqNJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC62199252;
	Tue, 13 May 2025 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101611; cv=none; b=L27OqzA5LOPalcoyNNIVUxxXyBIIXdM5F+hSldYfDEFqhdxvaXIhVHI7TqKUHkow4jexlFHnm3nV6q+v7BK3VdKr/x8YhtwQuMuEj2xJIlNbso6oHTUVTFbq60QtWUlrpN7qqJTzQkyjZ/BkNTlB4NDZKhzIceNJRK6N7DlmTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101611; c=relaxed/simple;
	bh=Jm6O3oZnQBFnXFODoXYNlE6Cl4goHN+1GeltvukLXKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJrBeyldh18BNfnPK3BGlPV4R6OOIvwOSlkB4zN8k6PB+v9yUAk3JsTNCkfn7/X6p3OzS7o71p2AI+uW7L3NFk2+SxG85vyK1uGqzh1b6k+wqXMmkCHMAeIGFp/O59nEe7eSrh1JHdiFo5V62CrcAhYMw37gQ8sqkZQrhN1EDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iseWqNJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C2C4CEE7;
	Tue, 13 May 2025 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747101610;
	bh=Jm6O3oZnQBFnXFODoXYNlE6Cl4goHN+1GeltvukLXKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iseWqNJ0yaXLH6jsViobGUL/7mVUIhy2lKeneECZZlxOJidks0+00W932SCTeIsrU
	 IUu9TDQe6EhQaxhv/PRCxUaoME5zG2vSuCaLoyGS3w4KoKWblQOdS18BAbOmszEEno
	 ccwvJkgC6bmZ/OVhQ6U0qoii4zVikF2CHHJoHNc4KeLysOKwcbVBpz/C6fTIxIxSyF
	 Z8D4doSlGlsHPYNWc3hsHILkmizqr1Vop2O3Mg+AZz/1FDUGm9Pyg8CZAovF5wVVh6
	 NufPtetBbNURZ8/v6DYV0ZHW6XgSuGgizD5klulF5A03qAEXlEzfYoYWJFo5Av0rFb
	 FQo+yZRUHFcLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0039D60BB;
	Tue, 13 May 2025 02:00:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/6] net: vertexcom: mse102x: Improve RX handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710164798.1142511.4752177124866760612.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:00:47 +0000
References: <20250509120435.43646-1-wahrenst@gmx.net>
In-Reply-To: <20250509120435.43646-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 May 2025 14:04:29 +0200 you wrote:
> This series is the second part of two series for the Vertexcom driver.
> It contains some improvements for the RX handling of the Vertexcom MSE102x.
> 
> Changes in V3:
> - Fix whitespace issue in patch 4
> 
> Changes in V2:
> - Add Andrew's Reviewed-by to patch 1-2
> - Fix build issue reported by Jakub & kernel test bot in patch 2
> - Use Andrew's suggestion for netdev_warn_once in patch 2
> - Improve commit logs for patch 3 & 5
> - Add new patch 4 to compensate loss of invalid CMD counter
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/6] dt-bindings: vertexcom-mse102x: Fix IRQ type in example
    https://git.kernel.org/netdev/net-next/c/a29a72866616
  - [net-next,V3,2/6] net: vertexcom: mse102x: Add warning about IRQ trigger type
    https://git.kernel.org/netdev/net-next/c/fed56943a8ba
  - [net-next,V3,3/6] net: vertexcom: mse102x: Drop invalid cmd stats
    https://git.kernel.org/netdev/net-next/c/aeb90c40ee9a
  - [net-next,V3,4/6] net: vertexcom: mse102x: Implement flag for valid CMD
    https://git.kernel.org/netdev/net-next/c/6ce9348468c5
  - [net-next,V3,5/6] net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
    https://git.kernel.org/netdev/net-next/c/4ecf56f4b660
  - [net-next,V3,6/6] net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi
    https://git.kernel.org/netdev/net-next/c/8ea6e51e54c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-65845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F80F83C054
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A171F21A77
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7B58238;
	Thu, 25 Jan 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePOMKZRg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4B3FE2B
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180427; cv=none; b=qUsIrcoExo+4RGux6xapJDUJCI4NA3ZjKAFpEhh/8NacO0WMpMu8PaMeDok/a33eLGOFpv+Vth98OBTt/waNL5SB8RSXsKUcXQ1OhHPEjmcVb98pMcFkuS42cEmSUAnNM9v5pzYpKyH97YtunNI+sejOvHWWNncPpaWPcZPLxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180427; c=relaxed/simple;
	bh=ssVANiXVMl+qiKXCkJfAsXgoW59i1Wh/GpGUAHZFaP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ao1e4z6zXt/z6TyxKPEwfBExnEmUNphAExddVjRyOdTLiSKJMml5eO9HvZkpkJc66NkDqAuxqmAmTV6sk5z0iDZ9UGeqkUVlOHJl6SxDEv3KyCsmLf9xIqjOHyipgaJdboq/Bct88hE5F84prUenDK17NJT/B99NN9nsFMr1964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePOMKZRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EDA2C43390;
	Thu, 25 Jan 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706180427;
	bh=ssVANiXVMl+qiKXCkJfAsXgoW59i1Wh/GpGUAHZFaP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ePOMKZRg3qLEn+o/Aavd1hBz80nhx06qaEcEDfgDoDTA7ytQkhLqHvMsYB1GPL3Eh
	 yhVpcAWUSA4JzP3D956eSScy6mWX9WwAaZF5v220XCORT+0GUatGbDmYElOeA1v6yZ
	 a8BXBmDpWI8OQPRLrP6KFXApx/fjjNAOC6mSTS78WYb7XRNyJoRXlvl26NxYFrfd7J
	 YGXHcvajBuZw7dzIXZ/rd7/apD2UPzdJFgbpVoWsfhYDvqybNm8NRheLhDnMTILGOX
	 4EUnsVUigDV6q4+TseJCppBo8UFGt3hGK3XBN0l7DlJDnHHXZjH9RxUsSuHjEFdtyh
	 rEupaMf2409sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 364D0D8C962;
	Thu, 25 Jan 2024 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 01/14] net/mlx5e: Use the correct lag ports number when creating
 TISes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170618042721.7005.16098750210142855838.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 11:00:27 +0000
References: <20240124081855.115410-2-saeed@kernel.org>
In-Reply-To: <20240124081855.115410-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 24 Jan 2024 00:18:42 -0800 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> The cited commit moved the code of mlx5e_create_tises() and changed the
> loop to create TISes over MLX5_MAX_PORTS constant value, instead of
> getting the correct lag ports supported by the device, which can cause
> FW errors on devices with less than MLX5_MAX_PORTS ports.
> 
> [...]

Here is the summary with links:
  - [net,01/14] net/mlx5e: Use the correct lag ports number when creating TISes
    https://git.kernel.org/netdev/net/c/25461ce8b3d2
  - [net,02/14] net/mlx5: Fix query of sd_group field
    https://git.kernel.org/netdev/net/c/cfbc3608a8c6
  - [net,03/14] net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context
    https://git.kernel.org/netdev/net/c/3876638b2c7e
  - [net,04/14] net/mlx5e: Fix inconsistent hairpin RQT sizes
    https://git.kernel.org/netdev/net/c/c20767fd45e8
  - [net,05/14] net/mlx5e: Fix peer flow lists handling
    https://git.kernel.org/netdev/net/c/d76fdd31f953
  - [net,06/14] net/mlx5: Fix a WARN upon a callback command failure
    https://git.kernel.org/netdev/net/c/cc8091587779
  - [net,07/14] net/mlx5: Bridge, fix multicast packets sent to uplink
    https://git.kernel.org/netdev/net/c/ec7cc38ef9f8
  - [net,08/14] net/mlx5: DR, Use the right GVMI number for drop action
    https://git.kernel.org/netdev/net/c/5665954293f1
  - [net,09/14] net/mlx5: DR, Can't go to uplink vport on RX rule
    https://git.kernel.org/netdev/net/c/5b2a2523eeea
  - [net,10/14] net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO
    https://git.kernel.org/netdev/net/c/20cbf8cbb827
  - [net,11/14] net/mlx5e: Allow software parsing when IPsec crypto is enabled
    https://git.kernel.org/netdev/net/c/20f5468a7988
  - [net,12/14] net/mlx5e: Ignore IPsec replay window values on sender side
    https://git.kernel.org/netdev/net/c/315a597f9bcf
  - [net,13/14] net/mlx5e: fix a double-free in arfs_create_groups
    https://git.kernel.org/netdev/net/c/3c6d5189246f
  - [net,14/14] net/mlx5e: fix a potential double-free in fs_any_create_groups
    https://git.kernel.org/netdev/net/c/aef855df7e1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




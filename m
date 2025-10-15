Return-Path: <netdev+bounces-229773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBCBE0AB0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 287524F31DA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34630E849;
	Wed, 15 Oct 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz6GSFVe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948030E824
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560832; cv=none; b=Ts+fC4jCjwp3ym3/88FIj0wJZdGTmz4gJOPyhzTer+3DBsLur5yzpeLPT9LREbY81oPDv4nEoMr7MV2GUdhI0LLEVwW4h/VLCBuvCCHR6I0/A3ijGrnXv46qHhk3On9vGPe8dxh9mcXghxQF32Kzj9u4BudQb8Au85AEvtsWAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560832; c=relaxed/simple;
	bh=EftGyIXEGaUzMrsX9S/f3QJToESiS40qCQRL0i8sY2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7/2InfRcM4qbhVwHcT/Na1Pd138ejJmoQ0G/hXBktmODI9N5Bb9GnGoFTKwFLB7ujh+WZ5xSaXaEnKBds0VoEp6sIdacwPMd1ZJK0CW1GnpfO6b3mMwlJUAvMGGEd7Wd1b6ba2ZVk4805Dgf81jLy+E4gyjzSF8LKlSq/18psM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz6GSFVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E6C4CEF8;
	Wed, 15 Oct 2025 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760560832;
	bh=EftGyIXEGaUzMrsX9S/f3QJToESiS40qCQRL0i8sY2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lz6GSFVeIOMWWf/yQRg5oLjQmASsbb9Jox3ak643c8d0s4krluzdPgFgwI3R88a3K
	 y9q8XGEYHo2954m1zoFO4ZflNUfYrMIRsn2O/gfDtF9wEGJMQqGDdLiLBN+cEWLPDo
	 mI3AlmHEtbi9NJPRb6Wu8SdQrF/R1Wl/H6E1No7n/K7ULbMA33ZXVVSVCYpnJp69wi
	 MTgZJMO+9ZdgUpFA77vYAJP7USKwm4fJXQlpE1PJaPb4xOI7X13UEh+KaZcEx/A0wr
	 ulqf7ZcOBlyT8dn4q7dN2V1NIXCpmk0RjQaLZLu8GVwiV/jeDqBCVp4iLvApd9MjvO
	 4IidD1WiICj0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEED380DBDF;
	Wed, 15 Oct 2025 20:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: remove unused platform code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176056081674.1041854.17951906850290237953.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 20:40:16 +0000
References: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
In-Reply-To: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 f.fainelli@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 08:02:47 +0200 you wrote:
> This effectively reverts b0ba512e25d7 ("net: bcmgenet: enable driver to
> work without a device tree"). There has never been an in-tree user of
> struct bcmgenet_platform_data, all devices use OF or ACPI.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  MAINTAINERS                                   |  1 -
>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 20 ++---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c  | 75 +------------------
>  include/linux/platform_data/bcmgenet.h        | 19 -----
>  4 files changed, 7 insertions(+), 108 deletions(-)
>  delete mode 100644 include/linux/platform_data/bcmgenet.h

Here is the summary with links:
  - [net-next] net: bcmgenet: remove unused platform code
    https://git.kernel.org/netdev/net-next/c/378e6523ebb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




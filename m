Return-Path: <netdev+bounces-196722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF3AD6118
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683A7178075
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBF2475E8;
	Wed, 11 Jun 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRfPnrxF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDD2472B5
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676804; cv=none; b=i/2IrjiGNAxEKixdew51AuWANMHBL9R49MIkRBUHa0BLbClkIQT4YvvY5VNRYlmfwveT7vT1iTnGGbIZXU3NroP1py+LE5qv7eo5oeus5Thv2bDs3/bQXs33IwtMqN9XmnwW1uk2SP1q7ziUUAeRuEbMUz0Gpg3oyxPdApgKWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676804; c=relaxed/simple;
	bh=iXWnMeDRI3Wvty3AIOK/4L9SQFqNNM8L99k1K4czOOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dziT/+dqgnJnBq8X9cYlXg0xTuOF+rgtQhrIP6Tg4vcgpwKHbk6WvPj2e6/twhT3fo9zLYN4aizNMF87/7lWledezidCtdI8CyUExmwAFLIT53jCE9Q7jlrsSmuA1aP/wung1ePh0fydbiJYJNOD9w0OEs757F+WPFHWL6DKlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRfPnrxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F562C4CEE3;
	Wed, 11 Jun 2025 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676804;
	bh=iXWnMeDRI3Wvty3AIOK/4L9SQFqNNM8L99k1K4czOOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BRfPnrxFpExLPWptRDBPIJmcMW1XZDObfIIK4oN3hTlKMw4P7Y1MJMzY9qqiqq/0N
	 m74ohHsAVCF4Ke+uJ3xgC8ShS3oAo8GddaWnkAFtzRdlWgCkVM4AZP1/uNkXmrtzxV
	 SEjRm6WWuhW9IJBisMP0H5HGdJitV0oeLP01wOVz13Rz3JwSgvRG4mG6M2AwAfB4Ab
	 K268uK7xFlR0MjRpnWf4BFZhqoMBcLL9WO+gjd3PdgoHXE5zXCt2yjPZOVqaSlcjLs
	 LcsHDsBnaw1c3UlKuVFMDVrvSom1z2e4Y+lasZaV2ga6pb+hwnDJ/AaxLE/yyuGxvQ
	 0MUviM0r7pwPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDF380DBE9;
	Wed, 11 Jun 2025 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove redundant pci_tbl entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967683449.3488937.11711221422088405505.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:20:34 +0000
References: <2d81fe20-f71d-4483-817d-d46f9ec88cce@gmail.com>
In-Reply-To: <2d81fe20-f71d-4483-817d-d46f9ec88cce@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 07:46:02 +0200 you wrote:
> This entry is covered by the entry in the next line already.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove redundant pci_tbl entry
    https://git.kernel.org/netdev/net-next/c/f6a0bc565028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




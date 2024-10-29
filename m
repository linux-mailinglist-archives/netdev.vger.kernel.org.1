Return-Path: <netdev+bounces-140194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F19B580D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A51F2415F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176220FAAD;
	Tue, 29 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fF4OJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A520FAA4
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245829; cv=none; b=EBXxcfdvvQ8dHuAf4Oq7gVoWcZ/N0c8IxyIvZ2LS1yceQ8dXcrf9ct6QkEcRtknQJl8PyFDwlDV9cfKtkdsei6OsxTpSaRqdksE19llq7OZwD3E13EDeywbD13d+Elhf1oAg3MWJB/mKSUjtYJBpfLdMIvzK4L7gyUGomiDaNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245829; c=relaxed/simple;
	bh=4hJyzoHVEu5hInBeYjSVNLRdvFYYqG0LmqczDYfIO5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aUxAWWMg6QcpppzSL/LlzlCWm4hqSURukFU9ud7f/ldc+A5+/Xh9q+i5QCmqZsn1uaqB5gY+pn+V2vnyHFtbK9WW3YWcOknzFAq19vf1AuFrZtN0wsLAO960A1IWDDzHjLk2RoGAPAieNfrYclcoqBR2RtXGaIj92olP97bMmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fF4OJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21440C4CEE3;
	Tue, 29 Oct 2024 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245829;
	bh=4hJyzoHVEu5hInBeYjSVNLRdvFYYqG0LmqczDYfIO5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9fF4OJJr6EqT3+OfcKwpHB2DvCekt9d+lgCAwgUjPaoX1QMFOGGnTqpa9XAPqNjz
	 vixm1jPgqg6T0HjLVRLPpvoMJMGAbVxTu5+nsv1nisALwVbXL9ZQ/R0DtSz9WGhPm3
	 b4efY3EODHpT6tUjLmAB0o/6SzDmNLBINC8dkjAs3Ar96rUuB0Ycy23lgmxKrUVCXL
	 x8bjQTU3ZJP7Hni7Lv+6RqN9C4skBwkhqmCGtQxq1mgqLjkeogiBf7/6vFbf3p5vbD
	 92S9heRPuRnhPp9gmkkPXZMnutuntI3c8L/zSmHHI11ZGzhDVS6kYqLnzjhL+dJ7j8
	 1UYD9WQ3OzQ0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBCCB380AC00;
	Tue, 29 Oct 2024 23:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for RTL8125D
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024583649.858719.14140374055070611577.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:50:36 +0000
References: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
In-Reply-To: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 22:42:33 +0200 you wrote:
> This adds support for new chip version RTL8125D, which can be found on
> boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
> for this chip version is available in linux-firmware already.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
>  .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++++++
>  3 files changed, 27 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] r8169: add support for RTL8125D
    https://git.kernel.org/netdev/net-next/c/f75d1fbe7809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-196399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F36AD4794
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC317140F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7335962;
	Wed, 11 Jun 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI2wiENi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DC2D7BF
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603602; cv=none; b=gWPGl9Ctn5HS/G5ww9NZL6YCHfwqtjt+vdMGYkugt8Q00UBG2pyuHjKHGuF1XQhrsxzxshDV9vv8egIyohtLRXbWMyM4B8+I4C9D4dZ/Wh9WPqMY3+T17JZYaVryyWxbx6RxoHEGDEtXGGhSqcCwHWnATmiHvERG9PYu0VARIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603602; c=relaxed/simple;
	bh=cDlgL9TIpTlOy9qfViDqqnNylmEqXONsBlqRKuuJ9Mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMtxHebplnnUiXR3kJRUgQ2bLm4gspCvznHg6NzXdoLapS5LpFXQUGapYhpXzeXsuYJR6+fPUdXnIwPH3ZEedGvSUa70/+96+MKm/wk85AYkUNeNSoRMdOCCQF0Y0IOfeWJZv4r3iY4ODJFhYS0ozP8AwAYoyaiMDYHaLEDYC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI2wiENi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8DBC4CEED;
	Wed, 11 Jun 2025 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603601;
	bh=cDlgL9TIpTlOy9qfViDqqnNylmEqXONsBlqRKuuJ9Mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KI2wiENi0OoTu8cyoIEtIpz5gUvXQ92Id8s+MbreiV4S+yc9084DLWGoL9R0LvsZZ
	 VjR2rlLDR66AN70GIa12bO1S4/HIm8ls70zfdK64hDvTMxEfH17wzsy+pYTEUt4R+o
	 +4QdjB29x4EggOerNzzgWYjH4INFm3f7c13Biy931vJrOd7e1L4yF7RnVCpHJJdOXX
	 EY33BfGMsqRbeKnUgLpKgxxkgZUfsl3lpT7Ih3Fdk7mzO2CEd3gCOR1/3PX5qHVsXK
	 2CgFP3s2b9sAk0c6aa2C4MNoH41bMzSSu2poCijR9sQv7r/dRWOAxzvJfq0JwO4QVw
	 wgjfk+NoiXsIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5438111E3;
	Wed, 11 Jun 2025 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Add PPPoE offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174960363200.2754897.16334165620003903309.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 01:00:32 +0000
References: <20250609-b4-airoha-flowtable-pppoe-v1-1-1520fa7711b4@kernel.org>
In-Reply-To: <20250609-b4-airoha-flowtable-pppoe-v1-1-1520fa7711b4@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 22:28:40 +0200 you wrote:
> Introduce flowtable hw acceleration for PPPoE traffic.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Add PPPoE offload support
    https://git.kernel.org/netdev/net-next/c/0097c4195b1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




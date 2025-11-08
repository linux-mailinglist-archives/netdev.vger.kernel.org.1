Return-Path: <netdev+bounces-236940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EFC42553
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B00FF4E306B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30402561D1;
	Sat,  8 Nov 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfNRMKN3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64E157480
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570853; cv=none; b=ijn60MUkq/P2Vgs/ghqPyC37YJHrCK26exynSrkULxUto2zLJljmt2mLuQYMwt6phcTJRwSY7V9vnk0QmwA+a/KKpF+O9U/5b5H58vPM7Ft20DeBu/XVJvZdOPdFsgiUc6pdd7g0HZnN5ItuO6ORk3E+gnSRqdscd5QfGD4sbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570853; c=relaxed/simple;
	bh=ShtdBZw8Sfag9tmAlo1Nbuy3uzpfzP2tPZoA8BFmlQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4UHZ0FGd7deqj19vJz+hNzlTzN0kAvGYTrE1dtcsbMd1zPXvPwjFMnFFzKrvGd2vzn+bX9m0nJZFG2ZTtlP3Vel4VFuajNjxvO4cknYTRxzHf7Axg9Yr8mYbPdCFdJR/iJW/CUbFnP5obUSxIFf0OX4oI290ltaWaKVF3y/pA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfNRMKN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D72C4CEF8;
	Sat,  8 Nov 2025 03:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570853;
	bh=ShtdBZw8Sfag9tmAlo1Nbuy3uzpfzP2tPZoA8BFmlQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfNRMKN3bWCBgWAqp/+6MD7LdTWkBzxgo/Me4xUq4U1m/cb8btnAZav4PKPTBy04G
	 MkfsJGda3TfFfXJ+m0gK3h3dCF1WwswDtNKvt1ZpnM2Bx3y8/PHBsXrhsEHEnVhrun
	 yKD0XyZyahKZSNU+e++DgnObHeOmioXl4vGQCAcAINR+SYaCUcbZOTXWkCrrzr90x9
	 2h7t87mN6PuCi5MX7z5RPoqr20PiFj5hQc86ChkWPTvrhYul/rdvOhCerajDU/1hqU
	 isbDGyubeALK5W6BJ+7DaDDE7YNKtdu754txH/p+q0QlKedDgzF1QXA6/9uWNi640I
	 3Luuk4GxXCqFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCB3A40FCA;
	Sat,  8 Nov 2025 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: shrink size of struct
 fixed_phy_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257082561.1232193.1810103224513109568.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:25 +0000
References: <9eca3d7e-fa64-4724-8fdc-f2c1a8f2ae8f@gmail.com>
In-Reply-To: <9eca3d7e-fa64-4724-8fdc-f2c1a8f2ae8f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Nov 2025 23:09:17 +0100 you wrote:
> All three members are effectively of type bool, so make this explicit
> and shrink size of struct fixed_phy_status.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 2 +-
>  include/linux/phy_fixed.h   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: shrink size of struct fixed_phy_status
    https://git.kernel.org/netdev/net-next/c/f73e0f46bbfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




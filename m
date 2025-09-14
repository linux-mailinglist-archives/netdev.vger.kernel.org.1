Return-Path: <netdev+bounces-222874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9EB56BF6
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DE3175524
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B42D0C9A;
	Sun, 14 Sep 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppPs4nXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF91D90C8;
	Sun, 14 Sep 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880011; cv=none; b=bdpuEKf+FVmgm7ueiQDmEf/vCtJdlc0RaaQCxHs4+ejY7+65ZaG1hbX3HBE5ooxaGIf9xz3TwfmZBB88icob5zgg+M4H6ZzAj0F1e3St2BCkzHs7QAQij/7T/yVuJCqoc/Qbu8MaGVpXjF9fuHmHy9MPP1puU1WmfHqScA334KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880011; c=relaxed/simple;
	bh=7oW7Lc9+7R0c/v606n9cnIcp4n6hF7lV/LtR1p8adWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMD5RhSmyLepCv9qGAmTy8d19wQE4r2kXCJfDdEoQkeP/tlt9Rrg87VuEbIHkZ3mQQbWSTOQpzmrOu26ndkP/hUk+jOcM/1oYR/9yQ13P/KqX9q7YxB1b4Vp34E29p4k8GJU7eWKMJQ3uVSBil4bkTK+uqQPBx0BDbeBzcaaetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppPs4nXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7385C4CEF0;
	Sun, 14 Sep 2025 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880010;
	bh=7oW7Lc9+7R0c/v606n9cnIcp4n6hF7lV/LtR1p8adWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ppPs4nXc861jgWHduhMER/0a7ay5e2tXCDNmPxOfGYyBKgHbU1QzuF3rri82MZNr0
	 I90X9ggtEuWVAq1KsRNHDQytbFUGosEgvIpqy6uhs+PXXKtwXkHoBnYn5M2FjSSwLi
	 Jmr4tTeEATrmBo0ZXt4x6e/aqrZe0tCIIG3gpxKBmYFK96ohoDm9EXaH8zl+cn7a0h
	 FvBlpOIwZOOPi3MxLZUMwBPLiFOgtXSxad4YoIhi7S26IwmB1P+kV6uHTqPBjz0WDf
	 7dMkUDvzkbyq4oCGE6LL3XXzJugH7DjW3VyGItxNLtVadmnRI/NYXa821UzuTrhFiv
	 ZqcSXxncuVnwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDB39B167D;
	Sun, 14 Sep 2025 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 1/3] net: phy: introduce
 phy_id_compare_model()
 PHY ID helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788001224.3538646.13476698657931506632.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:00:12 +0000
References: <20250911130840.23569-1-ansuelsmth@gmail.com>
In-Reply-To: <20250911130840.23569-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 15:08:31 +0200 you wrote:
> Similar to phy_id_compare_vendor(), introduce the equivalent
> phy_id_compare_model() helper for the generic PHY ID Model mask.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: introduce phy_id_compare_model() PHY ID helper
    https://git.kernel.org/netdev/net-next/c/ae1c658b33d4
  - [net-next,v2,2/3] net: phy: broadcom: Convert to phy_id_compare_model()
    https://git.kernel.org/netdev/net-next/c/64d1726ba9d3
  - [net-next,v2,3/3] net: phy: broadcom: Convert to PHY_ID_MATCH_MODEL macro
    https://git.kernel.org/netdev/net-next/c/1611666834d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




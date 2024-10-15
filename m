Return-Path: <netdev+bounces-135596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D747399E4E3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145271C25426
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09C1D5ADD;
	Tue, 15 Oct 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry2Uy1Hf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417F18A944;
	Tue, 15 Oct 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990024; cv=none; b=CD14nTrd7zSZW/CFI/bUbVwEQp8wuzfxvBnJLpQbR1cr2JFxbl/Goyh5n0qpF3jxRgchB3d0Z5c/Ib1BF00mMdNRkbFqds3KITTLvA4dXPqPbXj5YlEP3g4bgCx74DL8R0ZkmutboR74ZDtEIXwCJUZY2pQ0ppW+ts9GCp9n5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990024; c=relaxed/simple;
	bh=bGGxOzimidnVoOqV+3Adr/vRqEyTdvN/AtdteletgS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jqM7Zw9zwCdnIg+UBiIdvvVpVBJJPJrTMBRYNrMAb/pyJpUm0SduIEBBsw7EMpDIP0d+hI8vIK8kfiFMfAt17CS+CizBN5p1ow9Y3KxUJX4ka+VuU3FIfXsK+RPgxn3Le7N24Dz98GHoaCTooW+yii2Ow7lSSYGdNAmTVPsZEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry2Uy1Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58EC4CEC6;
	Tue, 15 Oct 2024 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728990024;
	bh=bGGxOzimidnVoOqV+3Adr/vRqEyTdvN/AtdteletgS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ry2Uy1Hff/h1CjesBZz+nLXaoFm7Zft6X1DmbtBGirwgM3Q0cEuIgj9/R6RMVhVA1
	 M5xKa07ZjF0/HEhKqBlJazQyQCE+rpKobkVKokSiKQHEStzCFxJi85/RmhSqXLNKMO
	 ra59hxWTOWbIajFpihClO6hbIXlsova/6IutsrkEMIl/Q0CF7XIY0twS6ggyUcC5xg
	 kf4ZfClHbXxgmKpB95R7G/tZiEcFcoYwg1O3XAmIm5oj2tkT0RAy4xz6F3AbUXJSb/
	 8DH6N/474/y0ne567aJaVTN9Mk/w7C25c1AarndxDKJ1RSeZCy8MFDxuiL/hrNq/Su
	 faFmJlGA3kAQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD363809A8A;
	Tue, 15 Oct 2024 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Enable USXGMII mode
 for J7200 CPSW5G
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899002952.1116703.4106967634840832752.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 11:00:29 +0000
References: <20241010150543.2620448-1-s-vadapalli@ti.com>
In-Reply-To: <20241010150543.2620448-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rogerq@kernel.org, dan.carpenter@linaro.org,
 jpanis@baylibre.com, u.kleine-koenig@baylibre.com, c-vankar@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 20:35:43 +0530 you wrote:
> TI's J7200 SoC supports USXGMII mode. Add USXGMII mode to the
> extra_modes member of the J7200 SoC data.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: am65-cpsw: Enable USXGMII mode for J7200 CPSW5G
    https://git.kernel.org/netdev/net-next/c/97802ffca711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




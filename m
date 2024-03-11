Return-Path: <netdev+bounces-79285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB98789D7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A71F21CC6
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4884F56B70;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FypTckeE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5A56B67
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=X/UR/erpG8Tr4t14NTN87df/fP1PmHyFS9C48SWTjUAdHVGW5dSWh+wL8ed4yi5mAunLderd6A+T0NPL2a9p8zcdXGNWmaig4nCm+0FEnE9T06gZGiN2Rz+tt2vIKcJEpQKqzap22zSNUUyPxwcYdKZjHytpkDFCLPedGX5jS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=s1lQOT3u5rn2PuOeKp19q5Ci17o9WjOASPw/ZA+BotY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MK696/2t3sTvlr+UT9inbrQb+4umsPnvlT89otC5PJQw91rpOQ7RQXwDyANmeDS6pflCMUWW3MwwqaYumQMfp4MlqW0z+IzSp9wv8hOIDKmgtGP8W4mVKAQD/2MfR2wHwRaD1GNiCWgaOKzMpEMYJvZnY1q05UI8wHqORU4GgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FypTckeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7A40C43399;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=s1lQOT3u5rn2PuOeKp19q5Ci17o9WjOASPw/ZA+BotY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FypTckeETw9q3run2KgJpOqukgRObO4gfJwsBSHPUHZysT2iSOpfp71Cz/pOMblJ5
	 TzsS5aPK71QiZyzyhHKwlTpIyyYotb+nPUSOKJPku0AFpwB+ccGn9eWxno4DTgkAYt
	 WMNY6UpqP1Uo4HzoBm+3Y94R/B5VF0xh6VYOn+IEXc3hCWj/YxCkOKTBmy6J1219EJ
	 CoVTNL4Y4bAq8mIQG2QUlzrpXaOFF6k/AKNaHOAvvfHwryW5KBDlMi3+qdB3jp1elA
	 Tgx1o8p9s6pwy1u0VoCrv5HFa2X72tSjVPl29p/Xv63NTs/KJj6VER3bHfmW7v6+Gp
	 PStfEb5gSVFeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB6F2D95057;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: simplify a check in phy_check_link_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143176.14853.7298066122215575687.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
In-Reply-To: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Mar 2024 22:16:12 +0100 you wrote:
> Handling case err == 0 in the other branch allows to simplify the
> code. In addition I assume in "err & phydev->eee_cfg.tx_lpi_enabled"
> it should have been a logical and operator. It works as expected also
> with the bitwise and, but using a bitwise and with a bool value looks
> ugly to me.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: simplify a check in phy_check_link_status
    https://git.kernel.org/netdev/net-next/c/c786459fc827

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




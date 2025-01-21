Return-Path: <netdev+bounces-159891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B9A17545
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8659C3A7EDB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62248EBE;
	Tue, 21 Jan 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTMnZ0EC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B204DDAD
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420004; cv=none; b=brKTSEnSeGuf5PTykjUwtKQWFalsteCrVGWdwLptCAIc0TsY5m1KRQ2vbPHpt2vMxrS8y3TqIfv71L7wFV4h8QF2Zr3ODeynu+zx+boGXCGIUX+4aLEh8W+7S3FUhjKuW4tRdDzVrAUT8nSCfCAEOA9v39qRnRTbmQhV0HohN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420004; c=relaxed/simple;
	bh=B7VL0kUqvlcxbhdchvDU32N5rBhiWviczMnLpMAru0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJMtZGtem8Bulrb0hQitvT86w6HOzT2FvRBxpq8ytKN6h7TZMZoUv6m6g+Lb+0Ww9eqGz609C4Rp5sPZPPWjsR8R6Y+GFjZ4JIoAFNZaGM5RPAzmlNUOpO/M5WhXW1tpbTPilp3N6YtnIZjVFbXF1qGhSW8xIrxcdyd6TcOkL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTMnZ0EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99B8C4CEDD;
	Tue, 21 Jan 2025 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737420003;
	bh=B7VL0kUqvlcxbhdchvDU32N5rBhiWviczMnLpMAru0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WTMnZ0ECfoeAHItRlGCb1AiZn8edukRaOC4VvFGiINKCz+JrDzUdsXOGucj/pgpV4
	 +Iy49prj8YBG6Jl2Acu8N9evc3cKzqGzWE5RV2P+LTItI9NO72ZJQ7C2y8WCJXugyU
	 5COJJqfv2VI3y2pLwyLQS2sMmVX/R41ihvtKLSxkuuWiFZW1Wl+0rLcBKSZXam6HDc
	 ZWm55vasJw2v0DfOknV0DxU2HESMktnboA0z2vD2yDLIcBd4DEffAfiAK93bN2Gq+o
	 8ZT02f6jxwzZBLyMOzwXyqZ8zQUOGXmkrEl6hVkTvgfJ1P0U5Stp8wmo7AgLBq8A8/
	 BF7lShc0UpO1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00F380AA62;
	Tue, 21 Jan 2025 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: fix regression when binding a PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173742002775.3693984.5137194373335494555.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 00:40:27 +0000
References: <E1tZp1a-001V62-DT@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tZp1a-001V62-DT@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jan 2025 10:28:54 +0000 you wrote:
> Some PHYs don't support clause 45 access, and return -EOPNOTSUPP from
> phy_modify_mmd(), which causes phylink_bringup_phy() to fail. Prevent
> this failure by allowing -EOPNOTSUPP to also mean success.
> 
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: fix regression when binding a PHY
    https://git.kernel.org/netdev/net-next/c/b1754a69e7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




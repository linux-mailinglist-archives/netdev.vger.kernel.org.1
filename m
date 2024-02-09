Return-Path: <netdev+bounces-70685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729485000B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16069B295D2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690083D0C0;
	Fri,  9 Feb 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja3ygXnf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CD3BB26
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517827; cv=none; b=OXyUZkxRJADyyHCQJu9Rj/ljlpauev8gkG+kyrWDGTSWosX6fYBIo3yPgD9kBwNfAXPBJmlcCa+OMy34H0uYD95+sohkWGPWN5D1GL27GpkeCv41A8X99rIs7HmepcCPicOjaJwgOuxR+zfovhC52T6oV9NUQtxzktzrpx7f484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517827; c=relaxed/simple;
	bh=HeEOekkpCvoGeYO1DDVCC5xIbLx6+qjFLP2yOn2vJD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQZ05AHymEWRrZ703roiBNKkXgJi11og/q1hbA4B6+K/FlBkTa17N/Ls1snS5zyX6q7d26CunGS+dNh27yFA1qcDw2VUQAbfRZCtPTMYPOvog0x5ORUy/v9EPPxi3sWy2Do8Qrlr4zksBNIK0ITbbsDXfA9A4VwnXrboCoz/1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja3ygXnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6BB2C43390;
	Fri,  9 Feb 2024 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517826;
	bh=HeEOekkpCvoGeYO1DDVCC5xIbLx6+qjFLP2yOn2vJD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ja3ygXnfYlnvVWGmZbszF6Yq2SBwV/DYElz9iU8su6jJMfvexKenF2UbJMhPLJ3Zp
	 e47e/xClRT/cmDks7Uj9nTtSeYU9Q3BiwBYkuGSrJPxH+LswBf/CSlAyTIi1molT2X
	 +jXRX+3sDEeTPHAfK2HM4bUQcC7leIwUvrqg/vLGSyY29UqVddJ59BJLG/IITGWgCV
	 OEPhS/146BYbgzpTObc8J7CYTcy8/ywxATbdRKXYkRI4cGZnZ/yUIJCkTIpFQdWa3M
	 dOhnFcuWe6iqiVXTaNbj/gUdPFep6tDO7YyzgEruQ0+P1AysNhpV9gMR27NQ66GX7G
	 XOeb0aJs5IMuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC7B4C395F1;
	Fri,  9 Feb 2024 22:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: use generic MDIO helpers to
 simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751782670.25096.5675462930502817147.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 22:30:26 +0000
References: <422ae70f-7305-45fd-ab3e-0dd604b9fd6c@gmail.com>
In-Reply-To: <422ae70f-7305-45fd-ab3e-0dd604b9fd6c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Feb 2024 07:59:18 +0100 you wrote:
> Use generic MDIO helpers to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: realtek: use generic MDIO helpers to simplify the code
    https://git.kernel.org/netdev/net-next/c/b63cc73341e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




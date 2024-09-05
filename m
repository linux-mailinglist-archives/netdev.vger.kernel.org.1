Return-Path: <netdev+bounces-125546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E496DA54
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A931F22C34
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9C19925B;
	Thu,  5 Sep 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLdfdZLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E51E481;
	Thu,  5 Sep 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543032; cv=none; b=OsbIjQ85zDJ2UhzTaYu0IS9Jkl+iphJcZYwDyS1HQBbldX3iu5Ssyy2N+//y1INR5p3tNJHesGs46/CbQCGBbWOnOeHSSw2AGkRsXZpl6xmRGRRbv1mukrJwNO/+WWdoJQR5cqf9SXxGBBevUxyzZLzkETOgy6oBeAUEYuk/LjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543032; c=relaxed/simple;
	bh=qnI0RTQ32PLAI3H8EH80PvE3dSr+Gbr7/jsmx+aPgfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPx1AXXwaovawB3Aqp50Vu8pKtfkLZRaocgA4uBE3wfYAS69XoWhvLvGd7CRpfZLVA7C+ZSKjq7TMd+rl+Geblq/jZs1tYaucakrLSoD4Hp9RD0cyAFwef5MNKk3IFGR2JJRV8bKTAUdDMF2scdxkLzteB5YkEfV3WwP7yS/HIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLdfdZLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF29C4CEC3;
	Thu,  5 Sep 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725543031;
	bh=qnI0RTQ32PLAI3H8EH80PvE3dSr+Gbr7/jsmx+aPgfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLdfdZLkM7TmNBUvM/K9dr86BLD+ftkw8WRYNz8N93rzXbR3mb9xCLwIjjfABHxgB
	 2lvRiZEKEa/rqp+uUzE5kWrv9ncg6Nvf9YP/Z8T8P+7TGI1l5S0GAZ/4OrXsmYo/Gy
	 ujXqCFWN32qSCg07OwQ6lHhEnuiaCyX3KUFwacnGpZ3qV/+hJk9rVSZHyr/h8InJ+K
	 qcfqTpStFG04+hiaCnrE8vEHVZTaSDkwdHQBQeOZHj7GF0OofGBLdCpIDQ54L7t8cf
	 lBHd7tskxVn3/Dz9EVD7mhq1+FYDipdPEzwnoKR8hIsqfAB2nqzGCPpkAi67tfXKGM
	 IPWMea0Axp4Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F03806651;
	Thu,  5 Sep 2024 13:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] Add driver for Motorcomm yt8821 2.5G ethernet
 phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172554303229.1691038.7744595102993244015.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 13:30:32 +0000
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
In-Reply-To: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Sep 2024 01:35:24 -0700 you wrote:
> yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
> default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
> as phy speed mask.
> 
> Be compatible to yt8821, reform phy speed mask and phy speed macro.
> 
> Based on update above, add yt8821 2.5G phy driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: phy: Optimize phy speed mask to be compatible to yt8821
    https://git.kernel.org/netdev/net-next/c/8d878c87b5c4
  - [net-next,v5,2/2] net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy
    https://git.kernel.org/netdev/net-next/c/b671105b88c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-115855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F9948177
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5121F238CF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6815F3EC;
	Mon,  5 Aug 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMkM1bnG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC015D5B3;
	Mon,  5 Aug 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881787; cv=none; b=mPSGx2M2LxRcrx3piIKV643SDJzmBxteDmwoF4D7Iww2itn1CoRTdvPJ6+Khu57EMIMkPeoTmem5FK+eF6TSZgqVMhnmwncHKWuNtjf/eH2zPxL8XTsKRtJ+HPRzP71+5V+6E8VGnMSMftXt8cL7ttEdhc/WVYvxc08xQC8dMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881787; c=relaxed/simple;
	bh=jlyLYfj4GAMVsCrFhoJ2/RK/IggMnsNIST3+I0SK7Ko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nH8j3D8sSp1zg2u2vj9WoGw9v832G/16EsBbiNHqQkyZYNHH26M2yEkGD6fxycjXLha3rkqFIMAgKD6bUYI1HgLy3LdAQk656B3vfl7DJSHS7TmsCazAy/6jh7A8IKvJJzYKuZsUVE3N5h7KlueeORB+a6Jlu8EuT/xrGtisT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMkM1bnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72030C4AF0B;
	Mon,  5 Aug 2024 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722881786;
	bh=jlyLYfj4GAMVsCrFhoJ2/RK/IggMnsNIST3+I0SK7Ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMkM1bnGsbjYXjnq0mtWAGu18sPyQUL6+9cUxB1o84wI3OSoNM+AHOiqYWrhbwb34
	 E8GYk/Z7bAhdJYlbWsqq7OkXZv+NAnWTat3v6NPjVlMHrs3qvE19L3tS5OYt9Qy2xY
	 eBHyZPBEfipmRARZSgn54gZqHVSLVqKDAvYoHJ5ZiZ9af1IJWn7ZEucOB4NPvtdoiu
	 KZJ8WBZI7KuHj1MNQfrtAmeXQSjyXpYpFsXMOcHgOcdYj4EYX7ZgEVfn/Cyu+SPSH6
	 T/+yWgTzLVPgHqEIoUxsoKNomhVLCs02Aq9uq18GywvM8LaEI3XJepiHPdwVgNprUf
	 YuLkw2w6iP40Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6593DC43337;
	Mon,  5 Aug 2024 18:16:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: vitesse: implement downshift in vsc73xx
 phys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172288178641.30956.14146151331299359240.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 18:16:26 +0000
References: <20240802051609.637406-1-paweldembicki@gmail.com>
In-Reply-To: <20240802051609.637406-1-paweldembicki@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Aug 2024 07:16:09 +0200 you wrote:
> This commit implements downshift feature in vsc73xx family phys.
> 
> By default downshift was enabled with maximum tries.
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: vitesse: implement downshift in vsc73xx phys
    https://git.kernel.org/netdev/net-next/c/ac4c59390a87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




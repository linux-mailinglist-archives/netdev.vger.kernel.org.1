Return-Path: <netdev+bounces-146074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FC9D1E83
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF91F21BEE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760938FA3;
	Tue, 19 Nov 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZDM5pCB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DC1A28C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985221; cv=none; b=sF3b3YU/Sa5bBw52rpSslXHVhQhS4Xd4L8KL/BFkeBa6oBgGyUSU+RGg0i4F+8DmjyyPhk+3I5ZgBnhqbcL56M/52V6mytOTKeudUo0ep6zQX9JVJ5ImsjfJ8V6zvOKUCiNrnxB2WL1CUTL/ywQdreOGEjxqOTORZmZtSr2LRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985221; c=relaxed/simple;
	bh=kiBlZcw6NCcJrhJvTdzOAX2lnaB6HmVRbF4oRLXrDtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/CQzUy3eBnuageWQI3eoddHEoL8jH+E8AMGF24YutAmmJKEsQhh/dZZBqbkDzsLL6Qkekc0c0QxtEi8BBdh6fIn0xL+54XwyL1P6UjSf7P2xB7GAxr/8PJp5CZMp1PJH5mUHKfo97ZWZ8ETMf7vdi7wLFacIkRa1bLqgTTnopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZDM5pCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4355C4CECC;
	Tue, 19 Nov 2024 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985219;
	bh=kiBlZcw6NCcJrhJvTdzOAX2lnaB6HmVRbF4oRLXrDtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZDM5pCBAYZp4hwHael9yJARGEwvAwW1+wc7HB024XAsLoC41oseJnLzdWMXr0cSn
	 NWrv3OxqookjndER7lipXpw6KEy4AEfUd2NttIzOFBsbhAAXcMxut1HIb8jtipYu6A
	 MD2dCmfdxJJh6MBd9mtZyViV4hS94In45MDgixW7Zfen5VgoEFTXolvBkrlaAn+V8n
	 lkrjx9qTxF3IXG4ggIOKTzxji3mUc0G8aebFxBcdGZ0DJNErEn0aFeoO29KUg1kMMo
	 ZUiEf1r7LH8Ezae6T/6733izViOa407OXOtibU0Cg94h9o+RfeJb4qfzg9r3ykbzCz
	 lyE5A5eJVsm5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712523809A80;
	Tue, 19 Nov 2024 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix null pointer to pcs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198523127.84991.8958952663015382633.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:31 +0000
References: <20241115073508.1130046-1-jiawenwu@trustnetic.com>
In-Reply-To: <20241115073508.1130046-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.co,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 15:35:08 +0800 you wrote:
> For 1000BASE-X or SGMII interface mode, the PCS also need to be selected.
> Only return null pointer when there is a copper NIC with external PHY.
> 
> Fixes: 02b2a6f91b90 ("net: txgbe: support copper NIC with external PHY")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: txgbe: fix null pointer to pcs
    https://git.kernel.org/netdev/net/c/2160428bcb20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-134722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8099AECF
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0936FB22F14
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2E1D4336;
	Fri, 11 Oct 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJWYbLKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44F1D14E0;
	Fri, 11 Oct 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687034; cv=none; b=MzdMWL8PTaN5GVK6bCI3KwEkWvRDjjTQGQftGv+Co8WFb1/8vHk8uZCbVr/hgeNVoajRL0y7garPuTEWG6RJxe+nn56ncj8KHZo0lTMDeRCAgaK+6mjB/ClZWkfRHMtTw6LX30gaLg6nio7MY43ESUJo6oxX8H2wVFmj7TXYUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687034; c=relaxed/simple;
	bh=a6WfMFHe39QfPqwyvI0diRdtokqB1aop1Y+cQV9AIVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/Xx0ocQp3jC62djQtFnsqB1P76sqGwjEL4E6bDHkAt8x+cmzLAWxUnWCUVxMyrUNzXN1iL0Akh4hzPb1cCEHpHaLOfGh9o9lHzorjegBgvB00R+IcV+hCWUJ3i9CXLuTgHzzA9Lc7VeF/tvh9PAOd13KVpvLImdRRjWRJH1O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJWYbLKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7FC4CEC3;
	Fri, 11 Oct 2024 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687033;
	bh=a6WfMFHe39QfPqwyvI0diRdtokqB1aop1Y+cQV9AIVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJWYbLKQEkHw2R27HukYvUEF0lA/6F4zhfglyNe/G86NVhQ13ENswUmKVdrWqEFP2
	 U6gHm9rs8rBBKe22kvBMAMuMDPoQgT4Gyn3sv2y9ipOy1HoaeJYATZyyILUD/ZnYgU
	 +XsWOA7aISpKY/iUzxCTUkOQ8LV8sTV9CNr9PmM4HLvwTUMBRA74pmbxQj1NRezYKm
	 EPBXJP6u8Yi+AZC9sYBZalgM2irBD/j9SMwPDCeNBP04fPfhltsqAwp+itXeZhO0qd
	 +/MhJ3nipnUAxbaNoPnrv+jEH0FoyiH+d58q0x3Wz51Qc0XLBjb+hPae1TUkgC0Uch
	 v1w1hUqo84jDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDB38363CB;
	Fri, 11 Oct 2024 22:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v0] net: dsa: mv88e6xxx: Fix uninitialised err value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868703824.3018281.16984336410969648159.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:38 +0000
References: <20241009212319.1045176-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20241009212319.1045176-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 10:23:19 +1300 you wrote:
> The err value in mv88e6xxx_region_atu_snapshot is now potentially
> uninitialised on return. Initialise err as 0.
> 
> Fixes: ada5c3229b32 ("net: dsa: mv88e6xxx: Add FID map cache")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
>  drivers/net/dsa/mv88e6xxx/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v0] net: dsa: mv88e6xxx: Fix uninitialised err value
    https://git.kernel.org/netdev/net-next/c/5e7e69baaded

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




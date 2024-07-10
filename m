Return-Path: <netdev+bounces-110538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BD92CF17
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7297B2754F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898E193078;
	Wed, 10 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpmCpuCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F775193075;
	Wed, 10 Jul 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606832; cv=none; b=WrMhJBo/IdLY3UdqVJaAzkEnNFxvatZ/pdALoIHhoQZ06FzowgaCYtVtq0jKzHvUj8T7PauDKaQ0Bn0OwxWghpOPS8UPAT2KVjWrMxwlJgTGDul+FCUHdGdH4uO5fIjo5En9a86oR4I/X5uvqwrKgttLTFGlzOhICYxAAa+SPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606832; c=relaxed/simple;
	bh=o/IfiJv7puT5cZkudxD3XYlYS7TH9XoYK3Fl28JNeBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E6UE69N06TRhuyqFHMS4H2Yz23NpVq3SkL/x+DdSi9KugpVS1xY7Cr3rbrtXsXrFtmfjg+xtZpRS2vyO7htfObD5kMeFLkSw6BAmAYFK13pGHO/IhDSxNjM1i1t+K2pYQfZt4LZtjmnYbhP54p/Y8GA3uVYggcAJvF588ehg+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpmCpuCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C66CFC32781;
	Wed, 10 Jul 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606831;
	bh=o/IfiJv7puT5cZkudxD3XYlYS7TH9XoYK3Fl28JNeBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TpmCpuCK10qN6Qa27fwCO/0Qz0jCpfwyW6dlCwGyYg8IfGWftDDrK5+8NWH+zLJOh
	 UDHzYT5EkKusNmd2A5oyGgYVvO17nHJLL06J980cLXsA0qKIns2sQrJ6bRAJ9IUL2A
	 nh0IfpSBpnpCwCtZxMOeYb23X456tPj1bkRMdrNjCSPFD0CZkm4UPAdZlm3gnZlFmq
	 /d02jUMQvnbPuNrgafAvlGYNXuvXs2nOrdoSXNAoFVGCmFJaV3JVTMkWfZ+K/zq0cx
	 wMggNv3j/0XQH7v+46FexmfdItljg4dlkHPYA142J72Y2bTs8eiGvMx2zs8y+tqKYz
	 L2/jL2srqxOIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B357EC4332D;
	Wed, 10 Jul 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v3 0/4] net: phy: aquantia: enable support for
 aqr115c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172060683172.25112.1657295048537359396.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 10:20:31 +0000
References: <20240708075023.14893-1-brgl@bgdev.pl>
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  8 Jul 2024 09:50:19 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Resending rebased on top of current net-next.
> 
> This series addesses two issues with the aqr115c PHY on Qualcomm
> sa8775p-ride-r3 board and adds support for this PHY to the aquantia driver.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v3,1/4] net: phy: aquantia: rename and export aqr107_wait_reset_complete()
    https://git.kernel.org/netdev/net-next/c/663117327a39
  - [RESEND,net-next,v3,2/4] net: phy: aquantia: wait for FW reset before checking the vendor ID
    https://git.kernel.org/netdev/net-next/c/ad649a1fac37
  - [RESEND,net-next,v3,3/4] net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values
    https://git.kernel.org/netdev/net-next/c/708405f3e56e
  - [RESEND,net-next,v3,4/4] net: phy: aquantia: add support for aqr115c
    https://git.kernel.org/netdev/net-next/c/0ebc581f8a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




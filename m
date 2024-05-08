Return-Path: <netdev+bounces-94514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F68BFBD0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23271F22E3F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64AC81AB2;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJO+cbNj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245D4C61F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167227; cv=none; b=PtWMzWZSaa0yG7B5rtllVVFARdx6fyT5KfjwL6X7VMCSmMNiO4Bviq7LTAE0clEKOImZVKV8iAeRPwGBDfZmVLj0bxglOovgWO4jc8qiHH/Hv9PGOBaK3XmqCeZh/KHuVEURugrinWBxI0Kl9CBQ5GV7RctMD98A8yNKhY3f1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167227; c=relaxed/simple;
	bh=O7Ep99QG2xfn1wmTrpc2PYDIm0JVaVhz9JSYDlR35rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WgGGZfLtFL/zHIyNkyJcxmdYIb7b/BJ5+k5CiIzv9smTAhxwARaRCciePMlrGpwOe7DG6IO/X3viIaanM2LoQ+5quYADuOfrPfRQ3EQ9W9z315c7r5wKPfljv+DExZoJ2TPeE5wfK7s1+Zj04GLFcdLMKp7d1sdlsyDB7Scr8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJO+cbNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F7A1C4AF17;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167227;
	bh=O7Ep99QG2xfn1wmTrpc2PYDIm0JVaVhz9JSYDlR35rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJO+cbNjNVykUz6liA5pJoNot3qjpkRH/XXCVk5En09HRxQB+//n53xy+kqbv2laa
	 5m7fs/RLICCaO32vbU8ST8z9ttS9nCUh//qFDEdTd+C5O7sN+w+3JiXo3IOzdO3n5W
	 5MQvnbCMMtH7RUqOj6rUdivDGpf3cgHHCcGWIxdylUI9w57dVNt/XnVwEc4BrnY0G3
	 ozD1TJAmyng167NECS0luY1WXccHHPcMEdemFDWxYuXHIbzSBynn0PU+r5nkQap4WQ
	 OH7Ru9re224gSG+Z4aJbSHpLUa86UAns81LxkeOgWUVL7lHgzFUyKa6zwdpdpkSXTZ
	 I9WCfMkgwAO0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EB5DC3275D;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] appletalk: Improve handling of broadcast packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516722731.3007.17316518084258740834.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:20:27 +0000
References: <20240505185456.214677-1-doug@schmorgal.com>
In-Reply-To: <20240505185456.214677-1-doug@schmorgal.com>
To: Doug Brown <doug@schmorgal.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vincent.ldev@duvert.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  5 May 2024 11:54:57 -0700 you wrote:
> From: Vincent Duvert <vincent.ldev@duvert.net>
> 
> When a broadcast AppleTalk packet is received, prefer queuing it on the
> socket whose address matches the address of the interface that received
> the packet (and is listening on the correct port). Userspace
> applications that handle such packets will usually send a response on
> the same socket that received the packet; this fix allows the response
> to be sent on the correct interface.
> 
> [...]

Here is the summary with links:
  - [net] appletalk: Improve handling of broadcast packets
    https://git.kernel.org/netdev/net/c/2e82a58d6c07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




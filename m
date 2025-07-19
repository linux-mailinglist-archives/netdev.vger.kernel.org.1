Return-Path: <netdev+bounces-208283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65693B0ACCF
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD185A1411
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6B44C94;
	Sat, 19 Jul 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRM53Wy5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E53BB48;
	Sat, 19 Jul 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884987; cv=none; b=jdOY9h6qqAf/F2hMrftAN1cncMALlKjmlz6ND+ail5kktUZ9SejCJwGRcHJDsoAgYGQ+Gpk+RaiWLf4sfiPfE6tFVbNiEcHzMAdjeJKkv5AfCEAQ5U2sh3ICMFiVD3gAWgeo0g2pFvU1sWRdmYAwIYVZhTLVG1R+ECS9omnbPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884987; c=relaxed/simple;
	bh=i2TQOPaND+67R0cRowE9uCFFBY1qMBcvE3cUgWagcHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptvk38g+3pg0c3fGPnohUybLW/gIW76Dy+jN3l7rGIOAH01U1XCiAaO1QDqMlSjLLTqYe7bB5vvOgAofuSRjSBydRRFRUGkkN+4EUymQpKAJKOS25z52pzvHJHD+hyBhqk4pks70PGlGBEXCG3O8bFF6PazVr27O+uNv0g92dGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRM53Wy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B7C4CEF7;
	Sat, 19 Jul 2025 00:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884986;
	bh=i2TQOPaND+67R0cRowE9uCFFBY1qMBcvE3cUgWagcHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nRM53Wy5SDFc2fDatUbW08whvgOzD0pFhMKfKGsJW41LXTDpgqkZS8hZdOSZEr87I
	 yVFJixKVNMq16B+m+mEJB3Sltux+EEvKfR1UMptaHcvzCMnnx/nOqpRQPLoS2bYEmd
	 ABqR/+o7DjK7aOIVm2bPr+fqQXrhLeOU4WneglP1o9lOIPjZDEkDSMKbL/P94XiSXc
	 2oyUZaSHUgttr6FoCHlvZ1S2vK0k/tV/Fv0LRVn5eEWi8VhWgLgpDZ5Q/NlgyMa/Gc
	 S34WVG9Y2sv6PaSnj+d/IhilhwpEStNd5J53JsrmjBW2NLP4azqDHykXrBSrn8JC4S
	 XXZBfEi3vVRww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD5383BA3C;
	Sat, 19 Jul 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288500601.2835800.2292924142843989751.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:30:06 +0000
References: <20250717094220.546388-1-h-mittal1@ti.com>
In-Reply-To: <20250717094220.546388-1-h-mittal1@ti.com>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, danishanwar@ti.com, m-malladi@ti.com,
 pratheesh@ti.com, prajith@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 15:12:20 +0530 you wrote:
> Fixes overlapping buffer allocation for ICSSG peripheral
> used for storing packets to be received/transmitted.
> There are 3 buffers:
> 1. Buffer for Locally Injected Packets
> 2. Buffer for Forwarding Packets
> 3. Buffer for Host Egress Packets
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix buffer allocation for ICSSG
    https://git.kernel.org/netdev/net/c/6e86fb73de0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




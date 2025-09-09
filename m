Return-Path: <netdev+bounces-221028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B25B49E9B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7053A4C9A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516F1E32D3;
	Tue,  9 Sep 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMRc7+AL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4811A9FA3;
	Tue,  9 Sep 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380802; cv=none; b=JsInkpLpGdX8NpfokqNACiEM+KHSVRtS/ExzM/yQ2Q53M2PxQ03oGOrTRp5ySARy9lWpNo0HSJzexeRmCRGOc14dtAYDZCWkzgkVummPRr6grKJdt7/Pil+9h1Rie47rjNTdqDR98eg4fEdWifLwB3QllW00fV+QiX9PBXD0wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380802; c=relaxed/simple;
	bh=B5O248oZB9tnM0qoMK3u1ua/t6R75re6mp3UbU/gOb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDq2ZdcXvgaqQji1wABPPslKq9vNsrc+N3kGV8PEvnEXFEAGMfCsNbssR0/W6fIdSC6+qNt1XXQ2Ix30lmS7Q2AnTdqFQL0OWPuCuLWILlWYdFRwZ2nl6imFygJiPbKZqpRvjqZWL3qJ0M0v11lUEH7bn9Ck6P+dke3nLeSBCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMRc7+AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C603BC4CEF1;
	Tue,  9 Sep 2025 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757380801;
	bh=B5O248oZB9tnM0qoMK3u1ua/t6R75re6mp3UbU/gOb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMRc7+ALe+Ys69KbXWDoG7+dGKCwuFqG7XT5UvzpCU1QTqDz3j5cq2F46vVBhCEE2
	 cnQzmvkDOpdS9NZnoZzoCqsrV1+PyD71q0wjBl8Txc9GGzuKs4YIDH9BPIzLw9L07q
	 E6mV+Tfi+ogpB96rms5xj6267B13cOEatbYHjt6vXfUcHouxBX0VQ8eczOrTMU6+7P
	 i0ixlJ0T7ZtHUoJgHE6Bbsaqe0Z/z19dFispfO51GKrNCWpw9P+1diosMJiQS5ZPMn
	 5e9KhAGstx5PwxN0G1AMlcWvSV9Htl2qKBFaA3MOQJyFWDK63spnUPFr03Hf/f92mH
	 67c594X6ubiCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C83383BF69;
	Tue,  9 Sep 2025 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: b53: fix ageing time for BCM53101
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738080525.105892.3765020910562024139.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:20:05 +0000
References: <20250905124507.59186-1-jonas.gorski@gmail.com>
In-Reply-To: <20250905124507.59186-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 14:45:07 +0200 you wrote:
> For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> the ageing time register, but kept the field width the same [1]. Due to
> this, the actual ageing time was always half of what was configured.
> 
> Fix this by adapting the limits and value calculation for BCM53101.
> 
> So far it looks like this is the only chip with the increased tick
> speed:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: b53: fix ageing time for BCM53101
    https://git.kernel.org/netdev/net/c/674b34c4c770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




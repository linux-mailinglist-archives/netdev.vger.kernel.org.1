Return-Path: <netdev+bounces-129494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA19841F3
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAC91F23B1A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5D156C69;
	Tue, 24 Sep 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqXtkitb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B384A50
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169739; cv=none; b=UDHZyXYIKhSckMyXXgkdIiCGhx79Sqp+AAlepRBH1escotg1g02B6GOeOaVXhVeRV6FdQKTV4Tri9ofuteqcP0AtJV3OduiNjDquPHR2bhyYBCIhH0D+WWXFwlpQOzlBKv2KAI1So0ke5fu3wGh4NMCQ3Tw80/V3fcs7hZLoOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169739; c=relaxed/simple;
	bh=/3P/1t7QqQRXXX3HIMSHbizyvQtPap2taSL9G/4lcEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPHEIGQGtf1KI7Gf3qTC9sBiMxHUwS2ZFKfULQjQkoC3nyuwoCoklr7dhPr+X1cqRFwG3/jUP06rgBuBaidYuUnMcCqgksBdjR3FgrvZxm3+V4Z2ol6ARjsKn597QcTOlqEw5JCEfW7nS19/Sfqgwr/NBPhoFFcwmEyTkwJEwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqXtkitb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6790CC4CEC5;
	Tue, 24 Sep 2024 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169739;
	bh=/3P/1t7QqQRXXX3HIMSHbizyvQtPap2taSL9G/4lcEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cqXtkitbl1DJK/I/cD9njJhQsBuc22Dz3u6/h+63JzhbQzl1vO0Lo/vUL2PXfYaWw
	 k9QvCCtLx2fglRDa22zmq4+Mbt3a2PtTzP6qTPnBiQDXpz8OPzkPL8QdFQh8TRIfKr
	 DTgfBj099ij9KYz2OhNoBv3HMj9lg1QH2Gqr2ejfwe7ZEItbb06IL9fF1xLQ4rBQTv
	 0UoTyTTQ10qcWWXHqZTe2x9zaTuu2ZJs7nk/MOtwAu5RjwsQroqzfB14OPoYu+yXqi
	 Egco31PRFrQZUBOV35FBbFOKZES2BUAPwYHqR9Qzcar56VauP647AwgQ257skseupk
	 jnbnEdKVro/iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5223806655;
	Tue, 24 Sep 2024 09:22:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: add tally counter fields added with RTL8125
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172716974148.3956294.1914952920883473326.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 09:22:21 +0000
References: <741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com>
In-Reply-To: <741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Sep 2024 23:04:46 +0200 you wrote:
> RTL8125 added fields to the tally counter, what may result in the chip
> dma'ing these new fields to unallocated memory. Therefore make sure
> that the allocated memory area is big enough to hold all of the
> tally counter values, even if we use only parts of it.
> 
> Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: add tally counter fields added with RTL8125
    https://git.kernel.org/netdev/net/c/ced8e8b8f40a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




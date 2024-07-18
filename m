Return-Path: <netdev+bounces-112063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020D934C93
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4378282BB0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C812D745;
	Thu, 18 Jul 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnDc+izu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B8558BA
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302235; cv=none; b=j7cmqbBEmGIaqQhep8enlP6yuZqgUzIgDe5i1fztftS2eKrOUF+lGdN8DH1tQcfHCLrHGjzWi9X0ibcpZBP04wTdFbcmwiAY8qnz3+Bg4Q8pJTQbJBZ9eM09m/jxFdPWl+tSUlZMd/m/nsSrUtJxhPN0IosMFOpR+sIvbyWa3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302235; c=relaxed/simple;
	bh=hTxmBwsTkNod/1c5wiPosrVLJt/jWlquXMpbD65BqMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T95eekMPvEfBTIw5nXWdiLb5Knai93hE/Qf++UX+s3b4+LKA9/wTpt2ZJ1AF1UJYuexRaufIo8A8R0ruvy2m05aK4JAmL/ipOcqRfBEsZ9CQk0irwg50AhuqkRov9OhTtX695ohIOf3guW+De9K9UPgR8jH81RFBApDdcHsVe7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnDc+izu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 419C2C4AF0B;
	Thu, 18 Jul 2024 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721302235;
	bh=hTxmBwsTkNod/1c5wiPosrVLJt/jWlquXMpbD65BqMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnDc+izu96/7HPCoqDZfqCFpKwiMN+3naLg+hPdVd7KAg4Y+hLE7ngK2jilHjmftB
	 VwN+CbjzmER6Jc2Tb/kmb2SvWdv7l78lRiE3RkItCGNRKZTyEUNSDRXxtW6XZKKPVg
	 cPeYqj8GOc3nhPevg5cnK2daW9z+Pv3mzXGTCMycFJc4F4QuTUqtmcbt3osAG7ccMk
	 wfe9B282jsoKhV+CxCMvLwhbe4Bwaf1lSNwGez3QNaDewzLW2AI178HeTb9m3NxakQ
	 tetavWIqd2VbNtWcWnFj7KN2vvDzDbt4XzoWsIXvEJzGxhKZG3VobsD09HXDQfOtx/
	 vfEeGafIc+guA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DA23C43613;
	Thu, 18 Jul 2024 11:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: dsa: Fix chip-wide frame size config in some
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172130223518.357.17701746167233713333.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 11:30:35 +0000
References: <20240717090820.894234-1-martin@strongswan.org>
In-Reply-To: <20240717090820.894234-1-martin@strongswan.org>
To: Martin Willi <martin@strongswan.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 chris.packham@alliedtelesis.co.nz, murali.policharla@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Jul 2024 11:08:18 +0200 you wrote:
> Some DSA chips support a chip-wide frame size configurations, only. Some
> drivers adjust that chip-wide setting for user port changes, overriding
> the frame size requirements on the CPU port that includes tagger overhead.
> 
> Fix the mv88e6xxx and b53 drivers and align them to the behavior of other
> drivers.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
    https://git.kernel.org/netdev/net/c/66b6095c264e
  - [net,v2,2/2] net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports
    https://git.kernel.org/netdev/net/c/c5118072e228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




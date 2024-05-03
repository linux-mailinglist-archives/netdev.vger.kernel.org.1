Return-Path: <netdev+bounces-93396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF98BB7F0
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BC91C23392
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C5839F8;
	Fri,  3 May 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kasr+Gx+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4482D64
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777829; cv=none; b=pwpppGY4qZ1MByL/0LCO/yOpLukzGi+14dQqFNH/RQt09rB+oYiWldZC7endrU9xPcvRs8pSXSX/1Ewxc6kExQSI/4T1fzP7Hf0Bk4Qxaa5opVhBg4ZJNvX3QEeQNfDIWMkStVMKCLxzphb7yJoLQ5lwFdUB0om/R8cC9UIySIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777829; c=relaxed/simple;
	bh=d9HZO3quqcCtJIaQ3/OnUXvGGLmjO1Nn50+CSuLSshc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ou2cF7c/vnrKtPKxc5UmMjFpktLxn7SejpFziLI3vMAzyCq35nMu+QlukxRgG/6veIHGeRII5PD80Y4aT3BiN8HyWTLhpnrV9mEfZDdBBZAibxe6EeOn+FbZWZqdqGda8U6C7Ft72ocmEbj688XV0NROjk/rYCpVKTUy3m3dmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kasr+Gx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E04BC4AF1A;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714777829;
	bh=d9HZO3quqcCtJIaQ3/OnUXvGGLmjO1Nn50+CSuLSshc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kasr+Gx+Xmpd12p11EarbsOWV3gniTwPNO6lj++KCyMn5JMYRncFC61qJ9jLQ02ey
	 aGtl2NK81TPSNs9cG8jEE8xnLrPRH894R8RWu6ePSQox6EekCca1Pq87ne+Pkxn5Vj
	 5nJgkTb9qXmENaq0AsR5gLI0MDVXzkKX7u503DOCGosmKfYO/GAjlEo4rJ8CP3T+r3
	 b1H8H6oB3x+4hmPPHWftcdeLly+V7myIRZiavjcoKWECQlLwINDAvAhRQDSO6tI1LF
	 TI8vr2kMVPYjG4gJUH0VMRsJS2p8kwcYIzQEXUv3dv75Y9MML68IY2WPuDvWBLliBa
	 5dfqiwyy8i4AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EB2BC43339;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update cxgb4 and cxgb3 network drivers
 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477782945.11856.13736297886605130615.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 23:10:29 +0000
References: <20240502184209.2723379-1-bharat@chelsio.com>
In-Reply-To: <20240502184209.2723379-1-bharat@chelsio.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 14:42:09 -0400 you wrote:
> Add myself(Bharat) as maintainer for cxgb4 and cxgb3 network drivers.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: update cxgb4 and cxgb3 network drivers maintainer
    https://git.kernel.org/netdev/net/c/fa870b45b08a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




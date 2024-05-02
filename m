Return-Path: <netdev+bounces-92979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58428B97BD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73D0B241EE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D348054BE8;
	Thu,  2 May 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PimJnKR1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74C54735
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642231; cv=none; b=bsDEFMJW7m3g0GJqwTTyvjLbPnPU8HrtK9bTusIOhO4ArYhD69DNhnxjUwtBvUHs4nB+UGpClPnEvCACgr61OpUL28zbw5XBM1MtJCg+5aM5t3mql0VXxthvSMa3GRm378oDH3qHSqSeBE1zz/JHPYtnfveeE1t9J5g8dGwGw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642231; c=relaxed/simple;
	bh=I1w+HH4l75gh4ceTL+g+BsTjDjOxupFBFhKvSNPGvKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UcPCemOVHiTfM53jJ9F6jQyQ32uLbj5MBqcjjAP0bOxi9r3/Xc2lCdnQBGxSWKugkyo2Di8d47e/FcBvyNG6Ahrax2y5t4bvw2c6iWxMeJxsuzAN9nzuFFO4cFLQyCws0Ve7fq+2c7pi2LzxvAdbxyJaKAe+Y6AeCqCzrOGfpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PimJnKR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CDABC4AF19;
	Thu,  2 May 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642230;
	bh=I1w+HH4l75gh4ceTL+g+BsTjDjOxupFBFhKvSNPGvKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PimJnKR19VuT20UG4gLIfafHE0EgjefY9VSCTtcsyeQrSDd7m6QTsQzhNix16oIip
	 lRaXtM/hA7e5QPAOKAad2QBm/P23fG8SsVrKjRnQzSG69/ijLEphD55ZhWvhgJ2tK0
	 oLdwHn7ZfXJV2u+K4Rw57tqxtr3W2FcOV9fw14H5ZDxEqOloI0zlgnyN7eaBLyttYM
	 xXV5dprUKoYdDS+Bo1zXaW4hHHl2j83cz8EnQByEtPvhC3KWssl2T/2ehnYLwAGNVS
	 vWSal187kAgp2CtLBWQEmCO4H3ypZGhKS3EiUozyaP/x3nU2uFLNdQSVJx0yElaqrp
	 OaBM21UvgO95w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46DB3C43335;
	Thu,  2 May 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: mark MYRICOM MYRI-10G as Orphan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171464223028.21469.5285688084791446333.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 09:30:30 +0000
References: <20240430233532.1356982-1-kuba@kernel.org>
In-Reply-To: <20240430233532.1356982-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, christopher.lee@cspi.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 16:35:32 -0700 you wrote:
> Chris's email address bounces and lore hasn't seen an email
> from anyone with his name for almost a decade.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: mark MYRICOM MYRI-10G as Orphan
    https://git.kernel.org/netdev/net/c/78cfe547607a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




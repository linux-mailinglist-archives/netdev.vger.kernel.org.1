Return-Path: <netdev+bounces-103490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F590850A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D26DB26E5F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281814884C;
	Fri, 14 Jun 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXy39Se"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94759146D60;
	Fri, 14 Jun 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350232; cv=none; b=Fb1uOi1tDIp0H6Z6OsrsdDssUr5KzUel/Ur1eu8H2D1WdveAOFAGD6YlFiHhR7WIpqza7dav2MNtOlLcZl9+vi9eFCVGJ2dg7g0egZPpaA1X3lvsqpsOMJd6tNIKbwEld8JqV+j2W971bd8/4BMZtQlYnRoUcYGMM/qt2qsgB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350232; c=relaxed/simple;
	bh=TxvKCz9vYX2Gz7wVXaMpV3Fiju3TFcVLbdB/7Iu8Rhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aZ/XX6nStuskMS/1SWsnfcKAHUQ0R7fmK15bjD47EZOQdviaSgcETLn2ZWDmTNnfPT1OfeUQ50DzdiP9lWOKlFBG+YrJBOLfPA32YVUlRfjauaLtKEWEbaSzyZOB126pnTQjMRM+0/WA4n9y7FBeqE8u0/Zv3ghuApnpK185l/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkXy39Se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C532BC4AF1D;
	Fri, 14 Jun 2024 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718350231;
	bh=TxvKCz9vYX2Gz7wVXaMpV3Fiju3TFcVLbdB/7Iu8Rhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkXy39Sevx6sw7/Ycl7Emq+R/LM9HWBTb2hFsbneN/bu7LYuk7jSLO5Tv8Frp5avM
	 znk0yYJaIPBV6xMf1e+2uomYLZijlBOHjFvTPuyth3QQ6qZXZVp7bW7pTTaDakt/8D
	 N1RrwLBqtgXImbbfX0GAU1FKT1J65k7/g8EY4s+TNqV/2Rnxo3Or/mZDc+TlKsdWnZ
	 9UAVPj5QLE9AwHcBttaehT0t0zoJ/wMsaIglY/dDTsG6r5hccOg+gpSdLiGn3P6UvP
	 mhy4VlBVbdUSVk+6DAy9nva413ANRu88V3FulUgRegwn4gAWqHXsHf1Gen+XQyV0IU
	 ehEOzWpXT6lgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE465C43616;
	Fri, 14 Jun 2024 07:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the
 CIPSO options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171835023171.4750.875741752386268097.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 07:30:31 +0000
References: <20240607160753.1787105-1-omosnace@redhat.com>
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: paul@paul-moore.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  7 Jun 2024 18:07:51 +0200 you wrote:
> This series aims to improve cipso_v4_skbuff_delattr() to fully
> remove the CIPSO options instead of just clearing them with NOPs.
> That is implemented in the second patch, while the first patch is
> a bugfix for cipso_v4_delopt() that the second patch depends on.
> 
> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> https://src.fedoraproject.org/tests/selinux/pull-request/488
> 
> [...]

Here is the summary with links:
  - [v2,1/2] cipso: fix total option length computation
    (no matching commit)
  - [v2,2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
    https://git.kernel.org/netdev/net/c/89aa3619d141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




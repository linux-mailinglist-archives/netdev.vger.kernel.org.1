Return-Path: <netdev+bounces-210622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F00B140FC
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E75B7AD299
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF851276050;
	Mon, 28 Jul 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhIhpDL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A029275873
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722603; cv=none; b=Jbjqw/SIfwn0hhVq3zAf1gQCiPIvdFXYWvFD+waIiwdZBJI3MT/SjhobjKQYBD9aSB7+KL1jcMoiYTROZRJ4NOxq/HaDQgvvp3a+bgdQvWjMl3iwND5qxvzDTcsREvBUr/nHlj1FGbdaDqypg9cO9IclSyU94v2qQQ+yxtRxD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722603; c=relaxed/simple;
	bh=lApmwt35WLiudZ6S7sfG5oBChx24Fb/6m8e+vg0QSWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e0C1nO3P7ngG3X+6i47sYFnHltlpCRu6QgZ/mXp21tjha/R5tH+wwMVjd19IeICG0pVTvqX0fbnjCzaTGwQfTz0ur02iLAm1Zf5Yxlu0EHk86Dfswftf8F3I2LGfyARu1ulLMwQvnplki2QGYr+Y5jlemjdmdj3bHebUcg3a1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhIhpDL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69892C4CEE7;
	Mon, 28 Jul 2025 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753722603;
	bh=lApmwt35WLiudZ6S7sfG5oBChx24Fb/6m8e+vg0QSWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XhIhpDL4UGFp2NFLtm3tXDs+YU/iQDEvnqeTqMLma2y66Zn1I64wcA8TEzZiIkYLG
	 dVb4d7LujhTuZIqLb9UzzJE0JrwyTZIULvQ3CDWmNxEtlRvqpAOHExEJDeDmEiRSkf
	 XW5z2h9pweYIJtcOHQItk8usBuL5PCfQbUnIo0B9x3xDHP4HzaRNCJvsHaV92HUipK
	 0sSXElPMKsW6N13IwT5N99nRkvUeaKIJzMW11rXKtwHBfOVKpmp2fdzsHZZLlcy02n
	 3SQT9SIlY9/LNEiAQv5VYVcuBN5fObcPsYGYMhEnFNW7pDyjgpC1e0dySIuaYTsnKF
	 p5EuKfxnA/m1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE6383BF5F;
	Mon, 28 Jul 2025 17:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] bridge: fdb: Add support for FDB activity
 notification control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175372261974.782645.4776959441968068820.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 17:10:19 +0000
References: <20250717130509.470850-1-idosch@nvidia.com>
In-Reply-To: <20250717130509.470850-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 razor@blackwall.org, petrm@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 17 Jul 2025 16:05:09 +0300 you wrote:
> Add support for FDB activity notification control [1].
> 
> Users can use this to enable activity notifications on a new FDB entry
> that was learned on an ES (Ethernet Segment) peer and mark it as locally
> inactive:
> 
>  # bridge fdb add 00:11:22:33:44:55 dev bond1 master static activity_notify inactive
>  $ bridge -d fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
>  $ bridge -d -j -p fdb get 00:11:22:33:44:55 br br1
>  [ {
>          "mac": "00:11:22:33:44:55",
>          "ifname": "bond1",
>          "activity_notify": true,
>          "inactive": true,
>          "flags": [ ],
>          "master": "br1",
>          "state": "static"
>      } ]
> 
> [...]

Here is the summary with links:
  - [iproute2-next] bridge: fdb: Add support for FDB activity notification control
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e041178ba6bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




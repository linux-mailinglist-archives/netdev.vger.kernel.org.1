Return-Path: <netdev+bounces-151596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C974A9F02C5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D989316AAA7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389D22071;
	Fri, 13 Dec 2024 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGLk+ELX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64E182D9
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058217; cv=none; b=Ayk7Y+ypqdidihYwC4xCU6a9iFoe8LRmhKe/pIMBWfGLFDyNPFUVxB0Ozm32dyg3ifNh6zsVVJl5PSl11IJJKUoyGOwmId2HHc8wHIjmqlU0ZX5mpZhv3kSOTjkvMONPE1O7lGVy9NjBsna8IblQ4SyRRS2BiD8xaMFV0QPeAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058217; c=relaxed/simple;
	bh=uF8gD77/oBBSt1MgUvW46lb83D/2Yj1ts134dEabqbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQtouPgQW0CuAUVoln4BHnx6TlQtFNOQ16e+bNIAIaTfRdJOv4cOD/OY6rKojFu25hyacoD3jQdnxAsHfgv6oeJMcd1jsx7rn5ztYgPWfXOMNh+VfJH2sBRcOSM3JcWlZOwLndkToL5rqJoT9P4ql2Z/WE/SvFWp8MduEp5Yjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGLk+ELX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B6BC4CED3;
	Fri, 13 Dec 2024 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058216;
	bh=uF8gD77/oBBSt1MgUvW46lb83D/2Yj1ts134dEabqbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGLk+ELXdFAeSP5NDi5iFSzBT62/HEeRvgGJ0YRBZ9yAYUZ+ldFN6wA8N1OVriokO
	 stsDJCkx2JTwDFgqsFB+8rXcK0ZVgChsDeFrUBwsSSPvkI9tnWijLT/MRW+GhNtYr5
	 rXhfLDRvKFXAYJFAP3e6Ed52uuwJFo0PUmqI+TlaMofzt/999ZAY19kIcxarNTWkMS
	 rNw01B8rvvD9PzJN0cP7/PCIN+o0YQrCM3MjMkXaDe2LmHWg5l47k7RXJ+Z3S6URUe
	 d0/oyP30tUo57lxeumTVZUWogXZiD5ivv0rHxeOtjEMCcWMZmutZzzb+x/qYdYA2Ue
	 k5tsNZ3x6oZFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6A380A959;
	Fri, 13 Dec 2024 02:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net_sched: sch_cake: Add drop reasons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173405823301.2517381.3836983297088707226.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 02:50:33 +0000
References: <20241211-cake-drop-reason-v2-1-920afadf4d1b@redhat.com>
In-Reply-To: <20241211-cake-drop-reason-v2-1-920afadf4d1b@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, toke@toke.dk, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 cake@lists.bufferbloat.net, dave.taht@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 11:17:09 +0100 you wrote:
> Add three qdisc-specific drop reasons and use them in sch_cake:
> 
>  1) SKB_DROP_REASON_QDISC_OVERLIMIT
>     Whenever the total queue limit for a qdisc instance is exceeded
>     and a packet is dropped to make room.
> 
>  2) SKB_DROP_REASON_QDISC_CONGESTED
>     Whenever a packet is dropped by the qdisc AQM algorithm because
>     congestion is detected.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net_sched: sch_cake: Add drop reasons
    https://git.kernel.org/netdev/net-next/c/a42d71e322a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




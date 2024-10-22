Return-Path: <netdev+bounces-137887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071229AB00D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B087C1F219E0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7619F416;
	Tue, 22 Oct 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGw0RzMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DB19F406;
	Tue, 22 Oct 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605031; cv=none; b=BSWP1vVtuI7YhNpyz8As7208KT/YCb4ugQoZj0xwEQvAdUB9WnwH8U8bGmZdP29ZvoH6vJ611nQnGAPl7FHkXjcOFDwY2eLAVLB0wAFczkviJdiIzi9X9jAx6ga4aVrmqHy2uXFW3+ALRVSkwqHBe2ksQM54VUEid1+M+cHeFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605031; c=relaxed/simple;
	bh=7DhO+XcQtbQ7x3y0dr4Vob6lgsBvWAhZ/wmsNaotVAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XgIPBTaihHT9k38fFYTBOIDLdX6/2oLlFDYzhtuSOR8rXbuyuAOneO7UP0JlNoqZP+fy4JruPh9vyUOcHMRjbwdBGW7P96HYVxjjvGG44+k5hmG8xElR9RYeDkwv4rch+9rVYy3r52UOIznTIqgY5wP+H/T47exf0UClIDIlLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGw0RzMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10494C4CEEB;
	Tue, 22 Oct 2024 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605031;
	bh=7DhO+XcQtbQ7x3y0dr4Vob6lgsBvWAhZ/wmsNaotVAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGw0RzMwpUKQxnr06SubuZYaJdrSyxq2mYhqsDVIC8UZpKl3S+Ikq9pPLa6t91V74
	 qpp6iPh3YhQf5FfJB8Ty8mRMn4tTiAByXum1BMOw7XFa2y/s6xTYItLaRFKjwLYNkc
	 gm0e4rREcmnpVhhcWJnCOlEcDvRSPob8FIwGJ2o7hvQ/ogd3sb4OPly+AX8+anlZSH
	 RgMFbAtiw0hq1yhVE5HSw9CO1fVuInPbjetQU2igiEY+c6aSkeZj8Avs5Z61SCXS7u
	 PjC7NdEJ+0Zzt9gtaDbPNqeuHCl6EAPfA+8p87Cdc0CSDZe/k26S8uHtxSevueYLJ9
	 XUpwHPPQkH+Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118A3822D22;
	Tue, 22 Oct 2024 13:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] net: netconsole refactoring and warning fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172960503726.970813.1989936598226724092.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 13:50:37 +0000
References: <20241017095028.3131508-1-leitao@debian.org>
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davej@codemonkey.org.uk, vlad.wing@gmail.com, max@kutsevol.com,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 02:50:15 -0700 you wrote:
> The netconsole driver was showing a warning related to userdata
> information, depending on the message size being transmitted:
> 
> 	------------[ cut here ]------------
> 	WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
> 	 ? write_ext_msg+0x3b6/0x3d0
> 	 console_flush_all+0x1e9/0x330
> 	 ...
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: netconsole: remove msg_ready variable
    https://git.kernel.org/netdev/net-next/c/ab49de0f7a08
  - [net-next,v5,2/9] net: netconsole: split send_ext_msg_udp() function
    https://git.kernel.org/netdev/net-next/c/e7650d8d475c
  - [net-next,v5,3/9] net: netconsole: separate fragmented message handling in send_ext_msg
    https://git.kernel.org/netdev/net-next/c/e1e1ea2e78e8
  - [net-next,v5,4/9] net: netconsole: rename body to msg_body
    https://git.kernel.org/netdev/net-next/c/e1fa5d23b2c0
  - [net-next,v5,5/9] net: netconsole: introduce variable to track body length
    https://git.kernel.org/netdev/net-next/c/606994ad2695
  - [net-next,v5,6/9] net: netconsole: track explicitly if msgbody was written to buffer
    https://git.kernel.org/netdev/net-next/c/b8dee8ed13b8
  - [net-next,v5,7/9] net: netconsole: extract release appending into separate function
    https://git.kernel.org/netdev/net-next/c/684dce1f9984
  - [net-next,v5,8/9] net: netconsole: do not pass userdata up to the tail
    https://git.kernel.org/netdev/net-next/c/144d57360f5e
  - [net-next,v5,9/9] net: netconsole: split send_msg_fragmented
    https://git.kernel.org/netdev/net-next/c/60be416c6380

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




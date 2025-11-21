Return-Path: <netdev+bounces-240618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C2C76FF1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9C3454CE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C422F16E;
	Fri, 21 Nov 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijwgE2/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB51CD2C;
	Fri, 21 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691641; cv=none; b=F/X2QR8AYecsGgPlKBHTPBQ3jGOqEodWn++yIE92SCXdrfx/zmJBTBk3oPYzb7uZ4XURTDRUtcQAV9F7+KmHZYxCINxndj46Tqob4Ya0EBVmKnNKSeUqBdgfokw09f7IhLvOlnIID4tTtTfb28lEtXPgpRWge+dgzlHwHxKlL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691641; c=relaxed/simple;
	bh=FlHSWlZt115YXoLQbDjyJ5aFuG0kVazXOsrBQEmlKZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W64Z3VuZzUH7iub8wNoDAR+EZ2zvoE38xo3oqQl2EjMkOGnwrVEFrq6MUYF/vvxQsPoEVh4yfQFtZ8qYFLTlVqdG4B75UXObf31zqWbAFMoPPgMa8ZUSSNjqOsc6DT7J9jNQPeistJNxgUAohwLW08MeXEuslX2QCWIVnJLkuSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijwgE2/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB40C4CEF1;
	Fri, 21 Nov 2025 02:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763691640;
	bh=FlHSWlZt115YXoLQbDjyJ5aFuG0kVazXOsrBQEmlKZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ijwgE2/EWrS0/l6TLzbtEWRj251phV1pc3R0qlsSRxsnI7hyYfrF6N0JY+9CPtkxr
	 ozFd0XT6esJaZ6kuSGwvHEZzGp1riuNC/+KRujtmsf7GvIFzKQJvfUgtT+2m9rtYyi
	 BziLBqrp5HNhbB3jrYFbvYR8vFLjJ6kTcY8lPGv69HuYDzqGUjykKZJUBWHj2cO8xA
	 09mdcFOs5Z0GIr4p6ZAfky/yHPOlRZN8PK5Jig+eVEBrKF1LzH0ZOeqyQNGiE/IxIX
	 jBHgPeALTYkS8RO87eXh2sL0s4KpdC+cfL5bok6obFtd8Z0bIfsJJ/LEJxUAjuE9Du
	 2MadnXD/frU4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0B3A41003;
	Fri, 21 Nov 2025 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atm: fix incorrect cleanup function call in error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369160578.1863338.9797726475142427513.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:20:05 +0000
References: <20251119085747.67139-1-sayooj@aerlync.com>
In-Reply-To: <20251119085747.67139-1-sayooj@aerlync.com>
To: Sayooj K Karun <sayooj@aerlync.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 3chas3@gmail.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 14:27:47 +0530 you wrote:
> In atm_init(), if atmsvc_init() fails, the code jumps to out_atmpvc_exit
> label which incorrectly calls atmsvc_exit() instead of atmpvc_exit().
> This results in calling the wrong cleanup function and failing to properly
> clean up atmpvc_init().
> 
> Fix this by calling atmpvc_exit() in the out_atmpvc_exit error path.
> 
> [...]

Here is the summary with links:
  - net: atm: fix incorrect cleanup function call in error path
    https://git.kernel.org/netdev/net/c/4b4749b7b4b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




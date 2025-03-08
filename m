Return-Path: <netdev+bounces-173142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B57A57814
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4273B660B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EB1714C0;
	Sat,  8 Mar 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo9zggLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634B169AE6
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405802; cv=none; b=IRiQvyXA3AOMMDqr17CtAx1EBkkvcFPHc1UBVqmSIh2FtM6Q7FX76KSzUoASc+xsyocqCF8EEjmgBZ9YhhwlkQlYpQJCxJkM5e0vBPLIkBoA3E+JoK3jZ5Kiplm3g8Jsi48Wha4ZGotAPAKj7tTefabWbB6uSF6F6SPW42GkmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405802; c=relaxed/simple;
	bh=km2Ws+ebLOC7cqyS6i/60FaR7y51e1gnt88MMhdOtpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrXENNvrnS4cezsOtaq+ImNqd3J7MPt01wBFHtYX20tbo3QbcJ5hqg7RZWG/TSCF2wIl+6Llnw7BgrdIxn1h4OAZRcjwojzr0+0FXKxT/sctnsSBqlu6h7dOwi72k0lXh2Higxx+RCxsBeyjcMUZq7yN2T+x9T1eUo0aW5PMI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo9zggLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDBC4CEED;
	Sat,  8 Mar 2025 03:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405801;
	bh=km2Ws+ebLOC7cqyS6i/60FaR7y51e1gnt88MMhdOtpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qo9zggLhE4CTMSyAkWLSupHSEqgfLGsKUJ90hIUX2IawYEvGL1ZTaErxGfKnMEVwX
	 CliUCyYj+rUcAEPyFuW2QVtV4qAptPwkVte7KBmCjh7XWIqoSQ0uPfLm4xkDgV+PIe
	 AtChP0MptMkA+U7z+vWqaMh3lJRzE5/MBTP8HiY2LnAXJP+mwaVeeKqkiKyGUd2fry
	 HxkY+LowU8i/iup6StWssqCgikoE/hLDdKQkWZuUXpa1u9Ufj609GFLlhrut70UA2U
	 jvwx8lhR5TC0NBZe/YI+weVVxlJ7tv5NW8ttP7+htQBhVpq5bx+3h3JuKLn04D2rHe
	 lOdsOiJSDaxVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DD380CFFB;
	Sat,  8 Mar 2025 03:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp i2c: Copy headers if cloned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140583525.2568613.8339138763937521440.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:35 +0000
References: <20250306-matt-mctp-i2c-cow-v1-1-293827212681@codeconstruct.com.au>
In-Reply-To: <20250306-matt-mctp-i2c-cow-v1-1-293827212681@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wsa@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Mar 2025 10:33:20 +0800 you wrote:
> Use skb_cow_head() prior to modifying the TX SKB. This is necessary
> when the SKB has been cloned, to avoid modifying other shared clones.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> ---
>  drivers/net/mctp/mctp-i2c.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> [...]

Here is the summary with links:
  - net: mctp i2c: Copy headers if cloned
    https://git.kernel.org/netdev/net/c/df8ce77ba8b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-68422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6C846DCA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4505F1F21EAA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3D7A70E;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiV/7m+u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6C78B64
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869227; cv=none; b=KRlAcxe5mbOgaPMB/P4qwA/ZbCpGrcan0Uv9Ikiv7BYR76KTRDKNi1Y7FsnRZ9LlEgC9JpCwuzPOp85tmBnPIgoKjxnHwUIQ/OmXQ4Dbn51qLsvrH5dqQwaoIz/ebZZtP7gkXGXmAovH9UC+Det9zBX4cuxfR0TWpwqK3Ejq4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869227; c=relaxed/simple;
	bh=/XHf9Y993bsNG50qFAHHxUzec9qZVSTcQXLQ8xDRHUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r12oMyoq0KgTTHKziSGdr7BpYd9x3zpNjREYAb6WL6OKLyvVplYvOfZsesEUZ4Pj3w10OZhHnM89a1FzFdm+EZUJQj0SxirIWtjyAD0EN1cuocc6/QsVTe6rEqWpXSU5sqed8yMw2rdGg+Skt+Ukrrtco2RZtgNc/BASVFnmwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiV/7m+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 196A6C43394;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869227;
	bh=/XHf9Y993bsNG50qFAHHxUzec9qZVSTcQXLQ8xDRHUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SiV/7m+u8z2fBNeXM9lNKQnyBb0jSBJM/rNnyBr3lc0a/hAkGZZ3mweFyZiNqofXI
	 Qi+EaybnQnqRg428JuQfI24r7rGVhzvjCwSoYgPUDtNPr63P6pO4yK6a+i6kN+JFNE
	 dpVV/OEgq6Rp9vaWOiQi5EBlXVPiiUJMZycznalkdNuTlnLdd6dUICf5U53GbcFW52
	 lTfMkHl3Pg3vUkiFPu/3Uf+3LVAKLAM45z6Xinvb7XFHU/ousRkpH8tBeUQfNgTs+m
	 pEpNP48SvTbpXHXVO+FgRDQGcc+VxVoq782HkqJL6o8crr3V8+gYpAg/HnEBd6giuR
	 RXgZ7yKPww0Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00EF0DC99E7;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND 1/1] net: phy: dp83867: Add support for
 active-low LEDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170686922699.24154.12053193327326884995.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 10:20:26 +0000
References: <20240131075048.1092551-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240131075048.1092551-1-alexander.stein@ew.tq-group.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 08:50:48 +0100 you wrote:
> Add the led_polarity_set callback for setting LED polarity.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> With the addition of LED polarity modes, PHY LEDs attached to this PHY can
> be configured as active-low.
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND,1/1] net: phy: dp83867: Add support for active-low LEDs
    https://git.kernel.org/netdev/net-next/c/447b80a9330e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




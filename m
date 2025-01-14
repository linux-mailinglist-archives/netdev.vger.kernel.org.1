Return-Path: <netdev+bounces-157955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E4A0FF0D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2967A1887D5E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A0233145;
	Tue, 14 Jan 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgGCAKYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D132327BA;
	Tue, 14 Jan 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824215; cv=none; b=REivM7ozHRwNtGl41Jlge6lgtqrl01oH5HjHGSgnbTz0g8/f3tMv5LGbhKdeqS9KmvxWPrj0bHIjxCnmOBbi2xFI+dlthGtnlXSCdi/GBtLMRGwDi7TN/eeMk2XerQZZDlcxn1j4D6Z47YpYp4kwyUUlsW1paCA+XwxyOxizCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824215; c=relaxed/simple;
	bh=CVj7TdloU+gXG15A51Peimye0OPTDRYZodtEP33PreQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7MOl30tCe+YVXzW0ksiP0M46MqL11oQuAXVQo5RKzDwiGHhDc2n8xdYnEHqDB8Wk3Ps6iLJ6emtOYM0tlZuOg4NL+h37joZQV/63pGc68KBLzJlJELDOmTAUCtM8wnz6SsuETPWA7p4+uOTF8JtfiYCNpLscw94O9qyYcjFmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgGCAKYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A19AC4CEDF;
	Tue, 14 Jan 2025 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736824215;
	bh=CVj7TdloU+gXG15A51Peimye0OPTDRYZodtEP33PreQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgGCAKYt4Z8Bvt5yPHuzRjwgq66Qk+KX8Rk1orS5F9+AyZx8Y7udllHQcsV6Y4UkM
	 aMEkvnIv9bI6OdLNQwy8Mti+10ZMuQ3mbnfoYN8kV5ueFTtyn3OyoUIBkez6kVfMbJ
	 A8y2CVvIWyQR88uEcmUfXXk1GclAdwRGWhBgPrnCyyoEUKV/3GTgftoC95MYoMmPrF
	 178ZXRLME6ijIQ5jckBIxzWigi+RMn88oBWLsnbAy7m7BpY+hHpW28i8ze2c8wtuDH
	 tR4GN6MBBQyjBrXdqmSrYd9rama6K/kAUAQICON9xHOUbTH/fkuBNeyEuCaBaVzC7q
	 xH5OkE+ybhUDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B0E380AA5F;
	Tue, 14 Jan 2025 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682423774.3717681.2700579800997856759.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:10:37 +0000
References: <20250109155842.60798-1-rgallaispou@gmail.com>
In-Reply-To: <20250109155842.60798-1-rgallaispou@gmail.com>
To: =?utf-8?q?Rapha=C3=ABl_Gallais-Pou_=3Crgallaispou=40gmail=2Ecom=3E?=@codeaurora.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 16:58:42 +0100 you wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v2:
>   - Split serie in single patches
>   - Remove irrelevant 'Link:' from commit log
>   - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-5-c7d4c4856336@gmail.com
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    https://git.kernel.org/netdev/net-next/c/6e702e6aba84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




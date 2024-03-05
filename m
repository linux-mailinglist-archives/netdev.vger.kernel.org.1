Return-Path: <netdev+bounces-77339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F887150A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5178B21A09
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2343AB0;
	Tue,  5 Mar 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZCRiONi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C540BE5
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614831; cv=none; b=f0FG77Cm7ubIAPcV7O70aIraUv0kvcw8NG5xQMpOKxajxvNwlIAOd6lNVkPTqn2ir+d4xGR2l6x/ouGC28yiZZoEGne05FmqlGu7K+bvb/EFpX+JDgQLbKCCmNVh3W23S58HS8bQX6xNg+j8XtOqRvY9sC2CF0USwxnUzHAG3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614831; c=relaxed/simple;
	bh=N52NIcfoeOdnmfHE44Kv4ZvhogulZHMe3YwB6vj1GQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Js9Q87cM3Mr/n+MQtGl57cDG2sRf5UKObO/BsO4IB0+dV2eNtuC+dxiWxtCic+YQTTpNgY8baiZ4S2WBATklag78Fv0k7+6Wz3n3mByKTRLQzZh2Aw2QMiv0ECxT4kMElC3Uh+SSRU6HFAGgKF3UxsvvcYv01s5uoqBQdZGyVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZCRiONi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A05C433C7;
	Tue,  5 Mar 2024 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709614830;
	bh=N52NIcfoeOdnmfHE44Kv4ZvhogulZHMe3YwB6vj1GQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dZCRiONin4uXA27PLAuwayoBtX3WyVTYltPaYm5pY/remQ0T181CG1vTE65n4zYG4
	 C1zxKLRMQfe9wSNpJj79UhmsFPC2SbVF0qKYEELkpNakaxg4AET4HFwpLzkoj/D+Nh
	 tjSLEc7KcBVG1ThiI6NnWb9aIx47Qbd6qwsGXkdsQ/oPd3snWC7nfwV679x1ptEYjg
	 rz5JQ46EWMgorZQf0OAopwuA7mTZAftAmyI3LOhGLcrZ0xI/r0iIoUsb9hu55eUjAZ
	 iKgWI1F5Fb0jJN1I18dD0KgC1+2GzXc49xCvWyx7GqRTTMOuCpcctHO6CCJV8rXy7j
	 Y5WM4CjpdaGsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4FD4D9A4B5;
	Tue,  5 Mar 2024 05:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver Updates
 2024-02-28 (ixgbe, igc, igb, e1000e, e100)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961483067.15495.15190821240384303008.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 05:00:30 +0000
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Mar 2024 10:48:01 -0800 you wrote:
> This series contains updates to ixgbe, igc, igb, e1000e, and e100
> drivers.
> 
> Jon Maxwell makes module parameter values readable in sysfs for ixgbe,
> igb, and e100.
> 
> Ernesto Castellotti adds support for 1000BASE-BX on ixgbe.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] intel: make module parameters readable in sys filesystem
    https://git.kernel.org/netdev/net-next/c/aa9870f5c7ef
  - [net-next,v2,2/4] ixgbe: Add 1000BASE-BX support
    https://git.kernel.org/netdev/net-next/c/1b43e0d20f2d
  - [net-next,v2,3/4] igc: fix LEDS_CLASS dependency
    https://git.kernel.org/netdev/net-next/c/30654f0eec65
  - [net-next,v2,4/4] e1000e: Minor flow correction in e1000_shutdown function
    https://git.kernel.org/netdev/net-next/c/662200e324da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




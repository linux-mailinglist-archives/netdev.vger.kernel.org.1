Return-Path: <netdev+bounces-244216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E5CB28B4
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A56B313D84E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB26313531;
	Wed, 10 Dec 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjTjxEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA131327B;
	Wed, 10 Dec 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358602; cv=none; b=lCgrwZD7pb/WvyoKWi7+ehx7cCb4JEKlpW9GtaLPgMjduS3j2EVGc3o8OFiFPFp+Apyif3CUv150BXLw9T6Cdb77wZAdFeCppnqb2u23YBGEQFDuJcai5DQLv2TTMKFDcMi/XY2AE6hIlTw2QXpKgQ15N8873qOgc4hud5t/bM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358602; c=relaxed/simple;
	bh=M9+qzYDTodf+Ghzo0GJvB5sNxJSUJZ9T0wWRgNj3cxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HvwKzLngaoHYzQFQRCWYNn39+kuFciaM4NhWphb6mA0UY5XJNyKUzWz2gttSpZz2vaSjBJTssU+bq20r4mn0EaiuhS/2iPEAW5BMQgmxOH13ycnIdfWeXkVdl32O87hyCfhwT1zAnNErPAZlHqLNgBYlgfBYXs7E44CkEHSH+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjTjxEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A74C4CEF1;
	Wed, 10 Dec 2025 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358602;
	bh=M9+qzYDTodf+Ghzo0GJvB5sNxJSUJZ9T0wWRgNj3cxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LxjTjxEPncGHWeroNabjc2hzdtuaqA2Mj8whcyJY8wogcfHdvIK7tj8sUyVyr3m80
	 mrI/o4Qk6iwO47SJ8h5Y5XUKXljN7dHROjv6fi+0s97QsJzWmeDF8VC55AKT7jvp9D
	 d7d3Bgx+5qwSfTP6M3gcJaURlg6mewfQiHx3AKE0PZvE1ba1fgXi4gdGVTPDr79SaJ
	 rXMFB57FXa8/fcxB3GVflN8YfVcjMOHYYfjvl8XV0DrjrBVYxH0hrDX54boinQZSZm
	 hVbFNmOOzlHtZOc0G0oLm/bXjjbYZmsGqazUsUMwg71DU2w9P/l9E+tWvQup7wzT2K
	 Orn4ev4SfwpOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28E93809A18;
	Wed, 10 Dec 2025 09:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL
 dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535841652.523551.6955043910846497888.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:20:16 +0000
References: <20251204100138.1034175-1-arnd@kernel.org>
In-Reply-To: <20251204100138.1034175-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 danishanwar@ti.com, diogo.ivo@siemens.com, jan.kiszka@siemens.com,
 rogerq@ti.com, basharath@couthit.com, afd@ti.com, parvathi@couthit.com,
 arnd@arndb.de, m-malladi@ti.com, s.hauer@pengutronix.de, pmohan@couthit.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Dec 2025 11:01:28 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new icssg-prueth driver needs the same dependency as the other parts
> that use the ptp-1588:
> 
> WARNING: unmet direct dependencies detected for TI_ICSS_IEP
>   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PTP_1588_CLOCK_OPTIONAL [=m] && TI_PRUSS [=y]
>   Selected by [y]:
>   - TI_PRUETH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PRU_REMOTEPROC [=y] && NET_SWITCHDEV [=y]
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL dependency
    https://git.kernel.org/netdev/net/c/9e7477a42744

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




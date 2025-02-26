Return-Path: <netdev+bounces-169680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CACA453BE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A5F17B545
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750C228361;
	Wed, 26 Feb 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJgwHHsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81127225A22;
	Wed, 26 Feb 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539410; cv=none; b=QlfYBbR0fNiJCCOE83Gx6bspdyqnNeKQy6qlJU+nCvtZIKYY+e/6L87VFWxw9pVtRHY1MLUM62GXSwiMLWfsXXjRKWlNGN6rdQeHyMc59VclCI6O5d4dFVT+fLjdns/dLPTr5w0JmULklfRY27m7LDVH4e73CU7d4qSv15U1pEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539410; c=relaxed/simple;
	bh=atSCfJYgCz1YPY9qaUIHK3Z9wgsRjkkwuytAKmlgGag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/Vh+LAyT2942tnjDvFpXyUdZWv7g0Yi6v70XrssW/JUgXSWPKAAjhzSJkip7SpYCG8nifp+zQA6wbiG0wwjYeRDPqjpo6jfZKYw8lKOEqH9NULn9CnCaPY+eg8ynL0HPhAgysM+x7LD2MhcHU1FOiOKjBrEXberF9W/YTAD70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJgwHHsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03AEC4CEE7;
	Wed, 26 Feb 2025 03:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539410;
	bh=atSCfJYgCz1YPY9qaUIHK3Z9wgsRjkkwuytAKmlgGag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJgwHHsk+s9cq+FjAmWjpy5JWOGM3fMvJbs2J9lj9y0ix+Bt9BfnZKJwrNvAU/QT7
	 kFFePACIHA1GFLYrPVTOuN1YXmC9Ajo1bKGnt2078YLzCgn14O/EChIaNz/eNKgNIO
	 V6ewzK0KTEKAHzS01K6pihNEVgd3ImGw2xNf+NjpiMjjeQSd0pea8oT4hSKAXqag8T
	 qXHzY2MZTWJCcaUKn2EGdPS/QWcKNWzyrsAmmyIryb6izPjlGZwFnkYgn1V8aKn50s
	 UezItIDB8oUKLulZHiZDmiOQ7fan+Wr2tpNT7BxA7OQP9+q8rCJdLcrAOV0WijsSS7
	 kT9ECcLNihPmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0A380CFDD;
	Wed, 26 Feb 2025 03:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wangxun: fix LIBWX dependencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944149.217003.4809468939056038023.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:41 +0000
References: <20250224140516.1168214-1-arnd@kernel.org>
In-Reply-To: <20250224140516.1168214-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, arnd@arndb.de,
 heikki.krogerus@linux.intel.com, jarkko.nikula@linux.intel.com,
 andi.shyti@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 15:05:06 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting LIBWX requires that its dependencies are met first:
> 
> WARNING: unmet direct dependencies detected for LIBWX
>   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
>   Selected by [y]:
>   - TXGBE [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && COMMON_CLK [=y] && I2C_DESIGNWARE_PLATFORM [=y]
> ld.lld-21: error: undefined symbol: ptp_schedule_worker
> >>> referenced by wx_ptp.c:747 (/home/arnd/arm-soc/drivers/net/ethernet/wangxun/libwx/wx_ptp.c:747)
> >>>               drivers/net/ethernet/wangxun/libwx/wx_ptp.o:(wx_ptp_reset) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - net: wangxun: fix LIBWX dependencies
    https://git.kernel.org/netdev/net-next/c/8fa19c2c69fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




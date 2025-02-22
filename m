Return-Path: <netdev+bounces-168724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CBA40463
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521E5703589
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763832B2CF;
	Sat, 22 Feb 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTDkRP3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18C1CF8B;
	Sat, 22 Feb 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185399; cv=none; b=ghO4joDbZBlqPUScp9G3FQFUBtX7gIbisL21tRjFJQ7sLF56feUwXqPOn5CiWsuRj4PBh10Azm6seHwAYhGpPhr15BJs+5bif9yJ0XmSDJFHoX9SmvrFJFcjELiszLkRF5sa5i5NCV8dG5otmo1m19sndQ+GxBG9dpSKjetfrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185399; c=relaxed/simple;
	bh=rlhW2u6asfZeesOm043RNpMYpJcG4du5sVGT5TT+2Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cAyF3Li1tV3cP9amo6fHAGim8gwpfswiP4Xx17OaFJ2soRk6W8CU6Ykzq/8un/1vS7UyZAAVQilYNrrTt3d6ES1YfJf4p22730yf03dpE388Uo2RnRtm0g2y+kGkEluKPz/gLux9yE2faI9FdaZkssS6filoJn0QBqel2NRdJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTDkRP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3345C4CED6;
	Sat, 22 Feb 2025 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185398;
	bh=rlhW2u6asfZeesOm043RNpMYpJcG4du5sVGT5TT+2Qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XMTDkRP3ek18NaKquxI+L1qFuIkG9nfVfBdLoY7fxQgs3AS/OeNEogNvlV7OF8NiH
	 JzUMduXXUMgJSMhSlUsSPtYmG08TijlUZF+3r1c7Bp33XTxm9Vay69zjUVWY5RF0zk
	 vfeJItbs9hgYgIlexgnxiwierIQqajSfXBoHKGz/AMO9L3xhURLp+TfqUGrcif68Jj
	 UsasXOnNHxUlZ2+utePY7mI/FIw2S7aIn5Tb1o0UsIkqigZaUcv6KVfl4AyY0rrzDN
	 rpFCiGNTUjZYrLRv76JFarO9txugnpPKHc7wxl9xNpcsgXNRKd/O7qJpZYb+7q+DIM
	 EtE0Fn6mgvlbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB191380CEF6;
	Sat, 22 Feb 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: cadence: macb: Synchronize stats calculations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018542976.2255625.1273232177921344284.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:50:29 +0000
References: <20250220162950.95941-1-sean.anderson@linux.dev>
In-Reply-To: <20250220162950.95941-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 11:29:50 -0500 you wrote:
> Stats calculations involve a RMW to add the stat update to the existing
> value. This is currently not protected by any synchronization mechanism,
> so data races are possible. Add a spinlock to protect the update. The
> reader side could be protected using u64_stats, but we would still need
> a spinlock for the update side anyway. And we always do an update
> immediately before reading the stats anyway.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: cadence: macb: Synchronize stats calculations
    https://git.kernel.org/netdev/net/c/fa52f15c745c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




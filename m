Return-Path: <netdev+bounces-251285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFBD3B812
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CD73014628
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB162DFA4A;
	Mon, 19 Jan 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgwV3RLZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FF2D23A6;
	Mon, 19 Jan 2026 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853412; cv=none; b=ZAsidEm66S96fhcIibN1+O2F29qJ0xreLE2eithNWGxWYce0nikz/ta5ABgt+ChRVYHYXunLa3HoUpNyr+hCKxJfqgAilGQdsQorcrho4sNN3iNobzpkRGScVsnt4uiHTs89pYD7d5WZKzNcsXqKsv78eCgLHi78xtWVK6J2zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853412; c=relaxed/simple;
	bh=T6vsd4Eb6tA1JHA41+BJf5+qW4tkABTcW3NPBmlWXKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTNQgcl7CzCBKAkknFtgp07TidNLSiRFDNhAj7+cbi6AIDi4TzpWyxnnWTH0UIX/IYv6NRQndNMsFktpgdp50ckcha5fxIMmwkhc+AZFkJhM1P+5ID2K6LqoVcMRFXFic6/3HquyMuglCRauFJBeF2gI8Tbra+uct3ULnooBwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgwV3RLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4688C116C6;
	Mon, 19 Jan 2026 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768853411;
	bh=T6vsd4Eb6tA1JHA41+BJf5+qW4tkABTcW3NPBmlWXKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZgwV3RLZW8NrOmLKO6w+ub/RYNVvH2T/Bipyt3hEvVYoUGUncOy1wXDpKNDvKqXdS
	 IZQ+d35Ox0oXTGAcXtGNF9AU0tCAa1Ng5SJ/9H+H0xClDCiQwCW/W4Ym9AUtTYL+AG
	 VTcpG09W3pssgKlLePKFqzSHY7qItFubmeQUozXH507nyQav6dfCWGMMLB9FFFy2wP
	 2O2f57BXMcxQmizXNa9KPloYZZrAZBnn7N4Fgq7zxUBLxZPvOKTWm3zgegeWb75t4/
	 Rg+eMzmY9kv43eli66e0UL2BAVX7JTFRr0Dy/Stz9Yr56gZTRjCobNVy644m2j/VcL
	 Zbk64GoJjxeXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8DFB3806907;
	Mon, 19 Jan 2026 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] dpll: support mode switching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176885340954.121500.4734443313038380002.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 20:10:09 +0000
References: <20260114122726.120303-1-ivecera@redhat.com>
In-Reply-To: <20260114122726.120303-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, Prathosh.Satish@microchip.com, poros@redhat.com,
 linux-kernel@vger.kernel.org, mschmidt@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 13:27:23 +0100 you wrote:
> This series adds support for switching the working mode (automatic vs
> manual) of a DPLL device via netlink.
> 
> Currently, the DPLL subsystem allows userspace to retrieve the current
> working mode but lacks the mechanism to configure it. Userspace is also
> unaware of which modes a specific device actually supports, as it
> currently assumes only the active mode is supported.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dpll: add dpll_device op to get supported modes
    https://git.kernel.org/netdev/net-next/c/b1f99cc88638
  - [net-next,v3,2/3] dpll: add dpll_device op to set working mode
    https://git.kernel.org/netdev/net-next/c/e3f6c65192fe
  - [net-next,v3,3/3] dpll: zl3073x: Implement device mode setting support
    https://git.kernel.org/netdev/net-next/c/d6df0dea24d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




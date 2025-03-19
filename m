Return-Path: <netdev+bounces-176248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7888A6980F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141061897ECB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F2820AF69;
	Wed, 19 Mar 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX+941jw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FC19006F;
	Wed, 19 Mar 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408998; cv=none; b=DM5W9lBjFxbhZRmEQ+GJQjXdV1h2jsvsv6+UVpKTnapNp+MMMct7LqU7Fq6fS6bWtyPFWLMsRyDam1/lCjTsXda59WhvuB39vlR1j89nqdJHLZbrzWFmbpLk02KoHj9b4wEuzcnMw4GNRsQXS260sotPMPHNoy5CK+GZzo/iCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408998; c=relaxed/simple;
	bh=rDEJilAYGA8Ecmyu39y36S9/93GbeW/ZKb/0a5sXCwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzJ/sbiazrVvVKYE6hEw8VqxnFWOgNCtFu4y0jwWq+IYw2FhHQWAH+l3mFxwAr9x9WRsE6s520PztF55rH01+jbmG+wv5WxG2BgK2tHTLmIPfUElTlOj0c+7h462EqSJbAeCHJGCWhOhWemP+wyUJu6motRn/td9U3Ae/jKMf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX+941jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C80BC4CEE4;
	Wed, 19 Mar 2025 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742408998;
	bh=rDEJilAYGA8Ecmyu39y36S9/93GbeW/ZKb/0a5sXCwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cX+941jwqXvuLuF6yUrjZQZJEg086+pcY5nlwE3jdJ/vv6mSXU1J2pA7qYMbJSFE9
	 wdljIudrLLYIMs3Ri90BpWAv5q7iu+0Jb0viUurFXz2geIHxe00Gbr4eJCqSeiwWyr
	 Wv4DUtSeBYweYvN3HG5cWFV0vGUpw1KZiMpmCFMJ0P2hpzu/a39wwUPkg15bR+KDY7
	 PFdd+LPi5m6+aU+PUzMX3l30TJSG6+UByaPCQM/9arRBkFuVCMcN+doW2LgkSXh1n6
	 FGup0bUa1ldcP++3Zy1Bv+bGOF8tITgp4v8Dez1MRG6q3MBrZIRq7CFEQwGtVNPnBy
	 p/iHaOFkTVhBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A9380CFFE;
	Wed, 19 Mar 2025 18:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] netconsole: allow selection of egress
 interface via MAC address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240903376.1147083.9038887742867617656.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:30:33 +0000
References: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
In-Reply-To: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 srinivas.kandagatla@linaro.org, rafal@milecki.pl, horms@kernel.org,
 akpm@linux-foundation.org, johannes@sipsolutions.net, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, horms@verge.net.au

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 13:51:45 -0600 you wrote:
> This series adds support for selecting a netconsole egress interface by
> specifying the MAC address (in place of the interface name) in the
> boot/module parameter.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes in v6:
> - No changes, just rebase on net-next/main and repost for patchwork
>   automation
> - Link to v5: https://lore.kernel.org/r/20250220-netconsole-v5-0-4aeafa71debf@purestorage.com
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net, treewide: define and use MAC_ADDR_STR_LEN
    https://git.kernel.org/netdev/net-next/c/6d6c1ba78240
  - [net-next,v6,2/2] netconsole: allow selection of egress interface via MAC address
    https://git.kernel.org/netdev/net-next/c/f8a10bed32f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




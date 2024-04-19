Return-Path: <netdev+bounces-89610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7968AADFC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15091F21B83
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3983A06;
	Fri, 19 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0REu8hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463422064
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528028; cv=none; b=KF42RmkPYIhSVKZ8CeenMzajVGiO619N+fV7yx/FPrWUZTvbtNDLclLaqelK42PogN4Tw+fl8V9vIP+aA5kIBLdmMNMPqW864EBYNj99j96fuinRsxeJc2xsPEO+7ixmHOTgsls74SkzKUp6zcrUbO9zYYwyffk8GNdZmembBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528028; c=relaxed/simple;
	bh=msXl/O/E9/AQw5Qev7GQCxlxekUyA6kBRZl1RpaLlNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oFHbMtC85pKJo34BAapr0Z4JgSEFn7433pkotFQcYPl1OjulXkLsZVrKlS0g2D7uxbaU4ms9hqRGZXmsJYMYwo2ouSoHnSlIDcBZDfmDuH4PYdUAhA9aLHyul+CKz0OAR23OqBMxXj5qRiJGSVk2+FYbJLaZbCgMNWTwT8UYyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0REu8hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85477C2BD10;
	Fri, 19 Apr 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713528027;
	bh=msXl/O/E9/AQw5Qev7GQCxlxekUyA6kBRZl1RpaLlNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0REu8hxLbweN2Pu+Tm3cmbuBegGsDCjUZdNX2JozyNsw+BpSZ7OLOeFTMlNw/LVJ
	 7PPgvyl8SNQsnKH7ylucUyXTt1j/yLuGxZqMzvmt4rrMSYtZlrjiGme1OfIJfRrmrl
	 K8ZPYG7fnAXoy8TcL3HnqKvbtGWaAAe3HNtcrmzvMW3L0rsjgvwqRe8M6uU87V6cFq
	 iP3wuxXxEE/COaVsyFAzF/kfNmzfelW1t7yHQ3GzZX/D+kh/4nNceszTTx/O1fdkIA
	 tiqk5RGyqWwVrx7gtyOiOKnCC5Xp3P98C+/KOURqOiDmZ+BF3fr+NfiU0haRbefMkc
	 RcOtkSzFxRpOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 752EFC43616;
	Fri, 19 Apr 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vxlan: drop packets from invalid src-address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352802747.22575.7295961597022710844.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 12:00:27 +0000
References: <20240418132908.38032-1-mail@david-bauer.net>
In-Reply-To: <20240418132908.38032-1-mail@david-bauer.net>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 15:29:08 +0200 you wrote:
> The VXLAN driver currently does not check if the inner layer2
> source-address is valid.
> 
> In case source-address snooping/learning is enabled, a entry in the FDB
> for the invalid address is created with the layer3 address of the tunnel
> endpoint.
> 
> [...]

Here is the summary with links:
  - [net,v2] vxlan: drop packets from invalid src-address
    https://git.kernel.org/netdev/net/c/f58f45c1e5b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




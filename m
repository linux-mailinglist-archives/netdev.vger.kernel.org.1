Return-Path: <netdev+bounces-247547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503ECFB983
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6974330D45D6
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608520E6E2;
	Wed,  7 Jan 2026 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAuNCWSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3F1DDC07
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749022; cv=none; b=AtDs29fTyjJ3tysFAN6VncAFJtprm1x4D7rdc+W2m9Q3cFzDMe6+/wB/MoAtdqSotdlODVN7fiIzaWMlyxhg8CYVFTX/0nyZtmstyEz687RIrwwEVUHNCexXk5M9jvy7wixC9GwlP1RypDL/K2M0Jnhsh2hevZnbscih1jBZnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749022; c=relaxed/simple;
	bh=IQkIGDZUPAQvMCIrS531ZBWTEZL8ze0N37vDBomOzJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JWDdK8vO5NkRFjoza2z5H2G5XAW13pGCHayhqoQ4huqAKW4JFb4uGnW/7+DWLsUgXs/zQZaUqxzzoYqVwWtd4ZA9K0yJBju8hbcyQx7+WbW3a6fNXmsPQ+S27NgNJFOnecKGbCNGEIMkqx9D4qO0vIsyFhn7N3wsibxI6lQAH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAuNCWSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861B2C19423;
	Wed,  7 Jan 2026 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749021;
	bh=IQkIGDZUPAQvMCIrS531ZBWTEZL8ze0N37vDBomOzJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jAuNCWSOt5VVobeJqIYZuYZdDZsqr9f1onyELZUf+hL3S/VviUJaVzR4wwOJvyqy0
	 gh4UQWpc3PEw+ESGooQhWK2vt7CMIgtyduB9WR6gG5J/NpUs6NdaY0tc+n3y8jp14V
	 EXtDO5eWKbPnpNPhvZavcv41aYAbFG6R7l/rEzafPFDzXpZVbjVs3yh7Y9xYqWq4hB
	 zK25YxbUufaA9AbTJhTDdHtnv0hwKZVjXYmm+Dyzbugjklh5+iAf6OK63VxODypv58
	 2+6mbAScm/Zp40D4UR5icqJm4WpNLwtJbYhsgG10hSZT4e+NcpqKo8QyS+fyvHn7pn
	 lNEFB+78cZAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BF23380CEF5;
	Wed,  7 Jan 2026 01:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: udplite is unlikely
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774881882.2188953.5562325587557891229.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:20:18 +0000
References: <20260105101719.2378881-1-edumazet@google.com>
In-Reply-To: <20260105101719.2378881-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 10:17:19 +0000 you wrote:
> Add some unlikely() annotations to speed up the fast path,
> at least with clang compiler.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/udp.h | 2 +-
>  include/net/udp.h   | 8 ++++----
>  net/ipv4/udp.c      | 5 +++--
>  net/ipv6/udp.c      | 5 +++--
>  4 files changed, 11 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] udp: udplite is unlikely
    https://git.kernel.org/netdev/net-next/c/e9cd04b2816f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




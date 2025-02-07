Return-Path: <netdev+bounces-163754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B919A2B7C0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C11669B7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25F54723;
	Fri,  7 Feb 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEWH5E2p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524D33997
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891207; cv=none; b=Vp6f4rkH3NHzU0uX3CyFlgckWq2qhkD/GIePW3/Js3EQhujc3Qu/la+V0x7dcA5mCSV670Lif3xecU06n2MgwWxKrJOu9oNIaDJkxO55bF/Tq+g/Epl2PGUQbH/HHciFmJRqB39irzlEb5w7itvP1oqGs5D5MOnW1rHArBwZDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891207; c=relaxed/simple;
	bh=/eQepd7t9WbqF+rO+C6ugvIzUBu5cUU400/lwirMgpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLPzMqmBuBOR2ku7DeSDidP1ImHLmQHHLgGM9IJzecDZ+bm95VhS2I1ltnQILboFiFx2qoqSZGwRjGv4IQogluZPkXj41+4jYzEZx9N7H7HvQfTRYqoY2UvEXVQZRkylJHzQe9R+GxjzOY7eUgvWbsAfwS1zRzHdM84FNenU09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEWH5E2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB52FC4CEDD;
	Fri,  7 Feb 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738891205;
	bh=/eQepd7t9WbqF+rO+C6ugvIzUBu5cUU400/lwirMgpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YEWH5E2pCBDkGC+GXfNk5R9MRcF4t4GkkyUfyJNi0ZugDp8gYAaa432EL9gQIAWw8
	 BjxkrqSPV+Te5MQ0ynW1pGbPg84Z0c+NqikeYlDGzID8bY2ga2rWi17TkopGXQr6KM
	 tGD9TJxPG2GlmGmCEqW70H8D9i5E096ym/cBKDdEw3TIpWmZSN9c9RVeMs0OXkyYoT
	 Dcid8YiiMWRzRuC+Q5nGB/WignYzbAGLQ8EM0J8JEk2ufMF2ByK1NilIdgdGNalRkk
	 wAOztIKrrvH09I4EgNt6zRClZT8/RWWSa7AmONR1oOMXV2Z7w/MxTbSwLsN2FdjeD8
	 Lvc7XbM9QH3rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF5380AADE;
	Fri,  7 Feb 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/4] enic: Use Page Pool API for receiving packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173889123353.1724081.15721162809855684305.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 01:20:33 +0000
References: <20250205235416.25410-1-johndale@cisco.com>
In-Reply-To: <20250205235416.25410-1-johndale@cisco.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 15:54:12 -0800 you wrote:
> Use the Page Pool API for RX. The Page Pool API improves bandwidth and
> CPU overhead by recycling pages instead of allocating new buffers in the
> driver. Also, page pool fragment allocation for smaller MTUs is used
> allow multiple packets to share pages.
> 
> RX code was moved to its own file and some refactoring was done
> beforehand to make the page pool changes more trasparent and to simplify
> the resulting code.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] enic: Move RX functions to their own file
    https://git.kernel.org/netdev/net-next/c/fe57762c6490
  - [net-next,v8,2/4] enic: Simplify RX handler function
    https://git.kernel.org/netdev/net-next/c/eab3726347f8
  - [net-next,v8,3/4] enic: Use the Page Pool API for RX
    https://git.kernel.org/netdev/net-next/c/d24cb52b2d8a
  - [net-next,v8,4/4] enic: remove copybreak tunable
    https://git.kernel.org/netdev/net-next/c/a3b2caaedeaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




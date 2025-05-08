Return-Path: <netdev+bounces-188844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEEAAF0B2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056841C24EB4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5B1A5BA6;
	Thu,  8 May 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5l5PemI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B51A3145
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668421; cv=none; b=iLei0r+fMfkJOV3Jo2hqafjGBGc0RJ9NiyyLzqT3yv7fX/VtMjfIGbdq/9lhs49m/s6BGFT3dXTW5F6PGBsSXL0nP3A8IGlDg8V/jKVx9wIc/r/26NCLzlMj1IG1kUmMFyxJSp+EvQBuaQLgILkl7kOF8DPF6zaPJicOek+c7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668421; c=relaxed/simple;
	bh=FFNR3BDxuiDWUjHtXh1ELs5jPJevzrQEhCKJ4rKQ9xE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JtIGbvQu5gsibrZeJYr8KRqZMFNqwSpwiG8bCeGmxFzvHK2KMHKWWw9GGVxAId6kww1TYJThQtU1gEW8dp7cWNATyij28gzHbmuEKKgtwt3sMU/OON9YyG/I+x6N1++ME3Yi9Q/061cfyngYMo/iwUyyxdT83Kl6Db8aYU9bRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5l5PemI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8C0C4CEE7;
	Thu,  8 May 2025 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746668420;
	bh=FFNR3BDxuiDWUjHtXh1ELs5jPJevzrQEhCKJ4rKQ9xE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W5l5PemIcmg0xJYyZk5C1BnflD/VuB6CIpPRN3nrphUOEepRLA4QWY4Sa5fMaOakJ
	 0tvBDoK3mG6UaZrIbgvWl8wc0nr+LiWdoI437AkFeFHjTDNB/0g/kmH0DC9Epnq9Ah
	 CzTnmf3UqgkcFa3ge0r2HzhpsXsLC2RKvEfTtX9Vu6wSSET81HrbfUkCuM7yxtjUvw
	 uSRfBeIv2jnxm4N8ch3RHzSHj3aI5FMOnLXfp9dRNsZiXei369A16Ib5QBzbnE6D2D
	 HJSzwizl++5tmcAFwm9OE2D5xM2YxvELapZo8Fyc+UgOT+NEXFXlSe0/xScE0Pe3Xg
	 Ki0aXZKRVaHlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB7380AA70;
	Thu,  8 May 2025 01:41:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] netlink: specs: remove phantom structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666845948.2418694.2377128711019323035.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:40:59 +0000
References: <20250506194101.696272-1-kuba@kernel.org>
In-Reply-To: <20250506194101.696272-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, johannes@sipsolutions.net, razor@blackwall.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 12:40:56 -0700 you wrote:
> rt-netlink and nl80211 have a few structs which may be helpful for Python
> decoding of binary attrs, but which don't actually exist in the C uAPI.
> This prevents us from using struct pointers for binary types in C.
> 
> We could support this situation better in the codegen, or add these
> structs to uAPI. That said Johannes suggested we remove the WiFi
> structs for now, and the rt-link ones are semi-broken.
> Drop the struct definitions, for now, if someone has a need to use
> such structs in Python (as opposed to them being defined for completeness)
> we can revist.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] netlink: specs: nl80211: drop structs which are not uAPI
    https://git.kernel.org/netdev/net-next/c/f22e764d7775
  - [net-next,v2,2/4] netlink: specs: ovs: correct struct names
    https://git.kernel.org/netdev/net-next/c/6c2422396d53
  - [net-next,v2,3/4] netlink: specs: remove implicit structs for SNMP counters
    https://git.kernel.org/netdev/net-next/c/ab91c140bea9
  - [net-next,v2,4/4] netlink: specs: rt-link: remove implicit structs from devconf
    https://git.kernel.org/netdev/net-next/c/720447bd0b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




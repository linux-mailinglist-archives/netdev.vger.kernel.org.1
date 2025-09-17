Return-Path: <netdev+bounces-224212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE8B82405
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763877AB70A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173672EAD0A;
	Wed, 17 Sep 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYu7Obv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9E2DF6F9
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151216; cv=none; b=hCRnQmLrNN/qtZwwDJOimPpmjFdFF4ArWNca7kbnzkMg0XPbB0g1C98BmO/V3XQbhmWsYddw7JVje4kBTlqLvFSRC9GcUmDQHM1YUUM1lc1USE49y0L+yE3hPunST+O/8ajQPh3DjasYcfPafkOVuygh0QVIAAzLESK/Pa9OFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151216; c=relaxed/simple;
	bh=u9T2acwp+te+yurpP8mW4WLrFqAnYauwDMSIX+Iawfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDxQ23HtuQQFwEk+8FgRjz68w43siydYKaXBl33KkWrbM1RcbO3qzBt+ccJ6Fj/vMZ1a2c5nQh2joJGnavcrOdbTU/JVr4qHCVpj6Qp1sb1acxagzVym/+G8efuMRPP9zQ1DySEqH+NIvoGsAhBxwWShaQ5gdBBQ3Hb5ozi2d9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYu7Obv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789B5C4CEE7;
	Wed, 17 Sep 2025 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758151215;
	bh=u9T2acwp+te+yurpP8mW4WLrFqAnYauwDMSIX+Iawfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYu7Obv/rUxUuq+bVvpQCpzBvaMq7ZOC3HS1ciX02GnXOW/pNxch03QQ/h7wC2YY9
	 alSOM5xCU2sk8imfX0q8ajlwEs779YfoIyOqJLFzsgUMcqiKzsWhbH3Sblk+so0iFv
	 e3xP3I56BCZ2wP2TNtemxWRgAbarpYGVhE5Lgb1HdT0JaRRGm3yqME4IgtoX51HpxJ
	 ibnP9jZOhKFDndR5ocXmLhWWv9M1g1uxolfo+VueeOpnIL2hvnJP/KMytIyoqRIed1
	 qJ7tcme+juAuYsBBwCshiNFVtj+BSYf6ehgH6rkXcGMLpxO9LvZh+OmXU5rxLBBzfH
	 Wrbk2Q5Elez1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9339D0C28;
	Wed, 17 Sep 2025 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] tcp: Clear tcp_sk(sk)->fastopen_rsk in
 tcp_disconnect().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815121577.2184180.6712486633909745791.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 23:20:15 +0000
References: <20250915175800.118793-1-kuniyu@google.com>
In-Reply-To: <20250915175800.118793-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 17:56:45 +0000 you wrote:
> syzbot reported a warning in tcp_retransmit_timer() for TCP Fast
> Open socket.
> 
> Patch 1 fixes the issue and Patch 2 adds a test for the scenario.
> 
> 
> Kuniyuki Iwashima (2):
>   tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
>   selftest: packetdrill: Add
>     tcp_fastopen_server_reset-after-disconnect.pkt.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
    https://git.kernel.org/netdev/net/c/45c8a6cc2bcd
  - [v1,net,2/2] selftest: packetdrill: Add tcp_fastopen_server_reset-after-disconnect.pkt.
    https://git.kernel.org/netdev/net/c/1fd0362262ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




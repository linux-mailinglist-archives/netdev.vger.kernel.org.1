Return-Path: <netdev+bounces-177490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D16A7050B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C28C1676DC
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4018DF8D;
	Tue, 25 Mar 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJz2h5mF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407B28DB3
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916608; cv=none; b=IQ6qTsfBR5hhhDUiIuJyfYZ0aPAplY7WGSlhgk+x+8XMTPIY8DDId/NVpDrsi1TGXGyCPKm2AZJcheAV5QMqFQ7J3jABFjMabrXVn1TM7YoiZm3+ebs+Ts0knIC4xWhmEiErEvwWakuf/j0OkAZ01Yy2fBPH+63QhOIzT6XPik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916608; c=relaxed/simple;
	bh=uL3EspvlpiPL6uipLgawtl/ag24Xfc72Wkn+o1KlikU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p6npbERwUBsKHlHRYH6O/blXaE1Sdb5jUTCWnnE5qNeMZ6pclRPd0x63kOVbrev76gyL4UIQzUiZxThfKBqth9Aa+122SONYqIlCZtbPMDA37bJd9nLOTOJUfRCgYjQsYCE2p6mcpFGkO0Ccy8eJjRe8oof993VhoehynFEA3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJz2h5mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9391C4CEE4;
	Tue, 25 Mar 2025 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916607;
	bh=uL3EspvlpiPL6uipLgawtl/ag24Xfc72Wkn+o1KlikU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJz2h5mF9L55ckzAsyrQQwKkAVpTFCbWNfSl0A0BqJy5Z3kkHZ7ZzGTvlN/d2Cq+8
	 5LeHAPSexEva+VQwJAj8UqKm00Z2SJD2yoPv5wlTe48H9tvx8Am4xALFpXET+AzVP9
	 5JUJrJDuG3pU64H4Tn4xjTiwAosuRhRakW6/ofXvw1YjgvykeeOFF+4lLjKJsrXuT0
	 /HzzaP4Z/i1cO8LGmxum24Ba/I8rAodEW2c/TlNpuf18vOVwIY5X5X7iglQBWICJwy
	 oL7t32bwvLXNtjupxm6+EIfn76bzUnU6OSa2KoZ7mI4k9TIeVv43CQ1OnoWuc1GzDk
	 0L5vE9TO3pi6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBF380CFE7;
	Tue, 25 Mar 2025 15:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rfs: hash function change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291664379.618403.16906116538409083829.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:30:43 +0000
References: <20250321171309.634100-1-edumazet@google.com>
In-Reply-To: <20250321171309.634100-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, kuniyu@amazon.com, ncardwell@google.com,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 tom@herbertland.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 17:13:09 +0000 you wrote:
> RFS is using two kinds of hash tables.
> 
> First one is controled by /proc/sys/net/core/rps_sock_flow_entries = 2^N
> and using the N low order bits of the l4 hash is good enough.
> 
> Then each RX queue has its own hash table, controled by
> /sys/class/net/eth1/queues/rx-$q/rps_flow_cnt = 2^X
> 
> [...]

Here is the summary with links:
  - [net-next] net: rfs: hash function change
    https://git.kernel.org/netdev/net-next/c/f3483c8e1da6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




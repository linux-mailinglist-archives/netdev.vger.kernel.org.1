Return-Path: <netdev+bounces-207612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D1B0803A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C606B1C273B7
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437482BDC1B;
	Wed, 16 Jul 2025 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve00XTBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0DEACE
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703789; cv=none; b=mmUiRm/bbNkv/dZifJTSXH7521zRkw7WtySXFHxwqg3bkLXo+KIuC7ljKmYL/KG91BLUj0fSnvoHWazYfL5uRR2HvjuD+VJIVkYT8OgEnjtQLoCIGKdc0nFpQ/7IXlgoDisDZ3JeY99n0ilc/TQHL/4JDtmTHzPjgPc7c9bFKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703789; c=relaxed/simple;
	bh=CcCxnqUSmOC3op1tpnPIltjY39lXB2Lt+QhfQeKhFIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvuBMo3ET12XQ54xrR8Avs0mwvSgEohkH+IV0SNfjjXPgW74EraB/I/s6ci/c1Y/18YJzQxndJOXMRXxhkj1Ezr1XAjWkpJIspM1kcgY4N/+u3dq7W32EKQYlLq33IZn2dn6NjtxhnQeyeKTVS7rr3M4lDsqpBgFqzPhkc7mM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve00XTBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819AFC4CEE7;
	Wed, 16 Jul 2025 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703788;
	bh=CcCxnqUSmOC3op1tpnPIltjY39lXB2Lt+QhfQeKhFIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ve00XTBxsA9RmYT0X1RkdUowaW/5ig3h9TjLIZFZuZZU8aS28Nh9J5mqvBrgdpzjY
	 9UGFqhacyYDTdby9KeF88D+LBhxosGuueoIlII9rQS5k990ek+zcSYxPE3/AV2w1MC
	 4auz9uKn8/HrQBcvxYACqLFCm8qm9r5MdbUwVT+R+oEwKRCbEEPi1ZlBkmhwKlyPwv
	 ROShHzIsI2OFRtIX5EQq3d0L+Qwim9IU/0CPRH4xLuW4q2FjgeF2BaAy9olSGHyS2f
	 8eovBRhqjMaB2C6rmArvoKfr6JTLsrH1EYSP+tb+IJuckJ6q+0tQY06fVbWHg8ZRE0
	 rKdWjBO3o5arw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD6383BA38;
	Wed, 16 Jul 2025 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: packetdrill: correct the expected
 timing
 in tcp_rcv_big_endseq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270380876.1341865.10440148648980422161.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 22:10:08 +0000
References: <20250715142849.959444-1-kuba@kernel.org>
In-Reply-To: <20250715142849.959444-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 07:28:49 -0700 you wrote:
> Commit f5fda1a86884 ("selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt")
> added this test recently, but it's failing with:
> 
>   # tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expected outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0.005046 sec
>   # script packet:  1.230105 . 1:1(0) ack 54001 win 0
>   # actual packet:  1.190101 . 1:1(0) ack 54001 win 0
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: packetdrill: correct the expected timing in tcp_rcv_big_endseq
    https://git.kernel.org/netdev/net-next/c/511ad4c26446

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-206956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D38B04DC8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0783F162FF6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7D20A5D6;
	Tue, 15 Jul 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENslAZ3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341E2A1AA
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546004; cv=none; b=RUMe2jBQvwZ7kO7jdRB8zwXJ/vDxS27dFTnesyMhfoUsyjt7+XVc1B/7UCzq5BGmB2++C8vq1T1D2ZY/0XR08Gc52Wbm9jXyEnOPsDcX3Pgl+Vtg9lAHunJXsp66zOpx+ibhF2J8BD2Vb/s9VdhVVeva6WFBfkP7UkW1+ymWF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546004; c=relaxed/simple;
	bh=xVlkzHMAO7rzB3vWO7NI2WlPngzV8bU/L9hGBFJpXsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E0Z9tIqxA1S5jBJ2WsHTI+CNL45BjxxGEgOHrtEECUTrBuBYciipOA3Caacn+w/ZHCa/1MlIMLQzrHkclrChVN2VkqnRMgx/5VpKG5vAkfMa3bgdHqWAZaJrbSfxMImHYbYbtIUxkkwRND94odT19uFGhaZWq3NDTseCT7Z2k1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENslAZ3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A417BC4CEF4;
	Tue, 15 Jul 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752546003;
	bh=xVlkzHMAO7rzB3vWO7NI2WlPngzV8bU/L9hGBFJpXsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ENslAZ3cWaXNmh1Qg2ZqaWorJiO5bBU8wMpD2Uw0rTBALF6ScAf1/WJ3SuTWS8XsI
	 u98CHKFu9lTnlcTmLGZuNwFYgTiwewm5h5CR5DXD8JlSOClL1S4daBVCc4UG+3Gr62
	 UP5QGGlRNkmXHAe6EE0GwaEKSFlY/Sv4QML1HWbe6BJcwrFJhLbTv90Yu9NNkN7CUQ
	 t601Ptjxdn4CO0wJcN3mlROpq3RJHi/K3ZRF1e4hxPJ7/XFmVxbHQzXpcamWDK2pZI
	 YXfl73W1NAqWK/UWZSWBQkoZ+q5mo7vzThBXrE81/kFBzKB6jayk9WhfCEiJhW45uN
	 BgzLmssdRbE4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD6383B276;
	Tue, 15 Jul 2025 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254602425.4061220.13616893735868328089.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 02:20:24 +0000
References: <20250711114006.480026-1-edumazet@google.com>
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 11:39:58 +0000 you wrote:
> Before accepting an incoming packet:
> 
> - Make sure to not accept a packet beyond advertized RWIN.
>   If not, increment a new SNMP counter (LINUX_MIB_BEYOND_WINDOW)
> 
> - ooo packets should update rcv_mss and tp->scaling_ratio.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] tcp: do not accept packets beyond window
    https://git.kernel.org/netdev/net-next/c/9ca48d616ed7
  - [net-next,2/8] tcp: add LINUX_MIB_BEYOND_WINDOW
    https://git.kernel.org/netdev/net-next/c/6c758062c64d
  - [net-next,3/8] selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt
    https://git.kernel.org/netdev/net-next/c/f5fda1a86884
  - [net-next,4/8] tcp: call tcp_measure_rcv_mss() for ooo packets
    https://git.kernel.org/netdev/net-next/c/38d7e4443365
  - [net-next,5/8] selftests/net: packetdrill: add tcp_ooo_rcv_mss.pkt
    https://git.kernel.org/netdev/net-next/c/445e0cc38d49
  - [net-next,6/8] tcp: add const to tcp_try_rmem_schedule() and sk_rmem_schedule() skb
    https://git.kernel.org/netdev/net-next/c/75dff0584cce
  - [net-next,7/8] tcp: stronger sk_rcvbuf checks
    https://git.kernel.org/netdev/net-next/c/1d2fbaad7cd8
  - [net-next,8/8] selftests/net: packetdrill: add tcp_rcv_toobig.pkt
    https://git.kernel.org/netdev/net-next/c/906893cf2cf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




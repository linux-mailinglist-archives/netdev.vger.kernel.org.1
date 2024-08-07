Return-Path: <netdev+bounces-116385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C394A44B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B9D1C20CED
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74F1C9EC8;
	Wed,  7 Aug 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsK2lM1q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4F1C9DEA
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023032; cv=none; b=DllY9NjGqDBKnpf9HNKX3Qs7Yf4/z/MIyqYBsr2pE05WBg7xF+Y8aL8MYWWmPSsoVymmWXbUXDsN4VvureHXYi+DQBh2dEywmo+PsBL5rg2E4WMzdAo/5PTuhC2kEKG7HckNI9nY6vb2+F6/EdUTRhaiTpdd4KW/o/bn45zZ1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023032; c=relaxed/simple;
	bh=3CR48rszCsXCLdSZPy3wnGJ7gEwn68BnFIqEut7jwBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fWBHcFAHw6WnXj5nWak1fJhw9unNlPwbOe3HxGrtGuJjHtUeNyk86MpUebq8Dq/IgRhLFTDJzt/QFAKpRUUCZHUnPcrlC4hUxo5NwnvS7HAdWO31yiVJ77LG/AZGMBFwcctj5Qgu8mokWc2M88v5Gyzm5KvlrLy8W3iTvqo15fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsK2lM1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72522C32782;
	Wed,  7 Aug 2024 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723023031;
	bh=3CR48rszCsXCLdSZPy3wnGJ7gEwn68BnFIqEut7jwBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nsK2lM1qq2sgR1QQ724PYF+sNh3f3AYxAiWKmWdidmc7PAyBBvvH9PJC/u4UfQFI+
	 Lhzik5tUDgFUmHpB3envxOEk5NnpPjHGWO/nv41d2JAAVoZZAQusVjppUBB2zQU3Fy
	 O0/ZH1L8dTgfuJmrMzUsWlphQjrFtgKEgFkvZwaRBS/7NRNz2BDlmcnRagC9sJU17U
	 fWvc6XMecsuCkxoZ31s6SlX1mAmfA1zZmawK/fWoxJs9D0B7gOuuKwCnKTp9JkF5Zm
	 Sy9QY7fHrVj90W9cFePjICWlbcYt7VD/urL7Ksi7Fc4My0dfc9XvWHkG4lVBGbmpHU
	 gx9qmx3/m3vHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E95381093B;
	Wed,  7 Aug 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] tcp: completely support active reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172302303026.2195973.4235240344711873074.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 09:30:30 +0000
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Aug 2024 18:21:05 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This time the patch series finally covers all the cases in the active
> reset logic. After this, we can know the related exact reason(s).
> 
> v4
> Link:
> 1. revise the changelog to avoid future confusion in patch [5/7] (Eric)
> 2. revise the changelog of patch [6/7] like above.
> 3. add reviewed-by tags (Eric)
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
    https://git.kernel.org/netdev/net-next/c/90c36325c796
  - [net-next,v4,2/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
    https://git.kernel.org/netdev/net-next/c/edc92b48abc5
  - [net-next,v4,3/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
    https://git.kernel.org/netdev/net-next/c/8407994f0c35
  - [net-next,v4,4/7] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
    https://git.kernel.org/netdev/net-next/c/edefba66d929
  - [net-next,v4,5/7] tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
    https://git.kernel.org/netdev/net-next/c/0a399892a596
  - [net-next,v4,6/7] tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for active reset
    https://git.kernel.org/netdev/net-next/c/c026c6562f86
  - [net-next,v4,7/7] tcp: rstreason: let it work finally in tcp_send_active_reset()
    https://git.kernel.org/netdev/net-next/c/ba0ca286c919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




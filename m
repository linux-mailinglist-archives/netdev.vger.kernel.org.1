Return-Path: <netdev+bounces-132217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CA9910A2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FBAB24587
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8C1DB357;
	Fri,  4 Oct 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKs7X6U+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3211D89F8
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069628; cv=none; b=twlLG+RQoLX35TzJkFip8XaXM26GL8yzGRYlc/uC+EPZJCqwjxarncE4yxN62aCt2Xu6CPN9WZcAR8AVZkYxgkzrlCBtbN3ulfxxKI1ljVgczYdojTM2RD9IfjfifgEdFtGH9Gcr5ZtevYzxJlcFwQ4FXmr4pjz7iXeDQlhE1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069628; c=relaxed/simple;
	bh=9DTQ7htQM/UY1VkQg+81LVY8BarPunBDB6UdWOk9MJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nwn3O1DjH4XXzuUw7GeihAkqVRpfjdPVR86/5FUFEadOV4aW64fywtUKlGNB+ZiaZmKzZEqkLKZ+5ryiSU8bPoTCj2x29kGjK2w+zhB40eG4+XWgrnv+VHgWvgUALOnX+SFg5e486xmb5b/d91CWcw1d7rkDkA238nyop7Jx4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKs7X6U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B20C4CEC6;
	Fri,  4 Oct 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069628;
	bh=9DTQ7htQM/UY1VkQg+81LVY8BarPunBDB6UdWOk9MJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iKs7X6U+/eCjcRkPJVgYaCUeAKY6vfSRt/k/6cJ3zk4pyLtIDL+aDO6RNEkK3r01v
	 2dFybGcZIAMOIkaHtW64P+GeFljKnUVUEw+NneAq9Ap5aZGxTGyfNlwZoI5gZBg0Z/
	 TzkOHap4T7CVlE94Ln/k1pU/a/1haYZK2ArJPCRtgiKVE2MMT5X5azAdIBUB/kC5rq
	 e1mXZt//inkNzTKHqVX92pT5kCwBbYcZX6CmYyG9Jz8obuQB0Lbn75mhxpKZM+U4si
	 mJ+1qOU6uBmDr5e3mSAQqnqNpaVkUnjyjJoF/CR16X5fodHVGPV8i58g5PQ3Hok2EW
	 GopSGnF8IQBqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3A39F76FF;
	Fri,  4 Oct 2024 19:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] Add option to provide OPT_ID value via cmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806963180.2712736.12630737288556684107.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 19:20:31 +0000
References: <20241001125716.2832769-1-vadfed@meta.com>
In-Reply-To: <20241001125716.2832769-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, willemb@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kerneljasonxing@gmail.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 05:57:13 -0700 you wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
    https://git.kernel.org/netdev/net-next/c/4aecca4c7680
  - [net-next,v6,2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
    https://git.kernel.org/netdev/net-next/c/822b5bc6db55
  - [net-next,v6,3/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
    https://git.kernel.org/netdev/net-next/c/a89568e9be75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




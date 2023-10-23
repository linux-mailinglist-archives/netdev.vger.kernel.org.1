Return-Path: <netdev+bounces-43387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8497D2D27
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E52B20C9C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863D111A6;
	Mon, 23 Oct 2023 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVtZ9/7g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B765125A1
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC45C433C9;
	Mon, 23 Oct 2023 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698051023;
	bh=17vbOo5dQNIH3oLhNYD3DBp3/e3o1Ha9oJg9U5OCJ+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVtZ9/7g6T+TeWNzeK8kMPDgThU1waUknVvvehdhewQM4PWj+/GkNFTt527v8thG5
	 5jusqhitwm3LmvBhz+Q6F3j6KgoIsO/4vxqeErMLfr4FL9wvqa4t7oQfKNaCdMdQBe
	 lxSxz/Oy5/yzV4z2AiM4cnSgdDzfYcsz/HkSRM7cTYLQ4rwHTq5pcQys/59nPpqjbv
	 X4IGRrMJQ6x5uaeWxVGM5pt6IuMZ7jN8qTSc9SKVQE2zjyVLpqRl9BoNE0h6yrRbo9
	 yZv/BOycXKiz6lgzlE12dDrx8ezF4tKgdxHTHc/qeo/Y/YSomEiTBL19dXHT+JUl87
	 6p9JGuwWykyvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EAB8E4CC11;
	Mon, 23 Oct 2023 08:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169805102338.2188.14410072725136198737.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 08:50:23 +0000
References: <20231020125748.122792-1-edumazet@google.com>
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com,
 yyd@google.com, soheil@google.com, weiwan@google.com, vanj@google.com,
 fw@strlen.de, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 12:57:35 +0000 you wrote:
> As discussed in various public places in 2016, Google adopted
> usec resolution in RFC 7323 TS values, at Van Jacobson suggestion.
> 
> Goals were :
> 
> 1) better observability of delays in networking stacks/fabrics.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] chtls: fix tp->rcv_tstamp initialization
    https://git.kernel.org/netdev/net-next/c/225d9ddbacb1
  - [net-next,02/13] tcp: fix cookie_init_timestamp() overflows
    https://git.kernel.org/netdev/net-next/c/73ed8e03388d
  - [net-next,03/13] tcp: add tcp_time_stamp_ms() helper
    https://git.kernel.org/netdev/net-next/c/99d679556d73
  - [net-next,04/13] tcp: introduce tcp_clock_ms()
    https://git.kernel.org/netdev/net-next/c/2a7c8d291ffe
  - [net-next,05/13] tcp: replace tcp_time_stamp_raw()
    https://git.kernel.org/netdev/net-next/c/16cf6477741b
  - [net-next,06/13] tcp: rename tcp_skb_timestamp()
    https://git.kernel.org/netdev/net-next/c/d1a02ed66fe6
  - [net-next,07/13] tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
    https://git.kernel.org/netdev/net-next/c/003e07a1e48e
  - [net-next,08/13] tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
    https://git.kernel.org/netdev/net-next/c/9d0c00f5ca05
  - [net-next,09/13] tcp: add tcp_rtt_tsopt_us()
    https://git.kernel.org/netdev/net-next/c/b04c3320885a
  - [net-next,10/13] tcp: add RTAX_FEATURE_TCP_USEC_TS
    https://git.kernel.org/netdev/net-next/c/3d44de9a10ea
  - [net-next,11/13] tcp: introduce TCP_PAWS_WRAP
    https://git.kernel.org/netdev/net-next/c/af7721448a60
  - [net-next,12/13] tcp: add support for usec resolution in TCP TS values
    https://git.kernel.org/netdev/net-next/c/614e8316aa4c
  - [net-next,13/13] tcp: add TCPI_OPT_USEC_TS
    https://git.kernel.org/netdev/net-next/c/a77a0f5c7f23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




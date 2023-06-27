Return-Path: <netdev+bounces-14228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270873FAA2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C61C209BF
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4949174D3;
	Tue, 27 Jun 2023 11:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222B10F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 11:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84088C433C9;
	Tue, 27 Jun 2023 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687863622;
	bh=BYNUTlfP7f+F3b9ynsAQKbHDC50G0DCol5Tq/g0IjEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8hZ+o1ZTaRX/xB01+g4P7JfO861D0RV5G0GltHcQ2Rz0zuG9lKMMrlUfL82cSBLX
	 WiiVBQRO12aUUVXYjm/NjzOn9U4EOk8L5j4iezAIEyxFRRftURYxADNU/QQWJQAFtT
	 QAFDFsVq7sBGY4LWu0jBjBx7Qmg+rOQK+6c/viFHvpQIzeK19feI18omLW0u0yXL26
	 DM0LZfflveOaGwqZXdf8MCPuc0ACDk6mXRGIj4RsoepLv66SSemQyXD68aBGQ+hssr
	 qDTrolVXIbEbsKTr6dM4gG9ixTHYF1cwgyZia8gOKS5rv+M3GsMLoFcTN3pvShrh0n
	 Yd5TESiq/jCyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6240CE5380A;
	Tue, 27 Jun 2023 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] lib/ts_bm: reset initial match offset for every block
 of text
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168786362239.16210.6293213397519316594.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 11:00:22 +0000
References: <20230627065304.66394-2-pablo@netfilter.org>
In-Reply-To: <20230627065304.66394-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Tue, 27 Jun 2023 08:52:59 +0200 you wrote:
> From: Jeremy Sowden <jeremy@azazel.net>
> 
> The `shift` variable which indicates the offset in the string at which
> to start matching the pattern is initialized to `bm->patlen - 1`, but it
> is not reset when a new block is retrieved.  This means the implemen-
> tation may start looking at later and later positions in each successive
> block and miss occurrences of the pattern at the beginning.  E.g.,
> consider a HTTP packet held in a non-linear skb, where the HTTP request
> line occurs in the second block:
> 
> [...]

Here is the summary with links:
  - [net,1/6] lib/ts_bm: reset initial match offset for every block of text
    https://git.kernel.org/netdev/net/c/6f67fbf8192d
  - [net,2/6] netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
    https://git.kernel.org/netdev/net/c/ff0a3a7d52ff
  - [net,3/6] linux/netfilter.h: fix kernel-doc warnings
    https://git.kernel.org/netdev/net/c/f18e7122cc73
  - [net,4/6] netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.
    https://git.kernel.org/netdev/net/c/f188d3008748
  - [net,5/6] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
    https://git.kernel.org/netdev/net/c/3e70489721b6
  - [net,6/6] netfilter: nf_tables: fix underflow in chain reference counter
    https://git.kernel.org/netdev/net/c/b389139f12f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




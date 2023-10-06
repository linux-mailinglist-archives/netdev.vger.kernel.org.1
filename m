Return-Path: <netdev+bounces-38534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E37BB56E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6521C20AA4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455DC15AE5;
	Fri,  6 Oct 2023 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbHlSbv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025F14F69;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0ACDC4339A;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696588824;
	bh=ooqbsMBFcH+zEx1BRZm017INGG3vcLFft8fYXG2wzk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PbHlSbv5lnpdBjnUnUrnYTjnmSbDCyTxW7Aj06g+rRrBCR96bjxML4ggfSutiYFg7
	 MZ72Hld0zAW69rP2YplGHBQHmyamkYpKHNJGxYBYaavxwXoH0AsxHn9ZbxtVEpH9gb
	 gEoAqxMaP4/vHh2gdChtEC+T5331Pwqiu9QNp2325FOapUxkgyWWfiBhIbN7rdhBDY
	 hOTxFt4MwJIxH7lAESM+ZCTU3nW3neobok6ZuKDX8XqFhAgMJuxj8hdkSMSC+6jL4F
	 e1pT0pHPZGjQJ0RQT6oe8sULk/31yCnCNYkYPdMWKUJcX2IdIh7xYs/1ZMKwEzlIOY
	 SMmHWm5WFC+mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 804DFE22AE3;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/packet: Annotate struct packet_fanout with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658882452.10984.9516643014205253723.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:40:24 +0000
References: <20231003231740.work.413-kees@kernel.org>
In-Reply-To: <20231003231740.work.413-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, amy.saq@antgroup.com,
 netdev@vger.kernel.org, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, syzkaller@googlegroups.com,
 henry.tjf@antgroup.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 16:17:41 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct packet_fanout.
> 
> [...]

Here is the summary with links:
  - net/packet: Annotate struct packet_fanout with __counted_by
    https://git.kernel.org/netdev/net-next/c/b3783e5efde4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




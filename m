Return-Path: <netdev+bounces-38535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3DE7BB56F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E421C209AC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9ED15AE6;
	Fri,  6 Oct 2023 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV/Kwoml"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222F15492;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ECCDC43391;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696588824;
	bh=KzIZOnElrqYjlyNCRhXZ/6dGkAdW/0c9GqOyBEpsNSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MV/KwomlYP3ethv7qRyi1HhKSpMRJQaqjQIimlbvulYa2t67ba9M1V8xuxMDFEQK+
	 EUGMCd3/3Crxija3JP/m6nR38DDF4vlcJQPIGm+8wuZb6SsbERYTKjo/DLa0brCfEa
	 xVPPzkd51dBirKbzrjrLZw66w2FQSrDUCwi3k7WOqZh+R5aLcvjI8Tbd9IZlU6MTTK
	 vpf3a4Rnasccgdlhb9HqiJcNArs10qxyCSnD/ZJqcct0BvAmkiCnrHzjvES95Do088
	 5NrycW+SLm5h6E4eI9F9Ouj7EnYkDG+BS1yxkf/S4ixWFRmVCNxAOtZILbJH7/2RfF
	 2Dct7quwMbVSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69844C595CB;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] flow_offload: Annotate struct flow_action_entry with
 __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658882442.10984.13385053977600897940.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:40:24 +0000
References: <20231003231833.work.027-kees@kernel.org>
In-Reply-To: <20231003231833.work.027-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 16:18:33 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct flow_action_entry.
> 
> [...]

Here is the summary with links:
  - flow_offload: Annotate struct flow_action_entry with __counted_by
    https://git.kernel.org/netdev/net-next/c/99474727d5d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




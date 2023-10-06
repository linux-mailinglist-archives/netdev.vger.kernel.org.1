Return-Path: <netdev+bounces-38514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE4A7BB485
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163728219C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E114276;
	Fri,  6 Oct 2023 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjIy7aAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D214014;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4712C433CA;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696585828;
	bh=mNdE47cVR0cIm8x+mu7MjDgzyED6ympkgUgeB0iaGbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DjIy7aAJSevjkK+a55ElHoUtPshXK0V5+gi+lsj1Da54fzbOPcloEZ4iQgRyTLaVs
	 LsWx4CMv9PwJqlyZLY1NikS2vqwJm+KxYxehRiB9kF7CzdS//b0WSImWSpupIdBsWB
	 odBUI4WS5I4tdDkeP64FB6tMGxJdDTTyol20JS+tOV0wg0gmLcQ+ftcME2eA3dvmVv
	 kQkhYg2spRCLtQIHUna9DFM4ui4lw6kbpqvc0SAiX3C1a3H6xE8pnJivj5g6McEfR8
	 L4ueUEzAgzl0qa76+Y2pHQxEgRSjOqRsGynCg6oe/Fd7Ndv/+LGOW9H+Nzc+kYaTzX
	 oYRx6a4HLiXDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 966F8E632D2;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: Annotate struct netlink_policy_dump_state with
 __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658582861.14501.9894166775052495116.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 09:50:28 +0000
References: <20231003232102.work.430-kees@kernel.org>
In-Reply-To: <20231003232102.work.430-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, johannes.berg@intel.com, netdev@vger.kernel.org,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 16:21:02 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct netlink_policy_dump_state.
> 
> [...]

Here is the summary with links:
  - netlink: Annotate struct netlink_policy_dump_state with __counted_by
    https://git.kernel.org/netdev/net-next/c/eaede99c3aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




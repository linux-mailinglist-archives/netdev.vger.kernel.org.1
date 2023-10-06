Return-Path: <netdev+bounces-38461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3A7BB018
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 117542823CA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338911C03;
	Fri,  6 Oct 2023 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vag4T/za"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A31855;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F3F6C433AD;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696556426;
	bh=GUAGPA2TNMtqx/k5hqRWI0g69x3ow7E+AEcpieFF9Ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vag4T/zamUJR4smsB80cnOswuxlstYz5FUWud/I1xaGmMV6FKlmymerOiYOHrb34T
	 flFH/gCFphNdKuMCsOFJeXfA06+Xvng3OYMLEvOZvoo7pNE2jbIYZCBN1y+M6Fm2Ef
	 3TzfesztHm3YD+MpXW4KQPeLTGA5WUpUJe9fsrYcmCTIgsWjWNQY2er+Z5daugBylH
	 iJXkx8n2w/MgX0h7mnjorTxq/0PQoXaWdqfxxRin8r7ywQ9qBQ0Rr2kOiVUTP9Z81R
	 VNM7GUcPKlBxpyF4GMcC1T44bGAkKHU755jNMlsXgRDlIGUYV8p14hPmrrSxHJbTbg
	 Z9hYi21mcDcBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31728E11F54;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netem: Annotate struct disttable with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655642619.20160.13590972818824999769.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231823.work.684-kees@kernel.org>
In-Reply-To: <20231003231823.work.684-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: stephen@networkplumber.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 16:18:23 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct disttable.
> 
> [...]

Here is the summary with links:
  - netem: Annotate struct disttable with __counted_by
    https://git.kernel.org/netdev/net-next/c/0fef0907d6fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




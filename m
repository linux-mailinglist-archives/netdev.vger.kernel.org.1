Return-Path: <netdev+bounces-38460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5337BB017
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A2DA028231D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D81863;
	Fri,  6 Oct 2023 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkSCdCCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0F15CB;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 451A8C43391;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696556426;
	bh=gqyrDN2+dTZupXeCUnU9mVObbWUJ6MuZQ0yvTbbWN1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkSCdCCSfYON8+xP7t8vbyzAu/msl77TOxUy2VyBRWtnH+rq5MmSlaPF4AjqaFan5
	 /bywZ4gFU0vgG3m9W5bwRHeZUBKJakMK6y1c89VYup75XaGNjCMXOYO3qlLWDV6uO5
	 lTut7jfV31ztuiB8pFwX/WaqsUOkOU8Yr/lS+437D3aUuWvzSfT4+lLYwHcH1TzV0N
	 f50kS8Q1RKyUIQPe0CVsSkzKA2U+nWcJ/tbx/eoWjexefWPPRrU3wQKz92gCuOoswb
	 l0H6PuMOvrdCDHPYCXK2iX6ph1sLS0VmcLQgdokiAbB678NgyXunWuWtU5MaB/xopI
	 B+sEmX2pAvGSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 272D2E11F51;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with
 __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655642615.20160.16106927648180643616.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231818.work.883-kees@kernel.org>
In-Reply-To: <20231003231818.work.883-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, netdev@vger.kernel.org,
 llvm@lists.linux.dev, gustavoars@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 16:18:18 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> nh_notifier_res_table_info.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_notifier_res_table_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/3e584e32b19d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




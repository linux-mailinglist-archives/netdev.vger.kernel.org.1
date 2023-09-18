Return-Path: <netdev+bounces-34638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6C7A4FD9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921631C20F41
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8923753;
	Mon, 18 Sep 2023 16:54:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42114AA9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F64CC4166B;
	Mon, 18 Sep 2023 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695056040;
	bh=5tqeR+4cq7gDLmyXjxnRKTojYZ2/r0NFh19i8NF67TA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Atl8ZCx1aWiAAw+bpp4TjlapT14IVO+embJSO6FJho0bFLFy3xxlICN+vCuZjD9br
	 sFXnNbq53tPoOTojn/wug/KErmn5iaUYl6VMQbI9fzGotZKrabinynvKE5oVTQ49Rg
	 XLCzB/fA9ci3CpTR/o0PtxUgP0FpLgYhoh7+nVz9UEiWWE9F/ot/8ZPJQJJX07DxYI
	 /pmYYeUaDVLW+cysP8u1za+suBxgL9zDHRWgrRDB681C1JdwpTuaFAaKWW1f13Oq9g
	 yXmfV3imgH0xzHu7t6R0wxHcBidhiLkjgmMR6dQTG12/oAK3lWgYoUXozT+m4JyH13
	 Je/bilViHWDYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE870E11F42;
	Mon, 18 Sep 2023 16:53:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] Makefile: ensure CONF_USR_DIR honours the libdir
 config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169505603997.6620.7032842292522262970.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 16:53:59 +0000
References: <156bb2949a091c8daa1ce1f4a8c6d7125eaad7f3.1694807902.git.aclaudi@redhat.com>
In-Reply-To: <156bb2949a091c8daa1ce1f4a8c6d7125eaad7f3.1694807902.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, gioele@svario.it, stephen@networkplumber.org,
 dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 15 Sep 2023 21:59:06 +0200 you wrote:
> Following commit cee0cf84bd32 ("configure: add the --libdir option"),
> iproute2 lib directory is configurable using the --libdir option on the
> configure script. However, CONF_USR_DIR does not honour the configured
> lib path in its default value.
> 
> This fixes the issue simply using $(LIBDIR) instead of $(PREFIX)/lib.
> Please note that the default value for $(LIBDIR) is exactly
> $(PREFIX)/lib, so this does not change the default value for
> CONF_USR_DIR.
> 
> [...]

Here is the summary with links:
  - [iproute2] Makefile: ensure CONF_USR_DIR honours the libdir config
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=946753a4459b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




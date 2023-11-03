Return-Path: <netdev+bounces-45874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FC7DFFF7
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0512BB212FF
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30467CA51;
	Fri,  3 Nov 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwxr5Ynq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE258C03
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938D7C433C9;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699003223;
	bh=/E8aN2eqf8+9+fQQLHb6DQ5BDwl4MybdpCu0nul9xiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qwxr5Ynqu4Y1dPkA8/LQUHD1izqztkB/TEnEYhAf3cXEyW2dtVTph0sBvSlVWbftO
	 +NgiIEQXB160wlNcoqDK59ErEkaiOEJ7KQTJjMB5ea15QN/vKx103GJ1QS/9AGRpZV
	 2fEU2jpmVWPDzpzkmf1fKxsczzGUHDvHkc9CIHgkhczwEdzsrGSLauQvD1F5NJgea0
	 VE/0RrCAVmgl0cqZGTu3JksVoQi1kE82wjhauGMPymhj7ml7iDFuALiCi4URApmnm1
	 T9g3EmUi1K2hAy9nA3OmL3mdnZa4uu5urEOGjkDlJo3y0A6LGXNP7PbQlaCIbQIfQm
	 vQmLH20WokGsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7733FE00085;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Fix termination state for idr_for_each_entry_ul()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169900322348.11636.17439163150143289110.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 09:20:23 +0000
References: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
In-Reply-To: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
To: NeilBrown <neilb@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
 willy@infradead.org, chrism@mellanox.com, xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 09:53:33 +1100 you wrote:
> The comment for idr_for_each_entry_ul() states
> 
>   after normal termination @entry is left with the value NULL
> 
> This is not correct in the case where UINT_MAX has an entry in the idr.
> In that case @entry will be non-NULL after termination.
> No current code depends on the documentation being correct, but to
> save future code we should fix it.
> 
> [...]

Here is the summary with links:
  - Fix termination state for idr_for_each_entry_ul()
    https://git.kernel.org/netdev/net/c/e8ae8ad479e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-13253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F173AEDD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0D82818F5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089617C2;
	Fri, 23 Jun 2023 03:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEE801
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5752FC433CB;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489222;
	bh=KfwjvmV5ejMTSyciHWdK1aLZdnKh10wfFkwKw4zVjnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjKuxmwPzsUpnRrUeHjOyk8Mom0nqgqtMix2E797mb3zGWrE/unhWSd89bM0+IsTs
	 GTbhIR5ChaH1VmhpyyX/fdkOwZHCDa+CrlUvcZ/Q2m3oWpyTt1/r6Yo+09860ozJ6U
	 gTHiSqTmLWjLD8CnlcW3RtNgfaeazZ0MBskXkp3cCs98V/Mb+WgotDadTJpZNHtRNh
	 tzCONnbXesYhUlABkl5JtWK229akCd90n19jWhubVfPdhEdhoPw0hq3FrcXkWTeYuF
	 QFphEd33qJixdQE0Pr9id8t3+gq0lu6qMa8hB01bTCOZVkGn2vL/t4+68bx9yUaoZo
	 rQDvyFYlusQLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DCD9C691F1;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional modes
 for netdev trigger
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748922224.4682.16332057188108766374.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
In-Reply-To: <20230621095409.25859-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pavel@ucw.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 11:54:09 +0200 you wrote:
> The QCA8K switch supports additional modes that can be handled in
> hardware for the LED netdev trigger.
> 
> Add these additional modes to further support the Switch LEDs and
> offload more blink modes.
> 
> Add additional modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: qca8k: add support for additional modes for netdev trigger
    https://git.kernel.org/netdev/net-next/c/2555f35a4f42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




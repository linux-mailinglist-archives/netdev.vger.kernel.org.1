Return-Path: <netdev+bounces-43548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4A7D3D58
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D1B20D6D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5D1F952;
	Mon, 23 Oct 2023 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Hr6ADZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095901BDC4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96679C433C9;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698081623;
	bh=JOA6qHHnvI5BhBR7T2FHV/tmX7qw+xAjO0ubpz6pRL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+Hr6ADZFXXYW8/EaKdHxoe9Tvu2IQ83/ilahJM+fPppjaGttZbkOziTVEXUp9Cml
	 Qni0/isRGw7POf7tzCO+QvWxNAFxZkys6tosQLRJelRrIcN4tvwoTGe7LWnWOu2jCA
	 cK6lKjO/BZQggofUJsH1ArmoedRTn7z9C0lNwrCtokdKSba4okTvpqCRwwXS9dm+aw
	 A77NnUginp8IiEKx08LkgDgB+ILgVphCNSRc1RMMY6F20vXrgxB6igksLpKGqsLK6t
	 x9kpl1SYdFT7qg7M0KGFS1aR8x76U3VSFjWLngNVueAyfe5wT7zcrQVlddaIzSakwi
	 MVlytOz3HwTVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79D65E4CC11;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: change spacing around __attribute__
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169808162349.28677.5756404188521560663.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 17:20:23 +0000
References: <20231020221827.3436697-1-kuba@kernel.org>
In-Reply-To: <20231020221827.3436697-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, jiri@resnulli.us,
 donald.hunter@gmail.com, chuck.lever@oracle.com, sdf@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 15:18:27 -0700 you wrote:
> checkpatch gets confused and treats __attribute__ as a function call.
> It complains about white space before "(":
> 
> WARNING:SPACING: space prohibited between function name and open parenthesis '('
> +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
> 
> No spaces wins in the kernel:
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: change spacing around __attribute__
    https://git.kernel.org/netdev/net-next/c/c0119e62b2fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




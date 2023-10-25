Return-Path: <netdev+bounces-44125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EC7D6716
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231AA281A6B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2AB2134D;
	Wed, 25 Oct 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMMhqh7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB220B00
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5B43C4339A;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698226823;
	bh=R40SvOBaAzyQCF+k5DFHQ5r8C9Pe2q2/Ct1mYoAEFAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMMhqh7lTesw1IPWDMNbczynMhRjX8fJ2jaKAg98AxuPiEywWwJnt5ceVAmKBeiz2
	 wO2G6iTmdCSU1RCh+rn+1WjuBLyVYb0ZV7nOtD+Jy9r4S/80u7Izg8HN2oqjxclwOY
	 WeGGuFmcaxQ7+ul0MYN8vVuNGgfIydWKKY4T++gB5T96QWfNgP2V6rEVSyBWtNTfD0
	 Q9K6xXStf5bzHZlUeMCzRQe1bGJiQ+VEvUpqH7d+alNvOvVdweeDk3ktMW4xJ/8zhJ
	 bEGvukAfZMX7Sr21vQ1vhjEDdT+A+o23B3QyI2UyMXfiyxft9GlTT/msSR7OGsEzE2
	 aXEtLT+98nOgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD944C00446;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] amd/pds_core: core: No need for Null pointer check before
 kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169822682383.18837.12141561827417952269.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 09:40:23 +0000
References: <20231024182051.48513-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231024182051.48513-1-bragathemanick0908@gmail.com>
To: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 23:50:51 +0530 you wrote:
> kfree()/vfree() internally perform NULL check on the
> pointer handed to it and take no action if it indeed is
> NULL. Hence there is no need for a pre-check of the memory
> pointer before handing it to kfree()/vfree().
> 
> Issue reported by ifnullfree.cocci Coccinelle semantic
> patch script.
> 
> [...]

Here is the summary with links:
  - amd/pds_core: core: No need for Null pointer check before kfree
    https://git.kernel.org/netdev/net-next/c/d0110443cf4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




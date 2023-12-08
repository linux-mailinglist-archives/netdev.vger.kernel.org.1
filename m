Return-Path: <netdev+bounces-55403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB9F80AC73
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FE2819A1
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28C32185;
	Fri,  8 Dec 2023 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUjDBMGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E541E12B6C
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 18:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A9FEC433C9;
	Fri,  8 Dec 2023 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702061424;
	bh=sOzOiCooIHWv8JwLcQOBgic7AA/i/2hi5qBpmG99UAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OUjDBMGBJIUBC6ckaV9Gmqu7y85/wcFFGAMz0R00eJ9mf/a5NWt9KcjofdBXnXQB+
	 qj28jcFigGux3yc8FWmKsS2iQycF9hKj0LxjP6kPxVWs7avWpd5htby0gMABGNBOGJ
	 zTOvmn/BoMftYVhSRfqN5QuOK59vvp29g7s38B+mNJxdnobhcqPTnMkOdyBlHOJjKz
	 onX836BQUzUueQR8m5SrxkqSfDb33I3xFtxa1m+XyFSeysM4k48qgj5HGBOxmyIqwc
	 zV8TrwL6+WaCJ8hJn9T+Jlob75GjvWPThThZJczI4hu5SoejK68TWdi5ukl+W84rQD
	 nPEAA3kRrdsvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F572C04E24;
	Fri,  8 Dec 2023 18:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] team: Fix use-after-free when an option instance allocation
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170206142405.6428.2927511697282770717.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 18:50:24 +0000
References: <20231206123719.1963153-1-revest@chromium.org>
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 13:37:18 +0100 you wrote:
> In __team_options_register, team_options are allocated and appended to
> the team's option_list.
> If one option instance allocation fails, the "inst_rollback" cleanup
> path frees the previously allocated options but doesn't remove them from
> the team's option_list.
> This leaves dangling pointers that can be dereferenced later by other
> parts of the team driver that iterate over options.
> 
> [...]

Here is the summary with links:
  - team: Fix use-after-free when an option instance allocation fails
    https://git.kernel.org/netdev/net/c/c12296bbecc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-48539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5C7EEB7D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 04:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9CB20A4E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2339448;
	Fri, 17 Nov 2023 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfNLBcqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB02112;
	Fri, 17 Nov 2023 03:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF577C433CA;
	Fri, 17 Nov 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700193024;
	bh=Bz+3K/MHbKM0UUanhKp7PB+9oqrK2L5Zjsk4+1NL9Bo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfNLBcqL+DWJOD1qevRxUkOoeXqIm0ZASOVL5miRebNHEvaDvsp9cbjbOAi1rkDg8
	 6iJ8JS6s9kbIhiy/vYTsIjrT8k0kzfTEjOX6D8aI1JzEMXvUvuOIbQTTHy1Ouv5gj5
	 umKsbGyU04Vu/tQ+yqtJhg3pBkID+ZpJiHZiXuzAhZxGZIkYT0oe2QQK05fsJTF57P
	 75iyYkd4SP6y1DqfBvrDY5aPsVLtjno7ebdCBtXpx+eKpywtlCVCg8cbJKmf7zPVnP
	 6zgpy1BFBryufT9O3SO1Zm9E5IjLxYnpXCdpDlPjsU3W2TttvjLtrycPUCK179farv
	 Nl0SlOtUPdXCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5F11E1F662;
	Fri, 17 Nov 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Add netdev subsystem profile link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170019302387.26330.13198114627054170018.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 03:50:23 +0000
References: <20231116201147.work.668-kees@kernel.org>
In-Reply-To: <20231116201147.work.668-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 12:11:51 -0800 you wrote:
> The netdev subsystem has had a subsystem process document for a while
> now. Link it appropriately in MAINTAINERS with the P: tag.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add netdev subsystem profile link
    https://git.kernel.org/netdev/net/c/76df934c6d5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




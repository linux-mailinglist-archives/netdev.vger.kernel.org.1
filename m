Return-Path: <netdev+bounces-68955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B4848F26
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA81C2832EA
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDBE2263A;
	Sun,  4 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVghoj7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5222EE4
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063027; cv=none; b=nheqQnLQtIw91jSxU2CEKbWvb3lDv4rtJXZU5pxw6VeNnQ8CCjheRMoODoZoGmnaFiDCHE7gsMygEB8nMC2dje9i++cVGg8DNlqWFrjLhaToOcfVkXYkKdoDr4N7rNvp3x6nIG4vdrs7LMRFm6zlhy2GeqNwqmXWlJ/s8VHXKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063027; c=relaxed/simple;
	bh=NlF784sutNDEI4Vxk0rbES80OQjhQL+fZMflQHbjrp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Znu6FiyKl+lenTBi+0k1ggmI0g0vmB/SgFnHYcxI5SewINoIW5lEq7VHOj5LwebnZx+Q5zV4FNEzuBGDrQFWl6IO8CzUTTLHV7/gOHt00Cj938GWvDi/hBbqt6ke8Jnyv/hUmYyUU1ngnlOEgscbqePQC2fu5SqHa9+Kz016Nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVghoj7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74ABDC433B2;
	Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707063026;
	bh=NlF784sutNDEI4Vxk0rbES80OQjhQL+fZMflQHbjrp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AVghoj7Dn+Btl07BrCbTxr2pH6PupxGJ9X77yp5Z1mCejd5BBzVDcpgdWlcVBdRAV
	 Eil603AlEJ2AaKMjGHe1cdIbSlQyyzkGGzyW+V3L/pd0mRfV0oXlPKf007oKeDEMyf
	 tmoDobIFuymZZSO+vzSfJxM2Z464yAfUXhwe57VTLQWCcTnzKGPWKc2bfN0++5p6RG
	 s0HlE3Sv30V17GX/h3aYFzLu4SdQM9gNY5zUB+a9/p/4AXFtZjO6YWJkkT1ARw+WWg
	 WI+lx/fNwsqXJZrH+r+BQ7As2IRRcwKoKZWewcp0H5zZm7xFzG9Xt+HL6cwGZT8XAK
	 DDFRfL56s62gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E7DEE2F2F2;
	Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: make dev_unreg_count global
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170706302638.24202.6356279353998672819.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 16:10:26 +0000
References: <20240202101106.342543-1-edumazet@google.com>
In-Reply-To: <20240202101106.342543-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 10:11:06 +0000 you wrote:
> We can use a global dev_unreg_count counter instead
> of a per netns one.
> 
> As a bonus we can factorize the changes done on it
> for bulk device removals.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: make dev_unreg_count global
    https://git.kernel.org/netdev/net-next/c/ffabe98cb576

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




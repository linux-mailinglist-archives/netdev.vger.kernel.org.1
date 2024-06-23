Return-Path: <netdev+bounces-105922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97A913925
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6344E1F216D1
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E07E574;
	Sun, 23 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS4T1Z/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F652D052;
	Sun, 23 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133830; cv=none; b=QVf73D8soyMsRzFCvQciHIDbNfqz0MS0QC+oywvxYCjDv8Sq9/KtUEUjIwfhSw0HdOjwe78DIVQWlZBzDt6d4Mp/ni5O021/hFQOe+JDjIQEZrwKd93L653hUfnRTEiY9ADvj17oTN/AEJRb7rUT+9IgzLnMDWtQv3u0fSgxLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133830; c=relaxed/simple;
	bh=7SZK06ovOGekuRqAjxHVE88fBd89NCL3FaRR8dCne1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5oolLxGypm73AqU7wuE6hWFdf2sHbFxZUaQHCFuirdQ0mae3jxHh6Wg9MTvkpseT1o9sobIY5p0XOGHjM8jhF2CfkPXh8YidtS5fMPVNZXM86lPIapJHB4knSz/ub4joO3o/5X1ilQFbkdrCVGSTfmsYzZ/Pe90iz9Wl1BuVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS4T1Z/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09827C32786;
	Sun, 23 Jun 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719133830;
	bh=7SZK06ovOGekuRqAjxHVE88fBd89NCL3FaRR8dCne1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dS4T1Z/PwjVzy6e5T4+GfqsRn3diV0STopJXy1Nb9zogR+Q0+WUNFelDUuhZtrdIw
	 Nklc34P0iw6mU1gYVshmvQdQYPMkVnuPs3FOQIU24/3fKyBDByQSLRhaBK7wjdA2sY
	 9q/OvzmsCtmhFzlflA7Oolo4saw9p/goTnKF5Fef8oguiVzfGnLuXPHm6LXi6Ux0lj
	 ysqYCLvsSy/Sd0zczaWFD/dlKp+Buz43Y2+aX/ihPHhqeqiCNcC4/hQDy++yRlSMn0
	 b7omFEIRluVkK2g0u/RvkZEtGYgx++HGG8fH7jqnljUJ7L/GJuYTDMcAfiotvt4y8F
	 cA4JNZKl0iukw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7AA8CF3B81;
	Sun, 23 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: Fix pse-set command attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171913382994.30896.14541719183636030634.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 09:10:29 +0000
References: <20240621130059.2147307-1-kory.maincent@bootlin.com>
In-Reply-To: <20240621130059.2147307-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
 thomas.petazzoni@bootlin.com, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 15:00:59 +0200 you wrote:
> Not all PSE attributes are used for the pse-set netlink command.
> Select only the ones used by ethtool.
> 
> Fixes: f8586411e40e ("netlink: specs: Expand the pse netlink command with PoE interface")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] netlink: specs: Fix pse-set command attributes
    https://git.kernel.org/netdev/net/c/42354e3c3150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




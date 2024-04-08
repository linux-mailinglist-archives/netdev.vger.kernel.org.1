Return-Path: <netdev+bounces-85678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05AE89BD83
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C931B222EF
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D05FB8B;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oytWGUVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A4524DE
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573427; cv=none; b=OjKgdN0bFAbnlXPBxmZ4CgefhUWfMS3E/+rvJJq4Eq/9HtrFNYhhiLMMPNEzBRtQMLLSiCmb6istSv9Wa4oRjZkoNLFtVHAVs2Y4uNtUa9iAlfSTgBM3QCNvtfZJPU/PEnkgkanSu9Wrgy+7xd8wAJwJ8qKTDyRtYX0q/CTD39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573427; c=relaxed/simple;
	bh=tSLu4JFbNcsTulQYhIAN1Ya5xJF/tkz0vkFXRq+Di2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qGWaI5bOM+Fk41bXsqq4U+KZnynH9rzFMMX20uZyd2Sp5qj3P8pUsZlbtwuYjNwY59pT32LTJUhhk+FYG2S5l79AnG0WVRytKPT7Z0nqO7UXHURTUWUOxR1bQb302fabsXW61pVGhQkXPwPjCHeX+/cxruNnXX0rg+JSnH9vm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oytWGUVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67033C433F1;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573427;
	bh=tSLu4JFbNcsTulQYhIAN1Ya5xJF/tkz0vkFXRq+Di2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oytWGUVocblv+BEnu1Z+7JkA7qJhTBxWpw7mHa4DKx+KMOHDfMJmHHDprLsGP1/Yh
	 v8Z0yq/VZvBk6K4cMGZ0xWfLra0HG0nOR2gUTVcs8vuu/tBSgfq3hlZB8p/G3iJOh1
	 qHlYEMYZrO+u8usvJlEZrnxRGszdTM+deBP+GwtkIKthk3QgeThJ2GM9s+d668C2ha
	 QeyANLvbj6om5XtZy0N9Sm+DTujVlAdTnfm3dunoNyywyBW0TIwCLl+yGNc1nFbKRC
	 gqCaBlre5m90jreG8gdGvI+0fAaFRETmaVlJxUdrELbx3RYyimNE1KeWK/W/wI8ba5
	 LNejzAYVxoEoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58D4AC54BD4;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: more struct tcp_sock adjustments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257342736.21044.8786404384177962110.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:50:27 +0000
References: <20240405102926.170698-1-edumazet@google.com>
In-Reply-To: <20240405102926.170698-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 10:29:26 +0000 you wrote:
> tp->recvmsg_inq is used from tcp recvmsg() thus should
> be in tcp_sock_read_rx group.
> 
> tp->tcp_clock_cache and tp->tcp_mstamp are written
> both in rx and tx paths, thus are better placed
> in tcp_sock_write_txrx group.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: more struct tcp_sock adjustments
    https://git.kernel.org/netdev/net-next/c/d2c3a7eb1afa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




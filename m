Return-Path: <netdev+bounces-45673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC77DEF2F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B0DB210DA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1FF11CB9;
	Thu,  2 Nov 2023 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLQ1IDyA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C1125A3
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE75C433C9;
	Thu,  2 Nov 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698918628;
	bh=Jg4InaDJnH/oeoyaPxpJdEYyiTiu4StA4+931M+X2yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jLQ1IDyAL59sFCSMvwjxPL5S1zVZ1hQ17kJxZYsRNVlaQnrD4vX3+SpV6s0QkvS6T
	 kyZl56FuS9cIrp0itdLppgwqJ0a42Zr6SnP+vu7Eo5ui/k03+ztthAeYEnKH97MK++
	 EBtpHRrK5dwoJA/HqLEG3FObyV9b3Ds57vR8wcEiMtexm5GSQ6SJ1pz7hTBjkBCOK6
	 kPyLFyIo7Dh8rdKXiJ+HdvjV6lJBFccGDl+hI3cSjoL4iitAZpUg939PfANzMwoVEs
	 E+xMwPbBihqvPfyTgPKq4RIJwm80RPrEB7aaHObl5hWv3Jaiy4yniBRgFKVZeWk1KG
	 H9oQBkNI1Nm4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8721DC4316B;
	Thu,  2 Nov 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] octeontx2-pf: Fix error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169891862854.20867.12440563910508147071.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 09:50:28 +0000
References: <20231027021953.1819959-1-rkannoth@marvell.com>
In-Reply-To: <20231027021953.1819959-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wojciech.drewek@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Oct 2023 07:49:52 +0530 you wrote:
> Some of error codes were wrong. Fix the same.
> 
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] octeontx2-pf: Fix error codes
    https://git.kernel.org/netdev/net/c/96b9a68d1a6e
  - [net,v1,2/2] octeontx2-pf: Fix holes in error code
    https://git.kernel.org/netdev/net/c/7aeeb2cb7a25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




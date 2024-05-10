Return-Path: <netdev+bounces-95292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA908C1D2F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B01F21D7B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941E1494DE;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPnLUYOV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF1171A7
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313029; cv=none; b=PXfyuIYOQpK/qAxR9/M7C5ehmi2YY+M8Gp6Gnvf21p0vk+/QSNqSnmOeWMLXYNga3PoP4BwP/uQ2f/EowFL7PPUxarlwRHSfPxxUgkx/eNiNSCSwYdlpFAs7L/7cULEb1c/01P6k3NBbJcCHAzL6dtSBBLMH/vxn+32E9mLxFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313029; c=relaxed/simple;
	bh=bA1+ZUycYHaEgMG18qKAK3fg7lA37hfJrSFo6idO7jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S97ncL3T79Yw/uyn3EBttr++pAFGEy8tKq4uzbezjGu9fzG/7FQpwbOPpy+zzKPq525UbBEmS/t2P3VKVzw6HhJI4UPV5fI3lfVLGifYDXumKnUaqS7fBvHuFWF2rjzhCLVQQSS6j2eTyIQ5kMjLwJWDnrYqL5Ws1VEOP5XGe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPnLUYOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2661C2BD10;
	Fri, 10 May 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715313028;
	bh=bA1+ZUycYHaEgMG18qKAK3fg7lA37hfJrSFo6idO7jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPnLUYOVAcGh0bv5Dw5J+XZBzqOoxk97umFTsVjL8olkkoxVZu8pMDUAaKFCFifw5
	 qk2poM1CfMolJId9Kw/bL5HJKyyg1BzO4VY81Oe5kyF6uMsXZpCftFy469VQWCJWYa
	 Do5ICFgMC+/I98+NDoSXhVV/eEywoHFpLHwRfi6CQeHyu9bd4xUgyzM1dmyOf+1a0I
	 eoTemOdQf5Kyhg4SIr4hbO586CR20FdRqWCtZxUwVHfXE9+g7srn0TrrMUNin2AP4G
	 Fjdia+qOlG9dn0rfb5261BkOitWI8rPGwMOWe0T1f75PGJt3XtELgcX8Fyp13Ji8Gt
	 kJrY9SQ3L82gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9434FC43330;
	Fri, 10 May 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: ocp: fix DPLL functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171531302860.29493.6765049351681307861.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 03:50:28 +0000
References: <20240508132111.11545-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20240508132111.11545-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, jonathan.lemon@gmail.com, richardcochran@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 13:21:11 +0000 you wrote:
> In ptp_ocp driver pin actions assume sma_nr starts with 1, but for DPLL
> subsystem callback 0-based index was used. Fix it providing proper index.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/ptp/ptp_ocp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net] ptp: ocp: fix DPLL functions
    https://git.kernel.org/netdev/net/c/a2c78977950d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




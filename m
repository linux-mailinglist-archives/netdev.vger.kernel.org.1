Return-Path: <netdev+bounces-226141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85510B9CECC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84511BC3DE6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA912D9EF0;
	Thu, 25 Sep 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctu08FGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE42D97B6;
	Thu, 25 Sep 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761435; cv=none; b=eTxGfn888X7IxDXIEC/pgRRoRlWejpcR7a9+VB/jI4o8nF8BsnF9udlwyd2y6/lJFuf8RjQPvIDtLOJlscSnIE70jCPynAEOuxTSXHVlLKUY87MJ12Vlo9ftl6vdbiOIrQ7QSGOYgQ/EQurY2fngCHs+xCoFooC7ko0qZysX/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761435; c=relaxed/simple;
	bh=ltaY4wgFPQ1cYd/NaoRRIjnK/lreQHuaJV2zykfI9Ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tvvpzgc4xIpUoRtnmc+zrzRzWAUJMXVQv/tMa/GwezCvkoHf5dh/Qb7dG6/3vZ4A2aRZ6TfNWv6eCuTv9ZmJGAVgeIQwXL1di4L2N7xnHFeEZ4vy6l6J00u3pTaGh76RdPyDRx+mlBMROptT8ikVFcGQWIIQUhZ58aXI0w6qMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctu08FGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1643C4CEF0;
	Thu, 25 Sep 2025 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761435;
	bh=ltaY4wgFPQ1cYd/NaoRRIjnK/lreQHuaJV2zykfI9Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ctu08FGeJa2gUJ/UQljgTD6hgiTOdOtgnwxjrdwojfcisoF5b551ntutZNTEeEB04
	 3JUco9wu5CrlBPE0OvBN0aGO+yqv0irEbZ0+XfjDRe3g3xYF1Xt6403vgcX5c+G027
	 2bcyDXjHPQPxhiL3yXWRcUhDVtneI9k+lgIK39G6MyplrgPq7PJA9qX3fvyrtPtz24
	 KhFyGigQ2atjuK/EL3UMbTPkqpyEhsUxcMn7gvM01EGyIUY1NagHUDg/5JD5XqLwRA
	 T580I4Tk0dKqLXPQcvH010SUBxSOTIyvaQEkqBlZ4Mo3wp5Z3x2NPkae8vrIPSRiek
	 6dX9gFXL6mB9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA339D0C20;
	Thu, 25 Sep 2025 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] tls: Avoid -Wflex-array-member-not-at-end
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876143099.2757835.4273019318269328907.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 00:50:30 +0000
References: <aNMG1lyXw4XEAVaE@kspp>
In-Reply-To: <aNMG1lyXw4XEAVaE@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: sd@queasysnail.net, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 22:45:10 +0200 you wrote:
> Remove unused flexible-array member in struct tls_rec and, with this,
> fix the following warning:
> 
> net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, add a comment to prevent people from adding any members
> after struct aead_request, which is a flexible structure --this is
> a structure that ends in a flexible-array member.
> 
> [...]

Here is the summary with links:
  - [v2,next] tls: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/b6db19d1df8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-94765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815988C0987
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35431C21264
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E20613D241;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxP8awr1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22213CFB7
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220031; cv=none; b=EVb6+9yDo2JpOOXCVcVnBWjWLt08pBS6dAsczMUqTsEaSpuyJPtYzIxl2+dEYGm24zq9i402brFqni4L9vcGimnN+QDiwl0CJDuHSFh/pOaS9DstVMdSaa79llFnLGh73RSlLiEOB2clfhcHXV2PK7zLV47ooW4yILgDN4/P5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220031; c=relaxed/simple;
	bh=PrtFRseENOuPJcfDJ+9a0Ly2swQ1fYsl4/sgaerCZfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVyURrqkFKyN+vwaKT1yFnOK6JcszP1tEcF3oZ+ALjNU+bixhxcTflVusgUFO0F/tynah+0Rcppxrl14wReOD90zbPuoL5UztmeGJdM4jhXKP81P8yhY9WY1T4hz7Yc58DGQvNPaUPmds8ypgL3Abd59E1534AkX4+1IrfaadB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxP8awr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1A50C4AF07;
	Thu,  9 May 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220030;
	bh=PrtFRseENOuPJcfDJ+9a0Ly2swQ1fYsl4/sgaerCZfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pxP8awr18k3syy6vLLtIBhVwmNksv9I5tBfLtEtruBNOXcBo00BQbgbyQEfkMLjil
	 wpzOSc1OP4t1UfsAurcbd9qoEmt6338CMpAcwdEGylyJeXqrSfIjFhVk1o1umRu+IX
	 cvzE74OizMjlh+DqjHMWCDFnBbi5PkCGaVk7+BemfYdPM9nvvx1N55QwdRQWvO5+XG
	 4TQMGsfE1d3T073BaZutOh4zr3xcoxFzaiXLClc7s92kU3IDMGUdiLSa34j4SYl+AK
	 ZET8p/1+q7iZe6xsc/6TqDAUSJd1peEyoU3KbHOFR4Xw/IsDOD0OlwL9qrqJMZDGDp
	 M8qJQVR1ESY2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4A34C43330;
	Thu,  9 May 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dst_cache: annotate data-races around
 dst_cache->reset_ts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522003067.32544.18287722465743436878.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:30 +0000
References: <20240507132000.614591-1-edumazet@google.com>
In-Reply-To: <20240507132000.614591-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 13:20:00 +0000 you wrote:
> dst_cache->reset_ts is read or written locklessly,
> add READ_ONCE() and WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dst_cache.h | 2 +-
>  net/core/dst_cache.c    | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: dst_cache: annotate data-races around dst_cache->reset_ts
    https://git.kernel.org/netdev/net-next/c/3b09b2bd0d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




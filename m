Return-Path: <netdev+bounces-92056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4A8B539B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847F71F20F71
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDE17BCD;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI4/17Fd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF3C2C8
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381230; cv=none; b=SNSabs2Gvv4DXE6CSzHW4mLUPzqKKM5bV5Z48XVQgPS5s7Hif/GG8ZAQWK3UdrE5Dsps/PhXMN10fh/KQQKtzDK3aCqwmcHANBqs9U341AyWUbgtWgycw6ra8lX6NQTMEplIdgn+bhsfO0Z/G6wnDVRCs9iYxVYxGEvuvMxo2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381230; c=relaxed/simple;
	bh=yx2eRPKtBnwbVpML9f14GqvN98MWeB0cxusKDfUQfd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ee3aOOPihV/e+TwUXzrB8+cM3Za9PmHHiPIz2ALdY7af75MFIHX/92UtcLzLs641uB7bXMRNy5wr8YDaFLvAw1bPweHuWbUYLrhGzNhi+V5LlYsy6KTe6bmDTY2NgyW5DM4tgBZLS6mVVX3BlI7anU46sZIzbaE6l/G7eesmsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI4/17Fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CC89C4AF18;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381230;
	bh=yx2eRPKtBnwbVpML9f14GqvN98MWeB0cxusKDfUQfd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FI4/17FdxzpE7c0Fwwa8/N+82HTC+UXORPf2aCDbnR516BoRMy9Mt3hYxxEeNiBDx
	 WAHkUC6yPLKZmKz97qwu9JL08HKa7fP/fNXk+j5UgWCs6cAT/iyNgpz9/GpyrE7Vfn
	 xcNNO7d1SwsSArUkYjsmNKuzfe/FV+E4PFmMotk/GPL250LJzlxJ2QU4pS59y32fGR
	 fAW8nn6+6P7H+NiJNWtLNGHRddGKGDUeGb0CXA6/09SJKGl9jBkSuoq6IUf0K1DUzy
	 9Bs9jemWTd4lVU+PtVNredLx7JWbQkJ609gCj40npfvXV5sRyE1UUQC4tB1BONQLz+
	 IQPYvngW+Owgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6B7BC43613;
	Mon, 29 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add an explicit entry for YNL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438122994.5873.17852360123873972319.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:00:29 +0000
References: <20240424183759.4103862-1-kuba@kernel.org>
In-Reply-To: <20240424183759.4103862-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Apr 2024 11:37:59 -0700 you wrote:
> Donald has been contributing to YNL a lot. Let's create a dedicated
> MAINTAINERS entry and add make his involvement official :)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [net] MAINTAINERS: add an explicit entry for YNL
    https://git.kernel.org/netdev/net/c/16f50301a804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




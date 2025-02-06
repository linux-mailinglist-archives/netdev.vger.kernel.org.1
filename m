Return-Path: <netdev+bounces-163693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F1A2B5DB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0318718802D9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860942376EA;
	Thu,  6 Feb 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlSlo7p0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4822FF5D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882206; cv=none; b=BwOXr09johXAJsr7M/HQh1nZnIdcQmIHeTmamOADiMnJQ8Z+MfIIEfqNRzU9agfnvhKYDTfmAXEakpWPxecou1aDmOjYZjfwjCFu8in6+X0jD9jD65kH3Kl6rvGOzktC9+H4P+0PT4dkQU6CGA41Tb0woSjRJ/acziCZNm0Sv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882206; c=relaxed/simple;
	bh=p2zLHiUAwGrxgtStrmK0+qugXx0iBmiZi8P2wL2Eue8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G6idycqe1oVJ/gSqsxlR4XdjHu4+HI8yZf6Ot1KnIuSGa2hbisy/eX6hvfyr2MM5U75SWiexF1jsrhy8IMBsWZlBvJnUChv9jYncdo+1lm47g7y/0zGh21ebVBiFXB2oI/iSFjkiI9n+c5DVYnol30qx1GQMVEV2ujB40+SGtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlSlo7p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA0BC4CEDD;
	Thu,  6 Feb 2025 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882206;
	bh=p2zLHiUAwGrxgtStrmK0+qugXx0iBmiZi8P2wL2Eue8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LlSlo7p04D73SFD7S8BQYZ7DX1ga5HCFWmmGj7cPxyLlIepk9V2eRtmckbnQ4CjGy
	 ki9NtFhOTEYvq5XDv/LamJ3kjqIP7R7RlCfYgeauRq+0HRnca4rsbFp0P6s6VdDvIq
	 ZVqeLZYA9ms2vRh1aEVZ3Cyazt5k8Jl+bv0wxrtI8JvrKFGMcKTZMsUMPfmSCvr5R8
	 Nw4lPFVzgZ7nuFjqjhSOelKhngoK5X6iFhJBx7fFR1Y2OjyLMvwVwNbMJJYWgX+wRm
	 DCbxbq8cM6XoNo9WreWznBwwQAayRBwUIavLZqxhw8exyYECwG5FLFw90mRoZfVbOf
	 1KbGm9GLDhcHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342C9380AADE;
	Thu,  6 Feb 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: add all headers to makefile deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173888223402.1683659.538160315646232891.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 22:50:34 +0000
References: <20250205173352.446704-1-kuba@kernel.org>
In-Reply-To: <20250205173352.446704-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, danieller@nvidia.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 09:33:52 -0800 you wrote:
> The Makefile.deps lists uAPI headers to make the build work when
> system headers are older than in-tree headers. The problem doesn't
> occur for new headers, because system headers are not there at all.
> But out-of-tree YNL clone on GH also uses this header to identify
> header dependencies, and one day the system headers will exist,
> and will get out of date. So let's add the headers we missed.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: add all headers to makefile deps
    https://git.kernel.org/netdev/net-next/c/0bdcfaf84a94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




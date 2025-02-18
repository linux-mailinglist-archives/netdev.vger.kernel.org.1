Return-Path: <netdev+bounces-167147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97AA39040
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B3B172677
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108797DA82;
	Tue, 18 Feb 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prTK9x5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25476034
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841605; cv=none; b=DV7r7vw2UN8KQAcKBiIa2BkUaHbCbzG3vmOWhSQ4ghqPp3muzF7uKGHHnteWxd5qDw2LFaw1rQ4PxjK4xZ2DE3BZ8Judc1xtpVfsq9cMkglndytmHzwQ9ZJbmqxNjQ4RmIl+FLbh3cvOoc7A+qOBHIWBT5UMq4PI9KWk8xH/6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841605; c=relaxed/simple;
	bh=ReKSDJFrINFx7+mv1Pf1+mJ4xasezsDu4gE7R8AxSAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTDRhjjC+7gAwRDdxS1DJV/rabdqVFpbEeuSuBhdbbspZ246494Ob00um9pYKLxpSMRBKYrm56dyxJHRJJukFTy0qeRR7qagmvPlYBQ0QSg+bCfvTCl/ZgHZFO4bRrSqJmBZT8bG3n9a9jeD6LNDKL7sDU95hLuiDOy6CDGZi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prTK9x5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2B5C4CED1;
	Tue, 18 Feb 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841604;
	bh=ReKSDJFrINFx7+mv1Pf1+mJ4xasezsDu4gE7R8AxSAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=prTK9x5SAf/KSC2n1U2GJ1tfm4hZS+UzolUewmKCMMF9Ixc+Ed3UY6RevH/MEqW+z
	 7Rre4PvYGcaeNU47SBp0hGoU5Qj9q4p/ZsNLyJS38GlMReXmixWKTgAm6nMROr6RC/
	 2GeI36zYTgHhU/bOWQ9uraSdKezzmsmxBYdVoxBGZ3FK9s+Hewwsn+/PfFSA76RfnJ
	 7C8opm6/84U61PvJRIgKB3pEvA9+5qZxLpq+5fb+iNkZyPoVs5ZY17ZwpTeXRP1+Lk
	 HG5MXQ3qX6Ron4q1AmYJBXbcDNqFMWxeoRjd4jV4SlbqbB7ePq3KboRcjRrpcvPg50
	 Z6se1/K7LFdBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9A380AAD5;
	Tue, 18 Feb 2025 01:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: create entry for ethtool MAC merge
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984163449.3591662.17041417442252348941.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:34 +0000
References: <20250215225200.2652212-1-kuba@kernel.org>
In-Reply-To: <20250215225200.2652212-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 14:52:00 -0800 you wrote:
> Vladimir implemented the MAC merge support and reviews all
> the new driver implementations.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [net] MAINTAINERS: create entry for ethtool MAC merge
    https://git.kernel.org/netdev/net/c/0a4f598c84fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




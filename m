Return-Path: <netdev+bounces-117899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C494FBA9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79035B2182A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA81BDDC;
	Tue, 13 Aug 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY2+XKJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BC1BC43;
	Tue, 13 Aug 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515032; cv=none; b=t6dwTtOGHr9bK56q2uo5WiSYGEB92FpkHTh6QuUVg31r90IJT4eA/+ROeIzHX2tZqEFs7V05CJGPT0Xfm4PwK+RVvSRvz+M6BSbwq/rCJJnucmCs95kyGMqw7ntN/up9MQVym8y+lZZGRFuRiULH0JV1wXLPgg6qpV+dVML9vXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515032; c=relaxed/simple;
	bh=GEhAqlpVDuWP7upfr4QwG6LF8kUijBo+SrN789bGFQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkyEissLzloS6tGm5qlTUSLOJEbmzmEtLORlCxZApCATGODooos37y0Cr2lX10lbXJ756kKc7w0gMbONJI7Zd2LFz+uLeHOUGbDy+CK/SH2NbHz4QzX8IgKutJMsuRDr/A1gdGTkrYv4KEGOPtpFdSaa6j05gUBsSJZ6nCUmo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY2+XKJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E45C4AF0E;
	Tue, 13 Aug 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723515032;
	bh=GEhAqlpVDuWP7upfr4QwG6LF8kUijBo+SrN789bGFQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EY2+XKJFyC/oQf8Ub6bxNdUwtouVcf8e+e9oFej0p3Fq/IcZAMG25kgCT68/3RR4/
	 4QtMTWgJgrR34yjCqGQ1umszkOPKDfF0hkrsWXGCwo3nte6/D4PLNCD31G88gT9sWo
	 SFHXqIhRpk9BQQD0mBf95EF60i44x33lOKA4lzPOxaFLtitmjlIRsZcdQJ+A4voBYA
	 2J1sdS/PBsNPU4vCXwnM8wVpDrub+Rni9cWWsJne/0bM/UInsco/8/PPBUCIz3We0E
	 LGoPf2PLJELB2NoTPZRE8NDqbX1cKOwZH/C7FjYtQsw++0CIJRDFOmWIolAxZ4jsMs
	 BSj5t9pTiIgOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71448382332D;
	Tue, 13 Aug 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] nfp: Use static_assert() to check struct sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351503099.1193412.17012802857805272349.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 02:10:30 +0000
References: <ZrVB43Hen0H5WQFP@cute>
In-Reply-To: <ZrVB43Hen0H5WQFP@cute>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Aug 2024 16:08:35 -0600 you wrote:
> Commit d88cabfd9abc ("nfp: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct nfp_dump_tl_hdr`. We want
> to ensure that when new members need to be added to the flexible
> structure, they are always included within this tagged struct.
> 
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.
> 
> [...]

Here is the summary with links:
  - [next] nfp: Use static_assert() to check struct sizes
    https://git.kernel.org/netdev/net-next/c/46dd90fe51f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




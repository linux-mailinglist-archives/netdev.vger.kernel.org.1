Return-Path: <netdev+bounces-186087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB0A9D0F8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915721BC7941
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BEA21A427;
	Fri, 25 Apr 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf5FFeRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295C219A8B
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607665; cv=none; b=iLqKZNTTy/eB2tAjbuHksSZujHjdOwrHMxwtFp7iJNR1tA7b/IFqLShiGbVq8M4X8HI+rvcOwUE/Y5WCzZVuZ3OzAw82kQcvalAQELIBbtaCpXnGZJcVwuTTBG3t9fpd3drmTwKBISqhmhoKT0EFNKO8sH9GkFPrEVV4DcDzBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607665; c=relaxed/simple;
	bh=5r4hJK1/eXIvfzCh6TE6dgC+QtSJ9c+JdZdDXyOTSo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLd0znzVTEmPlEkHIfX+rwiSgYTjtwuy3l0/cgpS/DgozTPbM8djHFCeCLLFZNdRsw3TzZYcTECYBSSYodDJRwK3Xm/AyqwsxbJiger2Av1G7SgrHiCMH4rmxVYbOQshIus3g7f/bsRHYAdG8RN8q1nucLEmIVB6un3b56eJXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf5FFeRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA78C4CEEB;
	Fri, 25 Apr 2025 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607665;
	bh=5r4hJK1/eXIvfzCh6TE6dgC+QtSJ9c+JdZdDXyOTSo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mf5FFeRj1S/XLqwIF+Cau/a5/PYG5HCa9rSjTW7GG87MDzpElX1YNeZ5xv+J8R/P3
	 +0l1OKWGpQGFQVFtFOwhp1E/noCySsrAuDpuF9E7ibbs0x1lw2DtMPHxBb31i5azCG
	 XFD840iE+vrU454G2FGFfvm0ROlDLexIrkJRKts7rLNK9nd8g0sckVqJbmWLje0+LD
	 qBGeZCTY7oyl05IX+RmMVoAArsxzY7vJBFzvL9xzeKPFbkbIaKeJvXpjQe7a0NxZnw
	 xQQbyNSK6uypb3D9UvqfEyzCTAOJHKvnD3QaJ/MtKOyI53XnMmj9MjuoOGyxOG4cXu
	 NdgMbQP9Umdew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF6380CFD7;
	Fri, 25 Apr 2025 19:01:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560770424.3803904.17648606997852709603.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:44 +0000
References: <20250423220231.1035931-1-kuba@kernel.org>
In-Reply-To: <20250423220231.1035931-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux@leemhuis.info, donald.hunter@gmail.com, jacob.e.keller@intel.com,
 danieller@nvidia.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 15:02:31 -0700 you wrote:
> Thorsten reports that after upgrading system headers from linux-next
> the YNL build breaks. I typo'ed the header guard, _H is missing.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Link: https://lore.kernel.org/59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info
> Fixes: 12b196568a3a ("tools: ynl: add missing header deps")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: fix the header guard name for OVPN
    https://git.kernel.org/netdev/net-next/c/f74d14a7dfb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




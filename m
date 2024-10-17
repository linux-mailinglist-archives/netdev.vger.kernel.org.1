Return-Path: <netdev+bounces-136458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8379A1D35
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58736B21EC9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AD1C232B;
	Thu, 17 Oct 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY8kaXHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F11369B6;
	Thu, 17 Oct 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153824; cv=none; b=n5ZTgJCT5ZpB4hvI2olKWZs+Ufbp/jLorUwT+V3lLcAfgnuBJC5UG6CviPbv5TVBrn3AaR7vTkM5VvJMdtWsFMeunKMnavIx3YQCk2I8r4FG0jopC18AFq3FiRs23xlRetot30GAk2kIkIaHCEtIEKO0yRQK0rxqKbImcnVG4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153824; c=relaxed/simple;
	bh=sMaTj67hu5LAEAQ/l/5pAEJDkPWMyEtcAQ5f9PTKvUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M5D9mkHo9jgxmch9T+dXgxxT19BX+fcyvpA29+wQm7owG6gwqr+yvv0L0sDocNwjbWqgVwt2QrAzIu1zkRRcQztvtgs4gzZV2M/tSnUfbFLpvZel5Jj5Qm19nBmjHontKimGavwIcWztyqRahhrlHiJHs0dhM1kFCrhLpqjpeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY8kaXHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5877DC4CEC3;
	Thu, 17 Oct 2024 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729153824;
	bh=sMaTj67hu5LAEAQ/l/5pAEJDkPWMyEtcAQ5f9PTKvUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iY8kaXHYcE87/KxaArS1LeGPfo2PXfiJwVuFTQSYeHi8+6Cl1pjdiw6DU/TVhazu7
	 M5skMMNp1QrnYMbk5PtIhx+rg0lYrlBr5zZvsedaeK0xxRyqI3OjLzxsCgMdqssx1i
	 yo20aH1wgvXUy74EhGVhzsuKbCwalQRNG1TC9lOyalRp5RHxALoLJG0R8bfF7O3SAr
	 ryfs/C0FXI9nhazALo5YOXS45YryrLfdHuAe9vlURjq1LEn6kFqOMNizQOglbrwtYX
	 ke2Zh9w58PU8PIWjeMoFOXFhZMVtHMHeOH8o9yqHoRisKjc1lDjIopu+p5ou+ZVzph
	 WRDIcfEarRqBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6393822D30;
	Thu, 17 Oct 2024 08:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ethtool: rss: track rss ctx busy from core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172915382974.2091096.5892312350045915933.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 08:30:29 +0000
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
In-Reply-To: <20241011183549.1581021-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 11 Oct 2024 11:35:46 -0700 you wrote:
> This series prevents deletion of rss contexts that are
> in use by ntuple filters from ethtool core.
> 
> Daniel Zahka (2):
>   ethtool: rss: prevent rss ctx deletion when in use
>   selftests: drv-net: rss_ctx: add rss ctx busy testcase
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ethtool: rss: prevent rss ctx deletion when in use
    https://git.kernel.org/netdev/net-next/c/42dc431f5d0e
  - [net-next,2/2] selftests: drv-net: rss_ctx: add rss ctx busy testcase
    https://git.kernel.org/netdev/net-next/c/1ec43493c94f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




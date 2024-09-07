Return-Path: <netdev+bounces-126142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E496FEFE
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F79EB21173
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DE611E;
	Sat,  7 Sep 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cILIN+18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774817547;
	Sat,  7 Sep 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672634; cv=none; b=HXzoyxiM1H/U6UemaKiZppkOaMNvs5xeAbW6tCwwx77spv4TSHKA8jROazED1fonwOKf6KhpCI5ILTtBH4rNifFkLpwUL8S9A/psZ/9eZ2wAjQ2h/5Qe7ntanpoFEzuC5sOX9J/CN7jirX/B1E3Dy5NR5CrmK8R98kYPRHLgMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672634; c=relaxed/simple;
	bh=OIjlUWpsF8/KqdXsnxQ39reC2jSTTuqwdBZAwK4EC0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EHBoQrwoQiBBA9xx1WohEBo34uLppoPhCWkib/QPthdZUIxf4Th5fARQeTgk/zI5ECVQX8LRmfePKACABxFET+vk2vd6mgtUOtXC3f2zkFkGT9XSvpFPYEPqSNQuIjLA3ilHk3go9V74Bxdhi6Qes5B8SgpOBKnkB2d5D9bT1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cILIN+18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EDBC4CEC4;
	Sat,  7 Sep 2024 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672634;
	bh=OIjlUWpsF8/KqdXsnxQ39reC2jSTTuqwdBZAwK4EC0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cILIN+18GgrHVFk+2ttx4GTHt5c1yMqxrwbH4eVhb+0vKBVBo43PBK5xszxS7R2Ka
	 fuyppWwGzOaG21atPpUjUdCNJxZdgrIW3MqfQ5VVXeXZs8AUxtSq82/b5pBU6AKz/s
	 o9pBRxULqUmN+UT4oMtc5DThzNszJa/FNdRlGkZI3z589CPUDCO9Gy/NqPbt4eDkB5
	 GC3F9hKD3tYMovoeQ5ZCRx50yitDyxlkfQq288BE3kyBHZ/iYC43Y7SiTmdudPMHFI
	 tyI25WM2Z3SpXmbIVYCumn/jMNghy2wu2h66mbWNL30ssZlqRH1+PXq/q1Eg5PSzEQ
	 6Y6Nuh4zK3j/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9E3805D82;
	Sat,  7 Sep 2024 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] octeontx2: Address some warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263499.2576623.425623460796543424.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:34 +0000
References: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
In-Reply-To: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, netdev@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Sep 2024 19:29:35 +0100 you wrote:
> Hi,
> 
> This patchset addresses some warnings flagged by Sparse, gcc-14, and
> clang-18 in files touched by recent patch submissions.
> 
> Although these changes do not alter the functionality of the code, by
> addressing them real problems introduced in future which are flagged by
> Sparse will stand out more readily.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeontx2-af: Pass string literal as format argument of alloc_workqueue()
    https://git.kernel.org/netdev/net-next/c/92218f108f51
  - [net-next,v2,2/2] octeontx2-pf: Make iplen __be16 in otx2_sqe_add_ext()
    https://git.kernel.org/netdev/net-next/c/7baa90c616e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




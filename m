Return-Path: <netdev+bounces-247554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE9CFB9E6
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C93903047117
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A35211A14;
	Wed,  7 Jan 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+NT+O8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD4207A32
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750214; cv=none; b=USN12jaSWaPvwu3Fj7vXrm/Rxogk3uwn2zy/ubj3l3/jbUsvo0m7LQpnpuu1g/UgEcPzzL2vglFM6qHdtR+rP31WIzxytwF/ul9nSGnILhSPLQIaThKCdE7fYDyYi1Yj4XObevpLlWy5dDRoM5oPtbpGQlM/aT4TQOME4Nv9v74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750214; c=relaxed/simple;
	bh=S8/hBD58v1KAYKBQHB+1NXt9tWyCfUwJGtkBZk7XrU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mXXESxN/Fi7e5Bl+cycF2glNjheUKA5LCrWP3g+/JBM+ZMMwQ8FQENNcqjPwHdDAA3zIuVZ9BBPICy1NK2PmRWDMhFr0tqQUyV8fLff8r5VkGEEUXhSAhqVPqJkgAFtabH6CDzXnQPJ9aUi3RUwJDHb+D1xMIWOrNhygBo2FTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+NT+O8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D3C116C6;
	Wed,  7 Jan 2026 01:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750214;
	bh=S8/hBD58v1KAYKBQHB+1NXt9tWyCfUwJGtkBZk7XrU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+NT+O8ITh2DuAlBB+2FOgIhqqefY217j3gFP+cL3sSpAz+JM+IhzZnjw/+FaT5dS
	 Ev4BFOfREq+qYXl9au95HnNQDtmVGvg6SihYDtjNqjARTtJuc0NOqB+xecxvPMFuXy
	 Qq+0bNuvQAJ8T6WE2WZXTPInuihGbT67JM4XFlOlsVfUFDjwdSAaL5ps0/kH41JQQ0
	 FfmA+jmtCEi54GgtKc/aBSPGDlm5xsonQqWdUV33x4seGvzbQprpmk03haeOYKL378
	 HqfpTvmgInl1ywPW8JaBfyQkaFm4POY8TnAGgbBLacN7h6BGup4Rq7j4yyLBb4B2IL
	 ndt8xZvsjihAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2980380CEF5;
	Wed,  7 Jan 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add minimal client
 and
 server tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775001152.2194089.13144888728220975671.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:40:11 +0000
References: <20260105172529.3514786-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260105172529.3514786-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 12:25:02 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Introduce minimal tests. These can serve as simple illustrative
> examples, and as templates when writing new tests.
> 
> When adding new cases, it can be easier to extend an existing base
> test rather than start from scratch. The existing tests all focus on
> real, often non-trivial, features. It is not obvious which to take as
> starting point, and arguably none really qualify.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: add minimal client and server tests
    https://git.kernel.org/netdev/net-next/c/3b7a108c4197

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




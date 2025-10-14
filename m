Return-Path: <netdev+bounces-229149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882EBD8A2B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75C13A573D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1D2FDC4C;
	Tue, 14 Oct 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3PhrNjV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361912ED14B;
	Tue, 14 Oct 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436021; cv=none; b=ZmXsVVJpE8yeWXCE07XuYgF+LrL7H56rVVRYJHs8KCd+ziIG1DFYrCI5Nix00NhyJqA17cdC7UbGBONFcIPIjrI0vzqfpe0wCEjqZlOkERCj5N1L5QE1wCuJ61QcXJ40NaPxpVM9bG6dbioK1lu5ztcs0EPf5k3ADDK7lPMJtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436021; c=relaxed/simple;
	bh=UHMe3b81m1UgQXFwSvOBKeHPx1lLJ4CKMtlBBgihsAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aLNV9ErtCqPUrdzvw0xiBVNGZWJwNi+F7vRmdI1Acy8yfeBJcZAn+lT2w2KnMPxwHjIsz0NF6UIBJB/ixFJgHM5slP99V2pmniRlj/u73RTY2wYQSesnDQ9HTUTA46zSnuaqxlSYVimhhDV4stPulLnGh/RaeCff9GS0nxVIyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3PhrNjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11498C4CEFE;
	Tue, 14 Oct 2025 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436021;
	bh=UHMe3b81m1UgQXFwSvOBKeHPx1lLJ4CKMtlBBgihsAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h3PhrNjVfWTy6iRKoQmoH1fhNUUDKL6nVZHtEv5WQYVvgNR4aOdwg7knoWRs38K6b
	 HJ9NY6pX/SgLC5AffA+yvjjt3MH8Hcdq0J0AtJGm5tH80hVFvbh/AjQZjG0G1NMQnT
	 2mbxtE99AvqYAX2jNAEdrORMoNkC8k8tqR8HF4ds7yMgLXqw+gaJicP1NqifbO0DCy
	 UFoMbegNeio814b7oslK4LxHbXDUSmmjWSAZqu2ebAzR3WJ3fd8Hm39Qe4Rcd2ajrj
	 KRvrf/gd13esjseTOaQFmAzOhOWfMC0AK/fpgkLyx4K3U37iA7pJGpey2I62bOMC9e
	 U1vk8d+I6/PXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB7C380A97F;
	Tue, 14 Oct 2025 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176043600652.3625307.14243303958438003684.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 10:00:06 +0000
References: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Oct 2025 13:42:39 -0700 you wrote:
> When CGX fails mapping to NIX, set the error code to -ENODEV, currently
> err is zero and that is treated as success path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
> Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> [...]

Here is the summary with links:
  - Octeontx2-af: Fix missing error code in cgx_probe()
    https://git.kernel.org/netdev/net/c/c5705a2a4aa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




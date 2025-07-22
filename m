Return-Path: <netdev+bounces-208958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A9B0DB1B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE933B6B42
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3E2E9EAF;
	Tue, 22 Jul 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS1EPIcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11522E425C;
	Tue, 22 Jul 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191599; cv=none; b=n2YOY/VbgbCKdM/e9kAIbb3Kbg6uJyzW3S/dr/jhm34ogK4f/v3iShG802PltPyVkqNZ0+a/SEuK4AH8Rcs0vxlsQ0Bib1XKnkZhlKVGjq8Xsv3+SGf3hAqLu+oVOhbrv7AgSg/DpbWDomdKuLBWWkTkyqEs9vq1rk+7tquUYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191599; c=relaxed/simple;
	bh=w82IroZHyxLBPCxDF/tgEYFjWbJRjWoNR2Rm8xKdH/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nRYWbcUCNuZX80hE7ipv7S2t5yTSud7NKS61y/XaJhjf///wKhKWXR3S6Kjz1VJVfZnbWRhJPQPOFjITkRC7fx/2s+9TjyFFQtLt9xqIF8126hbxJi4Q8pcwPqGcpWesQHTm91wrXSEyP8uObLuT8ilb+ZczzmhIwUwRbxn/uWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS1EPIcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C05C4CEEB;
	Tue, 22 Jul 2025 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191599;
	bh=w82IroZHyxLBPCxDF/tgEYFjWbJRjWoNR2Rm8xKdH/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZS1EPIcpxt85uRO7zcgPNp0wMFWjd9+1zt8+DiZX0VtI6YHPoB9mgh+sL+SidLOJz
	 et2C9kChLgiX0VBFgf0FA/iL3Sg7IiBtf8VNuZqZPBlD4h1lnPgGJRBpc8ePtbBhPK
	 7CZBtrC3enfDS1A4hOWs1QdIaKZtknYRTcQN20mCpk4BxD8HOll+tCbKacP+LERv6T
	 PyGs5tr3uGejY0ql/u/EYCOfiGWEznH7M/9NrJwB19xhvq7U0cLULG1lbGy7YYlIjI
	 fDqOi4nY2Ix2zyne07QZKNj7sHY9FncCLbtynH6Ag8CAikfYzRIq7azv/4up4ZToYR
	 qByzAcIawf8Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39752383BF5D;
	Tue, 22 Jul 2025 13:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PatchV2 0/4] Octeontx2-af: RPM: misc feaures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175319161800.812441.9425015938720528347.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 13:40:18 +0000
References: <20250720163638.1560323-1-hkelam@marvell.com>
In-Reply-To: <20250720163638.1560323-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, bbhushan2@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 20 Jul 2025 22:06:34 +0530 you wrote:
> This series patches adds different features like debugfs
> support for shared firmware structure and DMAC filter
> related enhancements.
> 
> Patch1: Saves interface MAC address configured from DMAC filters.
> 
> Patch2: Disables the stale DMAC filters in driver initialization
> 
> [...]

Here is the summary with links:
  - [net-next,PatchV2,1/4] Octeontx2-af: Add programmed macaddr to RVU pfvf
    https://git.kernel.org/netdev/net-next/c/dd47fc676934
  - [net-next,PatchV2,2/4] Octeontx2-af: Disable stale DMAC filters
    https://git.kernel.org/netdev/net-next/c/83d17aba92ca
  - [net-next,PatchV2,3/4] Octeontx2-af: RPM: Update DMA mask
    https://git.kernel.org/netdev/net-next/c/f5295b5a5849
  - [net-next,PatchV2,4/4] Octeontx2-af: Debugfs support for firmware data
    https://git.kernel.org/netdev/net-next/c/49f02e6877d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




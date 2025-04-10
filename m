Return-Path: <netdev+bounces-181002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4720A83614
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD8F46576D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEEE1E520B;
	Thu, 10 Apr 2025 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RArMMLnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621E1E5206;
	Thu, 10 Apr 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249797; cv=none; b=idg2/jsn6PcsjKV81Jk+ab35GT4fOemyY7ott1FwDjl7BCt2ZGWaOpYdClgG3HUKx+niq2y+y1cTCTaBw0d6FYhB1ygnNRvoMhNRHaNzDPxYDOngx8T8va1whY7zBs9MNOYFfbsLT9eiMVjVxnI4TVO1CEYlm1Pduk6dVT741HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249797; c=relaxed/simple;
	bh=28QeQ+g/6s+unKHjdyhHxXCM855jBormeJnVBEvE+sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZZ6NBjx3Kc4rhajJ0zkuYJ7HSoAcwmw1UD2qTN8q3pN4VodJ/ruMSgbM/V8R15KO+4yCZv7BRGUwbgdVEVpv2pGqIucAIjDmyTU3bY2ouBX7DJrLU1AL7SFUJxx0b0cAx1isZZ0pZOfk0EZJB8b0yjIDrs3IrM3dZVvmbA82v/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RArMMLnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E422C4CEE7;
	Thu, 10 Apr 2025 01:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249796;
	bh=28QeQ+g/6s+unKHjdyhHxXCM855jBormeJnVBEvE+sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RArMMLnNtk6NQIr3KqsV0lYvpwon5tXxtY1ghmVZi2FQtm/fNL3FCgD7oVTNSlNkW
	 NRVjbujWBX/Yqm47GaeulmDfCN5S2hZznI+l3wLsFns1GxRjcj7W+6lhQ0VGT1It5H
	 eLQBH/9sD86YAB95E22A1kdAK3DkHCurARnT2MPyWIdWlPRwjXo9H07mxy5pH8bdMM
	 XZXaF00YoAHPlk1lGPdZPska5I/LttpOiqaOAzJ9T4Skbiz5WNIQWbxFzfWcmqvuBR
	 IfotRH5UmrXRFrsrfCdpwadVGek/QcqeUfzXMhR85w0T/iFVtUP0dR+JYhnLYsDAF7
	 903dfyTkTPLcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AC838111DC;
	Thu, 10 Apr 2025 01:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] octeontx2-pf: Add error log
 forcn10k_map_unmap_rq_policer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424983374.3109521.6947734922803594004.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:50:33 +0000
References: <20250408032602.2909-1-vulab@iscas.ac.cn>
In-Reply-To: <20250408032602.2909-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 11:26:02 +0800 you wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors.
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop, and report a warning if the function fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [v4] octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()
    https://git.kernel.org/netdev/net-next/c/9c056ec6dd16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




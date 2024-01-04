Return-Path: <netdev+bounces-61437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCA823ABE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7966288343
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06FA1C33;
	Thu,  4 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbSpqiHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDF4C67
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12467C433C7;
	Thu,  4 Jan 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704336026;
	bh=C4hn3seFgZyVdeatTQjL7uw3+ygvvuSS2kRiuK73/c0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MbSpqiHirSlWrsThv8LcsBpoSdU8tB3o01XpVW52Vmd+ouZrZJrvKniaKCT6rnoWP
	 CUIfuG15cS101r5u318DH5b/hGXjPgccmcOWneKB5/3LG+fPRCWr4HbrJTFQ88JAIs
	 UOQQ+XNcIVo2FMOQ7OFuPcSeCChEUDd1QStSs7fRxv0/K4L+w1QPMZW32uWvUw1Wwg
	 ThiSV/D32ppohjcRJtMSaB6yhh+fEnELGr6jkrWTEugT8LSvADA/wD4j58moij76lA
	 OY5/BVQlMnfH0PGkTjw71ogZKrj/nswprjq3Qg27y/Q3XWzVPvZD0420Pohn8NEzDu
	 prMo+i2qPa5SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDFC8C43168;
	Thu,  4 Jan 2024 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net-device: move xdp_prog to net_device_read_rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433602597.24059.13310355310637111771.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 02:40:25 +0000
References: <20240102162220.750823-1-edumazet@google.com>
In-Reply-To: <20240102162220.750823-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 lixiaoyan@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jan 2024 16:22:20 +0000 you wrote:
> xdp_prog is used in receive path, both from XDP enabled drivers
> and from netif_elide_gro().
> 
> This patch also removes two 4-bytes holes.
> 
> Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net-device: move xdp_prog to net_device_read_rx
    https://git.kernel.org/netdev/net-next/c/d3d344a1ca69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




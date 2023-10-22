Return-Path: <netdev+bounces-43280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F67D22C3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D8528162D
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E478A6AB9;
	Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzycBDrS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B16AAE
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E646C433C9;
	Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697971824;
	bh=73gnJ1feu9sNKDKLfO33qJyYdHCMX44+qbCeHIC3h+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pzycBDrS7I7W7v97oY5nSt8chjWeOVl79h2JehS8ozMMVAIq4D+Y2P9uWv0oEfeIh
	 1fUMF+gu2M8FETZxYGMeY6/gtKow5TjAQ3/fq0tfvmv75yOfOsNuiy+l8aX8usE+hs
	 E85aesXIp3u+OPNyyr4aD0dszUtwGNt19ycyfgKVt/NUQQHn2CWj2dpNetTC9fkbOe
	 TLaplqmwEADGy+9om2PcpRHCRPZW0Tkb2CPSGfGGSEuef89IPdp2asQJcXKD6C8gN2
	 mlru7JpVQQdTWf/hIEdVb5I50YdyAwI6XgohsbGfTBwCyssWWw06i+UJFfh/rHpQH+
	 YR3IZTnIft9hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43AB8C04DD9;
	Sun, 22 Oct 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] tcp: fix wrong RTO timeout when received SACK reneging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169797182427.5465.8249918922922941092.git-patchwork-notify@kernel.org>
Date: Sun, 22 Oct 2023 10:50:24 +0000
References: <1697847587-6850-1-git-send-email-fred.chenchen03@gmail.com>
In-Reply-To: <1697847587-6850-1-git-send-email-fred.chenchen03@gmail.com>
To: Fred Chen <fred.chenchen03@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 yangpc@wangsu.com, ycheng@google.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Oct 2023 08:19:47 +0800 you wrote:
> This commit fix wrong RTO timeout when received SACK reneging.
> 
> When an ACK arrived pointing to a SACK reneging, tcp_check_sack_reneging()
> will rearm the RTO timer for min(1/2*srtt, 10ms) into to the future.
> 
> But since the commit 62d9f1a6945b ("tcp: fix TLP timer not set when
> CA_STATE changes from DISORDER to OPEN") merged, the tcp_set_xmit_timer()
> is moved after tcp_fastretrans_alert()(which do the SACK reneging check),
> so the RTO timeout will be overwrited by tcp_set_xmit_timer() with
> icsk_rto instead of 1/2*srtt.
> 
> [...]

Here is the summary with links:
  - [v1] tcp: fix wrong RTO timeout when received SACK reneging
    https://git.kernel.org/netdev/net/c/d2a0fc372aca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




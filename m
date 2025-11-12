Return-Path: <netdev+bounces-238032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 342ECC52F2C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC11B542754
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15F337BB3;
	Wed, 12 Nov 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKnqYrDM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFEC2750E6
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959637; cv=none; b=R5oatG1CdqfgDuckfbU9Mjy3hlTpDUDe3la0mbOQzFmmKmV1VasSL/CtgHgPSGUUnNgY94mqEG/D6ExANy9mwOK0dG+pi80pXMz+zAnDQ4sBaPDPBwpvrDuG2EI7seSHYn8X/Faep3sQXQKDLQHhTSeUsVIrvnEOvlNVLvBTqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959637; c=relaxed/simple;
	bh=w5Y4fxxWSM3L7vAdmyu49RRzSLoDbKLJrYt8BzwK5YU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pt8Xjgwdp8eKg/bjScOWTRPzE2yNR8ry5Weo5v247KfEqh5e7NSSWiVAhPdsX3vChHvCPSpVHp3z6j/PYLhpUapBRI6M5g4idruODtU8c8hxMBYapLck63O+Feswgvi1sC8Wgkjs641YJOT25t+7eAcKU+lrk+QlNcnppUJWYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKnqYrDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82777C4CEF1;
	Wed, 12 Nov 2025 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762959637;
	bh=w5Y4fxxWSM3L7vAdmyu49RRzSLoDbKLJrYt8BzwK5YU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iKnqYrDM0Up7VDmNJNHab16lM+exQE+ufP6wEn54L5BTiYRttRbnxLxwkPLKYDXPu
	 +JHicBQsBB/0TC5ADywpgMEhgJFbg1d2nbanbVx6lwWN2ah1qmgO9NQMxcoWK38P1P
	 CavFr1EjmI3O1yMS+83jwI+EweaGL7qSYqx9p7A3qWxP+yccljEMzmI9PLfRbR/5cB
	 kB8ji7vGGa8swy8Oudsy7/qxbC59F5TKo4RFICi0CvMeQ7ZZ+gheZLbmq/WAe6Tf6Y
	 CPB8olqa3KbiXzlrPzcVJQyCqZvyabqaaxDOkuA1kM55DXPQdHUvDi1gCVnQAagVpr
	 L2D0UBiXy1DBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECE39EFA4C;
	Wed, 12 Nov 2025 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: clear skb->sk in skb_release_head_state()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176295960701.42647.8926319551268174325.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 15:00:07 +0000
References: <20251111151235.1903659-1-edumazet@google.com>
In-Reply-To: <20251111151235.1903659-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 15:12:35 +0000 you wrote:
> skb_release_head_state() inlines skb_orphan().
> 
> We need to clear skb->sk otherwise we can freeze TCP flows
> on a mostly idle host, because skb_fclone_busy() would
> return true as long as the packet is not yet processed by
> skb_defer_free_flush().
> 
> [...]

Here is the summary with links:
  - [net-next] net: clear skb->sk in skb_release_head_state()
    https://git.kernel.org/netdev/net-next/c/26b8986a18c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




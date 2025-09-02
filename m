Return-Path: <netdev+bounces-219377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2CB410E4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B93F18917D5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE962E11DC;
	Tue,  2 Sep 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2Su4P4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045B2DEA8E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856409; cv=none; b=XYBRYKZ8/EOyBpPRr3rPjxhSyD7FaZlIeNaFY6K2Snn+XvXG77vbFBQszSpyF/7CRsJqkouTgVZeWjaM8rXBVRegDoQbXc4Znq8B6c8N6euIIYVdefvtjyLRvEIwiR6BQteAi3mdUTx7H+6oveNQ2mNrJmYx/2XMX1LvpZPn0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856409; c=relaxed/simple;
	bh=xiSbhy6xi8odfOfmGuOvnEhzww7V0vgjvJL+Sda29Q8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTKEyJYzcQ2EyJPLvA+W7EFV/+qGyX0oHpwMBaMK/MvnXH8WLi3fvC+2s+U7BBrt0e/sxd7EhnQXocnpZdaLI2TZc0KOM8qwOmO6X9K3zbxV/D6HsPqWbIknHcNRYKXboIAIvTreHDGUqUXjNyAI5MBDxDj1Wy2Vp/zs2O6Jvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2Su4P4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C57C4CEED;
	Tue,  2 Sep 2025 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856406;
	bh=xiSbhy6xi8odfOfmGuOvnEhzww7V0vgjvJL+Sda29Q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2Su4P4PNpvePqV0vCQq2MIexMLrPsHEMUJ/6on8k7UdnLrBsuAAgtVt7jPZzta2j
	 y2Uz2b8gwCauv+PmOxmoUHoAkqE2Kj+2zKqVJNT8ib6YWvhwkPBJfBl08OMV4k+DL/
	 a5Ev8uhnX7GOiumFtEtzXuxskiWhcAUGQy2FlIEPENGYTcE6f1zwR0k+1LJSBu8f2B
	 MtwmlebegUG9ns3sFr8Qw72/NkmWt3aWUuLCT9d3mt+1U+tbOqKEECd6j+pJbursqm
	 dPRXk/pq0rxdogYk7qPFTRfOFpuVJKC7TQ6+Zt0qQBp1UfP8mvR0+LHBT4K1p9EV1L
	 blBUdml9w4ZEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE6383BF64;
	Tue,  2 Sep 2025 23:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix tx vlan tag for llc
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685641149.469813.17773036989909976650.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:40:11 +0000
References: <20250831182007.51619-1-nbd@nbd.name>
In-Reply-To: <20250831182007.51619-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, hacks@slashdirt.org, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 igvtee@gmail.com, john@phrozen.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Aug 2025 20:20:07 +0200 you wrote:
> When sending llc packets with vlan tx offload, the hardware fails to
> actually add the tag. Deal with this by fixing it up in software.
> 
> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
> Reported-by: Thibaut VARENE <hacks@slashdirt.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets
    https://git.kernel.org/netdev/net/c/d4736737110f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-197289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DDAD804E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E725D1E2D6C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF861E51F6;
	Fri, 13 Jun 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2jF2RVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95061E3DCF;
	Fri, 13 Jun 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778212; cv=none; b=VXnnGb3uhKPWIy0xY1UbDCQhWz6b/QALZF5+u/bh9rIicdLrUg98Vizr5lJgzHzexe8lq+H08BKhkg0l4Cph2jWsWjRBPLEdLjlaVZ95pp800QoCRkkkze1aLLaoPL/B3S2ObIMJrktyePuNKDGlQPCbqi5qfAl7eRnmJF/m7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778212; c=relaxed/simple;
	bh=OgjMgeR/4SH6FHayrmQY6bHAivwHRm3BgepGfmAs2Zs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P2mORV7NzIDevEXSSbBY5MSJThHLB6wfJLLHH8VuvWvWU52yxB8oegbJEMd91d/GCoM8wv5TyxnYO0+QeLqVpz6pCDPK7eLueL9oUZRM/b99pP/rtLKMwqjtIpYAmCpjw8mHZqzDYYnE3pHQrX7ChpsbVwNT/gvRCfwrrUssFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2jF2RVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D738C4CEF1;
	Fri, 13 Jun 2025 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778211;
	bh=OgjMgeR/4SH6FHayrmQY6bHAivwHRm3BgepGfmAs2Zs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s2jF2RVi1l2WsCEyNUAdcIEdbF2NFXDvliqxua77xZjqBZNHEARcqj2pAIBEQ9rji
	 wBPe5FwkT0cqC+dKkJ2zaRMDjJkiBMkbOyjfDXUd8Z9OJJvsGJp1CH42sBCvfML2RZ
	 jbArZJQh8CmP6P7+3hFBBFT5IPzIk8ID+32Hbo3CgYQMUJ5nKOQBJ0ET54lkbXgZAS
	 FoW9mL7dQZT6nMnaosk5krt3GHmMRZWItXSzztvuuqKv4HPsQG655ztM5sHyaakksK
	 CjlDQ0T3fAkBTaJ8NNg4RR/BucNcCzQkTt0I7NhkTp2idTWJ4iBCp7otI8bJ70Q1YY
	 5Fu/A6n6o1BnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE539EFFCF;
	Fri, 13 Jun 2025 01:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: hns3: Demote load and progress messages
 to
 debug level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977824123.179245.9589458806623054124.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:41 +0000
References: 
 <c2ac6f20f85056e7b35bd56d424040f996d32109.1749657070.git.geert+renesas@glider.be>
In-Reply-To: 
 <c2ac6f20f85056e7b35bd56d424040f996d32109.1749657070.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 17:53:59 +0200 you wrote:
> No driver should spam the kernel log when merely being loaded.
> The message in hclge_init() is clearly a debug message.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Jijie Shao<shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: hns3: Demote load and progress messages to debug level
    https://git.kernel.org/netdev/net-next/c/3afc25335766

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




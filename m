Return-Path: <netdev+bounces-61407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD102823A00
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7BA282891
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB623D7B;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrHci0Hk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC32586
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C1BDC433AD;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=sdCLNeOl18ihYv93jeXGNf9KIn5+pvpkhtswnZmcctw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MrHci0Hkurw+wPXPS5C4XLNTXkRXOtOgegb5lZ2mx5BzSFcmpxM/kQ2dzr8m1Aizb
	 NJpUwpkhGN39l+gkSK/9KSKdyQHfxLEDSQuY8M7kw0knw0Y1PLiumgdu99cjMBhpAh
	 AAbTifvNHQSPFRnSu4EAYVONZqwpNgZQtqFhppKWla7jsDVwinqKla0vqblQ7/NutC
	 yL/pTcMV80OnjTa9ddhtqF8UQ/NoOb0Vo6iIjdQTrz+wVSA7vlI7yhm81s/OrmEq0m
	 SCPROW8Lhrk2XQnJ7OzOO3o/4u4hTbU2lC/euzj7wwEm0xIB46RamO7B1i3O7G/8y5
	 nwdWvoT9fAa6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05D53C395C5;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-12-26 (idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003501.5757.17195085391144718471.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:35 +0000
References: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 26 Dec 2023 09:41:22 -0800 you wrote:
> This series contains updates to idpf driver only.
> 
> Alexander resolves issues in singleq mode to prevent corrupted frames
> and leaking skbs.
> 
> Pavan prevents extra padding on RSS struct causing load failure due to
> unexpected size.
> 
> [...]

Here is the summary with links:
  - [net,1/2] idpf: fix corrupted frames and skb leaks in singleq mode
    https://git.kernel.org/netdev/net/c/fea7b71b8751
  - [net,2/2] idpf: avoid compiler introduced padding in virtchnl2_rss_key struct
    https://git.kernel.org/netdev/net/c/a613fb464dc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




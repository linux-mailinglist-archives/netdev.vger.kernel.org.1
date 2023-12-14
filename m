Return-Path: <netdev+bounces-57204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC18125AA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D13A1C2084B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15EA52;
	Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1WOdV/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEA814
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA93EC433C7;
	Thu, 14 Dec 2023 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702522825;
	bh=sfFFIOxWrh8aCBYWrka9XFG3m0E28R6vbTMjn9ChSaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j1WOdV/5eyYbR4vnFQdU2guY+Bh21vaifn/Wuc6KTLUu/lMnsg6MuebHGddbuLb4w
	 bdoktTaHpRfvxam2eZFYS+QIzbohUdabe62O2krkYoBZPw8M6UC29WSLDd+9N3nr/l
	 Ix7QoGN/K6GrZLuvVqV7DBULYNElGWSLVp8ZNdsAjJ6Jcww6b06NSvl2Gsu3LZSaL1
	 crJF9qVM6CP/HZKCfW99rjzhsJygWKU7/KbPJ9KdAODg/atpPrXS/q1VN4sshNEBfs
	 Mt5ojREQkQcMEnRDIV1x0RYLUrtF655ArH4Cg7F7JKRScEEVTJUvqWdbpvStAkKL2z
	 q8lj/N9Jhta4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2045DD4EFE;
	Thu, 14 Dec 2023 03:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] dpaa2-switch: various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252282578.11535.15284744936202542226.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 03:00:25 +0000
References: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
In-Reply-To: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 18:43:24 +0200 you wrote:
> The first patch fixes the size passed to two dma_unmap_single() calls
> which was wrongly put as the size of the pointer.
> 
> The second patch is new to this series and reverts the behavior of the
> dpaa2-switch driver to not ask for object replay upon offloading so that
> we avoid the errors encountered when a VLAN is installed multiple times
> on the same port.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] dpaa2-switch: fix size of the dma_unmap
    https://git.kernel.org/netdev/net/c/2aad7d4189a9
  - [net,v2,2/2] dpaa2-switch: do not ask for MDB, VLAN and FDB replay
    https://git.kernel.org/netdev/net/c/f24a49a375f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




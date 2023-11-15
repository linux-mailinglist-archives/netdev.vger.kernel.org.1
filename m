Return-Path: <netdev+bounces-47893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAB7EBC88
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78654B20A37
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE730A5C;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LncCrLuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253B80C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 382FDC433C7;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700021424;
	bh=ca3FaTTf7xF55RsKRMX9OUsVJi1TLI/WiEgTlTUi70s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LncCrLuTIkxhst59rQjeiWuyuRJL+2PgAFHl4nze3tMETIJqL9qIu/rSLf4BHCrFZ
	 ciHigk8nN2CtTOubbIeXyu4KmjeD1NzzzVjSeKL6YEwHvP9qfB2DsxrlPPSCgnvAal
	 llSFhpziYuhezt/M8AbncueSscb3HalfLh/W7hf+y7MNraxd/rhfKQ8iYymKNDkQ8G
	 GF7AFYWqN7g8Wa/MY1BKumQdZoC8Ns2COL0ssU8prs4WCdhTFrmfTk2SvS6vMguA+n
	 ncVuMr8Y8j4HJfwpnEGOHYZxwDgkXc+Izca/BdgU+lvGfkrppIYZukoo6S862f/yBo
	 xo7nfLfpri+rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24374E1F671;
	Wed, 15 Nov 2023 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2023-11-13 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002142414.20125.15013807766954840836.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:10:24 +0000
References: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 13 Nov 2023 15:05:45 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Arkadiusz ensures the device is initialized with valid lock status
> value. He also removes range checking of dpll priority to allow firmware
> to process the request; supported values are firmware dependent.
> Finally, he removes setting of can change capability for pins that
> cannot be changed.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: dpll: fix initial lock status of dpll
    https://git.kernel.org/netdev/net/c/7a1aba89ac54
  - [net,2/4] ice: dpll: fix check for dpll input priority range
    https://git.kernel.org/netdev/net/c/4a4027f25dc3
  - [net,3/4] ice: dpll: fix output pin capabilities
    https://git.kernel.org/netdev/net/c/6db5f2cd9ebb
  - [net,4/4] ice: fix DDP package download for packages without signature segment
    https://git.kernel.org/netdev/net/c/a778616e4cc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-61412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5FD823A13
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A533B2481F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C06376;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2ldSHLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BADA2A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC5EC433C8;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330625;
	bh=Une7s4zuvc12YtkykhavKdDsl78p5wuZ30KaTvKWC9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k2ldSHLn8lvUX4v0/4ZDNRH1OMc4ipK1DRZ7YqMxsmbseypkBrkm6usM6ShBLe3F7
	 /2+2rMp3UjxTZYP25HQUBX+9sWo3dXbxuQebNa8MozYCkioWrOtCuH++Fmy2ETo4/F
	 FsEehtF2dPDi4mprJIU6Z0T/HrgS/1fucYbmX2M0ssk7ddl28jmxmEPT+C/MxNnvW9
	 HPlfNBlmUpcsvtfkV8SVB1JX2sFekYy10ExYelAkLF75kZ/T2Bp7EIyuD5gIWadoOX
	 uYBr6/T6dDbVXV9fkcab2+CMhwSNKbNRQYUKblbXdT+CQzyzvheveBdmGzqXBN0gsJ
	 nlL3kP48SfbpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C15C43168;
	Thu,  4 Jan 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2023-12-27 (ice, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433062534.12007.1957974757794986044.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:10:25 +0000
References: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 27 Dec 2023 10:25:29 -0800 you wrote:
> This series contains updates to ice and i40e drivers.
> 
> Katarzyna changes message to no longer be reported as error under
> certain conditions as it can be expected on ice.
> 
> Ngai-Mint ensures VSI is always closed when stopping interface to
> prevent NULL pointer dereference for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: Fix link_down_on_close message
    https://git.kernel.org/netdev/net/c/6a8d8bb55e70
  - [net,2/4] ice: Shut down VSI with "link-down-on-close" enabled
    https://git.kernel.org/netdev/net/c/6d05ff55ef4f
  - [net,3/4] ice: dpll: fix phase offset value
    https://git.kernel.org/netdev/net/c/8278a6a43d03
  - [net,4/4] i40e: Fix filter input checks to prevent config with invalid values
    https://git.kernel.org/netdev/net/c/3e48041d9820

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




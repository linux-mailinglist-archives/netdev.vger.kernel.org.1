Return-Path: <netdev+bounces-54727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1C807F67
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 05:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F0B1C2095F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957355682;
	Thu,  7 Dec 2023 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFzuuZ4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACF65236
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C294EC433CB;
	Thu,  7 Dec 2023 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701921624;
	bh=JDdZ5Zt6I74tHSy3LpT4x1YhfQTqQHBqKh7JRDrzHBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FFzuuZ4hSggHDkWetVDeFXqf+HzF9rv1NQ8MXCOv2jdhGwFGeqzqnQFUKgj1x9ChJ
	 +xYsf2a0sQ3glfihk+omeHCVa9QytLVSf+WeGInnZqGscIIAAMxv973+4dvJt+xLeM
	 6qzHpD+nejDSJchfENzR55PK6Py33mXXHuX81kHzVRI/VLwFGo/rYYlIipbLeTte2z
	 u1qxDhDUdwPexaVQwg/M4xWpk8Y88CqaQCo/FgtmQ64h20wBR22dNQj5uN3zxLIIbq
	 tSML5go/CgL0w7/0wRGmelBI3YUMqP1Ob+NeyyoXjGFkCSfkbrw270Wp+cI81XwdyI
	 mtOHjRuOfB5ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7863DD4EED;
	Thu,  7 Dec 2023 04:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2023-12-05 (ice, i40e, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170192162468.29642.16211302491351895096.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 04:00:24 +0000
References: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  5 Dec 2023 13:19:11 -0800 you wrote:
> This series contains updates to ice, i40e and iavf drivers.
> 
> Michal fixes incorrect usage of VF MSIX value and index calculation for
> ice.
> 
> Marcin restores disabling of Rx VLAN filtering which was inadvertently
> removed for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: change vfs.num_msix_per to vf->num_msix
    https://git.kernel.org/netdev/net/c/f8e9889f54da
  - [net,2/4] ice: Restore fix disabling RX VLAN filtering
    https://git.kernel.org/netdev/net/c/4e7f0087b058
  - [net,3/4] i40e: Fix unexpected MFS warning message
    https://git.kernel.org/netdev/net/c/7d9f22b3d3ef
  - [net,4/4] iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero
    https://git.kernel.org/netdev/net/c/a206d9959f5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-57200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9480081255A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02AE282923
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8515ECB;
	Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPdGwY0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D5A59
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C30F5C433C7;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521625;
	bh=RkWa2Vxp48FvhWUEDd4UAUVq0uHmwOqAASOVffoictA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EPdGwY0Ea+enh+Og3ixNEC6JafTwyIRlyh5MeZWpXddI8G+rXhH/A8j0nx1UAUGxQ
	 aVQtVj+0naW/8J9yOrt9+fj03e1LhjGcoLlDIiMm/o+eWQnEme+KPk0jiwTsZBttB/
	 WNSUNXy36Rg+MCrk0tCNdZUQ1RyE31NQhiLCo/TRcO3GVRmKo7U8CEs+fB4Sx7v7Uu
	 dNV4UEB/xAeB7PCLyDwr5U1Tp8LJpoO3XqfcpE2uTkywvSKtiXW1Kr9W8Cl+WCWPf6
	 mc+qFupyP8IJXKG5+h4B+jhBgxLWKJD8Yw5FPyqyG++ddSY1+Q7+DzcyQ5L4MgR8ty
	 mI1SpzuTSnH/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5104DD4EFE;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header split
 ringparam
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252162566.2494.10156204711336606229.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.kubiak@intel.com, przemyslaw.kitszel@intel.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, mkubecek@suse.cz, jiri@resnulli.us,
 paul.greenwalt@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 15:27:50 +0100 you wrote:
> Currently, the header split feature (putting headers in one smaller
> buffer and then the data in a separate bigger one) is always enabled
> in idpf when supported.
> One may want to not have fragmented frames per each packet, for example,
> to avoid XDP frags. To better optimize setups for particular workloads,
> add ability to switch the header split state on and off via Ethtool's
> ringparams, as well as to query the current status.
> There's currently only GET in the Ethtool Netlink interface for now,
> so add SET first. I suspect idpf is not the only one supporting this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ethtool: add SET for TCP_DATA_SPLIT ringparam
    https://git.kernel.org/netdev/net-next/c/50d73710715d
  - [net-next,2/2] idpf: add get/set for Ethtool's header split ringparam
    https://git.kernel.org/netdev/net-next/c/9b1aa3ef2328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




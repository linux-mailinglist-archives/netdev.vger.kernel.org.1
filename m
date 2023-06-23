Return-Path: <netdev+bounces-13251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6673AEDA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDAF1C20DE8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0AA3B;
	Fri, 23 Jun 2023 03:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D07FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E82BC433C8;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489222;
	bh=0JkyIVBnd41yhwJ/QEUIjTSJ0oWR6KC7ItefkDu2r3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZatUw6p6nM0F29QVi33QAm/t9MCDfEBTFLCtmqgQwmDX1V85gH+Rv54b0SMUgV2G
	 EOYqMWieu/zVImYPDC3ntfypAcTazTHiDZUa7/LpzfL9q5ucvJnbA7NjXI7G6Hsou0
	 pjI3IfN+iriNTak9XF67ICIYPiTY/aTYj3tNfw7PSNF89vsIr9AXAKanzH0cyCaSRW
	 +ZtgkD3JfCOzd3qXiJ2uRynE04fDfeYvSKwvA1gtmRawZONtrTK5dOo8j33ZhLg0PR
	 sEjoUuvt2JhhzqUnBR6SNl5l99ULNJXX/WvPPI8uMnIlOHLEbV23KIkXTgZ9KiOFTm
	 nhxC6UiPRuMwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 287CFC691EE;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fix net device address assign type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748922216.4682.2341542021335233510.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621132106.991342-1-piotrx.gardocki@intel.com>
In-Reply-To: <20230621132106.991342-1-piotrx.gardocki@intel.com>
To: Piotr Gardocki <piotrx.gardocki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, michal.swiatkowski@linux.intel.com,
 pmenzel@molgen.mpg.de, kuba@kernel.org, maciej.fijalkowski@intel.com,
 anthony.l.nguyen@intel.com, simon.horman@corigine.com,
 aleksander.lobakin@intel.com, gal@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 15:21:06 +0200 you wrote:
> Commit ad72c4a06acc introduced optimization to return from function
> quickly if the MAC address is not changing at all. It was reported
> that such change causes dev->addr_assign_type to not change
> to NET_ADDR_SET from _PERM or _RANDOM.
> Restore the old behavior and skip only call to ndo_set_mac_address.
> 
> Fixes: ad72c4a06acc ("net: add check for current MAC address in dev_set_mac_address")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix net device address assign type
    https://git.kernel.org/netdev/net-next/c/0ec92a8f56ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




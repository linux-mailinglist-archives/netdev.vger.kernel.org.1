Return-Path: <netdev+bounces-54929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7B808F37
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B6B1F2119B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDD4B5C3;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1kmy7ii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDA4B5B2
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44260C433CB;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701972027;
	bh=ktLzJMGSuJbVN47s+rs99Zm1xBcnsPw3uH3ENqOgGYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I1kmy7iiFoTx5YBdnEio8cdRD8c5xKEsAuVGqNS/R73BoeF3Kansp0hhCc3WpZZRW
	 69ZyxPQx2sGS+7MUTTNMvPU66UfvZKP7LNCsZDonlUS+ouGwrTyMiOvfGgwtF8ZRVV
	 hIMbUj7F4ZILcFI7Jrbrx/rCIBsLKci47tTU/Hr9jw4GaZNbKI1WI0QjQgcP7uihaO
	 GrbU06WvmZEp6kMfKiHhqui6w5fxQT5S/VDpjsip5IN6QvDDuyGcH1a74LU1WxZdXJ
	 wGcGQTyklv09ndHIda7plm+25x/V4S2Z8ixWoP0JREHyYCv64++Rk/Sfx7izN9rPNO
	 GnZN8Gc1G85xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24A93DD4F1D;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Generic netlink multicast fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197202713.7796.14854919383895548891.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 18:00:27 +0000
References: <20231206213102.1824398-1-idosch@nvidia.com>
In-Reply-To: <20231206213102.1824398-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, nhorman@tuxdriver.com,
 yotam.gi@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net,
 jacob.e.keller@intel.com, horms@kernel.org,
 andriy.shevchenko@linux.intel.com, jhs@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Dec 2023 23:31:00 +0200 you wrote:
> Restrict two generic netlink multicast groups - in the "psample" and
> "NET_DM" families - to be root-only with the appropriate capabilities.
> See individual patches for more details.
> 
> Ido Schimmel (2):
>   psample: Require 'CAP_NET_ADMIN' when joining "packets" group
>   drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
> 
> [...]

Here is the summary with links:
  - [net,1/2] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
    https://git.kernel.org/netdev/net/c/44ec98ea5ea9
  - [net,2/2] drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
    https://git.kernel.org/netdev/net/c/e03781879a0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




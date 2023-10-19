Return-Path: <netdev+bounces-42572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DB7CF5FC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0C71C20A12
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D21805D;
	Thu, 19 Oct 2023 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBQqtl+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DD11708
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78ACC433C7;
	Thu, 19 Oct 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697713224;
	bh=xR9lGrNoIYXivbzzFkK5ayJiO+oyc+Q4ICPjEexkzcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oBQqtl+lBhBfimEtNmnfYRYfRIJaP9+FYUOfXOlVmZFtVgQbnWTU2fqPdn+j/3p2P
	 8K01j99NzMtw7x1LU2kVBQLFYSJIXUWP02ug9pAphAMiR9OIpAO0zCryMI2+oQ7Kla
	 +6GEXgbgRX8H3Hm4abOsYasnSdOyYZXdNrm6sYxeFzL0/9NQPKLziW3Dkf5Tv6Obxg
	 p3NNJQDAEkKsXebWIceRfATPtESIU5uQuybzHC20k6wXh1bHK+3Hj7hxgB4bWIJarR
	 Na+DeBDWmARGsoi3TwDzSqYp1gdjEn2c50m+OChtdXj3JYP1pntOh8NKgK6EuSs7hw
	 0FELRM/gRtUMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D941C04DD9;
	Thu, 19 Oct 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: Fix mixed module-builtin object
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169771322457.21860.12161979997200225746.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 11:00:24 +0000
References: <20231018064936.3146846-1-danishanwar@ti.com>
In-Reply-To: <20231018064936.3146846-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew@lunn.ch, arnd@arndb.de, horms@kernel.org, vigneshr@ti.com,
 rogerq@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 srk@ti.com, r-gunasekaran@ti.com, rogerq@kernel.org,
 aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 12:19:36 +0530 you wrote:
> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
> 
> The build system is complaining about the following:
> 
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: Fix mixed module-builtin object
    https://git.kernel.org/netdev/net/c/a602ee3176a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-42716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C276B7CFF1E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C8C1C208E4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B4321A4;
	Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzctAb/T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0532FE16
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC5BC433C8;
	Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697731822;
	bh=cBykJKHjrNAgWJmxcWiJVzH9YSi11Z2q3/uU3/UjPow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EzctAb/TkV4IHS5t4wBsWrt4eEnL//5F+R3/e4URIS6ajH9qIDAbNSTQ2niR53SCA
	 7ovlN06BWaG1bwo+uMIvvO1S42qGIFR6obEit1Lh+2PQZ/zF8rF+OOCq4ydp+w0CNz
	 lOwdkcJgMVS1gFeNUe20BVZyLBK6qLCbVTyWJvibVBrQbj8j/OHPqMsBdKxV3BrWHO
	 r64ktG+jeaW+X+o9+ukJr2UGXuKzzsyD/MIui+DJxgdVGeHLKxcpy0CmA0Ou8BgUiG
	 yEKZpcJ9KSkCWfrYztLENpp0DR4HD1CWMnQaOBSb5lZF5bzxiKV8kA4KJDtzEwgWLy
	 1/9tYJKmGHAqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 238FDC04DD9;
	Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169773182214.32102.11595509429600832386.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 16:10:22 +0000
References: <20231018150715.3085380-1-danishanwar@ti.com>
In-Reply-To: <20231018150715.3085380-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew@lunn.ch, grygorii.strashko@ti.com, vigneshr@ti.com,
 jacob.e.keller@intel.com, rogerq@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
 r-gunasekaran@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 20:37:15 +0530 you wrote:
> The bitmasks for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD r30 commands are
> wrong in the driver.
> 
> Update the bitmasks of these commands to the correct ones as used by the
> ICSSG firmware. These bitmasks are backwards compatible and work with
> any ICSSG firmware version.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
    https://git.kernel.org/netdev/net/c/389db4fd673e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




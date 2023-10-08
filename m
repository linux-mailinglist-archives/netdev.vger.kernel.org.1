Return-Path: <netdev+bounces-38901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663337BCF44
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74482814B0
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347A1172C;
	Sun,  8 Oct 2023 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLkCvOmy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08411706
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EC15C433C8;
	Sun,  8 Oct 2023 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696783297;
	bh=Fy5jIMKkOdHTuXl36/YKHyEm7PeJ61pD2CA+Dt0YG4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLkCvOmyz0mvyawAYFBho+k89Efz2LBd9rWQcTJ5pi27ECOTQp574BsST03RAztYC
	 xAoTn6mXFUdxvqtj8pcGCwOx8dR5fPbMb63j/7G4t2ddlG6174v23yfqqXvFLXjI9A
	 ocKGOj9g9saSY7BnZtZA2fDTDTJ7S7eTE1rtFdmKu3TC3KQ27V75KHLnWIKPmnIhPr
	 B6Ht2Z9uw413UgKQRYojt3XXBQptpQAJlPxUhd0QxVYivl6MoSAzCUGvQzpAHhxNjS
	 WrUcyTwySVACOvIzAnRL/bHgqV5hM7iFVz6gegCRUzY+jNSJ52PGfOVJB6II+/U6/9
	 WXQKJ+OUkUKkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCDB9C64459;
	Sun,  8 Oct 2023 16:41:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: block default rule setting on LAG interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169678329689.30377.1997538579923324646.git-patchwork-notify@kernel.org>
Date: Sun, 08 Oct 2023 16:41:36 +0000
References: <20231005163330.3219008-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231005163330.3219008-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, daniel.machon@microchip.com,
 david.m.ertman@intel.com, marcin.szycik@linux.intel.com,
 przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com, horms@kernel.org,
 sujai.buvaneswaran@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  5 Oct 2023 09:33:30 -0700 you wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> When one of the LAG interfaces is in switchdev mode, setting default rule
> can't be done.
> 
> The interface on which switchdev is running has ice_set_rx_mode() blocked
> to avoid default rule adding (and other rules). The other interfaces
> (without switchdev running but connected via bond with interface that
> runs switchdev) can't follow the same scheme, because rx filtering needs
> to be disabled when failover happens. Notification for bridge to set
> promisc mode seems like good place to do that.
> 
> [...]

Here is the summary with links:
  - [net] ice: block default rule setting on LAG interface
    https://git.kernel.org/netdev/net/c/776fe19953b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-21264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941FD7630AB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40B0281C87
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616DAD46;
	Wed, 26 Jul 2023 09:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590A849C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ED4BC433C9;
	Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690362020;
	bh=5DswEsNG69Uk11VvpOyj1fz3E3XLr3k52DbFt4XEzq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNj/mHqWAJ0RZTHSDf0f2l8CALgpWY38XVYNr5MRrK/3LbnaYp/7PtZzp0fcQ3XJE
	 wI9CSZkgPCm0AjaIeuM/YTwBhKeNd5aNfxxB8F86Wuzs+A6uIcLNnrZ6EZ+i5dKo6v
	 fRw0ESgeMrvZoUJ+/ohP5JYwza9UA8eatnrC/b3ui1ptK0iFecS9M2XE0Lo2lmkrcI
	 xyXZ5eWrGMFbP5c9ajfhbsqMZZw6ajIzu1gmRcb1vyHhUTD5mTkEiDdfXz70jDm+E1
	 MK99izX0US/JVtuZwJXfEW0RHZ41H0bOCytRyUh95TaIIBNqmDkH94jEs3gAWa+roA
	 /Q39eZVAJFs2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FF87C41672;
	Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix Kernel Panic during ndo_tx_timeout callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169036202006.9751.14838125009002591135.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 09:00:20 +0000
References: <20230724161250.2177321-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230724161250.2177321-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 muhammad.husaini.zulkifli@intel.com, sasha.neftin@intel.com,
 alejandra.victoria.alcaraz@intel.com, naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 24 Jul 2023 09:12:50 -0700 you wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> The Xeon validation group has been carrying out some loaded tests
> with various HW configurations, and they have seen some transmit
> queue time out happening during the test. This will cause the
> reset adapter function to be called by igc_tx_timeout().
> Similar race conditions may arise when the interface is being brought
> down and up in igc_reinit_locked(), an interrupt being generated, and
> igc_clean_tx_irq() being called to complete the TX.
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix Kernel Panic during ndo_tx_timeout callback
    https://git.kernel.org/netdev/net/c/d4a7ce642100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




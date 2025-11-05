Return-Path: <netdev+bounces-235680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D6C33B44
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB284641EB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6541A23B9;
	Wed,  5 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMZC1xob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97A18DB2A
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307442; cv=none; b=OwpOpq97Z70iCStQO6NW49n1R9MNkXwSAzQeILzaOzcW1E48K+AKo74iv6pq+AOePjrlIze1eKv1Em03PhlIdOxDUGITjA+5TsXktZk/lBhHZy4U3DeGZ+hF7TZW+92OHY8b4bgctDEehdzLPYlr79eWuv/HEnWggPk3OywtZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307442; c=relaxed/simple;
	bh=0mBzBlQwXGorXEifmZTWdlG1jyZb8jX7hEwudc0iRy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TKtSkPRD9uzwY5tbYpbotCecNoxuGDr6fKG7Ij7u2ToLS8jFlLS8HvtfRNcYK4goDQ88GG6IneXtqm+2f4PFA/LbRyfxZf7ySo8KIecYQCOX1IV7vpIoitY4D6xPbAETZ9/suBcndkNIaoMzHgjzrJgsLe06X7YIB+GCThQa2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMZC1xob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDBFC116D0;
	Wed,  5 Nov 2025 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307441;
	bh=0mBzBlQwXGorXEifmZTWdlG1jyZb8jX7hEwudc0iRy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MMZC1xobgMxy5ev5wYjvRtCg+5fqajpoI+e3k4ccnwvdAznnPQSi9xx6pRoWzydFY
	 q4C6nB8UyjhgF2hW5+R7y/ySmNuXpgyWQ7RsLwj6MFeQ/ruUrCoIQGdjFUrflwiTCq
	 o/kKkuZFTPZ0LXMHGUhxJ9aAIzXQn53ai2WlOvDkk/0+ZlxdNWMLhPpmnXWB87J6N4
	 75lm0mi9Ie4DD+a6tr5mzZAYHA9kJv80i7tkxJmoEnvZHRkpckqPKhFSPTCYUrkypv
	 eQKEnPYuRXFSBFjrIOVhX3ryA8BUXY7hI/s2MKeb6OANCROH/s1slWdJTqaanbcUlt
	 0yc66AYpHp96A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD3380AA54;
	Wed,  5 Nov 2025 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] convert drivers to use ndo_hwtstamp
 callbacks
 part 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230741525.3056420.8097169930615597775.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:50:15 +0000
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: manishc@marvell.com, marco.crivellari@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 vladimir.oltean@nxp.com, horms@kernel.org, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 15:09:45 +0000 you wrote:
> This patchset converts the rest of ethernet drivers to use ndo callbacks
> instead ioctl to configure and report time stamping. The drivers in part
> 3 originally implemented only SIOCSHWTSTAMP command, but converted to
> also provide configuration back to users.
> 
> v1 -> v2:
> - avoid changing logic in phc_gbe driver for HWTSTAMP_FILTER_PTP_V1_L4_SYNC
>   case
> - nit fixing in patch 4 wording
> - collect review tags
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] bnx2x: convert to use ndo_hwtstamp callbacks
    (no matching commit)
  - [net-next,v2,2/7] net: liquidio: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/2b3844754881
  - [net-next,v2,3/7] net: liquidio_vf: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/94037a0e18e3
  - [net-next,v2,4/7] net: octeon: mgmt: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/72c35e3a9589
  - [net-next,v2,5/7] net: thunderx: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/a23d0486d05a
  - [net-next,v2,6/7] net: pch_gbe: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/d8fdc7069474
  - [net-next,v2,7/7] qede: convert to use ndo_hwtstamp callbacks
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




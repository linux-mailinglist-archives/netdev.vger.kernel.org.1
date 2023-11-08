Return-Path: <netdev+bounces-46562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1AD7E4F54
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F251C20D7D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC21370;
	Wed,  8 Nov 2023 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJWt7UVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DA10FE;
	Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FD5C433C7;
	Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699413024;
	bh=rvO7jgle+mBgmeKkpTDDNi586VSWjG2AZorz5TM46Fo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PJWt7UVn2GlE0Ilk3Bc7/fvgogLAUVoTja/zp8MMHEYU1UdyrWmovEqP0+Gv80cAD
	 A1lU2L9bHKELNvtWSQbgKS42MBO9QkuCPl4nMj7jBuiJKbESSfDWfXr9vYk2pfq1iV
	 LgoDq0PElvrxrAgDCeDgNdRbdVAUU2yxVyybWNipk0/SmW07km73mI7vaNp2uD94qP
	 a/UTz0vsqYtPwh9rip5mmKIcjBZ74Sjt5g5jY4hgHLakrdvisBoKQHb3+NGHMyeQdo
	 zmxvsBtDYAJW0jWHXa9KZCG6uoenqKkSsRTZe3MmO15cf0bRgeZgEW1iZYZ3JQj/IB
	 JqJ2r4kO+K5Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D5FFE00089;
	Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: shorten enetc_setup_xdp_prog() error message
 to fit NETLINK_MAX_FMTMSG_LEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169941302444.21503.2410496259259680243.git-patchwork-notify@kernel.org>
Date: Wed, 08 Nov 2023 03:10:24 +0000
References: <20231106160311.616118-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231106160311.616118-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, simon.horman@corigine.com,
 claudiu.manoil@nxp.com, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Nov 2023 18:03:11 +0200 you wrote:
> NETLINK_MAX_FMTMSG_LEN is currently hardcoded to 80, and we provide an
> error printf-formatted string having 96 characters including the
> terminating \0. Assuming each %d (representing a queue) gets replaced by
> a number having at most 2 digits (a reasonable assumption), the final
> string is also 96 characters wide, which is too much.
> 
> Reduce the verbiage a bit by removing some (partially) redundant words,
> which makes the new printf-formatted string be 73 characters wide with
> the trailing newline.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN
    https://git.kernel.org/netdev/net/c/f968c56417f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




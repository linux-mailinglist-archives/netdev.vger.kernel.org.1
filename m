Return-Path: <netdev+bounces-25639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4B774F90
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74421C210B9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC381CA08;
	Tue,  8 Aug 2023 23:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0051CA09
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A1CC433C9;
	Tue,  8 Aug 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538622;
	bh=M3TRlWSBQkE2wV/TDXfwsr+AMZkpabLmZIZAXdgcO1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rTRKAnr8w/bUQzW9U8cI4JviJKMbAfPYSoQd+XL5z+hsb4S2kFjxMPXY8/QEmxu9+
	 K8kP4FQAllMDQFjugJD3tBkEB4rzC8qkzmuZB2XQg27OuNl8UHNuaEwDkFp5FYEwx0
	 HZkBlOJpX8K8bGEh+oqIsqGKEHOhdJVYlp9PdkvDarRcsOEwHdFs0j2r17DkqEhr75
	 o78dJmcN/6WElqADYfF8IXNQt8/cNTpQoJOWcH8JC358fN6FCkbL20x1B7ZaKCApR5
	 KerY/yIz0PRiJeAGX6qU8GYZcDTWier34ycS7oLUROy0jBGLEKGo449D7srOTCnmjM
	 YEd71GN1O2EvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B394C595C2;
	Tue,  8 Aug 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6][pull request] Intel Wired LAN Driver Updates
 2023-08-07 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153862236.1266.11255834550876220375.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:50:22 +0000
References: <20230807204835.3129164-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230807204835.3129164-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  7 Aug 2023 13:48:29 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Wojciech allows for LAG interfaces to be used for bridge offloads.
> 
> Marcin tracks additional metadata for filtering rules to aid in proper
> differentiation of similar rules. He also renames some flags that
> do not entirely describe their representation.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] ice: Accept LAG netdevs in bridge offloads
    https://git.kernel.org/netdev/net-next/c/505a1fdadac1
  - [net-next,v2,2/6] ice: Add direction metadata
    https://git.kernel.org/netdev/net-next/c/0960a27bd479
  - [net-next,v2,3/6] ice: Rename enum ice_pkt_flags values
    https://git.kernel.org/netdev/net-next/c/41ad9f8ee6b8
  - [net-next,v2,4/6] ice: Add get C827 PHY index function
    https://git.kernel.org/netdev/net-next/c/272ad7944a7b
  - [net-next,v2,5/6] ice: add FW load wait
    https://git.kernel.org/netdev/net-next/c/5708155d902d
  - [net-next,v2,6/6] ice: clean up __ice_aq_get_set_rss_lut()
    https://git.kernel.org/netdev/net-next/c/b6143c9b073f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




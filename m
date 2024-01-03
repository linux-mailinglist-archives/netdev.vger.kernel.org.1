Return-Path: <netdev+bounces-61063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D08225D4
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1555D1F22835
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C563F;
	Wed,  3 Jan 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8l4fP+f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8C632
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC1F4C433CC;
	Wed,  3 Jan 2024 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704240624;
	bh=wXZiKTIkjpRj7GdxkuEQnqZIOijMUTjcofi9s6s6vBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g8l4fP+fHV8zFqChrJgAkyRfUBneQNUL+2KEZOtuAzrjTrWBsj1qIZiI0peh8efPW
	 ulgiePDHvx4yTGVdpUzNsSNagi1Sr0ywRVSaE49sWNQIhN8Kw8660sSXXLDoHFNp1u
	 1TUxAJWE+2pUrTY3gDVhl8hqPO7P/Kad2UhR6dnzmTnizJTFgAdJAey+NFCsUtjtHP
	 L+vQhmWUiv7rlLjodp1PegT7TO09EckFDGMdu+wlTJJZfqdtK8LSpubwwtKlGBHSkx
	 KYiD+DU+MeNVyzbqpON+/+/kKU7E3ea9UqQ2omKfRCFh0eERTNX4yt1n69eQ0f1QG7
	 ljg3txkgOx/0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 961D8DCB6D1;
	Wed,  3 Jan 2024 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Bug fixes for RSS symmetric-xor 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424062461.8088.3644871226519179265.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:10:24 +0000
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
In-Reply-To: <20231221184235.9192-1-ahmed.zaki@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch,
 horms@kernel.org, mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 gal@nvidia.com, alexander.duyck@gmail.com, ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Dec 2023 11:42:33 -0700 you wrote:
> A couple of fixes for the symmetric-xor recently merged in net-next [1].
> 
> The first patch copies the xfrm value back to user-space when ethtool is
> built with --disable-netlink. The second allows ethtool to change other
> RSS attributes while not changing the xfrm values.
> 
> Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/ [1]
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ethtool: copy input_xfrm to user-space in ethtool_get_rxfh
    https://git.kernel.org/netdev/net-next/c/7c402f77e8cb
  - [net-next,2/2] net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm
    https://git.kernel.org/netdev/net-next/c/0dd415d15505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




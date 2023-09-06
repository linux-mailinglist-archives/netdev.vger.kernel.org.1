Return-Path: <netdev+bounces-32177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1949F7934BC
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076841C2096D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7EA3C;
	Wed,  6 Sep 2023 05:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B0808
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2289C433CB;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693977022;
	bh=qT/y5R9fBn1NeTGnJI8nbaXj2qg7qzFGbubGB+tg3Sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrUqxu1iUAhpkD1yEoMkiIAziUwxl0YqGZ5Pa0bip6wqDQLMvoAoN/hlWcLmA0B5Y
	 GtYPuQ/YwY1H6VvDvfgzVuRa74Vsi7AB0p1WSVtbohQuM2N3rbzxpkfYGmqg/YPRVo
	 Jej7oV5LsUxjeHaiYiYKirgi9y3OgY6SuY+T6x3qbnSPYA5NotYcoI4rVQdyTsFs95
	 eH7+pzZuuzDxWawetuka30UC3qWHyM/odtQPW5gv4UQMaxhM7GshTq9AnrO6+p0xkp
	 xzVXiMGw27/PnQY6F3wIT8GdwUMFMJjWS8OK1wIo+bs757u6jUeR5IYMyiG55eR/Rk
	 GB/votDSMLP8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8704E22B00;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/ipv6: SKB symmetric hash should incorporate
 transport ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169397702275.22023.11705389195236834744.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 05:10:22 +0000
References: <20230905103610.3087983-1-qtian@vmware.com>
In-Reply-To: <20230905103610.3087983-1-qtian@vmware.com>
To: Quan Tian <qtian@vmware.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 uablrek@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Sep 2023 10:36:10 +0000 you wrote:
> __skb_get_hash_symmetric() was added to compute a symmetric hash over
> the protocol, addresses and transport ports, by commit eb70db875671
> ("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
> flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
> IPv4 addresses, IPv6 addresses and ports. However, it should not specify
> the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
> dissection when an IPv6 flow label is encountered, making transport
> ports not being incorporated in such case.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/ipv6: SKB symmetric hash should incorporate transport ports
    https://git.kernel.org/netdev/net/c/a5e2151ff9d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




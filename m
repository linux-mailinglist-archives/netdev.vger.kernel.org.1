Return-Path: <netdev+bounces-20275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0E75EDF9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0187E28147D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D64C9D;
	Mon, 24 Jul 2023 08:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FB1872
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7EEDC43397;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690188027;
	bh=C+fpzMa4VtKtT5Coo9EgNamXVyGIEmCRJSTqQ3DuYTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m045UyKugNzu3fpp4ACAh1q0ohZdGpnm5OguRsSSmWVUUwh2VlR21oz0jZwofzHEH
	 B3Cezn4uM1LRMockRJbxnMsIEg6UcrODmhaDOwXiDOHNoBzqxm4eneYc4ZgXhWGANs
	 ve0zYTRO3id6YZCkyRtC54bj9XFT1oxO5Z5kT2HJTU3Qy9Ix+R5QctRktn9jCP0bM3
	 sJWXzsNnShbCTjt/EMwHJu5/xG9ZPhgTnFLSDsCpF7/oXBUFTAX5R0500y9uWcVWe0
	 xOxieXYidUxy366rzEmh50g6BT5/UEOO/Ch2LY6Cq237OB3U7EucVdwQowdwpbm6hL
	 tSXoEdJd/Gyhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD9A7C595D7;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: remove hard coded limitation on ipv6_pinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169018802783.2769.2075030751737520143.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 08:40:27 +0000
References: <20230720110901.83207-1-edumazet@google.com>
In-Reply-To: <20230720110901.83207-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, wwchao@google.com,
 weiwan@google.com, lixiaoyan@google.com, zhuyifei@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 11:09:01 +0000 you wrote:
> IPv6 inet sockets are supposed to have a "struct ipv6_pinfo"
> field at the end of their definition, so that inet6_sk_generic()
> can derive from socket size the offset of the "struct ipv6_pinfo".
> 
> This is very fragile, and prevents adding bigger alignment
> in sockets, because inet6_sk_generic() does not work
> if the compiler adds padding after the ipv6_pinfo component.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: remove hard coded limitation on ipv6_pinfo
    https://git.kernel.org/netdev/net-next/c/f5f80e32de12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




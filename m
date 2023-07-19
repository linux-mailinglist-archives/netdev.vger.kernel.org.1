Return-Path: <netdev+bounces-18941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65C759268
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611D31C20DFC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4412B68;
	Wed, 19 Jul 2023 10:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522F125C3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D67C433C7;
	Wed, 19 Jul 2023 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689761421;
	bh=Szvpo3jPm6xFX2CjBL67LKjIExmiX39UOjbELPu04do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=odSk7cwk85Y6E1GTrYTfQD1t32H3n/cthps7bvDWi6t9BU8kCbHvF248DGEJp5OJa
	 2e+VMlRR+dzd8d/bLuuHVgh7uKBnPVJ/8hdWGqKzoDbl+YyfNgf5xEdaokISiASd3H
	 B+9MYyYcx7znGy0E+pSf+7xpUDks6W4jIBrDehtwH9Qo5qKxMHP+UMo1BqeIJYjeuE
	 VLn0sbvBWaVHoT0wc3wKqTU0BPV91hQLqPj9EZTHI3ukWznUWI6q+8s6mwxaUs7l+S
	 5bu5+IkfiEwLHUrIFRcG1EWiXFeecPx7gD2y5qz9a+E2wcoSyzf/nKxtqM1xoxi8To
	 aZcATMuwohoGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD025C6445A;
	Wed, 19 Jul 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] Add backup nexthop ID support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976142170.5988.10461851053537614919.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 10:10:21 +0000
References: <20230717081229.81917-1-idosch@nvidia.com>
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, roopa@nvidia.com, dsahern@gmail.com, petrm@nvidia.com,
 taspelund@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 11:12:25 +0300 you wrote:
> tl;dr
> =====
> 
> This patchset adds a new bridge port attribute specifying the nexthop
> object ID to attach to a redirected skb as tunnel metadata. The ID is
> used by the VXLAN driver to choose the target VTEP for the skb. This is
> useful for EVPN multi-homing, where we want to redirect local
> (intra-rack) traffic upon carrier loss through one of the other VTEPs
> (ES peers) connected to the target host.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ip_tunnels: Add nexthop ID field to ip_tunnel_key
    https://git.kernel.org/netdev/net-next/c/8bb5e82589f0
  - [net-next,v2,2/4] vxlan: Add support for nexthop ID metadata
    https://git.kernel.org/netdev/net-next/c/d977e1c8e3a1
  - [net-next,v2,3/4] bridge: Add backup nexthop ID support
    https://git.kernel.org/netdev/net-next/c/29cfb2aaa442
  - [net-next,v2,4/4] selftests: net: Add bridge backup port and backup nexthop ID test
    https://git.kernel.org/netdev/net-next/c/b408453053fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




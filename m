Return-Path: <netdev+bounces-20274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8375EDF6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771A028147D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47275231;
	Mon, 24 Jul 2023 08:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28961186D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9923CC433CB;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690188027;
	bh=TpgUbozXV/DUy9JJQmxF+qbYFj8GJFLBDP0xCpyJ3PM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1KquQNGQvbAsWqik1zo+n1AMNv2X35YA1DR/0Cyi2UVfCG7r76gaXAOMralEPf3Q
	 ++CPKGBJVMMi6gzcUttQo/FemKUsIzvZpC55cRs6PePSP/YshSEkkAYm85IMf9eNSL
	 936Aw+XNujVYsGSbpojZ509WIyrH203qW5DIQ7B76+gJr3gxrpM2+YzQ6NMAeBAbjE
	 06/roZPpyOKZTPlVfpcT0XztVpsWQQd6rOhh28P8WjabuSX0FoO+m9tKgh+Lpl/TDo
	 6LZm7y0Kgvi3pWqTMpOuT72jihs4KtqVQGekitS+ggbhTobCQZJMXtaR+ucbz6hdqU
	 IZM6cSZGWmD8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DE48E1F658;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vxlan: calculate correct header length for GPE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169018802751.2769.17292878954186029325.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 08:40:27 +0000
References: <544e8c6d0f48af2be49809877c05c0445c0b0c0b.1689843872.git.jbenc@redhat.com>
In-Reply-To: <544e8c6d0f48af2be49809877c05c0445c0b0c0b.1689843872.git.jbenc@redhat.com>
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, pabeni@redhat.com,
 eyal.birger@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 11:05:56 +0200 you wrote:
> VXLAN-GPE does not add an extra inner Ethernet header. Take that into
> account when calculating header length.
> 
> This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU is
> cached.
> 
> In the collect_md mode (which is the only mode that VXLAN-GPE
> supports), there's no magic auto-setting of the tunnel interface MTU.
> It can't be, since the destination and thus the underlying interface
> may be different for each packet.
> 
> [...]

Here is the summary with links:
  - [net,v2] vxlan: calculate correct header length for GPE
    https://git.kernel.org/netdev/net/c/94d166c5318c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




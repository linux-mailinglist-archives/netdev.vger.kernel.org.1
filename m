Return-Path: <netdev+bounces-22572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5647680C0
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689EE1C20AB4
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17209171D2;
	Sat, 29 Jul 2023 17:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE54171A9
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3345EC433C8;
	Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690651221;
	bh=HGCU0Wu3IHcjCDcOzH1VNDX6WUxYD5nlAGAUD7BACrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehkkYi0qyRBq7NpJBHNtWFeyuBPiX1vlWr2UgT/Wp7oh26OrN0CSnrewauBbyCZv9
	 a4+BELWf3/qSegXOdUoDSkk45w6LS9S4AGBfkiIRbjjmti/TU4mDzr+SB3EXdlCh8r
	 kGRiIVVCBthzx7/RcZljQYV+IaU4FkPvx0gPDD8ThDUsBNDc7l44lQnFN52eZ9Ui+i
	 n1IDHW5Rko05+jks3V3UMWmpLLaVkBSTbb9C60REDJMvwbn67kBM90hMzkcBh5dklb
	 yIltoymF9tMOBnSk1yT2Y+lTnZJqm4sjhjyyKGAt5WCU2TfiVBLLFxhE+v2wDcMgHX
	 JfgxOtOxfnZfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18976C43169;
	Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] net: gro: fix misuse of CB in udp socket lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169065122109.20073.13115022881374676943.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 17:20:21 +0000
References: <20230727152503.GA32010@debian>
In-Reply-To: <20230727152503.GA32010@debian>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 tom@herbertland.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gal@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 17:25:11 +0200 you wrote:
> GRO stack uses `udp_lib_lookup_skb` which relies on IP/IPv6 CB's info, and
> at the GRO stage, CB holds `napi_gro_cb` info. Specifically,
> `udp_lib_lookup_skb` tries to fetch `iff` and `flags` information from the
> CB, to find the relevant udp tunnel socket (GENEVE/VXLAN/..). Up until a
> patch I submitted recently [0], it worked merely by luck, due
> to the layouts of `napi_gro_cb` and IP6CB.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] net: gro: fix misuse of CB in udp socket lookup
    https://git.kernel.org/netdev/net/c/7938cd154368

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




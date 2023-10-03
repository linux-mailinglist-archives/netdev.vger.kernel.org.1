Return-Path: <netdev+bounces-37791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FC7B7310
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B573A2812F4
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F43D964;
	Tue,  3 Oct 2023 21:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB429D2EB;
	Tue,  3 Oct 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46A15C433C8;
	Tue,  3 Oct 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696367426;
	bh=a2OQUcE+ISQtj09ENLHvNyZpLnb2mGbhv6CIImC0Y1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EWUGiwUg1CL/Zl4/IfF+fn0PrMvK6Q/i6OxqLQd937mJN7vNibUdpXWmmkrDaWkyP
	 EVM0Ke/cKhjfTzrCLBJTFKzhJ7cGnjl/w5M1ADgK71MxjUQDoMaH0WqxtEdhCpJYl6
	 jxRCLyK7+r8EE2NL0sAANqCtlXCr6Tfaq7YQY9lIJe3SIuzSpDv6I1cSoSTxWukRnD
	 Dbuc9hhgVrutDG0VC7rlLT+PfGmXvw3yQK9vWeZSqEwZd/8ahPFf+amatJh42G46jZ
	 h/grImG00zjg3Nn0pXJkJh6djfHV3JKt9MLgES8W4gOfXpoyg0c5tnWCgSPVVRFO2p
	 9cNjhSUQwPh9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 276F6C595D2;
	Tue,  3 Oct 2023 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] introduce DEFINE_FLEX() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169636742615.22161.7688987075875689506.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 21:10:26 +0000
References: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, keescook@chromium.org,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 aleksander.lobakin@intel.com, linux-hardening@vger.kernel.org,
 steven.zou@intel.com, anthony.l.nguyen@intel.com, David.Laight@ACULAB.COM

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Sep 2023 07:59:30 -0400 you wrote:
> Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
> with trailing flex array member.
> Expose __struct_size() macro which reads size of data allocated
> by DEFINE_FLEX().
> 
> Accompany new macros introduction with actual usage,
> in the ice driver - hence targeting for netdev tree.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] overflow: add DEFINE_FLEX() for on-stack allocs
    https://git.kernel.org/netdev/net-next/c/26dd68d293fd
  - [net-next,v5,2/7] ice: ice_sched_remove_elems: replace 1 elem array param by u32
    https://git.kernel.org/netdev/net-next/c/ece285af77d0
  - [net-next,v5,3/7] ice: drop two params of ice_aq_move_sched_elems()
    https://git.kernel.org/netdev/net-next/c/a034fcdbeaf7
  - [net-next,v5,4/7] ice: make use of DEFINE_FLEX() in ice_ddp.c
    https://git.kernel.org/netdev/net-next/c/230064baa43d
  - [net-next,v5,5/7] ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
    https://git.kernel.org/netdev/net-next/c/43bba3b1664d
  - [net-next,v5,6/7] ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
    https://git.kernel.org/netdev/net-next/c/11dee3d611dd
  - [net-next,v5,7/7] ice: make use of DEFINE_FLEX() in ice_switch.c
    https://git.kernel.org/netdev/net-next/c/e268b9722705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




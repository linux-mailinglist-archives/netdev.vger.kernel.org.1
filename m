Return-Path: <netdev+bounces-43666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB217D42FC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14003B20DD0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060A241F0;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D63lMa87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C223779
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 455C6C433CA;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698102024;
	bh=wCNTXUZWV3nC8GgCRGnDUP0eIak7cItiLeCiH6DM09c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D63lMa87knKfnKbKB8Vnx9Zc41LCSwOkaz5LC4gNN1Vl6vz4MRmespARbAjtWOBLn
	 K6OsZPqPd64aj47BfQgCrSdJXh+pbZhs6uFS7a1L59eRb6ugAAcrKKAW0Lr3BdirwM
	 u3eNqq5w3+enLrBXvSXaGmIlmDBib8PaMCJkVBL6DLKoCN0JID02oPw2BvJ0QwjalR
	 1g8tAH3zEdIVxgWmoymDhegJxSOSVw1Ne1rir+gbrJt73J9rb6utxDeGLTo7KDfpG2
	 34/mOjYmH2eZx5k3CobpTfXzKJMtnIMnroKZBqhq9nvTu31DpJovGDGrL7rxrRzu8K
	 gImq6zA7Bkm8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AA07C04D3F;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_fq: fix off-by-one error in
 fq_dequeue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810202416.28561.7474001249630741244.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 23:00:24 +0000
References: <20231020200053.675951-1-edumazet@google.com>
In-Reply-To: <20231020200053.675951-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, oliver.sang@intel.com,
 willemb@google.com, soheil@google.com, dave.taht@gmail.com, toke@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 20:00:53 +0000 you wrote:
> A last minute change went wrong.
> 
> We need to look for a packet in all 3 bands, not only two.
> 
> Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310201422.a22b0999-oliver.sang@intel.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>
> Cc: Dave Taht <dave.taht@gmail.com>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_fq: fix off-by-one error in fq_dequeue()
    https://git.kernel.org/netdev/net-next/c/06e4dd18f868

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




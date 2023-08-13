Return-Path: <netdev+bounces-27123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2B77A6A8
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2327D280EDC
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F66FAD;
	Sun, 13 Aug 2023 14:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF25235
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23CAAC433C7;
	Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691935232;
	bh=5wO4k3U4hIilcA3NWZmmA1AAwH4Rjr2FoPzPPYf3uwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QobnANBaBMtX7U5GTn/acLqtGcbfamZ9RVoE17NRBVV+L5/LglCQqmKZl1v6unK5A
	 Q+HW3zsOKMHI6r0FpWRvsNB+/hO1C+NZ2r9WLDvKzOrooAl+9cLfforO1WV/x4Bi87
	 oAX5ZemzMbCWjU9kR+hEyzxwsKgXb73Y08SCNJT1My7FTMwT16wNkNNZ2Z+JCyi/8V
	 wBxlb0MFYg8JP14M1qH7j8akVIchkHzUp4UfdfWeURwyCwHMVKyYBmAW41lVJuHtgJ
	 m9wVIbAUsJuyvKbPuEEGoTzeybW0u6hkriaNJAfWpqbjXtEckfhojMYAiDr9PIAPxA
	 OUQ4YiMHvNXWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B551C39562;
	Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove leftover include from nftables.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169193523203.30914.17606443372751582506.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 14:00:32 +0000
References: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
In-Reply-To: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
To: =?utf-8?q?J=C3=B6rn-Thorben_Hinz_=3Cjthinz=40mailbox=2Etu-berlin=2Ede=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 19:33:57 +0200 you wrote:
> Commit db3685b4046f ("net: remove obsolete members from struct net")
> removed the uses of struct list_head from this header, without removing
> the corresponding included header.
> 
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> ---
>  include/net/netns/nftables.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove leftover include from nftables.h
    https://git.kernel.org/netdev/net-next/c/f614a29d6ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




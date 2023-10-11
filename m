Return-Path: <netdev+bounces-39917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4897C4E38
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9BB2821A1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C21A729;
	Wed, 11 Oct 2023 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6aamtxb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B161A718
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC888C433C9;
	Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697015425;
	bh=pIQp+LwTNvdQ0PzfE/8yCOe2705OueXQH2dq7DVVotQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6aamtxbGtUlYMSm9SCZw2QSPP9BDsbf1vS/1Ru5Oa+1zn7Nq+1dr62GR0zyBifEb
	 BcVS+bCfO8AZIGtJIRZ8xx4hatOyovPM2WWMJPuv2ktcwbyfnx5gsiwIXl7khQYNWn
	 AaMNTHdwewbqtGi8LX38AsIYVTAG/qZ+xGNXXKh573RxhMGN0kfEUHYuK+3YmIA4PN
	 fOTDrANmdLemo7ombdlud1ycIDlsPCCtYofuotopih+SZfqey+o7ZW+JYSgifnVIhr
	 DdZ8+ZzcBht7YbjH7IXZDOoxGzH6hGjlcqMj3o+De9U2k9iLdiVcm71Y2tey1CbTR4
	 PcMWE1ZqxooIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1AC8E000BB;
	Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net/core: Introduce netdev_core_stats_inc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701542485.14579.951274482359879368.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 09:10:24 +0000
References: <20231009111633.2319304-1-yajun.deng@linux.dev>
In-Reply-To: <20231009111633.2319304-1-yajun.deng@linux.dev>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 19:16:33 +0800 you wrote:
> Although there is a kfree_skb_reason() helper function that can be used to
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> 
> For the users, people are more concerned about why the dropped in ip
> is increasing.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net/core: Introduce netdev_core_stats_inc()
    https://git.kernel.org/netdev/net-next/c/5247dbf16cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




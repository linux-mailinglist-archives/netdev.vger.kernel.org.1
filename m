Return-Path: <netdev+bounces-100603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99A8FB4CE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D327B281FB0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C718028;
	Tue,  4 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0MbQf64"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC329CF0;
	Tue,  4 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510230; cv=none; b=EJqFszNM9j7toXmlzUe9r9b+C6uAh76BdMP1Zs9/Hz6xunbkg2xmddE8nwXz0YH1v7tXfnMwUzXiDka8OwVFTtyuhWNs7kQ6lHN/C0Ja32oxFNwVGcgXH0q9n6KykJ0FeOYA24S8thX3GWkdmeIcgYlCxbz3HYTtGZkGq2oTSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510230; c=relaxed/simple;
	bh=U8Trk4xYW+uDxGn5Qnb0g0cbFG/eofASEf5XMd5G0Qg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rviJ6uGwhk8YuSyyJwv0mmK1wWp1Vbegz6E8oR69MMatAr2IolmjWjb1o8l8PXOdvo8Jg6cHuKIeMoE/p3Q+1ZvIaxVUKIMiQfROEwA8AMjqiK99peAUoIFiz5jAeUCBvAzl131qtj1rGa7jDFFBfADQTDh/Su/s7QrKeusgFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0MbQf64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D251C4AF08;
	Tue,  4 Jun 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510230;
	bh=U8Trk4xYW+uDxGn5Qnb0g0cbFG/eofASEf5XMd5G0Qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0MbQf64wIynUTaNrlnlWcaVYEKYkvG/XmgyFb7LgqUtwy9VJJeTxGMEMPBZuzNSc
	 7tfaThHQJGC2Ys8+c6XdsiHfC9qJ37eChOX8p/nG+AuDJLL2hJLQwoXyFSoW8G9fgi
	 oMHaPxdV/z/dHY5DQCu9FVbzKcRRBlNyKQSaWpmKJcwHC+mtSw2IcMOPQCdywmYd/L
	 Zj00bPu01lCiX/F4qpk2+zIsQizP1UTkJePga6OxljpqKt1Klh82qYsGVE59+m1/P7
	 WaaysQeSjZyu4cjfqXJW1xBdp0MbejzjspC62YFWhMahvNUAaQqBH+6PsLnpV9nuMN
	 7nkdCXf3D1G9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A960DEFB90;
	Tue,  4 Jun 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] openvswitch: Move stats allocation to core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171751023030.3529.1641049852286296501.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 14:10:30 +0000
References: <20240531111552.3209198-1-leitao@debian.org>
In-Reply-To: <20240531111552.3209198-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 31 May 2024 04:15:49 -0700 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] openvswitch: Move stats allocation to core
    https://git.kernel.org/netdev/net-next/c/8c3fdff2171c
  - [net-next,2/2] openvswitch: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/2b438c5774cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




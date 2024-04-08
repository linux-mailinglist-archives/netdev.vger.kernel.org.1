Return-Path: <netdev+bounces-85685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF789BDA2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289231C20F0D
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAA60263;
	Mon,  8 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhZ/cC98"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B26025E
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574028; cv=none; b=aQegkWVHRhH1cZCDtGMH1nxc16EZnpnGEnDTo7JkDjPpEx2tUne7mCj8pakByTtOYgwN3BqBr4MMS1EbmVY6WmBm4FiusthN+UpRUy3fs6URvbuiaoobCCcOALCQn6x35o7GGdeVjZjjnOsD91b1M2HvNkA/bvYMLyrIqNVnzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574028; c=relaxed/simple;
	bh=w2J1H7rQ539W/3ae+dass1QJ8dSHziVE9xQ5L+hP4bU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VeEs5ModtgkU+fl5j0iUV7lyVpkQrCDhR6splIshDsJ0Pi7mAOtXeRynZfXr/ennW6QHS69EAnn46yjwXciy2L5dhlapRsguqMP5rLyN9A89EBZ5fu0nH6vnwg+9UGFUC6FOcIE3k2kfz1H5C7s4YahHVzjgMdXtqgTZ04iea6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhZ/cC98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B25C43390;
	Mon,  8 Apr 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574027;
	bh=w2J1H7rQ539W/3ae+dass1QJ8dSHziVE9xQ5L+hP4bU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RhZ/cC98pgCGfLYiI2VBvqr9wNJNQWv0Ud2FjlUy5bCy75yCT86XhGabY4gqgHCqG
	 EtyxnU8VG/6YJl6nqZuPRhDwnjnZtioSpC1Lpa9S3Tbo76lH1SugcyvSHqUI6kWSjr
	 NUIBO87hyBJSLKU50X/rZXS1WTno2tGVvNE+ft4XOh7uOnAf10NwAYWD4u00Vj1hzB
	 SLgDc/jJcDfYKk1BdXToO02fQJ3gDvAEI3ayV+ROsdxQELMc12yNdLJCZtTSofG8Xw
	 DwIpxZJHjDSTIeLqhQbL87KvgrQuFxNZcgXc4DAF1hnITil+WQirTPleC/Hl5YvpNj
	 fqJrksXgvPl8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D26A7C54BD6;
	Mon,  8 Apr 2024 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] geneve: fix header validation in geneve[6]_xmit_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257402785.26748.9374335978714669651.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 11:00:27 +0000
References: <20240405103035.171380-1-edumazet@google.com>
In-Reply-To: <20240405103035.171380-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, phil@philpotter.co.uk,
 sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 10:30:34 +0000 you wrote:
> syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> 
> Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> skb->protocol.
> 
> If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> pskb_inet_may_pull() does nothing at all.
> 
> [...]

Here is the summary with links:
  - [v4,net] geneve: fix header validation in geneve[6]_xmit_skb
    https://git.kernel.org/netdev/net/c/d8a6213d70ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




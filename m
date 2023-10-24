Return-Path: <netdev+bounces-43817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448BA7D4EB6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE69B20C7C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87326288;
	Tue, 24 Oct 2023 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klz/cyCr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14A1FD7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90302C433C9;
	Tue, 24 Oct 2023 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698146423;
	bh=xftM4qcyT0lca87W0t2wbguo1Ot8Ftv8alOVYsmwwaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Klz/cyCrllNfqL8cuJyicdAONBArsjNq7/JWYKwQijDUbNfxnWxp1sjbu+koRxe6q
	 QhJfQk6FSzO3Adu0OIutA31SURHsYGE81iZFy8nSE7VVHH9o9Tx16zTDfb5KilAFxU
	 5h2B/Y0eqlbWCpBKoxu/VSdbmkqAfbZKxJYVIJFVFq6b8Cqkg6j8tBPxsBROvlpcX/
	 60Xpc5j73xbZfdBCFsUKftRw0tZSo/4PIuuHwHXoaByDdOzReTISdgbY2LJAd/zyq8
	 e94/LQAojn4+tBE+/Wq/zJhdPEB7PNvuLmN1MdfKd7551NFC0pOKRhb5XD5jEq/dOW
	 6hx+pUdPSlFlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73849C04D3F;
	Tue, 24 Oct 2023 11:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: sch_qfq: Use non-work-conserving warning
 handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169814642346.22456.5224425223628046710.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 11:20:23 +0000
References: <20231023064729.370649-1-liujian56@huawei.com>
In-Reply-To: <20231023064729.370649-1-liujian56@huawei.com>
To: Liu Jian <liujian56@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Oct 2023 14:47:29 +0800 you wrote:
> A helper function for printing non-work-conserving alarms is added in
> commit b00355db3f88 ("pkt_sched: sch_hfsc: sch_htb: Add non-work-conserving
>  warning handler."). In this commit, use qdisc_warn_nonwc() instead of
> WARN_ONCE() to handle the non-work-conserving warning in qfq Qdisc.
> 
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: sch_qfq: Use non-work-conserving warning handler
    https://git.kernel.org/netdev/net-next/c/6d25d1dc76bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




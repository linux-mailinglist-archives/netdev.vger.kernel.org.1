Return-Path: <netdev+bounces-210236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97058B1275B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5902D7B92A9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51425FA3B;
	Fri, 25 Jul 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvB1Bfnt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D625A334;
	Fri, 25 Jul 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485949; cv=none; b=ZOr3rnvOGxT1rDVHplekbL2/kFbtN+Sx94XXYK2ibSRYeVsfYhe8szZpc2F0bj8ePoEA8ghIHXv1LUAQ11Mctbur+xPmQBsO3391O4S8qXuWTXDcU3kKCuEFnYHmYwUdHZ1AnUA1IbYws8ryCcJtbgKSn8DoZ8UTDsHYPZ1ZAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485949; c=relaxed/simple;
	bh=X2csSYp5gRjbrQEJwwiOAhEf8VWSbhK9QEwPU1GO8q8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Us5rTnnaLPZXWJLuFtYz/2xgFNcdJ4YQ7YCBRD3EG6gm7JnLHaTepuzVWE+UgDcqO2vbDV+tDr9iSxWPaIbXLSj0ZwhnMNho560EwH7de+tjZ+R5uYq5aaGzSLkY7kjMNC3qhyNEFLrjtHk0IxWOkeZnIEOc6t/mgYGggbFZirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvB1Bfnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CEAC4CEE7;
	Fri, 25 Jul 2025 23:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485948;
	bh=X2csSYp5gRjbrQEJwwiOAhEf8VWSbhK9QEwPU1GO8q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jvB1Bfntxn8Yxo+GGPr3ZAqr1WI5TC3A3DXnf2wXVygyd7YnF30D8qMe0DSevw3/b
	 rJuWaGY/nBNVsF4HFEFxhU69YmsKjTrEutTgcCQLZ1FdjbkldKbprl7s+IRyHHv+s/
	 6DyemFaX35s9up444zFvLR5PCT0d36ETruMWJkaK6A6Hw+6e2sllriFrnTSez9A5Dr
	 fISmCrkjPWUnF1oktxFSqCng29mRLJ9BdeBQY35arEi2Jza/aH+vGD6GvR2jzuNMpT
	 C/6plCtTKUJpkcHJCzMFhrklP/SVGzQQkUGZeJAsgNrlmFaUjuWS/FJ/axDClrVF20
	 +eV8mfmGDDovw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8D383BF4E;
	Fri, 25 Jul 2025 23:26:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 =?utf-8?q?=5BPATCH_net-next=5D_net/sched=3A_Add_precise_drop_reason?=
	=?utf-8?q?_for_pfifo=5Ffast_queue_overflows?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348596599.3366157.7761382849511498697.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 23:26:05 +0000
References: <20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn>
In-Reply-To: <20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn>
To:  <fan.yu9@zte.com.cn>
Cc: dumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 davem@davemloft.net, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, tu.qiang35@zte.com.cn,
 jiang.kun2@zte.com.cn, wang.yaxin@zte.com.cn, qiu.yutan@zte.com.cn,
 he.peilin@zte.com.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 21:28:37 +0800 (CST) you wrote:
> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> Currently, packets dropped by pfifo_fast due to queue overflow are
> marked with a generic SKB_DROP_REASON_QDISC_DROP in __dev_xmit_skb().
> 
> This patch adds explicit drop reason SKB_DROP_REASON_QDISC_OVERLIMIT
> for queue-full cases, providing better distinction from other qdisc drops.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: Add precise drop reason for pfifo_fast queue overflows
    https://git.kernel.org/netdev/net-next/c/bf3c032bfe16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




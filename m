Return-Path: <netdev+bounces-180093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDE6A7F90B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1293AC2DC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BBD26159C;
	Tue,  8 Apr 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWxcHrnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EA20B815
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103398; cv=none; b=FcehI+m2lCWCDuOjOIVFzvs3igpfYVW7ruEoGw/9kGND8bFimGCX8G7wfmxm0ad7nvpLrldvcd+ZBqE+iJMjxHqywPp8TjMUaT9G8gzqMrV1GLhsrmr3VA1e6VnUTcuWmrmkmjOblBjVQpvr5UmBD8xB5MLAp3OpAnOA4lZ486U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103398; c=relaxed/simple;
	bh=U0KGWLpMueJsUMen5u+TbXWQ0Gx1Uz5/sQeOmSpzUww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0DTqb6f/yxnsLO3Yz/PdfJAknO7Um5GQAADfgoQ7CmuDD89VMFOSHVOnmoWedBXX3DQWRP+0hF/j25v2/qmvN7v7S2jBqHi9iF9bUHueMMB6CkEsUSC7OipiKOCVD/yONwNyY75BjxOvtqDWue+GUlAUbF2AE5gqF5Iv00nPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWxcHrnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93FC4CEE5;
	Tue,  8 Apr 2025 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744103397;
	bh=U0KGWLpMueJsUMen5u+TbXWQ0Gx1Uz5/sQeOmSpzUww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWxcHrncx7UZMgMJCq0F8UBoJ6VOLDtlazkrc2+KaDbVdgjBoiDt82aYf7WCe7xk1
	 Vqi6ctLveYz/Yp+Hb1PvPIdvDV1Zu6HKgmfss4HhbH+jg1kv5SCS2bp5Jlb2TNsFVV
	 RezMQZRB9VHG17/F4KEuVKSDBBfhknp4FEOzPs4VDJHGn0BJeiYIeAz2shoM2eXtSq
	 AgIvAwAtMVvOc2AsjEjMYSANbEN30k9aziRzuNqDfFNLAXjvr16HzDY8gX6knkkwB+
	 SpcYegSFToa0DJSHW9KC/JDPPrR9E9NSRx7fsUAwR/C+bv5VSlJZB9qrmS+sakgPDg
	 skC5ZqHYwfZRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346C138111D4;
	Tue,  8 Apr 2025 09:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net v2 00/11] net_sched: make ->qlen_notify() idempotent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174410343500.1831514.15019771038334698036.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 09:10:35 +0000
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Apr 2025 14:10:22 -0700 you wrote:
> Gerrard reported a vulnerability exists in fq_codel where manipulating
> the MTU can cause codel_dequeue() to drop all packets. The parent qdisc's
> sch->q.qlen is only updated via ->qlen_notify() if the fq_codel queue
> remains non-empty after the drops. This discrepancy in qlen between
> fq_codel and its parent can lead to a use-after-free condition.
> 
> Let's fix this by making all existing ->qlen_notify() idempotent so that
> the sch->q.qlen check will be no longer necessary.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/11] sch_htb: make htb_qlen_notify() idempotent
    https://git.kernel.org/netdev/net/c/5ba8b837b522
  - [net,v2,02/11] sch_drr: make drr_qlen_notify() idempotent
    https://git.kernel.org/netdev/net/c/df008598b3a0
  - [net,v2,03/11] sch_hfsc: make hfsc_qlen_notify() idempotent
    https://git.kernel.org/netdev/net/c/51eb3b65544c
  - [net,v2,04/11] sch_qfq: make qfq_qlen_notify() idempotent
    https://git.kernel.org/netdev/net/c/55f9eca4bfe3
  - [net,v2,05/11] sch_ets: make est_qlen_notify() idempotent
    https://git.kernel.org/netdev/net/c/a7a15f39c682
  - [net,v2,06/11] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
    https://git.kernel.org/netdev/net/c/342debc12183
  - [net,v2,07/11] selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
    https://git.kernel.org/netdev/net/c/cbe9588b12d0
  - [net,v2,08/11] selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
    https://git.kernel.org/netdev/net/c/4cb1837ac537
  - [net,v2,09/11] selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
    https://git.kernel.org/netdev/net/c/72b05c1bf7ea
  - [net,v2,10/11] selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
    https://git.kernel.org/netdev/net/c/0d5c27ecb60c
  - [net,v2,11/11] selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent
    https://git.kernel.org/netdev/net/c/ce94507f5fe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




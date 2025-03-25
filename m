Return-Path: <netdev+bounces-177552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF77A70885
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A783BD5A7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED0264F96;
	Tue, 25 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESP4Zp15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A1264F8C
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925003; cv=none; b=O4Ao5jHHP0Tqju/UJcyintdo2EbPUmD6hQuVEfgXk5XrtDsHT2esAbFCk8x+ADgNH1BimHNRYTLvouLdUkE5HASGrxnGRO6gCkFvMLoLzLq38eurCwH5fdMaEkEOISWrkyclt53cFJRU2p29qJOJgM0BJdBpzRWzxtIFeLj3Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925003; c=relaxed/simple;
	bh=8XJ/1/hnWAqpPFz0/Yd3tgRn1CnxBhS65FYXsMxOfO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WlT/3SsK9zsww5MDyL6IomxWR+mELy9gnEdWf6efKGFeLcYIV0F2jwQJtUBZ/6BcvSsXA1wUB+TEKutcnmkoom6PV8nDoeYVknQo2Ks61tmUL1u95QTR3bWczt3BXUawhpdHusJIMcReG2wFjwSBTVmAmBOBP3oxybUt3zruUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESP4Zp15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46FCC4CEF1;
	Tue, 25 Mar 2025 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742925002;
	bh=8XJ/1/hnWAqpPFz0/Yd3tgRn1CnxBhS65FYXsMxOfO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESP4Zp15ZuOnSlelAWXiReadXDFufWxakyPYVjxgnEn9LR4UEmHwP+EOxgirb9rFe
	 Vudzg+vXwyWTKNr9DOSxX+/qH+1q0A4mAHpCtshYX/Rioqh7/GEWOO/CgBYFQkZsFu
	 q1dqGlj4HH4ts1f2ITtdxGFabyQkTfazGaTdyHCeUljmqSGksZh/g44KjVloes5qf4
	 Rmd9YRZJxzCy9/pW4tsFMY1WVu9//2r0wWShL59lHjjvy6PAU8roBTW5KrzXVWGQCs
	 AHrqSAIhAeruzW+C7RzKKoXlaKCx2T7LVUS4n/QJcOToTJHzaJgFEgYP8KZBRFoML0
	 bqnGlo6Bcxq3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCB380CFE7;
	Tue, 25 Mar 2025 17:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] tcp/dccp: remove 16 bytes from icsk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292503901.665771.840360191905671384.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:50:39 +0000
References: <20250324203607.703850-1-edumazet@google.com>
In-Reply-To: <20250324203607.703850-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com, ncardwell@google.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 20:36:05 +0000 you wrote:
> icsk->icsk_timeout and icsk->icsk_ack.timeout can be removed.
> 
> They mirror existing fields in icsk->icsk_retransmit_timer and
> icsk->icsk_retransmit_timer.
> 
> v2,v3: rebase, plus Kuniyuki tags.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] tcp/dccp: remove icsk->icsk_timeout
    https://git.kernel.org/netdev/net-next/c/a7c428ee8f59
  - [v3,net-next,2/2] tcp/dccp: remove icsk->icsk_ack.timeout
    https://git.kernel.org/netdev/net-next/c/f1e30061e8a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




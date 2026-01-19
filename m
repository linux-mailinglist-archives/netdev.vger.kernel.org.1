Return-Path: <netdev+bounces-251131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF29D3AC1C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B6C6301D8BB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAA38F242;
	Mon, 19 Jan 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhMQ7u7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8038E113
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832590; cv=none; b=UHSPtCgZ1xIr2dvy4S9UVlsaPdYb6nh1uRq3vPCbZpFQahwjNkZX5APMh63MHwMroLHKhKc9i1njvwnvuGcpbApqdu0Hbjo4WS46n2mjMBEkSb2e+XY0PZY38YhySHXWOJccZnFrDRZq4NFf7K6+k1CYFrFuIKvL7HzxZSiVR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832590; c=relaxed/simple;
	bh=O7xmf1lJJAvnhNXByYOsSQC9xzWJJEsMfhN2SVGjWto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QQEAJJZXTyrxWz8NlqOCUVeTIRutxwMJPKSJWU0ShG3vlE/Bvv4k4VD8wS9CfIhrF1Lv9jCM7xSIK7VKmNzZsZpmEngBfGWFvwIDxmx2aqh/id4aWc/XGT/WGz2urZJ8aGtS37jNsVbx6D4j+YBv514fRe2/2p6T/dHabSAJUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhMQ7u7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7290FC19423;
	Mon, 19 Jan 2026 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832590;
	bh=O7xmf1lJJAvnhNXByYOsSQC9xzWJJEsMfhN2SVGjWto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhMQ7u7ZG/dBtZJynJu88fN9Sp5K0Hk/pEVgvWLVhAQLx4K2vUvLqsXM+xmVc6ohU
	 AA4a9quGfZeaiZDg/9n76gN9hzrgVBnwNavGxvS6MyeYQiKu13zfWLaTiEdT8gspb4
	 zVIeCXpEo5+JT16PmQTwNm0jSSR8gQ/WiFStUwXQrT5LO64gmeAp24b3JCuYnucMAU
	 o2cczOB+7DahNSlsahsgYrF2IxUWE7HpmDDvfhR6PZR6wlxdk+18PsjNsEDh/w66C6
	 yY0/J9l57XW06NIvaePtVB1gEnUDMSn9YNBq2QazKH2kgKrwfmDr9cvfeJ74MKnvvV
	 b+R9tQi7QSdFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787423A55FAF;
	Mon, 19 Jan 2026 14:19:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_rate_skb_sent() to tcp_output.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883238002.1426077.5540815214056969724.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:40 +0000
References: <20260114165109.1747722-1-edumazet@google.com>
In-Reply-To: <20260114165109.1747722-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 16:51:09 +0000 you wrote:
> It is only called from __tcp_transmit_skb() and __tcp_retransmit_skb().
> 
> Move it in tcp_output.c and make it static.
> 
> clang compiler is now able to inline it from __tcp_transmit_skb().
> 
> gcc compiler inlines it in the two callers, which is also fine.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_rate_skb_sent() to tcp_output.c
    https://git.kernel.org/netdev/net-next/c/f10ab9d3a7ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




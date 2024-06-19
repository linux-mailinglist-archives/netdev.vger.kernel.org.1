Return-Path: <netdev+bounces-104839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE090EA0B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88971C2136C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD213D532;
	Wed, 19 Jun 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvmZUOLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F21386B4;
	Wed, 19 Jun 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797831; cv=none; b=nba/o8RefybDBj7tcOg6LsUxrS+tdUfoF2CinUw5UfGL1jgYoIUo2jm02vC2jcGWX3ZiJ8xwZD7rQWBeduIDuDhK9iJTRDakX6JtfDS9iuOEiHBDyakDPMS9C5n3VBG/o9j+dldDeEJ3XQFOt04GIx43BJqTCpj5+25RjKPu9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797831; c=relaxed/simple;
	bh=WBAY54eGwt1loIBs6Hp8ejKwZhZ0eB+pAKKRU6vShMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNgQ5eSMEop5JAiK1MOuLiyF2ckY47qARyIyFZ+y1kLIx383WS0mi8QdWYAT1giK6k1mdfuBNZu+Wbmnzho30/+Tzcz3Uiat8A1chnCIQe51tGbLoArsKockv2XLpXgZg9hESXjy4Laory99qwcorUewK0Bbjxp51Yqn0+TY648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvmZUOLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50136C4AF1A;
	Wed, 19 Jun 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718797831;
	bh=WBAY54eGwt1loIBs6Hp8ejKwZhZ0eB+pAKKRU6vShMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WvmZUOLeb3qYVRlGvndMx20KcKoEOaFqXvUOuRtiiHPgzZse+YYSpMGK9uYt7zlCm
	 YF+qBY0on/1wGD/yh2CdK6q0TnYco2ZJTxJA5LY1OVBmwWft/GlKbVIcoFgui9uJ1W
	 VL65GxS1+FGSFsFpBdaKpEbac6Qnu46lj7ERSUhtAiBvJsgqz0MMnagXDBWXrbqk5n
	 svP7MfKjjQTOcseNUNy3+85tSbIrf/crPsLbEnFFWTmX2HeWguhhOhxOsrmbRtjmqH
	 5t9rDEz+svIM3EttXUhP9aaWMV4nG9GZ5thJe4Eoc8+f+HnijsMMCFXb5mRTzu/fDG
	 XE5OAq4B5fL6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B1DEC4361A;
	Wed, 19 Jun 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] net: pass receive socket to drop tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879783123.2748.515065113481168194.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 11:50:31 +0000
References: <cover.1718642328.git.yan@cloudflare.com>
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 quic_abchauha@quicinc.com, almasrymina@google.com, fw@strlen.de,
 aleksander.lobakin@intel.com, dhowells@redhat.com, jiri@resnulli.us,
 daniel@iogearbox.net, bigeasy@linutronix.de, lorenzo@kernel.org,
 asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, hawk@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, nhorman@tuxdriver.com,
 linux-trace-kernel@vger.kernel.org, dan.carpenter@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 11:09:00 -0700 you wrote:
> We set up our production packet drop monitoring around the kfree_skb
> tracepoint. While this tracepoint is extremely valuable for diagnosing
> critical problems, it also has some limitation with drops on the local
> receive path: this tracepoint can only inspect the dropped skb itself,
> but such skb might not carry enough information to:
> 
> 1. determine in which netns/container this skb gets dropped
> 2. determine by which socket/service this skb oughts to be received
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] net: add rx_sk to trace_kfree_skb
    https://git.kernel.org/netdev/net-next/c/c53795d48ee8
  - [net-next,v5,2/7] net: introduce sk_skb_reason_drop function
    https://git.kernel.org/netdev/net-next/c/ba8de796baf4
  - [net-next,v5,3/7] ping: use sk_skb_reason_drop to free rx packets
    https://git.kernel.org/netdev/net-next/c/7467de17635f
  - [net-next,v5,4/7] net: raw: use sk_skb_reason_drop to free rx packets
    https://git.kernel.org/netdev/net-next/c/ce9a2424e9da
  - [net-next,v5,5/7] tcp: use sk_skb_reason_drop to free rx packets
    https://git.kernel.org/netdev/net-next/c/46a02aa35752
  - [net-next,v5,6/7] udp: use sk_skb_reason_drop to free rx packets
    https://git.kernel.org/netdev/net-next/c/fc0cc9248843
  - [net-next,v5,7/7] af_packet: use sk_skb_reason_drop to free rx packets
    https://git.kernel.org/netdev/net-next/c/e2e7d78d9a25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




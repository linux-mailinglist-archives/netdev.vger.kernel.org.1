Return-Path: <netdev+bounces-264444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Du2IeCbqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:06:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F335821426B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5016302DE29
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75523B8956;
	Thu,  5 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5WDVUxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938333B894F;
	Thu,  5 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722816; cv=none; b=B93+k9Rh/HiYm8goGlIzd5gJFOOF53sL1Y+5Q9vogVGaOWZdnendKXykGXjil7uLbPt8jWb3L17nUHoJ1dtZry2o0LTWBKOadeYyoofgjR7aCtEFr1QNCdak+evTNTwcQZRLU9jTRyKiULqJwxdwpMMQK7/bGZFVVG6wGFRIab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722816; c=relaxed/simple;
	bh=G5vhjb/Nnx2gyYyA0nQ04DnQWCGi523oOse03LW0dbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MfiNuNpsClH6BsbudQGWFxcu4SlFCqc2YFn2riPdzrWao3Dw+qDgKwQ9kjhpitHH8JHGuxDWv1aZLc0UhFuOtR3NHd1OXoXWRlNO8dVxniB2kCx/9GLsykvF82cdeZj9MJYBGo+Fqt+4UNpfqCCRd8aotDoyq7w0s8qNZjwdUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5WDVUxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C3FC116C6;
	Thu,  5 Mar 2026 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722816;
	bh=G5vhjb/Nnx2gyYyA0nQ04DnQWCGi523oOse03LW0dbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5WDVUxwO2aPtSLHf6F6xgYVRy2LMKPdnMvqjvDlQA+HLWJiEIX+i3MN0WnjAQBro
	 M91XOFWx6m5d0F++u2ZX3lc3+wrgUr9gsEalcn7Q2OtoVsUPbC+npaQKMTUQj8XTzt
	 cZt3EvO9BqNb9+0VEaXV3J2/3S6e+CtfINrmNHOBNkkTYUFaQINEbNOZ3lmGUg5EUs
	 9dZvOaikUA4ikc/7ZN98fLWctqnLuZtGACc53T/10sfG7MBuDNgKUzu8f4PjS057vv
	 0lVMgd3wHgrK1vyc2KRiIKs2s8lND2pQLUN/iKnVQHOyUseKG9rFgQPE5yz1DjspDg
	 VVcsPeX+KT0yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CECB3808200;
	Thu,  5 Mar 2026 15:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] gve: optimize and enable HW GRO for DQO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272281630.3158199.14427132039125147491.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 15:00:16 +0000
References: <20260303195549.2679070-1-joshwash@google.com>
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com,
 jordanrhee@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, pkaligineedi@google.com,
 thostet@google.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Rspamd-Queue-Id: F335821426B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264444-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Mar 2026 11:55:45 -0800 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> The DQO device has always performed HW GRO, not LRO. This series updates
> the feature bit and modifies the RX path to enhance support. It sets
> gso_segs correctly so the software stack can continue coalescing, and
> pulls network headers into the skb linear space to avoid multiple small
> memory copies when header-split is disabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
    https://git.kernel.org/netdev/net-next/c/e637c244b954
  - [net-next,2/4] gve: fix SW coalescing when hw-GRO is used
    https://git.kernel.org/netdev/net-next/c/ea4c1176871f
  - [net-next,3/4] gve: pull network headers into skb linear part
    https://git.kernel.org/netdev/net-next/c/0c7025fd24db
  - [net-next,4/4] gve: Enable hw-gro by default if device supported
    https://git.kernel.org/netdev/net-next/c/3c398063ef01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




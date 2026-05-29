Return-Path: <netdev+bounces-293258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNDzAkn1GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEC608727
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9FFF300A66B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8F3B27D4;
	Fri, 29 May 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH9oyRHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD23AFD16
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086023; cv=none; b=ptkN+r7GJK9aM4vlzFod60F1W5vto94qBytvr7B5gzboO098r8l0xzpT08Ac6jS5XPeyfBs2tBqSk1id1g2dRD1H6JhlipMNGC6D1gp5yOutbluCmAWAS7raWs6LpSKq9G32I2kbbFODiDGPVfeYnglVd5YwZMDGnhiCMISW6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086023; c=relaxed/simple;
	bh=qjRYIDUA2BYfL5kJaC5Ud0nY2zvYNQAxrmAvzkDwRTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sImtmCls5fmd7JiFrUyxhiBiGPQusIalb3cvh7fVfGjHrp+H0z/9YCNG95ibOr5JcFp54KBXjykTeRRaEl8bfOIaczW2ilqjywub1BgNRevxBFRieUdBpHh2NX/f5bjClQ4RepalhU3/ZXS2oXNlOFKMDD8ZVUEQjA09oMc6J+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH9oyRHE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0AD1F00893;
	Fri, 29 May 2026 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086022;
	bh=FXb7h0yg8ZbY5/1PwC6EXH6Osh5rl0FUEnJuNsoDCwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eH9oyRHE/sNtpWk5tTcqDPojkuQNJGFLnNR9wKlSQgO8C852G0+phRvz+8Mfnc5Ps
	 CgbGRE65AfUAcERnB+XwsyejHXW91D314a/Tud/oFSlFYPtiDogufDGbndBU8TytpZ
	 KBuoNwc94qwB8TegTi/PfzaLCsmpf8IyPkJ2u/iLSSxh/l5mpM8Dm+oPNEbtYQBpiY
	 4noHB7vofrJoghmNHw7Cry+sLOWfwYc6aTlKiSUPSn/GAIuEaJppvBZDy3TP27KN5f
	 q9SJC24mPbm/UnDG4O/rpwOQd7pQvaRjN4739WPWeo/a/3uXPOmF8juZiktQeSw0uj
	 FOSkdpPs14QOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994839301A0;
	Fri, 29 May 2026 20:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] xfrm: route MIGRATE notifications to caller's netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008602564.1951456.13990735152471998792.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 20:20:25 +0000
References: <20260529092648.3878973-2-steffen.klassert@secunet.com>
In-Reply-To: <20260529092648.3878973-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293258-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,secunet.com:email]
X-Rspamd-Queue-Id: 0EBEC608727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 29 May 2026 11:26:03 +0200 you wrote:
> From: Maoyi Xie <maoyixie.tju@gmail.com>
> 
> xfrm_send_migrate() in net/xfrm/xfrm_user.c and pfkey_send_migrate()
> in net/key/af_key.c both hardcode &init_net for the multicast that
> announces a successful XFRM_MSG_MIGRATE / SADB_X_MIGRATE.
> 
> XFRM_MSG_MIGRATE arrives on a per-netns NETLINK_XFRM socket, and the
> rest of the xfrm/af_key netlink path was made netns-aware in 2008.
> The other 14 multicast paths in xfrm_user.c route their event using
> xs_net(x), xp_net(xp) or sock_net(skb->sk); only the migrate path
> was missed.
> 
> [...]

Here is the summary with links:
  - [01/10] xfrm: route MIGRATE notifications to caller's netns
    https://git.kernel.org/netdev/net/c/7e2a4f7ca095
  - [02/10] xfrm: ipcomp: Free destination pages on acomp errors
    https://git.kernel.org/netdev/net/c/7dbac7680eb6
  - [03/10] xfrm: Check for underflow in xfrm_state_mtu
    https://git.kernel.org/netdev/net/c/742b04d0550b
  - [04/10] xfrm: ah: use skb_to_full_sk in async output callbacks
    https://git.kernel.org/netdev/net/c/79d8be262377
  - [05/10] esp: fix page frag reference leak on skb_to_sgvec failure
    https://git.kernel.org/netdev/net/c/2982e599fff6
  - [06/10] xfrm: esp: restore combined single-frag length gate
    https://git.kernel.org/netdev/net/c/dfa0d7b0ff1e
  - [07/10] xfrm: iptfs: reset runtime state when cloning SAs
    https://git.kernel.org/netdev/net/c/7f83d1740732
  - [08/10] xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
    https://git.kernel.org/netdev/net/c/3e5241731847
  - [09/10] xfrm: input: hold netns during deferred transport reinjection
    https://git.kernel.org/netdev/net/c/c16f74dc1d75
  - [10/10] Revert "esp: fix page frag reference leak on skb_to_sgvec failure"
    https://git.kernel.org/netdev/net/c/6851161feb01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




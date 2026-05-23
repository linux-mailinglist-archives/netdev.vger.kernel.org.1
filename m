Return-Path: <netdev+bounces-290985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHARL9v3EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FB5BC208
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE55D3002D77
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41C2264A8;
	Sat, 23 May 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSmPJrvo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B621CC71;
	Sat, 23 May 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496827; cv=none; b=XLWqUEcWCcQ+JrUzFlCp/a5rnlYmYZYDY4Vd3/UlzohPtzh1HWLKCfAnLXJ7Gb94G/pTrm8+8dVqdkZAWqLLSLLtWTJ8Q4cMxabwa6pwRLHLQi+Bzk4vdFxaKPRjF+vtQSsnoOGFYvbjTJk6Ygk053QGP5zCz84Oe8xqED+MkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496827; c=relaxed/simple;
	bh=GHt4B4EO1pqZtvby/hfc+5ajJqOuwqHFvp7p5PK1n/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cToZpsm+FUVUmFTGFnml1WymK5+Tobpe4Y+FgWoK3yKvMFQOo5XShADyWcraEbVVH2WQtyLBAMQqyK+8N0A+5FArJwAq3yNNqFvTpgyC9pmCegMmtpc4nv76ePpZYqgVr5/mWtJleI3zaxtGxxFWAr+vuv+XX+yaLztya/Ewav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSmPJrvo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F31F000E9;
	Sat, 23 May 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496823;
	bh=88gBHfKfgsQdnZrl8tdzXg06YvEOGTOTk31Xla54xO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JSmPJrvoDp2ifhA81IFIwhTOUJVQkWX3prPUocoPvj36s5qr0XEYqzYEgC5IUoH+H
	 DIyByPv+9KV2e6jnT6AmunnOmL0GDDEjDDkCIo4P2zeD876WbSv7VyjnZrdJ5Z5Fvy
	 mxIxsNzEFO201fnw6Gi+YsqwbSL+sAHgT9EEm8IeqemHJhr+cNBF+xF1lZOYPUqAHD
	 a6yjWylzxlRACPsGt5bTVV74y34p5QZorvWqjOebQmxXiWHneylsMWhlXpUBnh40Rq
	 peY/lw9Ww96U+90fHgtPPwcVqvZE8z2ucZ/qwOIJ8MIMkPsqwG/4V5dhqEkR0dnXEC
	 j0E6DzTehcZng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A1B393100F;
	Sat, 23 May 2026 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: dsa: yt921x: Add port TBF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949683163.1426243.10519013324184980193.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:31 +0000
References: <20260521010320.208138-1-mmyangfl@gmail.com>
In-Reply-To: <20260521010320.208138-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us];
	TAGGED_FROM(0.00)[bounces-290985-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C7FB5BC208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 09:03:04 +0800 you wrote:
> v3: https://lore.kernel.org/r/20260508065757.2566258-1-mmyangfl@gmail.com
>   - prefer existing extack message in qdisc_offload_graft_helper()
>   - comment the dilemma for TC_TBF_STATS
> v2: https://lore.kernel.org/r/20260504101258.1608004-1-mmyangfl@gmail.com
>   - drop changes on tc_tbf_qopt_offload_replace_params
>   - drop excessive checks for tbf setup
>   - react to TC_TBF_STATS correctly
> v1: https://lore.kernel.org/r/20260502215314.917687-1-mmyangfl@gmail.com
>   - remove queue related register definiations
>   - add missing extack param during tbf setup
> v0: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
>   - picked from old series
>   - add extack to the offload struct
>   - add all params to the offload struct
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net/sched: prefer existing extack message in qdisc_offload_graft_helper()
    https://git.kernel.org/netdev/net-next/c/d8785b59c330
  - [net-next,v4,2/3] net/sched: tbf: add extack to offload params
    https://git.kernel.org/netdev/net-next/c/b7b1b8464b47
  - [net-next,v4,3/3] net: dsa: yt921x: Add port TBF support
    https://git.kernel.org/netdev/net-next/c/09ac78477ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




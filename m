Return-Path: <netdev+bounces-265854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCXRJ8x7r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:02:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B8243FB2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3880E30518D6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4593002C8;
	Tue, 10 Mar 2026 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHq3T5yM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0F311967;
	Tue, 10 Mar 2026 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108030; cv=none; b=Y9uw50umkb9izoiNmReg3wfJYnw/0BLGvomnz/ShLDB3VWruGiX0tprk7E9opyAyetilhVypofUR74cvL1u7FouTVb/C8YFVT7P3Orq9MyRHs+MKUg78J5iHqASbXH/03t6m87/Mu3HKCFyf2Jm1WPOo7v++kNo2ZpU1oag/z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108030; c=relaxed/simple;
	bh=0JEemkAguTgCCENrKaLPi4A+rYINGEmJR8Uc+O0f2XU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcnMlVtthCV/1Unzp5bJFrhaAiPaKlXCDePNEqnab17Rti6ngBP5Q0hbFjnIqT+GfLjXa7T9F2dYFGwJeCqzZNSxCypHlQI7jB6pQ4Zjy3PEdHKdLuj4eQ6TimidnuTJ3zstpqNrng5HsRHNp2UodTA8AdfeL/GIIVtJWpOFfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHq3T5yM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB71C19423;
	Tue, 10 Mar 2026 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108029;
	bh=0JEemkAguTgCCENrKaLPi4A+rYINGEmJR8Uc+O0f2XU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHq3T5yME3laqaQwHCa6byGNjuQB3SLuNm7QXdoqmk0UBGbo+b8RIq8MbEhvTa11d
	 uclNmzmMjAz8Jt/dLM1uNAMJZw3gmCYFu6EL5RgHgQQq/gttBQFRCDD8VDH3KTCbjs
	 zG+w97kAjUs88GuhQOyDdAvWSDJJTL+kdQYtKFG9Gfp37C3r//A+W38YVjHpOl7sDv
	 M9lYwS4iX0uhmpYbq7vz6BV76akNJmyLixS3nPJC89vrPoU0FV5PBCa17vFaUFqMk2
	 A/yDFvTNQVGMNiw2EWGedFIdnjYH9eA6lWwf0RHa/1IhTEU1eA+e7XDvijKx9dS1U7
	 TGhS8mHGq7uVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC63808200;
	Tue, 10 Mar 2026 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310802654.2022132.5094822260637763016.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:26 +0000
References: <20260307163430.470644-1-edumazet@google.com>
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, toke@redhat.com, eric.dumazet@gmail.com,
 linyunsheng@huawei.com
X-Rspamd-Queue-Id: 300B8243FB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265854-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,redhat.com,vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,huawei.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 16:34:30 +0000 you wrote:
> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
> 
> QPARAM="limit 100000 flow_limit 1000 buckets 4096"
> TXQS=64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net/sched: do not reset queues in graft operations
    https://git.kernel.org/netdev/net-next/c/47e8dbb6e763

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




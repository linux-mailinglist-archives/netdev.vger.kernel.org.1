Return-Path: <netdev+bounces-282183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNWfJsNh8WnhgQEAu9opvQ
	(envelope-from <netdev+bounces-282183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:41:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB848E098
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 784D33014A33
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B653248896;
	Wed, 29 Apr 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB5hXsI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB423183B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426863; cv=none; b=FEey4aeRfMGd6+IEfHjTBooc8MNG99JgjfIlUi6UboApUaDJXJqg632/Bi6/uhbeOY/NaUc45jaJdzd4EkggmBVR64wwOU5w/KjjO+eQAylJEXARTpxqlz8K8yq/MDjT4LES/YUTy0BqPO87MUQz/A3lAVHtkejPHbn+RFAfsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426863; c=relaxed/simple;
	bh=y/SmCYe+u3Bll2kNEKBHHhUHIu5oLf2T0V9WhcRJ4zU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TMJOu323swrmBOXdDBpraamhvSgcTw3Riu0ZgkgrneOO5MJwGw2WtXvMVb9KLl/LWkWGnWviNeQpeiLg3lCVu/SlRX4V04RLJxsL0IExG8PwF+P/rSu+y2O98jTPlqKGDwWSqe0/zzGF2xmpORXtFmDD8jZMREvsoLTIzeG7Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB5hXsI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE6DC2BCB7;
	Wed, 29 Apr 2026 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426863;
	bh=y/SmCYe+u3Bll2kNEKBHHhUHIu5oLf2T0V9WhcRJ4zU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KB5hXsI/h7ylChjXE0Aml0XcisipqIv7GGaKP6JN+JBK5VhAWADnPRUrvuL3HFqww
	 SbofEgKAcmDzMfBF2LMvrqQXjPc6524GlrETmFNHJ9i/nzyzztVfDBq5jcHZUn064Q
	 P5tzcae6aZZOdpO4S0GHIRu++hFRau5zl6MhSi/SQApO/sTJWSSH1/o7Pfgw7Frxn8
	 SWq9jnjGGCh+Kol7pfmgQzZsVHoNKChqEX04/F84YboCUGyvUuVPaJHzEo9T4xiZne
	 1Oq6dm892Pdy2S+xe9d3p6xHPLQWYEHbNdIMlimbriIV4qqj1PmS+wx0G2DcMRknlt
	 Xz1Fuv+Bs6g3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9639302C2;
	Wed, 29 Apr 2026 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (series)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742681930.1291511.17805353884577275954.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:40:19 +0000
References: <20260427083606.459355-1-edumazet@google.com>
In-Reply-To: <20260427083606.459355-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, toke@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 88CB848E098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282183-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 08:36:01 +0000 you wrote:
> cake_dump_stats() runs without qdisc spinlock being held.
> 
> This mini series adds missing READ_ONCE()/WRITE_ONCE() annotations.
> 
> Original patch was too big, splitting it eases code review.
> 
> Eric Dumazet (5):
>   net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
>   net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
>   net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
>   net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
>   net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
> 
> [...]

Here is the summary with links:
  - [v2,net,1/5] net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
    https://git.kernel.org/netdev/net/c/44967ac3785e
  - [v2,net,2/5] net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
    https://git.kernel.org/netdev/net/c/91a96427b93b
  - [v2,net,3/5] net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
    https://git.kernel.org/netdev/net/c/276a98a43496
  - [v2,net,4/5] net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
    https://git.kernel.org/netdev/net/c/8fab48d87745
  - [v2,net,5/5] net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
    https://git.kernel.org/netdev/net/c/a6c95b833dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




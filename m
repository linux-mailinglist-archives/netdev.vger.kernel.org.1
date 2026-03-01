Return-Path: <netdev+bounces-262270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFxdHp2Bo2lEFgUAu9opvQ
	(envelope-from <netdev+bounces-262270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 01:00:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9391C9C6A
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 01:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21485301F9AF
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961432749EA;
	Sun,  1 Mar 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY0ODin/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA520C00C;
	Sun,  1 Mar 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772323209; cv=none; b=g3fDgKetC00R/YxxQG1R9JC4jj0hIlkVoNYdhtecyglz3BTEu09gj6iWTd/Gi25s9TWkFG3GszQowbtzS1R/wV6ZVfWEbBG8eGkb1H2RiA+uJY46vxfv3TMriM2PyCJQ3rgb/93ygkX6wMzWcPklU1VHMOP3lW2q3ZRvvAVVQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772323209; c=relaxed/simple;
	bh=fh4ObmTqss74v05OBV7OE4CtGzCUPSuRoZCPcHg2JDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4RrIYsjLa+2Ewosq6/omRITXoWNroMhdzlEwUbh5ZZrSKpGe92sSFeixGH1I5hf+RHo7wYwdH0RoywGd2knN9sqU417gUjrkw86bny1rjp4hsZjrMRJfVY1ATei5tqIdhM/FNUc1ywniGjRodmIv1zHvVdbH7W01D/wmm2jeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY0ODin/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB26C116D0;
	Sun,  1 Mar 2026 00:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772323209;
	bh=fh4ObmTqss74v05OBV7OE4CtGzCUPSuRoZCPcHg2JDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hY0ODin/CIvZI/1I+TVon084mg6B86qBhzUFDkAw69pxP4J3XoPLYPMRIgbzM3mQI
	 pLqP3RQircubHKSUswGmFu9L+u4RSGr6OvRvUFDpfgFtwrQGD7/u45El2YJ7lhnfRI
	 svCNwR7YofkhJQbynmSHW4t9yL8yefY71KpsYLhvIAFPXri9I8epHP2ONien4NKPL1
	 EGsWcpN4PZP1I2A89YiVjb1+3CgZO5Gg82RoO+mZ0xeQwUS6LyicZpcpNSNBvKOI3s
	 f4GKJZyrxVlafu5DDjD5ROrAdhmdmdY905q98Q+eClClos4zvxYFWp/AMADAwa1h4x
	 ShhK/OwZr3XHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFB339F2024;
	Sun,  1 Mar 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] net: sched: refactor qdisc drop reasons
 into
 dedicated tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177232321230.3162700.9839449465077142615.git-patchwork-notify@kernel.org>
Date: Sun, 01 Mar 2026 00:00:12 +0000
References: <177211325634.3011628.9343837509740374154.stgit@firesoul>
In-Reply-To: <177211325634.3011628.9343837509740374154.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, davem@davemloft.net,
 pabeni@redhat.com, toke@toke.dk, bpf@vger.kernel.org, kuba@kernel.org,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, atenart@redhat.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262270-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,kernel.org,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB9391C9C6A
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 14:44:06 +0100 you wrote:
> This series refactors qdisc drop reason handling by introducing a dedicated
> enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
> layer drop diagnostics with direct qdisc context visibility.
> 
> Background:
> -----------
> Identifying which qdisc dropped a packet via skb_drop_reason is difficult.
> Normally, the kfree_skb tracepoint caller "location" hints at the dropping
> code, but qdisc drops happen at a central point (__dev_queue_xmit), making
> this unusable. As a workaround, commits 5765c7f6e317 ("net_sched: sch_fq:
> add three drop_reason") and a42d71e322a8 ("net_sched: sch_cake: Add drop
> reasons") encoded qdisc names directly in the drop reason enums.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] net: sched: introduce qdisc-specific drop reason tracing
    https://git.kernel.org/netdev/net-next/c/ff2998f29f39
  - [net-next,v5,2/5] net: sched: sfq: convert to qdisc drop reasons
    https://git.kernel.org/netdev/net-next/c/3e28f8ad478f
  - [net-next,v5,3/5] net: sched: rename QDISC_DROP_FQ_* to generic names
    https://git.kernel.org/netdev/net-next/c/f30d9073ec19
  - [net-next,v5,4/5] net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
    https://git.kernel.org/netdev/net-next/c/9d3e7f971898
  - [net-next,v5,5/5] net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops
    https://git.kernel.org/netdev/net-next/c/67713dff6398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




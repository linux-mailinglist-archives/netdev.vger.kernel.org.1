Return-Path: <netdev+bounces-294995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L5hkHnDRIGqn8AAAu9opvQ
	(envelope-from <netdev+bounces-294995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC163C296
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KJs3RyUq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294995-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9935D300CBC6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8C233149;
	Thu,  4 Jun 2026 01:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23D7261C;
	Thu,  4 Jun 2026 01:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535659; cv=none; b=K8GnL6n9UpifVZBAZjP2/99SSkAzRZm6/QFe64IgMiCcs9cFw0QTG6AkWhLWVv44qoV1z5/svM5ms/xnloDjbJEAuu3XpJknWMXwmOq76WXEg1HxBu6P/tsKBGWEmvweE3JIT877+POfDX3Bx0lrZfiizO28MRCLLzQhxM9uGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535659; c=relaxed/simple;
	bh=m0JY9j1jrJGxguon6EA9o6IK0CyvDX9kCdJH0Et+kQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W1YkhasO5/lgvJAI+lBdLsssZG6AnCKiQFmzysL0wsL9XPWfT1nuG5nL9yAD7HRA60ipATbyrlWwJRve4VVDe+Nnis16tJWGILk65d+owMGuewXVHVR+iGJDTDjjuVVZyJU963Keqj9d0fyHkENuhtH7AItrBwgZCHSEhLfvKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJs3RyUq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36111F00893;
	Thu,  4 Jun 2026 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535657;
	bh=yPE0Nyv/KgTnVjzG/2No8SWrXIVPmBJhSxad9PYvHGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KJs3RyUqES/iZom1cpuPl4fHDkzJzHtXw8fr2gdIFYvNPO2MqikEE3qkGparSP1nQ
	 uQeqfLx4cHMJfDMmMif9nmNyVnlYXsaSuzt8cuz9CQTpzF1ZFzSxhp6uvzqvbrDck9
	 fEkl8Nld9v/eZnBP7IopQk+QybvAj1np65y6TNZP1cXM0cDbsI1nCgDtshJlVai22u
	 FRPfoDa317erRTkZ0kCZNI1tfZ1lz4wAhOW17JdnhNwV3eSWmDBJCLHafxFVDepDfV
	 PSvizIBdGC/4K/hQjLLwoNAUzoUw2CCoSvVP3JcpOI9kmaOfxu7kGItJrhyxIH7IaK
	 ug9BK8eARYWBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0239308DD;
	Thu,  4 Jun 2026 01:14:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] appletalk: aarp: zero-initialize aarp_entry to
 prevent
 heap info leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053565889.2042071.17791761648159069507.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:18 +0000
References: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hxzene@gmail.com,
 kees@kernel.org, linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-294995-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hxzene@gmail.com,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64AC163C296

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 18:50:16 +0800 you wrote:
> aarp_alloc() allocates struct aarp_entry without zeroing it, but only
> initializes refcnt and packet_queue.  When an unresolved AARP entry is
> created, hwaddr[ETH_ALEN] is left uninitialized.
> 
> aarp_seq_show() later prints this field with %pM when users read
> /proc/net/atalk/arp.  This can expose 6 bytes of stale heap data for
> each unresolved entry.
> 
> [...]

Here is the summary with links:
  - [net] appletalk: aarp: zero-initialize aarp_entry to prevent heap info leak
    https://git.kernel.org/netdev/net/c/2cdeaba5a108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-294358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DNTGI3spH2owiQAAu9opvQ
	(envelope-from <netdev+bounces-294358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9663148A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PU4BNPQF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294358-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2703007F55
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4637C900;
	Tue,  2 Jun 2026 19:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BF286D7D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:00:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426806; cv=none; b=iDQwZ0tzzJAVZ033yAwWEv/wUIaJW2ZcmXrEaYQyVFUIVis+u3CPQ1cZF+mmY+DhveGXhvhBU+po/PhuTSQhrcTmR4xZfb1zRg0zI6mY++BLbArjeBky9PQtJsPVCXMME/2PC/lQQNOckzrxYKKJwPyIXayoCUSBDtJ/yB01X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426806; c=relaxed/simple;
	bh=J9JY452fHoT1AdJNB4ASUj3ND+jA3CR1mEUmoJ/+WYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=so0D4ohLh3t6NU3pdV+pofsITo0B5thl+6Y8jKRP+o80mLj7xBZ5BRBkCkpO2x8jKFLqZ4dx2LTTZYS4MZcbb21rOcveeXcn2j2DD/9uSLy/xljxyteBpigCixFhiBFNjal7qmYEmZ0AzVWZVtOZ/zVC+5Y1aeUm1wfkt63sQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU4BNPQF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDA1F00893;
	Tue,  2 Jun 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426805;
	bh=M+Nm8VEBNt2IKyMAuknLaYO7pFn128UMvoXewkzmVtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PU4BNPQF1qRx7E93j9NK9eMJniWw98yImkLZLYQtxTVnfFL6H/Enic6Y5m3SSizQg
	 o9BtHRF2ysNFlvSW8m0rAp5MjeilLXuvxg4uhPD/esL5BNZDGKgxB9UXgw7yOZM6/8
	 KIJ1spGGArkdJ/0XSQZGOrYiDPWvtMXExzWA9nExc8tMOrGQmnFhjh/6EWqIvk/rEy
	 6gOj7hQj/QsPBbjgIGF3d8/L4jWkycc1g72/3CGQlc6BVW4MySEJQr+k/eCA+/J9Q7
	 dGUAQ1uIRW/uKdn/XE19KF1x1fGQ/URJczgJB3mYuLWhpZL25Llt6rCW4pQ9oYPgUD
	 sGNxT2YHxnLaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E43811A6C;
	Tue,  2 Jun 2026 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042680740.1007375.14491547621037565757.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:00:07 +0000
References: <20260601182101.3183993-1-kuniyu@google.com>
In-Reply-To: <20260601182101.3183993-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, tglx@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294358-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,linutronix.de,goodmis.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:tglx@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+e809069bc15f26300526@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF9663148A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 18:20:55 +0000 you wrote:
> syzbot reported a weird reqsk->rsk_refcnt underflow in
> __inet_csk_reqsk_queue_drop().
> 
> The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
> is called only when it successfully removes reqsk from ehash.
> 
> Moreover, reqsk_timer_handler() calls another reqsk_put()
> after that.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
    https://git.kernel.org/netdev/net/c/e10902df2448

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-298838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pFPIH52kLGr4UAQAu9opvQ
	(envelope-from <netdev+bounces-298838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606767D4E2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:30:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Db2przDl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298838-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298838-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AD613007A64
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9D1A681E;
	Sat, 13 Jun 2026 00:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621ED1A4F2F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310616; cv=none; b=YyFl9bdbROci+Zp7BLwkDcAKcd3ODVLCfTxfR7wzx8QyQpAh8uZskL2vYF8MPminLs94PHld6PwyrxG5QS8ICeV8sZz+Y2uqC8cNWIVAOp6ruqkIO76+nUHbqVuZxGZDdVdkUF9hf8DtLqHmMKh0C4iV3beptqjS2I37LOYEJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310616; c=relaxed/simple;
	bh=HocRj9BP97CVRe+akO0HmhDSKet9YHxE/MFa8S9bIQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FBUHO+hlFEMq6YWH0QHJHW4vjTKLhEhWTfcCxVRNQ89vzJW57zmhPmW00zAcfW+yUn8ZMIyrOlFzBBQeZQEqvqZHngGqBoreEOIoHkMibPEgZ6ge+UtrVL2GokeL7kg6hPnbNwLn6MDDYxcv6y8TwEHeBvMCCa810NYaP7VXrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db2przDl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AA41F000E9;
	Sat, 13 Jun 2026 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310615;
	bh=yutcQ84uAQv/SA13tcZeL6VzdiuI3G2zwMIpkziCw74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Db2przDlQAXJFgWcoMW/oRczInpyATZXXPwMq+4msEyNOr0kOyGwXJgVVyW0izjT4
	 E1swEXxnDmejtQOJjSCyEJ9wwH6tkxnDOMQfSZDmDpIQvO+IcXWlbzPiz4kMoPzhY9
	 PyFcJuW78949xT4oLB5kByhwvIrvgvyccWxHkGCqKJZndueqRF5UiUyhesXgu/gwps
	 lht+lzAUicIVNuk9pA+IlLfufWe6mM4gwL1lTGgrazCGQA0KfNMubYjaxMqu/Oaemn
	 oMs4MDcjYKhb5vaAlgpx5uVY9u5fFBUnpbduzSifwqlyFrM7cMIvi2+HKS3GTTHqDq
	 yJ3L/YJE/SovQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A539E9607;
	Sat, 13 Jun 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Avoid mistaken parent class deactivation during
 peek
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131061139.1306549.5056558403294785324.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:30:11 +0000
References: <20260610192855.3121513-1-victor@mojatatu.com>
In-Reply-To: <20260610192855.3121513-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, anirudhrudr@gmail.com, pctammela@mojatatu.com,
 ij@kernel.org, henrist@henrist.net, chia-yu.chang@nokia-bell-labs.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298838-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,henrist.net,nokia-bell-labs.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:anirudhrudr@gmail.com,m:pctammela@mojatatu.com,m:ij@kernel.org,m:henrist@henrist.net,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7606767D4E2

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 16:28:51 -0300 you wrote:
> Several qdiscs (fq_codel, codel and dualpi2) may drop packets while
> peeking at their queue. When that happens they call
> qdisc_tree_reduce_backlog() to notify the parent of the backlog/qlen
> change. The problem is that they do so *before* reincrementing the qlen
> that peek had temporarily decremented.
> 
> If the qlen momentarily drops to zero while peek still has an skb to
> return, qdisc_tree_reduce_backlog() ends up invoking the parent's
> qlen_notify() callback even though the child is not actually empty. The
> parent then deactivates the class, while the child still holds a packet.
> For parents such as QFQ this desync corrupts the active class list and
> leads to wild memory accesses and NULL pointer dereferences (see the
> per-patch splats). For HFSC it might lead to stalls [1].
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/097f6fc7b1ae
  - [net,2/4] net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/52f1da34c9f4
  - [net,3/4] net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/15cd0c93bf4f
  - [net,4/4] selftests/tc-testing: Verify child qdisc will not mistakenly deactivate QFQ parent
    https://git.kernel.org/netdev/net/c/101f1047c2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-302297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ckABukuP2pZPwkAu9opvQ
	(envelope-from <netdev+bounces-302297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A56D0C38
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UyGFd9SX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302297-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB1F83021757
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158BF282F00;
	Sat, 27 Jun 2026 02:00:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968A2773CA;
	Sat, 27 Jun 2026 02:00:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525640; cv=none; b=qsbdNPlqezXyF2fY0RrwcMlbNzkD4E2wRj5W4CIXctAAZr3pe2cBk4jITlnfLsu8pL9HHUOjZUGsKsbZGra1KAEKAUJ/jZp1SvpNyFivEZ9sHhMkD0qLdxPdVkLkzWoGND3hNMcMDzg0rS+LatpAOO58CkP3pubWcOaD4rVzDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525640; c=relaxed/simple;
	bh=aBu7WwNSA106j04af2V3nMVbhEprCuCy37bfeSUemCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptZ49++rTu3DbZcLDAwtix72vujJRv77khkoyz/f6V1g9VB9T8YIIJqLhApO8TKgEgH3t602ZvHBb3uRDsDSE05DK/ncoLoy2Qc25RdUf7M2xNAozU3eGViQNesW8z6ep+DJMACvN7uA8Wgxatr83GdTk6LQptQ4Sq7MIuT6YBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyGFd9SX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35501F000E9;
	Sat, 27 Jun 2026 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525638;
	bh=4yHdHGfkrZLSnwfN25jAjiOc+CedmjCoRZsVINi5sNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UyGFd9SX/qOM10FK3ksdjzHPgYYDJ3r6uWWjT+yb/bUXEPRJW4lQyQV7dSMkivcDP
	 rXxUwf28Fn+7lotYbz1/sVKywCrnOODUYayjp4EW36/IK6x+nXVEUfHHljbdn6iHUM
	 oZfKxLVYpN3pcbCMF03Ym3Ibls5fVi0R897oveA7XDdgwdoSAWIm67gcNufO6Gk8bG
	 wKsWebiKy9yTS5Sv89SHHztGSFAb8Hf+iJ/xf5EE6LgAceVCl+RrQtJHjReteZsJDN
	 uqZAdcRNqgsMj1ln+I3rtKMUThgp566yL8lGmVX4Y9KN7LkPNSJ7lPfXlPhKTV3/Mv
	 rmRpgnbzWIVjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A73938C76;
	Sat, 27 Jun 2026 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net/sched: finish the qdisc_dequeue_peeked conversion
 (taprio, multiq)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252562506.1167656.8248831428302845030.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 02:00:25 +0000
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: vinicius.gomes@intel.com, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org, jarkao2@gmail.com,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302297-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,mojatatu.com,resnulli.us,kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:vinicius.gomes@intel.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jarkao2@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 983A56D0C38

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 04:51:18 -0500 you wrote:
> Commit 77be155cba4e added peek emulation: a non-work-conserving qdisc's
> ->peek dequeues one skb and stashes it in the child's gso_skb. A parent
> that peeks such a child must then take the packet with
> qdisc_dequeue_peeked(), not a direct ->dequeue(), or the stashed skb is
> bypassed and the child's qlen/backlog desync. sch_red and sch_sfb were
> just fixed for this; taprio and multiq still take the direct path.
> 
> [...]

Here is the summary with links:
  - [1/2] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/e056e1dfcddc
  - [2/2] net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/54f6b0c843e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-294376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQhoGPQsH2qmiQAAu9opvQ
	(envelope-from <netdev+bounces-294376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:20:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F08066315BD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:20:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VenvZf5h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294376-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1275D302D4F3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058583F39E7;
	Tue,  2 Jun 2026 19:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F243DA5AC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:20:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428007; cv=none; b=g+4FJxQ10rRpqAM1VkH+N0iJLCp7LgWe2TQYrXgUVYcepJPjjD33Xa7XszS09zTR63FZdmw5FjaL2JUCF+JSTr5avvAjGN4A2TSohMh3A2bArG2fj9ejziZ+SxtAb7chnHEdZMkt4o+gWO/A6wGdd1tNQGJ8p0UlPDGzbxrkxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428007; c=relaxed/simple;
	bh=Q78dAqoq65jemOFdJVJQCN/YbIvmQAwZiAsrHKMM9ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VvZLHukoMZyxdOO/McWQKab8wj9AMQNZlBKVlOLzONZ8ciK2q5xtrbZGYrrnFqtPNmxJ9YmgAffQuM2svk/5XskMPICkAJsHBjtaxxYbvKfTn8MpmJkcCVp3ADH82AymWdPTAriQp+vSeAXAuDTK3XXovBaR1B8wRUC+SXaL0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VenvZf5h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B775F1F00893;
	Tue,  2 Jun 2026 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428006;
	bh=2xFNHCENoFTJzzjofaQM3wQmsBlq4+stG51vFiI+frY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VenvZf5hsPLm/OI9rtOZmMr1XIZDr29mqZy4f9Zqz1izV66dYcKRiM0//ZB2Xd2Lq
	 Q75zs0ey5Rau1QvQEA08+s7SQ5GRezUJsMUZvZLSd7wtzBwmgLRPq9UEbg0CWZc0HJ
	 XEhAUGNYpW/e12pNdJPm1GtdVef6XPYqTot01W4SO8m9+UFGeseCu5Ni/aUw5XFUXw
	 Ci7c3ZQQxaaV/fM3e+SP5XUyULWTuUMshevFLS06KE/oTWA2gN1K4nrYL3XfTvgSJA
	 TUwYWvM7vHCveULE9dEns/crfccdLPMZ+iGNdFzvsItZm1XTJnu+YvUkBMvvJ/Znh5
	 YTQ/gArA62iLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C863811A6C;
	Tue,  2 Jun 2026 19:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] hsr: Remove WARN_ONCE() in
 hsr_addr_is_self().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042800839.1014313.645602550229785321.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:20:08 +0000
References: <20260530064300.340793-1-kuniyu@google.com>
In-Reply-To: <20260530064300.340793-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, arvid.brodin@alten.se,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+652670cf249077eb498b@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,alten.se,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-294376-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:arvid.brodin@alten.se,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+652670cf249077eb498b@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,652670cf249077eb498b];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F08066315BD

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 06:42:58 +0000 you wrote:
> syzbot reported the warning [0] in hsr_addr_is_self(),
> whose assumption is simply wrong.
> 
> hsr->self_node is cleared in hsr_del_self_node(), which
> is called from hsr_dellink().
> 
> Since dev->rtnl_link_ops->dellink() is called before
> unregister_netdevice_many(), there is a window when
> user can find the device but without hsr->self_node.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] hsr: Remove WARN_ONCE() in hsr_addr_is_self().
    https://git.kernel.org/netdev/net/c/afd0f17ca462

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




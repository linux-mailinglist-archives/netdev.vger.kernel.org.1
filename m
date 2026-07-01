Return-Path: <netdev+bounces-303421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GeaiNLVdRGqAtgoAu9opvQ
	(envelope-from <netdev+bounces-303421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:22:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE86E8E5C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LVXBY30W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303421-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07FDE304EE81
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF1225A38;
	Wed,  1 Jul 2026 00:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847F1CAA7D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865235; cv=none; b=bM6CJzsTJ+RlUMzwV9vqn4oov6Txw+QXCpNrs6He6aEi5dUU95Keb9p+8pJZFOFi4bGfDSZkcSDvGKXiZmil3Oxue8IQsjvq31S5HL8L4FX5LSzFoLrLZhfoD2JRE5Iq3TXrLJnqDubmINN+4s8+KjcYAaUMDBON/rbAR8iUXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865235; c=relaxed/simple;
	bh=lXwJVfboG13WrDn2SUCesqqIcWwUA/r+mE25SODpWBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVn1k03mgAzfZTbc9J9mHR0wYDNfpbSOMDnHy7TbUEHZDoN0BOaU3K1a2WUXy/ftpRredaxcQ2zIy+Pijf7EH8tSgEu22i1S+NVRlz7JC2cjKDlgiGneasgDw6Pgdx5Q4q9zWuSKHIqrwB80l8143ZH3woIIC3Zqw8F0/1Gr5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVXBY30W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF421F000E9;
	Wed,  1 Jul 2026 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865234;
	bh=fFH1f1zljQGut6nXy3zxBffRmqvy/56HlL61A3NE7UQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVXBY30W2A9+wfP4Oh8/scbuvljX7VxEuoEnmeqzEOgfEW6Rd9h8FucJlKeDvuSlM
	 5+kZdBi1/D0qw/AQVzHt9CNrrKSirr5dx/gDssT2DoeAnhY91HVX/nWCKQxH8dZfK4
	 1ha40pU66werxx6tl2LtkbaBXol2Ri9mGQb8tTm5R3Dg6ce3YmzgodaoeAlT4E75Fw
	 TFjKQm6w62B3rIxbl3qAPYaUhYHJzE2AySxDidLv3v6bPhCfInhmprQ4tTs5CZJ4Yf
	 ptnukHK5wLxepXEJAdtIO6fNS80jMvOcnaB39o5Rm3L8lDg+gqLEhY8JggcJ0JbaXc
	 S03fHbWJ4hDtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392A393A963;
	Wed,  1 Jul 2026 00:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] bonding: no longer rely on RTNL in
 bond_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286521813.349616.3126953661731602268.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:18 +0000
References: <20260629173200.469953-1-edumazet@google.com>
In-Reply-To: <20260629173200.469953-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-303421-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EBE86E8E5C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 17:32:00 +0000 you wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on port->is_enabled.
> While this field is written under bond->mode_lock protection,
> is is read without this lock being held.
> 
> Change bond_fill_info() to acquire RCU and use READ_ONCE()
> to read bond->params fields that can be updated concurrently
> from sysfs/procfs/rtnetlink.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] bonding: no longer rely on RTNL in bond_fill_info()
    https://git.kernel.org/netdev/net-next/c/317cefdcaacc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




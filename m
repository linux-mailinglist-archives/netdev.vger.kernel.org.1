Return-Path: <netdev+bounces-297006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XboUBiXpJ2pg4gIAu9opvQ
	(envelope-from <netdev+bounces-297006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17165ED00
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:21:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O7jqYXj3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297006-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E0E302F26F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35637C0E1;
	Tue,  9 Jun 2026 10:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EB2E9729
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000408; cv=none; b=CzRrrrbvn4j+2Fx4G72TnUjx4nAGm1kx9g5PnT3f+kxnHfk+TFco4gMHMEHmtmrzym7YKfu7VtzfhqvBPypBXSxI87TTYBOyv3Hj236+gNTB6UF8r7uDJCCEGwjluOzuJ8DxssU8qeU9fBFXsdDvrEcA35voXPE/+2jpy1QFkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000408; c=relaxed/simple;
	bh=lESJ6wiWVmWjLS9C7xguInk/92xub3MnZcLz5JMJ2K0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5MBCz875G0EI6SXE2V2s1b+lyYajesOllDVNtQWklOEaH1TSmxvWDdyRTwTnL1/ST6yD8bzEXgFayPH8/NStUQnrGVJcod9NMe79ukkXybbuuACFSmHWS90l/t2+2InuMPvvrJ30KziD+frZuZqvDfslzfemD7Ii9Vg3xr6EK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7jqYXj3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F181F00893;
	Tue,  9 Jun 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000407;
	bh=hcZCPZbAXpRMsPBMLdVQlgVIeSEL2c2sr6R+Tr9s+jI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O7jqYXj3QGPi1zR3gffW+VRA+q4jXH4na2yLtuafV7mo0ztoH9vhJ3bw/fXqt+BSQ
	 xhFqbw8i8xQbjESSQC1KLF35/uJgILKEJs/iIYWWH8hdXWe1NUR/IeeqLXsj1YQ/Rf
	 ckNBr4wvRj3DMyo5pT18kiRucIlAEIwFmajyoC3hrWkVpxgHgRkweSGK1N7PnYzTx7
	 9Op6Z21Q2RZkrG777KlEvyMjAlGnk9pZncEkMzc2pfk/Xnbrcy+IbQmiixQVL2XqQR
	 D3KXZJj3HeS1kfzAo0UhW9nZOl/CmsDVQFd8ABZc10BrS4tWC6W+r2PTVnmeZ3+np2
	 LrNmz0EmimDNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D096F393078F;
	Tue,  9 Jun 2026 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Update function name in
 TCQ_F_NOPARENT
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100040540.1935013.2799395346981956131.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:20:05 +0000
References: <20260605212239.2261320-1-victor@mojatatu.com>
In-Reply-To: <20260605212239.2261320-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-297006-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E17165ED00

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Jun 2026 18:22:39 -0300 you wrote:
> Commit 2ccccf5fb43f ("net_sched: update hierarchical backlog too") renamed
> qdisc_tree_decrease_qlen() to qdisc_tree_reduce_backlog(), but this comment
> was missed. Update it.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/sch_generic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: Update function name in TCQ_F_NOPARENT comment
    https://git.kernel.org/netdev/net-next/c/06528596662b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




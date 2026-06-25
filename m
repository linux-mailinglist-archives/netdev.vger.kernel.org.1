Return-Path: <netdev+bounces-301832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZRsBMzGOPGpppQgAu9opvQ
	(envelope-from <netdev+bounces-301832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AE6C255E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IgJgHXNG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301832-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4AA303B4E5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBC3A960E;
	Thu, 25 Jun 2026 02:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA63A8757;
	Thu, 25 Jun 2026 02:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353429; cv=none; b=Ih+zySJZGn5PKXgGaDpoZP1EuZPgYq4zqEEIVkj2/bdEFl7VHTMpx6qagmMeB9BHkb3Dr0SmwdzDP81sHa/b0AEasWnO4w1Tbf5H0jsjUqAAjDGCKAN7D6i+XWW1Xww/3M+cKDMD314TpW8zlcgIJItFXhrw63qrcKwla244YWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353429; c=relaxed/simple;
	bh=NGQeKDnfgCrXu/1cMppN+cdKDM1jC2DCXUnSIWGLp3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I0yksGdG/B/EnNNUraHJX7QZUtM5pxbLFXopOX40GuWe84oBq4vUW+GsYotHA1bnIsjZhZvM2U2ByXFHGN3FljoI46d460xzpzpjby4rsdeoW7cvzEQlAKDfeRINQ9p439VmQzyA8/lTmHwBP50fJMXhzGEJWDE8dXQPX0Y7FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgJgHXNG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBBF1F000E9;
	Thu, 25 Jun 2026 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353428;
	bh=uQ86/oRM7sU4wIrh/FJZ/Eb6hahhyaUF9V2kasWDLfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IgJgHXNGcYobqHw0eVpsTZzbvUU4ADZdBBy4AdAxASM0u6COr+UgYM77/kzwlZtjD
	 LwRRCRdS6k8p163T0YrBHspra1Eko4mHl7cr6rsmn4o1ZQ7xJ1+XqbZCuRHg1ke4Mb
	 3RuETEwwCXK2NoKMa8qflgHI3ulkz1lJ9iMVvY/j5aqT5zoQvbqHU4J3smMx/GbOiE
	 lW8T+R0Mb2vVUdY10qpuPPFQOxyNNidcQ2yw2L73JjtlL5WeQfJVe2E1NJra6p9ZBG
	 jxb+zUdLxKdWi0Z+7YxPhYBnBdYIZQLQjdCHr4K5iGETmYwVlu1SLKRD4m58NDmpuL
	 +LYUjCli82RNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABA3AAA6D4;
	Thu, 25 Jun 2026 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235341652.3082498.6358725051610913583.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:10:16 +0000
References: <20260622074350.1666290-1-yun.zhou@windriver.com>
In-Reply-To: <20260622074350.1666290-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301832-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3AE6C255E

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 15:43:50 +0800 you wrote:
> On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
> IRQ disable/enable scheme for NAPI: the ISR (mvneta_percpu_isr) calls
> disable_percpu_irq() to mask the MPIC per-CPU interrupt and schedules
> NAPI poll, which calls enable_percpu_irq() on completion to unmask.
> 
> If suspend occurs while NAPI poll is pending (between
> disable_percpu_irq in the ISR and enable_percpu_irq in poll
> completion), the interrupt is never re-enabled:
> 
> [...]

Here is the summary with links:
  - [v4] net: mvneta: re-enable percpu interrupt on resume
    https://git.kernel.org/netdev/net/c/fd398d648098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




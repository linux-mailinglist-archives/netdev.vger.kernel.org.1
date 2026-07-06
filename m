Return-Path: <netdev+bounces-305023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 09BBDVKqS2rHYAEAu9opvQ
	(envelope-from <netdev+bounces-305023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261917111CE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gfVOT0Ep;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305023-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305023-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1BFF315D213
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73B436BFB;
	Mon,  6 Jul 2026 12:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8E4314A0;
	Mon,  6 Jul 2026 12:50:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342234; cv=none; b=U4SwVVa0LkTeJTVxgTrGPGv3Z7hG5u6Flt6wNyxF/FB8kUY8NrVXps9Yd4lUjqiCgYkxy5Bkx77f3SxDKKnI4xezSrGP3K99rfO1LT/UbczKOYlP+UTxobDZkJL8NjwD1A3lP2zbf/OhHZMmacZmd4yt69cAF7jAj3o7vewREu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342234; c=relaxed/simple;
	bh=dJTnsQjTg7PUOYsGLtWV6ZDJjk+5j8akBb7rpVKeU5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OUbqWWt/XNG89Yp3JqfpNYQlv3HkSjNt03gQC+Vo5iTHAk+cjh48fDzObz4qeF/xj/gOddD0Lg1fVfUjlIXj4XmC2CKyWllPpF7XM1tuK9zay602X3p+oXIaLWWgrGJZa7GAC9bw6ncG12oYe5NVpRbeD2fcOOw0knlsWM8pKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfVOT0Ep; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB371F000E9;
	Mon,  6 Jul 2026 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342233;
	bh=nGoxNEt9aSaEtdNMdAjzoqSfrY9lFD+s2pD4JJq5j0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gfVOT0EpBqp+7cotyn0T49uELIJcdxxhhvZAr0xrvUkXXi0ljKYcKMMo8JLJenvH5
	 h6Q4mxWR/IzhyPQG1DCrL2xaTo2QSXSkL+r+phDfh63QtF74R92ubEFGbO/GtB2H2h
	 VqJvHr3IJ5WcKigBCnHbHDoBei8H+QPpAUGCqhT8q/sgsi30Mhp4YnFN3cg8af2M6g
	 ujBlUyzEUKr94xR0yQifCHNAo491m9zxtmhe0F8cHmIe1DIAt8H/hPEv0lRsfGcrNH
	 R3fhn6+OQK/wNz4AxKru1NIh6rYRiIr4W87BTSSb+UuEZLnWbrzYjsO8koWeL5ldzf
	 j6FEWNND7rw3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B7D392704B;
	Mon,  6 Jul 2026 12:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] dpll: add NCO pin type and zl3073x
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178334221414.555369.260570406265552226.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 12:50:14 +0000
References: <20260630125536.720717-1-ivecera@redhat.com>
In-Reply-To: <20260630125536.720717-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 kuba@kernel.org, jiri@resnulli.us, mschmidt@redhat.com, pabeni@redhat.com,
 pvaanane@redhat.com, poros@redhat.com, Prathosh.Satish@microchip.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305023-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 261917111CE

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 14:55:31 +0200 you wrote:
> Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
> the NCO mode of a DPLL and implement support for it in the zl3073x driver.
> 
> Patch 1 adds a STATE_CONNECTED_OVERRIDE pin capability for pins that
> can override input selection in any DPLL mode, with a WARN_ON check
> in dpll_pin_register() that STATE_CAN_CHANGE is also set.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] dpll: add STATE_CONNECTED_OVERRIDE pin capability
    https://git.kernel.org/netdev/net-next/c/b1d0c412088e
  - [net-next,v6,2/5] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
    https://git.kernel.org/netdev/net-next/c/0cc8348a9786
  - [net-next,v6,3/5] dpll: zl3073x: use per-operation poll timeouts
    https://git.kernel.org/netdev/net-next/c/2b11bde391c4
  - [net-next,v6,4/5] dpll: zl3073x: add per-DPLL serialization lock
    https://git.kernel.org/netdev/net-next/c/21460118d71b
  - [net-next,v6,5/5] dpll: zl3073x: add NCO virtual input pin
    https://git.kernel.org/netdev/net-next/c/3553976ffe2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




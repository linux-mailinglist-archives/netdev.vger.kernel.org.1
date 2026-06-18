Return-Path: <netdev+bounces-300282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KQ9kGMs6M2ol+gUAu9opvQ
	(envelope-from <netdev+bounces-300282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:24:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02F69CDFF
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:24:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xb7fWgoX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300282-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C8A30C79CF
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75847233926;
	Thu, 18 Jun 2026 00:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6276231832;
	Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742065; cv=none; b=k4V7FLOidNr9UztUCeUZh87WmOEQcub1RsviQbhlC8O6tjBcFRToriqr9sf6pEnPfIw0/RLrcECKWy8b2Z1aUhWHH2iFkfb1wNAAA4d4GZ9QNwTrT/+VpOPvDe0krZT0u1ZwAN5efHsVIqZreSGqQA0wNN40hfAioxrXaBQYQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742065; c=relaxed/simple;
	bh=Cjbhjb/KWtAfgGlgSDMuPfDlBC+Pig8YIVBznosYl6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8GHLlUpwlX2a7BppkIq5QIA3A4GFF9dmV9xKN36aOod95hE+52oNzgPBTJRI4Oa9pZsG/qi84HktBLNsDQmkFCPBsh0LcFOWH08TA/B98T4Mx6q6MCwRc6A6i8wg6/Wi4iIvmxidgPBJHw8ikv+rddEr418jXk8LpdzL7+hWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb7fWgoX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818541F000E9;
	Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742061;
	bh=TuXxwD1ly/AHxANQlxl6NxnU8Kd9W0BNlkpZ37PLkGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xb7fWgoX36IprWFQhjs1SXWTBvyLNPzRbgrd3v8TS+CmZOT/eijgRu/dN0oXzELHX
	 EaSTr59X5A4fsVTvNBshGE2IHWiLHUOzfGahAre2fV9tl70opvn23OMeN7NVInC3ll
	 +lO5M6nKy8lUkbnreGZELG6evs/ij3SGeugph8PGKyTUv2RGBTqKtyBkZp3Hp4lZnI
	 JhmtYY4NKfE4PABjHvc0uBPSPhpeI3LFO9w0csP1HlZ50PuqFzCz4qVWRPjtKS1g5P
	 YSB8SFQAssT7A+1UB+U+Kn8t3rgnVvkaNEUalKXS36DxAwq++wtIo9SKnyqXNqPYrT
	 3jSbmC0N1PgJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A59393102B;
	Thu, 18 Jun 2026 00:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205515.1875263.11940436993209911826.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:55 +0000
References: <20260611102517.445549-1-robert.marko@sartura.hr>
In-Reply-To: <20260611102517.445549-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300282-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC02F69CDFF

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 12:24:49 +0200 you wrote:
> The Set User Byte to Save command has three subject bytes.
> The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
> carries the NVM user byte.
> 
> Template only initialized SUB and SUB1.
> Fill SUB2 explicitly so the command matches the documented layout.
> 
> [...]

Here is the summary with links:
  - [net-next] net: pse-pd: set user byte command SUB2 field
    https://git.kernel.org/netdev/net/c/e586644d0a89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




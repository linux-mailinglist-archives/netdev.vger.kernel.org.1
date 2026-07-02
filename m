Return-Path: <netdev+bounces-304074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w2nwKlhBRmqhMwsAu9opvQ
	(envelope-from <netdev+bounces-304074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC366F61E4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:45:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Aj2zOvSU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304074-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304074-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EE8D31785C0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107DA47D930;
	Thu,  2 Jul 2026 09:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA53C5522
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985230; cv=none; b=gCviAzsJCQ7vjIeUHHH90Y7NE+4j8Ns/Ocfx3qMVcOqSR4a6ExoJ4LiYNAzvLqQaLNPsxw5xQcznwmtliM3z1kLxgWKqFx57uXcG3M7RZ0ZTrqCXn8AxKhktmeeJsXvG797nymqQmd9i8mQTN6inSAQMZRHDP2iYAx/pzmcB4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985230; c=relaxed/simple;
	bh=yvK0MHwx3vmGVY/m79tt8/pIuXHxGujFVNnZk8BYjSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lKsxi+zP5kUBf7E0aD2cfKAAWNzVWG7vetiWpiN4ej1kbVmxiYEwihVYkjlFxJrHLSSLK4zC9X/MbEAYeEihb8Q5LzCaEPF7LkbMuP20JCGYy2vAQ+HAjf7bK1XW4+SysEo9Q9RP73fFAneVJasyVofU3etj6IFfjfSnm3M6Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj2zOvSU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73681F000E9;
	Thu,  2 Jul 2026 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985229;
	bh=QHumWo5ev5sDskVNG2A5bm/KnmoR+NC3wTyj2R2aC+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Aj2zOvSUf/YZXgbbG8ZoTR7CVqGiko/dk6UIY7AYjOY4+LBH95x4r8GRGyP41z7rt
	 +F9bVbNELqfgMs1a2h8qH4YMk2nRIXbJ6VeUJpA1+1d+UR94FGZwWvJLuPE6JQZEBN
	 n2GBlH7w4cLWV+X0wv9uzQseVWgoM658iPRrXpmtq/5NzVC0OLoqhc+buYjDtRCDqI
	 qczVIyg8PhiFbIRIZOMR2EjKGvemZMgQB+2rSgDXMy0sCwh5ZyrERVdmCa+mt/vvx9
	 yc0h8+F9zHTYSXYgtbSriISKcCaNq0QBYU2XHokxqRsG3yBhGHBHBlLWQpK/LhVpbn
	 GECajn80AVbdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B153926675;
	Thu,  2 Jul 2026 09:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: dsa: realtek: rtl8366rb: Use generic
 RTL83xx code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298521289.1553926.2007107223584159437.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 09:40:12 +0000
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: luizluca@gmail.com, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304074-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bang-olufsen.dk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:luizluca@gmail.com,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEC366F61E4

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 13:19:40 +0200 you wrote:
> As a follow-up to Luiz's and Alvin's series improvining the
> generic handling of the Realtek DSA switches, this small
> series brings the RTL8366RB closer to the way things are done
> in the RTL8365MB driver.
> 
> This patch series switches over to using the generic helpers
> for:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: realtek: rtl83xx: Make learning optional in join/leave
    https://git.kernel.org/netdev/net-next/c/69bf497cfa79
  - [net-next,v2,2/5] net: dsa: realtek: rtl8366rb: Switch to generic port_bridge* handlers
    https://git.kernel.org/netdev/net-next/c/82ddf181448b
  - [net-next,v2,3/5] net: dsa: realtek: rtl8366rb: Use DSA port iterators
    https://git.kernel.org/netdev/net-next/c/cc61d5d7c205
  - [net-next,v2,4/5] net: dsa: realtek: rtl8366rb: Disable STP learning on all ports in setup
    https://git.kernel.org/netdev/net-next/c/e058ab0c4616
  - [net-next,v2,5/5] net: dsa: realtek: rtl8366rb: Switch to generic learning enablement
    https://git.kernel.org/netdev/net-next/c/b269a0596191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




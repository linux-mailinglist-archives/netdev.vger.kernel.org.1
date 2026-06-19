Return-Path: <netdev+bounces-300571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9hyUFluZNGrQcQYAu9opvQ
	(envelope-from <netdev+bounces-300571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:20:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6286A3877
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W+EcR2Vv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F36A302622F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B9314B63;
	Fri, 19 Jun 2026 01:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DE29B781;
	Fri, 19 Jun 2026 01:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832023; cv=none; b=UA/ktKNZBdF5YZTkJrDVYTpc70ZBFqQDlqvGyOkMNhCfE8771A12/92murMpZGurfqKYMwXLq0oqG4AUXyq1B7aXDPfBWqVMvA2Vb2MfRQeTEHvCIGXyFTnmq1tmHJ0FOec7edB8i1EaLiW0hG53BR31f3oOu2FItW4VLTy9dZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832023; c=relaxed/simple;
	bh=AXDp0hte4mIH3Z0lK87WeLKyTIfPrXPEUSmdoIUvIw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qol6vg0GlREw+bKNMk0nhlfd1lvxNdNumdiTsl1x6CbEM+Sz4yvRoPWgSbU40/BZcXpFXpUibuTj15pnSFJV2o8RlCQLeYJOXhaP1UJg+ambSfv47r79ZNAdIJZCbmryq/F4OwniGEYYATVrFZy+aZoR4zxtULHmjhUuX0HC0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+EcR2Vv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5D1F000E9;
	Fri, 19 Jun 2026 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832021;
	bh=ygg3GDdLHLLwrZPS+Uyqmft3vzEKyChkPs6vfBY/QVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+EcR2VvZcnXAYv59XKSsZ7HwYbe9d+X8oi8oskxnhVfQb9txRukJ05TIxbWL5L6d
	 o1nqcoD9hENcvN9mz0/OV5bwPwkHnOrBb/zX1JOJ9zYxi8T2Mpt1RQRfVLq8AaeXjQ
	 aCMllzSUdsD0Aop2Cj+BHeMr5EjCO2iBHUxuPkJmaWswrucd2AYX2Q6Yw2uwsmvtL6
	 OanolixmpnZj1kob0wxcUozMf1UBJgNRf/i6aJvLvRFAe7VAy7R3qooUSsVqp7BZCV
	 Gz83WU6lvWm/epZsLQ1Y+LGkjSNxu3iC/q4wbPxV9GNcU4+PiIqNwPZWmg89E5KSkI
	 SwsAlfSHedXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AAB3A78A7C;
	Fri, 19 Jun 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from
 lost TSTART write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183201489.3150917.15246467988851878585.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:14 +0000
References: 
 <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
In-Reply-To: 
 <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, nb@tipi-net.de, lukasz@raczylo.com,
 sjaeckel@suse.de
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300571-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:netdev@vger.kernel.org,m:theo.lebrun@bootlin.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:nb@tipi-net.de,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,raczylo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB6286A3877

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 15:23:03 +0200 you wrote:
> From: Lukasz Raczylo <lukasz@raczylo.com>
> 
> The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> the TX queue.
> While the exact root cause is not yet fully understood, it is likely
> related to a hardware issue where a TSTART write to the NCR register
> is missed, preventing the transmission from being kicked off.
> 
> [...]

Here is the summary with links:
  - [v2] net: macb: add TX stall timeout callback to recover from lost TSTART write
    https://git.kernel.org/netdev/net/c/e438ec3e9e95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




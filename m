Return-Path: <netdev+bounces-295540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NEYeLoUlImpvTAEAu9opvQ
	(envelope-from <netdev+bounces-295540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E20644635
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="M/NKAumw";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295540-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FA6930DF416
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493173AE1B8;
	Fri,  5 Jun 2026 01:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E9377017;
	Fri,  5 Jun 2026 01:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622419; cv=none; b=ph0ynFlKOcMEWgNg02uiDi+PgHlQKg+t4mEkg56D8HVtTR3sBUdw3Ndb37SwsnYibntvIdMBBE+mEDTxbaTwU1uvCb/iiPXavB4MsOeaR+UpaRKTv8Mj5+sWb+JxXrQr1I22KETRK2qMX7MqiraVMNLjgPxD91ZkpPz5KoLjPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622419; c=relaxed/simple;
	bh=1bQJxZK7MeXXJBmIg4m/IW7noycyprJ61qDFvno2fqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HIZjsOIzCSbHmtDEl0AFO0HDCa2wohl63dz71MSP7ZlnqL7MSUtUQ0xE20KkiYqWUsyH459dEeRu04O2CKghQyUBF+Vp5IeslWwkVtiZ/3JNn7H50Y9CUul/6CYIsFiibJ4GSBCEt8FDv3vVRrjK/4owz8ZRec93RECqX+MptnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/NKAumw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9051F00899;
	Fri,  5 Jun 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622414;
	bh=4iHe6xyo7nTzKTHdpcro7w98xSsaOFhGmdocRbk/QoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M/NKAumwOPGGfnEyY4bWuWiq3GmjccaCxXf5DGUibL9G5KoYHKBOCKlJZsg7em8IF
	 GfA87AvGNfR8sv4P6Xx9HBEB8fytKqFmCopXvRF+x2hAPtxKzjitJWA1mx2Nu7tGvM
	 dU07WndEmQtrpn3MyHA24da/OnAV7BomuaJTRx6gSQ/8+QJ2XU5ARxG7Oo7Dr9dzEx
	 BeD2JsIJGayL363wcbrkB/rD6vF9mg0KJFp7Qp34xCLHI7beSqBSzRM6B4uL637rnx
	 oSYxOrqFSdd3w6WMVZlF/8lUdFGi2ya8Qpg7Wv8q4Y7hOG2UGCuUukx8FviQ1J5Wcs
	 Yq4y2kyKzY/yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FA3930A8A;
	Fri,  5 Jun 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format
 specifier
 for MAC addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241439.3090676.13612712978442840035.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:14 +0000
References: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-295540-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33E20644635

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:20:11 +0200 you wrote:
> Convert to %pM instead of using custom code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: realtek: Use %pM format specifier for MAC addresses
    https://git.kernel.org/netdev/net-next/c/c1424df7ff82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




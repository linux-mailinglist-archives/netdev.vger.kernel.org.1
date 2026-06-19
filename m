Return-Path: <netdev+bounces-300581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oTg0GAaeNGr3cwYAu9opvQ
	(envelope-from <netdev+bounces-300581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:40:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38A6A3916
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b75OFL6x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300581-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D924301ACB1
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636632B12A;
	Fri, 19 Jun 2026 01:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6A2D7DFE;
	Fri, 19 Jun 2026 01:40:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833216; cv=none; b=d1ERyfIDnCQ++myuu3sOZacPAPnP/VmaUZ4d8wjafLzN/RK7qkWBViOMitZzkk6aGSgomA2rtw5goOgLY180kwCapdFuvIKdgnj4QEoAhuU/qSZg65b97haK2iiy4Pmwzt/LAeWDV3f3TeTBBFWQDEAgNzWGengOM2MuvMiyCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833216; c=relaxed/simple;
	bh=tjrJsdIiHCYCLuGAc4YYeeH+4fv9InnIjprEQNO+zmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rvEzdtVLmCZfyyAl7DhyZkcOv8LaR5ocukUrufZrPC44Vk6SQFdCmVHSTxDjhDQ7lhqLCddZXoHdn3Lq8Xbw5Zk87dNfBV8rEcg4HLlOW8YzV8Kczk0xElWJQtNmSgB39JtNes2n2saijbPI+86OC7OetTq0fSPpt70CJJraTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b75OFL6x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772C1F000E9;
	Fri, 19 Jun 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781833215;
	bh=dalQDSYP5jn89rgqcf5/uZT0A/dR08jUgd1Cghk6t9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b75OFL6xe+b5ekbEeWHRibmKM1EsBaKKZoTFMiXNjsc72DtqbBQmG8QPaKzmReyYZ
	 Nhs/y9pn7RznylrAoyMjPQDIszeM7Vq9qm5Jfs3Vj0fhxkWU1SSjer9A4+DaOogkkf
	 H253LEv8zElD1hIzeXTbkKvka+Hmt6ZGmghEZgnnLDjzHIc+eVgM/yTzvpgRG8RytE
	 EvpbshVk9963EMQFHIyjf+ZQnV/Hm5at7SKaeAhlgN4va15MZraTzDVyp9yJToU0RW
	 3pP2Qbm2mwEh//INjDmNPS/OZwmH/KnSS+iMUuM2AF3pWJAJxq3IZfaYAH7RO4/T+G
	 1+Uu2VMVhPwag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397F3A78A7C;
	Fri, 19 Jun 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: take netif_addr_lock_bh() around rx mode
 address programming
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183320839.3155315.16217960317472010329.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:40:08 +0000
References: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
In-Reply-To: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sanmanpradhan@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300581-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:kernel-team@meta.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sanmanpradhan@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danielzahka@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E38A6A3916

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 03:39:49 -0700 you wrote:
> When __fbnic_set_rx_mode() is called from contexts other than
> .ndo_set_rx_mode_async(), the uc and mc addr lists are accessed
> without the addr lock that __hw_addr_sync_dev() and
> __hw_addr_unsync_dev() require. Wrap these unprotected accesses with
> netif_addr_lock_bh(). fbnic_clear_rx_mode() has similar issues.
> 
> Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: take netif_addr_lock_bh() around rx mode address programming
    https://git.kernel.org/netdev/net/c/96e7f9122aae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




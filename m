Return-Path: <netdev+bounces-297380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WHWBKlK9KGqEIwMAu9opvQ
	(envelope-from <netdev+bounces-297380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:26:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A31665319
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:26:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eUtOg2mR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297380-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297380-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C1F3110AB9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA523EAA0;
	Wed, 10 Jun 2026 01:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B87E0FF;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054418; cv=none; b=N/CbTTTa5bVpTRTOsnidQgON1U5XvKlnOZZ9aWHQQIUw4oUVHKfb2dESlDqYqbP3ltnA3bgNkc+foZXnvVIN4gy8NXbluR4m+9teT0ikw/gQ/QCzVsYcxG1t+UHddxBX/aCsDzhIWzy/0s8ZlUgGCXL+K6AQ1Gu60sw4HwlOny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054418; c=relaxed/simple;
	bh=CHLiqPsKNMX5exPT742i0+3IE+Iy/k4VLewc72kYpw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hb5zvjrvTiFzHyzWWc2lOmtJIz7yV1BqrQmJVjQDZjWxY7EUFpkVpv/NbuvYLL5J+kOhn86r12cC6wskZIbmbcOd7ypOHBHjWpOISrEY2DlamlnEw0mAiezzL4l1tADoKRB27uL1eyaAkI/tgLxja3iBZDU2Xp0+cbIx44UJoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUtOg2mR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B051F1F00893;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054414;
	bh=aKGhdlzuvfHlB4+p9iqkgQqduQF9ViQTH2yVd3SVtuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eUtOg2mR1lCcDK8GHRNBijPvBxSw0/KeFz0ihiof2G8EChKTtyN9VTuNEEzrPzHsH
	 +wJ6kG6bkglUnVdSedQRwvvdcD+KWhL4+Uyj/M3EeVXCKLhjzucWbId1uqr6nU4+x9
	 mjEVsZqO1uJLBdXxIJ3IHoYRO0WKYxtX38JPRyOj2dOGFEa20tkAeilGfLH+GbmTc1
	 Fn4O6coR4Wjm5t9oIIiAud2LQgks9rgWD/TmOfzJJh+7fEMvY2s0vE3h9XuAaYTniu
	 noPxj9tWbhoYDOYhcGfOJOsZRz9Nivy5AuSqSAltNWjvNgXrMGeZKNx5iPWikLOT3S
	 8renqt1l/1NQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197403930A12;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next] drivers/usb/atm: Replace strcpy() + strlcat() with
 snprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105441263.2779729.6672573959508250060.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:20:12 +0000
References: <20260608095523.2606-36-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-36-david.laight.linux@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, arnd@kernel.org, 3chas3@gmail.com,
 gregkh@linuxfoundation.org, castet.matthieu@free.fr, stf_xl@wp.pl
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linuxfoundation.org,free.fr,wp.pl];
	TAGGED_FROM(0.00)[bounces-297380-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:3chas3@gmail.com,m:gregkh@linuxfoundation.org,m:castet.matthieu@free.fr,m:stf_xl@wp.pl,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0A31665319

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 10:55:20 +0100 you wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Avoid string function that are due to be deprecated.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> [...]

Here is the summary with links:
  - [next] drivers/usb/atm: Replace strcpy() + strlcat() with snprintf()
    https://git.kernel.org/netdev/net-next/c/41d3e102edc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




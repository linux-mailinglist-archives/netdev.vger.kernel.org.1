Return-Path: <netdev+bounces-298376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rt/aDpEyK2pp4AMAu9opvQ
	(envelope-from <netdev+bounces-298376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:11:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA96758E6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hWRjSyTj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298376-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08483324914
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C47383993;
	Thu, 11 Jun 2026 22:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656C3750CA;
	Thu, 11 Jun 2026 22:10:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215811; cv=none; b=Yn2ro4tJxLiUhKhP6RxQXhksmw/WKF72GJXEDT3vyX3UXttD5lHfjywwbJ4ANKO+iEephV94ePtjPlSXUtRu8LDo1C6GmfNveuC3v0fj0DpCDrrHEPHNzFEKDQfnB6xRAlcriMVc/Z9aT1uAo9pU8Tzer55PnU43uhYAVxwbFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215811; c=relaxed/simple;
	bh=o5jItAJcIaHmIf3DqJBevsH95Nzgxf2jcgTqWkCMNo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HavLs3QeUWLdlk7rDSgN5ufOsMLw3fpxnZHE0KLF79ZWFi9Dp3ieltiM1og7UKjMoEw55y/fvFmziTbf3wEImTUnN1omEpH05TbpmXNpLGewzGmQ7kD5SYv/ug5o4AmrHVflCkUeV2NAdO0Iul9HJ3dJw11LyEAfNtpuNVuMMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWRjSyTj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FC1F000E9;
	Thu, 11 Jun 2026 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215808;
	bh=WKV4caxo9laTzKngvavBKIZfdPi/VjaqX66Lf1iIXXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hWRjSyTjqHq1kdPH9NDk6i8wHkR8rOW8cKFP+cTfLcVdZlt/nzt5ca0ULHAUbDJc0
	 BRAfvjv611SEKIrHWfBaDzMxB2gkuQM/xmwheBYmPxyipvhnU8vZoAbT/AP2mz3kzl
	 uhSsPRDRLT7XefKhEuekdvf0aBxJlumAJK5KVyeKysN4wwMxHF8FwXA9pgY68Ep31m
	 sGlUQYjgo2lX5EoKOTPkxkUKIIrBtzfp2jNdpEYOzJs3ZVYwuryPZmaal7SgWzYGEq
	 RYDJ1524qmXfBPXDhGgE5/9OS8baJLhexpUOfEDSKLhnyQtqquEdVNrfSKMuzDnDxc
	 ADe39F8LJlgqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939DB3930FAD;
	Thu, 11 Jun 2026 22:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: dsa: qca8k: fix led devicename when using
 external
 mdio bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121580514.383948.11834573355322337930.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:10:05 +0000
References: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
In-Reply-To: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298376-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:f.fainelli@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79CA96758E6

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 11:22:08 +0400 you wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself. Upon registering the internal mdio bus, the internal_mdio_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, the driver still uses the internal_mdio_bus id which is used to
> create the device names of the leds.
> This leads to the leds being prefixed with '(efault)' as the
> internal_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.
> 
> [...]

Here is the summary with links:
  - [v3] net: dsa: qca8k: fix led devicename when using external mdio bus
    https://git.kernel.org/netdev/net/c/0b7b378ce6ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-298873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KngWOV6wLGoIVgQAu9opvQ
	(envelope-from <netdev+bounces-298873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:20:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BA67D6ED
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:20:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f3SBtoih;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298873-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298873-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1669330C4616
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F738AC87;
	Sat, 13 Jun 2026 01:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871538AC6A;
	Sat, 13 Jun 2026 01:20:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313625; cv=none; b=qIULUGqE1dS0cvAzpDwaci/tmFlWiEUvwXvPHlMchSMO/Cep3HuHGO9AM8TjdosizVwzJAb9jEYcSC51Q81ot6pmDWPHdyzlM7oLdVynTQlrrFrepo6DiBgRtEYMIE23ogYbg+ib2UPmVK/riQgHkb/rRUC25i5XcZMKck39YWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313625; c=relaxed/simple;
	bh=84CpOJkdZCFir8st5kyGHSjsPyktDjaHNuTVfgvlclk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cf69RseWALEitU1wVVZG98voI06Hh/rUBNYoa/XY77ndGzHKswsCwIUvkosXJk89A62d/tO06JzklXbkowTDaMGRYk0eC608+QCqfoubYkncwIdbWJq3rUcvcbRIJFUYSGmotT2Ifcjn5v1vjWfThQbdTcTTFMHeDFM+GBPz2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3SBtoih; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8AB1F000E9;
	Sat, 13 Jun 2026 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313623;
	bh=tdesUJBUuGtmIZkR5LhtnJJL+Z1i/RT/i62u3EL1di4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f3SBtoihbDrVbNYwKz6moxzMk9T9ESz9aRuZCRdt6KAcyHRwB3VqIBxLhXT5f7r/1
	 1I2SV/M+QgCfLcyoK9BniFWEIrADxzAX9e7auGjhQu0fkbWaY4gzfaK0K/CsNUMZQu
	 NcTdGe0OemWfdoWZq4fWs8Vy3VmHXPQjAjSYe+kjB1Jjba1LsTR8/yPSDFu/rmScdo
	 c/LDKCmb2Hc1lGxeOzYHYmDoO7S/aLdkvEbg9RsIZ5JXQViWb+CbWrva9lgAcdEHwm
	 mh/b8M1GfkUOShKbDU/pL6mcaGPdQdtmQRxIBr2b6YaCvwc8GiQbN+kybipE8fncFA
	 nl+TXxZDZlT2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EE39E9607;
	Sat, 13 Jun 2026 01:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] net: dsa: microchip: remove unnecessary
 dsa_switch_ops callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131361939.1320584.3348315807801285505.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:20:19 +0000
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 tristram.ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298873-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:bastien.curutchet@bootlin.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 523BA67D6ED

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 16:10:03 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by two previous
> series (see [1] & [2]).
> 
> The KSZ driver handles more than 20 switches split in several families.
> This was previously handled through a common set of dsa_switch_ops
> operations that used device-specific ksz_dev_ops callbacks. The two
> previous series have split this common struct dsa_switch_ops into 5
> to connect the ksz_dev_ops's implentations directly to the new
> dsa_swicth ops.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] net: dsa: microchip: remove useless common cls_flower_{add/del} operations
    https://git.kernel.org/netdev/net-next/c/e6759c4acc8c
  - [net-next,v2,02/10] net: dsa: microchip: remove VLAN operations for ksz8463
    https://git.kernel.org/netdev/net-next/c/b54a8087c43c
  - [net-next,v2,03/10] net: dsa: microchip: implement get_phy_flags only if needed
    https://git.kernel.org/netdev/net-next/c/4d574a5cfa48
  - [net-next,v2,04/10] net: dsa: microchip: wrap the MAC configuration checks in a function
    https://git.kernel.org/netdev/net-next/c/c90e80103ba5
  - [net-next,v2,05/10] net: dsa: microchip: remove setup_rgmii_delay() KSZ operation
    https://git.kernel.org/netdev/net-next/c/b97d51f4501c
  - [net-next,v2,06/10] net: dsa: microchip: implement .support_eee() only if needed
    https://git.kernel.org/netdev/net-next/c/d654b3241436
  - [net-next,v2,07/10] net: dsa: microchip: implement .{get/set}_wol only if needed
    https://git.kernel.org/netdev/net-next/c/75ad8c1bc79f
  - [net-next,v2,08/10] net: dsa: microchip: implement port_hsr_join for KSZ9477 only
    https://git.kernel.org/netdev/net-next/c/e33c16843686
  - [net-next,v2,09/10] net: dsa: microchip: implement lan937x-specific MDIO registration
    https://git.kernel.org/netdev/net-next/c/03d10c776802
  - [net-next,v2,10/10] net: dsa: microchip: implement port_teardown only if needed
    https://git.kernel.org/netdev/net-next/c/af472a40b276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




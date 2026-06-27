Return-Path: <netdev+bounces-302365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GepDKu9TQGpOewkAu9opvQ
	(envelope-from <netdev+bounces-302365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:51:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 031986D2C7A
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eVPcJfk8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFD73027974
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E93815C3;
	Sat, 27 Jun 2026 22:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB3803DA
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:50:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600644; cv=none; b=NohFXfCqJRK0udM+OWG2ArpHvOAJHuMj/w5fhJX2p7WBEznduFF5vYIkSa3vXwsItwlQts0dc/D667TvducFr4MvEji28AiDqhI7gENBcuVUzEgzM4eYHSJ8BiYwxVa0001qJQFWpp7eFTllr7KbGbsl3CgGLtx6jNFEOha4r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600644; c=relaxed/simple;
	bh=2CJnhDF9DD1OgzYpwvPSGcKGsVVRzTn5Hb0KmOffXSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1gAQulFg1UFLWsFYleorjWiAFb89qix6se3L2wK/zgUP9ml4VDqt81+dYLhviD3j1EA3DYl62wGb9NAfNdaqez2q+p1VRcSJlKIlACQRdg/XHH+7hHmPfdn6QJl75t90dCSCGX6/V8xvqYcDps6s8e/3uN/gHFod90tI+BQGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVPcJfk8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB37B1F00A3A;
	Sat, 27 Jun 2026 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600642;
	bh=g9TElVIDnPv7Li0JYvlHdeEO7dqICIvNnU7GJ8movX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eVPcJfk8sX98XZjC423SbE8k/VuJLJNuaJeplymAEs1R11Vb8UeIMFEbUGDzFN2nc
	 +RIyww1Bx0B5oAdAzS4dvwe+WTTb2CyrgzciOggWDAJJ5o6/AOurLprCZGyMnPKQ5P
	 thT2OGkG8dkHRmSNe8wvjGKxndHDXX0f6zDr/g/AcbaGVxnzCPpplLsM/KjojtiklZ
	 tjgiQMwf1a1sWGkU4ZCbG4+oTFCz3pCIcjyfmP7t/Ygr46SgGyJuXZONywcJ3lbjPX
	 xqQET2qYgiHUTX0jKr2cAitB+/O9n2QylQHaAIOKtjTK4IIYG/LTWle4a7jWEP5cyy
	 ruGIZGLcSdbdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E4A3938452;
	Sat, 27 Jun 2026 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: dsa: Fix skb ownership in taggers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260062830.1451849.3573078989535411096.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:28 +0000
References: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
In-Reply-To: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 florian.fainelli@broadcom.com, jonas.gorski@gmail.com, hauke@hauke-m.de,
 kurt@linutronix.de, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, clement.leger@bootlin.com,
 george.mccollister@gmail.com, mmyangfl@gmail.com, netdev@vger.kernel.org,
 sashiko-bot@kernel.org
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
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302365-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031986D2C7A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 09:47:01 +0200 you wrote:
> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
> 
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: dsa: Fix skb ownership in taggers
    https://git.kernel.org/netdev/net/c/d4be5f6f9094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




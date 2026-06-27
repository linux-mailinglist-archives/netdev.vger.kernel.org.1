Return-Path: <netdev+bounces-302363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L2OWBYZTQGo6ewkAu9opvQ
	(envelope-from <netdev+bounces-302363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:49:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04926D2C5F
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GzC94qMH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302363-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11E0230055F7
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C801F1513;
	Sat, 27 Jun 2026 22:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1A9463
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:49:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600575; cv=none; b=q1YRN5eSP2bTmM58pXG/qVb4Fb5lV1prh88jTNrEbSSm1hHmFbKXQp0p6/bsu9SYxYzNf2Fg5XeVKRs7JpFj1Y9/M3O4iDbvH7JPhFH44pnurBoE/lYy/7dWfYvny62TXjof9jsSRFEwLnp6lFRRPHEEsIklws+qWr2ubQTyLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600575; c=relaxed/simple;
	bh=EDV4vW7XuXcYOKgF8ffKtCsB4ZtaV4p1IMk5iDX3t70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvTiW57Gvn3tDXoK5yTQgh9Eq3NteDUJp3LCE0uOmqY7zrJLWP3QVHVM9QpUOWiPCUvpDkqCeXD4p2lmYao22u4XlYzJCvO/2w2XOLZPaNQpGw8wUu1vTznYGMX2KA7DxgibDbkePf76M1u+9lsLde63Wq1yb5vLIDoIYG/iRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzC94qMH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC081F000E9;
	Sat, 27 Jun 2026 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600574;
	bh=lvc4789cmtfQZqve++GjyXObf85hW1/QotscR9uDLek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GzC94qMHKna911BVaHrhsAln32XiWYt0EojNHEEVQaAlKRzVsoGY01S6nSUcMIqmc
	 B+fwmwpzvxBj8zQVg3ApeV8HU8VBFll1jLytppVWD93GK7qBH8Zg15jOn8ws8B6CF1
	 COphaCX3dV9UNfNI6ULQCMXpP5BneshmWe3sAkGDdWBOAvWuJIVZfbCy+GlDxLzQeE
	 YciTgJS/dPPs/9o3Xjs5eVQgfJ8R/JV2MPQ84Ouac/2tIXZmyGlJUdff+/KwKKv8aA
	 ZoW0yy52dwUfGgo0fcf0o65sT+URodqdgfMp8+Hq0M7re4gMBlh8E8rdtNaVa3sm22
	 QYr/N1mNMAGdA==
Date: Sat, 27 Jun 2026 15:49:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Jonas
 Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Kurt
 Kanzenbach <kurt@linutronix.de>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, "Chester A. Unal"
 <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, George McCollister
 <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>,
 netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v5] net: dsa: Fix skb ownership in taggers
Message-ID: <20260627154932.1304e1f4@kernel.org>
In-Reply-To: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
References: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-302363-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F04926D2C5F

On Thu, 25 Jun 2026 09:47:01 +0200 Linus Walleij wrote:
> NOTICE: Backporting patches to taggers (e.g. for stable kernels) after
> this point cannot be mechanical or they will introduce double
> kfree_skb().

Sorry for the backporting pain but since the DSA reviews have been 
a bit sparse lately - I think we need to keep this code base free
of tribal knowledge, to the extent possible.


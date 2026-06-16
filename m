Return-Path: <netdev+bounces-299692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QKYvCm+gMGphVgUAu9opvQ
	(envelope-from <netdev+bounces-299692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:01:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954D68B242
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T9PR013s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299692-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299692-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27E273007B38
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568431D5CFB;
	Tue, 16 Jun 2026 01:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C54502F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:01:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571676; cv=none; b=fYufzaJz+YdwaXIibFUpj8RwEFeWWhuQoaQOBggEpwBa878FPWSnztqOyRdvEMSnP0+Mclq5cKy/4WtiCo1kJ46d9eNif4VvfCFaj90bVluXLwmyG9scwFLEluGcIqdim/Bmn2cXhgkTSQW1KjQw4MJK2M+M67I5iAhPNkpAhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571676; c=relaxed/simple;
	bh=ls3HmpOgHhONDL/zyYQKXM6JmTBUuGrq/nK+wOXB2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJAXsPnbaflT9QhTHjN98XoKJbd8qsZyGi1VHnG7WVLQ1rX3EU28Fv0sGndSRt3q+qfRUZN1bWh3AXtPEKkU+lSJPABlYghTLdmanKsk3/fTmx5XIkgVw3pXOEfRGTXv/hBW62n3f/2oe/iFe31OoOwrBQ8mlKNfGhUJcVDidO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9PR013s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0709D1F000E9;
	Tue, 16 Jun 2026 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571675;
	bh=Dm0za3nNNqXWe406TFKCsAXtR6FAj8KUkFXQtNDJi0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T9PR013scgHSgYmlD58QMOy2RY8rEVAxWw+BOUrIKtCNy2yxJLbPKQ0Pny4XppTyk
	 A3BvaEleJ+/d3tNSEaxTbxc+c8y5u2v/Gn8yP/0XU7jrTBY9yLACTKqVnZYTYD16MF
	 eZLg6/wrE4isDZnW4cuH2hT0/Ivx6ZDoY4QYjK76e5oLCxiygj6ZtyNmFqozr7aAv2
	 c9+U+I9fomilkXJg42OmMYy4Jxz9XABA802T5hopFS/6LnUaHwbaD70/JvOtbQIq5M
	 mLCuKAYXsIG41z4asLnDyppA+pMmR0lkBMccgSyKOdvfI0hQ7uuRVErEyJ4dmziUxa
	 iH9YMkizGn7Ng==
Date: Mon, 15 Jun 2026 18:01:13 -0700
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
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
Message-ID: <20260615180113.13fca89f@kernel.org>
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299692-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2954D68B242

On Tue, 16 Jun 2026 00:33:00 +0200 Linus Walleij wrote:
>  24 files changed, 243 insertions(+), 91 deletions(-)

Impressive. Thanks a lot for doing this.

patchwork says it doesn't apply to net. Is it on top of net or net-next?
Since the merge window started already net-next is probably better but
you need to designate in the subject correctly. Feel free to repost
without the 24h wait, maybe we can still slip this into our main PR.
-- 
pw-bot: cr


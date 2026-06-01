Return-Path: <netdev+bounces-293770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONabBRGJHWrAbQkAu9opvQ
	(envelope-from <netdev+bounces-293770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F591620094
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C3BB304C07A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA63A6B8A;
	Mon,  1 Jun 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cIa9HeIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017E3A543A;
	Mon,  1 Jun 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320368; cv=none; b=tLYhzEjxgrUj0aSb4bPbPx7QuTgdIJTivgyZUUIX1SC1hvM5C5HmNssnIw48hxrHCz4og2m7IMh8LM64XbqtwADW901C5KmuIrB2ruU6p7DqwzgSqsj02YUbTQ1oNmDVSydwZXMEo5NcXwmOyfw/pyIUVkzNSHEKSB9EsUPDqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320368; c=relaxed/simple;
	bh=le79LbEmNjdRXJTILAC9NzYN6pt88MxtUEBHj0XQBtQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KWDUpO/2COjMvpUYhfhUK4x/gGIRcdagncgpfstxnwbOF/oLCM+/GdjikUSCCWITiC9PQOXNykUL+I7rH2RbpJvYZw0ih8JwmuJi/5UZlabRPjpmPTU3FZk0UXkPXzUu5D/wht4hRLVhsiYGHE9768erDBaPpse/53cw33pleNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cIa9HeIH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 502FAA08DA;
	Mon,  1 Jun 2026 15:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780320362; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m43hHnUk2TrrBU3R9f5h+D3RgpE/W+g1up4sANkurcQ=;
	b=cIa9HeIH1jnqLi5eGfMYRJdmT55E8TmQ2Oo3XLmGkunU1HmAr9/CKeAPCFogQGZTMi0xrY
	jOFeBk6aF/UTcONigJUFbes4HYnNszrQLnkARkO3qG3tt6C9KGrIYZ+4rurA3crKO/8am4
	M8qOLWKE8e2fimgF6ppZeKBgoEHWE1BkU/MpvCCtBIBnEBeFUUfandgBvQiWkW9pKU72s/
	0AgzNIZQgzq5VODNQino4SJmRa8MFPL1z30fGBlYGi/jxG3xeibGEUbLj8SRbtq35hEjcD
	3WQY/qoPu/hoPCMaiBWuURtfnq1Mtu/f7U4ANxOT+/1mWq0OVJPfkk5Wet20bg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 15:25:59 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>, Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH net-next v8 3/3] net: phy: micrel: expose KSZ87xx low-loss
 cable tunables
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-3-cfa102cf62c0@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
 <20260601-ksz87xx_errata_low_loss_connections-v8-3-cfa102cf62c0@exotec.com>
Message-ID: <2516d18e2acb66f9f13986506f168803@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-293770-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com,nabladev.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,exotec.com:email]
X-Rspamd-Queue-Id: 6F591620094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fidelio

On 1.6.2026 13:54, Fidelio Lawson wrote:
> Add support for the KSZ87xx low-loss cable PHY tunables in the Micrel
> PHY driver by implementing get_tunable and set_tunable callbacks.
> 
> These callbacks expose vendor-specific PHY tunables used to control the
> KSZ87xx embedded PHY receiver behavior when operating with short or
> low-loss Ethernet cables. The tunables provide:
> 
> - a boolean short-cable preset applying known good settings;
> - an integer LPF bandwidth control;
> - an integer DSP EQ initial value control.
> 
> The Micrel PHY driver forwards these tunables via standard phy_read() /
> phy_write() operations, which are virtualized by the KSZ8 DSA driver 
> and
> translated into the appropriate indirect switch register accesses.
> 
> Reviewed-by: Marek Vasut <marex@nabladev.com>
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai


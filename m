Return-Path: <netdev+bounces-295544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2lqN0QlImpkTAEAu9opvQ
	(envelope-from <netdev+bounces-295544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A472264461A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YwK7mFs2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295544-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295544-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59F743012351
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BA3BB685;
	Fri,  5 Jun 2026 01:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD137C108;
	Fri,  5 Jun 2026 01:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622651; cv=none; b=fj2TI/wP2Nicbc1p3B+TWHIbbzOALYJH/uaO4YF7lIw3zGonFplyet/cCIcWi8QyS9oQcm2ZB521EqQHww7ydjscmR++Y6dnTrjwBrIBBBCtNCftTqcyCtR3zG02ie5iq+y8pB02WdwrOv0lMhem6uStEH7B+ca60h7jyM5fqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622651; c=relaxed/simple;
	bh=vwgBJdCkr8sNOL19rwFXTW/V8L2QG4YVKyIgp93Ex04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLeF5khZsKwEhhs8XMpxcgZ0FfE4Cqn3Kv4a64FlBwE/QJ/ncvIE3Zcewfti+7xBxVxmn4vlh3Omo24Iq5mQWtVm4dBZR1vmMWRWMgf2hpFe8+uqI4MG2slOl4I3ZayyYZYhttmhtyA3CARh2MUVlXHEl0MtcvZNrgCroJO874Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwK7mFs2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338411F0089C;
	Fri,  5 Jun 2026 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622645;
	bh=huoyUmBaKpAcN9h2w3dZScXtYQ+/Yk0hkH7JmG05ogE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YwK7mFs2QOO2t1+TJ+2XxeQP1AVPFdWB5D5Vjx9mLpGcUHfd9CKaXdqlZTjuTi4N1
	 zFUE2ikFqPNW/Fnjo+StULGeyfF5AxtgDI+26xK2k0oPDM6DY7VE/vJ7VZEflE061G
	 dWiVYOuDsiMYztb0GMyQaOx2lCI6CLtg0oeeqlp8fsmIQYHIOWG6GWOtiUP/CCeZ/W
	 KaWIK6MNlwChQ30QmUnfs7Xs1qGI/qQ8RVVSiBGTAVzJKwF5hGrPTvYVddV5wsUreO
	 3Jzab2xQcdxwGuvo3IavJGwQ3vZlWpnNegazeh9eiY2frc/EfeiUxWRnjSIDMsAYEa
	 4fOHdVbb9eDaw==
From: Jakub Kicinski <kuba@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 1/3] net: phy: clean the sfp upstream if phy probing fails
Date: Thu,  4 Jun 2026 18:24:03 -0700
Message-ID: <20260605012403.3513979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-2-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A472264461A

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: clean the sfp upstream if phy probing fails

This commit adds a call to sfp_bus_del_upstream() in the probe failure path
to ensure the sfp-bus is not left with a dangling upstream field that could
be used during subsequent SFP events.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -3775,6 +3778,9 @@ static int phy_probe(struct device *dev)
>  	return 0;
>  
>  out:
> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +

[Severity: High]
This is a pre-existing issue, but if a subsequent initialization step fails
and we jump to the out label, should we be calling the specific PHY driver's
remove callback?

If phydev->drv->probe() succeeds early in phy_probe(), but something like
phy_setup_ports() or of_phy_leds() fails later, the execution jumps to this
error path. Without calling phydev->drv->remove(phydev), any resources
allocated by the driver are leaked.

Also, drivers like dp83640 register the phydev with external subsystems,
such as adding it to shared lists like clock->phylist during their probe.
Leaving dangling pointers to this unbound phydev in those subsystems could
lead to use-after-free crashes later.

>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);
>
-- 
pw-bot: cr


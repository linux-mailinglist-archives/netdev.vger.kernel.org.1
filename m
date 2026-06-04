Return-Path: <netdev+bounces-295028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XAj8E+jiIGqG8wAAu9opvQ
	(envelope-from <netdev+bounces-295028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4463C81D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:28:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L5Pt3zLT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295028-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05ED1300B527
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74837997E;
	Thu,  4 Jun 2026 02:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCD372069;
	Thu,  4 Jun 2026 02:27:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540037; cv=none; b=ZTZCj4U0ylS3buHfNP4TEy2JesG7HoptT5kSpJ3Os+LOfECqN4WBpSDPVYeZPD3w22a+mGnNu5g7pM23pm5zuJKk8Hj3f+mB3rxXAcAeU/v2d0o99VD0/O8Gc7+m1db8dNaOfitMTLh/uegRFgF97aaTW6brZ+954n2e58pHwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540037; c=relaxed/simple;
	bh=D78d217JUW+iFsIwB881grW5B8y3p3CeTZrqusmzOT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smotBDY0+MghGvn+IrgI0kPEH4tHx0aT3oNB6dfSnX5CHrTO0aQexrSUHMgxlhmt5a1Xd/zjh9ZS5VUQDylYDErAwb0uatkPxzC8o8XiRhV/517A2wJr5tb3SuyFfU25TIgiYeUsmY3CbSQGd0RXqvz0XzPJvzcp7RO4o9gmR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Pt3zLT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017851F00893;
	Thu,  4 Jun 2026 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540032;
	bh=2hWwEFYNoPk8RDgJA+HdJDWslftrvnBOU4+dDSmlqp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5Pt3zLTjkKJVeiiuCuyALCOHQGelB08HWR9Olx1JXSihXJ+TTSAZCx+YuH7fuwlv
	 uv1agjxExoV2lYlkjPROw+OUi3PQjpsNSVRoE3Y+f5pkI/v0W0n8VvabDWuVho67Ou
	 cEaTRFmhtmB9GEcTIsZ9IQ8E8IgmLr3S4NIs6O4g0bzzhhnaLuLe3Ik3TtHnyuk6Dm
	 Rll3nyR0XWJXnk4lce8eCH2UwUarTmPrBZsd+op19iPZyG6CKcOJf1WzV9aTfVLR+5
	 Qq6TyGzq+NMelYz+Codhqmgn+Wfan2VEtbceF2ud987RiXBLw0rYsK52wa8xbUvLw3
	 YI3BRrMsH+7kw==
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
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
Date: Wed,  3 Jun 2026 19:27:07 -0700
Message-ID: <20260604022706.2924974-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-295028-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72C4463C81D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: remove phy ports upon probe failure

When phy_probe fails, let's clean the phy_ports that were successfully
added already.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6ccbfacf7d1d2..a171cbe2a74a1 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>  	return 0;
>  
>  out:
> +	phy_cleanup_ports(phydev);
> +
>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;
>  

[Severity: Critical]
Is it safe to call phy_cleanup_ports() before sfp_bus_del_upstream() here?

sfp_bus_del_upstream() unregisters the upstream SFP callbacks and acts as a
synchronization barrier by acquiring rtnl_lock(). Before it is called, the
SFP bus is still active and can asynchronously fire events like
phy_sfp_module_insert().

Because these SFP events locklessly iterate over the phydev->ports list via
phy_get_sfp_port(), and phy_cleanup_ports() mutates the list and frees port
structures without lock protection:

Could this concurrent access lead to list corruption and a use-after-free?

This same incorrect ordering is a pre-existing issue in the phy_remove()
teardown path, but this patch introduces it into the phy_probe() error path.
-- 
pw-bot: cr


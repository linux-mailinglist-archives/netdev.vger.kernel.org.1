Return-Path: <netdev+bounces-264226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF/dAelDqWlV3gAAu9opvQ
	(envelope-from <netdev+bounces-264226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:50:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CAE20DBEA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442BF301589D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96339372EE7;
	Thu,  5 Mar 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="poexKRG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44921CC5C;
	Thu,  5 Mar 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700645; cv=none; b=oSCZtiAd58DFVfF4O1/9TMuBXDabaB6KItgxcXnT26U+pM0kJcDQAojTzzXDzbgbLRVv26P3nC5ggYf7xzok4x5vWwLHnwGtHy/wBb5zsgZr3yZaFM0wxXtcz3U0wihRkqztudqupaFzb0BkZW7fqPpjwC1WQbRg/lYnbafP6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700645; c=relaxed/simple;
	bh=fV+VzNFckG3w8s6jy0MEr3wY6mBu0Nx9mbIq7VnsKdI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dmz1KNstRjzyyLSNULCWPBFAWo4AkO7Wivy74RsaifWsljl2m/2hYYe793i2d1K9HVDIWA6dka8i+p1lpsF0fI0+ZyyTirrog+VRao6DJGdL8tM2hDANE2Aq/wk+TuYULUC5WfFTYud9Udmty4B0h+E9SGl8LqiGGWJFv7qBGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=poexKRG7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E20CEA0042;
	Thu,  5 Mar 2026 09:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772700633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a/5JcWPNdGt8uGTnqWElVMvY4k4brDzQwiKTZGQpZl8=;
	b=poexKRG7jjpRYBSLAMzk1TNo1T/jVSRx9ywDOX/5+ibbPlNqXMjH49qspxVDgnfnvei+U5
	pVlh+lK27qNfw1b50ZFoK0JVH3cpw3ql8i8PgCTo2+gE9/nD8MGhGFAPAROUVnDpINLrfU
	Vk2KExmz7stalHpSODNReWp9t3X+pHbLmobhRTKtxOswr1NkLab5ERUqPWPraCrb3akQJQ
	Od/J7/1ZeKdaFr/vgXw9nkI7wxKgr2HGwPleb59L9CeUDZMflBDxMpas05Jdd7tYc0Agb8
	ata3E/T5hjqiEoLxDkeQn/QOsQcCJ+hhwQnorD+ICp7MH3iPHw2IP1qUiA7L6w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 09:50:29 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: fix bcmgenet_get_eee() clobbered by
 phy_ethtool_get_eee()
In-Reply-To: <fd675389-b044-4783-be16-c5ba34163ef2@lunn.ch>
References: <20260303153918.538902-1-nb@tipi-net.de>
 <fd675389-b044-4783-be16-c5ba34163ef2@lunn.ch>
Message-ID: <a899e5a0addb1e58d47fb7f41e4d8a55@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 52CAE20DBEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264226-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Action: no action

On 4.3.2026 22:57, Andrew Lunn wrote:
> On Tue, Mar 03, 2026 at 04:39:18PM +0100, Nicolai Buchwitz wrote:
>> bcmgenet_get_eee() sets the MAC-managed tx_lpi_enabled and 
>> tx_lpi_timer
>> fields, then calls phy_ethtool_get_eee() which internally calls
>> eeecfg_to_eee() — overwriting eee_enabled, tx_lpi_enabled and
>> tx_lpi_timer with the PHY's eee_cfg values.  For non-phylink MACs like
>> GENET, these PHY-level fields are never initialized (they are only set
>> by phylink via phy_support_eee()), so the ethtool report always shows
>> eee_enabled=false and tx_lpi_enabled=false regardless of the actual 
>> MAC
>> state.
> 
> I think the MAC driver is missing a call to phy_support_eee() to let
> phylib know the MAC supports EEE. Have you tried that.

Thanks for the suggestion. I've incorporated phy_support_eee() and 
tested it
with a Raspberry CM4.

After applying the patch, the PHY correctly advertises EEE, negotiates 
it with
the link partner, and ethtool reports:

   EEE status: enabled - active

However, reading UMAC_EEE_CTRL directly:

   UMAC_EEE_CTRL      = 0x00000040  (DIS_EEE_10M set, EEE_EN = 0)
   UMAC_EEE_LPI_TIMER = 0x00000022  (34 us, hardware reset default)

EEE_EN (bit 3) is never set - the MAC does not actually enter LPI.
priv->eee.eee_enabled stays false at init, so bcmgenet_mac_config()
never calls bcmgenet_eee_enable_set(). The result is ethtool advertising
"enabled - active" while zero power savings happen, which is worse than
the original bug.

Likely root cause: phy_support_eee() sets eee_cfg.eee_enabled=true, 
which
phy_ethtool_get_eee() -> eeecfg_to_eee() then reflects back as
eee_enabled=true - but that is PHY eee_cfg state, not MAC state. The
fix should override eee_enabled and tx_lpi_enabled from priv->eee after
calling phy_ethtool_get_eee(), since those fields are MAC-managed:

   ret = phy_ethtool_get_eee(dev->phydev, e);
   if (ret)
     return ret;

   e->eee_enabled    = priv->eee.eee_enabled;
   e->tx_lpi_enabled = priv->eee.tx_lpi_enabled;
   e->tx_lpi_timer   = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);

This correctly separates what the PHY negotiated (eee_active, link 
modes)
from what the MAC is configured to do.

The deeper problem - that the MAC never enables LPI even when EEE is
successfully negotiated - was submitted separately to net-next [1]. It
initializes priv->eee.eee_enabled=true in bcmgenet_open() for GENET v2+,
matching what mvneta, mvpp2 and others do.

Given how the two patches interact, I think they should go through net
as a 2-patch fix series - if there is consensus on that approach. 
Sending
the fix alone would ship the misleading "enabled - active, no actual 
LPI"
state.

> 
>        Andrew

Nicolai

[1] 
https://lore.kernel.org/netdev/20260303160225.542613-1-nb@tipi-net.de/


Return-Path: <netdev+bounces-289435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGSmFAhQDGrwegUAu9opvQ
	(envelope-from <netdev+bounces-289435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:56:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F157E240
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BE913007B8C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD43346A5;
	Tue, 19 May 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DQbMI/ig"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248783F1ABE;
	Tue, 19 May 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191804; cv=none; b=EuI9IxjIJTrPcdjlrINV8dzU0Fmt5Nm3qaP7s4GcFe7D4qIyGB6AUhtK1DkBckYzveReJsARk3xC3dzmgKD4E6NN6/qZcezpdzyxkMylK7o08+O6u9InM+04Hge2E46C0vbytVAMXQhx2XURCp7w52+K0htNopuhFZVppVgYBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191804; c=relaxed/simple;
	bh=bQhKVL6qQMcUeyt6B+f8lMfTGX8DOTIkacSNevKWc40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emTpC1Sabaq+7Q5K3pVC2Ay7dNEC9yDLy2cxgL+KYzhlzzeOMug4ro3XuvFJfAff2egUJ6QtMiMNQjvBOcYh6sCuJguAkadIwNyG76h5nb0T5k7KvKYbHpAuw0oVAyVA69iXkK1WNX1QI20fevwEVTKzSwaXNSKV0IIVb169KZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DQbMI/ig; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ijR1bXan0D5bPjUwJSQ6AnjGs2pf347H7WrT7ZWyeMQ=; b=DQbMI/igPGT5Urim3E+Fc3Vk7Z
	oJb1lo179wf2RJT8bySyp92xFiPGxqqCEx5ALrnOgicG2l8B6hc0zpH3cTrSoXV1mD+4bwnDtlxV6
	9l6DM+86YJ6wR/T66g0zVxuM9bgsW9Sm+W0FhFMohKK/flQqoWzo/zfFkfhviuesndjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPJ3f-003eom-O8; Tue, 19 May 2026 13:56:23 +0200
Date: Tue, 19 May 2026 13:56:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: honor eee_disabled_modes in
 phy_support_eee()
Message-ID: <0d11744b-e235-437d-b14d-3b49e0e162ef@lunn.ch>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
 <20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de>
 <05a24b73-ff89-41e2-a655-224f1c2dbc31@lunn.ch>
 <7245b9c6294300265636ad954c01c248@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7245b9c6294300265636ad954c01c248@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 9F5F157E240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 08:20:02AM +0200, Nicolai Buchwitz wrote:
> Hi Andrew,
> 
> Thanks for your review.
> 
> On 19.5.2026 04:19, Andrew Lunn wrote:
> > On Mon, May 18, 2026 at 10:23:09AM +0200, Nicolai Buchwitz wrote:
> > > phy_support_eee() copies supported_eee into advertising_eee
> > > unconditionally, overwriting any filtering applied during phy_probe()
> > > based on DT eee-broken-* properties or driver-populated
> > > eee_disabled_modes.
> > 
> > Sorry, i should of questioned this on v1. What PHY are you using which
> > masks advertising_eee in probe? It seems like this is wrong, and it
> > should be setting >eee_disabled_modes, or maybe eee_supported.c
> 
> The masking isn't PHY-specific. phy_probe() applies eee_disabled_modes
> to advertising_eee after of_set_phy_eee_broken() picks up the
> eee-broken-* properties from the PHY DT node.

Ah, O.K, i understood that wrongly. But you do say phy_probe(), not
PHY probe(), so it was my error.

	Andrew


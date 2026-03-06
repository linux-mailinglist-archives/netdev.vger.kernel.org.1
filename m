Return-Path: <netdev+bounces-264879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHnGN3QDq2nDZQEAu9opvQ
	(envelope-from <netdev+bounces-264879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6181A225440
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D47730530D1
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90536CDFE;
	Fri,  6 Mar 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uDrDcUUJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880A311C01;
	Fri,  6 Mar 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814857; cv=none; b=KGBuWTdzilrjSrKOnUaCQ6OkQWVytSn5f8JKdbBB6AEBuE+taFRkGnaFCEh0MinZvPq2UfPe+OI5zOoGKtqo9VXMM4osiWpYrBT0brzhDYcc4ri5S7jgcJnUi9NgmZzjai/4AlddR0fDK8FFks12htgo8XUzTsef7C2DZsxdlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814857; c=relaxed/simple;
	bh=3YzCmW5K6qeLBqPOg0gXPxNNwM5gHgiWzQbHsCUkkAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/DpxnTHVpgTotSzQlmmzqm9qQxMlohW1flZ43MKcy95Nyw4wTnzBTGy07wVsgIQ+FF//kp/JXYPosrretXwUE/F6QtfmAYWCHqOl1IC89sNjZsSTAku75vSmZlS+ZvSen/vWRvs680nqbRUglWGgodF3KuqQ0jQfdgD4zI9N2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uDrDcUUJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=z+tuaKJg5i2koJxE2Il5d+ilUZ3/NgGBNbU1StFMjMU=; b=uD
	rDcUUJ8F6iVXIfRQrblZjKqoQFipsb6kKGP10q6rkvO6qA4PrgGcqUgKMopYtFqQ+uxOx7fEKDJ5V
	T5n/j8jPNKbQccrY2PeKCfpSENuBHhuBJJlYJXmVRrDkne0x0EhFQoRy8jBQtVOMghwgocQ1H2eey
	M5fAbW/DEhLqQ24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyY7g-00AVeo-Gj; Fri, 06 Mar 2026 17:33:56 +0100
Date: Fri, 6 Mar 2026 17:33:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <332bf6a6-ce9f-46d7-a2f9-10b5531598d2@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
 <7365618.GXAFRqVoOG@steina-w>
 <3de08c66-adc8-455d-b23c-b3464153b38c@lunn.ch>
 <b61fd4b0b7b371e1113b2c16873799ff1f745722.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b61fd4b0b7b371e1113b2c16873799ff1f745722.camel@microchip.com>
X-Rspamd-Queue-Id: 6181A225440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264879-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ew.tq-group.com,armlinux.org.uk,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:03:36PM +0100, Jens Emil Schulz Ostergaard wrote:
> On Thu, 2026-03-05 at 18:37 +0100, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > > However, this is a multi-giga switch, with high speed SERDES ports. My
> > > > guess is, a SERDES port is used to connect to the host, not RGMII. So
> > > > i would not implement this, until somebody reports having a board with
> > > > RGMII connecting to the host. KISS.
> > > 
> > > We intend to do exactly that with this switch, just because the host
> > > doesn't support SGMII, just RMII/RGMII.
> > 
> > :-)
> > 
> > Then i suggest using {rx|tx}-internal-delay-ps as Vladimir suggested.
> > 
> >      Andrew
> 
> OK, I will use {rx|tx}-internal-delay-ps instead. I can add that the 
> current EVB board for lan9645x also uses RGMI mac2mac to the host, so there
> are already users who would appreciate this. This is the LAN96459 EDS2 
> Daughter Card with part number EV14H52A.

O.K. Do you plan to add a DT file for this? Since it is a daughter
card, is it a DT overlay? I see there is an I2C EEPROM, used for board
identification. So that tells you which overlay to load?

	Andrew


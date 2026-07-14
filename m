Return-Path: <netdev+bounces-307581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ahiM0OUVmoR+AAAu9opvQ
	(envelope-from <netdev+bounces-307581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA97587E2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=cvH6i3lm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307581-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9598C3011A6D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575D433052;
	Tue, 14 Jul 2026 19:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F43ED13E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058945; cv=none; b=QwqUC54oQVYWc3qT07gq+Zpsfju6hZAW8vUBjyCvEc2Z49h0GfPen2EtdpzovRMoYkzsrodV8XQMf+1inJkRiYeCVA/dWj2LDg9dxZyIxIQTvwlJktodfULaXtSPqyUTSz/epMgD+IrbuGtEh8hLLekUohNiEX5PgJIF9vrXhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058945; c=relaxed/simple;
	bh=xZgaxnvE1V0Bn8v9qHMl8/NnGMb5gMjxc2bZcfc7O1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnmRnoOnvm+1C4JAyd0t9EGZpq4PqXQQzxx6lAFGa5cEiorfNxhhnj4DTLQtXmufM39RpJfUwbWKHjIHIxivKzz87MVitFK1++afTuijgGUVoltFrVZ4dJCaSUSk0XpMRjgg+hn70dIYyig31DdcsLQMpaEDQCN+q+FS3HwCgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cvH6i3lm; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oI0S4ZFR378em5gdXbTTpIauxguiZHRBB11Emx0Xs3c=; b=cvH6i3lmQ7QRlCkNbN+sVpKzDw
	zn+5Kd+vUm68iF0tZk1hLIDIVcdgfIDXMmf29ucCxXpa6TXzbNNx9LH+mMiM/WVhzc4TVMEA4mnPj
	lzuyY+pnBozByAoDMZrtkxuGtRhbjbXdNgyAh8CQYA1Li5r1nXf+lekS9qh7/QoRsOf8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjjEA-00CF95-Ic; Tue, 14 Jul 2026 21:55:38 +0200
Date: Tue, 14 Jul 2026 21:55:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
Cc: Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Message-ID: <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
References: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ayoub.kaanich@technica-engineering.de,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62DA97587E2

> There is no equivalent SET. ethtool --set-module-eeprom (both
> netlink and the legacy ioctl fallback)

In general, we are trying to block user space drivers, by only
allowing read.

> Concrete use case:
> 
> We (Technica Engineering) manufacture automotive SFP/SFP+ modules for 100/1000BASE-T1 and multi-gig automotive Ethernet (TE-1441, PT-1445). Alongside the standard SFF-8472 EEPROM at 0x50, these modules expose an I2C-to-MDIO gateway at I2C address 0x40 (0x80/0x81 as 8-bit read/write):
> 
> Writes to that address are relayed by the module's own logic as MDIO Clause 22/45 transactions to the embedded automotive PHY, giving access to link speed, master/slave mode, and other PHY configuration without needing register-level documentation of the PHY itself.

What protocol does it use? Have you seen drivers/net/mdio/mdio-i2c.c.
That currently implements two different C22 or C45 over I2C.

You should add your protocol here, and then Linux can just drive the
PHY, like it does for any other PHY.

	Andrew


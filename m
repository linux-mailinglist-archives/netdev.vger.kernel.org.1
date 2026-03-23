Return-Path: <netdev+bounces-270628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI1FFix8wWknTgQAu9opvQ
	(envelope-from <netdev+bounces-270628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:45:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E14272FA590
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9241E303B14C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B83B389D;
	Mon, 23 Mar 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="gvmWHfwU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DKR7Z4bz"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E43C13FF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286338; cv=none; b=hq6HSHdiM24uoFtA4cDMuEELxvOBWmkPv4aXQyg0XJpk/4l83EHH7lPUZFc6rMY6A5Um3gxB+VXsNSnY2cJ1iOdK9VN/5yHMMmAN03GZn8WIszJ+uQ8DgbP81Z4HlSgRLKG1ZNTAoIP65VFUJuRBBdDvU3w/iy7BGleP/9+v5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286338; c=relaxed/simple;
	bh=IyPIpKqff0QOAhzUsNMR7ffgpOkH8Ft8DtBqFyPcY60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHMg7LUASMYz9iM0YEdkB8Nu7I+sMJ3NbFqdqkfN0Ph8RubMiVA0zrOj7zalSHocBWZ1cxlBJDbRIfERFPavxgSeLsbL9LpwkxbERWRgh59Od7DSvs403i0du2gv+aWhCndkgYfIRfvh3BbCFVUs/zdrZFPxowVCc5Zm/2t1j6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=gvmWHfwU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DKR7Z4bz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=gvmWHfwUn+ci+XXztI/loMlrMA9N2AgTEGIEQ6aWUNUaqt6+brBItWjddiRtxTdVrI1fg3cONP7kqFhOe8lfrZIq3MaUE3i1po3Z6EzEMr+XPS1K5yOstuVVwRU2Uu7Fu8VNr4g+4zb4vDC/oz4TsK+3YWnv3kQ/6aWjFGwmVuhcH1Kz+yb+vDwHc3a8LAA4UotjVyhclgvHoAjAYJ7907KJU8z0SmcofxalNNkRSlr2UsUkuJk+Emke7Y8oYDsHE+J1A1YFFLx45598j2sRM6CQBmPoJhku1/9PYL33GKtia40AlsNNNrgCaNGbp0zPlZvds1JwJ2AB8W1JiEb5Cg==; s=purelymail3; d=tinyisr.com; v=1; bh=IyPIpKqff0QOAhzUsNMR7ffgpOkH8Ft8DtBqFyPcY60=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=DKR7Z4bzaJAWx+E81UrMH9q1K0S7qRdu5YLCgD2EvPUrU0zmF5ig2z9ufXlyTSCIJjSbnMoQOTAox4PKrqxLcWgvNoQ4MhzC8LlEJxJ7SnvaYMVR9fFjJq2lM95zRfRQSaW7hYYfad2EibfeSag5k6AWLIwQg6xee5aaURqooMamrIGaCUUG12t5Dg4GipmV1BiRWkZ43szi4o+ZBUrgtOoim1PaAH+GJog0u0jjwgo3NCYYyQHAmLhMOQjkXnbEY0eyVHIIew5CsafqmOzVfjC5P6s/41Tc0sVDwZZZYqgHhp0CaeSjGnIYistAFDC8EvHNDhFibfS9w6nn/+XulQ==; s=purelymail3; d=purelymail.com; v=1; bh=IyPIpKqff0QOAhzUsNMR7ffgpOkH8Ft8DtBqFyPcY60=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1017625389;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Mar 2026 17:18:40 +0000 (UTC)
Date: Mon, 23 Mar 2026 19:18:30 +0200
From: Joris Vaisvila <joey@tinyisr.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC v3 4/4] net: dsa: initial support for MT7628 embedded switch
Message-ID: <acFwjuPFiO0QFoJ-@archlinux>
References: <20260321194340.2140783-1-joey@tinyisr.com>
 <20260321194340.2140783-5-joey@tinyisr.com>
 <ab8IHwC4RfHG5wvv@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab8IHwC4RfHG5wvv@makrotopia.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tinyisr.com:dkim]
X-Rspamd-Queue-Id: E14272FA590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel, thanks for the feedback and suggestions.

On Sat, Mar 21, 2026 at 09:05:35PM +0000, Daniel Golle wrote:
> As mentioned in the binding comment:
> - The MDIO bus is exclusively used to speak with the built-in PHYs.
> - The PHY addresses match the port IDs.
> - Only Clause-22 read/write operations are supported.
> - There is no way to connect an external PHY (no MII interface
>   exposed on external pins)
> 
> Imho it would hence be much easier to just use DSA's simple .phy_read
> and .phy_write operations instead of registering a bus manually in the
> driver, and even requiring a description of the MDIO bus in device
> tree.
> 
> If you want to reserve the option of adding PHY-specific DT properties
> in future (eg. for PHY-controlled LEDs? but afair the LEDs are
> controlled by the switch itself and SoC-level pinctrl), at least set
> `ds->user_mii_bus = bus;` to make the device tree description
> optional. Completely omitting the whole bus definition and changing
> mt7628_mii_read and mt7628_mii_write to be useful as .phy_read and
> .phy_write ops in struct dsa_switch is the better option for simple
> legacy hardware like that imho. See b53 driver, for example.

The LEDs are indeed controlled by the switch, so there doesn't appear to
be anything to configure now or in the future. Using `ds->user_mii_bus`
sounds like a reasonable option to simplify configuration and works fine
on this switch, I was not aware of it earlier. 

> @DSA maintainers: correct me if I'm wrong and, for which ever reason,
> using the .phy_read/.phy_write ops is discouraged in new drivers, even
> for dead-simple hardware like that one.

Regarding .phy_read/.phy_write, I was advised against using them in new
drivers in v1 of this RFC. I'm happy to rework this, but would
appreciate clarification from the DSA maintainers on the preferred
direction for hardware like this.


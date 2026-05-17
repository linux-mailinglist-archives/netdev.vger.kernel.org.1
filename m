Return-Path: <netdev+bounces-288751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VZ1EA1zeCWrJtQQAu9opvQ
	(envelope-from <netdev+bounces-288751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F02561FA9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E070300B871
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A8B3B0ADB;
	Sun, 17 May 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S9USXKTK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40F30F957
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031638; cv=none; b=pAQPvpPVj9t7Od579dBAVWSt9Nps0kX/NNCdQuRyPpKof4da0sHwzOXEjupDXGcS7Ot2wmfRZQgAQCpBIyApo34/pUScnFYPp+yCNxa7OIAy9/YJKwc+LnUHX35EL1W8qcKh6lCks0ESnIvRKhkPugxSGkidgfeW6WojHI6gRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031638; c=relaxed/simple;
	bh=Xh9w9nnQ1BXjz1e2nRhzF9/3vI3dy5RtCDo1eM+23w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIlJF/rFCV687oM4rNNwaIqO/LhZmB/goyFjctXc4wUBt/a838rEC3sgaJbLIG8pITl1rTqjZ1cEDb38hLHA7mzzHDJeth9winHoom192v/AvEj30xKXLIJzE/94R3gsvNC6oeU8gc7+YFZtmEujLJedFKjLkTnig5oULZfQYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S9USXKTK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=nNHIlg0KhKM8vz2t70ndpkgpiFMwt72VAtSNvRBC8kE=; b=S9
	USXKTKCHtdG1RANCBNUpAltXHZApKjpRZ8rL1+ZT+TNPS5XbHBAGvITjhv0M9fuY6rWwVdm/0UlAI
	elVYCAYbQmB6GU79r4x6SoFqM2TN4YRhaU/5XqsfHDTMeI72FDNmv1oCB0Jk9m72Q1J4mKL8WOgNi
	g2vQYyZCMui2jBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOdOK-003L7h-IV; Sun, 17 May 2026 17:26:56 +0200
Date: Sun, 17 May 2026 17:26:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH] net: mdio: Add Realtek Otto MDIO driver
Message-ID: <da228153-65b0-4b21-b62c-1562394ca95a@lunn.ch>
References: <20260517111530.220017-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260517111530.220017-1-markus.stockhausen@gmx.de>
X-Rspamd-Queue-Id: B9F02561FA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288751-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> There are a few issues left that will fixed in the next weeks. So
> slowly it boils down to the question, how to best submit all of this
> to upstream.

Lots of small patches which slowly transform the Mainline version
towards the downstream version.

> +static inline struct rtmd_ctrl *rtmd_ctrl_from_bus(struct mii_bus *bus)
> +{
> +	return ((struct rtmd_chan *)bus->priv)->ctrl;
> +}

No inline functions in .c files, let the compiler decide.

=00> +static int rtmd_read_c45(struct mii_bus *bus, int phy, int devnum, in=
t regnum)
> +{
> +	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
> +	int ret, pn, val =3D 0;
> +
> +	pn =3D rtmd_phy_to_port(bus, phy);
> +	if (pn < 0)
> +		return -ENOENT;
> +
> +	guard(mutex)(&ctrl->lock);

Netdev does not like these sort of magical guard() locks.=20

> +	ret =3D (*ctrl->cfg->read_c45)(bus, pn, devnum, regnum, &val);
> +	dev_dbg(&bus->dev, "rd_MMD(phy=3D0x%02x, dev=3D0x%04x, reg=3D0x%04x) =
=3D 0x%04x, ret =3D %d\n",
> +		phy, devnum, regnum, val, ret);
> +
> +	return ret ? ret : val;

Does the dev_dbg() need the lock? What about the return statement?
That is the downside of guard(), it generally covers more than what is
needed. It makes it harder to change this code in the future because
it is not clear what actually needs the lock and what does not.

There is a comment about this in the netdev FAQ:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew


Return-Path: <netdev+bounces-302713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PEuGOOeQmok+wkAu9opvQ
	(envelope-from <netdev+bounces-302713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:35:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C06DD63E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:35:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=bLn6iDGC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F4ED3001AF5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848F43DA20;
	Mon, 29 Jun 2026 16:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A0426ECF;
	Mon, 29 Jun 2026 16:29:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750542; cv=none; b=uO0kgPcWzKyoLqIUhPfaIQXnxD50oY5CA8l+3opE+0dLT4vJmDip847xu+q99LB/N+QjS4v2+96jIQ6GuV9BlGQ6/cmXzaOJrPG+MVz0M1IICl3YfWwqPcDo5XcoVrm+S8uz4IWZQKc4u3IcQgPfrqQ8Iovo7vRutEghcQQCjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750542; c=relaxed/simple;
	bh=v+ZzzwyTZpCd3A9wLJNj/5QREFo40R32KmC0KRi4trI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obf7md6Lo8ggoIif5l7xfQA+/SVIwm6y6sgUzfBfqwMgp0Bn63Z1cm/54wGTSp70k5l0lqc03OGW65hvLjrRFedMmydmY5jcLQSIwtm7hb8dUXSf7h6jVXyNJa8cGJI2LtixlMJTExO49th/WKFQjNhGR+nxfqkJCoqvtAbcy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLn6iDGC; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lkQrR2HpPgR/4lUKYt2XGoq32UZZpopn65LXb2S9Gvk=; b=bLn6iDGCIGIthV8lH6CA1r1R56
	LWrmERqrTdeCOoN6Ta7IXP0Yuv6NvPF7DPhnIxw+5dCTL9CG8CIcPArIx2KRDV2DW25MVQZG8SH2T
	5fDuA1PCiEQMmNncnv93Ge1bYj72X923k1/ZpV/HpXD3T5ly6gdGlKaXtrEU2iK4oY2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weEql-009mmn-0P; Mon, 29 Jun 2026 18:28:47 +0200
Date: Mon, 29 Jun 2026 18:28:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: mdio: realtek-rtl9300: Add page
 tracking
Message-ID: <f3b0ddab-372a-49c5-977e-59c7a104d0a8@lunn.ch>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629152336.2239826-3-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B89C06DD63E

On Mon, Jun 29, 2026 at 05:23:30PM +0200, Markus Stockhausen wrote:
> The hardware polling unit of the Realtek switches has a very special
> handling for PHY register 31 (aka Realtek page register) in place.
> 
> - On the RTL838x it is permanently reset to zero.
> - On other devices there is some magic saving/restoring (aka parking)
>   in the background in place.
> 
> This makes access to PHYs a gamble.
> 
> As of now all known existing hardware designs have Realtek based 1G PHYs.
> Otherwise the polling engine and the MAC status update will not work at
> all and the vendor SDK would fail totally.

If you are going this direction, then please somehow validate the PHY
is a realtek PHY, and error out if it is not.

> This driver differentiates clearly between c22 and c45 buses. During
> probing it enables only one of the protocols for a bus. So it is safe
> to assume that any c22 access will only target a Realtek based 1G PHY.
> 
> Intercept access to register 31 and store the desired value for each port
> in the driver. When issuing access to other registers add the saved page.
> This given, the hardware will run two consecutive c22 commands that are
> not interrupted by polling.
> 
>   ... hardware poll ...
>   phy_write(phy, 31, page)
>   phy_write(phy, reg, value)
>   ... hardware poll ...

How do you guarantee the polling will not get between?

	Andrew


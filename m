Return-Path: <netdev+bounces-289436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGo0DdNRDGqmfAUAu9opvQ
	(envelope-from <netdev+bounces-289436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FE57E487
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A245303D184
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E83346A5;
	Tue, 19 May 2026 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VDg0zf11"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9B3DB62B;
	Tue, 19 May 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191808; cv=none; b=kbMa2Vzh/3EZh7yeDklFEgrm2JuEs7DkUosppm84WQ8f23w1lj3/6LH14V91hTihpzU9O7X23MyTTyXDfEjcgxBfOPYOMwrFjFHgM+i+Eeg5ItCP6fj/pncwxcMInfq+Vp4wsWB61bcksjtexTgkWiW7G7rcn7Sb2qkUyUdpPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191808; c=relaxed/simple;
	bh=CpNQuTYqWEmQ0jxtASrxsdjSo7pbVPqzz7x73T94pn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWxNPtXK5RCZZmho23i1notujuxgSXuTRXNJohQ7Zv8yfwRvjcua7EFRYEIUpfGXQi4l9jWA7WTQ6qcS14ZObvm93xndPY92uPB27Sexdft8xQM3yosxcdDMkv/GsA/KSTpiWRsh3F8oaQc2YwJRXpEDMEvL3FCLrTkj3WxVUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VDg0zf11; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aoyUbTDpd3rcxoAsbcPCvdPbnM/atKRFCZSR1ycX05I=; b=VDg0zf11OnpZbO1Npmkce9IhMC
	keY6gfXZAMCpf65rhv0cPHw0+ts5q4prHKT/JRiSVBtKNAjoGonnqKvh9ATpUjIReRB6bVg5yezX8
	//ULtxe98bj2QgVT8mXWMqZXswP0aSk7Ur6t2OY79lvzhBXrMp48VVWIGXc5+UQ/GjDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPJ3t-003epG-Fq; Tue, 19 May 2026 13:56:37 +0200
Date: Tue, 19 May 2026 13:56:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: phy: honor eee_disabled_modes in
 phy_advertise_eee_all()
Message-ID: <156e0ef1-1e61-490c-8e44-a75ea83f31cb@lunn.ch>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
 <20260518-devel-phy-support-eee-fix-v2-2-05b52626fa68@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-devel-phy-support-eee-fix-v2-2-05b52626fa68@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289436-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tipi-net.de:email]
X-Rspamd-Queue-Id: 391FE57E487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:23:10AM +0200, Nicolai Buchwitz wrote:
> phy_advertise_eee_all() copies supported_eee into advertising_eee
> unconditionally, overwriting any filtering applied during phy_probe()
> based on DT eee-broken-* properties or driver-populated
> eee_disabled_modes. genphy_c45_ethtool_set_eee() calls this helper
> when user space passes an empty advertisement, undoing the filtering.
> 
> Apply the same eee_disabled_modes mask in phy_advertise_eee_all() so
> the filtering survives the copy, matching the pattern in phy_probe()
> and phy_support_eee().
> 
> Fixes: b64691274f5d ("net: phy: add helper phy_advertise_eee_all")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


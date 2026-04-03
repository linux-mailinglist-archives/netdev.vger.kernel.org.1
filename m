Return-Path: <netdev+bounces-275109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGDpAhPfz2mn1QYAu9opvQ
	(envelope-from <netdev+bounces-275109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:38:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BC395DB6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA1343006D66
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92230DEAC;
	Fri,  3 Apr 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JKv06dPb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9828C2BF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230269; cv=none; b=XnQKtPhsb27rirtPF4YhTLYvoTx7qAr6w9pyMADVZWOyAhbrBUHKqBVoZcrO9Fw4xPeJEFcCYsQgONzWlo6Il0OVa2eGwWMvuI+WxHUnhU8O3D47jJPEZ03d8+4JAnsMYhnsvK/uqiQDBCO+FnmvJbgTVb7VY1vn+dszODOFiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230269; c=relaxed/simple;
	bh=xAuQx+LzA5SLDS80n2X0IuMsiLFO2f79ipBgFM5fpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/0PwTUHZohSSZIwLpnGPosWc59xK6l0BFFHqY0lF0aHs6AnO01eyTOCZh57aOJWr3hEpN+ql2EY7WSnxp1udEit2Ynj4iut/KfSb3ePAipbbswohFPRE9tkAXi6Oa4BHVhy35StcgJoF9eaNvIiQMXSyGa7IghhnZ/E8OUtkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JKv06dPb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v2Ih9xMdKHIyIulzgMvgqXUmgPq7T5xpyE6toLbZVWg=; b=JKv06dPb1Da07P9bikubD+c2Kx
	vFUyCUe7f1lqmQ3Yi0DPu3KbCuhYPuwkzwYB+Gz2Ux4Xs8IKIqbOBNQ5blgsXnKc30uJvpoYyxH0y
	68+L2pA/2rxtXFaJpaad9PV6GqDH4xcglPOqkw32h/QxafIdJHd3Rjyw7yPUnWOTqFjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8gUE-00EgMK-Q0; Fri, 03 Apr 2026 17:31:06 +0200
Date: Fri, 3 Apr 2026 17:31:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [RFC PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <459413a4-ebc8-4a73-a60b-333193cbb2b0@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090656.733985-1-nb@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-275109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 058BC395DB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:06:50AM +0200, Nicolai Buchwitz wrote:
> Some PHYs implement autonomous EEE where the PHY manages LPI signaling
> without forwarding it to the MAC. This conflicts with MACs that
> implement their own LPI control via phylink's mac_enable_tx_lpi /
> mac_disable_tx_lpi callbacks.
> 
> This series adds a .disable_autonomous_eee callback to struct phy_driver
> and calls it from phy_support_eee(). When a MAC indicates it supports
> EEE, the PHY's autonomous EEE is automatically disabled so the MAC can
> manage LPI entry/exit. The setting is persisted across suspend/resume
> by re-applying it in phy_init_hw() after soft reset, following the same
> pattern suggested by Russell King for PHY tunables [1].

I think the general direction of these patches are good, just some
nitpicks to sort out.

Thanks
	Andrew


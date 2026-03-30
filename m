Return-Path: <netdev+bounces-273233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IcvM2WSymma+AUAu9opvQ
	(envelope-from <netdev+bounces-273233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6935D82E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E6B3312DB9B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D195324B27;
	Mon, 30 Mar 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ub0HQrrF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2631F984;
	Mon, 30 Mar 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881985; cv=none; b=eRCl5Rm8ggUNtHnIbGT70zP+fDybtMgIwE/CZPOHqmfWtinpDyR+Efr2vsnwDoPaUcDnDHPz4BazfEK4fULe87rh73VKtA8eFLHLOpDjqRrtgIk5TQOnXhiqQ/ThMru+QLFTHdX55Gv4t66HW4daNvWHFm4GX0qQoiCZLrlV0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881985; c=relaxed/simple;
	bh=E41Frnz0gzQOhy6LGl1KlM+dWtbXfzFH9eunh71Ty6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCkPEwNH95MH+lNWZ23PcRvWLR/2qexBbUh+ecv3M6i3mpoCtCDaHxznuCYggJm3j0FJKC5eBVfRj+fdwYY8McGIhE6AIFXehE5II8P/we0yYyiG1LoFMMBnb4vkL5mKloDb8+BeM6NgLxTfC/tYiA4PdAe+nzMVB1RM5eS5cw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ub0HQrrF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L2ua2oQjIkX4hIJi0sX8mjIruC6aF6PUxPf8vYEK+Nk=; b=ub0HQrrFuPltVbp34VTcMnCoFS
	NBf5iV0HLn4gq4sXB/tFWONfDzkpvaF9pkj2DW71ekzUwv50AQKAFzOHTxijmJfdoTJxzTaMcaddQ
	aqrhG92/KLbo5aMAY1LQLLzn8k5cDKmNRmhkqf8rSzJJek84WCSrjrYwVPPZZoFE3t5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Dsc-00E2vA-HB; Mon, 30 Mar 2026 16:46:14 +0200
Date: Mon, 30 Mar 2026 16:46:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, steve.glendinning@shawell.net,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: phy-c45: add OATC10 Sleep/Wakeup
 support in 10BASE-T1S PHYs
Message-ID: <239a7455-5cb6-4cbb-b9d6-1d48a0cadbc8@lunn.ch>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330134222.67597-2-parthiban.veerasooran@microchip.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273233-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BD6935D82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +	/* Cache PLCA settings for later use. These values must be restored when
> +	 * the PHY wakes up from the low-power sleep state, as all configured
> +	 * settings are lost.
> +	 */

Does the standard define that this configuration is lost in low power
mode? If the standard says this, then fine. But if not, it should be
the PHY driver which saves its state during suspend, and restores it
during resume.

    Andrew


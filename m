Return-Path: <netdev+bounces-266734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMMFJrmxsWmXEgAAu9opvQ
	(envelope-from <netdev+bounces-266734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 341182687D4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DD653007BAC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F93E7156;
	Wed, 11 Mar 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bH0uAlY6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A413AEF22
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253046; cv=none; b=QUYJm0a4PglVLFyjTr9xxNTRQnv09zF1+PAAlT17/K65OD+VvdPR08r/5+GUIuvvGlyMVWPQM23tFgSF02YXYNCadd0LgKIiGJRG2l5Mvl4J1nvPSTrmIVkrhtsyG1v7PI2EwfvlRfih9X0Z79VtEPJ4qQw6r04MFDVIDcYvy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253046; c=relaxed/simple;
	bh=i43kvgHNzSyUZy/Jg35VfgHyjKRq6DCz9EVi6NzKC2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPcj5Jke/9HOb5TGzwiHCv8xciw6OisosKRywnrVmGLUUPaQ8D1srwrjrYqIKaaRolTTlKxI+Yucf+gtGB0Gtj0kgJE4UjBQd7CQdnWbE6E9VG8Zc+MhGjVx+LbkoY++0+a0eUpfIc6BD0MlqiwopEOYhXmjRRtZCudT6m5IcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bH0uAlY6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QHkoqFwf2MMklCs4/P8+fRi99/w62eFjq0wGLY+/d68=; b=bH0uAlY6KHt9hVTn9HE0ICBeBX
	SnjmeFpVk2+vWHYSO2+IjB+YNGLqK5Kx6yQqVpNQdTFm0rZS5TQ7gOB1YSgSwHR0VwGOwP2sgw6ZF
	057o4MFzn2P6gFWitORZlUD/qzua4bsE+BwoXDyrtVKN+7LkSEET3erBBu6LF3mLZvLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0O7S-00BDhI-LN; Wed, 11 Mar 2026 19:17:18 +0100
Date: Wed, 11 Mar 2026 19:17:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Subject: Re: Disappearance of network PHYs
Message-ID: <243d5ec4-785e-459e-9129-d1e862d36716@lunn.ch>
References: <20260311153421.u454m3e4blkstymt@skbuf>
 <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 341182687D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> One other thing could be to rely on phylink to handle that ? It's the
> one part of the net stack that already handles PHY devices suddenly
> disappearing, with the SFP case. It has all the logic in place to
> maintain the netdev's phydev pointer without the MAC driver having to
> deal with that.

We might want to consider the different use cases.

1) Hot pluggable hardware, and it disappears. As you say, phylink can
handle this.

2) Root unbinds the device, while it is in use, for hardware which is
only cold pluggable? Cannot we just consider this a foot gun?
Exploding is O.K?

Is there a good use case for root unbinding the PHY driver? We should
only add complexity if there is a good use case.

   Andrew


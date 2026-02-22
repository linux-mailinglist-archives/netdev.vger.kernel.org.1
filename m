Return-Path: <netdev+bounces-259853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id r/ZEJo55mmm3bwMAu9opvQ
	(envelope-from <netdev+bounces-259853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 04:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCAB16E720
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 04:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E7B630107BC
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23072125D0;
	Sun, 22 Feb 2026 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mvv8Dy3x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBF4A02;
	Sun, 22 Feb 2026 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771731337; cv=none; b=auud44Zs/e/r0lkJAB0Iqdh6Qf4OjtxRyLXDnj+MDxk0RSbdPMlW2r/gbjcyHYslomq7jrFIFn1z+5dsi9YNBVYUQoOdGtPfPo5n9t+Os1aHSKI4534kWUppppMi0bzit41u2UmvY2xJlVXIe2SPgSshlpSW/tfxxHoBF2UMvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771731337; c=relaxed/simple;
	bh=4y6qTVwwpXQiAVGwLU7RRdi3eRD/gwnH4VUiPsk74HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbj8fw5Fhe/D1eSAoXwt5j6XE7WMmfaJrvkPLqvLqPauHmQrHWbVHSWYJmdG7mT+ou9fbJ0vUZxrhBbLkMYlbYNdJ/YhL+xkzcmu2NapDsNCapQdKI6M9ww/NdVTB7cLeBWRmbml6UBqt9OW274+DXzNNj1y7BuAyOv5UeUAu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mvv8Dy3x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=8ZaHXV6lTmiTx1juUt0ede/Q3PPzOaeLyL0XLic2p6Y=; b=Mv
	v8Dy3xhCPlvrotvs51i2MR6CaWdX1up6kjaAXDxIH7dW1wWhWMuIdTW4cJZV2HRH23G7wSG30bQ+3
	TqS9EY09Fz0wlvjPWeQz6pUhl8SQf4uZCcJvhuoroPDpyU6hL/HhIb28ipAssSndwZl23G+5BaPFN
	ZmNs2REkvazh1I0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vu0FS-008EI7-Os; Sun, 22 Feb 2026 04:35:10 +0100
Date: Sun, 22 Feb 2026 04:35:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
Message-ID: <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[makrotopia.org,gmail.com,mediatek.com,motor-comm.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FCAB16E720
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 03:32:45AM +0100, Jakub Vaněk wrote:
> Hello Daniel, Qingfang, SkyLake,
> 
> do you happen to know if the MediaTek Gigabit PHY in the MT7981B
> can be remapped to a MDIO address other than address 0?
> 
> I wasn't able to find public documentation describing the registers
> of internal PHY or whether its MDIO address is configurable.
> 
> Being able to move the internal PHY off address 0 in U-Boot could be
> a better way of resolving a MDIO address conflict between the internal
> PHY and the broadcast address used by an external Motorcomm YT8821 PHY.
> 
> Any pointers would be appreciated.

Even if you can avoid the conflict, you still need to handle the fact
the YT8821 appears on two addresses. phylib has no idea it is the same
device in two places, so it can instantiate two struct phy_device for
it. This can cause problems, i think suspend/resume will break, etc.

There is nothing in IEEE 802.3 clause 22 or 45 that allows for this
behaviour. So rather than living with all the issues it causes, you
really do want to get the PHY into standards conformance.

       Andrew


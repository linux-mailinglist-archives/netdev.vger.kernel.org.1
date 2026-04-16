Return-Path: <netdev+bounces-279071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHJnNbzy4GkZnwAAu9opvQ
	(envelope-from <netdev+bounces-279071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120D40F958
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B153051179
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D52236F7;
	Thu, 16 Apr 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CcFjs9kL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB21ADFE4;
	Thu, 16 Apr 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349865; cv=none; b=YLBSWUZQYZQZCICA11P3oxWQ+CBF+a1bzxm1J0FWfiNUO1Vb6ciNB+tpVMxBylKngJFIaCx2X7AF5oZE5v9mUvUwa2KKM2p2Bu1GQtHaN9UN4x1V85EFMhfKX/Ykay7a+R+DMa5PR8T0d6IDABlvcwYkVqRecmm8mmAC0iBYUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349865; c=relaxed/simple;
	bh=notZMVhaA9VFBXLOHMpAnuDLOZ7ca4/U/AebILhpowI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWkrDu7raOHFRdhle+Z98h5CTp8KEXPPu4c0/RlK+K5oHslGiHkqiEVACoVJS8jCSiD6EItNfK6y8qNiyjGUEoTZVU1VUvElZTH0oy2WFTMmnGIT5TtGwklDuYz2qXEcUgdJeUWzcoWkkSVEHcLRmomgtnpnEjGTSEUnNcVVAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CcFjs9kL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=N2n11dxHk9/Ki2gi5ke8JzFzEct0ow5fF/szOMJL9f0=; b=Cc
	Fjs9kLeNFWC4n+BdtZCreNoN4Q479ftwAVyCLyrdFXwg6RMW4px2XwvH6W0DbseWWpHMo3IK0g5vl
	Bq5qbK1gX1sUBQpVpNITUBc/0ANfW9SEw8EUnarWbCblEm40//zwD6k/NWCSQsEI5swac+rIkumeR
	sJUY7DdqnawchVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDNjy-00GImw-P9; Thu, 16 Apr 2026 16:30:46 +0200
Date: Thu, 16 Apr 2026 16:30:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Marek Vasut <marex@nabladev.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <6a8fc2e6-830f-4f57-869b-41efe70557e5@lunn.ch>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
 <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>
 <03040421-89e7-4422-9fb5-0367a34323e4@lunn.ch>
 <bf93f620-1288-46a3-8798-6d70aeb2c7c6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf93f620-1288-46a3-8798-6d70aeb2c7c6@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-279071-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nabladev.com,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3120D40F958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> With this model, we don’t need to return -EINVAL for combinations or
> ordering, and userspace does not need detailed error reporting. The
> tunables behave more like simple setters than a mode switch, which
> keeps the API predictable and avoids the need for extack or netlink
> ethtool support at this point.

Sounds good.

       Andrew
       


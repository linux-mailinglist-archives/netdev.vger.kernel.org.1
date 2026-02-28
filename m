Return-Path: <netdev+bounces-262211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JY4C/5ho2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:45:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9744A1C93BD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 773A232BFDBE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A0430B8E;
	Sat, 28 Feb 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2kkinzny"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0972430B95
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309794; cv=none; b=JTYjrvFyyoH+R0BMJRfQIOrhP1Rc/+T9qe7ciESITOg8zbmhnc8gTNZvw8F7PJJyTEa6OCVjE/haRWSTMqmnsuLg6aZyRJSMzm9/neWd6oULJzPOOIGCT0cPBV4Q9zdnPQORgOlOtAUhW6BRYR87fVbyLK2ojrJN32mX584Y+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309794; c=relaxed/simple;
	bh=dQcDD7cr3guHFI3S1fEIDE1sf5IfTbr31cBNgQqWhko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7aeq3f1beRPp9rhoGibozHkLvaEzCF8PbW+W13YAX6fCzzsktPBnre6t0F3SMB7EfX2n73V7Y0Z54PpwrXQet5IXUso011ENUIEkvsYBrSoKemk8ThR+x+SGhU5t8qp77kVDoQBSGYq2HwQtf3pYulKIm1iPK4HcByIxihDrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2kkinzny; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AstPI9SLerL3GnfX/7VC0MEUfFdf6FjkltO1e76k7x4=; b=2kkinznyAVgscPtpC2eT+46uKE
	CoXmc4NUCnQxYcccb8GP4Fu6WdBlOmNxSl+J/QCfwtCF8WToNtIpCMcFKm0lYiqLLA9/PFnxFR3B2
	Ns9xyxzkBDFGn43tKY/6RErJcQvheAM+JGLpXk+sdGomXpRkl1wUIrNl4HPkXI2yxElQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwQjm-009Dc3-Tq; Sat, 28 Feb 2026 21:16:30 +0100
Date: Sat, 28 Feb 2026 21:16:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2 net-next] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <ecd7df0d-a5f8-4e0c-9ad3-51a007d8f456@lunn.ch>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228185242.800836-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228185242.800836-4-joey@tinyisr.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9744A1C93BD
X-Rspamd-Action: no action

> +static struct dsa_switch_ops mt7628_switch_ops = {
> +	.get_tag_protocol = mt7628_get_tag_proto,
> +	.setup = mt7628_setup,
> +	.port_enable = mt7628_port_enable,
> +	.port_disable = mt7628_port_disable,
> +	.phy_read = mt7628_phy_read,
> +	.phy_write = mt7628_phy_write,

Although phy_read/phy_write still works, all recent DSA drivers have
declared where own MDIO bus, and called of_mdiobus_register(). That
would be the preferred solution.

      Andrew


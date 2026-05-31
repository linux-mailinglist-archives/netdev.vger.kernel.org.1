Return-Path: <netdev+bounces-293446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP71EIxVHGqFMwkAu9opvQ
	(envelope-from <netdev+bounces-293446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D6616EC5
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7ED30277EF
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07972E7BD9;
	Sun, 31 May 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YtRaLfO8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD83002AB;
	Sun, 31 May 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241697; cv=none; b=jZLMBwXlAKCBd8CbyL4cHIGCD7Q8xOyVld01rsmV9KzAC6cL2PFY1tnrykyfUa9G331b22s9hRm6qFA3h2MGoO5F+Cjl5qb+fgX2drianzHI7XVYPu58sHDw6y4UiPVSS1QT9ZbKbJfubZxlCPzNU09A0mG3/hwwFXPqhGC43jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241697; c=relaxed/simple;
	bh=CnjYxTujUwqmWeP1pnZD3DQRbBwuGdBRB80Qyh0vafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7mg/HBY7gb6utgOyOL0wtdcnbL92ZeImBQ1LrKjXyaOEF/iEexqMkEQT8BR8rjcvr1MGzx3QpgTy8FxhorilWzlIdDSLke230bbJLLOY3ycWCabImLOkXifq7nkxZNVO9HM/lwxAnl/J8JW/3M1utgkxGZ2h2vwYAUmuhBa/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YtRaLfO8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PvG6MV5RPuHQIar4jhjtR9HbiwHnHpHaN6lD0W9eufY=; b=YtRaLfO8CkIXWYRtkbO1GOOKP6
	SbLKjCN40XDXuDkrixJWQH27drF6XWwdVj0N+0xb3j0ax6eOJtHthyuochZG9REuMoUM6zh3YVZhN
	MaFK1HBsW4LAgjp581zWFkZlp3yCIiC0bTIK4SlXmhnVz6iosI5gziPrS/oEBKO/g73w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTiBb-005NCq-JK; Sun, 31 May 2026 17:34:47 +0200
Date: Sun, 31 May 2026 17:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for
 loopback support
Message-ID: <22496ce0-6d50-4059-bbd4-980513ad2612@lunn.ch>
References: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293446-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: A65D6616EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int ncn26000_loopback(struct phy_device *phydev, bool enable,
> +			     int speed)
> +{
> +	u16 mask = BMCR_LOOPBACK;
> +	u16 ctl = 0;
> +
> +	if (enable)
> +		ctl = BMCR_LOOPBACK;
> +	return phy_modify(phydev, MII_BMCR, mask, ctl);
> +}

dp83867_loopback().

There is already genphy_loopback(), so it will need a name to indicate
the speed does not matter, because only one speed is supported etc.

    Andrew


Return-Path: <netdev+bounces-286649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2kJHMpnZAWoDlgEAu9opvQ
	(envelope-from <netdev+bounces-286649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:28:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5450EE72
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C9B30B1F72
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5373E6DFA;
	Mon, 11 May 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NMX1FjyN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBC3E6392;
	Mon, 11 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505715; cv=none; b=Wpz76NcqpS9hIT/WRsurPC55gKP/BLROps6tjMV3cp9jYWu1+l/pEv8TUtU6KjFRV84gXYFJyAlhE6rovamnFaUymBClLT3BKZ5YexvPW0of3It0Bfe+tR8i2PAr5eM7JwPVIxFcgI5XwfMnWkWsLXoZKh2Tb9RwOFN+/563qg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505715; c=relaxed/simple;
	bh=zUwr9YCJmCC+zkQ/01izxYa4XDCme5fAOxCt+ZUgQ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpswTZBrLnKmEmUSbrKJ4xpnQ2F0SKqa9eesNvrCX5Bg5oVfUfG8uZC7vtcCYqvTXoQO5CyjWP/p2oJpn4VUVSnd1dpmbg6pMG0lTcllwRZW34SX+VY+76NRKa1jY06wTY71P/F4K7FBai7lybipKNoKQDN9mvyuJys7jk9mOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NMX1FjyN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HsKTb5O5R/2smLy6Go15oB5pqJ7KBOXqhOkTOyWLjaA=; b=NMX1FjyNIdh6g0p2FFrNadkz2U
	kB8wYj+pYog4nlxhJmEOObGka35rtH3U9eM5uJJYE+I3xuObha1b2jTyC9JoqWMeVkaPK6iggIhzo
	Uf7vgCUv2x80+wXBDKRPyHHqjKLbX+Z0L3HW1pPvhinQc799IZEtkM6oP6m1dVYxYdHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMQZk-002Mdz-J1; Mon, 11 May 2026 15:21:36 +0200
Date: Mon, 11 May 2026 15:21:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v2] net: phy: DP83TC811: add reading of abilities
Message-ID: <63a83ffd-15fe-4667-abd3-f4617be04427@lunn.ch>
References: <BEZP281MB2245C0B534D1297363EE1343D9382@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB2245C0B534D1297363EE1343D9382@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 09A5450EE72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286649-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,bootlin.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,outlook.com:url]
X-Rspamd-Action: no action

> +++ b/drivers/net/phy/dp83tc811.c
> @@ -392,6 +392,7 @@ static struct phy_driver dp83811_driver[] = {
>                  /* PHY_BASIC_FEATURES */
>                  .config_init = dp83811_config_init,
>                  .config_aneg = dp83811_config_aneg,
> +               .get_features = genphy_c45_pma_read_ext_abilities,
>                  .soft_reset = dp83811_phy_reset,

It looks like there is a space vs tab issue here. It is not just this
one line, but the whole patch. That usually means your email client or
email server has corrupted the email. Ah, outlook.com. Yes, that would
do it.

As a result the patch does not apply and the CI/CD system has not been
able to test your patch.

https://patchwork.kernel.org/project/netdevbpf/patch/BEZP281MB2245C0B534D1297363EE1343D9382@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM/

One option is to use a web submission endpoint:

https://b4.docs.kernel.org/en/latest/contributor/send.html

Yep, a lot of hoops to jump through, just to get a patch
submitted. The processes are designed to be scalable, handle lots of
patches efficiently. But they are not so friendly to beginners trying
to get one patch merged.

   Andrew


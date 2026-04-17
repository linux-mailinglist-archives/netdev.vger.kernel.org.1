Return-Path: <netdev+bounces-279381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FkMI05u4mmp5wAAu9opvQ
	(envelope-from <netdev+bounces-279381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BFB41D7F4
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB06300E720
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6E2BE03C;
	Fri, 17 Apr 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y73whGyi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B42FC037
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447051; cv=none; b=VLKVJYrTsx3VBxtBj5p/M90bSEvNNC3VYHGL0+ExUtVT6JIgg8VJobhgCiMJOfcDfYphNwAIBYqbLXxrPri+kLmdl9i6ta0fGV8s7uFBxzJ3ij8OLs4EObvwz4XgcJAvCKZmHfNe89c3lhyjkVuatKorEKAZrXLewlXyFINGuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447051; c=relaxed/simple;
	bh=ycybKBC08oXR9ME0KHALVkiM6mQfe8XZvDSZtlzc91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwXFoMMz7+L8J8RQexUztv1cTCOemK89xdCMAj4VgMb9iYq6MR47J5LZ2wvo6HS3enLrjJYb+5FBnJJmGYBkANtyo5yS6qw9TE6tKUjrRkXaqm2eowHb+QSMtUv8o/QIIj8LlAN7NlABTjxGs+CExqCgP1cF7g+F9U9eYugDVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y73whGyi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TGZoyyU5mHFyfI81hgTycgiqWkmpexYhWMgVjzucmMY=; b=y73whGyibXvyVYNDNyPFnQAyMd
	eNY9QgXr6vi7KyuFwRNlaDo8k5tV+c+1/UEylcCLSaqrJP2gNkA8zSOSyey5havYeGQa4Vsy8QmX4
	0918cQy7oZdGrMy6KAypTjdiQtI9bC4T2/zcsWEp1a5TKgSl7pjvvLfFUEkvcrpA2yNM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDn1R-00GRAd-By; Fri, 17 Apr 2026 19:30:29 +0200
Date: Fri, 17 Apr 2026 19:30:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <01f5e05f-31ab-4051-bc2a-9c331fcd9a95@lunn.ch>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
 <680c384c-135f-44cd-a2cd-7e4fd0ec4bf7@bootlin.com>
 <13939918.O9o76ZdvQC@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13939918.O9o76ZdvQC@steina-w>
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
	TAGGED_FROM(0.00)[bounces-279381-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,gmail.com,foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5BFB41D7F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Thanks for conforming this for another PHY. What I'm wondering right now:
> Why is the PHY stopped in the first place? We are just changing the MTU, no?

It is not too uncommon to see an MTU change destroying everything and
rebuilding it, especially when it was retrofitted into an older driver
which had fixed MTU.

> I have a proof of concept running, but it needs more cleanup due
> to code duplication.

You probably also want to take a look at the ethtool code for
configuring rings. Oh, it is even worse:

int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
{
        struct stmmac_priv *priv = netdev_priv(dev);
        int ret = 0;

        if (netif_running(dev))
                stmmac_release(dev);

        priv->dma_conf.dma_rx_size = rx_size;
        priv->dma_conf.dma_tx_size = tx_size;

        if (netif_running(dev))
                ret = stmmac_open(dev);

        return ret;
}

So not even using __stmmac_release() or __stmmac_open(), and leaving
you with a dead interface if there is not enough memory to allocate
the rings.

These paths should really share the same code.

      Andrew


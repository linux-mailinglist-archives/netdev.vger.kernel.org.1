Return-Path: <netdev+bounces-259834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B3fDToMmml+YAMAu9opvQ
	(envelope-from <netdev+bounces-259834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 20:49:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640716DBAD
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 20:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6647300D75B
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932321DFE12;
	Sat, 21 Feb 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uWzlCfbw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446510785;
	Sat, 21 Feb 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703349; cv=none; b=OjktmzebNZdDSDgSZ1Ex6BqI6YgpN9PZrtB4DPNJ33z1R5+TSmhOKI9dNNpFIXNQsdLL53WpXlqsgYeS8vYCturqddqewLbe8a/eJQEH1GWGDsIXequw3gkjicUBzTH0qgrmoIe+WqqnbNvb+xYInf9aNCpQUez4tQGeiKAGBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703349; c=relaxed/simple;
	bh=fSRGrvc9Ng/9/dIjO6ddKOyQEt6stAFONh4lvET2pjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYGs9ZIVnIAZQVEyCQrzx7amvBsUf7iPJPgauRf708gY+sw7OPAO6xWz5ui8+9ea2XbcedfdP/8WuISWJRMz3zUAo/IV2e05JJ3MNIwhqLkQv+KwGvZiEgVxXJEmqaMDIlTEaCGfGZj/3Akadw3ogdt+TT9VM3suLngpeLDkM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uWzlCfbw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5iRlmFXc2r6CZchmrxzQhQ4qV/4q4TC+MOdXBZVQljc=; b=uWzlCfbwnN4+jfGVnro++028Lc
	7bkvigXRQdILPfCC6G4kZ8OKrcGboBJy4ytsZo67NIyOJ8AiCS+h/TI1V/oOKWhruAmCWo/MMPpnT
	nTI2tngWsMCu9/0R2n4Q4+JChWi0J6vFfbGkXYcG3+dDRBgsHh3WmhfWl8YqxRauU0sA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtsyP-008CQs-TI; Sat, 21 Feb 2026 20:49:05 +0100
Date: Sat, 21 Feb 2026 20:49:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net:ethernet:enic: map ethtool link modes by VIC type
Message-ID: <ba9de65f-2a58-4a02-ab01-b5a78a22d2f4@lunn.ch>
References: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
 <20260221-enic-cscwi36355-v1-2-5a01a6046d5e@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-enic-cscwi36355-v1-2-5a01a6046d5e@cisco.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-259834-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5640716DBAD
X-Rspamd-Action: no action

> +	switch (sub_dev_id) {
> +	case PCI_SUBDEV_ID_CISCO_VIC_1225:
> +	case PCI_SUBDEV_ID_CISCO_VIC_1227:
> +		ethtool_link_ksettings_add_link_mode(ecmd, supported,
> +						     10000baseSR_Full);
> +		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
> +						     10000baseSR_Full);

Do these ports support autoneg? Is it really advertising a single link
mode to the link partner for the negotiation process?

>  static int enic_get_ksettings(struct net_device *netdev,
>  			      struct ethtool_link_ksettings *ecmd)
>  {
>  	struct enic *enic = netdev_priv(netdev);
>  	struct ethtool_link_settings *base = &ecmd->base;
>  
> -	ethtool_link_ksettings_add_link_mode(ecmd, supported,
> -					     10000baseT_Full);
> -	ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
> -	ethtool_link_ksettings_add_link_mode(ecmd, advertising,
> -					     10000baseT_Full);
> -	ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
> -	base->port = PORT_FIBRE;
> +	enic_get_supp_adv_media_type(netdev, ecmd);
>  
>  	if (netif_carrier_ok(netdev)) {
>  		base->speed = vnic_dev_port_speed(enic->vdev);

Ah, if you look at the rest of enic_get_ksettings() you see:

	base->autoneg = AUTONEG_DISABLE;

So this hardware does not support autoneg. So all these advertising
values are pointless.

       Andrew


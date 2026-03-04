Return-Path: <netdev+bounces-264037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGmvChKTqGkLvwAAu9opvQ
	(envelope-from <netdev+bounces-264037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80180207844
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9B33044813
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3533B6CC;
	Wed,  4 Mar 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xYIGO1mN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16972D8DA8;
	Wed,  4 Mar 2026 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655369; cv=none; b=PrPq9/atdodS8vgevH75aTND5G1bbo3vk554BdvyeUTzoxepsZ78Oi8WtuTc0rPBXVfRUcYeEYPh+BTeJmbfAHoFeLCBphs6iTpKwiHHsSwVddIml5E9vqYcdtWV3EJWkRjs7AJ8CHeu6o7yrxYiYgcscKHInXBFAXeRfdPBfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655369; c=relaxed/simple;
	bh=u1bbpiWKxcQ33xBweWmJBReij8hzB8i3pgK0waGCwOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9csPt3pq+hO1Cpd9sOeyBV9YxXAV+/lrdwFShQqSw00oFeDSmMRxmKYD36abP9u5nUz97SJ32pocs2AbOvugT47xKPY2eBi6WSzBLzGk95uLI5to9EdHhesRRDpF800OhxXcXVEx3qobBdeJL6wam84oKZDmo+rgp+xXVXM5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xYIGO1mN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O5W0rWNkyqIYuvm8hc/o0jT6NtzcpJClwcC+P3CAwxA=; b=xYIGO1mN6A+vyyrQebHB5RDrjO
	Cax+vH7HBHBnKH3pJLlMqu2z+9wJ1DXp15d3kAdIEQcs/+91UX7VV7fEWMrG7q/rQzEnJ1gwRC+1t
	N7HNovYnSV6GPazhPDL+FQybwqYiogrhd9dVD54AIhVamfKzXl91omeJ5LmRa1Sv4CD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxsdF-00AAfh-DA; Wed, 04 Mar 2026 21:15:45 +0100
Date: Wed, 4 Mar 2026 21:15:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?= =?utf-8?Q?xt?= v6 3/5]
 net: ftgmac100: Add RGMII delay support for AST2600
Message-ID: <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
 <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
 <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Rspamd-Queue-Id: 80180207844
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264037-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> > > Therefore, we calculate the delay stage from the rx-internal-delay-ps
> > > of MAC2/3 to add 26. If the stage is equel to or bigger than 32, the
> > > delay stage will be mask 0x1f to get the correct setting.
> > 
> > Please return -EINVAL. Asking for more than 7.75ns is clearly broken.
> 
> ...
> 	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> 	if (tx_delay_index >= 32) {
> 		dev_err(dev, "The %u ps of TX delay is out of range\n",
> 			rgmii_tx_delay);
> 		return -EINVAL;
> 	}
> 
> 	rx_delay_index = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
> 	if (rx_delay_index >= 32) {
> 		dev_err(dev, "The %u ps of RX delay is out of range\n",
> 			rgmii_rx_delay);
> 		return -EINVAL;
> 	}
> ...
> 
> These codes will calculate the ns delay to MAC delay index.
> (rgmii_delay_unit is 250 ps on MAC2/3)
> If set tx delay to 8 ns on MAC2 or MAC3, it will get index is 32.
> It is over the delay configuration range, here will return -EINVAL.

So is the comment wrong? No masking is actually done?

   Andrew


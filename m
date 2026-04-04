Return-Path: <netdev+bounces-275382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YomMEBsk0WmNFwcAu9opvQ
	(envelope-from <netdev+bounces-275382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:45:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7F39B66C
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5363300CC0E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D41A0712;
	Sat,  4 Apr 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zvkMuo9c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3717736;
	Sat,  4 Apr 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775313942; cv=none; b=DD131V/iA7K6AlBLyySXSoZCfq5AiRbUrYSKqm3e8+5bHXo1vN0OvqNRrYjMla9gyebGtFpgwPbNT1G/WO7PSASywSLO4uHvHkz7V5yzWamP2ff3F29lkcb0ehIBYxGAAX+1z6OyHFU9rJ4LkPgTk7jKhYHPKjhT1TzcfyxxFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775313942; c=relaxed/simple;
	bh=Ow6iJqJdggA5/8F9EjUEwmff7SYCGGC3P7M3J+YMPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3e94rHFRRaeyxtPNh0gQguHpbFwQSYECdJEzVpQHwo50hFq3udvzqVFupF91bdoqsTPZRe1PVhDEBPaM2To0odTZUb7aoo6Hsj2EY/92xPAgCc1tuVZi2sS1JYeuSxnXQ51GW4MR5rXIMhZ+sfyUum6FH8CBBTjkInkfdC9q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zvkMuo9c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=98poN+0Me7pHop53Kjw5kc/RCUlTdmlIDXc15TIu/dg=; b=zv
	kMuo9cBxRs7+5wDfhoxIAyZFOo3URpr8VTpXW1nhhuHnvp4A4qzMYEX4iVkKHhjRHpmgHUA/iA/b6
	xFTR2DgAxATbZthh5xUajIGQO7N7gRfS5wYJmnf9hUfKAFNyiqqDh73/qukriv2ZLOTpUyjSJaq5T
	AxD7xN1D/a2KYGo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w92Fd-00Emnl-OD; Sat, 04 Apr 2026 16:45:29 +0200
Date: Sat, 4 Apr 2026 16:45:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <c235ee5c-6057-4c10-9960-9c5a3527bf22@lunn.ch>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <ab6a06c1-2d7d-4032-8d38-063470cd45c0@lunn.ch>
 <fe14415a-52fa-42cc-9e4c-e3876588d513@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe14415a-52fa-42cc-9e4c-e3876588d513@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-275382-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,bootlin.com:url]
X-Rspamd-Queue-Id: 7DC7F39B66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:43:24AM +0200, Fidelio LAWSON wrote:
> On 3/26/26 13:18, Andrew Lunn wrote:
> > > +	mutex_lock(&dev->alu_mutex);
> > > +
> > > +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
> > > +
> > > +	if (!ret)
> > > +		ret = ksz_write8(dev, 0x6F, indir_reg);
> > > +
> > > +	if (!ret)
> > > +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
> > > +
> > > +	mutex_unlock(&dev->alu_mutex);
> > 
> > What address space are these registers in? Normally workarounds for a
> > PHY would be in the PHY driver. But that assumes the registers are
> > accessible from the PHY driver.
> > 
> > 	   Andrew
> 
> Hi Andrew,
> These registers belong to the KSZ87xx switch address space, accessed through
> the switch’s indirect access mechanism. In particular, the offsets used here
> correspond to entries within the TABLE_LINK_MD_V indirect table of the
> KSZ8-family switches.

So this errata is for ksz87xx only?

For this PHY, do all PHY register reads and writes go through

https://elixir.bootlin.com/linux/v6.19.11/source/drivers/net/dsa/microchip/ksz8.c#L957
ksz8_r_phy()

and

https://elixir.bootlin.com/linux/v6.19.11/source/drivers/net/dsa/microchip/ksz8.c#L1221
ksz8_w_phy()?

We already have some "interesting" things going on in these
functions. PHY_REG_LINK_MD and PHY_REG_PHY_CTRL are not standard C22
PHY registers. They take the values 0x1d and 0x1f. The 802.3 standard
defines 0x10-0x1f as vendor specific, so this is O.K.

So you could define 2 bits in say register 0x1c to indicate the errata
mode. You can have a PHY tunable which does reads/writes to these two
bits, and ksz8_w_phy/ksz8_r_phy which translates them to indirect
register accesses?

It is not even really violating the layering.

	 Andrew


Return-Path: <netdev+bounces-273642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIZAHY/Py2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:43:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D895136A6C6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439C13038169
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E333E8C72;
	Tue, 31 Mar 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RMsAxwb/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27B3E8667;
	Tue, 31 Mar 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964568; cv=none; b=Dx1ixyQZhnyUUPKnkix4j1BYRjNyCZdu/onEawFETxyw7NqNUFhU+qzSNZpVTlpBqoo8/9J1tASaRFS/HFYt+wMUaBYliGxdIoq0MRS2hybA0wIOku5a3nwLgmeiWxbY4pkptR5tk8BqDooB4UzN0CqV+jhE4VRhNW6hR7TXCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964568; c=relaxed/simple;
	bh=AhoEZJeLDyXJCE4xiv1ZSHFhSsh1fqiNtDK5o9E0qc0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuG8FHXSckTCZgxSH1Z6b84avwwdVjreVg/dMARl2vyg0W+5PzlWQ7677NWwZeXplXt25zVc6kH+U5r9cgZo2YKQepfli63SFplUJnPj0RemSFfumWkrUklDySCU2LWENAKSE6EZ9k+uQ9XYn5rRfCpEBFsbZMa3c1DS2PS7bBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RMsAxwb/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774964565; x=1806500565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhoEZJeLDyXJCE4xiv1ZSHFhSsh1fqiNtDK5o9E0qc0=;
  b=RMsAxwb/p5A9EZ/ktZxbHV3B8+6KuSMGXhkPuEaLpnFJz7Dn1dSkqpqW
   ApBOYJe0jLG38OutRnDSRy/PEtLox3IUSCWl0Oc1Ykr8erW8+sqIWyHC9
   0sPDrQD/T0oVRvPHhWwllVjRGaOm4FUqdV8LZLMh2SZ/lHMBCVCFQjVkA
   3NQkjrIujklLq/aNUF9Z9Yi6o1vwodYFKxoBRj3xUGe3K0IWYlKrf3aol
   pq47vlZ0FvPFxJZQnoV3eQr4+iD1BTX5Z/tbDMp2mZxqxHfKljhtAqQXa
   82Puhe5QeE2ME57xubYgmBFycsPdl3xpsoTIR5WmV9w56x0Y3is1+EQ/J
   Q==;
X-CSE-ConnectionGUID: Z3cYWzf8QcKdKfmtRd4TIw==
X-CSE-MsgGUID: BqXFIh3ZSPWnmTVH64QV4A==
X-IronPort-AV: E=Sophos;i="6.23,152,1770620400"; 
   d="scan'208";a="222731736"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 06:42:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 31 Mar 2026 06:42:04 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 31 Mar 2026 06:42:04 -0700
Date: Tue, 31 Mar 2026 06:42:02 -0700
From: Charles Perry <charles.perry@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acvEpk1grDFAahzd@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,bootlin.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273642-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: D895136A6C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:57:10PM +0100, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 05:38:54AM -0700, Charles Perry wrote:
> > +	if (!(bus->phy_ignore_ta_mask & 1 << mii_id) &&
> > +	    !FIELD_GET(MDIO_READOK_BIT, val)) {
> > +		dev_dbg(&bus->dev, "READOK bit cleared\n");
> > +		return -EIO;
> > +	}
> > +
> > +	ret = FIELD_GET(MDIO_RDATA_MASK, val);
> > +
> > +	return ret;
> 
> You don't need "ret" here, this can simply be:
> 
> 	return FIELD_GET(MDIO_RDATA_MASK, val);

Ok

> 
> ...
> 
> > +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> > +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> > +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_WRITE) |
> > +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> > +	       priv->regs + MDIO_REG_FRAME_CFG_2);
> 
> Shouldn't this wait for the write to complete?
> 

As it is, the write transaction has NOT finished when the function returns,
because there's no call to pic64hpsc_mdio_wait_trigger().

It works because there's a pic64hpsc_mdio_wait_trigger() at the beginning
of ->read() and ->write(), so the completion will be waited for on the next
read or write. I've taken this from mdio-mscc-miim.c.

I don't know if there's any value in waiting for write completion here as
write completion doesn't mean that the effects of the write are available
right now. I also didn't run into any issues in my testing. Let me know if
you know of a use case where this wouldn't work.

I can add a wait for transaction completion if that's expected by phylib.

Thanks,
Charles

> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


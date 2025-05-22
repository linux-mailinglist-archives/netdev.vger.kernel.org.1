Return-Path: <netdev+bounces-192652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781DAC0AD1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D37AF71C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7523E23C;
	Thu, 22 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xGWCn1+/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4723C8D5;
	Thu, 22 May 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914698; cv=none; b=jRDv5HxkQgxFWduFW06bj963pS+VXMAJMe0+nlbN5Lm/GAINHPvYIUgFGbLBKxzwh93OTOaV47P7pAFIwiHWWtm7V9xiVVaN3JKL/hxDp1YQ2tst6MTcKWvvmwMqQHzjdivtajN0XrWETHyrl+4pLjK6d9aOE0o4tTtFYpqdcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914698; c=relaxed/simple;
	bh=0U3v25q4LYmjTERjsFbxxd4cfwi0Qtk29weCjU8YEso=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhdYSOQUK/OHGMad1bhgBour7AC0m3XR1qESEYAvUlwSjbj6aIpfmIv6btYwmNd41NPo7wNZm1AvjyfeCwbIsLPjxbtJ6+RgV/J5Hexfdge0OCw+8tYozvxdZ18bq7mONvMZXHDmb2WzhVM3mccfBBLF5szaaFCZBz/TewixGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xGWCn1+/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747914697; x=1779450697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0U3v25q4LYmjTERjsFbxxd4cfwi0Qtk29weCjU8YEso=;
  b=xGWCn1+/4nQyr6wTEO6uFTH8iu7QEj05gh66dnX9GjeZpUsPuvqS6jO8
   hppMJQoUVk0c4gEAvdq5nRAVFYOtEmvOi9gyWGAZ7vU78yrXWL56PLg8c
   TpD9O69JTXEe71ekRI/awFKYFjDoY2ODVnyLSDM15qqHVALrqly8X6QSX
   kZAmQEIK5cdczTZLeyCgUHK/E5gUxIT+LIGggOTSs8i2sm4HRCus9qvEg
   tUnDjiJib/P1Iqr5fqn2suFTbNclIepeamW2gbvpw6DIqu6KxycNs0118
   PdVibAeZW4qALNV7FZZP94/FII5X8BON5Xg3SeazhEDX7+FiLcSIdDtqp
   g==;
X-CSE-ConnectionGUID: TB3IYo0uQ0aw54PPV9dDGQ==
X-CSE-MsgGUID: stAIOwUBQzSuubJx+5BY8A==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; 
   d="scan'208";a="273317319"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 04:51:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 04:51:05 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 22 May 2025 04:51:05 -0700
Date: Thu, 22 May 2025 13:49:26 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Antoine Tenart <atenart@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<shannon.nelson@amd.com>, <viro@zeniv.linux.org.uk>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: mscc: Fix memory leak when using one step
 timestamping
Message-ID: <20250522114926.oavrusoaqnj6e77q@DEN-DL-M31836.microchip.com>
References: <20250521131114.2719084-1-horatiu.vultur@microchip.com>
 <vmtli7u7fnsj56xhih7eqtzt6w3v4yp7dviyssqyyybvsioznj@lzwdr5dpo5wg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <vmtli7u7fnsj56xhih7eqtzt6w3v4yp7dviyssqyyybvsioznj@lzwdr5dpo5wg>

The 05/21/2025 17:34, Antoine Tenart wrote:

Hi Antoine,

> 
> On Wed, May 21, 2025 at 03:11:14PM +0200, Horatiu Vultur wrote:
> > Fix memory leak when running one-step timestamping. When running
> > one-step sync timestamping, the HW is configured to insert the TX time
> > into the frame, so there is no reason to keep the skb anymore. As in
> > this case the HW will never generate an interrupt to say that the frame
> > was timestamped, then the frame will never released.
> > Fix this by freeing the frame in case of one-step timestamping.
> >
> > Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/phy/mscc/mscc_ptp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> > index ed8fb14a7f215..db8ca1dfd5322 100644
> > --- a/drivers/net/phy/mscc/mscc_ptp.c
> > +++ b/drivers/net/phy/mscc/mscc_ptp.c
> > @@ -1173,6 +1173,13 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
> >               return;
> >       }
> >
> > +     if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
> > +             if (ptp_msg_is_sync(skb, type)) {
> > +                     kfree_skb(skb);
> > +                     return;
> > +             }
> > +     }
> 
> I don't remember everything about TS but I think the above is fine. Also
> while looking at this I saw this function is doing the following too:
> 
>   if (!vsc8531->ptp->configured)
>         return;
> 
> I guess we should free the skb for all paths not putting it in the tx
> queue. As there would be 3 paths freeing the skb + returning, you might
> as well use a label for easier maintenance.

Yes, you are correct we should free the skb also in this case.
I will fix this in the next version.

> 
> Thanks,
> Antoine

-- 
/Horatiu


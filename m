Return-Path: <netdev+bounces-127707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504BB97622E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6282856B7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B918BB8C;
	Thu, 12 Sep 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zCBSqiAS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E027189F2A;
	Thu, 12 Sep 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124917; cv=none; b=NjvsnppGc8pM0UtAAM1ofqN+g00zdDDwKrIDrFF52AgmKQ7TFc3O0dRnQAywWTuiuq8OkKFUHDwKUTqg+Ety8MLk3S5JSeWoLQRxjjoRdF3shsEwQOWIIwkQkfN0MHCmoc+wbd6Y15B17spgQR0/xB6/QXDFiDZ666EVVS4gObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124917; c=relaxed/simple;
	bh=2lyMjLBgvf5VvxewBq2MS4qybxhPAvqiuXnebOHn3OY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7Wj2RuLG8tXYWNOzo9sAHDb6vq4W/GeLPr6JNB/+zwMu8jD93K091YnqPK2oCe7mVRU61QzXgLTIOvc8XoEIHoWpRENwoLF1h6entLmEyAgNUM2bVk6InZpUq7qcjSGlWVi0Bjopxmz4j2u8B+SCOFTW/78YvKfnedw3DX8BRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zCBSqiAS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726124915; x=1757660915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2lyMjLBgvf5VvxewBq2MS4qybxhPAvqiuXnebOHn3OY=;
  b=zCBSqiASXUWFzeXKHPNy51Rv9U5+ON01LOH0MnI4/S2dghUIuxTWYgby
   iBw//JMP5uEPH1fyzz1m2BqhxMyutxdSg9PQ8NJqQnJjab9okPICJPszk
   PxX/a0Pqq5fnmcnBcvBi2NYUfAJ4I+3pbpTGGZG+SVwAQ0WHFnA6wHxuM
   Fe3OfV7x3yDIXmZWx2/qGzACGh/2jbCEZyBKw02Np5avK1VMRu0ANNemJ
   1juQW5gpf81mqekLfgKi3Hi77Fx9tbl/kwnXc+1zB4TOd+NukDgZ06ODv
   ZcSsEu/Xlmzwa6T92nfAwWHGc8XKn3UCtlbrexDTUzM9YQjqNat0S+pSz
   w==;
X-CSE-ConnectionGUID: SJCZriqZRdqmJcJGVLbhmQ==
X-CSE-MsgGUID: qYD1QL15S3qxhUPEiavXyg==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="34836827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 00:08:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 00:07:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 00:07:53 -0700
Date: Thu, 12 Sep 2024 12:34:04 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP
 with 2500Base-X Interface
Message-ID: <ZuKSZEXDXYH9/zjW@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
 <82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>

Hi Andrew,

The 09/11/2024 19:31, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > @@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
> >       lan743x_phy_interface_select(adapter);
> >
> >       switch (adapter->phy_interface) {
> > +     case PHY_INTERFACE_MODE_2500BASEX:
> >       case PHY_INTERFACE_MODE_SGMII:
> >               __set_bit(PHY_INTERFACE_MODE_SGMII,
> >                         adapter->phylink_config.supported_interfaces);
> 
> I _think_ you also need to set the PHY_INTERFACE_MODE_2500BASEX bit in
> phylink_config.supported_interfaces if you actually support it.
> 
It's already add support. Here it's showing only diff changes

> Have you tested an SFP module capable of 2500BASEX?
> 
Yes. I test SFP module (FS's make 2.5G Cu SFP (SFP-2.5G-T))
it's working as expected.

>         Andrew

-- 
Thanks,                                                                         
Raju


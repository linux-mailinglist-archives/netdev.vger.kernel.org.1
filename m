Return-Path: <netdev+bounces-103689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FBB909124
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4D71F27A76
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6319ADA6;
	Fri, 14 Jun 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CJsk7Kao"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B486180A90;
	Fri, 14 Jun 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385162; cv=none; b=dyKfxQgZ/Udo//ppRlpAJd34NGFPfl0pByBpMNMTEQgOfy0wqTY2L/SdOjf/sQI5sJBRcEO2oejrWDpDsUswA3BLGYlzw/aMf9waa/9EmrKt/ZXLMKWsVD3/nd13ANjDkRlWsp5eVg98ccDZLB6loy2lWitO8JR5WP0xL9cQrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385162; c=relaxed/simple;
	bh=eakCW6YgAkEiw4MW/9EqIS0zsBV0/E06SjKsPCQzcY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqTklDu0MryE0jRG5BRSRGSA+5eCA1pD4/Ja9z2uicJH+sXUvzZsm+LvB2BaHoRp9YAeMiGLsdJXWnnE/Bov+gzQfjyKha7bwUP3HhmKNKaBvu1mxlLEJQ5H+KhG8V9aI6JpQkYmzC35S3hRinFiNm/wqVFqUHCNauapYQYWQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CJsk7Kao; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718385159; x=1749921159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eakCW6YgAkEiw4MW/9EqIS0zsBV0/E06SjKsPCQzcY4=;
  b=CJsk7KaozV8VQ6fMHgyegMApEgXSmQL4p4nv9l2Hd1GMNsDp2dv+AmV2
   FHwK+lY4LHLTZBAS+tLv9EID8yCsvwkY13DOvG1A2+2DlFRhVKKl0/Cad
   0IWKjkeUUzRQZp1wUWJpQQM3GiUhQ10xAioaLNdK/1zV0jFkIkMRI/KWA
   JiCIZmegaoDUcvSAFKVF6B9cOndQGB4gFpyhVHsrNwsvLEwOjGQU15l0V
   KoQdfgfEus40mXdiN4CjMWuAOwaaPnzHZvgqj80MU35fs2YjWrA+9QWaQ
   iAMqXYk1hAqEMSS3R6gYePxXMaKh1wwlqHdSHcrThDverR8NObznBu3df
   A==;
X-CSE-ConnectionGUID: 54pHiTd7Rq+dIdALU1AozA==
X-CSE-MsgGUID: 8sS45WrBSgyi0MiQ5uZEQg==
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="194984813"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 10:12:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 10:12:08 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 10:12:07 -0700
Date: Fri, 14 Jun 2024 22:39:21 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <sbauer@blackbox.su>,
	<hmehrtens@maxlinear.com>, <lxu@maxlinear.com>, <hkallweit1@gmail.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V4 1/3] net: lan743x: disable WOL upon resume to
 restore full data path operation
Message-ID: <Zmx5QfQ439XL7H0Q@HYD-DK-UNGSW21.microchip.com>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-2-Raju.Lakkaraju@microchip.com>
 <ZmqjYEs0G9pGQTog@shell.armlinux.org.uk>
 <ZmvHgg5SDYlrO9yB@HYD-DK-UNGSW21.microchip.com>
 <052f32e1-0a6b-4eae-a4d8-727a0d933d7e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <052f32e1-0a6b-4eae-a4d8-727a0d933d7e@lunn.ch>

Hi Andrew,

The 06/14/2024 16:17, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Jun 14, 2024 at 10:00:58AM +0530, Raju Lakkaraju wrote:
> > Hi Russell King,
> >
> > The 06/13/2024 08:44, Russell King (Oracle) wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > On Wed, Jun 12, 2024 at 10:55:37PM +0530, Raju Lakkaraju wrote:
> > > > @@ -3728,6 +3729,30 @@ static int lan743x_pm_resume(struct device *dev)
> > > >               return ret;
> > > >       }
> > > >
> > > > +     ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> > > > +     netif_info(adapter, drv, adapter->netdev,
> > > > +                "Wakeup source : 0x%08X\n", ret);
> > >
> > > Does this need to be printed at info level, or is it a debug message?
> >
> > Print at info level helps the tester/sqa team to identify the root cause of
> > the wake and confirm the test cases.
> > In general, tester does not enable debug level messages for testing.
> >
> > Still, if we need to change from info to debug, i can change.
> > Please let me know.
> 
> We are not really writing a kernel for the tester/SQA team, but the
> end users. Do the end users find this log message useful? Can they
> decode some hex value into something meaningful?
> 

Yes. You are correct. We are writing code for end users.

But, our chip support different wake options which are testing by SQA team to
make sure all the options should work as per specifications and the output
respective input.
This message is not new and move from bottom.

As per Linux community review comment, I will move from "info" to "debug" in my
next patch series.

> I'm surprised the test case cares what caused the wakeup. So long as
> it does wake up, does it really matter what the source was?
> 
>         Andrew

-- 
Thanks,                                                                         
Raju


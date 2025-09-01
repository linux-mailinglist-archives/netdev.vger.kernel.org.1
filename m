Return-Path: <netdev+bounces-218614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB5B3D9C3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82EC3B763B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12129246770;
	Mon,  1 Sep 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eIoyUcYt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590218EB0;
	Mon,  1 Sep 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707636; cv=none; b=Jvvay8U2+fmKT3ZNtg3VQl6aWtMZCcR4hBYk+d1h4r+IUlsy+BkVcaMuvox0t1AILC3dqHBM8fjLnnZPpyWNOUIOTgsZt6wZdlUaK4C/mcJ1oykz5jW/xnW6cVdHhkMrS4TCYOu18UO6LfaUaV/K1zPaBOlyiH2My3TmXC0fEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707636; c=relaxed/simple;
	bh=FYMe2bEyQnHgG7oiRFnq7nlgkYuj3AThOUClM2uvShE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfl3h7DXZjPHYhNoUZ0br9MBINNw2A1MXNBVr9zoYj7YFZDpjg41pDPdoeU64t3ltjF4Wqq4LW0bbtvqxSoLFL0GDvKup8iljyuZv5nTI9TfSBQMs03wy5BtIoZESL/ISqSrWav7YTtf8N0Z8jrvJ/9C0qiqRjnmWni8uNnvjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eIoyUcYt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756707634; x=1788243634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FYMe2bEyQnHgG7oiRFnq7nlgkYuj3AThOUClM2uvShE=;
  b=eIoyUcYtF2dUHFbcsbmiAaLBy24/Hl5zemgMm4nJg99bXtl6zt0e2u9A
   e6ABPo2hTcislw7H1SjIEB1vrCPuX4MAagzOLHFCJwY82DIm9SQqY/A0L
   jy2nyXqBg5XdVvKo5xtIHMz6tmZdO5hGPsjl+NFDP4rg/WOi+gg39Q93j
   CUl/AS4CtTmo74Xf0njZFgc3ByeZDjNqPayjDEEnuFIcww6SEdm1arB5r
   dmS2rY+P4CNP7nyepiHLbsAy2Uns6Iu45ezBEacGVP3rnbEExWGB/hyYm
   F01cGJsXwlCeZh1xUJHtOFNDUJIf2VfZTwMjmd1slp8g7i2fRlE/6WKAj
   w==;
X-CSE-ConnectionGUID: XhbRIGuUQGKz55BN2RxhtQ==
X-CSE-MsgGUID: M1AGaSGDRY20lkXyt/N5RQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="45874794"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2025 23:20:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 31 Aug 2025 23:20:08 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 31 Aug 2025 23:20:08 -0700
Date: Mon, 1 Sep 2025 08:16:30 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/2] net: phy: micrel: Introduce function
 __lan8814_ptp_probe_once
Message-ID: <20250901061630.rddeuz7yclmxl6w3@DEN-DL-M31836.microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
 <20250829134836.1024588-2-horatiu.vultur@microchip.com>
 <20250829163341.17712e59@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829163341.17712e59@kmaincent-XPS-13-7390>

The 08/29/2025 16:33, Kory Maincent wrote:
> 
> On Fri, 29 Aug 2025 15:48:35 +0200
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > Introduce the function __lan8814_ptp_probe_once as this function will be
> > used also by lan8842 driver. This change doesn't have any functional
> > changes.
> 
> It would have been nice to add the fact that the lan8842 has a different number
> GPIO in the commit message. It would have explained more the why.

Yes, I will update this in the next version.
Thanks.

> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!
> 
> --
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

-- 
/Horatiu


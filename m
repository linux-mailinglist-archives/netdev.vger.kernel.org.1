Return-Path: <netdev+bounces-231091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE04BF4C14
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 067B34E7799
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2726CE2E;
	Tue, 21 Oct 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I2fTwOx7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BCE2690D9;
	Tue, 21 Oct 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029589; cv=none; b=qFiu7Aeo9t7W2OV8FJSWMT9SDW1PB3isfNU6YsXmqNH935qTnUihxOZiFJ94vBZtx2H46em6UKVK52vzHPLfNtsEZJgx1lHCgzAaFZ3JaRIbYLbEXMevM3k+JdAF+taWR4hkGBo+ZLQmQ5q/oKWx9kXC5Ii2lBKDBVQWNqtKCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029589; c=relaxed/simple;
	bh=dT8D/fqK+qeM68iYwPgxwXnSgIs00YnR13VuAf2aYRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf6461J4RXzBm4OaOm0NK29+0yboNtQzeBzMM83UqC9BtLNpzcmv0LKRw/f6XSERCQ/dCBKvJqxuLEQApKENbnl+Isqv97oV0E2piznSz9IrpUTx+7rjIhNQZkWQM44TglNzNoBKPBa2ckglsT9i6axbx6gy409JE2RZzK62ZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I2fTwOx7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761029587; x=1792565587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dT8D/fqK+qeM68iYwPgxwXnSgIs00YnR13VuAf2aYRE=;
  b=I2fTwOx7famewtsKIVmrHCSKzeQscUbwE9YH/XXjJSmDKEUfVe9jCVJr
   0AISxbOIOKN00rrJJCVAtbRiacJ1soX+oUnmeg0nvnTdMP39uc3fHTi1O
   DLJTKTt1ALdgnl+EV/ebTmMth1BBddFt54qPKjXB1B3SHBN44sfZDFFeA
   949BeTs58VUFNVLu16fJFVRligenoCgY42XTEiNnEyEsOgrlunMCPmFlG
   6kdrN/s2bEkHKutY2HRhglXbtN4DRT4cLHRCS+mOiz2UgihYZmT/VzW50
   3wvAiudYsQv7C/1HHnjUcPB5qtuEGLhUp7XqlDLWED0c9LRPtiDkL46/j
   w==;
X-CSE-ConnectionGUID: Ss1WuPpDSteYpQ34q4x20g==
X-CSE-MsgGUID: r+VN4XBDRoWsZ/dRb4olEw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="215391938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 23:53:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 20 Oct 2025 23:52:57 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 20 Oct 2025 23:52:57 -0700
Date: Tue, 21 Oct 2025 08:51:51 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
Message-ID: <20251021065151.a3q45iihtmm52rgg@DEN-DL-M31836.microchip.com>
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
 <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
 <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
 <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>

The 10/20/2025 20:11, Gerhard Engleder wrote:
> 
> On 20.10.25 08:39, Horatiu Vultur wrote:
> > The 10/17/2025 23:15, Gerhard Engleder wrote:
> 
> ...
> 
> > > > 
> > > > +/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
> > > > + * some of them support PTP while others don't support it. This function will
> > > > + * return true is the sku supports it, otherwise will return false.
> > > > + */
> > > 
> > > Hasn't net also switched to the common kernel multiline comment style
> > > starting with an empty line?
> > 
> > I am not sure because I can see some previous commits where people used
> > the same comment style:
> > e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
> > 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
> 
> The special coding style for multi line comments for net and drivers/net
> has been removed with
> 82b8000c28 ("net: drop special comment style")
> 
> But I checked a few mails on the list and also found the old style in
> new patches.

Ah...OK. I prefer to keep the current style here.

> 
> Gerhard
> 

-- 
/Horatiu


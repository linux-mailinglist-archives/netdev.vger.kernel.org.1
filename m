Return-Path: <netdev+bounces-223386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D55B58F52
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71113AC896
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5F2E9EAE;
	Tue, 16 Sep 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z0Vpu0eb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8E2E9748;
	Tue, 16 Sep 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008317; cv=none; b=HcYfiPlIhk3bb9zvg5xN/tr5movOda5fAgM8Z6iq7jrq818E0AtuAjOmTUKjYZN1yGHgxlro3kHOzAf5Uritm1C13H0u6BpxX4TjWjzmHlGIb4O48Z5HGeoIUeDGULr3dkEhLXHBfq8W1d/HUEzPvm95y6ZkGbwoOTdJg1tOgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008317; c=relaxed/simple;
	bh=6hkL4CWqr5+YDd9Ncdh8bvXQbjUgV4NXSfCuyYYiZQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVr8eDgv1/gu1v2mqsgs4BGbcayqb2azTxE5ETx9taioOQpftiB+VcHINz3nCuhh3aJwaUIHtgxrAXTdy4EIriALQBMEun0SEyhvrljO0Ovm6IOosHJIyVRuzkM1Nqfj+LLZqjvnla8rzEsDUNpweEiiyhx+ULTI1RyWYO8SBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z0Vpu0eb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758008316; x=1789544316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6hkL4CWqr5+YDd9Ncdh8bvXQbjUgV4NXSfCuyYYiZQs=;
  b=Z0Vpu0ebMAYzQOHcBi/d1262DJu27nwX4/st63kfSYGomR2hpYQRg/WK
   8cGtfPRdO70rk5JPWj7fhlT7BKLphAkKcQr8BENCnZxiKRZXcpHXUgOAL
   RLORXA21MwNFSiBJnMBLaXQKRa0k1B/4TpgFnabUyXSy6XS+szROhqw6J
   ZaDn1r6TP2GxmqLZxVuNxzAHQEFOpyy4/1PQ4oGLoGkqDTKfe+YCthnJ3
   rCBAgz1UXH9+ITImJ4w44Bvtirs/FbGD2r9MQigg9m6cx7Ji+lJzraV1C
   649QD6DKfq6N8EK3YZrFxWDlfP3pa1CvzSMV8rhRQudM0zgA28pRBYd1b
   A==;
X-CSE-ConnectionGUID: uu6TxwMOSQ2ZIPOgQXRKkQ==
X-CSE-MsgGUID: JNefeZIjTuCYPDDHdVIw2A==
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="277928877"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 00:38:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 00:38:23 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 00:38:23 -0700
Date: Tue, 16 Sep 2025 09:34:27 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <20250916073427.xohv2cywonkfzp5k@DEN-DL-M31836.microchip.com>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
 <698d4fbe-a84b-40cd-986f-1ebaecbf60b1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <698d4fbe-a84b-40cd-986f-1ebaecbf60b1@lunn.ch>

The 09/15/2025 14:42, Andrew Lunn wrote:

Hi Andrew,

> 
> > +/**
> > + * LAN8814_PAGE_PCS - Selects Extended Page 0.
> > + *
> > + * This page appaers to control the fast link failure and there are different
> 
> appears.

Good catch.

> 
> And just curious. Why appears? Don't you have access to the data sheet?

I have access to datasheet. It is public here:
https://www.microchip.com/en-us/product/lan8842#Documentation

The problem is that now the register are described in a different
document and this one is not yet public. I have asked and they are
working to publish also this one but I can't say if it takes a day or a
month.

And the reason why I say it 'appears' is because I have seen most of the
registers are for debug and some timers.

> 
>         Andrew

-- 
/Horatiu


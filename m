Return-Path: <netdev+bounces-223876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFAB8064F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF30D7B26D6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510052BDC3B;
	Wed, 17 Sep 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QliMOZ+A"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03A2D781E;
	Wed, 17 Sep 2025 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092976; cv=none; b=jDz0A+0YUAsG77suWOkysje46nSHyHRSwuSqrlPbP9u/4kJTDIof65gI2Q7v2lmOKAR/WbeGgEZua5y39q76XehAqML7ww0476db86e6l7/zHU0BscqB39GQmsnLB3b5qr2quRSLuCrenzI7fcgwLNIzgfbxXS+Vykg56TWNs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092976; c=relaxed/simple;
	bh=nMiL6Us8jF/5NVrU3nbcvoZY44eWUfuFxF0JqFTgPNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5ODMWOIn17IUWpgPt6eQPWDnQSoPlS7fG6uu4hF5NclDpR69rFrDuwHo4kvyEhUgXiKWOH7WK0sN6AbBLfuvdtfKZfvSA8vbL21z6iqT4pV7Nr5FWIId0e2RSu00JNxT4XV87Kqlbljp63bIRx3o3b9B4DalaZ/CL9RdywrLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QliMOZ+A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758092974; x=1789628974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMiL6Us8jF/5NVrU3nbcvoZY44eWUfuFxF0JqFTgPNk=;
  b=QliMOZ+AOlriiKQ5/oPRO/1QtMEssfslfzee1sNTbPBoK1AK8vXQIJZv
   IMDXtsUya01B3lcaY7BOVMXB0ZYNOGEY+Rc4YRT/6O2DC9DsUNJ8mndiO
   9X7qY+sSeuk2QYNg7war4Xew80ippmwrtJmu1C7o+Xr9r7o0XgCyiulJ8
   cbdZ3UbiPfFlYqgooeE30/mWG/2jI6+X+RDaRo81uyJWfYTMHlK/cCQnl
   6ysrdHUXIk0GUZPv9d7jYhnpzC24iMbw1CcvqngpE+arEskWF+TIEN7PZ
   oYW/Y8BGEpVI38KyAan11o8Ux+EC/NoDEoa6LLvCl8jXp505jUvR7Yoh4
   w==;
X-CSE-ConnectionGUID: LbPGE0rbRfKlE3mQvAcwsA==
X-CSE-MsgGUID: ZFyuMrmYR7Sw165WoWhATA==
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="46029004"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 00:09:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 00:09:14 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 17 Sep 2025 00:09:13 -0700
Date: Wed, 17 Sep 2025 09:05:16 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <20250917070516.a5pykok2e6xfjyao@DEN-DL-M31836.microchip.com>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
 <698d4fbe-a84b-40cd-986f-1ebaecbf60b1@lunn.ch>
 <20250916073427.xohv2cywonkfzp5k@DEN-DL-M31836.microchip.com>
 <d0839c6b-1a6a-4043-bdaf-b0f572b26792@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d0839c6b-1a6a-4043-bdaf-b0f572b26792@lunn.ch>

The 09/16/2025 14:53, Andrew Lunn wrote:
> 
> On Tue, Sep 16, 2025 at 09:34:27AM +0200, Horatiu Vultur wrote:
> > The 09/15/2025 14:42, Andrew Lunn wrote:
> >
> > Hi Andrew,
> >
> > >
> > > > +/**
> > > > + * LAN8814_PAGE_PCS - Selects Extended Page 0.
> > > > + *
> > > > + * This page appaers to control the fast link failure and there are different
> 
> > And the reason why I say it 'appears' is because I have seen most of the
> > registers are for debug and some timers.
> 
> So maybe change the comment to
> 
>         This page contains timers and debug registers...
> 
> It does not matter if the document is public or not, the description
> is then correct and does not give the suggestion it is guesswork.

Yes, I will change this in the next version.

> 
>         Andrew

-- 
/Horatiu


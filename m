Return-Path: <netdev+bounces-216389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F5B3364D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB01200946
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DBA27F195;
	Mon, 25 Aug 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iaIVBKDP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3427F017;
	Mon, 25 Aug 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102714; cv=none; b=mrDzUeDBkBirOCPe3AfWXN8N9STZFa7zroeWQFekaLz+z6B54wX7z06CsncGuPZsUOq08j7vdpk4px4oPKOTU+GAKb9soquC5bvXVjAWfXeFK2TlI8IIlijJa7il5aP3lag4V6Wy8FJuQwtXbZBXXK++KQuDnlXJCzK2Smc5BqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102714; c=relaxed/simple;
	bh=HsBdTZhYbyhF+EndnLNoFlI4mM0RdTNWPULgcRPZw80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b77EBqqZAo8N342Tz+KEq9jpWEBs3dW5T6CoJy0wKABGO1H8V93TQgMtBCpPHLaqmGJVIyfrVHIAwAGIB65sPvue8/NP5u4PWmzC3yIZ4t785KEiWXaEs0BAfKuUp2F8bdqwPfvUbxMNtVan/jgcBE6W1Lxn47USDr3wS5rDDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iaIVBKDP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756102713; x=1787638713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsBdTZhYbyhF+EndnLNoFlI4mM0RdTNWPULgcRPZw80=;
  b=iaIVBKDPWrTaLrM9ARiAqoOMkrNxOOPHJpKvvE9TcpYzx3s2apravtFn
   FlfS/O6d+K6yW4TW0IkiC1j9YFK4hcXEoiHG53zK6lJ9Y56N/w3aToMmR
   aIzJTFb/bJwsARbOkL/8AJEVSjrWrK7DzNUnDTHu/ObYoPy6m6CP9/4fn
   IwWMby/QiVWn4AID4nt6BXf49TtC5Bn1CxDu6aNOvSm76XohEoE4XnSfq
   MkWEWvjlJOzDrOBWRFEcfi6zg7Xd0AOJKrjJcrKSBW404IkhOhbPLmYrQ
   KU1cp811r0/etxulTNb8g7JAcXegRafdFllyIbQ9nzGQhtyi5Zz6HM8tg
   g==;
X-CSE-ConnectionGUID: 7krTIVdARziqaZsCa7v5xw==
X-CSE-MsgGUID: CL5H24d9SrasyQs7RF7Pkw==
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="46175534"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2025 23:18:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 24 Aug 2025 23:17:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 24 Aug 2025 23:17:54 -0700
Date: Mon, 25 Aug 2025 08:14:24 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<vladimir.oltean@nxp.com>, <rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<atenart@kernel.org>, <quentin.schulz@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] phy: mscc: Fix when PTP clock is register and
 unregister
Message-ID: <20250825061424.zme43qi7hnyqa7rs@DEN-DL-M31836.microchip.com>
References: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
 <3f8cef10-fbfd-42b7-8ab7-f15d46938eb3@linux.dev>
 <20250822062726.cv7bdoorf6c4wkvt@DEN-DL-M31836.microchip.com>
 <20250822155834.57c7438d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250822155834.57c7438d@kernel.org>

The 08/22/2025 15:58, Jakub Kicinski wrote:
> 
> On Fri, 22 Aug 2025 08:27:26 +0200 Horatiu Vultur wrote:
> > > > +void vsc8584_ptp_deinit(struct phy_device *phydev)
> > > > +{
> > > > +     switch (phydev->phy_id & phydev->drv->phy_id_mask) {
> > > > +     case PHY_ID_VSC8572:
> > > > +     case PHY_ID_VSC8574:
> > > > +     case PHY_ID_VSC8575:
> > > > +     case PHY_ID_VSC8582:
> > > > +     case PHY_ID_VSC8584:
> > > > +             return __vsc8584_deinit_ptp(phydev);
> > >
> > > void function has no return value. as well as it shouldn't return
> > > anything. I'm not quite sure why do you need __vsc8584_deinit_ptp()
> > > at all, I think everything can be coded inside vsc8584_ptp_deinit()
> >
> > I understand, I can update not to return anything.
> 
> It does look a little unnecessary.
> 
> > Regarding __vsc8584_deinit_ptp, I have created that function just to be
> > similar with the __vsc8584_init_ptp.
> 
> Alternatively you could only deinit if the clock pointer is valid,
> regardless of chip id. Unclear which one is the cleanest form, TBH.

I will update in the next version to check if the
vsc8531->ptp->ptp_clock is valid and in that case call
ptp_clock_unregister and skb_queue_purge.


-- 
/Horatiu


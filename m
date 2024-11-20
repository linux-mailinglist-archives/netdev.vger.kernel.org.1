Return-Path: <netdev+bounces-146474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11C9D391D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D96B2AA0C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4E1A255A;
	Wed, 20 Nov 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fc37Z/7J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D91A00FA;
	Wed, 20 Nov 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100297; cv=none; b=UMaG5UxMLdBbPykBVasfTIlcc1CazLBfYo197b+EGPVU2+hk6yBpSSC4lWFoCl39c8XnH1R+9CB8IQkw9QZiB8StTCLFxAe0jv8EnINynuJgu0jCmh+cITMDnxXQqKuTKUxDPaN8uwV8lHucsO+8RWt4BFKwdcx9VzmxJGjAioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100297; c=relaxed/simple;
	bh=7zHVbE3RTdvozr56Vt0hiaPEg1DTrOhKqhHM3zAKh1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT7gTqMoH77JoXeZjWaHlZvZmPhD1yMuiN0yvmoCb8bTYN0j6MDuUJe2X2EVj6iO/Znlzu67wBBLZ3LRtc3fW3ro3qHgH52yg2ZpKEXgOIrMaYF255aowryP8yXGy25NPxnx4iHRkiVheQZkPGetiN5nGUQRh/dfa1BIJm49N1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fc37Z/7J; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732100296; x=1763636296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7zHVbE3RTdvozr56Vt0hiaPEg1DTrOhKqhHM3zAKh1c=;
  b=Fc37Z/7JWLv2XClCZA2tY8RFlRgW/oaB+ZMT5ShMb/SirC9PDreccpj0
   LWFSZoX7bTeyhIQwtdjlcQ8/oCLLOanspixrc+HrHRlu+ujHRMO97GOGX
   6eXHlVNTAQeCHI2a0zSjMyahZgDR2GEd0vXY/5GaKBnKG3ps/jfB8YGC0
   o4XUdBAE6XxCGwZfXWK6aJBevWd7tN+yNztJpQiQTy7sW9riicSO4RoeO
   101csuhSfcueXbXlwjKjySSZpGCg/8aqyb+i4a4h/x/NTIGR4x94iBXe5
   dChffMO2YovRHpiEjBh0XyyGBjg6O7iFleo8scTO8WsDBi0JH02XT+i9A
   A==;
X-CSE-ConnectionGUID: lSn+5QYEQsKTrQdRtaFjuA==
X-CSE-MsgGUID: 72+GzUJ4Rx+eWsYYc4nfOw==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="35058070"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 03:58:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 03:57:44 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Nov 2024 03:57:41 -0700
Date: Wed, 20 Nov 2024 10:57:41 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <jacob.e.keller@intel.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 4/8] net: sparx5: use
 phy_interface_mode_is_rgmii()
Message-ID: <20241120105741.bivv5yvsetic55x4@DEN-DL-M70577>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
 <20241118-sparx5-lan969x-switch-driver-4-v3-4-3cefee5e7e3a@microchip.com>
 <ZzzwNci1cHqsfHm4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZzzwNci1cHqsfHm4@shell.armlinux.org.uk>

> Hi,
> 
> On Mon, Nov 18, 2024 at 02:00:50PM +0100, Daniel Machon wrote:
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> > index f8562c1a894d..cb55e05e5611 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> > @@ -32,6 +32,9 @@ sparx5_phylink_mac_select_pcs(struct phylink_config *config,
> >  {
> >       struct sparx5_port *port = netdev_priv(to_net_dev(config->dev));
> >
> > +     if (phy_interface_mode_is_rgmii(interface))
> > +             return NULL;
> > +
> >       return &port->phylink_pcs;
> 
> Maybe turn this into positive logic - return the PCS only when the
> interface mode requires the PCS?

Sure. I can flip the logic and return the PCS for the interface modes that are
advertised as supported.

/Daniel 



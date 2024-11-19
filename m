Return-Path: <netdev+bounces-146223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCBF9D2517
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA92328103C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678921C9EC6;
	Tue, 19 Nov 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ATJ61zkg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3061C4A24;
	Tue, 19 Nov 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016631; cv=none; b=f0nZ7DtDt5vgzWSTbEEUmfmtzhAqDBj3IDZQb5QQRxgksKfEZo217ltfOmIiJOolFj6dKACw4JvHaHmPu9RmhkwMwXRPRxygeMItgn5L5exB5QyrCnin/mq31vOrBpCjpI7l1wargRYp8edeDmqkurzj1UgjJXJj1FK4z/o12aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016631; c=relaxed/simple;
	bh=oqBZU2s9GX4I4okgxGMVB9lX+KBfjQKxbdgLLlfDkEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfEzQCstukaZ8JsS7jQ31edsMUkpI8AMbIqdYfr32jEsY5hm1IBfXXMpUV03ThSCY8wan9wxS0yX1Qz1Qv64UqJPZ/j+9kG17sZk1XUX6NYpkV9EVFDfZxca8FoaUb5v+e8lXiSOCHa7VYGmoPklbOqXZLOchaITHQaoM4UEPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ATJ61zkg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732016629; x=1763552629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqBZU2s9GX4I4okgxGMVB9lX+KBfjQKxbdgLLlfDkEU=;
  b=ATJ61zkgdQRSfG0Hz11zLx9lsIngR5OIibeUHBs4DMzN75QHDUJcDZdd
   AkgevlOIhY5ntgewQuXyXfucsJp97yQTmGIVR8bkJd0xM2JTka/L+UeEF
   G+HxuIngnlnlKvf5/TFM2V3zqCBz0Ks1SqIbRFGx1X47XQN+Sz3xXFgp0
   YUbSNua44RCP1wh+pyJcXDUAU/FFf5fy0ImkcUWEBLvB35BCS125Fx6JE
   1gO4ZsFbFdbMYzK4fHiFY9uHeGgdYiixRiUgQRqau3bbHuSgW018V+Q8k
   Ko1BX7FJNfIyZR8BHNfnvwn9c1l7fThGHkqc38aXutzq9TVa/+2FQOOGT
   Q==;
X-CSE-ConnectionGUID: BWklstq0SNCOj2gcHvaF3Q==
X-CSE-MsgGUID: 05g4JmwuT3OCtZoW+/CaAw==
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="34225248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 04:43:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 04:43:08 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 19 Nov 2024 04:43:05 -0700
Date: Tue, 19 Nov 2024 11:43:04 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <20241119114304.u47srawc2t6ymvf6@DEN-DL-M70577>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
 <29ddbe38-3aac-4518-b9f3-4d228de08360@lunn.ch>
 <20241115092237.gzpat4x6kjipb2x7@DEN-DL-M70577>
 <5b9d79f1-ccdd-47c3-a02a-5ff0b12c1fb8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b9d79f1-ccdd-47c3-a02a-5ff0b12c1fb8@lunn.ch>

> > Hi Andrew,
> >
> > > > The lan969x switch device supports two RGMII port interfaces that can be
> > > > configured for MAC level rx and tx delays.
> > > >
> > > > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > > > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > > > rgmii-rxid or rgmii-txid. Also specify accepted values.
> > >
> > > This is unusual if you look at other uses of {rt}x-internal-delay-ps.
> > > It is generally an optional parameter, and states it defaults to 0 if
> > > missing, and is ignored by the driver if phy-mode is not an rgmii
> > > variant.
> >
> > Is unusual bad? :-)
> 
> Depends. Having a uniform usage is good, it causes less confusion. But
> strict enforcement also has its plus side.
> 
> > I thought that requiring the properties would make
> > misconfigurations (mismatching phy-modes and MAC delays) more obvious,
> > as you were forced to specify exactly what combination you want in the
> > DT.  Maybe not. I can change it,  no problem.
> 
> Do these ports only support RGMII? The general pattern is that ports
> supporting RGMII also support other modes, GMII, MII, rev-GMII,
> rev-MII etc. For these other modes RGMII delays are meaningless. The
> general pattern is that they are allowed in DT, but are just ignored.

RGMII and RMII.

> 
> If the LAN969x ports only support RGMII, and you are enforcing the
> four RGMII modes in DT, you could also enforce the delays are present
> and only have all allowed values. But i would not have the enforcement
> any more strict than the other ports. Do you enforce the phy-modes for
> the ports with a PCS?

No, we do not enforce that in the DT. For the PCS ports, you can specify
whatever phy-mode in the DT, and if that phy-mode is not advertised in
the driver, it will just be rejected.

I decided to go ahead with v3 (which needs to be reposted when net-next
opens), where the properties are not required.

> 
>         Andrew

Thanks for your feedback.

/Daniel


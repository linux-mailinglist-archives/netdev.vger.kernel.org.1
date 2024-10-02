Return-Path: <netdev+bounces-131139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9398CE08
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8ECB226A0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F46194123;
	Wed,  2 Oct 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SB2+H/aU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B511940BE;
	Wed,  2 Oct 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855308; cv=none; b=UlP+RtF3mxMulrlyZMUEU5vwbqsR8bS4FadxRDSs/KLpplEaij1oxuu/pATZ3d4PlHN89hEKXc434TQr0BkK2H1YviWvnNt0cjE1LfIVIOabkO/CdkJiT4m0QWk4cq8jwpHeS+YSOhDnuVDS+KVkvXk0xYfA3a92ypPmvWzwcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855308; c=relaxed/simple;
	bh=yjQbS4juwZPhWck9Qu/CXpBh5RJpxCF34+6/JYPUVGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY4WsjRfb5jov3M5C4Htt3xCVjX8aPcI8cF+osChE3bZzzk1e11YgWGinpQfbbEdMGKR86Wq8MhgiLGNRETdUKADHDeAbMFhbJn8VrNFbuS9BgcyhmDx6g7D2SDQXNVURDKR2N7eKjmKFQUaYBSCNm3CtbL4Jukevv3xsCvs+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SB2+H/aU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727855306; x=1759391306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjQbS4juwZPhWck9Qu/CXpBh5RJpxCF34+6/JYPUVGs=;
  b=SB2+H/aUhtJxJqDCo2BS3PCTTLL/0JDaUOw1Kt5QmSePOumldqyrV0lO
   qiwakYv1gx+d0UNwQ34WrPMoI+7ZJq+WlBlwA/Z2/MQ0a8zIxuYMAI4UO
   a+ZbAff550+w6FKkuJXIb10w+4K0/BwaE9eFdePZAlSEMzY1s5lG8vD3Y
   tjhV5W0V6600AyW/+mtbr6m84wToVGvwLqqKg8egPfs0UjYnkZ6M4fRt6
   iWoa697iC8OdI0X0osz5415CQfL5piGSFvxPXklEzHGy7d3NYc+1N9+dP
   BZX5+5WAvKJLyFDoACjB4BYadfudXnILSQOBbixKDPOsTCLTycLx3rX7l
   g==;
X-CSE-ConnectionGUID: ur9xYuViQOazsezB14XXWQ==
X-CSE-MsgGUID: F2F+WxPPTHC7dIcE4idn5Q==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="199937223"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 00:48:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 00:48:08 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 00:48:05 -0700
Date: Wed, 2 Oct 2024 07:48:05 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 10/15] net: sparx5: ops out chip port to device
 index/bit functions
Message-ID: <20241002074805.fcacici2omuimcgd@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-10-8c6896fdce66@microchip.com>
 <d3964902-ac02-4fac-a0e8-f820fe56eed1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3964902-ac02-4fac-a0e8-f820fe56eed1@intel.com>

> > The chip port device index and mode bit can be obtained using the port
> > number.  However the mapping of port number to chip device index and
> > mode bit differs on Sparx5 and lan969x. Therefore ops out the function.
> >
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
> >  drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
> >  drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 +++-
> >  drivers/net/ethernet/microchip/sparx5/sparx5_port.h | 7 ++++++-
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > index 8b1033c49cfe..8617fc3983cc 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > @@ -982,6 +982,8 @@ static const struct sparx5_ops sparx5_ops = {
> >       .is_port_5g              = &sparx5_port_is_5g,
> >       .is_port_10g             = &sparx5_port_is_10g,
> >       .is_port_25g             = &sparx5_port_is_25g,
> > +     .get_port_dev_index      = &sparx5_port_dev_mapping,
> > +     .get_port_dev_bit        = &sparx5_port_dev_mapping,
> 
> So for sparx5, these are identical operations, but for lan969x these
> will be different? Ok.
>

Exactly :-)

/Daniel


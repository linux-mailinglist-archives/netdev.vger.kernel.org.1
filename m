Return-Path: <netdev+bounces-137858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609539AA1E5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134B6282B2A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AA19F462;
	Tue, 22 Oct 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hjYwuD6c"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C499199938;
	Tue, 22 Oct 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598955; cv=none; b=rncSKePN+pfw5wvCrfapK5Z1iDnXQRq9jnIo7HAhyoFelZtFKZmYyTfsUl0o7WIf6Sm5FS5yjTP9lXrzg0l4HGtTYmcPZuN/GaxUSBMM/zL0OHbXbcBSjH1tTOy/CEujoWnb0NdIvDIYilHLFOCcdU69AjwZyQTSTKXkEs+Rwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598955; c=relaxed/simple;
	bh=GCAlh70HIIrX7QW1ylG+a51tvpUD9YM+ryk+RDixp4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0cmk+u2aDLT7Do6xSERKDWhq8kViiFQzCD3QRYx/hLEDYH9D/JWRua+phSlbOwLp8Aqet49e1g4SBpG8Vdm3mWzs9TSFuM3FM4W/QMCHP1K+jfTuSHqnby+hIlpwEfJFlsW3UC8JbkY8DqUSeZE17cFDzMI0jDlxLFkx73hoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hjYwuD6c; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729598953; x=1761134953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCAlh70HIIrX7QW1ylG+a51tvpUD9YM+ryk+RDixp4w=;
  b=hjYwuD6c8oEvcgvSFrzV2/kTzdR74NnnhtKYUFV7WUQwuGDeUqcRPljo
   b0dNuxX2HkuQvoZTeeSjSH1xYJ+syO3itZTiyyAiuNSwIxg8gKdhlkrBU
   4djPFMMxiB17Si8XpxBoyLP+AHDf6cUis0+tJY/h3pZj6v0AS3vtW+DRh
   alFDEoDNgGR4/NNPO7UyEGEUideUyYvFIRpAJQl8Yw8OHS7RuU7dAtNHu
   oVUzOIjyAYPI+ciQNonxnBLBCL3LW73OUMQEhG6zNaojhCp4qW3qvAmFN
   adxkdeJ+J+lQtFDVGXAfCebVWE6l9sS57qT9oXQ2KLBTGSNF3Ta+WWGr+
   w==;
X-CSE-ConnectionGUID: 5z4sXM/ESmCyIGzt5yX2Zw==
X-CSE-MsgGUID: YhWYqzeMTBaRk2u3gZSxrg==
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33105701"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2024 05:09:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 22 Oct 2024 05:08:47 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 22 Oct 2024 05:08:43 -0700
Date: Tue, 22 Oct 2024 12:08:42 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <20241022120842.uf575qwaulufjyv6@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
 <20241022085050.GQ402847@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241022085050.GQ402847@kernel.org>

Hi Simon,

> > Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
> > that we support, and verify that the devicetree target is supported by
> > the chip target.
> >
> > Each SKU supports different bandwidths and features (see [1] for
> > details). We want to be able to run a SKU with a lower bandwidth and/or
> > feature set, than what is supported by the actual chip. In order to
> > accomplish this we:
> >
> >     - add new field sparx5->target_dt that reflects the target from the
> >       devicetree (compatible string).
> >
> >     - compare the devicetree target with the actual chip target. If the
> >       bandwidth and features provided by the devicetree target is
> >       supported by the chip, we approve - otherwise reject.
> >
> >     - set the core clock and features based on the devicetree target
> >
> > [1] https://www.microchip.com/en-us/product/lan9698
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
> >  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
> >  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
> >  3 files changed, 193 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> > index 3435ca86dd70..8fe302415563 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> > +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> > @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
> >  # Provide include files
> >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
> >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
> > +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > index 5c986c373b3e..edbe639d98c5 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/types.h>
> >  #include <linux/reset.h>
> >
> > +#include "lan969x.h" /* lan969x_desc */
> > +
> 
> Hi Daniel,
> 
> Perhaps this will change when Krzysztof's comment elsewhere in this thread
> is addressed. But as it stands the construction in the above two hunks
> appears to cause a build failure.
> 
>   CC      drivers/net/ethernet/microchip/sparx5/sparx5_main.o
> In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.c:27:
> ./drivers/net/ethernet/microchip/lan969x/lan969x.h:10:10: fatal error: sparx5_main.h: No such file or directory
>    10 | #include "sparx5_main.h"
>       |          ^~~~~~~~~~~~~~~
> 
> My preference would be to move away from adding -I directives and, rather,
> use relative includes as is common practice in Networking drivers (at least).
> 
> ...
> 
> --
> pw-bot: changes-requested

I didn't see this build failure when I ran my tests, nor did the NIPA
tests reveal it. I can only reproduce it if I point to the microchip
subdir when building - but maybe that's what you did too?

Anyway, I will skip the -I includes and resort to relative includes, as
per your request. Thanks.

/Daniel



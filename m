Return-Path: <netdev+bounces-131138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9E98CE05
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E03C2849D9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763FD18E373;
	Wed,  2 Oct 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p7TGzV1N"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9911C6B8;
	Wed,  2 Oct 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855275; cv=none; b=iFhmxzU+MWT2sq3C5C893J/OOIc17Ob3tCTOh74O241OvDRa6dmvAOL5UW2+CR8g4rwNlInthjjYyv+RMasPyJCi68u0RvigidKnAHZIIiFsTOoDGYi35KlvcTqFaEI1KonPIxCh2DxLUnEIsklQJBeBKI3pWQWJOuYSil+XNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855275; c=relaxed/simple;
	bh=z0MT3UsYNgbdvoBZaDU1qGk7LBG6sR5i0JyVabGx2pI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K93sGEsbB7DkCR6fUZsHY0I8uCRixn49O1gzp6EcJ2FPM7PAGRezqdvtxOS+RMuUtOctw44/PACK+HQMaRLaXgufrhaN7VAkIEgI0nRig1Dwfznwbnr2M/AJ1l8eLbp9U1kHEp9G3OS7HI+WHuzroaN86UZXXZ1/Vn0SlZEf3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p7TGzV1N; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727855274; x=1759391274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0MT3UsYNgbdvoBZaDU1qGk7LBG6sR5i0JyVabGx2pI=;
  b=p7TGzV1NJWdLt8uAt2CspMl8Kvg760vRUuicqpW4kC35kbTAxKp9f3BA
   cqveG5AIdi5qbloIietuk5I6xdK2yOoJNdziPLUqiM9ZvOHdAO+hQqgDK
   G3N9uk+VEiFVnY958euWB7pWycnkBq/srtHw7fjpnSD+a7YBwOcfwAZAP
   dFmO+Yt0dH/67HqDIExnlpBDCfaz0oTpIW6vafcSj+c0s5xqHF7A6Jygx
   JZlFsEBZlO5G+kzDI6jcR6h9HJTdGLo/3dUwuY7kJKa4/i//BYb7Ii+1Z
   6zvFnJlhTfRPc1Fs/ZNDkrLGrn416i/yfN+80Ghvxz4OMvFlzZ0lrFF+p
   A==;
X-CSE-ConnectionGUID: HKYQm0CWSlePuzvScArC8g==
X-CSE-MsgGUID: alPX2nTXQBKPZ3NmZb1AtQ==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="32498850"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 00:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 00:47:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 00:47:14 -0700
Date: Wed, 2 Oct 2024 07:47:14 +0000
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
Subject: Re: [PATCH net-next 00/15] net: sparx5: prepare for lan969x switch
 driver
Message-ID: <20241002074714.uprnmhf5a2f2hyzw@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <4e89dd84-eadc-4cae-8892-c33688cc051f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e89dd84-eadc-4cae-8892-c33688cc051f@intel.com>

> > == Description:
> >
> > This series is the first of a multi-part series, that prepares and adds
> > support for the new lan969x switch driver.
> >
> > The upstreaming efforts is split into multiple series (might change a
> > bit as we go along):
> >
> >     1) Prepare the Sparx5 driver for lan969x (this series)
> >     2) Add support lan969x (same basic features as Sparx5 provides +
> >        RGMII, excl.  FDMA and VCAP)
> >     3) Add support for lan969x FDMA
> >     4) Add support for lan969x VCAP
> >
> > == Lan969x in short:
> >
> > The lan969x Ethernet switch family [1] provides a rich set of
> > switching features and port configurations (up to 30 ports) from 10Mbps
> > to 10Gbps, with support for RGMII, SGMII, QSGMII, USGMII, and USXGMII,
> > ideal for industrial & process automation infrastructure applications,
> > transport, grid automation, power substation automation, and ring &
> > intra-ring topologies. The LAN969x family is hardware and software
> > compatible and scalable supporting 46Gbps to 102Gbps switch bandwidths.
> >
> > == Preparing Sparx5 for lan969x:
> >
> > The lan969x switch chip reuses many of the IP's of the Sparx5 switch
> > chip, therefore it has been decided to add support through the existing
> > Sparx5 driver, in order to avoid a bunch of duplicate code. However, in
> > order to reuse the Sparx5 switch driver, we have to introduce some
> > mechanisms to handle the chip differences that are there.  These
> > mechanisms are:
> >
> >     - Platform match data to contain all the differences that needs to
> >       be handled (constants, ops etc.)
> >
> >     - Register macro indirection layer so that we can reuse the existing
> >       register macros.
> >
> >     - Function for branching out on platform type where required.
> >
> > In some places we ops out functions and in other places we branch on the
> > chip type. Exactly when we choose one over the other, is an estimate in
> > each case.
> >
> > After this series is applied, the Sparx5 driver will be prepared for
> > lan969x and still function exactly as before.
> >
> > == Patch breakdown:
> >
> > Patch #1     adds private match data
> >
> > Patch #2     adds register macro indirection layer
> >
> > Patch #3-#5  does some preparation work
> >
> > Patch #6-#8  adds chip constants and updates the code to use them
> >
> > Patch #9-#14 adds and uses ops for handling functions differently on the
> >              two platforms.
> >
> > Patch #15    adds and uses a macro for branching out on the chip type
> >
> > [1] https://www.microchip.com/en-us/product/lan9698
> >
> 
> The series seems ok to me. I'm not personally a fan of the implicit
> local variables used by macros. I do not know how common that is, or
> what others on the list feel about this.
> 
> For everything else:
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Hi Jakob,

First off, thank you for your reviews - I really appreciate it.

Let me address your "variable scope" conerns:

I had the feeling that this could pontentially be somewhat contentious.

Basically, this comes down to making the least invasive changes to the
existing driver code. With this approach:

    For the SPX5_CONST macro this means shorter lines, and less 80 char
    wrapping.

    For the "*regs" variable this means not having to pass in the sparx5
    pointer to *all* register macros, which requires changes *all* over
    the code.

I thought the solution with an in-scope implicit variable was less
invasive (and maybe even more readable?). Just my opinion, given the
alternative.

Obviously I did a bit of research on this upfront, and I can point to
*many* places where drivers do the exact same (not justifying the use,
just pointing that out). Here is an intel driver that does the same [1]
(look at the *hw variable)

I am willing to come up with something different, if you really think
this is a no-go. Let me hear your thoughts. I think this applies to your
comments on #2, #3 and #6 as well.

/Daniel

[1] https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/net/ethernet/intel/igb/igb_main.c#L4746




Return-Path: <netdev+bounces-214807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E0B2B584
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758FA3ADCE7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F417A2E8;
	Tue, 19 Aug 2025 00:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C63451CC;
	Tue, 19 Aug 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564291; cv=none; b=Sq7HboSMiw5AEPqVNFMSztQq+jbrw/st6LotbnZ8C+SLBJO1J05vvu8GQdsMS+xBYxfGnUKoZJx6aLHwk7r+ID3PyO07wESq7dPsaQWHYB/Bympj13b3L7+lBXoLWZYHYWB9JUtDFIL2VBhpxGwutGDTcsapcWJd2biYPlFmcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564291; c=relaxed/simple;
	bh=G+3x4iO7YudQi/d9E2cAzuUHCVJPYOopGklJPRoumNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4FPTYqCD4G/s5Mc/1qFJdpVzXAZns87IZGE9Yqo++HexDPYw//hglMlHN/nocbe9cGkHfyKgTtuW0J3K2eBdkNonvDrXJnI6N6k8RjegMU20CluAJ/yyZuYLusr4tOiuV27UQSX8rEfePqpErB5AJN73qmPrH9UyHTNeIgJjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoASl-000000008Qq-2F6B;
	Tue, 19 Aug 2025 00:44:31 +0000
Date: Tue, 19 Aug 2025 01:44:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 06/23] net: dsa: lantiq_gswip: load
 model-specific microcode
Message-ID: <aKPI6xMIgIeBzqy7@pidgin.makrotopia.org>
References: <aKDhZ9LQi63Qadvh@pidgin.makrotopia.org>
 <c8128783-6eac-4362-ae31-f2ae28122803@lunn.ch>
 <aKI_t6F0zzLq2AMw@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKI_t6F0zzLq2AMw@pidgin.makrotopia.org>

On Sun, Aug 17, 2025 at 09:46:51PM +0100, Daniel Golle wrote:
> On Sun, Aug 17, 2025 at 05:29:16PM +0200, Andrew Lunn wrote:
> > >  
> > > +struct gswip_pce_microcode {
> > > +	u16 val_3;
> > > +	u16 val_2;
> > > +	u16 val_1;
> > > +	u16 val_0;
> > > +};
> > > +
> > 
> > I would leave this where it is, and just have
> > 
> > struct gswip_pce_microcode;
> > 
> > Since only a pointer is needed, the compiler does not need the full
> > type info, at this point.
> > 
> > The structure itself is rather opaque, and only makes some sort of
> > sense when next to the MAC_ENTRY macro.
> 
> The structure is also used in the function gswip_pce_load_microcode().
> Now, if we keep defining the struct fields along with the microcode this
> will become a problem once there is more than one such set of microcode
> instructions and additional header files for them. Each of them would
> need to define struct gswip_pce_microcode with its fields.
> The lantiq_pce.h header then becomes private to the driver for the
> in-SoC switches, while gswip_pce_load_microcode() would be part of the
> shared/common module use by both, in-SoC/MMIO switches as well as
> (newer) MDIO-connected ones, and I would not want to include any of the
> *_pce.h headers in the shared/common module.
> 
> Obviously I can just move the struct definition in the later commit
> which actually separates the MMIO-specific parts of the driver and the
> common/shared parts into different modules. Is it that what you had in
> mind?

I didn't consider that the size of the array elements needs to be known
when defining struct gswip_hw_info in lantiq_gswip.h.
So the only reasonable solution is to make also the definition of
struct gswip_pce_microcode into lantiq_gswip.h, so lantiq_pce.h won't
have to be included before or by lantiq_gswip.h itself.

In file included from drivers/net/dsa/lantiq_gswip.c:28:
drivers/net/dsa/lantiq_gswip.h:226:44: error: array type has incomplete element type 'struct gswip_pce_microcode'
  226 |         const struct gswip_pce_microcode (*pce_microcode)[];
      |                                            ^~~~~~~~~~~~~
 


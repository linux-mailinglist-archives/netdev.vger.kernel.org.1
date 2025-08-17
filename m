Return-Path: <netdev+bounces-214411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D98B294EE
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 22:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC1E189ACEF
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBB21FF41;
	Sun, 17 Aug 2025 20:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1E212B3D;
	Sun, 17 Aug 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755461834; cv=none; b=oI5R2wSgmenYwrb49nj63GPu1DElv9QFPVyoM7W59WINSdmCi1BcDclwG1TB9LDY1PJRp9LBY2O7OXUmnzoR+o53pEHYCeLADbWZP6fcbG4dyc9pJvGW05bbyakLFJC+ZEaf3GQHRq68JCaUZPvFkFqonU7xmE6anmQDphvExF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755461834; c=relaxed/simple;
	bh=D7myZiWNhx3MHjJJPqnTlE2VCH8CxxYU/ukBho1zS0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imc9QqWbRLBLLYXhqe7xbHoGbhHpNaVBhTlit/VaZOQ7NKi3kBH6Xr7ahp86k59E5iDGAu5lRhIfZdTrUKD/jVXRcsvBWQumk28/S7jJLWhSqoXGq0FzcluKpiiTid8sSadHmbpIX0DuBzPoVc1sXQM1xXaGghhV03ltekSNdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unjoA-000000001uE-33Rs;
	Sun, 17 Aug 2025 20:16:50 +0000
Date: Sun, 17 Aug 2025 21:16:45 +0100
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
Subject: Re: [PATCH RFC net-next 09/23] net: dsa: lantiq_gswip: add support
 for SWAPI version 2.3
Message-ID: <aKI4rbGX8f03thgn@pidgin.makrotopia.org>
References: <aKDhigwyg2v5mtIG@pidgin.makrotopia.org>
 <712e82b5-62fc-423a-a356-8cc74fc22e3d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712e82b5-62fc-423a-a356-8cc74fc22e3d@lunn.ch>

On Sun, Aug 17, 2025 at 05:36:13PM +0200, Andrew Lunn wrote:
> On Sat, Aug 16, 2025 at 08:52:42PM +0100, Daniel Golle wrote:
> > Add definition for switch API version 2.3 and a macro to make comparing
> > the version more conveniant.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/dsa/lantiq_gswip.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
> > index 433b65b047dd..fd0c01edb914 100644
> > --- a/drivers/net/dsa/lantiq_gswip.h
> > +++ b/drivers/net/dsa/lantiq_gswip.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/reset.h>
> > +#include <linux/swab.h>
> >  #include <net/dsa.h>
> >  
> >  /* GSWIP MDIO Registers */
> > @@ -93,6 +94,8 @@
> >  #define   GSWIP_VERSION_2_1		0x021
> >  #define   GSWIP_VERSION_2_2		0x122
> >  #define   GSWIP_VERSION_2_2_ETC		0x022
> > +#define   GSWIP_VERSION_2_3		0x023
> > +#define GSWIP_VERSION_GE(priv, ver)	(swab16(priv->version) >= swab16(ver))
> 
> Don't this depend on the endiannes of the CPU?
> 
> It seems like it would be better to make your new version member cpu
> endian, and when writing to it, do le16_to_cpu().

Yes, that does make sense.

> 
> Also, if i remember correctly, you made version a u32. Should it
> really be a u16?

True, it should probably be u16. It would complicate things a bit though
as the (existing, currently supported) MMIO switches built-into the Lantiq
SoCs use 32-bit memory operations to access the 16-bit switch registers,
where the upper 16-bit are always all zero... Hence I got to use
.val_bits = 32 to not end up with bus errors, and also .reg_shift = -2
is needed as each 16-bit register address needs to be multiplied by 4 (ie.
addr =<< 2, which is what .reg_shift = -2 is doing).
So up to now, eg. when passed as a function paramter in existing code paths,
the version has been a u32 type. When using a different type for the version
stored in the priv struct, that would create quite a bit of confusion imho:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/dsa/lantiq_gswip.c?h=v6.16#n2018

Let me know what you think.



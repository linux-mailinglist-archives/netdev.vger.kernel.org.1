Return-Path: <netdev+bounces-115951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12629488D3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045E2B22DAA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4B1BA88F;
	Tue,  6 Aug 2024 05:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6615C124
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920938; cv=none; b=co9/RUgeLwUrGrbrRhAP0OM0QhwR78M8RSj67rPPrEuc3kQxZCuWZKJ6RpjtXM9Hfjbbyiy4vm3Kah/edhhGNRYQGnmCH3udfkwI4rRouumIiKkjdtaDRylyUEIMDxnpgeJwc7DsDz8j0MOkya+pXoxqr8kPCF9bbzGsSB1shQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920938; c=relaxed/simple;
	bh=G+qkxL3o6b8h7cYfhA90rctB4B5HL59adheeH1vAmw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGgHvno3M+MJ8HQ7u1Sox3/udg+gKk9ctALnjGf4A2iVTX0eb6Vo8QMLZVQrpXM9SJTQz8H64ysqqh3ebQdyZL+8FuvC2SDNkbMq0miTUE3ULpq0P5gpC4YaffE93ioOnwOccLUUTKrvPWctJgU0Vz+32PQ89cVq/nuleGmjlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbCRB-0002IK-BZ; Tue, 06 Aug 2024 07:08:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbCRA-004sKK-Kj; Tue, 06 Aug 2024 07:08:44 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbCRA-004tiG-1g;
	Tue, 06 Aug 2024 07:08:44 +0200
Date: Tue, 6 Aug 2024 07:08:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: lukma@denx.de, Martin Whitaker <foss@martin-whitaker.me.uk>,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: Re: Regression in KSZ9477 dsa driver - KSZ9567 et al. do not support
 EEE
Message-ID: <ZrGv3BEWnfaro39W@pengutronix.de>
References: <137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk>
 <20240805135455.389c906b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805135455.389c906b@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Martin,

On Mon, Aug 05, 2024 at 01:54:55PM -0700, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 13:15:49 +0100 Martin Whitaker wrote:
> > I have an embedded processor board running Linux that incorporates a
> > KSZ9567 ethernet switch. When using Linux 6.1 I can establish a stable
> > connection between two of these boards. When using Linux 6.6, the link
> > repeatedly drops and reconnects every few seconds.
> > 
> >  From bisection, this bug was introduced in the patch series "net: add
> > EEE support for KSZ9477 switch family" which was merged in commit
> > 9b0bf4f77162.
> > 
> > As noted in the errata for these devices, EEE support is not fully
> > operational in the KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices,
> > causing link drops when connected to another device that supports EEE.
> > 
> > A fix for this regression was merged in commit 08c6d8bae48c2, but only
> > for the KSZ9477. This fix should be extended to the other affected
> > devices as follows:
> 
> Thanks for the analysis, adding to CC the folks who wrote the commits
> you mention.

Thank you!

> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > index 419476d07fa2..091dae6ac921 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -2346,6 +2346,9 @@ static u32 ksz_get_phy_flags(struct dsa_switch
> > *ds, int port)
> >                          return MICREL_KSZ8_P1_ERRATA;
> >                  break;
> >          case KSZ9477_CHIP_ID:
> > +       case KSZ9567_CHIP_ID:
> > +       case KSZ9896_CHIP_ID:
> > +       case KSZ9897_CHIP_ID:
> >                  /* KSZ9477 Errata DS80000754C
> >                   *
> >                   * Module 4: Energy Efficient Ethernet (EEE) feature
> > select must
> > 
> > I have verified this fixes the bug for the KSZ9567 on my board.

I can confirm it, Microchip officially removed EEE support from the
datasheets for this chips and extended errata documentations.

KSZ9567S-Errata-DS80000756.pdf
Module 4: Energy Efficient Ethernet (EEE) feature select must be manually disabled

KSZ9896C-Errata-DS80000757.pdf
Module 3: Energy Efficient Ethernet (EEE) feature select must be manually disabled

KSZ9897S-Errata-DS80000759.pdf
Module 4: Energy Efficient Ethernet (EEE) feature select must be manually disabled

Would you like to send this patch against net and add references to this erratum
to the code?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


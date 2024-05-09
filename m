Return-Path: <netdev+bounces-94797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449ED8C0AE0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81281F24052
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE11494A3;
	Thu,  9 May 2024 05:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7313BC3C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231736; cv=none; b=EDgmXoBH91r3mvyOA1RDFVouwyQQJ9HczSujM+N+yd3qHaiE6HqRHoO0Dmh598JOQnu6pR+ylgqK/Gj9YDMj7pcCcHT6gCOGbmd6uhSgGUSjba0XWpGrpzWZllHhUVJpITjp+XFGwCRKVEcUkfO+l7uagrX+JyaEheaeU/E9S10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231736; c=relaxed/simple;
	bh=cIDQZAOFPzs20dF1EbvJv64A34Ri3yMsRyyX/TylLmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqgwvmTZ7UpL8PJEmMnXxh62pWVGrqjGEaKAprkxFUCF2VtrUkmyiS9DH0qCpTMOgOUo5c45MbrjCMbgzjW1LpHZ9PqlKH0y+BqOKjqT5TLIwgRHNTBlvhAagx8RoGCnUS/VSn25f+q+nxgCdrkRph/jqVul5awldjqM6m7Nr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4w7o-0004Iw-3N; Thu, 09 May 2024 07:15:24 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4w7l-000P7C-Tw; Thu, 09 May 2024 07:15:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4w7l-002KX4-2a;
	Thu, 09 May 2024 07:15:21 +0200
Date: Thu, 9 May 2024 07:15:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Message-ID: <Zjxb6a_MaSxjTQxU@pengutronix.de>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
 <20240508103902.4134098-4-o.rempel@pengutronix.de>
 <d4f7d3be15d46b07d7139ee4d453d7366d7aedc3.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4f7d3be15d46b07d7139ee4d453d7366d7aedc3.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Arun,

On Wed, May 08, 2024 at 03:11:24PM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> On Wed, 2024-05-08 at 12:39 +0200, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > 
> > -static const u8 ksz8_port2_supported_apptrust[] = {
> > -       DCB_APP_SEL_PCP,
> > -};
> > -
> >  static const char * const ksz_supported_apptrust_variants[] = {
> >         "empty", "dscp", "pcp", "dscp pcp"
> >  };
> > @@ -771,9 +767,8 @@ int ksz_port_get_apptrust(struct dsa_switch *ds,
> > int port, u8 *sel, int *nsel)
> >   */
> >  int ksz_dcb_init_port(struct ksz_device *dev, int port)
> >  {
> > -       const u8 *sel;
> > +       const u8 ksz_default_apptrust[] = { DCB_APP_SEL_PCP };
> >         int ret, ipm;
> > -       int sel_len;
> > 
> >         if (is_ksz8(dev)) {
> >                 ipm = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
> > @@ -789,18 +784,8 @@ int ksz_dcb_init_port(struct ksz_device *dev,
> > int port)
> >         if (ret)
> >                 return ret;
> > 
> > -       if (ksz_is_ksz88x3(dev) && port == KSZ_PORT_2) {
> > -               /* KSZ88x3 devices do not support DSCP classification
> > on
> > -                * "Port 2.
> > -                */
> > -               sel = ksz8_port2_supported_apptrust;
> > -               sel_len = ARRAY_SIZE(ksz8_port2_supported_apptrust);
> 
> If we remove this, How the user application knows about the DSCP
> resistriction of KSZ8 port 2. Is it implemented in other functions?

Yes, it is implemented in
ksz_port_set_apptrust()->ksz88x3_port_apptrust_quirk(). This patch
affects only default configuration.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


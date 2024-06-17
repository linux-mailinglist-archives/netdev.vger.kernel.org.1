Return-Path: <netdev+bounces-104241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0690BB76
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BAD284A08
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D38187560;
	Mon, 17 Jun 2024 19:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C73D53E
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654144; cv=none; b=Fl5YNnPDjp9RW/H/+V8bvs8AkEyNS72fEIpKZ2hsT3vd3HnOPFsVf7dtLUblMMymDyi4i8wNDX9NvEUd8deHCXn9WnFQstGoPaHOwdyhIZ/DECj4yCQyrMYnjqJilKakAFquol2I4X81XN54PK5xrKv731lXJqh3yPtdcY8acEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654144; c=relaxed/simple;
	bh=BKwBZ1Uh+W0EYjv1sS/U5nLLrTEJXKX0KED9wVuMh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYt5dewAKIFcQXzoGKoGdHEWYTPyMVfgukf6HJN6C+xQmt/D++mZ1/rC/zFbtF4CmxD3p+keXmeTtdflzJMET99HBVLfHqwyKD7YpRs1ZnOnOsAJGUG/Q6lQTBkiGRGST/biWljZhRRgXv51Cw9PSuHFvU2MTMwaECmvF8az7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sJIRs-00060n-VJ; Mon, 17 Jun 2024 21:55:28 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sJIRp-0033Sx-PR; Mon, 17 Jun 2024 21:55:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sJIRp-00GGJK-2B;
	Mon, 17 Jun 2024 21:55:25 +0200
Date: Mon, 17 Jun 2024 21:55:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <ZnCUrUm69gmbGWQq@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
 <Zm15fP1Sudot33H5@pengutronix.de>
 <20240617154712.76fa490a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617154712.76fa490a@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jun 17, 2024 at 03:47:12PM +0200, Kory Maincent wrote:
> > According to 33.2.4.7
> > State diagrams we have CLASSIFICATION_EVAL function which evaluates
> > results of classification.
> > In case of class_num_events = 1, we have only tpdc_timer. In case of
> > error, will we get some timer related error?
> > 
> > In case of class_num_events = 2, if i see it correctly, PSE is doing
> > double classification and if results do not match, PSE will go to faul
> > state. See CLASS_EV2->(mr_pd_class_detected != temp_var) case.
> > 
> > Is it what we have here?
> 
> Mmh not really indeed, maybe we can put it in error_condition substate?

I'm not sure how this error can help user, if even we do not understand
what is says. May be map everything what is not clear right not to
unsupported error value. This give us some time to communicate with
vendor and prevent us from making pointless UAPi?

> > The difference between open and underload is probably:
> > - open: Iport = 0, detection state
> > - underload: Iport < Imin (or Ihold?), Iport can be 0. related to powered/MPS
> >   state.
> 
> Should I put it under MPS substate then?

If my understand is correct, then yes. Can you test it? Do you have PD
with adjustable load?

> > May be you will need to contact Microchip directly. Usually it helps :)
> 
> Lets keep it like that for now?

let's map it to unsupported error for now

> > > +enum ethtool_c33_pse_ext_substate_pd_dll_power_type {
> > > +
> > > ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE = 1,
> > > +};  
> > 
> > Here i was potentially wrong. LLDP stage is after power up, and this
> > values was probably set on early stage of signature detection. How can
> > we detect a device which is not conform to the 802.3AF/AT standard? Is
> > it something pre-802.3AF/AT, micorosemi specific vendor specific signature?
> 
> Don't really know.

Same here, if we do not really know what it is, make it unsupported error value

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


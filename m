Return-Path: <netdev+bounces-116741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66494B8BB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F8D1C242C9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72568189511;
	Thu,  8 Aug 2024 08:16:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235E6F30E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104977; cv=none; b=IPMSXqAZ2NER5REY54dnN21YwrAEIv3yYKqJtAhaDd3FqmJGD/wxll/KvCgFxY+PMtYGut4yGIo8raz3hyFYrDDMuTbngu3mKud/2RiYvVmlRxk/zrfa0D3+nPE75bLvY+oJ6Wa+yaKIjsOKlmhpaYa3TwKFp7FVY5iRlJDtqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104977; c=relaxed/simple;
	bh=nEfyhXYBGUJmuf89ex3f4i//xxJh252/RWCclx2i4Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA/DhnP78ipnayhC8nPA6SUftDcDWLKGlW29wF2CmC2e5UyGsUn+TvkBb6w6k/BKSuVvYCD+Z5HtC1RwAwXYjcrYwQMDeARAhvvdbfxuV8U6NJFoVCm7RGGvtnEIPhTnuW2evLCmxhgfCWBkixXrSmjVj50Wy7n2xDdaOioaztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbyJY-0002uS-FF; Thu, 08 Aug 2024 10:16:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbyJX-005Nh7-7G; Thu, 08 Aug 2024 10:16:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbyJX-008mIc-0J;
	Thu, 08 Aug 2024 10:16:03 +0200
Date: Thu, 8 Aug 2024 10:16:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <ZrR-w7phB1DZL3kt@pengutronix.de>
References: <20240807093251.3308737-1-o.rempel@pengutronix.de>
 <ff096c1c-00bf-4e55-9400-fb869749b07f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff096c1c-00bf-4e55-9400-fb869749b07f@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 07, 2024 at 03:24:52PM +0200, Andrew Lunn wrote:
> On Wed, Aug 07, 2024 at 11:32:51AM +0200, Oleksij Rempel wrote:
> > Introduce cable testing support for the DP83TG720 PHY. This implementation
> > is based on the "DP83TG720S-Q1: Configuring for Open Alliance Specification
> > Compliance (Rev. B)" application note.
> 
> Does the OA specification describe all these registers?

Not all of them.

OA specification provide recommendation for the bit layout for the TDR
status register (HDD.TDR):
https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf

> Should we expect other devices to be identical?

Yes. I'll create a new file for OA specific helpers.

> > +/**
> > + * dp83tg720_get_fault_type - Convert TDR fault type to ethtool result code.
> > + * @fault_type: Fault type value from the PHY.
> > + *
> > + * Returns: Corresponding ethtool result code.
> > + */
> > +static int dp83tg720_get_fault_type(int fault_type)
> > +{
> > +	switch (fault_type) {
> > +	case DP83TG720S_TDR_FAULT_TYPE_SHORT:
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
> > +	case DP83TG720S_TDR_FAULT_TYPE_OPEN:
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
> > +	case DP83TG720S_TDR_FAULT_TYPE_NOISE:
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
> 
> You could add a new type for this. I think some implementations will
> also re-try a few times to see if a quiet period can be found.

ack.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


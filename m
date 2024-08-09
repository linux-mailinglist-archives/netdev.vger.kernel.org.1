Return-Path: <netdev+bounces-117087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA694C98C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79410B235F4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C70166318;
	Fri,  9 Aug 2024 05:18:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2A18E25
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180701; cv=none; b=OHKvxPH4N9PuiwYRvXNb5G+PEUWqXgmVtEL7p1QzPDg2XQsmMSgR+WO/jqw4Becs0rvySfn1KVXAvaaFKkYEgA/e5Kbm7pq39CrowkKWYaiIUvfH4HTQZHswuQ4DYK1+d1uxaUWJS+7q96DLcN03+kiyIwQQkAx8CJqngjF0SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180701; c=relaxed/simple;
	bh=JBMg47OQTO2usEseBnYz78pjPbkR6k1Og9xsXbbeIBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXXuV7Rxi+LSubsxpZJS8kzYIm+4TTQnuH6a+pwGg/TbIUUQyEoHPZHncxpCGft1qDAyM03syQdnxWlXsJUX/t0G4Ez5d7YbDNMdIN2Byd8eaADZcqblvkzEDtr1+aIYl2Sow/da0zIGiWl1rIkR5Cq8NdbHgUzoJ0ug2cgHcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1scI0e-0003CM-CZ; Fri, 09 Aug 2024 07:17:52 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1scI0c-005aez-B5; Fri, 09 Aug 2024 07:17:50 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1scI0c-00AhSk-0j;
	Fri, 09 Aug 2024 07:17:50 +0200
Date: Fri, 9 Aug 2024 07:17:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <ZrWmfqtYICzaj-HY@pengutronix.de>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
 <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 08, 2024 at 03:54:06PM +0200, Andrew Lunn wrote:

> Please could you give a reference to the exact standard. I think this
> is "Advanced diagnostic features for 1000BASE-T1 automotive Ethernet
> PHYs TC12 - advanced PHY features" ?
> 
> The standard seem open, so you could include a URL:
> 
> https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf

I already started to implement other diagnostic features supported by the
TI DP83TG720 PHY. For example following can be implemented too:
6.3 Link quality – start-up time and link losses (LQ)
6.3.1 Link training time (LTT)
6.3.2 Local receiver time (LRT)
6.3.3 Remote receiver time (RRT)
6.3.4 Link Failures and Losses (LFL)
6.3.5 Communication ready status (COM)
6.4 Polarity Detection and Correction (POL)
6.4.1 Polarity Detection (DET)
6.4.2 Polarity Correction (COR)

What is the best way to proceed with them? Export them over phy-statistics
interface or extending the netlink interface?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


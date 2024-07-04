Return-Path: <netdev+bounces-109311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69450927D92
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4811C23569
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A051C42;
	Thu,  4 Jul 2024 19:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233049629
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119920; cv=none; b=QIcqXU1xg7LRfkZPdcGbwDD6Fd/AvUelH6KONipdGCj9WxVQzYd16HXyuWfI4RSrUyL0d2qTbwO9WnqgHrEZ/XDfR6uvOE1Qkm7O8fDibIf0LkFvOHBwGXNAHWMrnI42ZczFtCd5BRil5/RB2G29tymSlgbGdMW6wObDz/3qXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119920; c=relaxed/simple;
	bh=pHbOcWLEcn9Xqrgf+5/Gho5nIyey0ri49aANfeFQVds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP/MlIy5b2+RefcS+3rcUWBHnVe5FwGd9U4OXXQqSmE1+1A0G0quOCGpYd2Qny4N7lK2pfeAlh6z9Kb5WfiPY7qgtdd1Eo/9UL55OLqrbj0EUmaHPGx2UXI+laqYpneJJg/x6DZzk+mTjGK8YzcM6G1DuS4U9xKzBJTdHe5crrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPRl7-0006ZF-VH; Thu, 04 Jul 2024 21:04:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPRl6-0079X4-7j; Thu, 04 Jul 2024 21:04:44 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPRl6-00EZSD-0S;
	Thu, 04 Jul 2024 21:04:44 +0200
Date: Thu, 4 Jul 2024 21:04:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung.Huh@microchip.com
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	Arun.Ramadoss@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Yuiko.Oshino@microchip.com,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZobyTGbbzXlhTBbz@pengutronix.de>
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
 <BL0PR11MB29132F1C667E478728BCE4ECE7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR11MB29132F1C667E478728BCE4ECE7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Woojung,

On Thu, Jul 04, 2024 at 03:44:52PM +0000, Woojung.Huh@microchip.com wrote:
> Hi Oleksij,
> 
> We use phy/microchip_t1.c for T1 phy. Can you please put the case in different phy driver file?

Which file would you suggest?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


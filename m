Return-Path: <netdev+bounces-116376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783694A3E4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882BDB280C0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A231CB304;
	Wed,  7 Aug 2024 09:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB3B647
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022043; cv=none; b=M8mkHIu1ukAZgyHmHiw+8N+rmbAiXuIaUyTmg1jn3mu3g0k9rwj+X2vmLjwXME9nCDPJmObGixSq4CPvXb9oCErOqplrPHAw+gtJL1hlouLgg+vZFrz08wiYny+r8+mOj+2bTIU8Z1ZP41EzejQyck1foWBWTSrwsFSIYsOkNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022043; c=relaxed/simple;
	bh=DP6AmAs7OB7NrfQbUAU01mOamE1yKADeqYUvuV61lPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH5FGXdHPFRfjx4mdnTJX/SCvUnYP7Enqf1lj6CkS8lbOTZ3pVeDGVswbvxTBj1G425ytIyuDBrXfcUpH0aisbj7xZvQXJ1VjP3KDrO3MEfd0P8YVLN+zHtf1swY8vpc1R4x0MHrm9m7rvVcxl4rBTtPCLTmHUKBsWM30UFD5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcjt-0006HJ-Sq; Wed, 07 Aug 2024 11:13:49 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcjs-0059sm-P2; Wed, 07 Aug 2024 11:13:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcjs-006td3-26;
	Wed, 07 Aug 2024 11:13:48 +0200
Date: Wed, 7 Aug 2024 11:13:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: tps23881: include missing bitfield.h header
Message-ID: <ZrM6zOyLodtaDVpQ@pengutronix.de>
References: <20240807075455.2055224-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807075455.2055224-1-arnd@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Arnd,

Thank you for your patch.

I acked already other one:
https://lore.kernel.org/all/20240807071538.569784-1-guanjun@linux.alibaba.com/

On Wed, Aug 07, 2024 at 09:54:22AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using FIELD_GET() fails in configurations that don't already include
> the header file indirectly:
> 
> drivers/net/pse-pd/tps23881.c: In function 'tps23881_i2c_probe':
> drivers/net/pse-pd/tps23881.c:755:13: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
>   755 |         if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
>       |             ^~~~~~~~~
> 
> Fixes: 89108cb5c285 ("net: pse-pd: tps23881: Fix the device ID check")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


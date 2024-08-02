Return-Path: <netdev+bounces-115239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D635794594B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3001F2381A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005091BF301;
	Fri,  2 Aug 2024 07:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BA482CA
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585246; cv=none; b=AJI9dehuMTZXuzmIJ17/fmv3iEsrm3gTReKUmjF+hQbdHlSF/l/9ABKGFapGYHnAndgPI+U4lxa0exIMkwgxr+xN63nrWpHld25iamp+qVcO6kSVaUHRJnIEAyhlyp3wcKUWbcFsf9cea68XK841Ij8EhHs6uBhLWHFnuh9Lv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585246; c=relaxed/simple;
	bh=ng9lL5OyIkewkcab4rQhaW0ud3cfMUqSL++SkFcm/SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6mJ+x15YGhmsBZQ968NB+okgN/eC+2oUjGWndZduZiZQFzEq90Xo/cc8m9Xv9JL2Omfkb2IietiuPXte6uDyueuJjcs4dqiONsR2dtzRm21qAAvk6OTXv04pC2KLG/NpSyOjrpHSWWIoiReqCZNEWNGGln1kH1qd6hgeJQelic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn6p-0006IZ-7y; Fri, 02 Aug 2024 09:53:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn6n-003xLw-Dt; Fri, 02 Aug 2024 09:53:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZn6n-00EqBX-11;
	Fri, 02 Aug 2024 09:53:53 +0200
Date: Fri, 2 Aug 2024 09:53:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Message-ID: <ZqyQkU7ea1Ea2uGY@pengutronix.de>
References: <20240731154152.4020668-1-kyle.swenson@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731154152.4020668-1-kyle.swenson@est.tech>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jul 31, 2024 at 03:42:14PM +0000, Kyle Swenson wrote:
> The DEVID register contains two pieces of information: the device ID in
> the upper nibble, and the silicon revision number in the lower nibble.
> The driver should work fine with any silicon revision, so let's mask
> that out in the device ID check.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


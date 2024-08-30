Return-Path: <netdev+bounces-123586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4996569B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D882858EE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AAC1411C8;
	Fri, 30 Aug 2024 04:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E4136337
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993807; cv=none; b=P+DOG9GvHv5hEgUAHZQbW1SIcayi6n1aziBzZhIttEPbu0+nSER6ukX0Ojn48zHab7dlVWvdcy6Ja+j7mbq+M4HJeKj4xHSwq77REJMg1KoRWhRsxsPkevs1pMTKri//4GJ7TaHZpkS4jidh5WfH34cWHq3w+I+u4cnp4oGD7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993807; c=relaxed/simple;
	bh=qBvVDmgffDEKLQLg02ZvuHxPtbWEzN2MNEX6JaFejPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1Z70VnyIsRfy4M0SORkQ32NMtQEjnV+imLuFBIL8e1X+z9ai8zbIE1Usqz8oDYtVGV6Rvd1qR0SHnRWEBC8Rde3EkAVtA6BUpuiSJU+JuIgcKdbMKN1QfurL3rDFcc2BZihDUMgk/aDD0h8jy/UZxGK7jaJSdQjhMLcvj+TsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtga-0000FC-8o; Fri, 30 Aug 2024 06:56:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtgZ-0044WK-RL; Fri, 30 Aug 2024 06:56:35 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtgZ-00EP1m-2N;
	Fri, 30 Aug 2024 06:56:35 +0200
Date: Fri, 30 Aug 2024 06:56:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH net-next 5/6] net: ag71xx: remove always true branch
Message-ID: <ZtFRAyfmfOllGfwa@pengutronix.de>
References: <20240829214838.2235031-1-rosenp@gmail.com>
 <20240829214838.2235031-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829214838.2235031-6-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 29, 2024 at 02:48:24PM -0700, Rosen Penev wrote:
> The opposite of this condition is checked above and if true, function
> returns. Which means this can never be false.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


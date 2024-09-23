Return-Path: <netdev+bounces-129234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2597E63C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4937B1F2108C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34E219FF;
	Mon, 23 Sep 2024 06:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC7EAF6
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074590; cv=none; b=VgTLi6WbLUaZ0lByJ5ERhkNRHer6eYJzDY6TZomOonrG95zlQnmXpW0FxnqhwK8HVdF4v91dC3PjGRp9iAc67lF1ZLDRbA499rtRIMVO9Zo93DLwJaqUOOxTaDOGM3uMFvBeVEy//9pco2MuIrgI7GZcswRP1HPGcQ04y+8pex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074590; c=relaxed/simple;
	bh=V3paVrfNIRP2Z+5Cwp68N6b2MyCaHcd3zPQkf9DX/Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm8QJoP3WQnLoPzWUmzzV7dtbHzDjC4Azclddi+yfrwi14xStBlIi2AhhP8UPBkdwXoza3ifR+3N+Zj8z11VLlbd0vf/vYVmHrFKptRfgSv2I5QZMbo8d+lqV3Dy/0SoMyUDtMItBw+XerJbzRiwH5WFZYK5uZ4CvOQn2KLA7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ssczg-0000aI-Si; Mon, 23 Sep 2024 08:56:24 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ssczf-000te9-OD; Mon, 23 Sep 2024 08:56:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ssczf-007QKU-27;
	Mon, 23 Sep 2024 08:56:23 +0200
Date: Mon, 23 Sep 2024 08:56:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	spatton@ti.com, r-kommineni@ti.com, e-mayhew@ti.com,
	praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 1/5] net: phy: dp83tg720: Changed Macro names
Message-ID: <ZvERF6Akt8kMonly@pengutronix.de>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <b9ae5a74361c80becc446775258c06154e00be1d.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9ae5a74361c80becc446775258c06154e00be1d.1726263095.git.a-reyes1@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Sep 19, 2024 at 02:01:15PM -0700, Alvaro (Al-vuh-roe) Reyes wrote:
> Previous macro referes to DP83TG720S, where this driver works for both
> DP83TG720R & DP83TG720S. Macro changed to DP83TG720 to be more generic.
> 
> Data sheets:
> https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
> https://www.ti.com/lit/ds/symlink/dp83tg720r-q1.pdf

One one side, this change is not consequent enough - this patch set will
add support for dp83tg721 variants too, but rename reflect support only
for dp83tg720 variants. At same time, TI has company internal names
for this IP cores, which are not used for end product names. Every time, some
one add new chip variant, we will need to rename defines.

On other side, already this refactoring is too much, because it will
make maintenance of stable kernel a nightmare.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


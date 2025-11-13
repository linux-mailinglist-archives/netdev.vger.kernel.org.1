Return-Path: <netdev+bounces-238197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7128C55C36
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918703A7E72
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAF284684;
	Thu, 13 Nov 2025 05:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AB2905
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010498; cv=none; b=aG7B9FubQ0P98NNIpqWqeYhUY17QvsrxE14Pfpm52pIYgIRZK7ayZPahcqBNIqNlAWNBkiFUEOOKw09HYV+O1xDKpPvDLMSLCX4SlHqO2dYfWtLe3bkOnN2q0xiqw9mHxReqIMN90m5F3RSKXxQHZcMW4WXMxGkPYZ2UfVAWxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010498; c=relaxed/simple;
	bh=fiaBJQzNniiKRC8Bsy4AcL2myrZMWM3MFMY23DrmM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWxvg3EHkvG+2iNic1jc4RAlOsskxOfn1s8OFETPABZ9WmlZ0xnoWFnCMW7b7BRcd+4uWbhndzZKyMLZZu4Z4ONsGRzaOfYYktRSa1diHpx1P/q4lc/HhwWd2ngu2zztoa5AEopCKyY6ntKBgD+EewCamM8iQSylTVYEPDy/BwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJPZ5-0005M6-IQ; Thu, 13 Nov 2025 06:08:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJPZ5-000CQy-0q;
	Thu, 13 Nov 2025 06:08:11 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJPZ5-000gdh-0R;
	Thu, 13 Nov 2025 06:08:11 +0100
Date: Thu, 13 Nov 2025 06:08:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: dp83822/dp83tc811: do not blacklist EEE for now
Message-ID: <aRVnu5h-l1TMSaxj@pengutronix.de>
References: <aRRGbAR26GuyKKZl@shell.armlinux.org.uk>
 <20251112135935.266945-1-o.rempel@pengutronix.de>
 <aRSuBOxAZf3tN-hk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRSuBOxAZf3tN-hk@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Nov 12, 2025 at 03:55:48PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 12, 2025 at 02:59:35PM +0100, Oleksij Rempel wrote:
> > Note: dp83tc811 wires phydev->autoneg to control SGMII autoneg, which
> > can't be proper decision. But it is a different issue.
> 
> Yep, that is just wrong. You didn't state whether you are happy with my
> plan to squash this into my patch. What would you like to happen with
> authorship etc?

Just squash it and add my:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


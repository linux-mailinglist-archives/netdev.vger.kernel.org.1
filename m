Return-Path: <netdev+bounces-121614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71C95DB85
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 06:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B4A1C21220
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C961605BA;
	Sat, 24 Aug 2024 04:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70D39FE5
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724474900; cv=none; b=WElnIDOJZtTWs6XLLE1VkxHsKujjyjjJVULw7eqbUa/f5cPjF3jkVx8xKEY6hpN/fdR7oWCw3yBqaCpbyemtBhviKbeq1UBAhVeN3XoUBG9l5MCfP32mS0Km1qWOxnn86NhCSqTUP7BCS8jVZ5B5Cct952jtuXWGmjlNT5yE054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724474900; c=relaxed/simple;
	bh=rk9D33q8kn84aYQ2vFDuhi6NuE8Y6FGmVkjAvkU8XN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djx3fcfLAIJVgRmRhKd6C4Y+OeGDJx7CnAe52QmlKtZnhfbkVzqKOPpbNlrFWY2GcH6X9Bn2sYPnQh+gGR3Zkz1pJlnTuxAcDGS+XXuApT3FuL/kpn4dQuBF18NrwY3E/KA00j4IjyFVaGhpotCuNsOCa4Ecqv2odKr9gBDdSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1shih6-0001ly-Oj; Sat, 24 Aug 2024 06:48:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1shih5-002dp5-SW; Sat, 24 Aug 2024 06:48:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1shih5-003MVH-2U;
	Sat, 24 Aug 2024 06:48:07 +0200
Date: Sat, 24 Aug 2024 06:48:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] net: ag71xx: add missing reset_control_put
Message-ID: <ZslmB8RZo7z-uZQl@pengutronix.de>
References: <20240823200433.7542-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823200433.7542-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Rosen,

On Fri, Aug 23, 2024 at 01:04:18PM -0700, Rosen Penev wrote:
> The original downstream driver used devm instead of of. The latter
> requires reset_control_put to be called in all return paths.

At the moment of upstreaming this code, the original driver used
of_reset_control_get_exclusive() and was fixed by f92bbdcc93 ("ath79:
ag71xx-mdio: get reset control using devm api")

Why not port the original fix?
 
Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


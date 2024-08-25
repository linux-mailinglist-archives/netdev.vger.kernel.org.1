Return-Path: <netdev+bounces-121707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E395E266
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 09:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A62826C8
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D755381B;
	Sun, 25 Aug 2024 07:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDF41C6A
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570719; cv=none; b=fUgMdfNzdMY+XAsGXDITNzDA1Y2N55I5UcHuRa0kU/Byr/wW15ZxMkCLEItt+PTJk96Fyk6Q+9iPQNTRArS9Kc1LLyvWOEl2p5SQ7IFPN6Zsb8usTGpkrtC0b8MsdH8iS6SkyWQb6TaM7HDkYTfDyE0SBtSrVqur15tUp+qcWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570719; c=relaxed/simple;
	bh=l26K0PqQYrgv/p9/jetvS7fhGVxG+s88mWVmHvvwFEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGUAIRag5Dd86fBMsEelagwecQtFRjVVPQDozWxlT7LjqCsEd0I6OEIlh6gLJoWyEWJPIlZiILEBsvSCU4lzv/Bp7BuPg9zFfw31P4HX4SdK4vbyShx8sGGhXOIA+VFqOEj75CrkRbwfZKRo3o67izN/kXhddyICSwpMsoi0O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1si7cZ-0002sm-0V; Sun, 25 Aug 2024 09:25:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1si7cY-002tmi-Il; Sun, 25 Aug 2024 09:25:06 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1si7cY-005ApT-1S;
	Sun, 25 Aug 2024 09:25:06 +0200
Date: Sun, 25 Aug 2024 09:25:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH net-next] net: ag71xx: support probe defferal for getting
 MAC address
Message-ID: <ZsrcUiKuojyFEn3u@pengutronix.de>
References: <20240824200249.137209-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824200249.137209-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Aug 24, 2024 at 01:02:37PM -0700, Rosen Penev wrote:
> Currently, of_get_ethdev_address() return is checked for any return error
> code which means that trying to get the MAC from NVMEM cells that is backed
> by MTD will fail if it was not probed before ag71xx.
> 
> So, lets check the return error code for EPROBE_DEFER and defer the ag71xx
> probe in that case until the underlying NVMEM device is live.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


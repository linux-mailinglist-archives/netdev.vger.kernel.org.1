Return-Path: <netdev+bounces-205264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16307AFDED9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CBF4A677D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F91DED53;
	Wed,  9 Jul 2025 04:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611F13A3F2
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752036145; cv=none; b=fB9we+chcr5+NBv7Eii5632TEyvbyot5TULXi14WQ4DPcQIjjVMcfn49WUIDgBmRvE456QKi2tbLFAgMKJfVaJmblDLkz3MmG+qDum302szJJJKM6dh9Y/Hg+DjAUaEhOoZp7plCfcwK9FjPG3WOD7CZY/FDPsuC3kBEbxPPFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752036145; c=relaxed/simple;
	bh=sWTCjw7yV66pBVAAsh/JHklRYDUJqSx7zwbyy/gm3qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Web67LJ6QMVL7pdFAr/AQ748daJs3QatBYHlvmCrBxl6AJgJqxDMdpYWxsKo3dESQwk+qpbWV62sdXd9hNA2Cdu+S8XFud/fOLPUaIYhpd7FNlJu76KdVbCVnfPjaV43QYmG/lj8IYzgCzkwMniGCvXVJm9pfKIIGecJ4IyNhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZMdH-0004mH-4L; Wed, 09 Jul 2025 06:42:11 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZMdF-007WaS-0X;
	Wed, 09 Jul 2025 06:42:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZMdF-009pDy-03;
	Wed, 09 Jul 2025 06:42:09 +0200
Date: Wed, 9 Jul 2025 06:42:08 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jun Miao <jun.miao@intel.com>
Cc: kuba@kernel.org, oneukum@suse.com, qiang.zhang@linux.dev,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: enable the work after stop usbnet by ip down/up
Message-ID: <aG3zIMg_z2CpnG70@pengutronix.de>
References: <20250708081653.307815-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708081653.307815-1-jun.miao@intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jun,

please resend this patch with the name [PATCH net-next] and add all related
people suggested by scripts/get_maintainer.pl.

./scripts/get_maintainer.pl drivers/net/usb/usbnet.c 
Oliver Neukum <oneukum@suse.com> (maintainer:USB "USBNET" DRIVER FRAMEWORK)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:USB "USBNET" DRIVER FRAMEWORK)
linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)

Best Regards,
Oleksij

On Tue, Jul 08, 2025 at 04:16:53PM +0800, Jun Miao wrote:
> From: Zqiang <qiang.zhang@linux.dev>
> 
> Oleksij reported that:
> The smsc95xx driver fails after one down/up cycle, like this:
>  $ nmcli device set enu1u1 managed no
>  $ p a a 10.10.10.1/24 dev enu1u1
>  $ ping -c 4 10.10.10.3
>  $ ip l s dev enu1u1 down
>  $ ip l s dev enu1u1 up
>  $ ping -c 4 10.10.10.3
> The second ping does not reach the host. Networking also fails on other interfaces.
> 
> Enable the work by replacing the disable_work_sync() with cancel_work_sync().
> 
> [Jun Miao: completely write the commit changelog]
> 
> Fixes: 2c04d279e857 ("net: usb: Convert tasklet API to new bottom half workqueue mechanism")
> Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>  drivers/net/usb/usbnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 9564478a79cc..6a3cca104af9 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
>  	/* deferred work (timer, softirq, task) must also stop */
>  	dev->flags = 0;
>  	timer_delete_sync(&dev->delay);
> -	disable_work_sync(&dev->bh_work);
> +	cancel_work_sync(&dev->bh_work);
>  	cancel_work_sync(&dev->kevent);
>  
>  	/* We have cyclic dependencies. Those calls are needed
>  	 * to break a cycle. We cannot fall into the gaps because
>  	 * we have a flag
>  	 */
> -	disable_work_sync(&dev->bh_work);
> +	cancel_work_sync(&dev->bh_work);
>  	timer_delete_sync(&dev->delay);
>  	cancel_work_sync(&dev->kevent);
>  
> -- 
> 2.32.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-112234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D469378BE
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D8F281E28
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676A13D501;
	Fri, 19 Jul 2024 13:52:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63983A19
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397143; cv=none; b=h5EZc9ETzXgoXk5s1N3eAUzefROQIy/6nPfrEWdXHAiaCBSFEwl2GwTItt0nFWywsjx4II6UfKOYZ2ZQ0D4S3SZERsezYUdQvKhO2Pudjkai/Ipvsy9Hk1kEQDO65PAXPNqGaVx6WR7OmXXsqN/u2DbcSqWQPXtVZ9rxZLImXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397143; c=relaxed/simple;
	bh=be9qMww+NPOk4AHVSfmPsPHRmcVLjOlUarbb5KQHUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY6woYe0QTUtmAFxn4fGg23rbybBNdHUCHNYOqcfBbIl4l84tTPRL/6PJuL3tgk2dG2FLBE212o3I6KMtkAHjN5AY4+PHp24lDr6cUnd2aRRtESbRQPUBcWUjeab7CzbaTMHFDibz2xORF1veKlhznF53SFfVMNSn0LTyfJU8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sUo1x-0005LB-Aw; Fri, 19 Jul 2024 15:52:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sUo1w-000hAp-Mi; Fri, 19 Jul 2024 15:52:16 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sUo1w-005wHi-1v;
	Fri, 19 Jul 2024 15:52:16 +0200
Date: Fri, 19 Jul 2024 15:52:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH 4/4] net: dsa: microchip: ksz9477: correct description of
 WoL functions
Message-ID: <ZppvkFJQzHxAAsJ0@pengutronix.de>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com>
 <20240717193725.469192-4-vtpieter@gmail.com>
 <20240717193725.469192-5-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717193725.469192-5-vtpieter@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jul 17, 2024 at 09:37:25PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Correct KSZ9477 WoL function description, found when evaluating it for
> usage at KSZ8795 family of switches.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>  drivers/net/dsa/microchip/ksz9477.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 425e20daf1e9..1344b60ee2c3 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -95,9 +95,9 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
>   * @port: The port number.
>   * @wol: Pointer to ethtool Wake-on-LAN settings structure.
>   *
> - * This function checks the PME Pin Control Register to see if  PME Pin Output
> - * Enable is set, indicating PME is enabled. If enabled, it sets the supported
> - * and active WoL flags.
> + * This function checks the PME 'wakeup-source' property from the
> + * device tree. If enabled, it sets the supported and active WoL
> + * flags.

Good point, it is out dated variant of my previous implementation but i
would prefer not to mention device tree as the only source for this
flag.

>   */
>  void ksz9477_get_wol(struct ksz_device *dev, int port,
>  		     struct ethtool_wolinfo *wol)
> @@ -135,7 +135,7 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
>   *
>   * This function configures Wake-on-LAN (WoL) settings for a specified port.
>   * It validates the provided WoL options, checks if PME is enabled via the
> - * switch's PME Pin Control Register, clears any previous wake reasons,
> + * switch's device tree property, clears any previous wake reasons,

same here.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


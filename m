Return-Path: <netdev+bounces-81322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187D887370
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7339F1C21B1E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD976054;
	Fri, 22 Mar 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OFD2nZf2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3864CC6
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133793; cv=none; b=XCIisrmpCLLFxgXGGDJbHu35v96K5fOdtLTaZTFa8MDS6OA2U0BjXwVyuZO2Jcch1EwZ5pku2URlT+DIIvCUurC8J9X+JWgngDKZ4JIww+HutEEqwJFgyFXBKh1bGKOBgBHRP0NyimoaYiCpdXblXyICYgsspTCanUwWFjH51Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133793; c=relaxed/simple;
	bh=xRYPY+c1NLifolhNI+YEckcw8DZ680p3Ew8dX3ve3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBKb5ZQqHronMhm7VscUB33qhH9uL0WILUxan5AIzpCJxeIrZDg5rOGi3QFPquoBWKHyEBOyqgms0yIkUCjf3pg8Al1zkyahXONsC7qNB7ZVh9SwpXYWOKBZ7MmcV92V5IIfZ3OYRcLLayKfIGBf5SmOFN7IdHP2gaYaOklrS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OFD2nZf2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R4evshRGA+Qp/behd8f+JvNGPqucE8jSuUt0zNFm9W0=; b=OFD2nZf23Weire80Y5tF4EKe3B
	vkAztmaQ5Zpe5KjCKoTKfpS95TJJOEY+0aePBDVySFNjhRKPJEEI+OPON6ZwT78u5J/4oyBtX+rPB
	J2zIoPtqleE/5CIzcvtKeUkrtyTKTA5wBpR1fJuCN2oKHp8ej2x/mipfMCu6F2szNVic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnk3w-00Ayrz-K6; Fri, 22 Mar 2024 19:56:20 +0100
Date: Fri, 22 Mar 2024 19:56:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Message-ID: <f194b4a4-0bbf-4cd0-81c2-b0fbe5ac8a8a@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
 <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
 <1fc37850-e74a-47a8-9c74-2fa08b4eae9e@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc37850-e74a-47a8-9c74-2fa08b4eae9e@solid-run.com>

On Fri, Mar 22, 2024 at 06:33:28PM +0000, Josua Mayer wrote:
> Am 17.03.24 um 22:45 schrieb Andrew Lunn:
> > Add a set of helpers for parsing the standard device tree properties
> > for LEDs are part of an ethernet device, and registering them with the
> > LED subsystem. This code can be used by any sort of netdev driver, DSA
> > switch or pure switchdev switch driver.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > ...
> >
> > +struct netdev_leds_ops {
> > +	int (*brightness_set)(struct net_device *ndev, u8 led,
> > +			      enum led_brightness brightness);
> > +	int (*blink_set)(struct net_device *ndev, u8 led,
> > +			 unsigned long *delay_on,  unsigned long *delay_off);
> > +	int (*hw_control_is_supported)(struct net_device *ndev, u8 led,
> > +				       unsigned long flags);
> > +	int (*hw_control_set)(struct net_device *ndev, u8 led,
> > +			      unsigned long flags);
> > +	int (*hw_control_get)(struct net_device *ndev, u8 led,
> > +			      unsigned long *flags);
> > +};
> I noticed phy.h calls the "flags" argument "rules" instead,
> perhaps that is more suitable.

The naming is a bit inconsistent. include/linux/leds.h uses:

        /*
         * Check if the LED driver supports the requested mode provided by the
         * defined supported trigger to setup the LED to hw control mode.
         *
         * Return 0 on success. Return -EOPNOTSUPP when the passed flags are not
         * supported and software fallback needs to be used.
         * Return a negative error number on any other case  for check fail due
         * to various reason like device not ready or timeouts.
         */
        int                     (*hw_control_is_supported)(struct led_classdev *led_cdev,
                                                           unsigned long flags);
        /*
         * Activate hardware control, LED driver will use the provided flags
         * from the supported trigger and setup the LED to be driven by hardware
         * following the requested mode from the trigger flags.
         * Deactivate hardware blink control by setting brightness to LED_OFF via
         * the brightness_set() callback.
         *
         * Return 0 on success, a negative error number on flags apply fail.
         */
        int                     (*hw_control_set)(struct led_classdev *led_cdev,
                                                  unsigned long flags);
        /*
         * Get from the LED driver the current mode that the LED is set in hw
         * control mode and put them in flags.
         * Trigger can use this to get the initial state of a LED already set in
         * hardware blink control.
         *
         * Return 0 on success, a negative error number on failing parsing the
         * initial mode. Error from this function is NOT FATAL as the device
         * may be in a not supported initial state by the attached LED trigger.
         */
        int                     (*hw_control_get)(struct led_classdev *led_cdev,
                                                  unsigned long *flags);

So if anything, phy.h should really change to use flags.

   Andrew


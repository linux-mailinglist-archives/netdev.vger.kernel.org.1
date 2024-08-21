Return-Path: <netdev+bounces-120415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3A9593B4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79371C213CE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 04:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB05588F;
	Wed, 21 Aug 2024 04:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E72B9B7
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724215554; cv=none; b=I3tXbwq8mrbriQE+wFpn6EmPOWbKichdZ00XAP5tHTYTNBzHfdtQT/Jj4+g/wNKskj0pzTYRTOI/dKrrVUSPmb6JCxEk30HhcD/tX6wuQLCtOwsoAF5yYROgkFlj+C6E7kkUNZGF/tpIO9mlmDptP4NKTqUw+JVZXvB8JOTFHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724215554; c=relaxed/simple;
	bh=jZz3LWN68RnPgIUqgxrVPxpg+fdNLalxNbimRc3RCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRAvhxId4WGOu8uCO5ZpuTq6p4wg4pokyL9kSS+C9J5aP0I4hGvINmdQ+8zvNiC6SI7gTRWWgHIN7lOUh2a7zwUDoq86yJJrF8D/E120xnwb7tEcvYXXMHm+B3v04di8LPV0jo0Veg9dWSLeWmlUQcbScw8o8molGb/B3i2KClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgdDu-00077x-HS; Wed, 21 Aug 2024 06:45:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgdDs-001vi2-ME; Wed, 21 Aug 2024 06:45:28 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgdDs-00FNkZ-1l;
	Wed, 21 Aug 2024 06:45:28 +0200
Date: Wed, 21 Aug 2024 06:45:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Message-ID: <ZsVw6NkVGNEfS-4R@pengutronix.de>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
 <20240819190151.93253-3-kyle.swenson@est.tech>
 <ZsQ2fuqWkMYwq_kh@pengutronix.de>
 <ZsUFLDaMdVPQQ98I@p620>
 <ZsUGbsnkvCr_tyqS@p620>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsUGbsnkvCr_tyqS@p620>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kyle,

On Tue, Aug 20, 2024 at 09:11:22PM +0000, Kyle Swenson wrote:
> On Tue, Aug 20, 2024 at 03:06:19PM -0600, Kyle Swenson wrote:
> > Hi Oleksij,
> > 
> > On Tue, Aug 20, 2024 at 08:23:58AM +0200, Oleksij Rempel wrote:
> > > Hi Kyle,
> > > 
> > > thank you for you patch.
> > Thanks for the review!
> > > 
> > > On Mon, Aug 19, 2024 at 07:02:14PM +0000, Kyle Swenson wrote:
> > > > The TPS23880/1 has an active-low reset pin that some boards connect to
> > > > the SoC to control when the TPS23880 is pulled out of reset.
> > > > 
> > > > Add support for this via a reset-gpios property in the DTS.
> > > > 
> > > > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > > > ---
> > > >  drivers/net/pse-pd/tps23881.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> > > > index 2ea75686a319..837e1a2119ee 100644
> > > > --- a/drivers/net/pse-pd/tps23881.c
> > > > +++ b/drivers/net/pse-pd/tps23881.c
> > > > @@ -6,16 +6,16 @@
> > > >   */
> > > >  
> > > >  #include <linux/bitfield.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/firmware.h>
> > > > +#include <linux/gpio/consumer.h>
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pse-pd/pse.h>
> > > > -
> > > 
> > > No need to remove space here.
> > 
> > Sorry about this, somehow I missed this gratuitous diff
> > 
> > > 
> > > >  #define TPS23881_MAX_CHANS 8
> > > >  
> > > >  #define TPS23881_REG_PW_STATUS	0x10
> > > >  #define TPS23881_REG_OP_MODE	0x12
> > > >  #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
> > > > @@ -735,10 +735,11 @@ static int tps23881_flash_sram_fw(struct i2c_client *client)
> > > >  
> > > >  static int tps23881_i2c_probe(struct i2c_client *client)
> > > >  {
> > > >  	struct device *dev = &client->dev;
> > > >  	struct tps23881_priv *priv;
> > > > +	struct gpio_desc *reset;
> > > >  	int ret;
> > > >  	u8 val;
> > > >  
> > > >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > > >  		dev_err(dev, "i2c check functionality failed\n");
> > > > @@ -747,10 +748,20 @@ static int tps23881_i2c_probe(struct i2c_client *client)
> > > >  
> > > >  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > >  	if (!priv)
> > > >  		return -ENOMEM;
> > > >  
> > > > +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(reset))
> > > > +		return dev_err_probe(&client->dev, PTR_ERR(reset), "Failed to get reset GPIO\n");
> > > > +
> > > > +	if (reset) {
> > > > +		usleep_range(1000, 10000);
> > > > +		gpiod_set_value_cansleep(reset, 0); /* De-assert reset */
> > > > +		usleep_range(1000, 10000);
> > > 
> > > According to the datasheet, page 13:
> > > https://www.ti.com/lit/ds/symlink/tps23880.pdf
> > > 
> > > Minimal reset time is 5 microseconds and the delay after power on reset should
> > > be at least 20 milliseconds. Both sleep values should be corrected.
> > 
> > Sounds reasonable, I'll change the first delay to be closer to the 5us
> > minimum reset time.  I need to review the docs around delays to pick the
> > correct one for this case.
> > 
> > For the 2nd delay, I (now) see the 20ms you're referring to in the datasheet.
> > 
> > I was looking at the SRAM programming document
> > (https://www.ti.com/lit/pdf/SLVAE1) and it indicates we should delay the
> 
> Sorry, this is the wrong link.  Let me try again:
> 
> https://www.ti.com/lit/pdf/slvae12
> 
> 
> > SRAM and parity programming by at least 50ms after initial power on.
> > 
> > Should we guarantee we meet that 50ms requirement with the 2nd delay or
> > would you prefer I just meet the 20ms requirement in the datasheet?

Ah, I see. The easiest way would be to wait 50ms, otherwise we will need
to do some more code to get this 50ms requirement.
Please add comments to the code describing the reason for one or another
delay. And, please use name and revision of documentation you used for this
choice.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-133760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD7996F9F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A55283F2F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035D1E04A0;
	Wed,  9 Oct 2024 15:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A61E009C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486998; cv=none; b=gt7nF2CLY5UacMt0GqrFusiOGQS3y+eUmNaIQyEDQpGzYyXGXKT5toEo/kcBebwwOFg1nmqfAfgNGTaQja2YblWTJ7w93rJl8L32jF2CxY8jG6MC3LN1zIF9mq0+nYJT7BpPkPTusi5erzfDMkwvTFxCw7e/7DDMYpgarixXveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486998; c=relaxed/simple;
	bh=erbjsBtCILmKJ+nigxio9EUrqkSXvbmuLoXoTa3lE+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZvSLyGISkZRi8CTNG/VhHuDSAb+kSftHYp8UJfbqZNzHihOAlJabnR4k5vDrhrEH37Iy2VXWmqRh/XzNH/9znJXiRsDio/5d5Dludefwo2qZcfq99eMM8i63MuMjW/D1jwDuwdxF6DXgYj/2T34XRwNKQQtsXQhVhSmy9a/q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syYQK-0000cM-0b; Wed, 09 Oct 2024 17:16:24 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syYQG-000dE4-In; Wed, 09 Oct 2024 17:16:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syYQG-002AnD-1Y;
	Wed, 09 Oct 2024 17:16:20 +0200
Date: Wed, 9 Oct 2024 17:16:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 04/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Message-ID: <ZwaeRL9z310dBBlh@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
 <ZwYOboTdMppaZVmX@pengutronix.de>
 <20241009110501.5f776c9b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009110501.5f776c9b@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 09, 2024 at 11:05:01AM +0200, Kory Maincent wrote:
> On Wed, 9 Oct 2024 07:02:38 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Wed, Oct 02, 2024 at 06:28:00PM +0200, Kory Maincent wrote:
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > 
> > > Expand PSE callbacks to support the newly introduced
> > > pi_get/set_current_limit() and pi_get_voltage() functions. These callbacks
> > > allow for power limit configuration in the TPS23881 controller.
> > > 
> > > Additionally, the patch includes the detected class, the current power
> > > delivered and the power limit ranges in the status returned, providing more
> > > comprehensive PoE status reporting.
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > > +static int tps23881_pi_get_class(struct tps23881_priv *priv, int id)
> > > +{  
> > ....
> > > +	if (chan < 4)
> > > +		class = ret >> 4;
> > > +	else
> > > +		class = ret >> 12;  
> > 
> > ....
> > > +tps23881_pi_set_2p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pol)
> > > +{  
> > ....
> > > +	reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
> > > +	ret = i2c_smbus_read_word_data(client, reg);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (chan < 4)
> > > +		val = (ret & 0xff00) | pol;
> > > +	else
> > > +		val = (ret & 0xff) | (pol << 8);  
> > 
> > This is a common pattern in this driver, we read and write two registers
> > in one run and then calculate bit offset for the channel, can you please
> > move it in to separate function. This can be done in a separate patch if
> > you like.
> 
> The pattern is common but the operations are always different so I didn't found
> a clean way of doing it.
> Here is a listing of it:
> 	if (chan < 4)
> 		class = ret >> 4;
> 	else
> 		class = ret >> 12;
> 
> 	if (chan < 4)
> 		val = (ret & 0xff00) | pol;
> 	else
> 		val = (ret & 0xff) | (pol << 8);  
> 
>         if (chan < 4)                                                           
>                 val = (u16)(ret | BIT(chan));                                   
>         else                                                                    
>                 val = (u16)(ret | BIT(chan + 4));
> 
> 	if (chan < 4)
> 		mW = (ret & 0xff) * TPS23881_MW_STEP;
> 	else
> 		mW = (ret >> 8) * TPS23881_MW_STEP;
> 
> 
> Any idea?
> 

something like this:

/*
 * Helper to extract a value from a u16 register value, which is made of two u8 registers.
 * The function calculates the bit offset based on the channel and extracts the relevant
 * bits using a provided field mask.
 *
 * @param reg_val: The u16 register value (composed of two u8 registers).
 * @param chan: The channel number (0-7).
 * @param field_offset: The base bit offset to apply (e.g., 0 or 4).
 * @param field_mask: The mask to apply to extract the required bits.
 * @return: The extracted value for the specific channel.
 */
static u16 tps23881_calc_val(u16 reg_val, u8 chan, u8 field_offset, u16 field_mask)
{
        u8 bit_offset;

        if (chan < 4) {
                bit_offset = field_offset;
        } else {
                bit_offset = field_offset;
                reg_val >>= 8;
        }

        return (reg_val >> bit_offset) & field_mask;
}

/*
 * Helper to combine individual channel values into a u16 register value.
 * The function sets the value for a specific channel in the appropriate position.
 *
 * @param reg_val: The current u16 register value.
 * @param chan: The channel number (0-7).
 * @param field_offset: The base bit offset to apply (e.g., 0 or 4).
 * @param field_mask: The mask to apply for the field (e.g., 0x0F).
 * @param field_val: The value to set for the specific channel (masked by field_mask).
 * @return: The updated u16 register value with the channel value set.
 */
static u16 tps23881_set_val(u16 reg_val, u8 chan, u8 field_offset, u16 field_mask, u16 field_val)
{
        u8 bit_offset;

        field_val &= field_mask;

        if (chan < 4) {
                bit_offset = field_offset;
                reg_val &= ~(field_mask << bit_offset);
                reg_val |= (field_val << bit_offset);
        } else {
                bit_offset = field_offset;
                reg_val &= ~(field_mask << (bit_offset + 8));
                reg_val |= (field_val << (bit_offset + 8));
        }

        return reg_val;
}
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


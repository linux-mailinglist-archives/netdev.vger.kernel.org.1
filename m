Return-Path: <netdev+bounces-43490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641287D3973
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037A4B20D4B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68D3D7B;
	Mon, 23 Oct 2023 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93079F9
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:36:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0AE10C
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:36:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quw2m-0001qy-Tq; Mon, 23 Oct 2023 16:36:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1quw2l-003ja7-Nd; Mon, 23 Oct 2023 16:36:35 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quw2l-00Fx3X-Kn; Mon, 23 Oct 2023 16:36:35 +0200
Date: Mon, 23 Oct 2023 16:36:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, f.fainelli@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com, robh+dt@kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231023143635.GD3787187@pengutronix.de>
References: <20231023114916.GC3787187@pengutronix.de>
 <20231023124130.3158-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023124130.3158-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Oct 23, 2023 at 02:41:30PM +0200, Ante Knezic wrote:
> On Mon, 23 Oct 2023 13:49:16 +0200, Oleksij Rempel wrote:
> 
> > In case of KSZ8873 we seems to have something like:
> > 
> > Switch MAC<-.
> >             |
> >   PLL -> clk sel -> REFCLKO
> >             \-----< REFCLKI
> > 
> > Clock select in this case is controlled by Register 198 (0xC6).
> > 
> > In case of KSZ9897 we probably have something like:
> > 
> > Switch MAC<-.
> >             |
> >   PLL -> clk sel -> REFCLKO
> >             \--x--< REFCLKI
> >                |
> >             Gate REFCLKI if REFCLKO is used.
> > 
> > In both cases:
> > - KSZ8873, Setting bit3 in Register 198 (0xC6) will control use of clk
> >   select
> > - KSZ9897, setting bit2 in Register 0xN301, will controll use of clk
> >   select and probably gate REFCLKI.
> > 
> > So far, it looks very similar to me and it is usually handled by
> > phy-mode rmii vs revrmii. Correct?
> 
> Thats correct I guess with one important point: default setting for KSZ88X3 is
> not to gate back to REFCLKI, while KSZ9897 will (correct me if I am wrong) 
> automatically gate to REFCLKI and does not have the ability to gate/not-to-gate
> REFCLKO to REFCLKI with any register setting. Thats more-less what this patch
> is all about. Something that is automatically active (and can not be changed
> during run-time?) on KSZ9897 needs to be manually configured on KSZ88X3.

If I see it correctly, in both cases there is only one bit to configure
direction. The code need to support two interface modes:
- PHY_INTERFACE_MODE_RMII (MAC mode) PLL is the clock provider. REFCLKO
  is used.
- PHY_INTERFACE_MODE_REVRMII (PHY mode) PLL is not used, REFCLKI is the
  clock provider.

Linkmodes for KSZ9xxx series are implemented in the ksz_set_xmii()
function.

I already did some work to configure CPU interface, where which can be at least
partially reused for your work:
https://lore.kernel.org/all/20230517121034.3801640-2-o.rempel@pengutronix.de/
(Looks I forgot to complete mainlining for this patch)

If implanted as described, no new devicetree properties will be needed.

> > So, the main question is still, do we need this kind of configuration
> > per port or it is enough to have it per switch?
> 
> Thats something on which more experienced developers/maintainers may have more
> to say, my impression is that its somewhat specific to KSZ88X3 to have this
> option available and the location of the register itself also makes a point on
> its own. I may be wrong about this of course.
> 
> > For some reasons KSZ8863MLL datasheet provides RMII clock select
> > configuration for two ports (port 1 and 3)
> > https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8863MLL-FLL-RLL-Data-Sheet-00002335C.pdf
> > May be there are variants with two RMIIs?
> 
> As you noticed KSZ8863 provides configuration for port1 as well, but I was not
> able to find any reference to what it may actually select. The product
> identification system for ksz8863 does not mention devices with 2 RMII
> interfaces. The KSZ8873 has this bit set to "Reserved" so I can't really
> tell whats going on there...
> 
> > Something similar but with multiple RMII interfaces seems to be
> > supported by KSZ8864CNX:
> > https://eu.mouser.com/datasheet/2/268/00002229A-1082534.pdf
> > 
> 
> As well as these datasheets are sometimes muddled and difficult to get a grasp of
> by looking at the KSZ8873 datasheet it seems to me that it can select between
> "clock" (default) and "normal" mode, which is something similar to the 
> rmii-clk-internal property of KSZ88X3 devices, however this mode of operation 
> seems to be selectable only at boot time by strap pins (see description of 
> Register 12 (Global Control 10).

Ack. No need to worry about this one for now, it was only as example of a ksz8
style device with multiple RMII ports.

> > And all KSZ9xxx series seems to handle it per port as well.
> 
> I guess you are refering to register 87 (RMII Management Control Register)?
> But this only selects whether to enable clock output on RXC pin?

RXC seems to be not correct description or may be just internal signal
within the IP core. This register points to the strap pin affecting value of
this bit. Reading strap description in KSZ9477S or KSZ9897S give better
idea about meaning of this bit:

0: MII: PHY Mode (Default)
   RMII: Clock Mode. RMII 50MHz reference clock is output on REFCLKO6. (Default)
   RGMII: No effect
1: MII: MAC Mode
   RMII: Normal Mode. RMII 50MHz reference clock is input on REFCLKI6.
   RGMII: No effect

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


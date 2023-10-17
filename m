Return-Path: <netdev+bounces-41687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F87CBAE5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ACC2813C9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C1D2FC;
	Tue, 17 Oct 2023 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321A3D86
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:19:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF89AB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:19:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qsdQ6-0007Li-W2; Tue, 17 Oct 2023 08:19:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qsdQ5-002Fuq-N5; Tue, 17 Oct 2023 08:19:09 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qsdQ5-00ErhU-Jz; Tue, 17 Oct 2023 08:19:09 +0200
Date: Tue, 17 Oct 2023 08:19:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/9] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20231017061909.GB3539182@pengutronix.de>
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-5-o.rempel@pengutronix.de>
 <97df39dc-daae-4334-bb80-d690851e5269@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97df39dc-daae-4334-bb80-d690851e5269@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 08:37:50AM -0700, Florian Fainelli wrote:
> [snip]
> > +void ksz9477_get_wol(struct ksz_device *dev, int port,
> > +		     struct ethtool_wolinfo *wol)
> > +{
> > +	u8 pme_ctrl, pme_conf;
> > +	int ret;
> > +
> > +	ret = ksz_read8(dev, REG_SW_PME_CTRL, &pme_conf);
> > +	if (ret)
> > +		return;
> > +
> > +	if (!(pme_conf & PME_ENABLE))
> > +		return;
> 
> I suppose this works beause you have separate enable bits for WOL_LINKUP,
> WOL_ENERGY and WOL_MAGICPKT, you could have also left the setting of the
> PME_ENABLE bit to the set_wol() routine provided that wol->wolopts is
> non-zero.

Setting the PME_ENABLE bit in the set_wol() function might imply that it
should also be cleared within set_wol(), necessitating refcounting due
to its global bit nature.

As an alternative, the reading of the REG_SW_PME_CTRL register could be
replaced by checking the wakeup_source variable, which might result in
some optimization.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-43374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864617D2C14
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4073928142F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5010A1F;
	Mon, 23 Oct 2023 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE410954
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:59:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79092D66
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:58:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quppp-0004Ut-Kh; Mon, 23 Oct 2023 09:58:49 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1quppo-003ei6-D0; Mon, 23 Oct 2023 09:58:48 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quppo-00FtCD-9u; Mon, 23 Oct 2023 09:58:48 +0200
Date: Mon, 23 Oct 2023 09:58:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: olteanv@gmail.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231023075848.GA3786047@pengutronix.de>
References: <20231020143759.eknrcfbztrc543mm@skbuf>
 <20231023072700.17060-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023072700.17060-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Oct 23, 2023 at 09:27:00AM +0200, Ante Knezic wrote:
> On Fri, 20 Oct 2023 17:37:59 +0300, Vladimir Oltean wrote:
> 
> > Sorry, I didn't realize on v3 that you didn't completely apply my
> > feedback on v2. Can "microchip,rmii-clk-internal" be a port device tree
> > property? You have indeed moved its parsing to port code, but it is
> > still located directly under the switch node in the device tree.
> > 
> > I'm thinking that if this property was also applicable to other switches
> > with multiple RMII ports, the setting would be per port rather than global.
> 
> As far as I am aware only the KSZ8863 and KSZ8873 have this property available,
> but the biggger issue might be in scaling this to port property as the register
> "Forward Invalid VID Frame and Host Mode" where the setting is applied is
> located under "Advanced Control Registers" section which is actually global at
> least looking from the switch point of view. Usually port properties are more
> applicable when registers in question are located under "Port Registers" section.
> This is somewhat similar to for example enabling the tail tag mode which is 
> again used only by the port 3 interface and is control from "Global Control 1"
> register.
> With this in mind - if you still believe we should move this to port dt 
> property, then should we forbid setting the property for any other port other 
> than port 3, and can/should this be enforced by the dt schema?
> 

If I see it correctly, KSZ9897R supports RMII on two ports (6 and 7)
with configurable clock direction. See page 124 "5.2.3.2 XMII Port Control 1
Register"
http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


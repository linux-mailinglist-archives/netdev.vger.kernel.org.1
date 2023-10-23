Return-Path: <netdev+bounces-43383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E07D2CFB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3ED1C20995
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC6101C0;
	Mon, 23 Oct 2023 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD97472
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:42:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138EFDD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:42:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quqVT-0002jy-33; Mon, 23 Oct 2023 10:41:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1quqVS-003fNO-DD; Mon, 23 Oct 2023 10:41:50 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1quqVS-00FtcB-AO; Mon, 23 Oct 2023 10:41:50 +0200
Date: Mon, 23 Oct 2023 10:41:50 +0200
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
Message-ID: <20231023084150.GB3787187@pengutronix.de>
References: <20231023075848.GA3786047@pengutronix.de>
 <20231023082230.17772-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023082230.17772-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Oct 23, 2023 at 10:22:30AM +0200, Ante Knezic wrote:
> On Mon, 23 Oct 2023 09:58:48 +0200, Oleksij Rempel wrote:
> 
> > If I see it correctly, KSZ9897R supports RMII on two ports (6 and 7)
> > with configurable clock direction. See page 124 "5.2.3.2 XMII Port Control 1
> > Register"
> > http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> 
> Clock direction is possible I guess with other devices as well, but I don't see
> this specific property (routing REFCLKO to REFCLKI internally when switch is
> used as clock provider) for any other, including KSZ9897?
>
> I am no expert on micrel switches, but this to me looks like something specific
> only to KSZ88X3 devices as the clocking seems a bit different on KSZ9897 and
> alike. KSZ88X3 may generate clock to REFCLKO but still needs this clock fed
> back to REFCLKI (or will be routed internally with the "microchip-rmii-internal"
> property). This is managed differently on KSZ9897?

Here is KSZ8873 as initial reference:
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/00002348A.pdf
3.3.9 RMII INTERFACE OPERATION:
"When EN_REFCLKO_3 is high, KSZ8873RLL will output a 50 MHz in REFCLKO_3.
Register 198 bit[3] is used to select internal or external reference
clock. Internal reference clock means that the clock for the RMII of
KSZ8873RLL will be provided by the KSZ8873RLL internally and the
REFCLKI_3 pin is unconnected. For the external reference clock, the
clock will provide to KSZ8873RLL via REFCLKI_3."

KSZ9897:
http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
4.11.2 REDUCED MEDIA INDEPENDENT INTERFACE (RMII)

"The user selects one of the two RMII clocking modes by setting the
appropriate strapping option. The clocking mode is selected separately
for ports 6 and 7.

While in RMII Normal Mode, the port will require an external 50MHz
signal to be input to TX_CLKx/REFCLKIx from an external source. This
mode is selected by strapping the appropriate pin (RXD6_1 for port 6;
RXD7_1 for port 7) high during reset.

While in RMII Clock Mode, the port will output a 50MHz clock on
RX_CLKx/REFCLKOx, which is derived from the 25MHz crystal or oscillator
attached to the XI clock input. The TX_CLKx/REFCLKIx input is unused in
this mode. This mode is selected by strapping the appropriate pin
(RXD6_1 for port 6; RXD7_1 for port 7) low during reset.
"

Information about corresponding bits I linked in previous email.

I do not see much differences.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


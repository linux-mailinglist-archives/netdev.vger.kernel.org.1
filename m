Return-Path: <netdev+bounces-23892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B063076E054
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F82281F91
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6D8F57;
	Thu,  3 Aug 2023 06:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C66D1B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:37:25 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC01706
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 23:37:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qRRwt-0004xV-Ry; Thu, 03 Aug 2023 08:36:39 +0200
Message-ID: <22f979e8-7591-3393-f323-114da0131e7a@pengutronix.de>
Date: Thu, 3 Aug 2023 08:36:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [EXT] Re: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
To: Shenwei Wang <shenwei.wang@nxp.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Simon Horman <simon.horman@corigine.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Wong Vee Khee <veekhee@apple.com>, Revanth Kumar Uppala
 <ruppala@nvidia.com>, Jochen Henneberg <jh@henneberg-systemdesign.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, Frank Li <frank.li@nxp.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-3-shenwei.wang@nxp.com>
 <bf2979c4-0b63-be53-b530-3d7385796534@pengutronix.de>
 <PAXPR04MB9185D7D3B088E4786A216044890AA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <e32c89e1-7385-105b-63c9-74f58c2253cb@pengutronix.de>
 <PAXPR04MB91851BB5D1375AF0EF3C51B7890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <49d52a10-20cf-9c5b-ebe3-07292664fe11@pengutronix.de>
 <PAXPR04MB9185C0C3B3E41534F555BC43890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <PAXPR04MB9185C0C3B3E41534F555BC43890BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

[snip]
>>>
>>>> Also: does this only apply to i.MX93, or would we have to test and
>>>> enable it on e.g. i.MX8MP as well?
>>>>
>>>
>>> Yes, it is required when the EQOS MAC is selected. However, this patch
>>> just enables The feature on i.MX93.
>>
>> If this behaviour is required on all EQOS, I think the name
>> imx_dwmac_fix_speed_mx93() is misleading. It should either be
>> imx_dwmac_fix_speed() if applicable to all imx implementations, or
>> dwmac_fix_speed() (and moved to a non-gluecode file) if applicable for all
>> implementations in general.
>>
> 
> It has the general fix_speed function there named imx_dwmac_fix_speed.
> This one is the special for this mx93 fix.

I think I might have misunderstood your last statement or I failed to express 
my point. If you need to replace the dwmac_fix_speed() on mx93, because this 
SoC implementation requires doing so (the usual reason for doing something like 
this is something like reset quirks because of screwed up IP Core integration), 
then your approach is imho valid.

But if I got your last comment right, your changes should apply to EQOS MAC in 
general (but you want to only enable it for mx93 at the moment). In this case 
this quirk will later be as the fix_mac_speed function for other hardware as 
well, in which case the name ..._mx93 is misleading, and imho rather a 
descriptive name should be used (i.e. have the name describe what it does 
rather than for what hardware it is implemented).

Except if the maintainers have a strong opinion that the ..._mx93 suffix 
version is exactly how you should proceed...

Best regards
Johannes

> 
> Thanks,
> Shenwei
> [snip]


-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |



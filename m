Return-Path: <netdev+bounces-21724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3A764710
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C425A1C214EA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C05AD2C;
	Thu, 27 Jul 2023 06:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D504A93C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:41:26 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A353A81
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:41:04 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qOugC-0002Bi-91; Thu, 27 Jul 2023 08:40:56 +0200
Message-ID: <f7849436-8dac-64b1-8ec6-3aced13bee94@pengutronix.de>
Date: Thu, 27 Jul 2023 08:40:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
To: Richard Cochran <richardcochran@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Eric Dumazet <edumazet@google.com>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, patchwork-jzi@pengutronix.de
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <20230726-dreamboat-cornhusk-1bd71d19d0d4-mkl@pengutronix.de>
 <ZME88hOgNug+PFga@hoboy.vegasvil.org>
From: Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZME88hOgNug+PFga@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Richard,

On 7/26/23 17:34, Richard Cochran wrote:
> On Wed, Jul 26, 2023 at 08:04:37AM +0200, Marc Kleine-Budde wrote:
> 
>> At least the datasheet of the IP core tells to read the MAC delay from
>> the IP core (1), add the PHY delay (2) and the clock domain crossing
>> delay (3) and write it to the time stamp correction register.
> 
> That is great, until they change the data sheet.  Really, this happens.

I think I don't get your point here.

That's true for literally any register of any peripheral in a datasheet.
I think we can just stop doing driver development if we wait for a final
revision that is not changed any more. Datasheets change, and if they do we
update the driver.

Johannes


> 
> Thanks,
> Richard
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |



Return-Path: <netdev+bounces-19559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72B75B316
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F66281C9B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CA18C0D;
	Thu, 20 Jul 2023 15:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C918B11
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:39:13 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D092D51
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:39:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qMVjn-0000me-3S; Thu, 20 Jul 2023 17:38:43 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qMVjj-0001sD-IF; Thu, 20 Jul 2023 17:38:39 +0200
Date: Thu, 20 Jul 2023 17:38:39 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230720153839.klrukzea3o2dxif7@pengutronix.de>
References: <20230718132049.3028341-1-m.felsch@pengutronix.de>
 <20230718132049.3028341-2-m.felsch@pengutronix.de>
 <20230719211235.1758bbc0@kernel.org>
 <20230720064636.5l45ad64kwwgd2iw@pengutronix.de>
 <20230720081945.5cf783f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720081945.5cf783f0@kernel.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23-07-20, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 08:46:36 +0200 Marco Felsch wrote:
> > > Please fix and rebase because the current version does not apply to
> > > net-next/main.  
> > 
> > Sure, I thought the changelog should be part of the commit message in
> > net-dev therefore I included it.
> 
> Old rules, I think. Since started adding lore links to all patches you
> can put the changelog in the cut-off section.

Make sense.

> Adding a link to the previous revision there is highly encouraged,
> too!

Sure, I will check my tooling to use b4 for sending, so the links are
provided autom.

> There's a sample of the preferred format at:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested

I will keep that in mind.

Regards,
  Marco


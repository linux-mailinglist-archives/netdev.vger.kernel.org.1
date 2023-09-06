Return-Path: <netdev+bounces-32205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9497937CF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580D31C20998
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458151113;
	Wed,  6 Sep 2023 09:13:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6062B
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 09:13:18 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF0395;
	Wed,  6 Sep 2023 02:13:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 654EF60013;
	Wed,  6 Sep 2023 09:13:12 +0000 (UTC)
Date: Wed, 6 Sep 2023 11:13:16 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove unneeded stmmac_poll_controller
Message-ID: <ZPhCrPlFzBDaco0f@pilgrim>
References: <20230831120004.6919-1-repk@triplefau.lt>
 <20230905151751.1b2148ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905151751.1b2148ad@kernel.org>
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 03:17:51PM -0700, Jakub Kicinski wrote:
> On Thu, 31 Aug 2023 14:00:04 +0200 Remi Pommarel wrote:
> > Using netconsole netpoll_poll_dev could be called from interrupt
> > context, thus using disable_irq() would cause the following kernel
> > warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:
> 
> Could you rebase this on top of netdev/net? It does not apply:

Sure will do, thanks.


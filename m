Return-Path: <netdev+bounces-38373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1307BA9CF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 513AE281BB9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433D41223;
	Thu,  5 Oct 2023 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976129422
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:11:09 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41DD3CE;
	Thu,  5 Oct 2023 12:11:08 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1qoTkV-0004ws-00; Thu, 05 Oct 2023 21:11:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id AB72AC0148; Thu,  5 Oct 2023 21:07:01 +0200 (CEST)
Date: Thu, 5 Oct 2023 21:07:01 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare for
 platform removal
Message-ID: <ZR8JVc/o5MQ7vs1f@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
 <ZR7Dd8wy91+G2U3v@alpha.franken.de>
 <20231005071634.581fa8c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005071634.581fa8c2@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 07:16:34AM -0700, Jakub Kicinski wrote:
> On Thu, 5 Oct 2023 16:08:55 +0200 Thomas Bogendoerfer wrote:
> > On Fri, Sep 22, 2023 at 08:15:26AM +0200, Wolfram Sang wrote:
> > > AR7 is going to be removed from the Kernel, so remove its networking
> > > support in form of the cpmac driver. This allows us to remove the
> > > platform because this driver includes a platform specific header.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > > Changes since v1:
> > > * added ack
> > > 
> > >  MAINTAINERS                      |    6 -
> > >  drivers/net/ethernet/ti/Kconfig  |    9 +-
> > >  drivers/net/ethernet/ti/Makefile |    1 -
> > >  drivers/net/ethernet/ti/cpmac.c  | 1251 ------------------------------
> > >  4 files changed, 1 insertion(+), 1266 deletions(-)
> > >  delete mode 100644 drivers/net/ethernet/ti/cpmac.c
> > > [..]  
> > 
> > is it ok for network people to route this patch via mips-next tree
> > or do you want to apply to net-next ?
> 
> We have a ".remove callback should return void" conversion from Uwe
> queued for the deleted driver (231ea972ccaf5b). The conflict will be
> really trivial, but I guess no conflict beats trivial conflict so better
> if we take it? :S

makes sense, so I'll just apply the other patches.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


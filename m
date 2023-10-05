Return-Path: <netdev+bounces-38283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095B7B9EF0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0830F281E3B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAED28DD7;
	Thu,  5 Oct 2023 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz60a5Ea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330021105
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3ACC43140;
	Thu,  5 Oct 2023 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696515395;
	bh=nNp35xI077yQXxP8uX1fwQCGUbyzwbzHw+RybI+zhrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fz60a5EalsIPlI5xmAewZKSyJP5mY4XoFeQDpBsnmgL9e7G3G8SljF26stQkNdgNS
	 HILBXuyxFF8L90iDCJZAHTiMcIsmnVR6DjcB3jDHb4St7B8foBOfQcLv0hFXxLjJg3
	 7IpJA8Pukze6X5P3okmQPKniObWAkfUBWBtgAu1PNSga3fZg0+qfhgqxv8lsOWXTR4
	 bmcI1hsszsN8RyCCYkOwQOZGLqYfdfa8dJYOaml+R1cz5vw2z5j1xlbX6ZC1U78mnM
	 cZjyEBd9R9bJgTvrWr03+hGL1ZngMpOrph7iiQMnoluZB8btSQNcR6VeVuuAwgeHMn
	 Y2JAy24wGJspg==
Date: Thu, 5 Oct 2023 07:16:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>, Florian
 Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare
 for platform removal
Message-ID: <20231005071634.581fa8c2@kernel.org>
In-Reply-To: <ZR7Dd8wy91+G2U3v@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
	<20230922061530.3121-6-wsa+renesas@sang-engineering.com>
	<ZR7Dd8wy91+G2U3v@alpha.franken.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 16:08:55 +0200 Thomas Bogendoerfer wrote:
> On Fri, Sep 22, 2023 at 08:15:26AM +0200, Wolfram Sang wrote:
> > AR7 is going to be removed from the Kernel, so remove its networking
> > support in form of the cpmac driver. This allows us to remove the
> > platform because this driver includes a platform specific header.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Changes since v1:
> > * added ack
> > 
> >  MAINTAINERS                      |    6 -
> >  drivers/net/ethernet/ti/Kconfig  |    9 +-
> >  drivers/net/ethernet/ti/Makefile |    1 -
> >  drivers/net/ethernet/ti/cpmac.c  | 1251 ------------------------------
> >  4 files changed, 1 insertion(+), 1266 deletions(-)
> >  delete mode 100644 drivers/net/ethernet/ti/cpmac.c
> > [..]  
> 
> is it ok for network people to route this patch via mips-next tree
> or do you want to apply to net-next ?

We have a ".remove callback should return void" conversion from Uwe
queued for the deleted driver (231ea972ccaf5b). The conflict will be
really trivial, but I guess no conflict beats trivial conflict so better
if we take it? :S


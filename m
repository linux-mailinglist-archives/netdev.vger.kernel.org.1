Return-Path: <netdev+bounces-94465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F38BF8E2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0424628712A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895754744;
	Wed,  8 May 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1lkVOCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA51DA21;
	Wed,  8 May 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157568; cv=none; b=qOeoV8aHRdVPIr84fewkr8Dzr0iN1X6WWhXoem5Dgz8kwLuIIoxhyaNhRcQRzaf2ZxDQuR+3p5Rtiyg/M045ndEiWDTYskoINKerH++FTszyj7XziEUbMDqmiX9gLG+Pwae8YN3EyljnkbJglRDpOFjQgSGHFTpDPRnvlCypbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157568; c=relaxed/simple;
	bh=Az+mUCgN8cLAqPcKX4l3XwNzu3OaAIxFfUYbqtcwBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4dKT6L1GyGNp3hP+PjxFere+8VOekH9fn0AZhBukeikysZyBglbbbaudEuZvAtUiS7fn5f5OZbC6oJVTk46+5MRLvKJIjlWeEhPeMv0UETxFHBHR+rsO5dGUGmsgFqKT7LX1xxVSdGsh0T3+jqAifY/mfGu7imYJ7jg6mXBck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1lkVOCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FC1C113CC;
	Wed,  8 May 2024 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715157568;
	bh=Az+mUCgN8cLAqPcKX4l3XwNzu3OaAIxFfUYbqtcwBuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1lkVOCSWSDjLVLMNkECiGVwa6umncB49gFnCQxqigWFKIpPxEKkYqr0QZ3w8N0e3
	 LS6ql/n22qnxqojctbzGjBExsEeOkfqsuEOlnIc68UZuSFp1fFHVhnBWwe8lXzgmZG
	 PMmzM/hPwJBWRBbOHa3mq05shSwDOQQYqPWt1GxVMlQ8c2wiY2vV7pErPGNpSt+CLU
	 fqUfhgmyKKReB1QrrjpgePn9MEJvxnMUTrmNKv6RQdU3VtDdw+ioNIpB2pR9jvk8iA
	 9Vx2Apak6rHvL1NPb5/wlrcdFPN5vc3Am3vcJq8GiLvG9CWxc738vu7Ln5MsHm+h6z
	 ycW8hxMGx09yA==
Date: Wed, 8 May 2024 09:39:23 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v17 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20240508083923.GO15955@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-2-justinlai0215@realtek.com>
 <20240503093331.GN2821784@kernel.org>
 <14c200b4573b4a60af14b37861ca1727@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c200b4573b4a60af14b37861ca1727@realtek.com>

On Mon, May 06, 2024 at 11:32:38AM +0000, Justin Lai wrote:
> > 
> > 
> > On Thu, May 02, 2024 at 05:18:35PM +0800, Justin Lai wrote:
> > > Add pci table supported in this module, and implement pci_driver
> > > function to initialize this driver, remove this driver, or shutdown this driver.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > new file mode 100644
> > > index 000000000000..5ddb5f7abfe9
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > @@ -0,0 +1,618 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > > +/*
> > > + *  rtase is the Linux device driver released for Realtek Automotive
> > > +Switch
> > > + *  controllers with PCI-Express interface.
> > > + *
> > > + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> > > + *
> > > + *  Below is a simplified block diagram of the chip and its relevant
> > interfaces.
> > > + *
> > > + *               *************************
> > > + *               *                       *
> > > + *               *  CPU network device   *
> > > + *               *                       *
> > > + *               *   +-------------+     *
> > > + *               *   |  PCIE Host  |     *
> > > + *               ***********++************
> > > + *                          ||
> > > + *                         PCIE
> > > + *                          ||
> > > + *      ********************++**********************
> > > + *      *            | PCIE Endpoint |             *
> > > + *      *            +---------------+             *
> > > + *      *                | GMAC |                  *
> > > + *      *                +--++--+  Realtek         *
> > > + *      *                   ||     RTL90xx Series  *
> > > + *      *                   ||                     *
> > > + *      *     +-------------++----------------+    *
> > > + *      *     |           | MAC |             |    *
> > > + *      *     |           +-----+             |    *
> > > + *      *     |                               |    *
> > > + *      *     |     Ethernet Switch Core      |    *
> > > + *      *     |                               |    *
> > > + *      *     |   +-----+           +-----+   |    *
> > > + *      *     |   | MAC |...........| MAC |   |    *
> > > + *      *     +---+-----+-----------+-----+---+    *
> > > + *      *         | PHY |...........| PHY |        *
> > > + *      *         +--++-+           +--++-+        *
> > > + *      *************||****************||***********
> > 
> > Thanks for the diagram, I like it a lot :)
> > 
> 
> Thank you for your like :)
> > > + *
> > > + *  The block of the Realtek RTL90xx series is our entire chip
> > > + architecture,
> > > + *  the GMAC is connected to the switch core, and there is no PHY in
> > between.
> > > + *  In addition, this driver is mainly used to control GMAC, but does
> > > + not
> > > + *  control the switch core, so it is not the same as DSA.
> > > + */
> > 
> > ...
> > 
> > > +static int rtase_alloc_msix(struct pci_dev *pdev, struct
> > > +rtase_private *tp) {
> > > +     int ret;
> > > +     u16 i;
> > > +
> > > +     memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct
> > > + msix_entry));
> > > +
> > > +     for (i = 0; i < RTASE_NUM_MSIX; i++)
> > > +             tp->msix_entry[i].entry = i;
> > > +
> > > +     ret = pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums);
> > > +     if (!ret) {
> > 
> > In Linux Networking code it is an idiomatic practice to keep handle errors in
> > branches and use the main path of execution for the non error path.
> > 
> > In this case I think that would look a bit like this:
> > 
> >         ret = pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums);
> >         if (ret)
> >                 return ret;
> > 
> >         ...
> > 
> >         return 0;
> > 
> > > +
> > > +             for (i = 0; i < tp->int_nums; i++)
> > > +                     tp->int_vector[i].irq = pci_irq_vector(pdev, i);
> > 
> > pci_irq_vector() can fail, should that be handled here?
> 
> Thank you for your feedback, I will confirm this part again.
> > 
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int rtase_alloc_interrupt(struct pci_dev *pdev,
> > > +                              struct rtase_private *tp) {
> > > +     int ret;
> > > +
> > > +     ret = rtase_alloc_msix(pdev, tp);
> > > +     if (ret) {
> > > +             ret = pci_enable_msi(pdev);
> > > +             if (ret)
> > > +                     dev_err(&pdev->dev,
> > > +                             "unable to alloc interrupt.(MSI)\n");
> > 
> > If an error occurs then it is a good practice to unwind resource allocations
> > made within the context of this function call, as this leads to more symmetric
> > unwind paths in callers.
> > 
> > In this case I think any resources consumed by rtase_alloc_msix() should be
> > released if pci_enable_msi fails. Probably using a goto label is appropriate
> > here.
> > 
> > Likewise, I suggest that similar logic applies to errors within
> > rtase_alloc_msix().
> > 
> 
> Since msi will be enabled only when msix enable fails, when pci_enable_msi fails,
> there will be no problem of msix-related resources needing to be released,
> because the msix interrupt has not been successfully allocated.

Thanks, as long as no allocated resources have not been freed in the case of
returning an error value, then I am happy.


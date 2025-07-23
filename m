Return-Path: <netdev+bounces-209184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EAB0E8EE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0806D7B322C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937418A6A7;
	Wed, 23 Jul 2025 03:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1D1DE3CA;
	Wed, 23 Jul 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239749; cv=none; b=u6w774CCcFE9pykblIMzs1/kh8hfQSWTnGXMXQPmxqEFHi1f1pTwm1MpVoLFEPZJ50izSYGUx3ajbf5BJksIWsLleq+UC/0EIr+pnH+36bPP1KznPRxPeSyMdIy2n5T8mwx+sOqlj9d8+SaLKi6W1ZBinM2Iv+N531iY/+Q+IaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239749; c=relaxed/simple;
	bh=M/evPR0svUbE7leAMZM+BaBttls2euCF4BVwatvjvI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcUrI7JyZ8dGQespaLrZnxEByeR1MVazoW0XCkIMiy8SWTIULYVnhViqF/vZwUMVSqsW/k2z7oe9nbe8P0VJq57T7pj31s91MWlXGLWOdrTFQQHBOPFOF3mitZxcFmjjVhsp1jY8Q+PJRrzgFMNoDJukikloB88OIi7pKJkliiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1753239673t6fcb271e
X-QQ-Originating-IP: h6+YcNk6wtGkCE8eMFp3AqG3T77X+yNwoyDRkGfMTO8=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 11:01:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12358391869417309562
Date: Wed, 23 Jul 2025 11:01:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <0E9C9DD4FB65EC52+20250723030111.GA169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <20250722112909.GF2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722112909.GF2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MvyKdZyVtFx3iDqIOOqiI+R6sLCE+t2jMOk4OK539kaJ9/u1j6/h2grf
	Rgy2tNSMffv4T/gAAzgDq+EYY/P2yiHpa+ldqcvDiUe09M60SYtTATEYMPKNZU3PMIDvkZH
	6qJcuARg4Xzau/nH7DJiP4ySkEdza6WYuDkTaT40FrT+aQ6mrJqesP+RCcnBrZMHBb2kt5F
	XuSYG95Iinpq2h9cniaMQbuMClyhs6DXaApc14kAEe2SVp9vwc5nmg24Zlf+sGVJ/YgNV/M
	n8oV71faRgN9YE+PdW+lrZ2/bkfpLv2kWwt9xRasuuhPEMPPo8dHP0XDE7iiRyWkrZqwzOK
	KCXCsL+ROaF9i1W8yhz6JHemCkyPMdUt/nTf+4kGb2YGWH6Vr4XQsYrDeT83Xwd9n3yGcbY
	DSsi7pmCAsR9L4bHuecKj2mX7/IaLXB2jPfkigBu0hzz++pXf5AxrC+q0j+cxWwiPQO9E/m
	f/APh/Y8Oa+h/KpXmsAjn4Pdu7cBADCAWMsZZx8eGq886yMLbKA4A+WnLrxesc6QsRQmvlZ
	afgFNei527OUjBGnM4QZbXdTmv7kvPwePL1Jwo/h0gK3lU7zFIgj7CKmSR7sS10le+eGl5X
	IzqFq4MKwNSz1ae68lUF077mJjUyrsM/9uiA9D+C08XD39TQxjtXt0ra2BEjSQBiB/41SZF
	JhABcX885n2JElZ4lJvwPjX9LrmeSqt/w1dy+7qEmv7pagGJizYyUQCu0qOOEWbJkcCwBdh
	IFmi0uIw6A02t42LB0JqQWrbwYtJUqJWymFAl3PvkrJbzNFbghclRSvQEktTND8432Wi7Ai
	EDFuThRqqAsu3XJLRlQHB1B4g/Jxl8+bEdoP4KaQf8Et5xmn09MZ1Umd6iQgIekaolCOZ/m
	+m6Xmq+gMc16cnzZXm0Eph8U9y7r0RtXvXU3oXcRPn2Mzdc4SbIrOO//yvURoXJ64nPq8wx
	IP4FSJX3cCvGPmh2jV5cXkWMqN2LzUfMOa4xuGEZN8qOU1bUZPX7Q/WWdxv2pwVkhRaZlvk
	9xFPjF3Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 12:29:09PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:24PM +0800, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > new file mode 100644
> > index 000000000000..13b49875006b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -0,0 +1,226 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/string.h>
> > +#include <linux/etherdevice.h>
> > +
> > +#include "rnpgbe.h"
> > +
> > +char rnpgbe_driver_name[] = "rnpgbe";
> 
> At least with (only) this patch applied, rnpgbe_driver_name
> appears to only be used in this file. So it should be static.
> 
> Flagged by Sparse.
> 
> Please make sure that when each patch in the series is applied in turn,
> no new Sparse warnings are introduced. Likewise for build errors.
> And ideally warnings for W=1 builds.
> 
> ...
> 

Got it, I will fix this.
But I can't get this warning follow steps in my local:
---
- make x86_64_defconfig
- make menuconfig  (select my driver rnpgbe to *)
- make W=1 -j 20
---
if I compile it with 'make W=1 C=1 -j 20', some errors like this:
---
./include/linux/skbuff.h:978:1: error: directive in macro's argument list
./include/linux/skbuff.h:981:1: error: directive in macro's argument list
........
Segmentation fault
---
I also tried to use nipa/tests/patch/build_allmodconfig_warn
/build_allmodconfig.sh (not run the bot, just copy this sh to source
code). It seems the same with 'make W=1 C=1 -j 20'.
Is there something wrong for me? I want to get the warnings locally,
then I can check it before sending patches. Any suggestions to me, please?
Thanks for your feedback.



Return-Path: <netdev+bounces-213205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B7B241D4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC806253F1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462312D3734;
	Wed, 13 Aug 2025 06:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B32D373E
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067509; cv=none; b=bMRjmc6++TJ6S8IufK/Vv+gf+/8Lj+nA3tYtUoee+QCgQcR2xU60fvn7ziV/rN1BDp3qGJCWSO3WuL3CeKpKR7HhI32PZ4YXqJ7m7YlwGoDFnifDMwGxoZqnhlRngtt0YTHb6kMs8dDFmtSEXIBBoAd7cu9fFzUTu7KEB89fu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067509; c=relaxed/simple;
	bh=X1iAxCzkC0UTn04Af07aTWJbu6jdxrV+7YWDNaiy9Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/WiMWtLGEdq4bm22Vk1DynOyhLGkDzGpDd2w/Z20WkGQbQ59/RzNsQZUDJiL6vtt25PPg1c1rgBDCvArixINlcIFIOuEmofx6fstKdE0fI7bGecLsTIl/kgEU+lAiMgN9QRGxEiKXSRCrRV0pTKU7z57pgvPuJ1QMMuKbKzoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1755067483t4b22c6e6
X-QQ-Originating-IP: atNYv484Sc0LnNQn6B0BdZHBN2Wh7P8+LL0ZD0kuURs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 14:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1883357001402126137
Date: Wed, 13 Aug 2025 14:44:41 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MRRqyjT9q6wlvkHMKsiMxZRv0YHt52pAGrSwSDAGIHLrfud88iPSvX3a
	3D+mg3WjQv7mowEVOPw0iRQjumY+l3CJnrVZAQ/yCKt8ZFhgjJ1SnX7klga6sk6fi1S7ofn
	5QnDVjB6dMayCmxYBHuUYKggrr7Lez6H4a+bA3oxBMMuW/BGJ2lbP9oTTXQ4B3V/uCo0f3C
	ZQNvgHwOWGst8uBqrhaJVfFeHYk9gHMKF8s/n0M5nHcLBcR7d1DxW15oSqVzpGIMmwlvVH/
	EFt3aFADlBRTstTcggJoDgCNqErg0LCQMc+t2iOV2DjtylleZa3HcK544m4IzIXuWdvSmqn
	H3RFB3vynuN2uHCKPfrSly90yRQpLFbFVsfpmWtt3fGbsPTe0iTb6IkRe2nJsghtvaWMYem
	1Mk+S2GJZvzkURUkm17UK+b5/mGRNaeTFEAxyj37Z3lCQpRaKNRDUCmmKomFai3on8TNt8I
	/G9/PlkrX1utUZ2O6syKMCakNyq6MMgNvveVKEJcyCu4Xqxsf1J364en16TcjMuwZxNQo27
	BqJw1x+rZeRQaJ5uVHLf+qQDnuXzV9k4D5su39qx+qFRHWqrE8ehUFSWY8KMD8/w0dEkUOS
	4a4SCQOyzeN9bD04X2dFPAkLHazVOX4GASLcjK3GtjtZ1ASQ5TrHG5iGtP3KeW8txxhsgAC
	eo0eaZ4vh2ysJoE/++ZhjtPq9FjG3TdE681ZxJ8EMXvQ6ldUX7mbYBH3DvPObL4B/nAYaqt
	HlQzcQ8uZbWD+64msR8q0di5v04w8rEPZgk8G5GUWvGMDFWMjDbDi2TT3UtIXm3bMw9pAMG
	oCymKqsVKeMd/VdhJGMYqS2xd2xCIx/ENvLsM84Ud1Rynn4/3uSDpIMaBTCWmmAIxUw4VOS
	mfYR+uOIHWxnPs9bhv7kKAIV5+nYvJUoCA9b57eEGL0PnzZG1tzA1cKnUhP8UZ7WwYdBdTi
	epTEVtuwVy3svuu3RZ9dnCpIo7bYy4MfhyAtrWr1+qcQgMQUp6/Aj+ZWIPHo/FbV0bcqMpV
	SLaG9maw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 09:48:07PM +0530, Anwar, Md Danish wrote:
> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  .../device_drivers/ethernet/index.rst         |   1 +
> >  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
> >  MAINTAINERS                                   |   8 +
> >  drivers/net/ethernet/Kconfig                  |   1 +
> >  drivers/net/ethernet/Makefile                 |   1 +
> >  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
> >  drivers/net/ethernet/mucse/Makefile           |   7 +
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
> >  10 files changed, 267 insertions(+)
> >  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >  create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >  create mode 100644 drivers/net/ethernet/mucse/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> [ ... ]
> 
> > + **/
> > +static int __init rnpgbe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	ret = pci_register_driver(&rnpgbe_driver);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Unnecessary code - can be simplified to just `return
> pci_register_driver(&rnpgbe_driver);`
> 

Yes, but if I add some new codes which need some free after
pci_register_driver failed, the new patch will be like this:

-return pci_register_driver(&rnpgbe_driver);
+int ret:
+wq = create_singlethread_workqueue(rnpgbe_driver_name);
+ret = pci_register_driver(&rnpgbe_driver);
+if (ret) {
+	destroy_workqueue(wq);
+	return ret;
+}
+return 0;

Is this ok? Maybe not good to delete code for adding new feature?
This is what Andrew suggested not to do.

> > +
> > +module_init(rnpgbe_init_module);
> > +
> > +/**
> > + * rnpgbe_exit_module - Driver remove routine
> > + *
> > + * rnpgbe_exit_module is called when driver is removed
> > + **/
> > +static void __exit rnpgbe_exit_module(void)
> > +{
> > +	pci_unregister_driver(&rnpgbe_driver);
> > +}
> > +
> > +module_exit(rnpgbe_exit_module);
> > +
> > +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> > +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> > +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> > +MODULE_LICENSE("GPL");
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.


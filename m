Return-Path: <netdev+bounces-213244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65751B243B5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822A9189442D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C32EA47C;
	Wed, 13 Aug 2025 08:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C72293C71
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072074; cv=none; b=YggQ2e9bQ3ycs/KesazNhqn61XW0FoPONx6ag0GxYiCEMwvxhBJJfu/p98apHNDovoohmVRPidx1whothgsC3gw83DCvAQyqTGBpT5Wr9rR2OACAMeb3f0q8USpasjHKSFCaDxPRZwA6DmJcTXX+lbvm+dmz5jqnEBeG8VmX6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072074; c=relaxed/simple;
	bh=ARWZeV5AIKpwWGWYFjzn8mwFl1iehx3wMvcM+mthYB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxNY0g+H7gYsf4Jvmi7V68o/uPwdaHJ2Hw4fbnwbJdysawpDdWl/xZ80HGkSTS+KK9d5rmEYiQa7t7MiTiF2gQyK6IqDO/55Jvm9pbHR21yAxWBdORwm0nHMZxJl1bL4633fvl24ch6jw92Xp7mMpY9EVmqEBaDqG4dWR785l1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1755072056ta162e254
X-QQ-Originating-IP: ktDmJ8wFfoS0U7omIKUwwKWalGUVF+AwW9KX5f9UOSs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 16:00:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15826050987606234436
Date: Wed, 13 Aug 2025 16:00:54 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <71381A4EED369AF0+20250813080054.GA965498@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
 <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
 <d0c2fcb1-578d-443c-949f-860c94824ac9@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c2fcb1-578d-443c-949f-860c94824ac9@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M9t1NOw+1P4Gho5lqwo+O/PMDjigsAnZ6HLBRgVBp7mEK/S70pXHfjgE
	D66+ZEZG6IAUcHHmo60E+0Hm+lP35rgHJM4NCxK2PaYkyyxBm9y+bQpZOA48Hv1hNpsGiKq
	Lpwy5yf+MNimIkFuLQgCfCSNEyHuIJYRpKQMbVzlo0hIO9qF1wem3V75BM2Bx35qu01s5v0
	QsEjsbcO7QDj6o6BuOmD7Mfi9lkZdr9TDzPASRS4ofrog/unc7A/cQ22u2En3sfg0yCE8RP
	Etewz+msxJGC0g0jp2wZ8LWACb7vIndtaR6Z4zvft+LR1vcQ4usuGluD7SRSpbeNp/jRurD
	kc6G13Th4KxbHQAkYalXN+nB4nHat/ubb6Hghtknp+DuNzVg161hAaTr0HFFz2we01v4n1J
	E5auaggVJG/+Mwuuc/wdOqaS+G43k12glb3e//KdeJH0ZYNwEutQuY3mZjoEJGFekMyL+x5
	5d7bA9CkVMYgYeVrOZgmST2n/GvWqn6MZ2RdUHFt8QUTmH6tqn43UcfhpckuPl0qAJuaz0E
	MBnPuEmrhwgMLee0VItI+MA4uOYTyKbjiX1xVnwRYylwjfE+qHI1871skHoPMesYYWoEni/
	kB83tiuYmi6tqIOye4nAnFhI5ehFXwvokgFe8oA33t5q2UH4Py+bls/WgfBq3W7MY3WCyK3
	mqeYrsbiaRrr0M8D5A8DJ8kpyJH+J2mWBfFiDVvAMmw1f8oFRHs5Bj3gV6lbIT5iECeIsaZ
	uPqqoCRmUFfDENd6D4fvTkcu7/hFZPzir14/txH7zoBjVAvnh+dakHFQMQ5UGXG5NCLDSTg
	D7bEQFXKvS0I4+NhYGjkzPdpxMSoc5TgngNZs22iA/d+e/XzWBnUTOrMirqPG2ggHiBdTCc
	EGB8WNEuhO6GOZrzr89j5EVq7b8GaonKSA8ZeuoAl65WZkbY+GRX0PT0yrMW7yv7lvAv1NC
	CN3DATuxp5ZxJMgl5H5DkyAfww2sEfSqTei0HKmyISNMpCzkgtnAOzNsbNfbGXUZgTPxGo6
	PPqsPE7HwSS0bqh9BmYZzoaePkFi0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:21:26PM +0530, MD Danish Anwar wrote:
> On 13/08/25 12:14 pm, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 09:48:07PM +0530, Anwar, Md Danish wrote:
> >> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> >>> Add build options and doc for mucse.
> >>> Initialize pci device access for MUCSE devices.
> >>>
> >>> Signed-off-by: Dong Yibo <dong100@mucse.com>
> >>> ---
> >>>  .../device_drivers/ethernet/index.rst         |   1 +
> >>>  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
> >>>  MAINTAINERS                                   |   8 +
> >>>  drivers/net/ethernet/Kconfig                  |   1 +
> >>>  drivers/net/ethernet/Makefile                 |   1 +
> >>>  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
> >>>  drivers/net/ethernet/mucse/Makefile           |   7 +
> >>>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
> >>>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
> >>>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
> >>>  10 files changed, 267 insertions(+)
> >>>  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >>>  create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >>>  create mode 100644 drivers/net/ethernet/mucse/Makefile
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> >>
> >> [ ... ]
> >>
> >>> + **/
> >>> +static int __init rnpgbe_init_module(void)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = pci_register_driver(&rnpgbe_driver);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return 0;
> >>> +}
> >>
> >> Unnecessary code - can be simplified to just `return
> >> pci_register_driver(&rnpgbe_driver);`
> >>
> > 
> > Yes, but if I add some new codes which need some free after
> > pci_register_driver failed, the new patch will be like this:
> > 
> > -return pci_register_driver(&rnpgbe_driver);
> > +int ret:
> > +wq = create_singlethread_workqueue(rnpgbe_driver_name);
> > +ret = pci_register_driver(&rnpgbe_driver);
> > +if (ret) {
> > +	destroy_workqueue(wq);
> > +	return ret;
> > +}
> > +return 0;
> > 
> > Is this ok? Maybe not good to delete code for adding new feature?
> > This is what Andrew suggested not to do.
> > 
> 
> In this patch series you are not modifying rnpgbe_init_module() again.
> If you define a function as something in one patch and in later patches
> you change it to something else - That is not encouraged, you should not
> remove the code that you added in previous patches.
> 
> However here throughout your series you are not modifying this function.
> Now the diff that you are showing, I don't know when you plan to post
> that but as far as this series is concerned this diff is not part of the
> series.
> 
> static int __init rnpgbe_init_module(void)
> {
> 	int ret;
> 
> 	ret = pci_register_driver(&rnpgbe_driver);
> 	if (ret)
> 		return ret;
> 
> 	return 0;
> }
> 
> This to me just seems unnecessary. You can just return
> pci_register_driver() now and in future whenever you add other code you
> can modify the function.
> 
> It would have  made sense for you to keep it as it is if some later
> patch in your series would have modified it.
> 

Ok, I got it, thanks. I will just return pci_register_driver().

> >>> +
> >>> +module_init(rnpgbe_init_module);
> >>> +
> >>> +/**
> >>> + * rnpgbe_exit_module - Driver remove routine
> >>> + *
> >>> + * rnpgbe_exit_module is called when driver is removed
> >>> + **/
> >>> +static void __exit rnpgbe_exit_module(void)
> >>> +{
> >>> +	pci_unregister_driver(&rnpgbe_driver);
> >>> +}
> >>> +
> >>> +module_exit(rnpgbe_exit_module);
> >>> +
> >>> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> >>> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> >>> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> >>> +MODULE_LICENSE("GPL");
> >>
> >> -- 
> >> Thanks and Regards,
> >> Md Danish Anwar
> >>
> >>
> > 
> > Thanks for your feedback.
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for your feedback.



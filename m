Return-Path: <netdev+bounces-225773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3936B98167
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508783A77BF
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDD2116F4;
	Wed, 24 Sep 2025 02:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9514317D;
	Wed, 24 Sep 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681921; cv=none; b=AxHxHDQASlx57/snfIg1JqGcEmc2D7zr3ByYp+Br7VuxD0rt5mUicb22aer/kswZFkZ7ZGK/Wy1oYKRM6OGf/6x+898bA0jsHjYJRAWq23C6QplbRpbP4TTo/YiDyPSO1bDP53fVnwgPkf99WYj6TW8dsg4vib3/uY50f8a9FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681921; c=relaxed/simple;
	bh=lqxklR9mOWs81KNj4z4qsLpILTVDdfn7+J979dqGXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB65p3hg/EK0A055wvwdY60W2BkbHlyEjrixCcI67JvgO9XYn6B6nDnWWBSnsEBOC3YPMG3I3bn+9Kv6AStJg3emTp/as8qPBFd5VahP6JCpyJTH93Ec+2lHmknTrYJfgMexMgP32gDn5HOqEi9FLxTtTMbx9ckW/2DRSNJGPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz4t1758681876t1e3ccc25
X-QQ-Originating-IP: 4kgQSL6STHaKosl1eg/Ylv5lM/i5m44RFczJ2nXYIEw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 10:44:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17616937174524784097
Date: Wed, 24 Sep 2025 10:44:34 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, joerg@jo-so.de, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v13 1/5] net: rnpgbe: Add build support for
 rnpgbe
Message-ID: <EA71F5311AF8C4FB+20250924024434.GA292859@nic-Precision-5820-Tower>
References: <20250922014111.225155-1-dong100@mucse.com>
 <20250922014111.225155-2-dong100@mucse.com>
 <20250923180854.46adc958@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923180854.46adc958@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2uUxVy6vITVQTcXJo2r0ul7TI+3+DuMqgDHgQqYv0Eq7/CjlRyceLmV
	eby+lNbv7omMBKyA96mOP+uIqRqeYm9HbVB/OamPyCZZSUF+xUURZB9LlfbDSkE6vjnYYVY
	u6TCrfJ2IQ1GXc5hfCqnkE1rBSbdl+A0UAjNglRtBO9Cu7CNZMjUCotPc5a89VAjwKAx4CO
	ThIJ419eyWmVpOfIjUmmInIisVVZP2s5RJ8mQCzJN7qpebZjam3po6j68SV9bAdEKV3fau+
	IOvLdIjVSKYlNJ2Bc8tPBT8r2xHVB6lCW/dB1NeUfRPuAlxKxFF9EVS1Gg4DtK5ENWbEc6X
	JmAHfwKPgslLKYN/IeHKr8cQdiaqe6cEVFpyIKLnDd1wozG5pV9tm4EFw3oYlM9zdkhFBsn
	N606SfA5vUkR4oPvOhg0lYErpFeKhHX/QRqzRbS39DhCcdhyY1fIAvUtEtcnI9qhsdZ7qJ4
	X+slA9Um0LYVBwTPfiYGmc9+TwLE8yrCqqcflzHN5bpAKg+JxwlT6fflEIMeiWaFG7P39UJ
	netksuCoar4aatyB8Lx8vre/6zwcHlUE/UdErpXXoKIeFuThHiiIt9L4MAaVozsIS7uFhC3
	WB0KQxxlwf4c9+WtFxAOwH1x20u/1x3ZWtN0CCC6DS7L7y7H3SKnom4la+r8DCrfTKGihSq
	Z6kv/S6uZlAtjccM6A02EfHnSBVEpR5y+bXAiunh0gO03sj2R7tNWwMT+jusP5Oap81bq3A
	UJD/D2V8iJR9mYWEQFZBHBR0D8XHnUd915sGHNkezKh2jgpuzGodWWx0dExBjGj9dH9Xl6t
	GLlWdjP8iW4Ne3wYVzPPPZWk1jnCub4sN7Kd4yvmPgY5DCoZkx/u+CBi0tdwfKVD3jX7HYs
	DT+D6907gxAlk6fKd34ZaxaTJBZmONzrQFGzZBi2ZL14/fgGRnahg4S7+Ts0ArZ4qsxtkEJ
	OKo3a3So8Xj+8X2rUUAdHW1wUN4GTGsWckWfe867mHpVjhTG7tg7yxqfpp1bPvtap1XPaNw
	M20HtVLg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi, Jakub:

On Tue, Sep 23, 2025 at 06:08:54PM -0700, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 09:41:07 +0800 Dong Yibo wrote:
> > +===========================================================
> > +Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
> > +===========================================================
> > +
> > +MUCSE Gigabit Linux driver.
> 
> You already said that in the heading above
> 
> > +Copyright (c) 2020 - 2025 MUCSE Co.,Ltd.
> 
> copyright is metadata, it should not be part of the user-visible doc.
> 
> > +Identifying Your Adapter
> > +========================
> > +The driver is compatible with devices based on the following:
> > +
> > + * MUCSE(R) Ethernet Controller N500 series
> > + * MUCSE(R) Ethernet Controller N210 series
> 
> These are out of numeric sort order
> 
> > +Support
> > +=======
> > + If you have problems with the software or hardware, please contact our
> > + customer support team via email at techsupport@mucse.com or check our
> > + website at https://www.mucse.com/en/
> 
> Please don't add support statements. People can use a search engine if
> they want to find the corporate support. The kernel docs are for kernel
> topics, and "support" in the kernel is done on the mailing list.
> 
> 

Got it. I will update this file like this:

.. SPDX-License-Identifier: GPL-2.0

===========================================================
Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
===========================================================

Identifying Your Adapter
========================
The driver is compatible with devices based on the following:

 * MUCSE(R) Ethernet Controller N210 series
 * MUCSE(R) Ethernet Controller N500 series

> > +config MGBE
> > +	tristate "Mucse(R) 1GbE PCI Express adapters support"
> > +	depends on PCI
> > +	select PAGE_POOL
> 
> you're not using page pool in this series
> 

Yes, I will remove it, and add this when truely use.

> > +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> > +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> 
> Only humans can author code, not corporations. Delete his AUTHOR entry
> or add yourself as the author.
> 

Will fix this.

> > +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> > +MODULE_LICENSE("GPL");
> 
> 

Thanks for your feedback.



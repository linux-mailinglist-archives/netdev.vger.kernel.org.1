Return-Path: <netdev+bounces-208882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C3B0D7AC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDCD3A3B6B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E412D8766;
	Tue, 22 Jul 2025 11:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8C1DE2B5
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182384; cv=none; b=XPEMFYeAGI07Wn6S2pjGV7wEImlUKBOUw49Tu3kvEHgIgGyhX/VCPgUj8b3fS1cVsdTPth4H70WyRf8iHmQSeVJP1HERjSFgsYlxpPqMZcve0snFJMfuUSzV0x0yMY1Oz+yssuR4uLsF8Tu0WM25K8QxC1zBmwUiGJsy/2IEdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182384; c=relaxed/simple;
	bh=osaPJphBkG3Oc5IjP9rPY0C6ox0p0oIZq0W6NW8vKys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltnMe/60nO3GzYCDaxxgtmKlAaEHtLSfNWEz5sJQQKHNU1ZbvKOZ5cS0DXS6RactoTPPehQ7ksk6wJ/iJoxcLqVKR5iX+0rf59oachbPFvdDWf6s1z58ntxmHWUXXedXBVqsZiNHLAD5JJoZAg6xraM5RpEleQ8jRg0xIKsuXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz15t1753182360tf29cfbad
X-QQ-Originating-IP: FXuqZDVo/GZ6z9v0ge1P2MCwsAK4t9NGsisCs29wpck=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 19:05:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1745295540662431408
Date: Tue, 22 Jul 2025 19:05:58 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <6D29CA59CCFC37A8+20250722110558.GA125862@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>
 <D6DDF24A13236761+20250722030245.GA96891@nic-Precision-5820-Tower>
 <60ac707f-b57b-4f31-8c54-b59e75200181@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ac707f-b57b-4f31-8c54-b59e75200181@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND3CPZxVFFQclkUGnDuw2KhdoEn5w8Fdnw0Xbqd29jZXIKj8Q9MZlZfB
	Eh4M9SvS+E1Y0bUm99oj9itV/m5xd7bNuPXtBekr0pWlFomUNNx/eku1YSjRyFZlXxhDyDe
	X5L+Bz4qLaWAbG7WZE1KRx0+4FV4zBGBxOEhZ1PB6qlRXITqx+i6hbc7MhP7hr5S5UlMcKu
	lNxR8PCJqdDRk9nFkUVhn+yxDavKQJutvqdGoaAz95KppIR75T1zJqdua9whanmrp/LaMxX
	PonMRey2STguPD2PaqHdYfxqmF4m5rALIb4mJ8wtvo4RunJPyoONa3VZkvGl42pyFK3Fn5/
	6VC8yrOqTmRRk8JgZia1FT3S7+6pogpCt20joFyMTMTHxnLUx4W6WuzdA3GVuAqKdwt6jhy
	ZMY4EhyYS0s/ljh/NUaXxUIpdkXiVGbbFsntjjr4qjA7W1QDU1mcJKjTLQDSTPsCqY11pZl
	57Lg/zO3NedCSYuID9OMMZrsZVtEAeYzupirJvRlZFHauKr4ehRfZggaxRNl7P0Qf0gowtk
	LBWJkVVO6u6YCLXRlRTmV7D+vduraaxDDKYJ0FO1ea2uAGZA038wbB6w7UJHtkHan3RBSlJ
	6gZSSUe0SosOflLFkB3718MoWMQye7pzjZM6WKjjddvSyT11mHTEAnP0krQSDn/MCFQlGkm
	SMCwR3oGBcFOXpj/hg3Yeuy2YVH8b7i1XJOAjPMn971L7C0YaZ2vcOWPyl7rrPA85PNio2e
	nIMsKa4YXKJra1EtQWsLfJnYlBoJZd6yXAofxEh/F9FVVY+ruT9Q+uWBsztIQLtR/teHW5l
	xr9aIb1aP2TfEEnEn6NiSi3eOUqS7C8rKangc7h6041lyt1ZE7A5Om2jjRtftSqe4Ji5dgs
	ekyTwBHdmemcVrHFvLAqU/NJjY7iQvl9qr2EJby9+vPrhyDC8KPVxGFDtCg8MQmWwZ0OQwo
	zHk0foPzYHlxbMfZT08zbRXHHTFeebgJxHpFaN02kFoFsxne/1Eay/Wv+ZnMJCOfrtOmrZy
	D60kJUdg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 11:17:03AM +0100, Vadim Fedorenko wrote:
> On 22/07/2025 04:02, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 02:30:40PM +0100, Vadim Fedorenko wrote:
> > > On 21/07/2025 12:32, Dong Yibo wrote:
> > > > Add build options and doc for mucse.
> > > > Initialize pci device access for MUCSE devices.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> 
> [...]
> 
> > > > +
> > > > +struct mucse {
> > > > +	struct net_device *netdev;
> > > > +	struct pci_dev *pdev;
> > > > +	/* board number */
> > > > +	u16 bd_number;
> > > > +
> > > > +	char name[60];
> > > > +};
> > > > +
> > > > +/* Device IDs */
> > > > +#ifndef PCI_VENDOR_ID_MUCSE
> > > > +#define PCI_VENDOR_ID_MUCSE 0x8848
> > > > +#endif /* PCI_VENDOR_ID_MUCSE */
> > > 
> > > this should go to include/linux/pci_ids.h without any ifdefs
> > > 
> > 
> > Got it, I will update this.
> 
> As Andrew said, my suggestion is not fully correct, if you are not going
> to implement more drivers, keep PCI_VENDOR_ID_MUCSE in rnpgbe.h but
> without #ifdef
> 
> 
Ok, Got it.
> > > > +
> > > > +#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> > > > +#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> > > > +#define PCI_DEVICE_ID_N500_VF 0x8309
> > > > +#define PCI_DEVICE_ID_N210 0x8208
> > > > +#define PCI_DEVICE_ID_N210L 0x820a
> > > > +
> > > > +#endif /* _RNPGBE_H */
> > > 
> > > [...]
> > > 
> 
> 


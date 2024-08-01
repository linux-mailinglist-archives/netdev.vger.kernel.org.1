Return-Path: <netdev+bounces-114937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A93944B60
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FEF1C24525
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B61953B0;
	Thu,  1 Aug 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hLPkfTes"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506549641;
	Thu,  1 Aug 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515605; cv=none; b=tOrjS/1cjm/4LjU3iZ8lmRluvSXMjnaD+bm0ve2wcoyNiz3XRZ5imhAmau1qpJF0fTcJP7Pxn5MFRLLieJ9EncAxnFeFJ/bDn5V2PWo6JqVfGgOzf5FiUm7WrhzG1QDFl1rIx6An1PBbOBCXC6rw3nmeiLGANlxyEAc40cLTzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515605; c=relaxed/simple;
	bh=ISfTAzbWUkV7/dEVJLW1JPTgrCRjPLNkivoDFJ7g9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa0AiX6HuJoW1c92Kq75jOtn4meEvX2LddixG4wNuE/cvmtLUmII+w0jYNsdS8P12T6B8tGCOln1ohCt5qiRKIoxQBiplsEA5IdnDqobcHJ5tv/mgnje/z1MgGbrPGB6o+gGOgY38xOoJAwHk4IXr8kgfFtQoc+jc+hWV680o6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hLPkfTes; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kOJVYxF+5aHy0xm8sHyQfUFrcqHBhYqf0L3Q4EjM3HA=; b=hL
	PkfTesPsel61q+lmzHyIHBSPAIrn1N0ETU+l4113Ef0lUe4A5IWIIw/JrKWqT+p6nfezqvosGT3Vd
	rlrx6u3SwLwXVLUcFEIQ5FPjgZteEqrJGdFB7m+CjHkK3hEstMT7hg9oip+c5AyJ7P0LJZtQCYZXP
	yS0z/LovpI2Oz3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZUzc-003m2R-Oh; Thu, 01 Aug 2024 14:33:16 +0200
Date: Thu, 1 Aug 2024 14:33:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 09/10] net: hibmcge: Add a Makefile and
 update Kconfig for hibmcge
Message-ID: <adc486e6-2f09-4438-a86e-f9ec42c88e77@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-10-shaojijie@huawei.com>
 <49d41bc0-7a9e-4d2a-93c7-4e2bcb6d6987@lunn.ch>
 <0fe6e62f-a6cf-4a9d-9ccc-004570c3c46e@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fe6e62f-a6cf-4a9d-9ccc-004570c3c46e@huawei.com>

On Thu, Aug 01, 2024 at 08:15:43PM +0800, Jijie Shao wrote:
> 
> on 2024/8/1 9:13, Andrew Lunn wrote:
> > On Wed, Jul 31, 2024 at 05:42:44PM +0800, Jijie Shao wrote:
> > > Add a Makefile and update Kconfig to build hibmcge driver.
> > > 
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   drivers/net/ethernet/hisilicon/Kconfig          | 17 ++++++++++++++++-
> > >   drivers/net/ethernet/hisilicon/Makefile         |  1 +
> > >   drivers/net/ethernet/hisilicon/hibmcge/Makefile | 10 ++++++++++
> > >   3 files changed, 27 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
> > > 
> > > diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> > > index 3312e1d93c3b..372854d15481 100644
> > > --- a/drivers/net/ethernet/hisilicon/Kconfig
> > > +++ b/drivers/net/ethernet/hisilicon/Kconfig
> > > @@ -7,7 +7,7 @@ config NET_VENDOR_HISILICON
> > >   	bool "Hisilicon devices"
> > >   	default y
> > >   	depends on OF || ACPI
> > > -	depends on ARM || ARM64 || COMPILE_TEST
> > > +	depends on ARM || ARM64 || COMPILE_TEST || X86_64
> > It is normal to have COMPILE_TEST last.
> 
> ok，
> 
> > 
> > Any reason this won't work on S390, PowerPC etc?
> 
> I have only compiled and tested on arm or x86.
> I can't ensure that compile or work ok on other platforms.

It is a sign of quality if it compiles on other platforms. The kernel
APIs should hide away all the differences, if you are using them
correctly. So i would take away all the platform depends at this
level. Toolchains are easy to install apt-get
c-compiler-s390x-linux-gnu etc. And 0-day will build it for you after
a while on various platforms.


> 
> > 
> > > +if ARM || ARM64 || COMPILE_TEST
> > > +
> > You would normally express this with a depends on.
> 
> Sorry, I can't understand how to convert if to depends on?

Kconfig is not my speciality, but cannot you using

	depends on ARM || ARM64 || COMPILE_TEST

inside the symbol?

	Andrew


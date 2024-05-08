Return-Path: <netdev+bounces-94466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEED8BF8EE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D44286F1F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFBD54756;
	Wed,  8 May 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="droVsfqg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710D54668;
	Wed,  8 May 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157635; cv=none; b=skeMp75ECAedMIX4oTGTETslgbe+q7OyTDYNlSYjSDhB+fUacn2zPxulMAnjvbs+CjsXZmCYiIpxyrCRjgeFNKsIvZ8+tkRCUM5nqaJFxvVME6WKI2FJb+0lM/bk/6pOUjKws8BC8bu8YN9ZJAlG3bVu2yTHo5rCUhKK/qmlLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157635; c=relaxed/simple;
	bh=7AkH+Cd52kKIzQ6Z1eGmeRFbIVVvMbs2fVbYsa8ENKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdeyJ0zzk7Cm+gAZiyGR0zcIyNROET+/6cvJsp7Sxlh0xtJ3RlxHcmMZwSaPyH+GSxQpSDcQ+VcOxqC0bkctc64npQKAAK6wZIUOFJBbmG6IsPQKlXUl0qcw19/DznLc6rmCtWPoRLts8VGvqf2RDx8G5cTh6HoWBvUh1hp/uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=droVsfqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB9C113CC;
	Wed,  8 May 2024 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715157634;
	bh=7AkH+Cd52kKIzQ6Z1eGmeRFbIVVvMbs2fVbYsa8ENKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=droVsfqgQLlY5fn/Vt+M7KFqUK8CKoh3x8pk8O7hiSlH+LLrXoFhbLEOMEBzKSfSJ
	 RW6Cg0/CXmktZnLv3xWhN3fVBJ0GHSvvmlpJtWA4H2GeFzyd2TaMmkvhYFs6I7gRyC
	 rjRpZlaVpVWqP/mO7ty8Zv6GgLrUaL4BPgSJbagucUx/5FjvFx00pisN6wobVbxP4L
	 xBYbs419tu86cidfsKDlkkKF8MPP2vnQ4TW1PnqoHoULcIxlZvJD6OfosCATT8B4Sn
	 xIe/XRy67//r1SbHqzYJ4KU3oHgU43lmMWtZsMNJAFLJm9QtU5T7btGJRzcIr/3rAF
	 7w7ZC+2BqY0LA==
Date: Wed, 8 May 2024 09:40:30 +0100
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
Subject: Re: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <20240508084030.GP15955@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-13-justinlai0215@realtek.com>
 <20240503083534.GL2821784@kernel.org>
 <1470b2c0983442fcb5078ca510aade35@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470b2c0983442fcb5078ca510aade35@realtek.com>

On Tue, May 07, 2024 at 09:44:14AM +0000, Justin Lai wrote:
> > On Thu, May 02, 2024 at 05:18:46PM +0800, Justin Lai wrote:
> > > 1. Add the RTASE entry in the Kconfig.
> > > 2. Add the CONFIG_RTASE entry in the Makefile.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > ---
> > >  drivers/net/ethernet/realtek/Kconfig  | 17 +++++++++++++++++
> > > drivers/net/ethernet/realtek/Makefile |  1 +
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/Kconfig
> > > b/drivers/net/ethernet/realtek/Kconfig
> > > index 93d9df55b361..57ef924deebd 100644
> > > --- a/drivers/net/ethernet/realtek/Kconfig
> > > +++ b/drivers/net/ethernet/realtek/Kconfig
> > > @@ -113,4 +113,21 @@ config R8169
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called r8169.  This is recommended.
> > >
> > > +config RTASE
> > > +     tristate "Realtek Automotive Switch
> > 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> > > +     depends on PCI
> > > +     select CRC32
> > 
> > Hi Justin,
> > 
> > I believe that you also need:
> > 
> >         select PAGE_POOL
> > 
> > As the driver uses page_pool_alloc_pages()
> > 
> > FWIIW, I observed this when using a config based on make tinyconfig with PCI
> > and NET enabled, all WiFi drivers disabled, and only and only this Ethernet
> > driver enabled.
> > 
> > > +     help
> > > +       Say Y here if you have a Realtek Ethernet adapter belonging to
> > > +       the following families:
> > > +       RTL9054 5GBit Ethernet
> > > +       RTL9068 5GBit Ethernet
> > > +       RTL9072 5GBit Ethernet
> > > +       RTL9075 5GBit Ethernet
> > > +       RTL9068 5GBit Ethernet
> > > +       RTL9071 5GBit Ethernet
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called rtase. This is recommended.
> > 
> > The advice above to chose Y and M seem to conflict.
> > Perhaps this can be edited somehow.
> > 
> 
> Hi Simon,
> I would like to ask if it would be clearer if I changed it to the following?
> 
> config RTASE
> 	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> 	depends on PCI
> 	select CRC32
> 	select PAGE_POOL
> 	help
> 	  Say Y here and it will be compiled and linked with the kernel
> 	  if you have a Realtek Ethernet adapter belonging to the
> 	  following families:
> 	  RTL9054 5GBit Ethernet
> 	  RTL9068 5GBit Ethernet
> 	  RTL9072 5GBit Ethernet
> 	  RTL9075 5GBit Ethernet
> 	  RTL9068 5GBit Ethernet
> 	  RTL9071 5GBit Ethernet
>  
> 	  To compile this driver as a module, choose M here: the module
> 	  will be called rtase. This is recommended.

Thanks Justin,

Yes, I think that addresses my concern.


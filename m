Return-Path: <netdev+bounces-209009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31CB0DFC3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DFC7B827F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C952DEA7C;
	Tue, 22 Jul 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1mRleX5Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C56239E9E;
	Tue, 22 Jul 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196360; cv=none; b=Wxv5sQeImTKOJt+Etse2A0eKZ9iNdvG7fez4pV4Tv7tPDjVGh/US4P/y+Ld5X8wxOE2PJeGN0/czdIuAGcP/GjAOpkzZoSlrJLx15DH97NTaY/L0qe48BOal1i2+KGhL18qu9iBJo8TW6BMql414dcXOwfJvmGshygyn3W2wW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196360; c=relaxed/simple;
	bh=ou7A8dCtajtd2EqlFdUb122ILRZkFdkN1YbKnDqV3tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6XQ/7alryNKgmauJB0ixB7cZ+0CWxM0KE2El60rO8K5gFGUTcfkpq0kDQEZEHt+cxLFQYAH/o3MhwPZnaIPRAeAld9Ro+TF5IJvn4j/sJXtD48uyNYZox85pwhK4gP0EDf7w7KtBU5XZGxsFjoFq1t4gMAQgXmgQG6+DPzSPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1mRleX5Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qXqgH+7Pf8+YOQt42JO04/xiRlrY25OPKvo6NdI8jhU=; b=1mRleX5QRWQZbkWvtmnIFJ4XZ/
	gt9P3d9AJKA4hTjBiS+wkEwXnqHsh0AyuXqXN5pxL//H5Kc/lNw4YAwfa9YRZyM/+xdH/LJ7lW6NA
	1aZd7S4UKw4KmsczXyW6B9tGPHNu22aqewBOoN5Kv3lRdruVtQ5vYa01a2qn6a5mCAB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueERs-002Tkl-HD; Tue, 22 Jul 2025 16:58:32 +0200
Date: Tue, 22 Jul 2025 16:58:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
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
Message-ID: <53710a91-a4b1-4ce9-a9f7-b32a74dec3fc@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
 <146B634370ED44A0+20250722033841.GB96891@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146B634370ED44A0+20250722033841.GB96891@nic-Precision-5820-Tower>

> > > +#include <linux/types.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/netdevice.h>
> > > +#include <linux/string.h>
> > > +#include <linux/etherdevice.h>
> > 
> > It is also reasonably normal to sort includes.
> > 
> 
> Got it, I will also check all other files. But what rules should be
> followed? General to specific?

All global imports first, and then local.

    Andrew


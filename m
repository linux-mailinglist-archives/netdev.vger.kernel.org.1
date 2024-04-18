Return-Path: <netdev+bounces-89244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16BB8A9D58
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BD0B21122
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761515F418;
	Thu, 18 Apr 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M13ziffz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFA6FB0;
	Thu, 18 Apr 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451359; cv=none; b=rOz88ubd8HPhmaHgju5+Jqm7KrVxpJ8ER+psBGE457ONVS11gU/mBaIdEWF2Oq4CKSUU/YKF6Kh3+CSg6JKcE/lyjJE9+lrewjgKZCOBH8qod/3/Wfe1Y6XHQHHUeWWp9bOUM1qni+W3Iq3xa92YBNJzAy/etUBepXyp1TADK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451359; c=relaxed/simple;
	bh=X/X/TboqyfyUYTUVWHRPVjdRoe8kWfo0nNRba0UUe3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npCsQidWbccnnuVzMGyt+OKK7q2+IQC4/krc6oReKy48axX8LKossELD9o8uFLLmqt/Gka26IbfGIs+8YM+6KlqXe605bc8EU29wry7j/qcOyZqyhoWchc5r5sodpOV6VEr72R5WvyMrD2LxoqwgsJRN06WM07CweHfc0KFClCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M13ziffz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=exe9fv7oChxO5dkJDmvKHfPoF5uNIcU4b4Fk47PWcJs=; b=M13ziffz/YyFgNDh+s5EP6JkLz
	RQLWcoKOi6kSxj0F6z29pP14vOvkqXZn3xpvq7+VcLWlbkkwPPWfoWOpJR8iSv73gTtv1R540raXC
	xkM6jU3cQq8mdkB0Bxoeil5jrjtbXYixs+esMcHSJCMPLJ2WN3P/2Du+bsoNJ5xHQjFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxSy9-00DMJm-3I; Thu, 18 Apr 2024 16:42:33 +0200
Date: Thu, 18 Apr 2024 16:42:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <176fe839-7142-49be-9fba-1e105dc8d4de@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
 <2024041549-voicing-legged-3341@gregkh>
 <20240418.220047.226895073727611433.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418.220047.226895073727611433.fujita.tomonori@gmail.com>

> >> +            if i == 0x4000 {
> > 
> > What does 0x4000 mean here?
> > 
> >> +                a = MDIO_MMD_PHYXS;
> >> +                j = 0x8000;
> > 
> > What does 0x8000 mean here?
> > 
> >> +            }
> >> +            dev.c45_write(a, j, (*val).into())?;
> >> +
> >> +            j += 1;
> >> +        }
> >> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
> > 
> > Lots of magic values in this driver, is that intentional?
> 
> The original driver uses lots of magic values. I simply use them. As
> Andrew wrote, we could infer some. I'll try to comment these.

When you start from a Vendor crap driver, part of the process of
getting it into Mainline is getting it up to Mainline quality. If this
was C code, i would be trying to replace as many of the magic numbers
with #define. And then add comments about the best guess what things
are doing, based on the datasheet. The data sheet however does not
explain all the bits, nor give every register a name. But you should
use as much information as possible from the datasheet to make the
code as readable as possible.

	Andrew


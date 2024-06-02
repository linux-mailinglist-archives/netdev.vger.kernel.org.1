Return-Path: <netdev+bounces-99986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD788D762B
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A9D1C218FD
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922040855;
	Sun,  2 Jun 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DnKT0AY/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B043AC5
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717338073; cv=none; b=Cchr3Yt9S+x4jFBlW4Lk/STXniUP8sSc1PHTErDkzcotu0Q/+TuS2JG2wChL6sMDAknwu+VNrC3q6w3n5YK3wS6DxBTVyxWeaU70IDyFd7fXWAjt8j86ioLFYmPmiKI7Vggjg+JJFmED3wx2RI/e0ULohxa2vikHkEHzXowMBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717338073; c=relaxed/simple;
	bh=gFwfCv1030Lqd5eYxjox7Dj+TAhbrNehgtzOzdM5hoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOWxPsqgmnLhOXEbTxEdN5o0TYxIsUpYigAQpnYsVoQGVkV1XmytbfkH8gR2mL6mdDYcCANsEkLRJVFqwlSPlTkAlLCFQtIRjR9l6FIOAS2OrkIBbRqR31tuQHt/nXQI8SrCNISRD5UX6REckb0Amw0cWogXp7VQIuaHSVx3dWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DnKT0AY/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kGYmFBw/YcXoNqXlN8RS6kJb2pQEFKWH4xRKsNit8Ig=; b=DnKT0AY/BJWmZtnVN6NNyZi6nI
	KeDaKIaD33ebJwgxGWH6ug+6vVSGu4QY4JXG3BpTy9kmSpqd6ebfD11aFT7m6jRNx/+4tZwzplJSn
	1WtR5NPc1su2pBSc88zq4sJ+BABPqixlZ20dQ+sOxpZRsS4VH8B5poF5YyLQPqNgxRuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDm50-00Gc5b-K4; Sun, 02 Jun 2024 16:21:02 +0200
Date: Sun, 2 Jun 2024 16:21:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yangfeng <yangfeng59949@163.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	Yang Feng <yangfeng@kylinos.cn>
Subject: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Message-ID: <098c355c-a7b7-4570-988f-56e7d54989f3@lunn.ch>
References: <20240602084657.5222-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602084657.5222-1-yangfeng59949@163.com>

On Sun, Jun 02, 2024 at 04:46:57PM +0800, yangfeng wrote:
> From: Yang Feng <yangfeng@kylinos.cn>
> 
> Stmmac+RTL8211F cannot set network wake-up, add related functions
> - read: ethtool NETDEV
> - write: ethtool -s NETDEV wol g/d

I don't see any interrupt handling here. How does the wake up actually
happen on your board? Is a pin of the PHY connected to a PMU? Maybe
the more normal way is that the PHY interrupt pin is used to
GPIO/interrupt controller which can wake the system. But that often
requires enabling the interrupt.

It would be good to document how it works for your board. That will
help others who need to use the interrupt method not break WoL for
your board.

       Andrew


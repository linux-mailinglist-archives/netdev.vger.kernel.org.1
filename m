Return-Path: <netdev+bounces-112879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0A93B958
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 00:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4598D28454B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9DC13D8A8;
	Wed, 24 Jul 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYDqnVuR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE513C683;
	Wed, 24 Jul 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861847; cv=none; b=Mo3gSUdvQDfP/NcA+8dyPyPCcHFOnXopb3wBRjqgr70VWTi3jYq8YKCu6ORUlC7qhKyrgeF3GaBqrSOg9sJsefagk7B4lMmBaWg+gUKiJMnUcXUZIn1Ddy9zSOoh2Jwfspd6ynA8YOW7B59S+cxDbFBc76Gw0u/qqUA8aFTi2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861847; c=relaxed/simple;
	bh=QsV35kx67fk6W7FePfSB912TE52cOz2MXf4AVn8FWT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAyqfAhPempMX21XQqgAr3+x4+E1dgwSWCQmNZ65alXTv33+cqsLIyRSB45Pkn05buldc7LEHj2sGgE300NIyWwg6HGyDmVv09DyU+Ao0HDLI2dcvtTnwzwl6GDjOsL0lLHw2mXVB4PxbvfhoBfxXO1vpXHlRFeA+m4sq8qHwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYDqnVuR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AnOsDNoOUMx34awfCSEwq7vD/aAuMY5vGGHbjxcPkq4=; b=tYDqnVuRmeew92WQD0EJoT3s1A
	FOaSRp4kf5vQ9SruCECUmZVzGy9lNSQ0Cg01+bsehjK4c1MwGOoClI00m5g1II39wPhEJAVgQenrH
	h6bqZTrSObdlIWQMqB0u3ddrHi8RYKdI5eLs54CCvx02pZX6I42fBPU/IGrFWeoPEKjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWkuv-0039o2-Ei; Thu, 25 Jul 2024 00:57:05 +0200
Date: Thu, 25 Jul 2024 00:57:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
	gregkh@linuxfoundation.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	lucas.demarchi@intel.com, mcgrof@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
References: <20240724145458.440023-1-jtornosm@redhat.com>
 <20240724161020.442958-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724161020.442958-1-jtornosm@redhat.com>

> For the commented case, I have included only one phy because it is the hardware
> that I have, but other phy devices (modules) are possible and they can be some.

So this the whole whacker a mole problem. It works for you but fails
for 99% of users. How is this helping us?

Maybe a better solution is to first build an initramfs with
everything, plus the kitchen sink. Boot it, and then look at what has
been loaded in order to get the rootfs mounted. Then update the
initramfs with just what is needed? That should be pretty generic,
with throw out networking ig NFS root is not used, just load JFFS2 and
a NAND driver if it was used for the rootfs, etc.

	  Andrew


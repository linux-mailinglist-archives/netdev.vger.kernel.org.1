Return-Path: <netdev+bounces-61221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65595822E6C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9142B2340F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB3199A2;
	Wed,  3 Jan 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HQna5uzz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545481B280
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IEgas0JQm1hJblT1IpLnxc1qyOy27q9Fc71HcnAHZCM=; b=HQna5uzzNdhNROTPwc16RNsiSO
	05AaNGlwGxL1dG7MwqiSWkCZZtCJINtn4W0e6vl3igaKFfFABsgwVkdWECWzInvnu9UfzQTbKx4Y3
	nv7beYGtWL5W7+qP2UiaCNvEFECnezkSfBizP3xHQrf+Yvvj+r3CBNv4nLGHI6AZV4KE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL1Ll-004Fz3-LX; Wed, 03 Jan 2024 14:32:01 +0100
Date: Wed, 3 Jan 2024 14:32:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mdio_bus: make check in
 mdiobus_prevent_c45_scan more granular
Message-ID: <64fc51c9-760e-4ac2-aae0-5bd510a2d4c7@lunn.ch>
References: <42e0d1c5-fdd2-4347-874d-2dab736abbdc@gmail.com>
 <3e99877a-6f85-4842-8418-584a8aaf03f7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e99877a-6f85-4842-8418-584a8aaf03f7@gmail.com>

On Tue, Jan 02, 2024 at 08:53:12PM +0100, Heiner Kallweit wrote:
> On 02.01.2024 16:54, Heiner Kallweit wrote:
> > Matching on OUI level is a quite big hammer. So let's make matching
> > more granular.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/net/phy/mdio_bus.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> 
> Shall we put this on hold until we better understand the root
> cause of the original issue?

Yes, lets wait for a while.

     Andrew


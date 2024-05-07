Return-Path: <netdev+bounces-94100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17A8BE1DD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6C31F25EF2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37518156F45;
	Tue,  7 May 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H+RObFUe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BD156F23;
	Tue,  7 May 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084302; cv=none; b=G2wE5GD2/8PVnCy+qUrY2gn8dLGwor5PKvmSAeruGy0fdP8PZCQXeZQieFg8fDyHwv2V+iMlbS9iV6mbxjcjO4E9vX90dz3j1Thf21u3sZdoSSUSsFDW9yQD2kGcoB/Ujp/jHtTS4yzTG247/AlhkGLwLGiYFDbFIfsImAqn0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084302; c=relaxed/simple;
	bh=XaLCNAECeluzjka4Oi85rIiDsTD/ZdajAgV3Z6+v+7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsjIcKB2mWGqYh/HY/jdHoEqpefn6MscHY/Lu/UBCLVIYro70vZnNp7+T1DuprfbvravDJpEcpfv3nbBI1cB44Ej6FO/jmizqGea8TUqKWvVwMTLBpRsp0IAL32GUFbkDp21VvTlNRPsN6IMfYxYtkkBryu34GDpS3JaPo0WWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H+RObFUe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sQM7rZP+pwd6y8h6SxqC2oyGkTbPvL7xGJBN4HpKr/I=; b=H+RObFUegfuZ2TdyPCJN3rgdVf
	LUzOCqnzI7JHPLWff6XuRq2XbRFosmQyErR3l5CR9BWv4yBUbPYku0tQEO871ENmYWt4F51D+lkVW
	DvXnuPEA9tNUByoG/kXU6mPav+iVuexgWqHtCt7e6C+AigcqHgbXrYBwhJC4tRTnWpCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4Jlr-00Eqp4-Ak; Tue, 07 May 2024 14:18:11 +0200
Date: Tue, 7 May 2024 14:18:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: marvell: add support for
 MV88E6250 family internal PHYs
Message-ID: <a46c1c48-653b-48b1-9a56-da2030545f81@lunn.ch>
References: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
 <0695f699cd942e6e06da9d30daeedfd47785bc01.1714643285.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0695f699cd942e6e06da9d30daeedfd47785bc01.1714643285.git.matthias.schiffer@ew.tq-group.com>

On Thu, May 02, 2024 at 01:13:01PM +0200, Matthias Schiffer wrote:
> The embedded PHYs of the 88E6250 family switches are very basic - they
> do not even have an Extended Address / Page register.
> 
> This adds support for the PHYs to the driver to set up PHY interrupts
> and retrieve error stats. To deal with PHYs without a page register,
> "simple" variants of all stat handling functions are introduced.
> 
> The code should work with all 88E6250 family switches (6250/6220/6071/
> 6070/6020). The PHY ID 0x01410db0 was read from a 88E6020, under the
> assumption that all switches of this family use the same ID. The spec
> only lists the prefix 0x01410c00 and leaves the last 10 bits as reserved,
> but that seems too unspecific to be useful, as it would cover several
> existing PHY IDs already supported by the driver; therefore, the ID read
> from the actual hardware is used.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


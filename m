Return-Path: <netdev+bounces-223941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BAB7DE2A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A5E176629
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64D30BB9F;
	Wed, 17 Sep 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="042Z8aE0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDC27B327;
	Wed, 17 Sep 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103619; cv=none; b=nKHKFRXRJPof3m2C5iBELX/2iWQJmYuvQCqB2w+EyR4FzgL0OUUQyeTfIOefYUFocZdDEfzg3qb0Mj2fptiv430jreo97uhKciy9PUrKib7kfZQk/1cG18isal/f/T5Ah59dgdOjtbwU3UX9lP3NUSEjIszCa7R4CloGKiaHxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103619; c=relaxed/simple;
	bh=nNmhE3RItLIRca/R4MuPOB4UUV52yGzBElfntr3ycRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzLUGJAljlc4mjoVnlIwhSlm5XxsP7KSbGed1FEOpBeLpH7PTJgt7vyEZpX7/EccFVKVShrRMz7/sG5YFbZ0O8rtKwbHd/1SlwAGmWtY/tVDKzQOzTgCC+JyEv85pGnnQjTw6Xo21+ANh1M9sfCY9tPH/A7dquHlZQX0M3Z3FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=042Z8aE0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AEQHN9NOrHUX6WSDWUyLYAXWBcyAt6Sm6ISFtDOz+xY=; b=042Z8aE0260IRmWyeU+sQtkzuV
	gnrrjJOQpCwanmXxjOlQ0WEkCcw3bjyfA1C8YujRr1tU4Eq7RYOipgqF4iOaon8ZTMtD7P/+Pbcc0
	244N35Di3ZzM1WlDaXp+NOmMFaWQ8pil9xOp2UA3vBkHeFDWjg4p2EEM9wA1J/L4FQDo4IQSw9POu
	/mKB6ODWZWnVW7rvzgm4lBJxs0pnta4BfFcvQnInJWKKH+NvHnb44b00GKRVKaDJq/CspkVah2mv8
	PGUwEnwOtxmGifY5RQWRczphTV9WFXfHc8pRzObhDQkTzkO0FqwVYI16jpDpYVQbbW1CgIdtaGPKq
	dn20Nhng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39102)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyp3k-000000003Vk-2PDk;
	Wed, 17 Sep 2025 11:06:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyp3d-0000000006C-3LL9;
	Wed, 17 Sep 2025 11:06:37 +0100
Date: Wed, 17 Sep 2025 11:06:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yicongsrfy@163.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <aMqILVD_F7Rm-mfx@shell.armlinux.org.uk>
References: <20250910093100.3578130-1-yicongsrfy@163.com>
 <20250911112525.3824360-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112525.3824360-1-yicongsrfy@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 07:25:25PM +0800, yicongsrfy@163.com wrote:
> However, there is a particular scenario as follows:
> 
> Some PHY chips support two addresses, using address 0 as a broadcast address
> and address 1 as the hardware address. Both addresses respond to GMAC's MDIO
> read/write operations. As a result, during 'mdio_scan', both PHY addresses are
> detected, leading to the creation of two PHY device instances (for example,
> as in my previous email: xxxxmac_mii_bus-XXXX:00:00 and xxxxmac_mii_bus-XXXX:00:01).

IEEE 802.3 makes no provision for a broadcast address. Here is what it
says about the PHY address:

22.2.4.5.5 PHYAD (PHY Address)

The PHY Address is five bits, allowing 32 unique PHY addresses. The
first PHY address bit transmitted and received is the MSB of the
address. A PHY that is connected to the station management entity
via the mechanical interface defined in 22.6 shall always respond to
transactions addressed to PHY Address zero <00000>. A station
management entity that is attached to multiple PHYs must have prior
knowledge of the appropriate PHY Address for each PHY.

So, phylib code can't make any special exception for address zero.
We definitely have network adapters where their PHYs are at address
zero, so blocking that address will break them.

As for Andrew's suggestion, returning an error in the probe function
doesn't prevent the phy_device being created, and it will mean that
if a MAC driver attempts to attach to that instance, phylib will use
the generic PHY driver instead. So, this doesn't solve the problem.

I don't see that there is anything that a PHY driver can do to solve
this as the code currently stands, especially if the MAC driver is
coded to "use the lowest PHY address present on the MDIO bus" (which
in this case will be your vendor's idea of a broadcast address.)

I really don't think we should start adding hacks for this kind of
stuff into phylib's core - we can't know that PHY address 0 is a
duplicate of another address.

The only thing I can come up with is:

1. There must be a way to configure the PHY to disable its non-
   standard "broadcast MDIO address" to make it compliant with 802.3.
   I suggest that board firmware needs to set that to make the PHY
   compliant.

2. As a hard reset of the PHY will likely clear that setting, this is
   another nail in the coffin of PHY hard reset handling in the kernel
   which has been the cause of many issues. (Another nail in that
   coffin is that some MACs require the RX clock from the PHY to be
   running in order to properly reset.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


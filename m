Return-Path: <netdev+bounces-164527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF10A2E1C6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6311617BF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74C632;
	Mon, 10 Feb 2025 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G0XMAlA2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17145258
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147574; cv=none; b=IMujM/GfdiLSEG1vaOHcJoMss78k44CBoxixojAaZRrcFK8cwTmPb2rCDPgTIFRm7eT/c1JRiI+B0zoQFKVLnrjTBTQSwKJ7pKZ1tGutenSPTkKK2+DBnFTcuWY6hcw+U8TJYErR+h5R6J6XA4i5Vt0AgfEYUZu3/maSf5n9WkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147574; c=relaxed/simple;
	bh=MG/y6wumQaqPj6ectDsmzcLThbySPojKPPFgXLjBxMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Vl04Nrv9Jme34G+sD1Z19QOonIiAte4uF6uh7W+R59uURrc7qmqOfKvbF7G4Gd9G0sbrCMiH+H4sdM1fOm7K3jx2e2VQtkDNhg1lMUAqymQrB8J8zYFTEoVCr5zd7A3pfxGVzxSYQjWvqmiHXpNBxMisq/njMunuxC6uIxQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G0XMAlA2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+zrVL00Y7mH/Y/PHtnbU3jGC3BfYX+exBMvRQJY6Gmo=; b=G0XMAlA2tSUgTM8YwNdaI9bfGF
	puXU5v7dupj6py2tUxKkUubzDaf9/mq9A2M0XGaRD/bJ4A1LGqcsLelJEywgcS0UBrd2qWU7Tc+mI
	Y0dfHPykt4KytEM1elReD54IaHdcewDsJQyonKCnCnfWfVX3I/HYPclfWxIOjVs04hiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thHj8-00CYEc-6b; Mon, 10 Feb 2025 01:32:42 +0100
Date: Mon, 10 Feb 2025 01:32:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: make configuring clock-stop dependent
 on MAC support
Message-ID: <5232a50c-3840-4c76-8b9b-cb0dcbbcc833@lunn.ch>
References: <E1tgjNn-003q0w-Pw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tgjNn-003q0w-Pw@rmk-PC.armlinux.org.uk>

On Sat, Feb 08, 2025 at 11:52:23AM +0000, Russell King (Oracle) wrote:
> We should not be configuring the PHYs clock-stop settings unless the
> MAC supports phylink managed EEE. Make this dependent on MAC support.
> 
> This was noticed in a suspicious RCU usage report from the kernel
> test robot (the suspicious RCU usage due to calling phy_detach()
> remains unaddressed, but is triggered by the error this was
> generating.)
> 
> Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


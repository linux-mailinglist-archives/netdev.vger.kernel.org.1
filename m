Return-Path: <netdev+bounces-184607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CCA965C6
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB587AC237
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9E1F5827;
	Tue, 22 Apr 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KZt5KOmZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816DF510;
	Tue, 22 Apr 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317393; cv=none; b=osllSSzbaZzBOcRiiKw9kxulunocAadKW4/5idnyPq/A12tpNHLbd3BN0WrugXSJr+H3q4xsT9BbzmL3whA1V/vpP1jrJOEcwWuYsGgw8S90YewK0Tl7omR1hQwMR1uug7DhHZnsxCL1nOl0hpqmlib5S7cHBt3QQyrIyz53og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317393; c=relaxed/simple;
	bh=9U0y8AazlFYUUbq6n7jrNcFwYKUoO+Qq3tFFP4YSOg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBg9wUj7j/ZVqrnS8CRircF7MqBVhi7V01tUW1oCMOhB17prOxwEpaxFWjhIT+GZOJyD6SvZWqJM2efFORZfjT6WpRwEulOvOqrluYOsj+pmWbQdEOyBgz6+A35jehI1TeP5NOQeRPqDGs7FqfN0rQrbEWqmMsu77VgUzBWeKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KZt5KOmZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eWqimEvZYjJ+hHLiu/HNG+SHzYVuamy+C0IrsJuwiZc=; b=KZt5KOmZMimyaXz1jUZ3tCe+nC
	gHyTmBIBPv2GDXRgIPXD86ceGvYoRmhJR0o+qMKCtK8dw2EQLu6ki9wnqj5auK0MR/ak30Rfjon95
	nGbKHssWOnmxa85ge4y2nY0ar4CjdgNJeoYn9CgZ7F9f8EilHiWGiOqcw3CIDBe/eCbd4e8bGN11O
	c3tPXs2mTzCz7XiBqLXQGeN8O+AHDQT1IK1knc6qdihGUGlvml0Mt22pyhq+JTZxrm19eXK+Svrre
	JWbI/uHRNK3iT8ZGObSGZO5Mvb0L8RLhD9gVSWaFSbO1bEgk/8K2jS1aI5cGd7qYjtqO0YMsiajhR
	174DMe/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7AmP-0004C5-04;
	Tue, 22 Apr 2025 11:23:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7AmM-0007PA-0g;
	Tue, 22 Apr 2025 11:23:02 +0100
Date: Tue, 22 Apr 2025 11:23:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net 1/3] net: stmmac: socfpga: Enable internal GMII when
 using 1000BaseX
Message-ID: <aAduBtZ9jc_AMmEZ@shell.armlinux.org.uk>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
 <20250422094701.49798-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422094701.49798-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 11:46:55AM +0200, Maxime Chevallier wrote:
> Dwmac Socfpga may be used with an instance of a Lynx / Altera TSE PCS,
> in which case it gains support for 1000BaseX.
> 
> It appears that the PCS is wired to the MAC through an internal GMII
> bus. Make sure that we enable the GMII_MII mode for the internal MAC when
> using 1000BaseX.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


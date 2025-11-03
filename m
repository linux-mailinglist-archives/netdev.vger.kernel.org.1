Return-Path: <netdev+bounces-235205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46EC2D6AA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D98594E5EF1
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613F31A7F3;
	Mon,  3 Nov 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eroDWRMu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D331A579
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190147; cv=none; b=otH+zrhr3KIUI6wgm7L7Da473mIM2PJPFSR4mRxrkjpoLGp9dFMhX6a89vwdpug+8iWEb7F4AQNHesIkjs+lx/WTPJwQJ40aQnndZ1yia/WKUlCR8pRPspSb/9Z0/SeTcGYJq8dg8uhMTudjjY+u0H0ykY2yS6rtGVk7+uG+84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190147; c=relaxed/simple;
	bh=4eo62lHOOzrlaACh2LsE5YEMR/bCnNJaLotrqwgnc3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX4qPVP+D2AfahN9aQrx9DNfTR/kxVI0QUw6vqxa8gj+goktoGUoimmZyJrMlXlm1oe73jbSVlBno242351laSYGh8xO+1nHiRcAI8clVDOp9OqpCirJzXgwEFR4AvYFLqj40VWzvY7rLvsQ1yYlX2hTdBxdb2thFpBycHSMApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eroDWRMu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X7LHTYlRd2Uco4t3uvuks9Y03m58cTc/VFc7A12+Lhc=; b=eroDWRMuE2iZ6523AxbAjTI8As
	sHamown5yiImEunNAM/nTTJyo8ESShHMOcVebEnIJOUB7JkRM4atIYhiot3lRHS2zN8Lsk3+Rz5dp
	gdK0sMVurz9LdwKht3K67CfHEUj0sFIo+whfp1s/jCmCnaRi0LaE+1ce6ZZsJs27hNgNfLplRPm81
	eIlaIW5nkSWCwNelpP00jUy6st6L8/HUZv/hAUZ/s0JmFPJBCkJO6lPMl5RezQIFBn1p7siCgMFwX
	Rb7E+rqdW26Dg5ArwybxOgPB0RbuXGVu6sYgW4JbrwVmHjtspTpQhfcUZ3y+jMXC+jZ6ip+2NFiNu
	imxbJ6wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFy9T-000000001Bu-45ss;
	Mon, 03 Nov 2025 17:15:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFy9R-000000003y5-0W5l;
	Mon, 03 Nov 2025 17:15:29 +0000
Date: Mon, 3 Nov 2025 17:15:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQjjMM-wCyPXsKUh@shell.armlinux.org.uk>
References: <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
 <20251103121353.dbnalfub5mzwad62@skbuf>
 <aQjAeCNGA2cjNXy6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjAeCNGA2cjNXy6@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 08:17:20PM +0530, Mohd Ayaan Anwar wrote:
> Here are the logs when I boot up with a 10M link:
> 
> Media speed 10 uses host interface sgmii with rate adaptation through flow control, inband enabled

As I say, this is broken, and this comes from how the PHY firmware
was provisioned in the Marvell toolset for the PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


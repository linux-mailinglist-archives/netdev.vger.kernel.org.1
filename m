Return-Path: <netdev+bounces-162503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D842FA2719F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA318886ED
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC3210F76;
	Tue,  4 Feb 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="grjh7xGP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED82101BD;
	Tue,  4 Feb 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670987; cv=none; b=C+WxczdxmSZmSunx4kbZb4yhkBmRrS+vsN0YUJ715cZkkmCgvoQ0Jbf/AWiGCNffsgl8NiPnZUlaO0bsgg1Ro+XqXMJ8rMZRBRv+LhjueK+pk0XaZ194nt+Z/uREydt6Y6jTrsQA3zbya+FPM9w7xmLN6JhdQCM7tIivDtceMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670987; c=relaxed/simple;
	bh=d8BFEH60jD/R5jxvAVRS4XOFB9XxrdufokPf3pA63BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7T4Abn9yU47sPo8I+rBApTG0CPr0/EPYEn4qUzBkdrbeFX0ipk4XX7yzCtoQu7ECZxpeDgORfX0/ZB6Wx/P29tild3poTrgzWX2llaf0PhwIryfD0UmY8OYZyVIfJJUddnHMLGZuqt9OaZ1dODEMAvfLpbI4YdP6QizY5m0NMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=grjh7xGP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rox8IBA4TOog/Xi9d+CxsHeyf4Lozl25g79JAYxmrsE=; b=grjh7xGPy1aXjV8j/7VAJRQ/3Q
	Zq+FAY0cDbRfh8SEOCyMIV1sMNeR3vmdA4pZtUw+BnlN6lhG2on+Btf+bSiva7Db/YMxo3UGx9Oro
	9NpsoE4iXTuhscCT73b1FFUfGw/NpiYwJw03GvNr7R74HprHXSBG91FnziUApwNBAVuNBN0vN3vVQ
	NM9Y34zvc+ynj9Gt07JXEehZEc4GfFbRKq1vvfRLBqmB9q4XfR8hCmC99NPeOidVjlz2C/poPwJwx
	B8/RLvAKHGc9fg+IFjS8I9g9n2f8zGD1y+5e64/F6tdwo8zhM6iEceRokQhidTowc8xIC9O9DjWJq
	JVdGvBZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfHji-0003Tg-3A;
	Tue, 04 Feb 2025 12:09:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfHje-0001NM-1y;
	Tue, 04 Feb 2025 12:08:58 +0000
Date: Tue, 4 Feb 2025 12:08:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes
 according to the interface mode
Message-ID: <Z6IDWiRF73sdVWob@shell.armlinux.org.uk>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 04, 2025 at 02:10:17PM +0800, Choong Yong Liang wrote:
> +	int (*config_serdes)(struct net_device *ndev,
> +			     void *priv,
> +			     phy_interface_t interface);

Since you call this from phylink's mac_finish() method, I would much
rather the call down into platform code was also called the same so
we don't end up with a proliferation of methods called from that
function. As such, please also arrange for it to pass the AN mode as
well.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


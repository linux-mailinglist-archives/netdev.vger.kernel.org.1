Return-Path: <netdev+bounces-169900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0AA4656A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AD13B3BAE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA421E0BE;
	Wed, 26 Feb 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ya8e/Mih"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80EF14A627;
	Wed, 26 Feb 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584478; cv=none; b=RU069tCdAMbqzS3VcjqUhdHhoG5D0bwLy+1RY03C+CMDmGufFbLQ2N0RcmYMCVmKK6Y6NJbYo2VF9iNRecXSa1rdT7xgsI/2cq+L20eHCZH+ZEBsCvgoMmJvWIKqBfs40F4qQDudzWVEPR+XQHaGgzUys9d0MzB8E4AC7HSF+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584478; c=relaxed/simple;
	bh=g4VX+IIjpYFSia5Wf2OfNpcphkL/mbF6IOOP6hK6jk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBwU4Qj/nYMaEnHIXETcn3HTqVNiFMmyPGQf3zDQwhG9xXlHGoXQ4h7bOOq7EPquDatvFrM3qJujpL9w0TZRwW8WayIM7wrELb/k73T0RNoYmH/sfv4owuWLenskRyZMu8i/EcW+yFcAnLOZeAPcWjwodZDnVOZcVece6gNtAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ya8e/Mih; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JQFHZ/kdDsS4cmacYVEXIC+sRK+7fav8gHKUqIh5pBo=; b=ya8e/MihaW9zZqW6s9mBDHFloc
	Sm5jbxrIfXIRjDtO8huDZnrzi5pWuHJVcEart1ut2y2g1y8SE+OI1Qs3gsoWm6iJNcW+nOB5XCZ99
	FGQ1LNq8aoLJ2cSJmqsNg9V8YJLA+9TOEQ1My3owfK18QKqSxD16YV82bHL7KXCT+MypbIm6MB75i
	O4UMnBszWlJB5AsJ77jMv/RtDPaenNeZo7YB6hqmWjCjmv3D19S7uqFsAW/AnL8NMYJ4V56Xs1EDu
	5aFm05oKk7nSsSeE71wde3f8TFBoaWmWI6FRuLSfE8OLignQUE5U6iEhXEMTGMLcwA4yc9AlsVYcE
	klDf8hjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnJWm-0004kG-2T;
	Wed, 26 Feb 2025 15:40:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnJWk-0007DX-0U;
	Wed, 26 Feb 2025 15:40:50 +0000
Date: Wed, 26 Feb 2025 15:40:49 +0000
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
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v8 5/6] net: stmmac: configure SerDes on
 mac_finish
Message-ID: <Z782AcW4a7SEfDUT@shell.armlinux.org.uk>
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-6-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074837.1679988-6-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 03:48:36PM +0800, Choong Yong Liang wrote:
> SerDes will configure according to the provided interface mode after
> finish a major reconfiguration of the interface mode.
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


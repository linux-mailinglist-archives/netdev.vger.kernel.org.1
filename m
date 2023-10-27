Return-Path: <netdev+bounces-44664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E977D900A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CD7B212A8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F0C2C3;
	Fri, 27 Oct 2023 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bWNuWJQC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CACC13D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:39:02 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846181AC;
	Fri, 27 Oct 2023 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UrVb0RxnFRlTxNQClfI8ZHdeowM3uhiJ9mxX6SCrB/s=; b=bWNuWJQCcEuejHP845AFX2lFJC
	WQ+R+JY4/YiK21y5U0P/rQQ1K7AFgsItJU5KzHDh+DOfSS/APHTQLRVLFrynNOJZCgRVmm4eeNIQl
	mMNAPZguvQAV5JKkzY5whERVVfBI4zbRH/+nOlOjxXo/c+6y64IgXOZaELBJ5OaUP2WSyF316S29G
	P3KuAgnUBW9oktobYODQnCqyr0vqoITHSJq5Uka2xGpsMWPPujC/ZIH9xpfVFNG/e8CDhglqU7usB
	5/joRs1HV9raMiXpmfcjQuyXYxPVgU6rnduQRDlk2E5TIYqudckCMYJvbbmu4qveqh7zY8hOt75iO
	46BsoR6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56172)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qwHQc-0007Yi-0Y;
	Fri, 27 Oct 2023 08:38:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qwHQa-0000Zo-5S; Fri, 27 Oct 2023 08:38:44 +0100
Date: Fri, 27 Oct 2023 08:38:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gan Yi Fang <yi.fang.gan@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Ahmad Tarmizi Noor Azura <noor.azura.ahmad.tarmizi@intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: add check for advertising
 linkmode request for set-eee
Message-ID: <ZTtpBCZuB+bjVt9D@shell.armlinux.org.uk>
References: <20231027065054.3808352-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027065054.3808352-1-yi.fang.gan@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 27, 2023 at 02:50:54PM +0800, Gan Yi Fang wrote:
> From: Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>
> 
> Add check for advertising linkmode set request with what is currently
> being supported by PHY before configuring the EEE. Unsupported setting
> will be rejected and a message will be prompted. No checking is
> required while setting the EEE to off.

Why should this functionality be specific to stmmac?

Why do we need this?

What is wrong with the checking and masking that phylib is doing?

Why should we trust the value in edata->supported provided by the user?

Sorry, but no. I see no reason that this should be done, especially
not in the stmmac driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


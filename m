Return-Path: <netdev+bounces-163030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38629A290CD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133C1188901B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4F7E792;
	Wed,  5 Feb 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VeLMyF8b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5581156225;
	Wed,  5 Feb 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766400; cv=none; b=U4MKrAu5rmEBB9CdcIoqxtNah82iqxkxo9jo2BwE1ROqPDOdrFy9CMb36qzkb77zoPcMnC8LGzYX20JalCE0/cg/uoKKTV1oGESVGJY6ohUnPfMToAlkasp8/QA25KpUkEaJewQR5EO0eMsjfSeVy2bXHXseAqDiluzckL67p+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766400; c=relaxed/simple;
	bh=X6UZwehcqhpv5C0RCnqO0myW9qgvIO+fZ4sIewulYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfOcGWuNszPjR4WOR98+RY5nbtJ4iKFvpwBoVuIkT2kRqtB3ktdKSMNfJG3FEwYZWZjYwuV+rYEnrr1M9DYpc8T3aTLDm8UMMDsj266cmMfDFnTBzFHIrNS8i99tul2o+G3uoATNskzFgf6a5r5xELIvY05br5TGplypUN0V/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VeLMyF8b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0bL3gxLmyKoIOFUQltNWan7x+Q3hxZzBXfuqkmaS2PY=; b=VeLMyF8biNfumqmuZmc/C6wCWs
	cYHL1aCStiFMh3q45g/T0gP/yblv4P2Sr/aG2NKh5HsTcytUdyGSRMXfQHuOl00YgiuU8X10nSp4d
	kknFpGsZJs26ahI6wJZ5Np3T8QPegTgBgvDL/erMWki4TMPAzMFMssXY7J5BWBYT7glwODUwdaCkH
	sVLbHj3pwXrk/oHU+rfSNeXfURFWx/Doph3ecygwITrKTsKOMC40Gb98HftgsxOQguZc+G0grkk46
	E+l2hNjQaqhq46/kyWqSK8dor0UoSKkUpcC2R9AtG2kDqWJrcf1r7XUM9TdmkY+oKoFZni+5d3qWy
	hoQTXHUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfgZ3-0007N2-1Q;
	Wed, 05 Feb 2025 14:39:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfgYx-0002Uc-2s;
	Wed, 05 Feb 2025 14:39:35 +0000
Date: Wed, 5 Feb 2025 14:39:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Steven Price <steven.price@arm.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Furong Xu <0x1207@gmail.com>, Petr Tesarik <petr@tesarici.cz>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
Message-ID: <Z6N4J-_C3lq5a_VQ@shell.armlinux.org.uk>
References: <20250203093419.25804-1-steven.price@arm.com>
 <Z6CckJtOo-vMrGWy@shell.armlinux.org.uk>
 <811ea27c-c1c3-454a-b3d9-fa4cd6d57e44@arm.com>
 <Z6Clkh44QgdNJu_O@shell.armlinux.org.uk>
 <20250203142342.145af901@kernel.org>
 <f728a006-e588-4eab-b667-b1ff7dfd66c5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f728a006-e588-4eab-b667-b1ff7dfd66c5@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 05, 2025 at 10:22:00PM +0800, Yanteng Si wrote:
> 
> 在 2/4/25 06:23, Jakub Kicinski 写道:
> > On Mon, 3 Feb 2025 11:16:34 +0000 Russell King (Oracle) wrote:
> > > > I've no opinion whether the original series "had value" - I'm just
> > > > trying to fix the breakage that entailed. My first attempt at a patch
> > > > was indeed a (partial) revert, but Andrew was keen to find a better
> > > > solution[1].
> > > There are two ways to fix the breakage - either revert the original
> > > patches (which if they have little value now would be the sensible
> > > approach IMHO)
> > +1, I also vote revert FWIW
> 
> +1, same here.
> 
> 
> For a driver that runs on so much hardware, we need to act
> 
> cautiously. A crucial prerequisite is that code changes must
> 
> never cause some hardware to malfunction. I was too simplistic
> 
> in my thinking when reviewing this before, and I sincerely
> 
> apologize for that.
> 
> 
> Steven, thank you for your tests, Let's revert it.

https://lore.kernel.org/r/E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


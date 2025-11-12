Return-Path: <netdev+bounces-238037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FEC530E2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6BDA5470B3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28D33BBC4;
	Wed, 12 Nov 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q02TgTDT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8233B6E6;
	Wed, 12 Nov 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960575; cv=none; b=HApSNWMxog1FSdyKWufwCpZ2i6skH2xZ2cIPy1bIF4qu98C59HpG6ZaUSQyZVYOj8vnlZtldrqUcRmnIMuVDLG6bldy03snFTm/tUiSZonn5ewH12Sn5tAIwyxDchLizfwdXoxi6TabMcJdzOrh7FSMSpmf/XQeL8A7wg9tIHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960575; c=relaxed/simple;
	bh=zjx6B+619CsXbaouI/PHSTM+ikNzZ0gi0xC5Af+pay8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnuKQ7GuLxMJVIeK+jk1QVC4+WCiNzJtcHwi9ol9jWkpebI+QJvY0sGfuIHqIYXAZym9Q1Wp72xf9Hvd//wM7Ddgnn+CNC2FFKcnYv9fxX0UIjUI9TIeDMDOWPV5vLKyJ+apv27sdpcIvwx13OSyptLnfIWjS3Uhal8vv8HPigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q02TgTDT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WnViCk0cfIY52l7AXg9iqhjaJQI0ot9fPwMd05CyNmw=; b=q02TgTDTMZnGqnQd3Ton5KLVDu
	vpg8xkwUxnVOLQ89rd2lYQtamhBvbcaCieBgBYjVVpla+CDqmgILeB3T2R5qpw/t5EpIwcBPFaek8
	+yMydM55n1r8CLqutBEzCD5ePSe8MQvTk/5cGfdCeOECrY0e3kclkufL0HKfboa2bdQMjnCGDyVF+
	2656ynzNXL4ZrkR9Sl2XcA9muTSwRSlIQmjMV+OxfMNtB+/x/UxO4Ji4psheCOLd1NOmODboEh8M8
	e8xRbLTz/9TR9bSAUoLjI39IEJUm8Z1Nz5GJhVim+8uyXjvQqApgqgFxiuZRHRr3PuvOb6eqUlrps
	Fwl3ntXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45940)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJCZb-0000000046s-1jjA;
	Wed, 12 Nov 2025 15:15:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJCZV-000000003z0-2usV;
	Wed, 12 Nov 2025 15:15:45 +0000
Date: Wed, 12 Nov 2025 15:15:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aRSkoTJjVlUC6ZLQ@shell.armlinux.org.uk>
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111100727.15560-3-ziyao@disroot.org>
 <20251112065720.017c4d07@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112065720.017c4d07@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 12, 2025 at 06:57:20AM -0800, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 10:07:26 +0000 Yao Zi wrote:
> > +config STMMAC_LIBPCI
> > +	tristate "STMMAC PCI helper library"
> > +	depends on PCI
> > +	default y
> > +	help
> > +	  This selects the PCI bus helpers for the stmmac driver. If you
> > +	  have a controller with PCI interface, say Y or M here.
> 
> I didn't pay enough attention to the discussion on v2, sorry.
> I understand that there's precedent for a library symbol hiding
> real symbols in this driver but it really makes for a poor user
> experience.
> 
> The symbol should be hidden, and select'ed by what needs it.
> With the PCI dependency on the real symbol, not here.
> 
> The "default y" may draw the attention of the Superior Penguin.
> He may have quite a lot to criticize in this area, so let's
> not risk it..

Okay, should we also convert STMMAC_PLATFORM to behave the same way,
because it's odd to have one bus type acting one way and the other
differently.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-101538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C168FF4CE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF8E286AC0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB045034;
	Thu,  6 Jun 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DN5tJWtg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33D45025
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699155; cv=none; b=RrNJ800k5wlC7gYy4s5LO0+hNnA6YkKDgIinr6uk0tmEu/mHji5JpLaIS0itx1JrdmQiy88gjhZoznJUoOERUhFQVN1Tsz0IDYuyCxO6ScE4CiVvLJChzv/hzeukKZNQoriaXLkXpSlICrbdvO9rLyPNKc9RSGxVAAKhfEYQPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699155; c=relaxed/simple;
	bh=LEela/2V00yFmy1oYi1xzO40Cz0VCRwXwT8Pr2rUW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFIEzbCPBVY4jLH6FELqnMd5eYAtvDTo2mMPSS/geDM1DW6k5TfqJ77+Gvs9MxP4sK/8qi9tVor3BQ8FPxTkHnPoBH2tn54kPOWJWd7fHVhrRXjlYYNsTS34O8sgrvKl14nFIwG31PmgN4oEOqzI1fuxO/WM+z403dqjQCmdUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DN5tJWtg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NPkrDtbL6SDglP4m432l2ydFs0RYe5Jvp0p/W4dKkV8=; b=DN5tJWtgaPD8xC3V/kSOK+dp9H
	5FU53Nt8HEAAybp2/V6TpSCt45pUhaF9m3d6mUHIUbij2d2sGfoWSZpd7Mmw8pocONvAkIa2954Of
	ufKp7vhsg8gXA5X7gCpXCpTYHSEEGCpR8zjga66p2s3XpRQaVeTsJotb3isRgZPGqQO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFI0q-00H2im-DC; Thu, 06 Jun 2024 20:39:00 +0200
Date: Thu, 6 Jun 2024 20:39:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 00/15] stmmac: Add Loongson platform support
Message-ID: <3fa260a8-65bb-49bc-896c-658bb8b067ac@lunn.ch>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <ZmH/qN6lKGA/tGTW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmH/qN6lKGA/tGTW@shell.armlinux.org.uk>

On Thu, Jun 06, 2024 at 07:27:52PM +0100, Russell King (Oracle) wrote:
> On Wed, May 29, 2024 at 06:17:22PM +0800, Yanteng Si wrote:
> >  3. Our priv->dma_cap.pcs is false, so let's use PHY_INTERFACE_MODE_NA;
> 
> Useful to note.
> 
> >  4. Our GMAC does not support Delay, so let's use PHY_INTERFACE_MODE_RGMII_ID,
> >     the current dts is wrong, a fix patch will be sent to the LoongArch list
> >     later.
> 
> RGMII requires a delay somewhere in the system, and there are three
> options: at the MAC, in the board traces, or at the PHY. The
> PHY_INTERFACE_MODE_RGMII* passed to the PHY determines what delays the
> PHY uses, and thus what the GMAC uses has no bearing on this - if the
> board traces are adding the required delay, then
> PHY_INTERFACE_MODE_RGMII is sufficient.
> 
> If the board traces do not add the required delay, and the GMAC doesn't
> add a delay, then it is necessary to add the delay at the PHY, so
> using PHY_INTERFACE_MODE_RGMII_ID is appropriate.
> 
> It's all detailed in Documentation/networking/phy.rst
> 
> What isn't documented there (and arguably should be) is if the MAC
> adjusts its delays according to the PHY interface mode, then the MAC
> should pass PHY_INTERFACE_MODE_RGMII to the PHY _irrespective_ of
> which _ID/_TXID/ _RXID has been selected by firmware (since we don't
> want the PHY to be adding its own delays if they've already been taken
> care of by the MAC.)

Just adding to this, the vast majority of systems default to the PHY
adding the delays. There are only a small number of systems with the
MAC adding the delays, even if many MACs have hardware to allow the
MAC to add the delays. Keeping things uniform just avoids problems, so
i always suggest the PHY should add the delay.

    Andrew


Return-Path: <netdev+bounces-244105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF5CAFC41
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4ABF30115A0
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A62C11D3;
	Tue,  9 Dec 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D9rFHetJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E198225409;
	Tue,  9 Dec 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279710; cv=none; b=mymlhXADjgEDI8WdRZB6GVJfkNcSVJIWvBuh14yPYAkhFXZryLRGRs7aJkDM9T9t4VyG6aXnbt921tlP6Jwqduvwcws1cfVA4IV8cjaEGWoUXOKa8drPedGLjdhahL3dJEdK+9PMiQlERQM8p5ueU3YfvZTYG0Rd5QyYHhdNDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279710; c=relaxed/simple;
	bh=JaMUsqag69VV3cGgLujH7M1g0NcexZYlInCVbk1MVRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8CNyH0EK0mMzNdc7zvJ11ka3bdvi9gLG7iN0Bmunlh7HdkcXnaQQH1Xq+C+sk8gH+evkgWwRPzWVQ19FQcin+iH0kngjugOUlIhnjJc4hbi7/Sw5+Opfss0u1XKeew/nT6huyfSPEw1GHy+zlxMWDD1QeBe/az27KcpC8dkGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D9rFHetJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DwKdmCUbXETjxy9fokPP+UnDSthHBd6FAyICBa61gQE=; b=D9rFHetJk7ay/DXTWcogtOMRUt
	jy1aVrj+NO6xKIk/M8evsvfydfIZJbYw5Ui+Ujn56/7VBa305YJ9I7tF7Rtd+9Yr1dniHavtI1T+J
	sWcFLnp2VymQ0Ze+CS0nFMDv67CRoP0GIL2q0izyU6yk6GwFYSXMqyF4PZKzrdEhZKKIL+fM1Tcmf
	uajhTlqMaBxi6tMsohBHsXEkWI+D7+HWVpXqc9TaX4mZpY71tyG6ualnvhbg9oEo2Vfl8NS4fcZdk
	4zdhlgTxaqpZXtjYRbmfefhLWrvcEjUh+WsNaxL2SLa5xXbs3D7yZYrmRUqclUH7fNT8haY2vupJ6
	GFS6nqQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSvsw-000000000Nz-0ADF;
	Tue, 09 Dec 2025 11:28:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSvsr-000000005xz-34kQ;
	Tue, 09 Dec 2025 11:27:57 +0000
Date: Tue, 9 Dec 2025 11:27:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Potin Lai <potin.lai@quantatw.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <aTgHva-UVEPl9EAR@shell.armlinux.org.uk>
References: <20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 09, 2025 at 07:15:31PM +0800, Jacky Chou wrote:
> +	/* Workaround for read-after-write issue.
> +	 * The controller may return stale data if a read follows immediately
> +	 * after a write. A dummy read forces the hardware to update its
> +	 * internal state, ensuring that the next real read returns correct data.
> +	 */
> +	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);

What purpose does this cast to void achieve in an already void context?

We have plenty of functions that get called in the kernel that return a
value which the caller ignores, never assigning to a variable, none of
these warn.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


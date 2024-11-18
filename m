Return-Path: <netdev+bounces-145806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D79D0FA7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7725E1F2261A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2D198A39;
	Mon, 18 Nov 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cwk2KtJ4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2919884B;
	Mon, 18 Nov 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929261; cv=none; b=SOq66963A1rsf6ISCntofqzC0BQnYw0kSmJoIFvf7ZcAhhSeZzUYSanitnjBUTABGwOprLnGWs36ye7Khd8MAtOSMYKiE8v1ICXWXN5r0yV72t6WNQXlLQsHOoR5hZiUJ1WJXVpfCx3XSZTeagg0iBA0ZEDO7UtT2sw6D9j3TKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929261; c=relaxed/simple;
	bh=XzSXgYfcoT1U8q5HfLv6ZN8Sc+0cViVPj/g3CvWfLnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEhTi9KjJ+IgPT+2Um1aspIq98ZmuE4sTsKUNJIyH8dsVFy62io3sy5ywslS5fGmLlym0aZG/nqLmUb6nsE7zSnUkZpRtHvGJyche+orD9F6D8EaoB1gBOPQdeLNsW95T2H6AqzumNZZBL4Vi6J7OanyttofxbMd6k+f2qY9AJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cwk2KtJ4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aWVvJstqu9oec/DoTVTnJT7l6FlIcFpKbuGY46oxk6U=; b=cwk2KtJ4V+P6+P9vEVpTY7PwsN
	1XNQDV9EPdUIi0MXxbA152apmmiU1F/1puH6c8Ut39T+KkGzMaoVdjScT9xBGduCB9bjQLXjoFx6Z
	0qe2z1SuCHJL1fAXCg+IvRaajK9aZNdbmVWWPqYaUGHrLEdepPSZ4Sn/3+CtJaF8PMU0L39PAdozl
	88DnDLXFJe52T/zbpsQD/Q6nkNv24ism4JHUOog/KGF/MnXuXSeshbiExUhPf9OdZAd4NJ9tj3DOS
	xDiELwQK3h0shwfx5CXEEAbiUdiZ3z01RuURY9cRxNI8uRLcnkI3LjcCkM2r9JddEDHuCOPdnfDEP
	HDNrau2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tCzum-0001dc-2F;
	Mon, 18 Nov 2024 11:27:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tCzuj-00053M-2b;
	Mon, 18 Nov 2024 11:27:29 +0000
Date: Mon, 18 Nov 2024 11:27:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdio-ipq4019: fix wrong NULL check
Message-ID: <ZzskoS2jwC6eLlmD@shell.armlinux.org.uk>
References: <20241117212827.13763-1-rosenp@gmail.com>
 <5562cf54-d1bd-4235-b232-33f5cca40b85@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5562cf54-d1bd-4235-b232-33f5cca40b85@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 18, 2024 at 06:26:27PM +0800, Jie Luo wrote:
> On 11/18/2024 5:28 AM, Rosen Penev wrote:
> > devm_ioremap_resource returns a PTR_ERR when it fails, not NULL. OTOH
> > this is conditionally set to either a PTR_ERR or a valid pointer. Use
> > !IS_ERR_OR_NULL to check if we can use this.
> > 
> > Fixes: 23a890d493 ("net: mdio: Add the reset function for IPQ MDIO driver")
> > 
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/mdio/mdio-ipq4019.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> > index dd3ed2d6430b..859302b0d38c 100644
> > --- a/drivers/net/mdio/mdio-ipq4019.c
> > +++ b/drivers/net/mdio/mdio-ipq4019.c
> > @@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
> >   	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
> >   	 * is specified in the device tree.
> >   	 */
> > -	if (priv->eth_ldo_rdy) {
> > +	if (!IS_ERR_OR_NULL(priv->eth_ldo_rdy)) {
> >   		val = readl(priv->eth_ldo_rdy);
> >   		val |= BIT(0);
> >   		writel(val, priv->eth_ldo_rdy);
> 
> Reviewed-by: Luo Jie <quic_luoj@quicinc.com>

Looking at the setup of this:

        /* The platform resource is provided on the chipset IPQ5018 */
        /* This resource is optional */
        res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
        if (res)
                priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);

While this is optional, surely the optional part is whether resource 1
is provided or not. If the resource is provided, but we fail to ioremap
it, isn't that an error which should be propagated? In that situation,
isn't the firmware saying "we have a second resource" but failing to
map it should be an error?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


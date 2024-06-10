Return-Path: <netdev+bounces-102320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1149025DB
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7822A1F21381
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55212FF86;
	Mon, 10 Jun 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HFyVU2q2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66074A953
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034155; cv=none; b=gybYD3YOGRwafLAvmHlHLEk9b7t19B2WU+xnOsMmfMLUC0huAOsB2yEu7GDjHLfFAqGWSrF02yu3k6aZkw14HANTqbBtVq2hGPRosCBGJVnDoimprBFONwZqmuhI6gX6QiovWyXdLTzS8X1n5EXwVmdPFivutZLndVUJV8CNnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034155; c=relaxed/simple;
	bh=6fhVi4qdL3BeexngS8ukPClZMBYvQ3p+xFtXpaEz3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNWzdBojXqy/S79N/3Vn2rxYxs7KKggvsj8wgt7Zv627ntu7msR8teCmCoHwp5zb7C+9+hbkaLF3H0enCCQ8df32+ZB/vL10wNkJNb+sc439gICPMF66Micg+zgP6Ptb66jY2bFtXSSKWJO/HjswUZS+cD6OD0EFgvISCaqmXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HFyVU2q2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mn1SKS1TN6/sJ0J/edAfefwFp1FEYmXrKrD0j2vFb60=; b=HFyVU2q26rSHoKTEhaant2zW45
	O09JBV7PIlIRDnrCrmcA0g5lAnLeBPyqGKFlHBM0rdVag/FWRlktFxDL8LCnZtditn8JoYizsyQMP
	Mqr1gftPbILtvw0EYAM9wERu/HfJmDxytqCPKkrxqi1ji2OCv5yD0E15sfgnHMdHoPJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGhAE-00HJVG-52; Mon, 10 Jun 2024 17:42:30 +0200
Date: Mon, 10 Jun 2024 17:42:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 6/6] net: tn40xx: add phylink support
Message-ID: <f8befc17-bc29-41f0-95f7-7af3f854d77e@lunn.ch>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-7-fujita.tomonori@gmail.com>
 <ZmWFNATfPWEPSLyf@shell.armlinux.org.uk>
 <20240610.151023.1062977558544031951.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610.151023.1062977558544031951.fujita.tomonori@gmail.com>

On Mon, Jun 10, 2024 at 03:10:23PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Sun, 9 Jun 2024 11:34:28 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> >> +int tn40_phy_register(struct tn40_priv *priv)
> >> +{
> >> +	struct phylink_config *config;
> >> +	struct phy_device *phydev;
> >> +	struct phylink *phylink;
> >> +
> >> +	phydev = phy_find_first(priv->mdio);
> >> +	if (!phydev) {
> >> +		dev_err(&priv->pdev->dev, "PHY isn't found\n");
> >> +		return -1;
> > 
> > And my email client, setup with rules to catch common programming
> > mistakes, highlights the above line. I have no idea why people do
> > this... why people think "lets return -1 on error". It seems to be
> > a very common pattern... but it's utterly wrong. -1 is -EPERM, aka
> > "Operation not permitted". This is not what you mean here. Please
> > return a more suitable negative errno symbol... and please refrain
> > from using "return -1" in kernel code.
> 
> Indeed, my bad. How about -ENODEV? Or -ENOXIO?

ENODEV.

	Andrew


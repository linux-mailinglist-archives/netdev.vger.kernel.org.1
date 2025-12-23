Return-Path: <netdev+bounces-245821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD3CD89A9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D287D301FC35
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B4329392;
	Tue, 23 Dec 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sQVgNRfI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A5328B73;
	Tue, 23 Dec 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482574; cv=none; b=X4Rg81zATxE5t4Bba1WGY1dH8TmRx9YOYg0KGvLdaeLyW8lg2j2x5jhtttIr+FF7aJSjvR8UbPC1QpZOQFIrWMkfpAgFFknYq7WZ9EBO/dq+pJmWKDs1v/i8rQ2Pctn/3AUtCTbNUPScnqm8WBzrfnU7h/moNSbbL9YOJeekuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482574; c=relaxed/simple;
	bh=UlFibiI5NCeGp5dHX154eZaLqB9fGCF05/Bal4lw0oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4MZ/PrJqxjSsugQJQQpFCTO4ayM30CyEaOsRqEYSUrZ+cI9Nkjyw8FCD3NorYbsvaUOv9HhK0Hnb/co0IxLTIgzsuGEDMuXPyHFhkChCRYcG86dHMf/KuBvDFfwBw3VF9dfhB42FyhwIhwgStYqrEq1bO6BwoN4s/PpIuDB5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sQVgNRfI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EOdUMkDXWzvzhdMNaAxNlHu+DMh94g8QwbGb/FxJKCQ=; b=sQVgNRfIJr/spOz5uoX+BfsPDI
	ktHGhkOp5GlzOpIrkvamV0M1AwYwdmPfweKrCMags0YIH45Z/o7ML6SEroH5DbAD9mujB8AaEJdsg
	t61CP/ZBXAXQnzg9gIku722oqIVMdPRo3OGg3oE1EuFjTJEXvAA65hcDZAkXkEjuwM2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXyoM-000HW1-2m; Tue, 23 Dec 2025 10:36:10 +0100
Date: Tue, 23 Dec 2025 10:36:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Osose Itua <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com
Subject: Re: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP
 Termination Register
Message-ID: <a587cedd-9450-4c58-bc39-ecbdd525ef65@lunn.ch>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
 <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>

> +static int adin_config_zptm100(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	int reg;
> +	int rc;
> +
> +	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
> +		return 0;
> +
> +	/* set to 0 to configure for lowest common-mode impedance */
> +	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX, 0x0);
> +	if (rc < 0)
> +		return rc;
> +
> +	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (!(reg & ADIN1300_B_100_ZPTM_EN_DIMRX)) {
> +		phydev_err(phydev, "Failed to set lowest common-mode impedance.\n");
> +		return -EINVAL;
> +	}

Under what condition do you think this could happen? Do you think
there are variants of the hardware which do not have this register?

	Andrew


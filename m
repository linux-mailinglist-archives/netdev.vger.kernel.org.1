Return-Path: <netdev+bounces-87992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E598A5224
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CB41F219E6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2173175;
	Mon, 15 Apr 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z9PnMCIl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E71B3A;
	Mon, 15 Apr 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188942; cv=none; b=A+43J3jPwt7m8NHvZfoKTffm22cKTTFC3GGWSeHzAGp1CRyFevKS9X252UTUKOlHX3wwAbPXKPfWTxDxh7qZiXAGGbjKUR02l8Xq7AAMg9cqiDgvb7ksY/D/H2vm1z/yw28Cd729KJskGyhrtSu93YFwMCqYXrDf7K5n/4TKY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188942; c=relaxed/simple;
	bh=byyuGKFmlI3hbdOTLduNttEhM/F2miZWWsgZSr4EnV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxaBLPcexTdUTLfl5BCdad1LXu2s9rdNe9h9Qn0FUe6xUeisNkDoCbUdSEZ0VldnF/iGnO1nKkVMbjbEhji5Ws7F6u/eWg0cD34Du58kmkL7Bzameuwe3Oiv96yFe9eihV/F8QJEnXA/u+UfWdjk/Ph3KI3pSIRbCLF2lsL5Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z9PnMCIl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TPq2gpyOaK+VTqdSdtQAk4akDRexl59i2+mZeKq+Lcc=; b=Z9PnMCIl/Q9N6BHPxVuZ8nfZ3i
	usaBt+YErrZYZuhAXWr7VAYCBg5Gwwc8Tw9QXqa1Y/XRXAkWgVZRFqPpDMeNRkhjiYKqdxgUfaR4O
	jnpkdCHjiuPhNy8ka9+7kOEGasYNo7hVEq3ztMLwUIMAizEQ935cXK3sxTu5PL4cVghU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwMhe-00D2q0-HP; Mon, 15 Apr 2024 15:48:58 +0200
Date: Mon, 15 Apr 2024 15:48:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <94f86118-4e2e-460b-9f52-911835c22065@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-5-fujita.tomonori@gmail.com>

> +        let phy_id = dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
> +        if (phy_id >> 8) & 0xff != 0xb3 {
> +            return Ok(());
> +        }
> +
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0000)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC302, 0x4)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC319, 0x0038)?;
> +
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC31A, 0x0098)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0026, 0x0E00)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0027, 0x0893)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0028, 0xA528)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0029, 0x03)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC30A, 0x06E1)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0002)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0xE854, 0x00C0)?;
> +
> +        let mut j = 0x8000;
> +        let mut a = MDIO_MMD_PCS;
> +        for (i, val) in fw.data().iter().enumerate() {
> +            if i == 0x4000 {

I'm assuming enumerate() does the same as Python enumerate. So `i` will
be the offset into the firmware. There is actually two different
firmware blobs in the file, and you write one into the PCS and the
second into the PHYXS?

> +                a = MDIO_MMD_PHYXS;
> +                j = 0x8000;
> +            }
> +            dev.c45_write(a, j, (*val).into())?;

Maybe my limitation with Rust. Is this writing a byte or a u16 to the
register? PHY registers are generally u16. And if it is a u16, what
about endianness?

Firmware should not be trusted. What about the case the firmware does
not have 0x4000 words in it? Is the size of the second blob known?
Also 0x4000?

It would be more normal to load firmware into the PHY during probe,
not config_init.

    Andrew


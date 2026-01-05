Return-Path: <netdev+bounces-247112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C8CF4B20
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FA49308FEFD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C2347FC3;
	Mon,  5 Jan 2026 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w0TUrT4c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7A346FD4;
	Mon,  5 Jan 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629782; cv=none; b=l5Al6SqMK2/wQXMjrTWP8z10pI5c5UQXo4LRkvMcJT5bh+BqncdgmnvG9vfh8Q38F1eke/7Ex0PZ4zc1SCQiPyOQUPNOWOCmYTz0D7cZxyZdZ0iNZ67JSjcROswdKe1M1+keDJDW4fH1dBIhGvnU88nBLRgxD8cOdjZBPlh6ywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629782; c=relaxed/simple;
	bh=9i67VTNE5FrtiAowIq8uSRUUDChaB5at4SSp/o9nPe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En+DYBR1TpM1xf1u02V3+FILqpgY5+Rphyxog7xP6dr2/dAis+SFcMkrWk/eP0KqSLiHEDTIv3DhI/t/HljsNZOMbdHtKGc8/GKHYPlr7CHegjOw2Pl/x+q0iQCZKaGlhnt+X7vXci0xtThsMxyQd4B4awFyzLFuz3p8iNAMhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w0TUrT4c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jdTxogabHUVvZFgfzUllqOqY7gjAS94xoT2KLAqZfG4=; b=w0TUrT4cle/QW2C1IgaR3L3msZ
	DbdCDJ626YYs4V+t+2hOQlg0/coZ/eMue4bHhdfp6kfU47e7eqkU2XduqdVEq4vsgnQLyL+krYP+J
	xGXzmx0pLgr3RRMNVRfH0iNDcIEEoEa8hrK+JzCvxOjrSAvhSL1y8R4mgNoOGiGnD2jiy8PF1k+Db
	TMLPW4NoXT3y6oUU/djRt5eB+OQcwOEpIhUs4YUcdEE4FVjKKmX/Fq3PkfQq0YN7+YILktz4FjAei
	6KNWYGdwX+Ux6P9YFGhvXjS9fzMRoWPeOI7C7KH/wOAYhfp/FIbKmihx/MMVMtT8BK/FxaxACBi1b
	dLTx7H3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60394)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcnFd-0000000084D-079a;
	Mon, 05 Jan 2026 16:16:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcnFZ-000000007z0-3ngJ;
	Mon, 05 Jan 2026 16:16:09 +0000
Date: Mon, 5 Jan 2026 16:16:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2] net: sfp: add SMBus I2C block support
Message-ID: <aVvjyWzKuczNf3lt@shell.armlinux.org.uk>
References: <20260105154653.575397-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105154653.575397-1-jelonek.jonas@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 03:46:53PM +0000, Jonas Jelonek wrote:
> @@ -765,26 +794,70 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>  		dev_addr++;
>  	}
>  
> +	return data - (u8 *)buf;

A separate fix is being submitted for this.

> +}
> +
> +static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +				 void *buf, size_t len)
> +{
> +	size_t block_size = sfp->i2c_block_size;
> +	union i2c_smbus_data smbus_data;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	u8 *data = buf;
> +	u8 this_len;
> +	int ret;
> +
> +	while (len) {
> +		this_len = min(len, block_size);
> +
> +		smbus_data.block[0] = this_len;
> +		memcpy(&smbus_data.block[1], data, this_len);
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_WRITE, dev_addr,
> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +		if (ret)
> +			return ret;
> +
> +		len -= this_len;
> +		data += this_len;
> +		dev_addr += this_len;
> +	}
> +
>  	return 0;

This is wrong. As already said, the I2C accessors return the number of
bytes successfully transferred. Zero means no bytes were transferred,
which is an error.

All callers to sfp_write() validate that the expected number of bytes
were written. Thus, returning zero will cause failures.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


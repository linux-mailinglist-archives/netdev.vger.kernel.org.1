Return-Path: <netdev+bounces-141564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0F9BB6A4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896C0B2094F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E18025776;
	Mon,  4 Nov 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bp7LY+tM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE28BEE;
	Mon,  4 Nov 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728195; cv=none; b=tLYurtf5Bxa2txhweOQZgpKVSeUmzqEr741USZhBvAX57gkxMULtkHnV5Qj2GN01Jf2RO1+tPY4KCPJIfZ9IZpdlVhJnGBd5vQmxPWmNGn4L+CjfhFbvdr7gwd5CtSFgyPXtr7z1gl/5I4e2A1llP6D6SZE7YkCrtzZ8NgH8zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728195; c=relaxed/simple;
	bh=0h24Z/KmOBeWc61kIufk+VlXZiXL62drrzwhEeQScZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKoNJhS+7wnir8pxf/VrjOB86OdBMf9bANIiTFzuCda0xUuphNJ8+uZMMQQysTN49jH0lORH3EGX4ZTSst5CjfhQF4GTc4FealCNkEzcL1mup48gTzfHj0Rlu8+nu/6jIsH2261386j96sxExy2gi0fqniG9AkZlbR1cMptRNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bp7LY+tM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zfHUUBEvbnEiK3TFZcwygJuDOsuq2mvLTMARsCEc7ok=; b=Bp7LY+tM/ioObqhADkWHMt2DKN
	3YL1XXE4BYMytefuFFK67hjdsrMadTofYG2qDhkItzEJUYYa+EiPFKEMIYeMDvS2n9CapOmz/nWcc
	gAfsaSpDnkJv933zIzySYDdpCjGsSDUjfX4G1SvFMJRAM6jZv3Rp4vPVMp3xsdDxEv3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7xSo-00C6mP-HG; Mon, 04 Nov 2024 14:49:50 +0100
Date: Mon, 4 Nov 2024 14:49:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alistair Francis <alistair23@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
Message-ID: <9ae6af15-790a-4d34-901d-55fca0be9fd2@lunn.ch>
References: <20241104070950.502719-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104070950.502719-1-alistair.francis@wdc.com>

On Mon, Nov 04, 2024 at 05:09:50PM +1000, Alistair Francis wrote:
> The static inline functions mdio45_ethtool_gset() and
> mdio45_ethtool_ksettings_get() call mdio45_ethtool_gset_npage() and
> mdio45_ethtool_ksettings_get_npage() which are both guarded by
> CONFIG_MDIO. So let's only expose mdio45_ethtool_gset() and
> mdio45_ethtool_ksettings_get() if CONFIG_MDIO is defined.

Why? Are you fixing a linker error? A compiler error?

In general, we don't want #ifdef if they are not necessary, because
they reduce the effectiveness of build testing.

	Andrew


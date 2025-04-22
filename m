Return-Path: <netdev+bounces-184549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49359A962D0
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FF0440D52
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E028151D;
	Tue, 22 Apr 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pY1FOnwL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1222A1ED;
	Tue, 22 Apr 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311102; cv=none; b=JI3UOSKW9c3A9tdjhOu0fHJvgteWHuQKowqCasdKm7ZNOtJ4A3ti0FA3xh2fIAuPve9QIrVo3mno5qEtK5Ju+ZO8fio2S3fG32QN4uXEuxUL56UaNjxpQLvPBAfSXO0Dm1PGIkCEO6UuhGWO7sx4EwZOBmefK7gHw3MRSeODiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311102; c=relaxed/simple;
	bh=p8VDFnBBLQB+c84WukX9np3V2pQTHpPbephzaUIJxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTQbBDfTAqfSdgzqAkaa0iCnb4MrpmqG5+RQpDFJ7lGuIp72RTXaFZt/Fm1zz04vEn/EzyJr+uvFTluiEDHQSSGAYnA+MSguPGY5bZ3xHAED3A9HWqmvkU20YJB0y2qlHO9D/133840/mk1B/JXIHWLSOKJKe9ND8TYQcNywSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pY1FOnwL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o0w6pamxCxDKHzVZmfTHs/uYuK6PeXKb0434M6fEc3M=; b=pY1FOnwL/S8J3yGEKh1QZZ5tZL
	Vp5eQoQWU2/fdqKvavzm9zcqh0HuU5etRNXQGprVs9hiAsBfNYdPqrgId2x5g/Xe0bKHniIm2xhvE
	8qg3NSfGSBE/rkWYZks9XUrVuCuPYpQP1SMdO3Ip+CZZ50Utq3eo9em0yld9lfynz3LfK+NJMuc+A
	ZqdNlAzkl5OT2o8YyCKMhreS5amF8eK3LuM7nR4+SHjRhbC9YRoQ1WMob9krsSoaaSnHEVBf1u6/r
	YxqplweIaUZVt50eYcclgDhxG7A5F7pkPpGykSHp04WnpNU8QIqCrDU0sf7ITae99C+JYPuZxBI4C
	vfDNrPJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u798f-00042g-1a;
	Tue, 22 Apr 2025 09:37:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u798X-0007KW-2n;
	Tue, 22 Apr 2025 09:37:49 +0100
Date: Tue, 22 Apr 2025 09:37:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <aAdVXQhR7-mYl783@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 04:06:31PM +0530, Siddharth Vadapalli wrote:
> On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > As discussed [1], the comments for the different rgmii(-*id) modes do not
> > accurately describe what these values mean.
> > 
> > As the Device Tree is primarily supposed to describe the hardware and not
> > its configuration, the different modes need to distinguish board designs
> 
> If the Ethernet-Controller (MAC) is integrated in an SoC (as is the case
> with CPSW Ethernet Switch), and, given that "phy-mode" is a property
> added within the device-tree node of the MAC, I fail to understand how
> the device-tree can continue "describing" hardware for different board
> designs using the same SoC (unchanged MAC HW).
> 
> How do we handle situations where a given MAC supports various
> "phy-modes" in HW? Shouldn't "phy-modes" then be a "list" to technically
> descibe the HW? Even if we set aside the "rgmii" variants that this
> series is attempting to address, the CPSW MAC supports "sgmii", "qsgmii"
> and "usxgmii/xfi" as well.

phy-mode is quite simply the operating mode for the link between the PHY
and the MAC, and depends how the PHY is wired to the MAC.

The list of modes that a MAC supports is dependent on its hardware
design and is generally known by the MAC driver without need to specify
it firmware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


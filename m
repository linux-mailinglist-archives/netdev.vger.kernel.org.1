Return-Path: <netdev+bounces-247424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4CCF9DF2
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 097BC300F695
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B8364E9F;
	Tue,  6 Jan 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nAl+7afP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1044364E8A;
	Tue,  6 Jan 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722028; cv=none; b=aq/GxQc1A/PuE9Ilrsb6sz65OEWFviR3XHNe+bjStWq9uvVBB10vYL2Czm75lRu3fJdZWq2pkBpP9nXEO+O2n5Xo4rcPMKJQ1GH2oUBdf4JdGYLMrn+h0tlgDp72ilfB8MyQP3XXU24IRcwyKwFWiVPA0iErDVvmF43DcFReszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722028; c=relaxed/simple;
	bh=LKWPitbcGrd3Rpd+vyUqksGir5Ob6WW1z1gEt7mAFzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRZKTaBVFJiM6XOZYX6SF9fZSX4+r/h/LG1z8L9mx9LxzlAYvGDLvmWexnpzm+00kuXVdByJfyKQv/ZN+lBJR8f79BWlOBir7x/ZfpHTpaI2RXx1ewNFtl2QP7hAZ5+5iQPZbBQEjXztMAbFvrUugYx5oX19i6AqcSSWBrq9Bns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nAl+7afP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NeRc65GgtPKha3VBPc75CE2yju7Fvs2u23mVuFJS94M=; b=nAl+7afPDn0GKI0lv6drLUgXh5
	Sv+T406urwiNXaZ5hXTQCgxv6OmLgra0PRGIpHxfhfoSnpX/f4WCivJiWex/WzHTw0jfrzZouHZpd
	Z0PWml4rxKHQQu7TOoUZiHUQ9g5WKg6sYxuf++B/H9YVH7a2k42sh7li+vFWctRUb2DpxrhnGQVMl
	2e6a6/yRQ95N5sPnwEBFsV80q1o1eMgf3wkyY4qdAMUR1Ts9T2K82mpkCMWsmzPt4A5yFst5CJKKu
	Y3rWDk8wPcVBrUAJz9iGSgDrP3ddxwXwieutAolLMp0RN4Mk/sze2Jni8fQvf1mEM8DQecClK95Hk
	gZnwDj+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vdBFN-000000000sa-1PL4;
	Tue, 06 Jan 2026 17:53:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vdBFK-000000000c6-0NYK;
	Tue, 06 Jan 2026 17:53:30 +0000
Date: Tue, 6 Jan 2026 17:53:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v4 3/4] net: mdio: add unlocked mdiodev C45
 bus accessors
Message-ID: <aV1MGQirTHyFdv7Q@shell.armlinux.org.uk>
References: <cover.1767718090.git.daniel@makrotopia.org>
 <36fbca0aaa0ca86450c565190931d987931ab958.1767718090.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fbca0aaa0ca86450c565190931d987931ab958.1767718090.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 06, 2026 at 05:14:57PM +0000, Daniel Golle wrote:
> +static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
> +				      u16 regnum, u16 val)
> +{
> +	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
> +				 val);

Something doesn't look right here - missing a couple of spaces to
correctly align? I suspect checkpatch would spot it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


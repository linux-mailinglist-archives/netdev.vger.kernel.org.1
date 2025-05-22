Return-Path: <netdev+bounces-192673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F3AC0CAF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B417B2757
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC7428BA90;
	Thu, 22 May 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JVRRiR70"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3723C384;
	Thu, 22 May 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920393; cv=none; b=Tzpjlm8XOYE6RN0i4t41QJOFp9JR1bymx7p07SX8UXnj4rysUn0slOoiBQNv6bErHBzDjNapmlZm4Fo1/5mAxVFl0O4sE80W51SwMdp5Q2xO6gH41RAMMvrUAEtdvwXqNWMxnsDvCrHiuS0MdqTsU9foZdSc2FV0yjCPR0GaRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920393; c=relaxed/simple;
	bh=iU1Rll2o/pj1xps6yjyhdNOZcXQk0/Bd1Ky/o2eP3+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnZnKptOMnS040JCQq5m2XUF2JY7aVvDlE6qgvNY94+zx5YkVQZryCB3AL8uYwlTujo666UIBp4WshQAB7r6tKPQEOoylmhkDyGT7X8mZAXKuCZii9Q5XDHGK71dZEQnMSVU7dvweCDWnK+FaDZvolfb6qJ4rPWJ2d9MU4qPey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JVRRiR70; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fVUl1SvG1l+ZNN0za4npeE4yZeXHiPDMDPr4FX1cWeg=; b=JVRRiR70iqfqZszxAr0e53RwH3
	+1SouU7HHq4X5J9IvE6eomKbrnVU2DKKx7mZA9l1yYvl5R8wt/Y8MVc3yX8p8dupshoZ0uMso9tdN
	iMEJzLWUqhELkcLPlvxAcaBnqrjZVGcjsUADL015Z8s1A9L3reEOsXBo/LbL17wkVZADzhdVquXB0
	tGpAyrzSQis9TzlPZSHi0z1foegViJSzg+DNWrh389uQCI6ggr4RUvhTfTydMeUJ2bDP0xHTMHZvL
	h7H0fwjXrdZzsnQVLRu+J3WHaq2QjXLQSFww7+i1inAoZxXPAaHy/VjO1F/ssfvQi9q7gH26UBlEm
	tD2klKYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57092)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uI5wD-00020O-1j;
	Thu, 22 May 2025 14:26:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uI5wB-0004uN-0s;
	Thu, 22 May 2025 14:26:19 +0100
Date: Thu, 22 May 2025 14:26:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <aC8l-96fjjPBvYS1@shell.armlinux.org.uk>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522131918.31454-1-yajun.deng@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 22, 2025 at 09:19:18PM +0800, Yajun Deng wrote:
> The phy_id_show() function emit the phy_id for the phy device. If the phy
> device is a c45 device, the phy_id is empty. In other words, phy_id_show()
> only works with the c22 device.

This is correct.

> Synchronize c45_ids to phy_id, phy_id_show() will work with both the c22
> and c45 devices.

This is incorrect, as there may (and are in some cases) be multiple
different IDs in a C45 PHY.

I think we've had patches like this before and turned them down.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


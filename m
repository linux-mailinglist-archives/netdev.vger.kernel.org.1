Return-Path: <netdev+bounces-173592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C36A59B1C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165B53A5457
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA24230264;
	Mon, 10 Mar 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WlAzFezD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF5185B62;
	Mon, 10 Mar 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624506; cv=none; b=Bo00RsIL/P2ibm6JYUgEKXexw7odfwQqrZRZQqDlWhpiLtIchLlNXs1wUwRNpf8RU943D9bIXtQhOQKAV+zrp3Mg/JjATuQXCCIOTG65iWG9LetfvcqzeDeHprkNPwdRoepEpGnjta0NQe1Ltn9KgzQ43Ljs3pJc1BBuHWYZrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624506; c=relaxed/simple;
	bh=ZKvVsJ9Jxs6BNf0ZGQzgXFsZmlABP9EO6Vd96lMv61s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwaRAtSKE0eRi8SG+cuXJfSckt01c1dRc6qkP4s6H4gZLFFqkKEtGkzWrHdJz1r7K8IuMG9Aw+ZDPDk8PkwCoZHjbY8VXMneyR9gWiGIyk4gzeyiyJQ/+AP3e4RxSMuZMz9NwiJk/voiy+26AaAY/+goMh8EWhg9I/GTUfQ441k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WlAzFezD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JIY+PmPHLz9u1Q43AC3Utd4UHBNiWYM3sRig9h9ZDIc=; b=WlAzFezD92g8yZE05XlG+QVd9I
	nDY2cZPRV75FlaCIXRYVuoYV2W8dz61IUOegXJxMGRZgge0sZg9Z2byWtKYHmCMmk+vB7e97XqYAI
	1FfX8lLDP4Y+COvOjaD+78aYI/QOLKsaa4VbYQBa0PRwgM9pMOOcU2esrFeOOE2SkNmyo+gqYjE2M
	vz7pOAz3I7822bghlJOtdV7zqxszfaQZT6FWWyCpTAM9rbtpEh0O/RSl7iPr/+Vv/Q+zwChxM+g5j
	VZT9JY9QNsCUD0xQZajYH+PrVkFiUVaLWWXcZj3pWAODzvPGGLm5ntVBux/wRjuXxlUgvwVG9c9bL
	ii6q4DHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38804)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trg5R-0002wT-1t;
	Mon, 10 Mar 2025 16:34:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trg5J-0002ch-0i;
	Mon, 10 Mar 2025 16:34:33 +0000
Date: Mon, 10 Mar 2025 16:34:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Daniel Golle <daniel@makrotopia.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"sander@svanheule.net" <sander@svanheule.net>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <Z88Uma90VzLul2we@shell.armlinux.org.uk>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
 <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 02:07:26AM +0000, Chris Packham wrote:
> So far upstream Linux doesn't have generic paged PHY register functions. 
> It sounds like that'd be a prerequisite for this.

If it doesn't, then what are:

phy_save_paged()
phy_select_page()
phy_restore_page()
phy_read_paged()
phy_write_paged()
phy_modify_paged()

etc?

These are at the _phy_ level because it requires the co-operation of
the PHY driver to select the page in the PHY (each PHY vendor does
paging differently.) They aren't a MDIO bus level thing because paging
doesn't exist at that level.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


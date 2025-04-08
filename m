Return-Path: <netdev+bounces-180154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB38A7FC2C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874C14416F2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50F268FD0;
	Tue,  8 Apr 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mUZpaISE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20302267F70;
	Tue,  8 Apr 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108244; cv=none; b=eflYHZ44NbDdKRSqsP5r3SdhGSKTOGYjxAP18X6VIfXDqF9zz70cf+WxkRTns8BC6R7QD/ytSE0BGtUZyRonHojDOvIJ0pGesGirWlPFVliPSnqhJ43bZ2LtjimhM9drkyNdUy/0KXCa9/hgHnOdjEsV+0on05B/x1iaAnSv600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108244; c=relaxed/simple;
	bh=P6q7ocM2fZ/JCZfHXicwSxGd25qScXXfymOe1Sn5MXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG3Zs3edl8Z3x1ptR6XvjA7YpNC8cGvVPBD54CSn5k5UUm2E89el1vhb6bsAxkmj8jew/Z+c4NTttWxsEw6wDKsdEz7NBIeSUytJCW6xYdkAtjZAeC1b0qXMueW+lMfKlJFcwb5JZyT0n9XNguNOrzVeLZcFcqmftx3KHKlpp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mUZpaISE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aPK8UeRUdmmCTq0T/PPSZ9uFgrIh4Dpxqt0k3+h/cv8=; b=mUZpaISEpFvcYPJ+/0U5A7pk/T
	u14ZK/VEpYGBy5UZ+sRus7i+I/C8uQ+nIVlS5qoRNmcKvta2OYRd44tAg42Ftb9c6MH0SKg1Ed3wK
	fFpvoKGwqn2Od2duEMsfwKEEc7sHgNZPORuBbVJm85McUZ6DeuoPV4B6dVx51UwnheAQRnCbqLh0y
	ZGQ1yNgZM7UdQH7MY6Y9Q8DlUZkde7j+1Ni6RYkJgLunNjrJ9/v4uvGAuyMWErwBpLEq5NjuAu7PX
	4TIYM+c1sVbbd0cYbx4k9KdkJyZR2pGgu6Rkd+z1twmYCbfOtt7bv1Z1QoBBoKk2cA6w+c1E55gbr
	R4KvywQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53706)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u26Du-0007CZ-0P;
	Tue, 08 Apr 2025 11:30:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u26Dm-0001Lq-1p;
	Tue, 08 Apr 2025 11:30:22 +0100
Date: Tue, 8 Apr 2025 11:30:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
	horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
	geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
> YT6801 integrates a YT8531S phy.

What is different between this and the Designware GMAC4 core supported
by drivers/net/ethernet/stmicro/stmmac/ ?

Looking at the register layout, it looks very similar. The layout of the
MAC control register looks similar. The RX queue and PMT registers are
at the same relative offset. The MDIO registers as well.

Can you re-use the stmmac driver?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


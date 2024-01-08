Return-Path: <netdev+bounces-62435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC78273AF
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E94B20DD3
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D951032;
	Mon,  8 Jan 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FVg52wKX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39B5101B
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CJXhJoPPEtYsWdDZuoug7EJKQH8XVN7cv912tWB6rmA=; b=FVg52wKXK0DXNpynQx3W1PonEF
	RCQx/FE9y1kqwBuWTIecGsWVdNY4pveEiCxrTJg8VRsQIVDyoGF0TJGeXhPgo9l8DHtp/7rGl9QEf
	7ar5zddwDU5W6cPIeAARDElv+fNPkSTNAicxmKKEZcHumuMKtngHx8ljgdJwTHgMZmRdf6tLp0Pwd
	az6E0+AJaU5DflTGsbXRss5oQuk39pE9dh504iwbqQHme/O84R+0rfp0yJo/KG3Wtb/wzjuCxU4R5
	kbCK5o7GbgmjuE92C9alwj9Sz1PkF1vr0Kvzjyc5QBnLL5KkMMDNnYKyQZtISYlCevUe/h2ToID+S
	Nq5CPPFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40838)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMrhb-00039T-2s;
	Mon, 08 Jan 2024 15:38:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMrhd-0003LP-Kl; Mon, 08 Jan 2024 15:38:13 +0000
Date: Mon, 8 Jan 2024 15:38:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
Message-ID: <ZZwW5e8pZp5XVzZi@shell.armlinux.org.uk>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
 <a044621e-07f3-4387-9573-015f255db895@gmail.com>
 <f704864d-56bb-4ff4-933d-8771d0bb6c19@lunn.ch>
 <8bfd2b95-2c73-4372-bf63-0c6ab7cd03c8@gmail.com>
 <53909c11-825a-489f-822a-dd4829dc8041@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53909c11-825a-489f-822a-dd4829dc8041@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 06, 2024 at 12:15:18AM +0100, Andrew Lunn wrote:
> I would not do too much refactoring. I have a big patchset which
> refactors most of the phylib driven drivers code for EEE, removing a
> lot of it and pushing it into phylib. Its been sat in my repo a while
> and i need to find the time/energy to post it and get it merged.

Strangely, I have similar for phylink... I was thinking about sending it
out during the last cycle, but I guess next cycle will do.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


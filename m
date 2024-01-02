Return-Path: <netdev+bounces-60833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13C821A81
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08932282B94
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBFD313;
	Tue,  2 Jan 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Py2XMqE5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A7DDA7;
	Tue,  2 Jan 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P7Jb3mDo49MLacBnG7AhGIaZNuCuPSYfPQElZXHcOe0=; b=Py2XMqE5fjChLA604/A9Yo5eia
	YtalWfuwqCLpnFPfAzizPcxQ0u644zIM9Amhtnf4f9E3xu/MAtqMKlR5altz5yJXHjvYW1XQ4SWHz
	T+TeuKNzCNdytlJSP6fUVyMgG4xEilF8CruX68mHGG3zXKRanBXI94KIB0xZL/Gl5AhR8okC0oU/1
	LHgxJDcQGYD8n/6p9HXtcVt2J/0uLQaEsKYEFwqzMritPeWnY0gXFhu91P3YhrDsfoDhZ7CZv0vgU
	/Fhu9w8WmyQIu+K/BXX9gM0LoXNJnz1CVTXP4KwZPF/p9+QWTc4bhaNpAbLAweNzXcUDaaQ9WsDu0
	9LOUnvqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44170)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcOs-0006Pl-1d;
	Tue, 02 Jan 2024 10:53:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcOu-0005Ci-4w; Tue, 02 Jan 2024 10:53:36 +0000
Date: Tue, 2 Jan 2024 10:53:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: at803x: better align function
 varibles to open parenthesis
Message-ID: <ZZPrMKZU8IlluZIU@shell.armlinux.org.uk>
References: <20231219202124.30013-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219202124.30013-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 19, 2023 at 09:21:24PM +0100, Christian Marangi wrote:
> Better align function variables to open parenthesis as suggested by
> checkpatch script for qca808x function to make code cleaner.
> 
> For cable_test_get_status function some additional rework was needed to
> handle too long functions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Add an additional fixup for qca808x_is_prefer_master

Just found v2... see my comments on v1.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


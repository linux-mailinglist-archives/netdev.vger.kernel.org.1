Return-Path: <netdev+bounces-61251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586C822F90
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2780A1F247E2
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD71A5AD;
	Wed,  3 Jan 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rqsp5R3v"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338841945B
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LKat1FniWi8aQCsmkF3p1i5EuDgMtNdpdZH1RmFgAS8=; b=Rqsp5R3vQQLBeuAzI8levtHihJ
	PKzSIhWYiAbdCICZI4MuZeGstqLQkOi5HuLjT/KCQhceMQhDws5dfAJ0j2DRAeFLDEfCdS/YqDix7
	Hjob99gfhjuPJrkcYYbtNIFt4Jw85Coh0HZhjhENryzX3gCDNKajiYsIZpvld3uBqJOpzt9w3p5BR
	fO0+8kqhqBY7bgAKGvyEjbMIwy+9258yQCxsH8F9qwNpTLEzk+9SMDSXtR0kwYUtVmSVo2tRY7eGu
	Or5Gi6iDv+BZ+Vs3UsPrlkyGo8eaN1ZC7qp6PhRVQRoni60Ck/VfiuwyDkdK2OiHs34cGHGJ0agoH
	Qh1paeDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60432)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL2GC-0007aU-2O;
	Wed, 03 Jan 2024 14:30:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL2GC-0006RO-J6; Wed, 03 Jan 2024 14:30:20 +0000
Date: Wed, 3 Jan 2024 14:30:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 1/8] net: libwx: add phylink to libwx
Message-ID: <ZZVvfHlZJVulSGJe@shell.armlinux.org.uk>
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
 <20240103020854.1656604-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103020854.1656604-2-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:08:47AM +0800, Jiawen Wu wrote:
> For the following implementation, add struct phylink and phylink_config
> to wx structure. Add the helper function for converting phylink to wx,
> implement ethtool ksetting and nway reset in libwx.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


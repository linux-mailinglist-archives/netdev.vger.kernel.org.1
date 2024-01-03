Return-Path: <netdev+bounces-61254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86326822F9B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A311F2479C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0341A599;
	Wed,  3 Jan 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lk8pCty6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60761A59C
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zrODgtrklPzgEmRaFDuB1+wU68MPxeH/fsr7chfdZeY=; b=Lk8pCty63On8V171/d6RHzqINl
	2bp3+tqKIhQQVZ02Drz8vBNB8Fayu44+wKAKp/LfYhxNDwuCmwBmdJvCrop0imZ04T4YpmWX59rED
	8wJQ+Z/naMLQLdLdJsqJ9v9nt/pwZnDsA7gowSCi3Nep7BEiDuMfo6S9E/T0hQxH9ORWKJfRzqxkg
	Ny4s5oLzzUGVDWtQgVVM9K3o8kj7WBcD2zuzG8Z0v//+Bc3reYeYCVgNqQ/uK8WodiCeJWohXhZ4F
	ctEVljQrC6I9qZ54eUeAuR+Ks2fIRs++1nqrALeH6rqguntv8BTL9XbfkI4uBWo5byhMA8YuM7Iks
	C4WP0Jqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL2Kq-0007bA-2D;
	Wed, 03 Jan 2024 14:35:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL2Kt-0006Rd-Cs; Wed, 03 Jan 2024 14:35:11 +0000
Date: Wed, 3 Jan 2024 14:35:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 3/8] net: ngbe: convert phylib to phylink
Message-ID: <ZZVwn+KYM/okPHDo@shell.armlinux.org.uk>
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
 <20240103020854.1656604-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103020854.1656604-4-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:08:49AM +0800, Jiawen Wu wrote:
> Implement phylink in ngbe driver, to handle phy uniformly for Wangxun
> ethernet devices.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


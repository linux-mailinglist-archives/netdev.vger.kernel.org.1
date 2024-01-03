Return-Path: <netdev+bounces-61262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14293822FD0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB82E1C20B6D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF171A5BA;
	Wed,  3 Jan 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0R/U8pTa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600461A5B3
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MAgvyYYX5vBcVgVmMOkd4Gu+T5MezQxf6/j8rEnTlBs=; b=0R/U8pTa9MSx6u2nqqLKhCIubB
	Aug42o6eoqRLruWjoTLKlkgQXnz/ZO7G6oNxE1bEZOcDxPP+E3A/pf860JKTH0cbJxfqdfv9PXmg1
	94GUcgHH1u85WbXZrUOlLbZCIOSfXg36fCVPGP9ukd7RPePTWB4mJjLAjGBt6o27gYk5LiSjj/9/E
	loBa59hw3sGKSzIxvYipzJya3sqNT+WxrEh0gVd/wuzPsRcplcyBesUf82Sv4rB4qFfQCTtum/wQO
	+KFtT3xUbTEIy8b76+a02vvwvucjpnLsp/KwVMRBDtLvqs122FUYyN9L+fx91mxK1s0nuoAak7YqD
	Pb2v+EMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL2Xh-0007c2-00;
	Wed, 03 Jan 2024 14:48:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL2Xi-0006Sh-Ix; Wed, 03 Jan 2024 14:48:26 +0000
Date: Wed, 3 Jan 2024 14:48:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 4/8] net: wangxun: add flow control support
Message-ID: <ZZVzumTDGLKqTd3n@shell.armlinux.org.uk>
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
 <20240103020854.1656604-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103020854.1656604-5-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:08:50AM +0800, Jiawen Wu wrote:
> Add support to set pause params with ethtool -A and get pause
> params with ethtool -a, for ethernet driver txgbe and ngbe.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

For the phylink bits:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


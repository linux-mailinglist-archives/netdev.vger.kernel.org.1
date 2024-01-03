Return-Path: <netdev+bounces-61252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D5822F94
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC041F247FC
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61E18645;
	Wed,  3 Jan 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yHWzZz5e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC41A70B
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Dv05mKen3im7/ArpzUpxmS/x9hWp0ffVpvdN4s80xU=; b=yHWzZz5e/yh3/fmJYSEOp8v8kk
	+oHfAeCrsq/M1WyJD4RJCRwkKyGTrnbLVhObLO0qp+A0TyxnqiZ79Mn3oGHQhltcmID0bajjyCPP+
	S7Ayy+8oWbmbT0CNt9+/a2B/OmdXBHMuyc0wpICXCXveDB5mt4Y3OUo7lfv0BsTI5wkiptJR9Fy6C
	NumjH7QAABTgv7vXM4sbqJ6QOV+s3Aq08O0E3yIQjdv809d7x+J80Lb8/a8lUdHv5nDEXZnBe2f/3
	+I0nI+4O9lXlm48FSMtXLiKm376aiYO02xMsXKkDtaiNz1mBhO21Rr9AUQPyU/zH6xvgj9CZfprq2
	0F2m3T1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37606)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL2I7-0007aj-0r;
	Wed, 03 Jan 2024 14:32:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL2I9-0006RW-Uy; Wed, 03 Jan 2024 14:32:21 +0000
Date: Wed, 3 Jan 2024 14:32:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 2/8] net: txgbe: use phylink bits added in
 libwx
Message-ID: <ZZVv9cUCef6c17bD@shell.armlinux.org.uk>
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
 <20240103020854.1656604-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103020854.1656604-3-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:08:48AM +0800, Jiawen Wu wrote:
> Convert txgbe to use phylink and phylink_config added in libwx.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


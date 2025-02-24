Return-Path: <netdev+bounces-169086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC47A42863
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A83A70B4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833B263F21;
	Mon, 24 Feb 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yp52K2+K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446C1917F1
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416006; cv=none; b=DOVezUlkkur/NI2IvOG/m3Ft2rV0c/VblXsiU4abAS6VK4HvMYk3IwL5CuLN5JOeK+fOZTU8BVgwZntUaQBVlqECj0I4w73ZCW1+by3h/jaQPi177b9v28hk7NsIrH2mIyjW9XuGH/01ovz+jj3oVWlN6QKGQ807J2sny/IzeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416006; c=relaxed/simple;
	bh=JyRi0WrXrLWHH+T2DLwHD3alUdQ8E+jBpfq4ueFYQnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qgYjX9pIlJSdkiMN4e+/zsD9YNEHhKfXgTZ/SqT4DXwAmEqmdowYt/SwPjK+h026pRlgoCs7RyWmVURgLNHQrpEZz2nb4ZGii50DpQVgRVy1tD0txn0mrjVZftw5SWdqAkLG5ayNcWCm30jvO9ZfuXu4S2jqg2ZvAYDizwLSauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yp52K2+K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eVrvblwUeOHaT5XpR0ycq1832zl1k0eQKG1nFxW4qwE=; b=Yp52K2+Km6Tx58ZqpIMJpAICc8
	vRynoJccGOIhZxobrV9L7bkz71SCBR6olbWMFrYAC9XgkNwC9sDqFkfoqzh7erW3CCMVL5AAu5qYc
	zvJPwhslbILb1/qJXP1GHZ7OYDvr0ykAbeFUuuFPntjqiLojRVHKbiEjVNlMa6nHnjIJigc3+dA8d
	a9xG0h+9IZhTD6Um2Zp2BqgHHehIttG2ARvosni5xx4cvqBUWlGwMENrzVHhFFmb4eKfae10ZiPxk
	erznh5aLAeOaKmA+nY+Pjj6uNesvLx45sKmYBU3wB4S9dv3LE3J2skGAgRhvsmZ0pPr/CPIMKZf43
	sGp1lnqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmbhm-000702-1P;
	Mon, 24 Feb 2025 16:53:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmbhk-0005AN-1g;
	Mon, 24 Feb 2025 16:53:16 +0000
Date: Mon, 24 Feb 2025 16:53:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

My single v1 patch has become two patches as a result of the build
error, as it appears this code uses "data" differently from others.
v2 still produced build warnings despite local builds being clean,
so v3 addresses those.

The first patch brings some consistency with other drivers, naming
local variables that refer to struct plat_stmmacenet_data as
"plat_dat", as is used elsewhere in this driver.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 53 ++++++++++++----------
 1 file changed, 29 insertions(+), 24 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-136566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515B9A2181
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466701C21F72
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF31DCB06;
	Thu, 17 Oct 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q6OjX4mO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B91DC1BD
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166000; cv=none; b=MP3HpbRxhT0K8Qotysnx9tcpqGZjgPeqIt/bSmQqSp4iDGQAmsTitIDX4oimhssrmqnLLjpwImsKQync8t2JNSQZvXs/EmXugKYBdWLno5VUM8o/JSofbnNDDHlVaCpTvyEy1kSmbUgNC9JK302ldKA96huC2pxKWabrRHI4tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166000; c=relaxed/simple;
	bh=N413eM8WzS1RGZBJ0Kk5cx0zDDnBNWC987+5dlYrm0w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Hs+32IFncySJd0tPqioxSWi0tUlTF08joIsdHV355QS1NQhTZmcMoIKnMAvtC/5j3ZdU1xJvC47zkQwPbY/RggnIRFmihhWqI2TnrZkeabh2poIFZW6fGh49ehxsGt2pONy6hRHmnWUGRa1MFJHNOlwcSM7a+H4D3qgftTqJ0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q6OjX4mO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X5R1VAyDfzXSwTaI9sm4LYD34gTnjOhvwyd7oFUcx+8=; b=Q6OjX4mORBeYCuP/hq73SxZFKH
	aRyaPjgKXlTVqMkpteXUG4x5VH85AbqoxMLX2hfwLkeygmcsqkdZmLXVieQ7BKtPfYhnvgIs/Hb33
	H35vvCaTVACw8gvcbOuzD+n/DpjSqkPU7Z0WycCXhzXChPBckaRhmKT02fDazxvzyAnWYoF9SAwYs
	pLa2ZCKuHTZddCX3NRffrcWwEYj0Fn//l2NwNIjJb8jKYNdMQlQ+aOLDk/BcehpXXbEQ58OJPINGh
	B/p7yP/r3SZuGus3CJvAXF6flIKUoJFJzg8aaRmTHg+hPNlL1Qoc6vKdzdf5Z9z79GQjmGwknQBAf
	KRz5ye3g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42932 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P42-0006Vn-0k;
	Thu, 17 Oct 2024 12:53:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P42-000EKd-5S; Thu, 17 Oct 2024 12:53:10 +0100
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 7/7] net: pcs: xpcs: remove return statements in void
 function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P42-000EKd-5S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:53:10 +0100

While using "return" when calling a void returning function inside a
function that returns void doesn't cause a compiler warning, it looks
weird. Convert the bunch of if() statements to a switch() and remove
these return statements.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 89ceedc0f18b..7246a910728d 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1140,13 +1140,20 @@ static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	if (interface == PHY_INTERFACE_MODE_USXGMII)
-		return xpcs_link_up_usxgmii(xpcs, speed);
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+		xpcs_link_up_usxgmii(xpcs, speed);
+		break;
+
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		xpcs_link_up_sgmii_1000basex(xpcs, neg_mode, interface, speed,
+					     duplex);
+		break;
 
-	if (interface == PHY_INTERFACE_MODE_SGMII ||
-	    interface == PHY_INTERFACE_MODE_1000BASEX)
-		return xpcs_link_up_sgmii_1000basex(xpcs, neg_mode, interface,
-						    speed, duplex);
+	default:
+		break;
+	}
 }
 
 static void xpcs_an_restart(struct phylink_pcs *pcs)
-- 
2.30.2



Return-Path: <netdev+bounces-175438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379AA65EDB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F956176F3E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542531C6FED;
	Mon, 17 Mar 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="RVNd4JTS";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="OqoapmT1"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D679D0;
	Mon, 17 Mar 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242317; cv=pass; b=PKClAmdLAZVLZSE2dZdoKygigf4AGeZhHFNjKDvBvFvt73Kj1szMaleYEjxCn8azwmcJFO+X7FX7sT8XwnCL5G6gwKHl64qX4PdVKv4tSkFeA/xUzNdogBtRrNQm12MQDB33fs2wz4iq4rzHu7ipRzFIw4anHOJGuYWEphln77E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242317; c=relaxed/simple;
	bh=9NVjqnYgCsBmMDzDcrvPyoQHqImXvWPH7qg2UlpgFEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5mt+XZB8wajTv40WV3F4uI+6jsNXkvWDjjIDxKJM6H/ibKepJsgSNvOs42lGOt1yOv/X8CGn4zMBRPhxk7e9WpaD6K5ows36U8LSKAn7F0CaHUXVFa+fsNfe2Wv9a0BMK7b+KSnWCwMBTbBmHJbKDBoIY61YjANjKlne0TFKvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=RVNd4JTS; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=OqoapmT1; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742241940; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZU9nCznBL4BGjTOQQnS1iDd9RBbj1EAKhVzM8Ej7apTiSEuA9zTTcjRLRdfim2+tX6
    XDqyi60FsXNopppOoTAG7kInKxDqEm1UjtazwzskwIHV7Q1GL11odkvWZgxSMAMiSgZX
    3rCZ0Z45JVVnCwG81v56VrvmqAK84ssJN07MceIFrLnaDmLSXehkhq9R7zj3lIDb8Yka
    3Q/3FVS9aoVDlcpyW2gA0AaO5EBP/M1Noi7/FVTXhgj90yzyTBo/4B4h8KGfWuQpLrel
    XO3laV91A1dWWay+y+NLRH6pQpymSzSIxC3Ah4ubzZbxp4PW9R7E/azMhsD7/L6YnRDd
    HZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X41sAXwx4dq+mleJddWvcwMFzvvjwQW2qCXvir84Qzw=;
    b=qufXWoYJr4waMziggK5NjKUPSUk/35atBEGxT5C6+E8ak5izc4FqM5sU2CUqx5xzcU
    79vUFouD4TlgItEJ/U4x19E/dVib09Nxv7HRmgFytVASrWEdoj+4yQdAgQ8hwukxGLTS
    2oUneYezCMv0iqlA+iWClTYcvqz32AvJxWfSLDsK+kG7p/tPtlenZSlWWD7k17WyRZjU
    +WMHH28QNRMY5eI2iVv05IhMfRg5jxQOzeNxbwGOU9b964blzsu7Fblz3PSKPRNuzyai
    gKj0vpk9rRpVgOYjmBeIp/XqKF1tYU4IC2IjF+gJAw2IWv18MdRlOgDzLQdyfU1zIm5i
    Z6Hg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X41sAXwx4dq+mleJddWvcwMFzvvjwQW2qCXvir84Qzw=;
    b=RVNd4JTS8T4HPThBPqQ+fVdtvp6sF3C1v+IMpMJa3LBQP0YaktiAVYG5/rkCMmk6I9
    Q2fiiEdwq8nGT5+fRmNtB4/RS1pM84IKrhc6W9BXlk2zuKh1SL72J4+7QoNpxLjeXr0Z
    QoeB0a+G53/eCT/0LMC2NtJXewTORsZgOtc1jNOd0aVyRvYXuftMtFSpbTHArloOOc4f
    3VnvNYm3d/0zNRNc4Ih1QaUr1Lhv8Utc1L/v0NSJ1Az8cfGfc6QMmNk4Wd2nMLSMO8pP
    WDwMIVPfQGRm8F1eVFeE+vr/xCzpbUfrYwZnSPNZqx7JyCZOc95qcPhX3RluM9NSSpi/
    38ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742241940;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X41sAXwx4dq+mleJddWvcwMFzvvjwQW2qCXvir84Qzw=;
    b=OqoapmT1M6lpr+0JO050nYZ99p96deV4s/sh5ZDI+BHV2rsBmk0MVHAI9lX6qX0eDn
    JVdaef/JMah+7X821QBQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512HK5eG00
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 21:05:40 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tuGiO-00085g-1i;
	Mon, 17 Mar 2025 21:05:36 +0100
Received: (nullmailer pid 93679 invoked by uid 502);
	Mon, 17 Mar 2025 20:05:36 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v4 2/3] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
Date: Mon, 17 Mar 2025 21:05:31 +0100
Message-Id: <20250317200532.93620-3-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317200532.93620-1-michael@fossekall.de>
References: <20250317200532.93620-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

rtl8211f_led_hw_control_get() does not need atomic bit operations,
replace set_bit() by __set_bit().

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 58ec16cc8061..ccef7c01ccc4 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -570,17 +570,17 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 	val &= RTL8211F_LEDCR_MASK;
 
 	if (val & RTL8211F_LEDCR_LINK_10)
-		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
 
 	if (val & RTL8211F_LEDCR_LINK_100)
-		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
 
 	if (val & RTL8211F_LEDCR_LINK_1000)
-		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
 
 	if (val & RTL8211F_LEDCR_ACT_TXRX) {
-		set_bit(TRIGGER_NETDEV_RX, rules);
-		set_bit(TRIGGER_NETDEV_TX, rules);
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
 	}
 
 	return 0;
-- 
2.39.5



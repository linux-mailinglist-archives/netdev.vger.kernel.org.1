Return-Path: <netdev+bounces-181509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1AA85425
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A461B681DE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32021B9C7;
	Fri, 11 Apr 2025 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="cl3UQ9AE";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="gvFAdM3y"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BC1E8323;
	Fri, 11 Apr 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353046; cv=pass; b=DxXCSjSvScXnfgRRBpiWIi6aMX7eGT5NqwDNXUpoTH1McbnxpfBhHQ8jb0mN5HV4pNp+wlKMLAPHx2zCVJtZfnL6+q8wiXS2bB+eXiES4/uvb2oo6AGCDxHCiHcrRx472/xF2JrD5VC5F9uz8KPEVhpPWuAvS3XHLg+gJADTFaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353046; c=relaxed/simple;
	bh=FL/zHRGkTfMdzfXifxSvfeF5OBhgbQ3MaRUqFElKz0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0SE8XN1Ryf6dxLMWK8F4pYfA4eu9XymRZbrJyLclJ/VzYiwXkfiH7Qwfl+SAORr95DuMbi2yNU+/B5qLwcU3CtDM6LWB4tLBMOBG6XmxEn2ayin5BiagcpGSRKdTf58RhrqUMKVJf/6u0MdT9WSXiyblAUCLrbBDX2ex0DPjQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=cl3UQ9AE; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=gvFAdM3y; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744352676; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NpICie6SFHLxli3ayk+QwTpwfDTUXv6NaBw5r06kWxJ0LvcgivxrlYwGg+1IIGPb+q
    ni4ssNzf4XyRixRzgl3zdY2wOEZakL73026MA2fakx7yUiTiu/UhRpHMBYr+l+24fkdV
    M1pBcuoAEWkGmY1ZI/3hlFb54sNkDt3oqRJK7W4mHXGCjYTUCQaxIsBI9edJ/Iumk2rn
    N2ysEQjf3AKtjpLofSFH9gDD7PVQ14NpcN6DF+Aprc+raOn5yHZEk38mnWEd5ca74Ux1
    1Mo532vcza9DotTSmUSXPPkRxQMuX0zdHrtHXnwJrf+nyEavj2hcNZZPQ9fNG6cLP3jV
    JEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352676;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yJvzWblq2V3g7go81Jv7S8LucASw8IgMZLFX3zeLYV8=;
    b=muXEyfk8LTnLy/mDaVxyO5Y7s9sAjGD4dhkXQekMo+96FOyE6/sZIvFvCbgkiMl/K9
    94nxSdxFbovMAdZxUiDHfpNVMRNe1G6W7AJ2aClvsJMNsABuIUK0BNCakrxi+Up7AY1E
    JEOGFysIHYtqSnLqKxlHyIXGQ2kO38SJy0w9mvsVU2tHMvUgm0f/T/ycHSnPfsGjt6FW
    2RC9GMBiBSYcs3zyoptqrxaPsXWBoE5nMz3yfCQH4mjsvqSUUcrx1KJdgFUx6QG3Jrqm
    klpgpwOocC63/W9MJUTi7Ka/MUN2x20olqTcHt1wYvhaLerxI3zxsnuPZc0NscqNFH/p
    +2kw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352676;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yJvzWblq2V3g7go81Jv7S8LucASw8IgMZLFX3zeLYV8=;
    b=cl3UQ9AEPUS8hYEpxSyfTlVw1VkWTid3Jw0na+o4Ha+XS0BuUL+HY/Hi8Br9DGnDEM
    DjKWh9VbVnXzhB7FP4Ay6UjsxBCD6i7BOW7qmzxPz6Pkdu/NOTSIqChUCS0ovfATPigQ
    mP/jSCc2RxFnkBICD/uSSF/YTIdJ/p9OsJOa2CTHYt3xyc87Px4DAhQEJdciGdqSzwvD
    41vcjtMfpBSX5jfQFRcCu1E6N6Pf1U+aBVu3Tih0aGZb84uI5IYZvOD5dO+WKhjFcNIt
    yoovflYmvNxOtjx3UY8R0MEvAAW3uFMU3wlnVqGvzn0YJy5TdINy/zNImcOO9ebDnNeu
    NyWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744352676;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yJvzWblq2V3g7go81Jv7S8LucASw8IgMZLFX3zeLYV8=;
    b=gvFAdM3yY5WklCer8B/ap0WoJJdoWDQtgzPHW5yOwuXlSbCqWAlJVyLOJJ3lB3aogr
    PpoBUQsF4TJN7pf/tcBg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513B6OaHac
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 08:24:36 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u37oZ-0000NU-1c;
	Fri, 11 Apr 2025 08:24:35 +0200
Received: (nullmailer pid 8897 invoked by uid 502);
	Fri, 11 Apr 2025 06:24:35 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v6 3/4] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
Date: Fri, 11 Apr 2025 08:24:25 +0200
Message-Id: <20250411062426.8820-4-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411062426.8820-1-michael@fossekall.de>
References: <20250411062426.8820-1-michael@fossekall.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/realtek/realtek_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index b06d53867b99..cf310cc90b97 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -581,17 +581,17 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
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



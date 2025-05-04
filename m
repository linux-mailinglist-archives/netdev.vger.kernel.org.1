Return-Path: <netdev+bounces-187649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F13AA889A
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A55B3ACEAC
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C381F5841;
	Sun,  4 May 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="d3Kn6YbD";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="BpOKrI6T"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F1EBFF0;
	Sun,  4 May 2025 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379960; cv=pass; b=rEhYZNlTifQ9/+J1oI4LhD/uIQkFZX/iqhEZHncyx4i/0i6mEXQKNwwyBGocgSBue206/IYZH803oXloV5yqfVfRpA6JtVYc5NwoN7PQJbhSLmRPnBVYy3SOERSUB0sLQ0IzKRll81mTRPImuxcSfaUSI4REE/NbpiVMv9JZG0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379960; c=relaxed/simple;
	bh=jjVvFwaPVz8sERV6/nfEQEuaJq+qD+p0iszyZxBKs4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM0JYeBw6KkzsD+hV2qy9Fiuis2PVfplfEIerxQodFCDmXME7rRO4kXLtku1RlA+qKYXp2SQCaZZ3Pi3/v4KCed6oPo9w45m6Xhy4btpyDY8vJ8SedBKm1bLABm81oC62/WMUlj88FUfezy1z1ecTSprew1yNSIQ/FgkZnPoi2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=d3Kn6YbD; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=BpOKrI6T; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oFdZfCZ+67Dd3ga6ki4V+aJR+ewoaPBx3e1fFNTRZkejt6Iy/sWZfT6I8KOMyxEIDN
    J9ORLBJYaJI/nQXamvObT4brlpinx9kR/tIYvC/lgTKdVYKwDJo4TTxrviaczX/hRVmz
    tY/KjbvOqeTPEHC/24KFhPDdr5zZ/umL6dW9lJzpJiE6eerdV5jtdcq6eplz6Uhi7Ozm
    TXyQD13+GctoztaPf44PSxsXkehVYqof8OkdpN1KKBr/VJ8Fu7f+obM3NKisAdmXUV/t
    PA/NiZ/hZYc618LX/3BTiZ4nOoIfklqxjJGDsaoAVz+L0ioyoBvoMsFmvRVGGTyXkUtl
    4onQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ThmyLMnI+zNQGBsrrmk/j1yTgAAi9LHyZ0fVJEHOioo=;
    b=eMJ/PvqjoTjIaIIi5nFq1cCHHm2oiUjhM6yuy22C1i3aQjHxTKQc/hketU/FTeCFiN
    83RKYOL5sI3HUgHyiiNPFjHRWrLYoGLQhGCxHcTNxLXEmvpCYCiNV+aITsr8WQHsbA+5
    KfB/ypYcnHUBnCtzGPQBqChbAkTlU2f9c+pbjzbx1JdFJMLANfQgzO0bFwb74c6TD6Ju
    x/UIGQD4i/MFppuF7/JkhzlHUZBZaMzQoeQcKMTfWd2dxM63BPsUvMJLz8xmVzPJa0ru
    F8Dym01ftCnO/dRg/8SYpNZmaZFO7xsjBOIMPXQb/2lNdoIGa5PFeRoOj3wzVmuNEcEE
    sCqw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ThmyLMnI+zNQGBsrrmk/j1yTgAAi9LHyZ0fVJEHOioo=;
    b=d3Kn6YbD5KKgw/Ab9Sh+MM08eHz0M66JAnZ36RFHdVM0Sj0O+8I3zRkUZZxQecmChd
    N9KMY8isksMH6C395g/fkNuFPsPCaTpJ88IvhnSfsPriX04JoprcQV0OMnEbVimNu8Ed
    NOo+RkhmsAiljI+rGX6bCopaUYe/ezyU3iO7t7I45Z+cRcIWhY7XSMa+eqron2EqOz+Q
    fT5xy5XjjJlPN9QG/MFm8Bcp76F04PTNWdufajT48nZYBjMDWnKtoOGgu9INjNpXhF1T
    hiIE6G/8gwYQEiPkhJT6TVxSUwHEkIMzHXDSsbHqbWmYcLmYnSxLMVG039pKz/Jg6T1P
    G2jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379774;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ThmyLMnI+zNQGBsrrmk/j1yTgAAi9LHyZ0fVJEHOioo=;
    b=BpOKrI6TSvB7Ldzdiq2qv0Ge4pRpZ4rCF4Qge1+AvJktNpQ1iRWhIazhDyt7+N3cjb
    /SG35yK4Q9Jax6L4VDDg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTYz9K
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:34 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9g-0004OW-0h;
	Sun, 04 May 2025 19:29:32 +0200
Received: (nullmailer pid 243292 invoked by uid 502);
	Sun, 04 May 2025 17:29:32 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 5/6] net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
Date: Sun,  4 May 2025 19:29:15 +0200
Message-Id: <20250504172916.243185-6-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
References: <20250504172916.243185-1-michael@fossekall.de>
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
index e01b13a9b5c3..e26098a2ff27 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -659,17 +659,17 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
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



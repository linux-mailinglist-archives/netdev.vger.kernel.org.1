Return-Path: <netdev+bounces-33224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159579D0F8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38674281A26
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03B154A4;
	Tue, 12 Sep 2023 12:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7020FE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:26:09 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20AC10E3;
	Tue, 12 Sep 2023 05:26:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so4277767e87.1;
        Tue, 12 Sep 2023 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521567; x=1695126367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnLlBCmtmpQwQX7mUFEwOLmXNNLfxSSVf+nmIrWyOZs=;
        b=EYSrpED2Cj87rwpIj26QLhbqEhLfgTWxmFxunudHer/hmDZkZy9DTJDmuh6LZh5wRZ
         kKpLbwF0mYSMO/GiKr2WWuNFYPs2M1t8xf2aNf0VhcEpUNgIsOS7dB4Ipy/WdjkO1KwA
         58e17DgoSo5bQGUfqbrHi4luJuCrusUGNC94FqYEEy6DeY08O4OedEP/gQkgHtonRSxf
         Bpurbv22SQmU4NaCjNYhHJZFTmlmGB4BklTVbdrqZfbM+uUI7aaXD7M+VUyMIJhO+xBY
         VGUVo2OA/twMS4E71NKIsA04wxUFQXUstFAZOGpGYSfX5ptTly2p7ncx8JpGaf0GajMb
         EwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521567; x=1695126367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnLlBCmtmpQwQX7mUFEwOLmXNNLfxSSVf+nmIrWyOZs=;
        b=jBpc5nZC6pdPjNWGKlC1PZU540ud55MqC5LQVEb4MMgDrKGMRdUIns0krt8IV2RvTO
         dRR89kV/IgImZAoWbJQTrixaBlRkSNyqwgIfs62G4yNjtxXOE4uPctYIqO+qZFDZUzsG
         D9kBFrJSKRSpYtDtC8Mx/rihsd4tP3Pe+LBGzL0Ib8cW/QNGmyVNdCW8s5Nj+RNQitVo
         Q/DGauUQ+gtmFllOdT//7sqb4vIRx9RTInIKm3JK9BlzH6uVE0f8OnURKpXgABgEckGh
         +Hw/qftOK4bLCgUYp0O/uS/BUxtxECqTnRkNJN+A/BlGI41+s16Bu/KB9SN9mT+4UvXN
         OVHQ==
X-Gm-Message-State: AOJu0Yz72mpFT6IOO+AbpQCEBi+h0FbdcEWVOp75ZDZe2zDKr7bZiXxL
	V/eEhf3A704xr44ywOTUFuWlnXbpdt2ecw==
X-Google-Smtp-Source: AGHT+IG1G3AMAK3YToq5m7pTojGhwQBOMsXKM2t2ivPIYbpqabYebLZCZdyQW//J5iFXqavwZ3IlzQ==
X-Received: by 2002:a05:6512:15a3:b0:501:c1d4:cf68 with SMTP id bp35-20020a05651215a300b00501c1d4cf68mr12169998lfb.15.1694521566405;
        Tue, 12 Sep 2023 05:26:06 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:06 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/8] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Tue, 12 Sep 2023 14:21:55 +0200
Message-Id: <20230912122201.3752918-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit switches delay loop to read_poll_timeout macro during
Arbiter empty check in adjust link function.

As Russel King suggested:

"This [change] avoids the issue that on the last iteration, the code reads
the register, test it, find the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait."

It also remove one short msleep delay.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3:
  - Add "Reviewed-by" to commit message only
v2:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4f09e7438f3b..b117c0c18e36 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -779,7 +779,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -794,19 +794,16 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					1000, 10000, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-- 
2.34.1



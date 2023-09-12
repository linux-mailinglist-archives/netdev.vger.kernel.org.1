Return-Path: <netdev+bounces-33227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75379D100
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E81C20DE7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D03156D2;
	Tue, 12 Sep 2023 12:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B2BE4B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:26:43 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6410E3;
	Tue, 12 Sep 2023 05:26:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50078eba7afso9634875e87.0;
        Tue, 12 Sep 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521600; x=1695126400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLiYnDslj4QGPvPw52DJQXGshf2rhE8i4UYC6emHYJA=;
        b=mSeVFcL/tbHM9eTF/baMaMLbu9IXfcK0WpJ+UWVfiwEkhoCeugbP3f/exZBsyp9oQL
         lNUGj8YpdBQ2/28L7Pr++n9crG5mvIY/UPH0zuGGjyFSnKBAPFLyba/ZCiab3gtv6gmk
         HtUx8120miroq5gbYEQhTMPf+0fcUBuH8N4oClyiOuI87DWMSTJGKYUPWgNQQurinEtl
         IoMx2Hbml+WCi1iia2nMm/ChrW8o52nZ4yUug05c6xiO7iwLn9SstdpSBFAz2JPSxoxd
         LkDb5h26J3WwZ7s8+lnT/lS0jlfa66c9jmSdUOt/3nANCnq2SumLCHlqqrWbXimN7aEY
         XcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521600; x=1695126400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLiYnDslj4QGPvPw52DJQXGshf2rhE8i4UYC6emHYJA=;
        b=ZZpiH/XDohXEel2QnTkiu4GsWuQRq/hnaQ6yn/i6qBNdMXnPBLCFDsBIe/3kJ4TA2n
         askrguTL9IMFV7xMrKOxbBC0BxNEEUXWQyc0vtCslOof7/1seXxPMBc20nWkrbIkadNf
         iSj334ls70VZNJZ0zmnAaXohCGJKto5QmbIGoIZVcxTOl9vXG4CObffOcYAYhSbxXBo8
         rsQeTTBadUrJGub4uUGY5fhM8PyhnRcS/qX9VjGeEkngJ0keT2rfrbN80g4f1+RFgN0+
         O8bpUAZ5igIfuX8cF+kJm0gOYnU6DHJuFnZLJOKpaletrY5vw49obEINPvuJwP4KhUrk
         ERdQ==
X-Gm-Message-State: AOJu0Yzf9gxrsq9jwZoA5Rdn0RzCJnuHHVVy8EQPBfzXkgk7CvI6/p2X
	kHglgznqzGNZcBTDmc2zaZtT05zGI9kDCg==
X-Google-Smtp-Source: AGHT+IFITTu921/xfXw8wra3PAhwjkYob1e3m7GFd3B8e9CJNX3dljG2FX2aTGGy5D92CgC16zjOTQ==
X-Received: by 2002:a05:6512:3a92:b0:4fd:cae7:2393 with SMTP id q18-20020a0565123a9200b004fdcae72393mr11965194lfu.2.1694521600349;
        Tue, 12 Sep 2023 05:26:40 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:40 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/8] net: dsa: vsc73xx: add port_stp_state_set function
Date: Tue, 12 Sep 2023 14:21:58 +0200
Message-Id: <20230912122201.3752918-5-paweldembicki@gmail.com>
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

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc

 drivers/net/dsa/vitesse-vsc73xx-core.c | 61 +++++++++++++++++++++++---
 drivers/net/dsa/vitesse-vsc73xx.h      |  2 +
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8f2285a03e82..541fbc195df1 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -163,6 +163,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -619,9 +623,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -864,9 +865,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
 	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
@@ -1033,9 +1031,59 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 	return 9600 - ETH_HLEN - ETH_FCS_LEN;
 }
 
+static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
+{
+	/* Configure forward map to CPU <-> port only */
+	if (port == CPU_PORT)
+		vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK &
+					     ~BIT(CPU_PORT);
+	else
+		vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK &
+					 BIT(CPU_PORT);
+
+	return 0;
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag8021q operations.
+ */
+
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	if (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_RECVMASK, BIT(port), 0);
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_RECVMASK, BIT(port), BIT(port));
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_LEARNMASK, BIT(port), BIT(port));
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_LEARNMASK, BIT(port), 0);
+
+	if (state == BR_STATE_FORWARDING)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK,
+				    vsc->forward_map[port]);
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
+	.port_setup = vsc73xx_port_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
@@ -1049,6 +1097,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index f79d81ef24fb..224e284a5573 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -18,6 +18,7 @@
 
 /**
  * struct vsc73xx - VSC73xx state container
+ * @forward_map: Forward table cache
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -28,6 +29,7 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	u8				forward_map[VSC73XX_MAX_NUM_PORTS];
 };
 
 struct vsc73xx_ops {
-- 
2.34.1



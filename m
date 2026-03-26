Return-Path: <netdev+bounces-271942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLYNK2v7xGn+5QQAu9opvQ
	(envelope-from <netdev+bounces-271942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9033241A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2B63181730
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B43BD259;
	Thu, 26 Mar 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK67c333"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703CA3B8D7E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516254; cv=none; b=QKwQXaZWUyni33TXXFQJeiz9uXooEYckf6FvJmFWrBnJtBt5iKt6bpZqKAUiXYhyqnTEk15u886PGm5pk9qtb3amp24LW+5KOgeA7iODO8vqWcK9AmiamLCrqYo691MN4Hlkx6wDW+gxM/f3c2adf7Sfp3cmh+hPiWn7Rkj2etY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516254; c=relaxed/simple;
	bh=8+8i3aomOLS8R8b5sollZ2ZiFAWOT1uHJtt2Q7PXFp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Su1cMb4KtCNdUqfvnHPs4Lsx4KvfC3eBgqF4fj7IsD/ES60o33BbbklFFQreA5mugkWuzudaU39dDW/GaLc2hVgZzMjQIY+Z4NIl9nryv7+lwmxULXllljUOn9xasL5SI2qDhfkFhktx3wT1KwiNOEgJ51t3ESjr87zkQ1ShQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK67c333; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b98652f05so100466f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516252; x=1775121052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDIt8ynlMPPK0wzqF40DJoyfDxdBKdzIG4wv5s2In+Q=;
        b=KK67c333v2UQBXZfGlsXu9xlt/W6+97A1LgDGPy9T3JFTJMsNLJjD5WxT1/DUFBzK9
         zsdzIQuMsr29z636kNd1x5JUteFRXB6zcfysUiKQksiv/UVOQz2gkxGOog271WM+jfVB
         CVRPAocAXRzgkU6pio+Hljdx5smHdRknkcxMmYaXWqfMZJm+8ALnXVubjnl/M0mPurhA
         PrpGGrSlA+dGDXzeXhAKemLU9U/7feSXNqo1MfiBGwFmCyCVoFjECtZhfoM9aEMuAgEh
         jX7BM9dTHvJ0xyi2/gEVPXSXg18yd0LK8mR2h++x9OLsVjU75izp/kZfeWgXEnWU1qfd
         F6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516252; x=1775121052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDIt8ynlMPPK0wzqF40DJoyfDxdBKdzIG4wv5s2In+Q=;
        b=l/W0jECIVEVD00iwtLWMpJajkufLL52rpyF2N2pPivEf0h+RK+fL9ECUeb+ysdV8kx
         SaGTfCPtgI2po+xnbRr8BpYLPBLbfI3gFB90yP64de2+To2xK3Cx5yHdNzPsDXlJ8pIY
         JjSTck0DuA1LKgpSXaC8rgxF0rTy/+86VJbocm6GDXNwX+kVm/TUQthEquQhOL0ZXvMH
         e2e3yR12wQdGT2PeRcqx7UV+KcaGc4f7MJcGuQjvakJG338/Q+R+U6QZyuPhqMcEr3+f
         M7N0RlR2LVeUQgBWpccdwTBb5MYSx8FUT6snke28XhhNffTYt7f4qR97BFZ96MSOOb1v
         0eUA==
X-Forwarded-Encrypted: i=1; AJvYcCVTy1KniMysmTmc5lhnwW11qiHjxuU0OsxlVp5xlkBPMnOxMj9cPOdx7qBhxrbeVujsXiE79+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgBDqBF3T/FG1C3zLnxooip58R6u6IwkY8AGzGD5TEdUw6q3D
	QuoMYaBnFmfxbfpMDy6K4kkJUIWFFuzAqSk4wXUimf7xet4T/nlzeeO8
X-Gm-Gg: ATEYQzxH60xDDBZQqQWWgdkynQaqb5+kGz+mNgmhT30CD9pOyVlzKXTZ3TnFr7MREmU
	HnjAuwHO+Cj2aqP0Qf8Vscn416Ogi6vB3BDoKFdZsFQcFEnFVA7jgKzannvDkcwu+VOZ1avADgc
	WILs4355rsAsY/zy40DxZB6hOAjyVVhavvNocu/PSmoEd0CwWrICUr4byXavgVkOy9p47jprDAy
	q4OyPr8z2jsxTfCD2p7UOS+39uU2vMYNZBZG2Qi8z4nrYIoDh0j5Q80XRIzF4HbNfHEifvsHRQW
	qXnjwwhttphy5Rk24LpSwOK9ODGtX43NM7jd+OS58ypo9XwQf68Hqpk+8U64KXhzOC2WEf/yukI
	UmjaxzLp5LnSsMg3xO/EWiPWkPvG7xRUc3IwoQw7MFureUVrI2MZJBfnmZ+O9iygnbfebfWCfhC
	gVnvobU2BJ51ipYBA/D/bcs3Ww+z93rB7MKS2vJTHHvOKbHVUcWS4lCVIWXEp98EduEIqF3MzZE
	3PM90PVRg==
X-Received: by 2002:a05:6000:40e0:b0:439:936b:bff4 with SMTP id ffacd0b85a97d-43b88a2939fmr9878451f8f.46.1774516251706;
        Thu, 26 Mar 2026 02:10:51 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm6381199f8f.37.2026.03.26.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:10:51 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Thu, 26 Mar 2026 10:10:22 +0100
Subject: [PATCH 2/3] net: dsa: microchip: parse KSZ87xx low-loss errata
 from DT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-ksz87xx_errata_low_loss_connections-v1-2-79a698f43626@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774516248; l=3456;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=8+8i3aomOLS8R8b5sollZ2ZiFAWOT1uHJtt2Q7PXFp4=;
 b=R/3HNms1ACa2Mn3v7SBYrjkAoaa6bt/B2PlA7rR3/K+Hd/yvt4vsoeheFdN7BB4KG+iLb5tw9
 nheDwsKTLVlAPe2fatFvMp7rPf8lFmWrgrHN0M8n753bPqnXiN9qEpx
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271942-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EB9033241A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add parsing of the new DT bindings related to the KSZ87xx low-loss cable
errata. The parsed values are stored in the ksz_device structure for use
during switch initialization.

If the enable property is present, the driver reads the errata mode
(microchip,low-loss-errata) and selects workaround 1 or 2 accordingly.
If the enable property is absent, the errata logic is fully disabled.

This keeps behavior fully backward-compatible with existing
device trees.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 25 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz_common.h |  9 +++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..78b42cf50ce2 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1989,6 +1989,10 @@ int ksz8_setup(struct dsa_switch *ds)
 			ret = ksz_rmw8(dev, REG_INT_ENABLE, INT_PME, 0);
 	}
 
+	/* Check if errata on low loss cable should be applied */
+	if (ksz_is_ksz87xx(dev))
+		ksz87xx_parse_errata_dt(dev);
+
 	if (!ret)
 		return ksz8_handle_global_errata(ds);
 	else
@@ -2096,6 +2100,27 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+void ksz87xx_parse_errata_dt(struct ksz_device *dev)
+{
+	struct device_node *np = dev->dev->of_node;
+	u32 mode;
+	int ret;
+
+	dev->low_loss_wa_enable = of_property_read_bool(np, "microchip,low-loss-errata-enable");
+
+	if (!dev->low_loss_wa_enable) {
+		dev->low_loss_wa_mode = KSZ_LOW_LOSS_WA_NONE;
+		return;
+	}
+
+	ret = of_property_read_u32(np, "microchip,low-loss-errata", &mode);
+
+	if (!ret && (mode == 1 || mode == 2))
+		dev->low_loss_wa_mode = mode;
+	else
+		dev->low_loss_wa_mode = KSZ_LOW_LOSS_WA_1;
+}
+
 int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 0f2cd1474b44..3a43769a4c53 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -66,5 +66,6 @@ int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 u32 ksz8463_get_port_addr(int port, int offset);
 int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
+void ksz87xx_parse_errata_dt(struct ksz_device *dev);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..f40e7bd20b3e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -158,6 +158,12 @@ struct ksz_port {
 	bool manual_flow;
 };
 
+enum ksz_low_loss_wa_mode {
+	KSZ_LOW_LOSS_WA_NONE = 0,
+	KSZ_LOW_LOSS_WA_1    = 1,
+	KSZ_LOW_LOSS_WA_2    = 2,
+};
+
 struct ksz_device {
 	struct dsa_switch *ds;
 	struct ksz_platform_data *pdata;
@@ -219,6 +225,9 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	bool low_loss_wa_enable;     /* low-loss cable errata activation */
+	enum ksz_low_loss_wa_mode low_loss_wa_mode;     /* low-loss cable Workaround to apply */
 };
 
 /* List of supported models */

-- 
2.53.0



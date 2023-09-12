Return-Path: <netdev+bounces-33226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47E79D0FD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F411C20DDE
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690316430;
	Tue, 12 Sep 2023 12:26:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F43BE4B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:26:34 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FDF1716;
	Tue, 12 Sep 2023 05:26:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so8119181e87.0;
        Tue, 12 Sep 2023 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521591; x=1695126391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIINcjg1K0iB3NZ3Vu0aeFoG3sVyQIACaQcxlgJYgGA=;
        b=FEqJ0Rd0p3IE8r9kIAhHmm90tcUFGC+VJH5550HnSSBczPUaGdNFf8Nu23xYes9Ukm
         lwIgMqJnIW3KbMUsW9dEi6dfiVXDMLZny7teBcylMXkRttEMvm/vTI/XMlTfWLkIjY/h
         6xZfwl6+nEFYDLPNohHVmyOIjbnj/6zEX9W0F6N/1Xx3Qja3YOu6+c79mgwmhYGz/DxC
         OpQ/0092jQvNln/uenMZVpwvm+WJZn7L4fsIgKaQK/aTTMdrH5xKbAuMRzCPM2jKde35
         s7Cl10tvI2GxVLaNK3usQ2gchh5zDHb/wPFPGII6/mju/AuUNvkve/4Cu6I7oZt4tHub
         LRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521591; x=1695126391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIINcjg1K0iB3NZ3Vu0aeFoG3sVyQIACaQcxlgJYgGA=;
        b=mZ8eLe+gsQn7ahhfd/t5VpzemA/1fnzNUTiBmQQSXb8NgiYl0aYzRFRpPdSoPCp4gp
         ctA4R21OCPL7RR++gtCYs6jECxyBi64WV/aXQF0OndtisvLZs6uKGDtB03Xekc7axaC5
         wDjLLus8g7sz/0j6uHSzbyxu51Ff2L9x/VX0vbczhobVpaBbmQPcStgFhlIF0c4fsAOo
         LhcdqHelSkpuGuPuShzxZy8ONPn5HsGfpdchC/QAlAZACwx5EGVXpEfE2DkYgcF8p4eC
         yfIWBdbKxoy/af3JVhUa6L3ED3Za/pXukCLSbQcBIXFNbJFGPn5fEpWP2z6nAXL//wJS
         6bwg==
X-Gm-Message-State: AOJu0YwJqlwWoZBsLvgRAZqgHbpFOu98ml5jIzPWqizWzldRZXikpaxr
	Bbm73QYpUc4hQjDEiZ7pvR0doNVjzXdTiA==
X-Google-Smtp-Source: AGHT+IFNqXL/mbRbfyqU9xKH+dvengeJ9YwA6QuKbMZc7kTq/yVK1regtJsMZjXQzp2/wfIu7JfzeQ==
X-Received: by 2002:a05:6512:31c4:b0:500:b102:d1c9 with SMTP id j4-20020a05651231c400b00500b102d1c9mr906528lfe.29.1694521591426;
        Tue, 12 Sep 2023 05:26:31 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:31 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/8] net: dsa: vsc73xx: Add define for max num of ports
Date: Tue, 12 Sep 2023 14:21:57 +0200
Message-Id: <20230912122201.3752918-4-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v3:
  - Introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 13 +++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 39d3d78f4bc3..8f2285a03e82 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1175,23 +1175,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		 vsc->addr[0], vsc->addr[1], vsc->addr[2],
 		 vsc->addr[3], vsc->addr[4], vsc->addr[5]);
 
-	/* The VSC7395 switch chips have 5+1 ports which means 5
-	 * ordinary ports and a sixth CPU port facing the processor
-	 * with an RGMII interface. These ports are numbered 0..4
-	 * and 6, so they leave a "hole" in the port map for port 5,
-	 * which is invalid.
-	 *
-	 * The VSC7398 has 8 ports, port 7 is again the CPU port.
-	 *
-	 * We allocate 8 ports and avoid access to the nonexistant
-	 * ports.
-	 */
 	vsc->ds = devm_kzalloc(dev, sizeof(*vsc->ds), GFP_KERNEL);
 	if (!vsc->ds)
 		return -ENOMEM;
 
 	vsc->ds->dev = dev;
-	vsc->ds->num_ports = 8;
+	vsc->ds->num_ports = VSC73XX_MAX_NUM_PORTS;
 	vsc->ds->priv = vsc;
 
 	vsc->ds->ops = &vsc73xx_ds_ops;
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..f79d81ef24fb 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -3,6 +3,19 @@
 #include <linux/etherdevice.h>
 #include <linux/gpio/driver.h>
 
+/* The VSC7395 switch chips have 5+1 ports which means 5
+ * ordinary ports and a sixth CPU port facing the processor
+ * with an RGMII interface. These ports are numbered 0..4
+ * and 6, so they leave a "hole" in the port map for port 5,
+ * which is invalid.
+ *
+ * The VSC7398 has 8 ports, port 7 is again the CPU port.
+ *
+ * We allocate 8 ports and avoid access to the nonexistant
+ * ports.
+ */
+#define VSC73XX_MAX_NUM_PORTS	8
+
 /**
  * struct vsc73xx - VSC73xx state container
  */
-- 
2.34.1



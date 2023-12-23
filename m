Return-Path: <netdev+bounces-60003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F4981D0E3
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BABF1C21BC6
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91609396;
	Sat, 23 Dec 2023 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPNKgoJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA01376
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d2e6e14865so15741015ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292850; x=1703897650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/OUgEHqJzfbmhRHvlImtbrLIayt04REq9M8W1Cd2/M=;
        b=PPNKgoJH4FDkQGtGSv8Ecu2efuH7Ta23awnyRI9wsbyILvW9OGHZQ2SKWvfps1MCE1
         Ypy+h/dFKfdbnvbDgMEyrZQMKqKo9aMP2ytBt/g995M4XBmzic2PpyyZIdnJP6+auSfD
         7a4r6wWPq8gXGLfWAArcbxf+LSerqwOJRs8XCO/8ZSF+4x/SxyCF7gizx/4OYTuqBKm1
         ppVKoGzqjcXNBVTqD0rkPsVoONzTB+yI99JeogrL3BSwlkGfYJNiQnJByvAAzHcLTrb6
         Jo34pWUMVVwvsMIXEWpRM1e1Hz7eCbnA546LAqDAvh8c6yN8u6XCKyuWuLHPcmOjGa7B
         t1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292850; x=1703897650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/OUgEHqJzfbmhRHvlImtbrLIayt04REq9M8W1Cd2/M=;
        b=ZpiskiRZe8W0jII68YGZe1vznrJ1G17PI7OmQBl4yQXVQFPq/Yi2IkZw7ZMxM66Fw8
         mqlfSW0GdkmCuX2YRNRqz9g6psdaDiE+hMAPZH08Pk/AEJNz5aJQMcLj0SoH6CisDCD1
         /pHN/9FfKH5iv3nx8b3k9/Lh2AAy3VsIey3Bc6t75iNdGKdIoJXL0uLuBY67EHBor7Sv
         DNrhyoFxPN0QQAgQBLYbcmPPEDba1k45kFK0NTHTz3TcufbsdA3RDQZYPb4pLCAlSkWg
         DGOeIufbOWsifg1qgWaSusMEWEZPXuCfx2V4WtxGVLYE08WPV9jo5xIVbNDnSZMlH6eC
         GLKw==
X-Gm-Message-State: AOJu0YyM202qxSRUhGHOcznUpsbraBlRhoXvqurSkCXhVFjbLo0z2cXh
	9aHL2APKxHzQlPK5zXmTG48I/KyW+CFgWFYd
X-Google-Smtp-Source: AGHT+IEgqdXZsfxlDx4mqkS8NmgEoWf3hM1OgrlMXKnvDOdg4udC2jzJkhCTK4ICA4hVKDAMAZwtmQ==
X-Received: by 2002:a17:902:e9c4:b0:1d4:14a0:bf66 with SMTP id 4-20020a170902e9c400b001d414a0bf66mr1357280plk.23.1703292849698;
        Fri, 22 Dec 2023 16:54:09 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:54:09 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
Date: Fri, 22 Dec 2023 21:46:36 -0300
Message-ID: <20231223005253.17891-9-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>
References: <20231223005253.17891-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit fe7324b932222574a0721b80e72c6c5fe57960d1.

The use of user_mii_bus is inappropriate when the hardware is described
with a device-tree [1].

Since all drivers currently implementing ds_switch_ops.phy_{read,write}
were not updated to utilize the MDIO information from OF with the
generic "dsa user mii", they might not be affected by this change.

[1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 net/dsa/dsa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..09d2f5d4b3dd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
@@ -626,7 +625,6 @@ static void dsa_switch_teardown_tag_protocol(struct dsa_switch *ds)
 
 static int dsa_switch_setup(struct dsa_switch *ds)
 {
-	struct device_node *dn;
 	int err;
 
 	if (ds->setup)
@@ -666,10 +664,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 		dsa_user_mii_bus_init(ds);
 
-		dn = of_get_child_by_name(ds->dev->of_node, "mdio");
-
-		err = of_mdiobus_register(ds->user_mii_bus, dn);
-		of_node_put(dn);
+		err = mdiobus_register(ds->user_mii_bus);
 		if (err < 0)
 			goto free_user_mii_bus;
 	}
-- 
2.43.0



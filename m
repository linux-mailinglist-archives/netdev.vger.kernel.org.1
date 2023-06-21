Return-Path: <netdev+bounces-12806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E9738FDA
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA631C20C77
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C71B911;
	Wed, 21 Jun 2023 19:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008B19E76
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:14:29 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DAF1FE6;
	Wed, 21 Jun 2023 12:14:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98862e7e3e6so589299466b.0;
        Wed, 21 Jun 2023 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374858; x=1689966858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdYtgHKZj+ELTXrWmyVhlIH7tFc3MvfFabglOK+p780=;
        b=WXgkrRpNV56pikPYNbETkpOiv1IcHYuJvW8/KS9rXaLhYXpVRTs6PWx1fAuFZN72Q1
         HTbGS1e2jMI0pZK66Asq4XV1AF9EUKf/iQyjhQr0eIzu17rYRmk+V0fB7gVsrXUoLxPj
         sP3YWzUET9wo/mA4jfFp/DH1t3i2kmWfv1I4kHy2mWq+zjMQ7SbPrTHaI8grT1IPtSM9
         9anmQkDLJulg48sUBYIY+/8+wjT7T9Furh+qdo7ZMRCW1ZsqlNRyFjtojbhNb+UDgSiL
         sRPSyCg6VDfvFJBLwRT7HH2J2OsU7hi+XrUxJW5D1gz5KAZ68oix8XF3HLhVFYfDsj+P
         HpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374858; x=1689966858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdYtgHKZj+ELTXrWmyVhlIH7tFc3MvfFabglOK+p780=;
        b=f/MNNErde+ZBpvMSu04Pf3drb5FoSTqBf2llH8hPL84zxUNR3h6zZ9Xynr5hrjsy0y
         b1LZ7gSrFsAb7ZDBJNnpQBQDeS2/21P2HYjm940xBU+A3GjBI7sJP7qZo9Rbi3e1xC1i
         mcltblnrZUqcc42lYo5/NZ2tqtAl3j32z4vYU0Blx9bjgOAL6q5Bo7pp13+xGltnZiKI
         lAuk2OcEuB0zDSNaLW8PnvNXIjpCHp43spmfN/xOS6HqPm/AxqARrcUQEgiZ0TNh5wLy
         WTv+T6NLjFP/iE5/4h4ziEScCNs59MK9+zE3hD3aQOnBQmV1TJmVn8dvsldBWyrBU/F5
         MDng==
X-Gm-Message-State: AC+VfDwTFUAP2V0AuKkqrTDUu8xnfccPXKjWVyMn+UzUqo3Jee2WenhB
	90abASRImu8ud4oHbgxKRlfU1b3G/qKIPg==
X-Google-Smtp-Source: ACHHUZ6Zjg8q80fKUCVFrV6eKRynkFRJXjQOIW4s1EuaR8e1mZTQXYXevQkFvsC5u7IJCBH9m0va/w==
X-Received: by 2002:a17:907:7d86:b0:978:8790:9103 with SMTP id oz6-20020a1709077d8600b0097887909103mr16038144ejc.70.1687374858324;
        Wed, 21 Jun 2023 12:14:18 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:14:18 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: dsa: vsc73xx: fix MTU configuration
Date: Wed, 21 Jun 2023 21:13:02 +0200
Message-Id: <20230621191302.1405623-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch in MAXLEN register store maximum size of data frame.
MTU size is 18 bytes smaller than frame size.

Current settings causes problems with packet forwarding.
This patch fix MTU settings to proper values.

Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index fcce47cf6da4..a806a263cf08 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -992,17 +992,18 @@ static int vsc73xx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	struct vsc73xx *vsc = ds->priv;
 
 	return vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port,
-			     VSC73XX_MAXLEN, new_mtu);
+			     VSC73XX_MAXLEN, new_mtu + ETH_HLEN + ETH_FCS_LEN);
 }
 
 /* According to application not "VSC7398 Jumbo Frames" setting
- * up the MTU to 9.6 KB does not affect the performance on standard
+ * up the frame size to 9.6 KB does not affect the performance on standard
  * frames. It is clear from the application note that
  * "9.6 kilobytes" == 9600 bytes.
  */
 static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 {
-	return 9600;
+	/* max mtu = 9600 - ETH_HLEN - ETH_FCS_LEN */
+	return 9582;
 }
 
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
-- 
2.34.1



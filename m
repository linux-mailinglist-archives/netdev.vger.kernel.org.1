Return-Path: <netdev+bounces-55576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62A80B6E4
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF20B20933
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F81DDD5;
	Sat,  9 Dec 2023 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgf5xE2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15210B
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 14:37:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso3242887e87.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 14:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702161461; x=1702766261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wK1ulY27NMZmWdsLq7CLiqw+4sl1nkCqvHbECoiH7eE=;
        b=sgf5xE2qGM/H2zDTiwf7zrvUCf7GeHLPLd8tA9lhEkbsDcEH9PHLveWsFTWTkr8J8x
         +pg4jbJVXjyyfu7rPfwf1fK0I9333cR6pOc1Cn7+Wm8CIptfHCePeKjBtH2EqsckWcz6
         PXaJww1jvP2cLkCMuLBtHmjByY78pqtkA8GQ+Dy9dfhHnr5PSvwM6Wn46u+zNGKnhJge
         n+gNcZvw+U73wXEmHqtnf3+veOVShgYDFFtK0Ef8JiySaZKmEK/Q+IS4UvMzds9feG1/
         IR6+LsWBTd7lTbp0kmpLC3ZIQ7O9wfkUF6K5yzH64LgEHez4NKDjz9+WZY4eB6iLuCTs
         HMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702161461; x=1702766261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK1ulY27NMZmWdsLq7CLiqw+4sl1nkCqvHbECoiH7eE=;
        b=wfR6gDGucrxkn1eP/RqkHTnDtmyNdHa/cscqeFCdQ59cJ32qI5ETTJb7PDMPSzPFJ8
         JUsz2Q8APGlDGAGPwyTxbMeMiqM7KLdpIWiRe6uDlHLznTlIwiwQD8TJ23xP8MFXQIAh
         vOJUHkT+F0m0Bz5stN/j6Y17OY7kzWuFblCYOR8IVCs2F81fjPbdu2OPw2mVtpykSkzT
         NQ51yleDwByYnhjTOMnLk1JpTUkTywomQRm0aCdSGtnZB9dkJG30yE9za52z956KJxXj
         w7AMlubQ7M28NtKV0sGidf5CZ929vbL6BkuSz8t80QfAaYtDAOp4RnxLWvQ685RUvSso
         S8DA==
X-Gm-Message-State: AOJu0YwVr0ce2moU+nG40P80FQTt1IOAQDUNy8d4ZNUzZjBuk95/yaWO
	wKcPm4qKnKy6iNXAf65DK822xg==
X-Google-Smtp-Source: AGHT+IGsmxOsUGE9snSXULCnRvVDNBhJyXaKk8scRK0yQUR5n8RK/MswQvHnoZAtImXxa04qRm6W8w==
X-Received: by 2002:a05:6512:2821:b0:50b:c0f1:f532 with SMTP id cf33-20020a056512282100b0050bc0f1f532mr1883101lfb.26.1702161460954;
        Sat, 09 Dec 2023 14:37:40 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050c0c46e1desm634885lfb.33.2023.12.09.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:37:40 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 09 Dec 2023 23:37:34 +0100
Subject: [PATCH net-next 1/2] net: dsa: realtek: Rename bogus RTL8368S
 variable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Rename the register name to RTL8366RB instead of the bogus
RTL8368S (internal product name?)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index b39b719a5b8f..887afd1392cb 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -117,10 +117,11 @@
 	RTL8366RB_STP_STATE((port), RTL8366RB_STP_MASK)
 
 /* CPU port control reg */
-#define RTL8368RB_CPU_CTRL_REG		0x0061
-#define RTL8368RB_CPU_PORTS_MSK		0x00FF
+#define RTL8366RB_CPU_CTRL_REG		0x0061
+#define RTL8366RB_CPU_PORTS_MSK		0x00FF
 /* Disables inserting custom tag length/type 0x8899 */
-#define RTL8368RB_CPU_NO_TAG		BIT(15)
+#define RTL8366RB_CPU_NO_TAG		BIT(15)
+#define RTL8366RB_CPU_TAG_SIZE		4
 
 #define RTL8366RB_SMAR0			0x0070 /* bits 0..15 */
 #define RTL8366RB_SMAR1			0x0071 /* bits 16..31 */
@@ -912,10 +913,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 
 	/* Enable CPU port with custom DSA tag 8899.
 	 *
-	 * If you set RTL8368RB_CPU_NO_TAG (bit 15) in this registers
+	 * If you set RTL8366RB_CPU_NO_TAG (bit 15) in this register
 	 * the custom tag is turned off.
 	 */
-	ret = regmap_update_bits(priv->map, RTL8368RB_CPU_CTRL_REG,
+	ret = regmap_update_bits(priv->map, RTL8366RB_CPU_CTRL_REG,
 				 0xFFFF,
 				 BIT(priv->cpu_port));
 	if (ret)

-- 
2.34.1



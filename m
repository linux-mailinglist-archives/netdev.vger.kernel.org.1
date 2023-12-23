Return-Path: <netdev+bounces-60000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08281D0E0
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD10E1C2208A
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64F396;
	Sat, 23 Dec 2023 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOnb9ZYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD6138F
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ea5cc137so19348705ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292837; x=1703897637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nerlDTKUxvNS4EQ5OGYXJvHQx6u0E/QclFP8VvibvO4=;
        b=QOnb9ZYQnyo2Mgwz5SgRvMrrgKhCpmlReUBHxnH3oJi+wrqGrrIQTwq+9emFPXiqNO
         wmc+veGCKecGPGTs5lhSLUz01V08hmweamdBAmD7IEE3BoGpNBkpSaX5phTNNtDc8CYU
         TwAmrRG+AQ/mbA+v2p8UFtw15gUtHZCJVXMfSJFYbg2Zl20mANTHS35uft64c99+MWSy
         LIi7nSaIBcARmVHMEHDHlTA60pnYFpXSa+r7QGNvnMLH4EmyeuV6Gw4xH2FBrHJ7OYzo
         bhh9Fowb2Tf9YlPyCnGJaFLlRqcjy5h18JJjq7LGEqSUteD6LFgZjya47MhSx0vDSzJa
         +kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292837; x=1703897637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nerlDTKUxvNS4EQ5OGYXJvHQx6u0E/QclFP8VvibvO4=;
        b=JHK1p8tz9r8voV/qyYvqJwzsoCEXdN6NyCnSzShwTQdL93Y7c2eg7xg/1KXKMb3GRW
         eu2fqPK/j95X2e2h2JJyK+SIZ/nJmt5oT0T/ehqBtNms4HML3cr5pEt+i0HEvRnOusei
         wnrFaUfLSAabCUAiSjRKZX7exPlGk/2NzZxLmWK2cF9Roc1/WtR7Q/4LmEeJdZrnIWWL
         pjH656hIoystAeiMntBwpdCKK3+f809GhWdSI6o9zEFP7J5x2OYHO1YTaNspDNAU8fvv
         kVZ7bxMKKhK/nAtkf4YIzW+MPdLOebK0sU8yCg6ZLWCJ6AcgKv6oi2ynquM1Ag+/vI6x
         IeTw==
X-Gm-Message-State: AOJu0YzQG7fIxaIiLbqmTSaR//4IQwNCQOPeEmMBDhjBbI8DPijM58h/
	FBGex15AWwjxCPpeVke3rxazSEGeugcUZSnV
X-Google-Smtp-Source: AGHT+IGdktcQPEesPBCE3YFw2OZQFF0Hxv/wQWygw4GMAbqtQTB+y3sbcUYm90a95DFK/Dg4NuVkTA==
X-Received: by 2002:a17:902:da91:b0:1d0:737d:2ae5 with SMTP id j17-20020a170902da9100b001d0737d2ae5mr2133145plx.87.1703292837663;
        Fri, 22 Dec 2023 16:53:57 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:53:57 -0800 (PST)
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
Subject: [PATCH net-next v3 5/8] net: dsa: realtek: get internal MDIO node by name
Date: Fri, 22 Dec 2023 21:46:33 -0300
Message-ID: <20231223005253.17891-6-luizluca@gmail.com>
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

The binding docs requires for SMI-connected devices that the switch
must have a child node named "mdio" and with a compatible string of
"realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
docs only requires a child node named "mdio".

This patch changes the driver to use the common denominator for both
interfaces, looking for the MDIO node by name, ignoring the compatible
string.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 2b2c6e34bae5..9100b583ddc5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -360,7 +360,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	struct device_node *mdio_np;
 	int ret;
 
-	mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
 		dev_err(priv->dev, "no MDIO bus node\n");
 		return -ENODEV;
-- 
2.43.0



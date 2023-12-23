Return-Path: <netdev+bounces-59996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17B81D0DC
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DF1F23231
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB581E;
	Sat, 23 Dec 2023 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/MU0urZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B27814
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35fc16720f9so9677055ab.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292822; x=1703897622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkQPjZQ33Ljgmtvt2fEErV/4qrSCqWyMlDz/GEXX2eY=;
        b=c/MU0urZfaY1Bt36ZPRXwKVeYQeY0YaHP4BlfzakxZoxVYiTd3umGz1z6byr1vnBoh
         6nIYUcgDWj3OdR3KPH6tk40b7g85uJa/j2YoBevXaZxModoHP3A2ZM5+aGdGITe9vDGT
         mA25i1K30s2YhMfK2cI4ZmGtUy/bxvTWDzNr3raHnkLDX6cnjwp4xt0utnPgHKwXCyAM
         mbYENR9A2FERUrRRguceZ6EZ8y1y+QhY9UcmXziQZhC9S7kjDXYl0x6wV9KopFk5l4ya
         l8zAEO1MMFfTV7ecd7v/qBj8YuG4ihMZcTostRZhfIh1s4OddupJf/8zDa21l+fHasl5
         nbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292822; x=1703897622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkQPjZQ33Ljgmtvt2fEErV/4qrSCqWyMlDz/GEXX2eY=;
        b=Hs6V1mJ+feFzbUKYKpwx998rPHSSyqyK0+BwzQZG3mPkPK732rlLnVMNe5cj1DYUdF
         vgOXN0CnUuHdFwsNnT1DeEOIaFTxnPNAzdaEeBBTHBBjA/GrOxpnt2Iqy3TF8JFyEGZQ
         ap7vzobMf6XXIb2bAv7f2fWZ4ULmZtzom5XW/A9f6+U1juIeZTQI3UmrcHIgsskD6zir
         FAbEwhqrsgs3IceoMZmt6tIKvjRRmvPJHrPoEf8UlNkNQV+5zRUUi3knhXstQUq4y1ca
         olUbhRue83FNpK9dPVl6/bYLGI8Gi/8Hpa81uaNy15hvcXFxNtcBqqxbooGXSKoCb3fs
         XVYw==
X-Gm-Message-State: AOJu0Yw6Rv23QovdF2/cxrDP9i6J03ju+cJrWFWD0L4C7Xtr3XZnPdCE
	biCrKHEHnPoc2He3zyNYAJtBcWv3w0cFOV3l
X-Google-Smtp-Source: AGHT+IGwZl/9kMsMBnTipJExcedW4HS9naA1bXvW93AN9VXo/SVAvp9XZbRAF4WwNBPa23t3ForVVQ==
X-Received: by 2002:a05:6e02:1d91:b0:35f:d8aa:6e9c with SMTP id h17-20020a056e021d9100b0035fd8aa6e9cmr3087033ila.22.1703292821951;
        Fri, 22 Dec 2023 16:53:41 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:53:41 -0800 (PST)
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
Subject: [PATCH net-next v3 1/8] net: dsa: realtek: drop cleanup from realtek_ops
Date: Fri, 22 Dec 2023 21:46:29 -0300
Message-ID: <20231223005253.17891-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>
References: <20231223005253.17891-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,
-- 
2.43.0



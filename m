Return-Path: <netdev+bounces-48745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA737EF678
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9004F1C20862
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303B3C48B;
	Fri, 17 Nov 2023 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="f37EjEfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C481D4B
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d9effe314so1539831f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700239495; x=1700844295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ctuwvPDSa9uZCOLTfAErk4+6RVQpToW66kimL2TEOU=;
        b=f37EjEfkE2wE5wUT9b42TZ3b4S5lw9tQqiI9n/Qdsq4nkhdUGrZ8+GZLO75m/prkvb
         2GOOFipeStAbRuqyTH3opTZZw4UXkuLhCYdDApddyeOofgYiA9k/p7S6b8caHxv2SH1N
         yXBff1U+AOcNsLF0K0bCHtUHBDe+3FJfxh9DjoB1LzZeQqRkuh8o3pu6lJEAcRGbBPgM
         pg48sJISzmAHtNO2orwmrb4MyHUREvv3fdtEQ/rjr5YzeH9c41rtzrUrocOB/VHif53H
         akOB79NDJaS2Wwg/xNLwte6xYBYcwsMayReT0G4ZxlU+wqA6rAw49t/9sJc42KafWlF6
         WDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239495; x=1700844295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ctuwvPDSa9uZCOLTfAErk4+6RVQpToW66kimL2TEOU=;
        b=tY7qOvfooSzqw0+7eUgUIxlOGxNS6FhSHBHkL6eFzH5rXbJEHwPTv71TCSMQjzT1k0
         HnQKBWS/A4NFm0vsOnLxz+LxheKpDnC1FTHLl7yUnCch5l2v1wJfjq09ZwW0z4oZ2tIg
         7ldbcQzsl+/x6gJZTNktXVksn8CNtbuR8jFBOFKdeNULRzCACFovBdo1+w3fe8vt//Zf
         hxNdvcH0MzNh+lTulAs2rdhp9jXgzriDooxegixLsuCHz3LrB/YRZFPAeJKs4nMbx3Jt
         w3rPcv6l+sGFiq/gY5sk1L56shgbOR37fmyKFFp8FAf0JrKZy2KeohzY3a0cUwMRoEjx
         uudA==
X-Gm-Message-State: AOJu0YyLm3h50cbrraMYgGAsx3qgxpFyVNy54qvvbQVyla9ebjERilhq
	ALL6s0sWYQucIN3uWR6nGQzNfg==
X-Google-Smtp-Source: AGHT+IEki3Odc/z/NMe7thygFDWVaCnOECdby64FFzQDj/s/3i2E+SLxm5CPlx0cuO47pXuLEZtQgw==
X-Received: by 2002:a5d:548f:0:b0:32f:88e8:b8d1 with SMTP id h15-20020a5d548f000000b0032f88e8b8d1mr12969140wrv.13.1700239494955;
        Fri, 17 Nov 2023 08:44:54 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm2791947wrn.60.2023.11.17.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:44:54 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 2/5] net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
Date: Fri, 17 Nov 2023 17:43:29 +0100
Message-ID: <20231117164332.354443-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of printing a warning and proceeding with an unknown register
layout return an error. The only call site is already prepared to
propagate the error.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
index c007e33c47e1..443ca5a18703 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
@@ -130,23 +130,30 @@ static struct ptp_clock_info rcar_gen4_ptp_info = {
 	.enable = rcar_gen4_ptp_enable,
 };
 
-static void rcar_gen4_ptp_set_offs(struct rcar_gen4_ptp_private *ptp_priv,
-				   enum rcar_gen4_ptp_reg_layout layout)
+static int rcar_gen4_ptp_set_offs(struct rcar_gen4_ptp_private *ptp_priv,
+				  enum rcar_gen4_ptp_reg_layout layout)
 {
-	WARN_ON(layout != RCAR_GEN4_PTP_REG_LAYOUT_S4);
+	if (layout != RCAR_GEN4_PTP_REG_LAYOUT_S4)
+		return -EINVAL;
 
 	ptp_priv->offs = &s4_offs;
+
+	return 0;
 }
 
 int rcar_gen4_ptp_register(struct rcar_gen4_ptp_private *ptp_priv,
 			   enum rcar_gen4_ptp_reg_layout layout, u32 clock)
 {
+	int ret;
+
 	if (ptp_priv->initialized)
 		return 0;
 
 	spin_lock_init(&ptp_priv->lock);
 
-	rcar_gen4_ptp_set_offs(ptp_priv, layout);
+	ret = rcar_gen4_ptp_set_offs(ptp_priv, layout);
+	if (ret)
+		return ret;
 
 	ptp_priv->default_addend = clock;
 	iowrite32(ptp_priv->default_addend, ptp_priv->addr + ptp_priv->offs->increment);
-- 
2.42.1



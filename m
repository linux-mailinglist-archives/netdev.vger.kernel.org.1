Return-Path: <netdev+bounces-48746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89D7EF67A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA1BB203C9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62814177B;
	Fri, 17 Nov 2023 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="ozSvtk17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA37D5E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f70391608so1321392f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700239496; x=1700844296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhPeJT65e+HlTL4GEJcknvOqJIOmP+OVNMnytUlHsfE=;
        b=ozSvtk17xBLXkMfBwC2qyJJk0GVjTJmr0wWomvIaoviYcwg8IlJ11FZOX6ZtP10K7q
         gXOC34Y62Y88RPBuNhazpUNJ2EVKID9Q/Y2gt1bs7eV2vzNtlzW0/ngh9IhSq+KtoOCj
         +2w92g0vDdbTwvy+8hSU1YB1WXHO8X9BX87+h7rb93swmBHeRvTfQmh/x2077IfT+OWs
         6c9GMyqOokObymXWRF+aBAgFEPROMRm3mlvq3OOiufeWnuxRzhvLR+5nqai3pXwZEbpH
         xI9sWaDU91kccDDKaHN98rUdxWCiTiCSz0TLDds+DsAOKQir/iW1eS5ZwB6Xo1aMnpd7
         TmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239496; x=1700844296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhPeJT65e+HlTL4GEJcknvOqJIOmP+OVNMnytUlHsfE=;
        b=tK9Ft7wsFMx72TL4uSQAXe/m03OgAsdCu9eHv+h5JOzJiPqcAAhVtj+Rwz0iUuiswq
         MXuxhJ74i7epx4248N6m/pgxD6UbDvuee1OqDyHYIRNe8PBUJfJH7qrtUY0YGg2rGZBC
         EAyc2ABviKtz/Gs/TDUi9gD0MHls+tu5hbPkz3PPPxIE9ukEy6cVrb1PIVdzU11ZDO4L
         pHHjOHErVVkdsXSLYK+xGIYGvaMpt+vB9/Cmu1ubcPQTE22To/NGRNRNS90v99VJoz3R
         2FSpFLZFn+u/FjYsI7fmowxvhSeO24WjPdoyhUWXmsoAL9bROxMUrcM48S5irIzlrtb2
         TD3g==
X-Gm-Message-State: AOJu0YzRLj3dmeh2JhiEyIJlnGf6K5mqUOytJlF9vqgQH8O2BHjV83Q6
	rWTx2KWIGRyDWjvMljSdfs2wCA==
X-Google-Smtp-Source: AGHT+IG4Fo+rQkLIhotw1LTO6yBVUGA+K8V4fgVejBF7yALbeqscuO6QEm4badwj2b9vcfPRno2sDQ==
X-Received: by 2002:a05:6000:1a8f:b0:319:8a66:f695 with SMTP id f15-20020a0560001a8f00b003198a66f695mr18194190wry.55.1700239495876;
        Fri, 17 Nov 2023 08:44:55 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm2791947wrn.60.2023.11.17.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:44:55 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 3/5] net: ethernet: renesas: rcar_gen4_ptp: Prepare for shared register layout
Date: Fri, 17 Nov 2023 17:43:30 +0100
Message-ID: <20231117164332.354443-4-niklas.soderlund+renesas@ragnatech.se>
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

All know R-Car Gen4 SoC share the same register layout, rename the R-Car
S4 specific identifiers so they can be shared with the upcoming R-Car
V4H support.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 6 +++---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h | 4 ++--
 drivers/net/ethernet/renesas/rswitch.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
index 443ca5a18703..59f6351e9ae9 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
@@ -14,7 +14,7 @@
 #include "rcar_gen4_ptp.h"
 #define ptp_to_priv(ptp)	container_of(ptp, struct rcar_gen4_ptp_private, info)
 
-static const struct rcar_gen4_ptp_reg_offset s4_offs = {
+static const struct rcar_gen4_ptp_reg_offset gen4_offs = {
 	.enable = PTPTMEC,
 	.disable = PTPTMDC,
 	.increment = PTPTIVC0,
@@ -133,10 +133,10 @@ static struct ptp_clock_info rcar_gen4_ptp_info = {
 static int rcar_gen4_ptp_set_offs(struct rcar_gen4_ptp_private *ptp_priv,
 				  enum rcar_gen4_ptp_reg_layout layout)
 {
-	if (layout != RCAR_GEN4_PTP_REG_LAYOUT_S4)
+	if (layout != RCAR_GEN4_PTP_REG_LAYOUT)
 		return -EINVAL;
 
-	ptp_priv->offs = &s4_offs;
+	ptp_priv->offs = &gen4_offs;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
index 9f148110df66..35664d1dc472 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
@@ -14,7 +14,7 @@
 #define RCAR_GEN4_GPTP_OFFSET_S4	0x00018000
 
 enum rcar_gen4_ptp_reg_layout {
-	RCAR_GEN4_PTP_REG_LAYOUT_S4
+	RCAR_GEN4_PTP_REG_LAYOUT
 };
 
 /* driver's definitions */
@@ -27,7 +27,7 @@ enum rcar_gen4_ptp_reg_layout {
 
 #define PTPRO				0
 
-enum rcar_gen4_ptp_reg_s4 {
+enum rcar_gen4_ptp_reg {
 	PTPTMEC		= PTPRO + 0x0010,
 	PTPTMDC		= PTPRO + 0x0014,
 	PTPTIVC0	= PTPRO + 0x0020,
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 43a7795d6591..e1e29a2caf22 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1828,7 +1828,7 @@ static int rswitch_init(struct rswitch_private *priv)
 
 	rswitch_fwd_init(priv);
 
-	err = rcar_gen4_ptp_register(priv->ptp_priv, RCAR_GEN4_PTP_REG_LAYOUT_S4,
+	err = rcar_gen4_ptp_register(priv->ptp_priv, RCAR_GEN4_PTP_REG_LAYOUT,
 				     RCAR_GEN4_PTP_CLOCK_S4);
 	if (err < 0)
 		goto err_ptp_register;
-- 
2.42.1



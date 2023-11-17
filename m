Return-Path: <netdev+bounces-48747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D486E7EF67C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EFE1C20A72
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E84314B;
	Fri, 17 Nov 2023 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="aSgYT9J5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB58D73
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a55302e0so3298649e87.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700239497; x=1700844297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdcFTkjJJKdk2tWc8kj9ugAu+k+ZjoJk+1mRNKldi1E=;
        b=aSgYT9J5L7HzzuU/AEnOMWA1dxngjgQZBZjqEk8QZr9YVQsZahtX1h/xhYmlCSIb0z
         uhDupq+nnQaLTVQ/FSaWJwBW+zFoVGb2QDQMsx0Mb4XyqNZmJ5ggW0hy4NF9cxidZdi3
         3iodB/uDpVriWXQWVPgylIpjNou+c/+kCnazVXtRuo/vnHbFslVdk/6yEarpGPJSkJSt
         DYcM7IdqhKAI3znLiUF4JWBPpFX8gquHS4AGeVzLo3QfmFJ0L7NqUfoHQo7GZTCIEpDP
         p6rp0pGxGxVLeMbjjLTfsFeh8kVO8fCA80l7BTlMaKPsPA75Kl0BJWiEb2+k9aRQy6t3
         KA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239497; x=1700844297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdcFTkjJJKdk2tWc8kj9ugAu+k+ZjoJk+1mRNKldi1E=;
        b=qwxhsXoKRwraQJn3hTt1pqkP9ARkiEVQ4ctmEfROFSOLORmrFFZYzxmVpRDq7PoYxI
         90pfPXiBIGVdVajMbZkQ35e1OQu77daTRjPzDOduqZv9mr4NoRfEQGFZ03PlR1963w67
         EFQTx7yhD/5bwiyZxouq4IC3mHjj7l/gxDWuHqdbs84zHS2q2nA7v71Rtpwp0rJlia2P
         JQzV6xbjevkBcTr7CoEkhPio8G3V4OmuCMzm5hOgtc2choWPO0BzxE1Y4MynTmAh/7VP
         QvQxC/p1GiQdcsZRZT6w3hMqNIJ/36hK5SJcLrit653XYGWQ10duAASxXBgEXreme1/B
         HNqQ==
X-Gm-Message-State: AOJu0YwYqYAcBmU1kml3EOnaxrJ4arGvCniBFJ7qeEH2NTkgnviZJ0Wl
	rf235ZNd2+SvS4NyUfjn+jxvZg==
X-Google-Smtp-Source: AGHT+IElGFJq6FDin3q1ZNiLN21lTleD22/7v7lYF9GaOGz9+SBbC/qO6c8vYYQwfr8nmi5zNRCp4g==
X-Received: by 2002:a05:6512:358f:b0:502:a4f4:ced9 with SMTP id m15-20020a056512358f00b00502a4f4ced9mr52784lfr.62.1700239496893;
        Fri, 17 Nov 2023 08:44:56 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm2791947wrn.60.2023.11.17.08.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:44:56 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H clock setting
Date: Fri, 17 Nov 2023 17:43:31 +0100
Message-ID: <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
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

The gPTP clock is different between R-Car S4 and R-Car V4H. In
preparation of adding R-Car V4H support define the clock setting.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
index 35664d1dc472..b83a209e9845 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
@@ -9,8 +9,12 @@
 
 #include <linux/ptp_clock_kernel.h>
 
-#define PTPTIVC_INIT			0x19000000	/* 320MHz */
-#define RCAR_GEN4_PTP_CLOCK_S4		PTPTIVC_INIT
+#define PTPTIVC_INIT_200MHZ		0x28000000	/* 200MHz */
+#define PTPTIVC_INIT_320MHZ		0x19000000	/* 320MHz */
+
+#define RCAR_GEN4_PTP_CLOCK_S4		PTPTIVC_INIT_320MHZ
+#define RCAR_GEN4_PTP_CLOCK_V4H		PTPTIVC_INIT_200MHZ
+
 #define RCAR_GEN4_GPTP_OFFSET_S4	0x00018000
 
 enum rcar_gen4_ptp_reg_layout {
-- 
2.42.1



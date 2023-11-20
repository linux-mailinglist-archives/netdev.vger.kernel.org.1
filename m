Return-Path: <netdev+bounces-49287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAE7F1817
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9234281621
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB51DDEE;
	Mon, 20 Nov 2023 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="n9+wGFoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750A112
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-407da05f05aso15360505e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700496207; x=1701101007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCuKJJPaD5V6lLtWPkXeck252UXqGAE7uAoQWOQcy7A=;
        b=n9+wGFoaq07UZl2jBer0LJnA6GzNJVhYdLs8c/ckH65Fbpu4Q8g9JClHRPv0dlovOu
         4RT7vl159hknqDpa+2yiK6a5GY1ijEWkkYXz0wdj/VpwN+IgtxtqpZ8tl9LD8ePuuGAR
         y6tum0Pq2HgJ2VocCiKuVBW1ZTUA6M2UF7o3BqXNx71O6y+BP5Tqi5QdH7CzWkdjmVHe
         s9sINtPnjh/SFoQ7Kynni91EFiLP79rOZxS/rUUubsiszcJU/ht1/McpCO8yFPEGHwyN
         hBNgdJDIYDCSRk8S6ZcPPcQhJMF9f6vkRGCs9RcNtTIQJr6MK1uv7RELMMPPwTv4uqGN
         nNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496207; x=1701101007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCuKJJPaD5V6lLtWPkXeck252UXqGAE7uAoQWOQcy7A=;
        b=gMxVIJgWF56pqybL+gbip6RNFOdeVBDPuhN90n8RB9wI9utTh5hqY9obYjcPyiIZYp
         /H/ehC3Zo0vj+0GwanWb/yvDbZtHbjiCPPku6I1RbU/Y+HHts/FGarq4AoHRF62VHhIt
         nv8sXOKOf58h0oLtfNCFUcxbLwWY+ZfnXpqbWTx3VQLTVQwFAPoIxuZq0dqLz0pNUCSZ
         h/tHmue1WNnnlaxI+oSyF764Fufr/v1TSR48ILayTJ16TR+YxsadwRDIC8GHfV9gqUZM
         2jFcGJYOzEgLcDwimkJZG99zP2v8X6n7ldSezckJU+zu29FOBiRlhoGDCcTYEJHS7XkX
         cE9A==
X-Gm-Message-State: AOJu0YyWFu/QwqyDDXKpi1KFCFJPbFT/70m3+YugA45byqc9MuNXbY7T
	OYhE448zrglis1ZRE1OTf3ZlNw==
X-Google-Smtp-Source: AGHT+IGrIn6cydY9Wp9P9eVUO8ONV3ded3Cd20aFLroq7J4ObGAvD/0N6ml7GMMx+5YPZ3v/3kn5Dg==
X-Received: by 2002:a05:600c:4507:b0:401:daf2:2735 with SMTP id t7-20020a05600c450700b00401daf22735mr5802675wmo.31.1700496207198;
        Mon, 20 Nov 2023 08:03:27 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id m21-20020a7bce15000000b004080f0376a0sm13564631wmc.42.2023.11.20.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:03:26 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [net-next v2 1/5] net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
Date: Mon, 20 Nov 2023 17:01:14 +0100
Message-ID: <20231120160118.3524309-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se>
References: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The comments intent was to indicates which function uses the enum. While
upstreaming rcar_gen4_ptp the function was renamed but this comment was
left with the old function name.

Instead of correcting the comment remove it, it adds little value.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
* Changes since v1
- Added review tag from Wolfram.
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
index b1bbea8d3a52..9f148110df66 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
@@ -13,7 +13,6 @@
 #define RCAR_GEN4_PTP_CLOCK_S4		PTPTIVC_INIT
 #define RCAR_GEN4_GPTP_OFFSET_S4	0x00018000
 
-/* for rcar_gen4_ptp_init */
 enum rcar_gen4_ptp_reg_layout {
 	RCAR_GEN4_PTP_REG_LAYOUT_S4
 };
-- 
2.42.1



Return-Path: <netdev+bounces-49712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1437F32CA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288A21F21F8E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDC5914C;
	Tue, 21 Nov 2023 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="EQ44AVlW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC110C3
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 07:53:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ffef4b2741so261563666b.3
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700582021; x=1701186821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1tQAoZQgFgk25StX3LmmkNTA/AsMdJ3cDJnMXgpoTs=;
        b=EQ44AVlWEDNDtvv5ZEW0jCNyoJ5kpEbzgPLOy1Kyhly7Xgx1areiZxUEQ3JOH275AD
         5JYU1I185m9f3stMCm/bI5OoMnnAmA/IBWhscSJPufc5V+/t8txzxKN4iwurdEU+F/Er
         Ys6I0GjJPV665eK70NEzyn2zre4ZJJ0VPOObk07Ga5H4QwjX4nwwD1pMPnwZG3PhcNOP
         u7+Pm1/TI7/35FD+H5SpcfCaq5Lsuh0ADVKrNxQtIv2/gd1/S8EgyYnbgULwx7y+IA/0
         E2HTIynIDma9vkuWgvBwfdPP4ET/0oiFZUe3+VOfCWWvgzFtL0zvoGIBZ4SF7uR7x0+V
         JyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582021; x=1701186821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1tQAoZQgFgk25StX3LmmkNTA/AsMdJ3cDJnMXgpoTs=;
        b=QvAVT+SrwH4eF74sd/fYG2YqZ+3L9a/TKJbFmm9bYZ38AK1AfSJn904pu+GihP6k3i
         IZh4yrmCBNyYQfzRaJQTTEzMkW64Wmg3IwLQDWT0Sh0UxLf2EteWQpKhhDtn5gVdU3kL
         TQdna6oaEFxFuFpx5Uq10l1TEr6v+pBI6boI1viUWSoyVwinTJst5+eFeS/ia0+kIhKs
         +cf6edtTx7ytWgohDaMxSH6dUFm3yI3nBWZ1dDvyHl8PV4ATByD5FafgxG0YFiZfnTYY
         g2UmrUsAvHGZ1iqxU+pwRes1eo8o/iRyKRGNO/OPS1ZcaUaQMLI7t/2tkCYBGIh/OWlf
         kKJg==
X-Gm-Message-State: AOJu0Yyu6u3LnonY4+tuRPgV8g2shqWg2wtDRhylVia4HMVqlVbS1yj2
	hNCfZl//Cfme3fOsuzIM4ZaxIw==
X-Google-Smtp-Source: AGHT+IFumWJ3TPYOouLLfqM3uX8s7lAMI5kBa/WG6pmf3sp5L5nbdO83bWwAKC3hRbCzYR9rGum/Zg==
X-Received: by 2002:a17:907:c007:b0:9d3:f436:61e5 with SMTP id ss7-20020a170907c00700b009d3f43661e5mr10541291ejc.29.1700582021271;
        Tue, 21 Nov 2023 07:53:41 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id dv8-20020a170906b80800b009fdc15b5304sm2896853ejb.102.2023.11.21.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:53:40 -0800 (PST)
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
Subject: [net-next v3 1/5] net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
Date: Tue, 21 Nov 2023 16:53:02 +0100
Message-ID: <20231121155306.515446-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121155306.515446-1-niklas.soderlund+renesas@ragnatech.se>
References: <20231121155306.515446-1-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v2
- No change.

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



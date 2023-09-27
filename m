Return-Path: <netdev+bounces-36530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953577B04B1
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 48782282AE2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54528DC9;
	Wed, 27 Sep 2023 12:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5928691
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:53:45 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FFC0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:53:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405524e6740so90212325e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695819222; x=1696424022; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7knE2DJnO/01VXS48rrS/2ecXZAzLdWcWdPE/le5Z0=;
        b=J+40QJuLz12IfxPJcHJCTTPZyuIlYmg/RkDCQtxnVaYsUu8wSd2dQJ8nKOIsi7pxNs
         KeMzCRiJA1BTb8Kx0QSAxmtQ6RMAV34QbWuetGcqQjfLB5NX1hXyYP+ipsQna3pfYaDj
         elLzjJB80p404Dv1Wht0BO7UxR9lFXsn9ywHFUwAZvmbBBhfShkBnjCrp8sUDM5v3ZhX
         5d/PXhFek1CxsHG/AIfve8+fHfrhjTi73SM4DQ5BpAGaqUMOBv7eNhMTvpYWhdvdry+R
         MGzA74/wjK/PNSlNdbULiTQmkq8GJI5sAyUt+kUx7XCFeEM2Q3eY9FIVNtEZIdOfqtGq
         8LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819222; x=1696424022;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7knE2DJnO/01VXS48rrS/2ecXZAzLdWcWdPE/le5Z0=;
        b=CpI77YKV+xldRQ7iXlEgB6bAGP9NXaEAEYOxzVNO0ejEgRTjyzl/aCl6RjyGvzagfm
         LE/irfT24k2+OVCsg3DjXYaOvihz371OW33medbwmkCj45i37HbVFBykZg2kb0Nu6NKF
         dhIoh+PPt+8aGcF13JRYJIkCyNclWrdo2pNhEynppxsGcUTgldCFEAoJDI7JyTyhILIa
         N9nnZsgFzcu6p2RavAli4jsmWeordgjAls493HJSJCIFtQnrGdNzF+sL6Gyb26gVhKuY
         KwNEsPZvhVDsN+mYOEWI0M7zqQyoSPVUlAEPax01MYWyKbnBmLA1qI+euwizywqphyoq
         bQ/A==
X-Gm-Message-State: AOJu0YxcUtNVzEBOPS/HaNnbCpewOWeZiq3gF5SX93EBd86mtOsmcNRT
	L1qvELLIvD3BRa5qFArp0pL/8w==
X-Google-Smtp-Source: AGHT+IGuIOSGq+NeSzXDAzXG2TWDzvJQwcmOFs7bPvR88jZd54ASK0IqYI/r9YlF2jqY+p5yPplTUg==
X-Received: by 2002:a05:600c:240a:b0:402:e6a2:c8c7 with SMTP id 10-20020a05600c240a00b00402e6a2c8c7mr1829982wmp.7.1695819221783;
        Wed, 27 Sep 2023 05:53:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u11-20020a7bc04b000000b003fee6e170f9sm17442529wmc.45.2023.09.27.05.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:53:41 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:53:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: dsa: microchip: Uninitialized variable in
 ksz9477_acl_move_entries()
Message-ID: <2f58ca9a-9ac5-460a-98a4-aa8304f2348a@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Smatch complains that if "src_idx" equals "dst_idx" then
ksz9477_validate_and_get_src_count() doesn't initialized "src_count".
Set it to zero for this situation.

Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ksz9477 switches")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/dsa/microchip/ksz9477_acl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/microchip/ksz9477_acl.c
index 06d74c19eb94..e554cd4a024b 100644
--- a/drivers/net/dsa/microchip/ksz9477_acl.c
+++ b/drivers/net/dsa/microchip/ksz9477_acl.c
@@ -554,7 +554,8 @@ static int ksz9477_acl_move_entries(struct ksz_device *dev, int port,
 	struct ksz9477_acl_entry buffer[KSZ9477_ACL_MAX_ENTRIES];
 	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
 	struct ksz9477_acl_entries *acles = &acl->acles;
-	int src_count, ret, dst_count;
+	int ret, dst_count;
+	int src_count = 0;
 
 	ret = ksz9477_validate_and_get_src_count(dev, port, src_idx, dst_idx,
 						 &src_count, &dst_count);
-- 
2.39.2



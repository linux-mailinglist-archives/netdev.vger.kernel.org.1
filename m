Return-Path: <netdev+bounces-40976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A596B7C93E4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45AD282B2B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459EFBE42;
	Sat, 14 Oct 2023 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNgf+cZ2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE010781
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 09:30:36 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D20CF;
	Sat, 14 Oct 2023 02:30:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d569e73acso2623937f8f.1;
        Sat, 14 Oct 2023 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697275831; x=1697880631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=jNgf+cZ2b3PzrOJdmUcMRYCiTaEQ4UvvU/wqx+0p7vn/FhGwBwK/pLpgY9B+r7aoOl
         r1RLgxN8tO7AdBzeCJKcoYzsTE7aUy+ITPB5E5wE47zMw4rP1dVEfnDFo4A7xnVRQ+L2
         SgUMm0k6ktXLC1NZGhu8G9TtyAim+LOfOxaf1FzyIao4W4RcabqQ3Pm7Pdetymdy1yog
         q6cAhf92iKnAcG8IZzYTZ3ZzQ9QGxfLY/46aG6HKeBlzRzWKPsBeQVjBsi2m60A5QW+K
         bOj0CFFIRi9UffUU1uVcF1Uy1un8+Re5s2Ni3nhwEzrDEq56Z/euz+8KQjcZBn+/5PQg
         jiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697275831; x=1697880631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=dH8jvzEmKrQw6d08FwRQOBgtlRtLPxslcP9zhJyL8uSEDj/Q56G+PgtHGrI0ticUTq
         Hu3vjK58ldqSo47/YqRbRMOfzCg7WQvKiwe3RzCw+znePvPJ+RivO3BDwcgK7p4AcwXE
         i05e7D4LcWFApc3EV6ZtrcIw/1WuY7Cq5yWU2RpUtmqKtJA0JBO/J1O1T/sIjgsfil1O
         n5/9oaST82OkCvGbR5wgMB/pBeSCtaEnRCVIlGi6Jgdq4RIQdXP58Kpa910Bicw6Dyd1
         lXw+O0Wxgdft+x9G6wYyJf5pWS8VV7G1/X7OTuNa+wtlrb2923doWTVJk+tSYTHpSLZs
         DxZQ==
X-Gm-Message-State: AOJu0Yx7g9YCQhW4wzCDcZAFCIQo2qbmlTW5eGp7zSQrPXOFPWlNHH0S
	nA5eeq6ZKPWp39Esyzow9yw=
X-Google-Smtp-Source: AGHT+IFpFx9x4EPEvCFdXGS/SpNKLQq7KRgOHBLFfKy+KqvZNLFbEiecbXCUkuM9Sz82toMeuJ08jw==
X-Received: by 2002:adf:f084:0:b0:314:a3f:9c08 with SMTP id n4-20020adff084000000b003140a3f9c08mr24141801wro.39.1697275831283;
        Sat, 14 Oct 2023 02:30:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u12-20020adff88c000000b0032d9a1f2ec3sm3691564wrp.27.2023.10.14.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:30:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Raju Rangoju <rajur@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 4/4] net: stmmac: increase TX coalesce timer to 5ms
Date: Sat, 14 Oct 2023 11:29:54 +0200
Message-Id: <20231014092954.1850-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231014092954.1850-1-ansuelsmth@gmail.com>
References: <20231014092954.1850-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.

This caused some performance regression on some target (regression was
reported at least on ipq806x) in the order of 600mbps dropping from
gigabit handling to only 200mbps.

The problem was identified in the TX timer getting armed too much time.
While this was fixed and improved in another commit, performance can be
improved even further by increasing the timer delay a bit moving from
1ms to 5ms.

The value is a good balance between battery saving by prevending too
much interrupt to be generated and permitting good performance for
internet oriented devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1e996c29043d..e3f650e88f82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -293,7 +293,7 @@ struct stmmac_safety_stats {
 #define MIN_DMA_RIWT		0x10
 #define DEF_DMA_RIWT		0xa0
 /* Tx coalesce parameters */
-#define STMMAC_COAL_TX_TIMER	1000
+#define STMMAC_COAL_TX_TIMER	5000
 #define STMMAC_MAX_COAL_TX_TICK	100000
 #define STMMAC_TX_MAX_FRAMES	256
 #define STMMAC_TX_FRAMES	25
-- 
2.40.1



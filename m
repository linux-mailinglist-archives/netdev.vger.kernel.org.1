Return-Path: <netdev+bounces-112726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6C93ADB5
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8894A1C20B00
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BA4D5A2;
	Wed, 24 Jul 2024 08:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6942AAB;
	Wed, 24 Jul 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808344; cv=none; b=cE+SWcNvzKt0dTrr5kFqttbzGCMThAyOTPfynrvMrss0UTvDAuRoTtGp26+gCI2khVMamtIZKazsbnzSwuJH+nX+sTv30yZM3Dvlvmb6Pe8OunAwC1galSqWkhA3b28Ff9jvObMwbvevYoTB84GaEcYWLhhbeAbhv7iCXzbVgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808344; c=relaxed/simple;
	bh=KWA0LZ+Vh6zwP1XD/gorid9aN4VGv0xItTURDO7NHAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekjR1PweC2L054CHhzyTegUmZw6KAJIqohAodeVWKDT/K9p5lE025pCrMkFBFkqkIT0GUsQCpvqfSa4eCqX4n1Bp+1mcPAUrq9zc3kjBu3vtFKgp5qseioJaXrsRUXfc/De+YuhkRWyHPCJJ7bcSAzo+a+LI4yIgeYAnPMxfTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04c29588so4377473e87.3;
        Wed, 24 Jul 2024 01:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721808341; x=1722413141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHZ4tckbMHgCkPRX0CWgUyznqrPY7OlancEa6H16LW0=;
        b=I9Y+oJMQTBIdn6YZP0Uz/3YuqdJSntJpF3cl4w8cYkTYvXiDuRKVbmvnBwbR96/ePm
         Au9ZjWsOknAmvepB2ocC0SzjHYwLesvwFwi3QGluSGgrzpqMTdZNSBPEyM7JB9bYStuZ
         TT4lc3f4TgfF/51P1mGR4zRFzRqSTrAfJupclRXVXF93GHtoMjUSwb+ysdgUVv/7mxnD
         BOwlpRgodmH6Ib1zu00xO//7GslQnHvq7KG8Wn2setRA5GaGpt246CNVVU635onlPoVN
         YflMsqZak6Tex/qwCsPyXq39VIpoBRh9zsrp2OoKNSQHb1O/WeFsypkATLO1JRzN0mSs
         Xeqg==
X-Forwarded-Encrypted: i=1; AJvYcCWDGxsI0k9ulF22nIxiNvUWLfRE3hD+sP0pGNzCw9lShTKmKJ25iiUNGsuyhGEHtJ6F0zsmX1Z+whJ+E3RzDABhHUJFYZ8lurnxHk5g0ygog8ajZOdDDlEHzY7go9S+VfVnJgIQ
X-Gm-Message-State: AOJu0YxfLO20rGDztquLUM3Bht52QBed76DSmdMc8IY6ywiwdYc6lbIN
	euhGlcK8mbzEFHirqfa5tbtx7rzL/EesPIygZMguZnKOe9ordMP1
X-Google-Smtp-Source: AGHT+IGn3jI1OhP6bn56ZLvRBV1Y4cvAt/WWYK4Jk24kCcT86h9PesTBRJOe7jtfVpyw2W4M0I++iA==
X-Received: by 2002:ac2:4e05:0:b0:52e:f463:977d with SMTP id 2adb3069b0e04-52efb79830emr7950836e87.20.1721808340979;
        Wed, 24 Jul 2024 01:05:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7ab04b31ddsm46320966b.60.2024.07.24.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:05:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: leit@meta.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org (open list:MEDIATEK ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net] net: mediatek: Fix potential NULL pointer dereference in dummy net_device handling
Date: Wed, 24 Jul 2024 01:05:23 -0700
Message-ID: <20240724080524.2734499-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the freeing of the dummy net_device from mtk_free_dev() to
mtk_remove().

Previously, if alloc_netdev_dummy() failed in mtk_probe(),
eth->dummy_dev would be NULL. The error path would then call
mtk_free_dev(), which in turn called free_netdev() assuming dummy_dev
was allocated (but it was not), potentially causing a NULL pointer
dereference.

By moving free_netdev() to mtk_remove(), we ensure it's only called when
mtk_probe() has succeeded and dummy_dev is fully allocated. This
addresses a potential NULL pointer dereference detected by Smatch[1].

Fixes: b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/4160f4e0-cbef-4a22-8b5d-42c4d399e1f7@stanley.mountain/ [1]
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0cc2dd85652f..16ca427cf4c3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4223,8 +4223,6 @@ static int mtk_free_dev(struct mtk_eth *eth)
 		metadata_dst_free(eth->dsa_meta[i]);
 	}
 
-	free_netdev(eth->dummy_dev);
-
 	return 0;
 }
 
@@ -5090,6 +5088,7 @@ static void mtk_remove(struct platform_device *pdev)
 	netif_napi_del(&eth->tx_napi);
 	netif_napi_del(&eth->rx_napi);
 	mtk_cleanup(eth);
+	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
 }
 
-- 
2.43.0



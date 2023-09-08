Return-Path: <netdev+bounces-32527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44017798249
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BEE281976
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EC185F;
	Fri,  8 Sep 2023 06:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9801852
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 06:21:37 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B31BE9;
	Thu,  7 Sep 2023 23:21:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b89b0c73d7so3335215ad.1;
        Thu, 07 Sep 2023 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694154094; x=1694758894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdlxO8xCKrQy/jRT0nkbbxVM9BFP+RkDY99mRvExc+k=;
        b=jVK9HFTeboxtCz+n9j5O0uYCYEiitQ2KcVh0a5q33dldLAdceiWj68Fh2pScdBaIoO
         PUoRytI0EEUi9TAIT/EIQuD4HHoHu2kI7nYOw+pjVbaEHPrOgxvxyBr5K/zpjD3o6Yns
         8vSUbau21hI/mdYD7DXT769sftq1NLkYNan+n1cMxB0oc6fKaoiJ6nAHrBcdjm8doNXJ
         lKlC2b4MwC8Ev/ebjFpB0g9YJBZ65oyZUlF1fPb9R5Nq3GUT7NCSQSNYjRKhbjkRa5Zp
         b3HkKfJtie0mntKpWkqcc+y9OQHsd/PdKiHrYERTpbevatfncv8OeN4kh++A7WD1CPg4
         qJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154094; x=1694758894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdlxO8xCKrQy/jRT0nkbbxVM9BFP+RkDY99mRvExc+k=;
        b=i8MMo0lRWLPA1x9yzvZMX82dz2WKMMap01dU6kZt//fOxqhA9zTi5aEFLkflAbciPg
         2wPLMzMXkqcn5VRzESjacGqkqR+ukcm4J360wtlVSMBaibsXKdnuwTyVzqGwlT4YTk0J
         6RW7PGsAU9XnPpIcFnO/HvrqTNiow4QbYQf2MV4zK6tqSd5V9QmRqqcM9bYYz9glil05
         GqomSyigUNQ7Fq1Q2T8FUTrCbgsnIfw2ReiMRyMzcb1eSmQ3kr+MhVn+YRVFubE34tzs
         IZy24BEpTQs+dmh4rZyFPP6984i6txRLfVBc0ZX8lzdIEfAmy6YQqommaUkHUhd/JH31
         Y/qQ==
X-Gm-Message-State: AOJu0Yz8FcjKBcZUgL2/uXpMKdV5AC4pq0UGKMtlaDwsi4kzJveuJMEH
	1DDVoriauBspmMNYFv0iibQ=
X-Google-Smtp-Source: AGHT+IFtdbDXX/f6kthEXzxe3IPBBobkRzWDXfCM/Z8uOIZugSIsTKjKzDPEZO02Vum21D08dqAq4A==
X-Received: by 2002:a17:902:e751:b0:1c3:2af5:19f3 with SMTP id p17-20020a170902e75100b001c32af519f3mr1732109plf.5.1694154093626;
        Thu, 07 Sep 2023 23:21:33 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b8c6890623sm768620plg.7.2023.09.07.23.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:21:32 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: justin.chen@broadcom.com,
	florian.fainelli@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mw@semihalf.com,
	linux@armlinux.org.uk,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	maxime.chevallier@bootlin.com,
	nelson.chang@mediatek.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 2/3] net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
Date: Fri,  8 Sep 2023 14:19:49 +0800
Message-Id: <20230908061950.20287-3-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908061950.20287-1-hbh25y@gmail.com>
References: <20230908061950.20287-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

rules is allocated in ethtool_get_rxnfc and the size is determined by
rule_cnt from user space. So rule_cnt needs to be check before using
rules to avoid OOB writing or NULL pointer dereference.

Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index eb74ccddb440..21c3f9b015c8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5586,6 +5586,11 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		for (i = 0; i < MVPP2_N_RFS_ENTRIES_PER_FLOW; i++) {
+			if (loc == info->rule_cnt) {
+				ret = -EMSGSIZE;
+				break;
+			}
+
 			if (port->rfs_rules[i])
 				rules[loc++] = i;
 		}
-- 
2.34.1



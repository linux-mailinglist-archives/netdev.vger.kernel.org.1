Return-Path: <netdev+bounces-32210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB8793804
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2310128127E
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C81392;
	Wed,  6 Sep 2023 09:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932646B1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 09:22:23 +0000 (UTC)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A2E73;
	Wed,  6 Sep 2023 02:22:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-27197b0b733so721212a91.1;
        Wed, 06 Sep 2023 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992140; x=1694596940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdlxO8xCKrQy/jRT0nkbbxVM9BFP+RkDY99mRvExc+k=;
        b=cGmGgvQQAiX1me7w3FJvszJ652L7+zowyM+ScvjUV3T3KHXu0ColK3l+u0L8r+OZgv
         9cBXAJMxCnk92jTU+BmfEoR+F6xfOwMzqm9BUo4plUrPUJ8fdSBujccw2nR9pul+VzD1
         K/1PzF27i7ZIN137pSJCTvaRRlQ/rLyP2bNJj0LKBI/+Mf1Z6YplgBQIAAVpMRSda02A
         4/LMqgbRt+G5eY5UKIWJ9dwu3ceEfss6jWdO+yCIpAcuXRq1hFSBinscyaVjVOUlb49r
         d3wT+teUDR9pcFKcbKUOgkRMmvAmZw8jDB9NsIBym/MNuhiKsn/viPzwJejUwhXiW/P2
         BL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992140; x=1694596940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdlxO8xCKrQy/jRT0nkbbxVM9BFP+RkDY99mRvExc+k=;
        b=fBxtzMpVHkxRTWPxqHBP0Kodu+9kzVn0J32ZwbZVTmVAqbSnqu50qfdXKfVcgeuph/
         TFuiCNI0BDw6+yeL3PHF6E0cYBb7tBPH86WO0uBGxvhtrLW6vWiZU71qO9OAdv5pgj7e
         bV+Yeu47NojwaTG02atEJ6aezrtVJ0a3AdmpeNkPSeo1xqfm1zTRbe5KMMh2/dyIIgUO
         GQR/QWzx9Q6hM9OHKKd9KgouxQ+HFj1W01aWCWcyHzKc8XEN+tE0xsaZkFzy4uhbk+SG
         6xSTksZUb70PqFaNrdV6t3fqTrlwO8jhsPMx0TQ3ARQ85L7cofAcQb3qup2M1NnP9SNS
         YdUg==
X-Gm-Message-State: AOJu0YzzYgAtoU6t45SQBwpw5omhF7X0JXPGA/U1p1mLvFtv6C/Idj7D
	KnuhauRJS7FiFutcBK3a9Q8=
X-Google-Smtp-Source: AGHT+IHMiYlrF3Jj3YOcK6rVl4xLdU7DgmAA3OTs/hdRqP6Fw6ddEdyaYMDL7Qb3ChEK1pnU2kkrAQ==
X-Received: by 2002:a17:90a:7564:b0:26d:414d:a98a with SMTP id q91-20020a17090a756400b0026d414da98amr13879578pjk.1.1693992139631;
        Wed, 06 Sep 2023 02:22:19 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm10679242pjb.14.2023.09.06.02.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:22:19 -0700 (PDT)
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
Subject: [PATCH 2/3] net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
Date: Wed,  6 Sep 2023 17:21:06 +0800
Message-Id: <20230906092107.19063-3-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906092107.19063-1-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
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



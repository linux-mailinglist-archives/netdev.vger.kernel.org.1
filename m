Return-Path: <netdev+bounces-15316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C184746C6A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC944280DE2
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFCA443F;
	Tue,  4 Jul 2023 08:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082B468B
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:53:36 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB961A2;
	Tue,  4 Jul 2023 01:53:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-668709767b1so2880425b3a.2;
        Tue, 04 Jul 2023 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688460814; x=1691052814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo4utTOFZlOpmYZQpJZ1w5TonydZxH/5QRh2ywOl8/s=;
        b=FRZN8vYPM2rFBLciNSfH259E1rj5uWQ4N4dPNgzNf4y0Z0scqWSi+oJUQUZrEVhAb/
         oOoWMujAalNciaipXXKIIgQNajnj9DJ2RMd8XkLg/KKHHDbQMW90C5SIG1lLPk2Uvtyn
         RKIoSo9YkuScoN/b1tbRCvkF9pSfog438/tBKICpfubxAVuSGSeaPkNzS0o/Jk5mdRPc
         su+YmmdRBgQddFzkvzXR83VAoyt2W8nKG7E8j85ITsfihI+AbZmumzPoO6gGBA32mU90
         4v6XsIYnVHhOPdkMHSULuCPk8/ra2/1CnGBg67NRvEykRkHJmdtEESuFVHA0teApHlwf
         9OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688460814; x=1691052814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jo4utTOFZlOpmYZQpJZ1w5TonydZxH/5QRh2ywOl8/s=;
        b=cPFfIEC35g+b06HOtYx7VkDWrFTF13Y6hjusAjZyU7wTPe0y49sMzkPJw094qQDN8a
         G7jOVIQguPh5EyFQGoGHxuAZNL0dRR8IgvwCrf3vPdApizKFzKygI3Rlq6Gv/r5j7kLs
         gd3FOemQCpJjcrug49sP1VEE8gvVbrJohn5HUaUhZMB1Gzpnm/HJ5kODm+VDvthbfg9D
         siUiTZil2mdqJLjVXqjVekPxrF1V4tc+eqPY6qUsgsaCJTM7reV7zPqu029FE7NAWCa0
         exwUylzpan/MVW8t7cV5VRSVmjT/6u8N+Tj6GO7UwpB9UYMHsCdRIvlf6BsautI2LAD2
         7g/Q==
X-Gm-Message-State: ABy/qLZBuVnbpt12JtlUdeZICAQqj7qzWJkT6ySQIFkwJmOHgwdMUhDI
	2Gz2haudZjXDPfmbxVGBi4b/xUs6DI2cQ66F
X-Google-Smtp-Source: APBJJlGdBDdI6CvkjhePpsVTcMguXJZHvum6U+F5zEnuUg9cknmAcMM+M0nSG9MCqR3oSM6A8gXTUQ==
X-Received: by 2002:a05:6a00:998:b0:673:8dfb:af32 with SMTP id u24-20020a056a00099800b006738dfbaf32mr13158303pfg.26.1688460814142;
        Tue, 04 Jul 2023 01:53:34 -0700 (PDT)
Received: from localhost.localdomain ([81.70.217.19])
        by smtp.gmail.com with ESMTPSA id j24-20020a63cf18000000b0054ff075fb31sm15996382pgg.42.2023.07.04.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 01:53:33 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
Date: Tue,  4 Jul 2023 16:52:36 +0800
Message-Id: <20230704085236.9791-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
to clear the unnecessary noise of "kfree_skb" event.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f42e51bd3e42..bcd0f0173cb5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -685,7 +685,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_kfree_skb_any(skb);
+		dev_consume_skb_any(skb);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.40.1



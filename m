Return-Path: <netdev+bounces-15572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67774890C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6967F1C20B07
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE4125C5;
	Wed,  5 Jul 2023 16:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F911CA4
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 16:15:42 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996931735
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 09:15:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76772fde287so274501485a.2
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688573739; x=1691165739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrbA99K1dqbxarLFSmNbQ4uAfE+s1hyibiXZ8BjKyss=;
        b=YAwaL0asaxbRNcYzxDauD8rRQ2cPKNL2/OQczEsyDX/LKaEa0CgrXSsyjvDzb+juBE
         MeLQzthznmtbdLPz1FuMx6BWWOXORrxBtJ086HipK9JumfY5FBDxQwpjgbLOEcbfAj6J
         WSDSUbMC3LNaC5Hc4cx7JuQXZBeAKttjE2nfM97iqc1UqpKY9rgwwbWOt5h1KbVZyb90
         uVv0tATOnZh0YoME/+sjgXEYpy9CHfnRYEypOygrFLRNsVWbFMIHC+iPFir5Ysfs9gwa
         JrSAYjjacIK8v/InfqwxafNU6x7TqDoLkqe1zuVgiL/M7b/bWV/BLDBPxu63xijab5oP
         2oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688573739; x=1691165739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrbA99K1dqbxarLFSmNbQ4uAfE+s1hyibiXZ8BjKyss=;
        b=EkojTha+2owPAcmbvBFLzNrtMdt2pkwGUzoE6fbJniCjlUaQd7Qb8KOUaOZ04+DZEu
         +JxuPulOaSTVNtywYD9zvSblBFJJePc2AHdkGQcFqrivyHimJj+lLIwQcmgLKLcDBS5m
         rn+7sqXkWZSzzdIHWbMcOCsiGuyaS6y+18ZEvV435t9u8a7PEdhIUAoljm5VxtcCri+Z
         /grfjWIYOvQq6dKgx90vVf4eqM+tg6kJq2rLEsK5EUXVacJ0E61Zw6MQ/ZONFEPO2jM/
         uWHvnnu0TRowC1nnlB7Rf7fBBxuzHj2CYYXLCQngzWHJ3bKRo/IcDhMo/d8wr147qHgH
         tYOw==
X-Gm-Message-State: AC+VfDyjsHQIIRGRAPMZXZbE0CD8qG8qwI8WhNFKZ1kbYis5elEcXw8W
	+75wsNxpn5epZyttX11/XKwM/g==
X-Google-Smtp-Source: ACHHUZ4GGYq46g/KEIZefzdRiUA8gN4OLx9rby0M8jocREH8JmGGCXgo85HnKcYi/r54d1NBj1pA2A==
X-Received: by 2002:a05:620a:191f:b0:767:cf7:e662 with SMTP id bj31-20020a05620a191f00b007670cf7e662mr20691361qkb.35.1688573739758;
        Wed, 05 Jul 2023 09:15:39 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a030800b00765a676b75csm11155796qkm.21.2023.07.05.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:15:39 -0700 (PDT)
From: jhs@mojatatu.com
X-Google-Original-From: ramdhan@starlabs.sg
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	ramdhan@starlabs.sg,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net] net/sched: cls_fw: Fix improper refcount update leads to  use-after-free
Date: Wed,  5 Jul 2023 12:15:30 -0400
Message-Id: <20230705161530.52003-1-ramdhan@starlabs.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: M A Ramdhan <ramdhan@starlabs.sg>

In the event of a failure in tcf_change_indev(), fw_set_parms() will
immediately return an error after incrementing or decrementing
reference counter in tcf_bind_filter().  If attacker can control
reference counter to zero and make reference freed, leading to
use after free.

In order to prevent this, move the point of possible failure above the
point where the TC_FW_CLASSID is handled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index ae9439a6c56c..8641f8059317 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -212,11 +212,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
 		ret = tcf_change_indev(net, tb[TCA_FW_INDEV], extack);
@@ -233,6 +228,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
-- 
2.34.1



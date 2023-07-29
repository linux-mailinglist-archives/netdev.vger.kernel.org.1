Return-Path: <netdev+bounces-22547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CD767F29
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1883E2825C0
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255DD168D2;
	Sat, 29 Jul 2023 12:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E1168CE
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:32:29 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596182D7D
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3efebcc24so2356805b6e.1
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690633946; x=1691238746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzpcxfJtg9C/S41DIrYk7rj68a4zxIEDEj2VNXRtGHU=;
        b=2GIRFCmIxAfPNEpPYzHiP0XYAvHbZ/irqVfPTyYgH0J1aBZC1rqm1HDbNrktefDVqt
         hYu+YmGjt9/zy4DFaxbsvmWzW22bp5if1tH43ENumYKC5ZTFtjuz6fyiTXfiCAncqe0i
         CmfmM1KxiP17pCFv2loYKwh7YCSN6Pkt2ryRtpDEcc30lY8zOtB1VlWazj1o/5OH0+ET
         E9Qyy8TCOYUJhHTUT7BFPdf+CkvzvF/S5uRSa2H6z2kCb1O8/CBiRUg7ZMBOH1dpk5Ck
         M0YimobpVeSBdQnBjkvE35p6mQvWUGWXccfFVWDYCKDX02bAyrOjAKKeh/dhB5SF23zQ
         sl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690633946; x=1691238746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzpcxfJtg9C/S41DIrYk7rj68a4zxIEDEj2VNXRtGHU=;
        b=JCFR/T0HkBmE5tD9Bh0iV5GmmRGQiyZxpC4RsdiGvTdQEP9uyflpfbpGswZjwBn80F
         DmQYCAL0w7xoe5zQhNPP87QrwlsqIy/5f8VQHni6LBWo5FQ6yW+0atH9Nm+dyzGoCuLP
         UpyccNVdrGj3QT5MQvZXa623eTXTgHuEK8SQ4VOHsNrFxYTMEVRoelzBX/Dss1TkMsD7
         y6wQGyZ3pT8s8GlqHcbLWOaJSCuDq5i6GahRxiICjpeQrk/NhyAZi850lh29lXsokSki
         sU084mWwWKO/AU/tnPdWrvhdKo40weJmZveoVldPJSISRtUOIyuyDXGSMAnv1QjuRBpU
         XOzA==
X-Gm-Message-State: ABy/qLZIV8dnhs+rGAhy3/8Gqu9b06JJAGqaZfHESmMPn6HlWNtTnpJN
	o21eq1LeTKrReUrxtJXlqvQDdA==
X-Google-Smtp-Source: APBJJlHoVHJMhcgRakhF9q8fvl0YCY2SPAA7TPujyNKb8lllkM1Yq1YtjrMRWlRvNeDhnHXWHcAOuw==
X-Received: by 2002:a05:6808:3023:b0:3a3:6c7d:a5cb with SMTP id ay35-20020a056808302300b003a36c7da5cbmr6382405oib.46.1690633946630;
        Sat, 29 Jul 2023 05:32:26 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b006263c531f61sm2024716qvk.24.2023.07.29.05.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 05:32:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	sec@valis.email,
	ramdhan@starlabs.sg,
	billy@starlabs.sg,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 2/3] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
Date: Sat, 29 Jul 2023 08:32:01 -0400
Message-Id: <20230729123202.72406-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
References: <20230729123202.72406-1-jhs@mojatatu.com>
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

From: valis <sec@valis.email>

When fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: e35a8ee5993b ("net: sched: fw use RCU")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 8641f8059317..c49d6af0e048 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -267,7 +267,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 		fnew->ifindex = f->ifindex;
 		fnew->tp = f->tp;
 
-- 
2.34.1



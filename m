Return-Path: <netdev+bounces-21987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD457658AF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2672A1C21502
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D01C9E4;
	Thu, 27 Jul 2023 16:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975220FAD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:30:12 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DA26AB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5634dbfb8b1so707521a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475411; x=1691080211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDndtUhTmjZhFwzFz2FDQYmgm5v0x87/y1zJ2WzSNM=;
        b=o09wR1GBUQ0fLtNeGIGR+inuMHtaNtuSkmaRK8SOHIZ3bA0d0S3C5zmboHCrVlGVbO
         I/oQbnvjuQuNjBMw5+qhgJzMSW46OmVyOTBPm89W18rl8ne17KsLOPwqLRCY1Tp2Y/uP
         lasYE9NqUvaa9usIrMxSwAGFrW/NNcP3jpDqqG1tSNUlJvMYUeZMcHAlioe9JlqHVdtC
         IG6/4M8GiaKvK9gi9xg6lN956zn0mDkQSPT0u52mBPjl1acgGUfw50yHSBwrHYeic6pN
         oi8jjyVjT/mxYjHPaqvyKbfdMR2HYICHze61mzIMPmtFEeVopwIt6Q2rJCvICpfCLYGv
         x4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475411; x=1691080211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDndtUhTmjZhFwzFz2FDQYmgm5v0x87/y1zJ2WzSNM=;
        b=WF+oItkfIyGejBUgL8LS0RxfTndRizqoD9Rd1IUaz/JYmzsFcWa5R16DXSQHx8Tih0
         svp5+tsvFf47Umpstz1PIGjCKSMABbmTqeQNgJqnf1T164GXKHSDQEF/89bV/bS6PwFj
         VooBckk3Hp6hdLM64JfzQv5do5W6tznd+F/PZxfNvCKiiRJfttjOGd+y3arSNM01CRim
         mD2+enkuqy4SqAVMYPCpM4h1r9gZYYKO29WaN6SVMWl78Run5ybFRYYkN8LX5LycZHta
         w8R1Km2v5hbBGn6+DUoOfFSWRC3E49Xu4KBTN3SFFCyXxWFH0RMPsr3vLMSLZB1w56gC
         yKAw==
X-Gm-Message-State: ABy/qLa3cgqtAb0k2ntgpfi3iJlhlBDCjOoiy+cFU4pRug/BO7zUvkIN
	8X6q9igUFzG/HiuWSkDJiSUycE3pA+Jaij6SKCet/5B7Rg6HLHRvdOkoUQAgAF3ibDWwuiXSO0M
	/37qqrqEpCzVIHdHwLWncOByoImlDdkkUjOeMXyQ5vomHKAb2ciwZpA==
X-Google-Smtp-Source: APBJJlFiIj/05iCTRMMvgFz0A0lSHRxD0cIR9qk4of0KMGMdM3pZobp8Ddt+dVih8UKDKvsqL231/Tc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3ec5:0:b0:557:6227:bf47 with SMTP id
 l188-20020a633ec5000000b005576227bf47mr25875pga.9.1690475410216; Thu, 27 Jul
 2023 09:30:10 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:30:01 -0700
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230727163001.3952878-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230727163001.3952878-5-sdf@google.com>
Subject: [PATCH net-next v2 4/4] ynl: print xdp-zc-max-segs in the sample
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Technically we don't have to keep extending the sample, but it
feels useful to run these tools locally to confirm everything
is working.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index d31268aa47c5..06433400dddd 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -38,6 +38,8 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
+	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
+
 	name = netdev_op_str(op);
 	if (name)
 		printf(" (ntf: %s)", name);
-- 
2.41.0.487.g6d72f3e995-goog



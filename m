Return-Path: <netdev+bounces-30268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA1786AA9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873911C20DE6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A10CA76;
	Thu, 24 Aug 2023 08:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42AFCA73
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:50:05 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C36E5A
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:50:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4108f709210so29594631cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692867000; x=1693471800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6N5nck5jnVx/VlQ+dlSgF/0u+kNuHdIzfWF3P7rNUM=;
        b=jQzQ5bLrHckwgXK/hyM3x53zXA9bPVFu3eYzE3Y75LYVygM3UdKm/3CAQtAgqYKq/L
         EeVASLdc0+g7LrjpqU17fn56WgJD5CzYW+wcv87B4TVK2UXYXDTKO4ZAGcXK7Ca9RPCR
         ePmMqXrvUiVjDYeetNLy/UPuSIJGo3KldMxR9U25+60gcN0IY2qpAXft3Ty1EOxfJBRU
         pX9d2eZhdmy548CFiaiYKQK3Lahdkq05s2KXJdaQubkKc/zMMVQo2U1gNOvHpiCGvh9X
         XCd82iKaTZ0eJrt/aK9N8EO77Pc84eGMG4Y3Rl3tbhXldZ+rVqvKpSzAWBmaadRCRaCI
         +M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692867000; x=1693471800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6N5nck5jnVx/VlQ+dlSgF/0u+kNuHdIzfWF3P7rNUM=;
        b=Y/4M/eFxaEpJ01WlZY0uzWIWyjoihKNmp37xTr5iNc9Rfulkjo6y7BlRE/IHJUJq1W
         xyHlStSVXtfvNCFdnLdWIUO0fexEwPYQov7/F5qEBY5VLaWN73rnNPcA3jUhZwiVRCK5
         ym8acsNQr6O2iRLQh4hQghGvfPkLe/kfcPUHGZzTu5ZXFLjYkJ8b5bbdLNh7pcwL1ZkM
         eHRIp9hvbyxpQ/W7V9yg1QPw9dy5kj57JeZl5m8WEKlgs5JQpzS6Z0DguG3PQythoqQs
         S/lrtWBqIIqWS5rJTzstjhLNqIp+cjwn4bCMTfxofHG9YgGUIeAgtQOAp0fSxdwbMkc4
         l7Qg==
X-Gm-Message-State: AOJu0YwVHwtV3wMxZkgiBUZXdKuglabCk7qQYfanKIlhz2un53SZwVne
	Pl7ZRgodhA0XbfzFho7tBXjmc5AsW1rApec=
X-Google-Smtp-Source: AGHT+IFf8PCeI6NIv7Ly+OvSlEqoOiQA4DG7IyLAxenJLimotLtWEedJ2PhnWtJt8mabkNZgaVmkTg==
X-Received: by 2002:a05:622a:152:b0:403:e9e2:3d03 with SMTP id v18-20020a05622a015200b00403e9e23d03mr19615573qtw.47.1692866999870;
        Thu, 24 Aug 2023 01:49:59 -0700 (PDT)
Received: from localhost.localdomain ([178.249.214.21])
        by smtp.gmail.com with ESMTPSA id hx3-20020a05622a668300b00403cce833eesm4120819qtb.27.2023.08.24.01.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:49:59 -0700 (PDT)
From: Budimir Markovic <markovicbudimir@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Budimir Markovic <markovicbudimir@gmail.com>
Subject: [PATCH net] net/sched: sch_hfsc: Ensure inner classes have fsc curve
Date: Thu, 24 Aug 2023 01:49:05 -0700
Message-ID: <20230824084905.422-1-markovicbudimir@gmail.com>
X-Mailer: git-send-email 2.41.0
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

HFSC assumes that inner classes have an fsc curve, but it is currently
possible for classes without an fsc curve to become parents. This leads
to bugs including a use-after-free.

Don't allow non-root classes without HFSC_FSC to become parents.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
---
 net/sched/sch_hfsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 70b0c5873..d14cff8d4 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1012,6 +1012,10 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
+		return -EINVAL;
+	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
-- 
2.41.0



Return-Path: <netdev+bounces-40729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DD7C8857
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176C11C21093
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1C1B260;
	Fri, 13 Oct 2023 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yS7967Ci"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98418E20
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:11:15 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F4CA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:14 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4f1f0774dso1459627a34.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697209873; x=1697814673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b73NidNwA2qI/73YayEw70kSAtJX/7MJfo52+MbiIWc=;
        b=yS7967CiJHDz/5UyamgQ20hp+1oOfjGfsUF7mzUDzYL8bBWJq1wkyv+fJsIVl4L8OZ
         Dj53YSxvn3HeKTZvf3VAKhgV49wEUx+j1ScAms+KXTgy/M6/6Bv+6NhblIL5J7nhCbwv
         zZtWwcS1ixEyFrzcAW01GwLGYy6/9ZrR1M0tntro8mc0d0F4kzkX/LAs665jSbIfUc5H
         FCusBQQFjL0EeY9azNxBiGalSVzfw78vr5WIgz9vpvQSCkgee2+L34NRb5mRLlMewRDf
         PzdJBdNsPyT/UHnwqJ887/ajBWPnTWeaKNIl32OaE57lz+S1JdhcxxDHnblwrQIUo1eS
         Se7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209873; x=1697814673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b73NidNwA2qI/73YayEw70kSAtJX/7MJfo52+MbiIWc=;
        b=tM9DNXO/5Ao7dhQ3cj0JjW+iXvtRpmmWWWASPmn7vy7RSmoAP6b1TF0vAdcYbfYhjx
         a7aLjOwDY+boIu2Zj/om5kiywO5+bjv/EoyhA/CXctMyP+kK/K97LiILBzsNkQNwU9Tx
         /mt3Now85rWMf+ZThSLQpBQlhsatSdeJYDsN63NbaixP7S2cl6ZZmjY5DvVg7vwxXMrQ
         Bv/rp2kUPnPmKDtsL4gQG/DoIHw9udBQiA2GJ5DQd2U2uGVfhSe4QLgZRmVSnoFpipb9
         eGh4NhhSinl3EZgqBZ+Qkoxt5UCfhnDWfJG3au0zDCaDNxqwav2WKrnZfsAvN3bkFqCw
         j8uw==
X-Gm-Message-State: AOJu0YwCVDWQBhe5Hi7UmxJxOL9tE5qp/awFLjRDNWbQVNNCG2m5zPKi
	5FOvgKvUn/sIe7macJKO+x6r88cekexGpH/xGrrZhg==
X-Google-Smtp-Source: AGHT+IEnbvRCpWnsLkIG3snCS0hWRijI5iVVKoIoOwIMddzqwXI4HGIgMSiuG748HBsv7g5/uX0D+A==
X-Received: by 2002:a9d:6c04:0:b0:6bd:bb7e:3dfe with SMTP id f4-20020a9d6c04000000b006bdbb7e3dfemr28266941otq.6.1697209873599;
        Fri, 13 Oct 2023 08:11:13 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:aa18:90b1:177c:3fd3])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0064f76992905sm13716881pfn.202.2023.10.13.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:11:13 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 1/2] Revert "net/sched: sch_hfsc: Ensure inner classes have fsc curve"
Date: Fri, 13 Oct 2023 12:10:56 -0300
Message-Id: <20231013151057.2611860-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013151057.2611860-1-pctammela@mojatatu.com>
References: <20231013151057.2611860-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_hfsc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3554085bc2be..98805303218d 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1011,10 +1011,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
-	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
-		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
-		return -EINVAL;
-	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
-- 
2.39.2



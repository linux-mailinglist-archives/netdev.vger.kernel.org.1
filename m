Return-Path: <netdev+bounces-60085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCF81D466
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7402838E8
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A05DDA5;
	Sat, 23 Dec 2023 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NbTgR59X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F309DDC2
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78117e97becso150344285a.3
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340132; x=1703944932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i40BQqNAyXroNCvlOksNxdslsW86ov9lOuDnEGnhAw=;
        b=NbTgR59XaFzOiiMAUCW1b8xFp4KuRITPRtMQKEm+VfuTwnwcaEPfyfMah9HtFArY3U
         jCnz3mPNMg1ipFQiRj1YMs89UbG1JqVx0cNYAT1zYiqT4y21N1r1fz282bIB1p5lZ+Kv
         AUl9JYeTkMNhdb7Q5Uat4owIWnUUxF4WXFDpGCBH2dtDYkzlBqQeDGYZ5WJoCDO2gwJV
         lDxPBc35DLPrfVG+/TT5Ga9E5rTPyEnUrJDRW6rwK4WPVaz2V2us8MN6uAEJip0/Rjl0
         zMpO4koLt/xbYbmIqurD4d5JwkdJbQa5gRUsYiTiypjScZ3rw0qjva7SwCYd2TII11Z4
         pTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340132; x=1703944932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i40BQqNAyXroNCvlOksNxdslsW86ov9lOuDnEGnhAw=;
        b=QKZJxg5i/dwNEBa90/vqgb+KucXvEtTbGqnFcXvz8/zgsWxVayEtXN3Cxe8ypPikkp
         244fmoLGMZKcS5pqLRvxEdcc/htYp/Y/pK+BX/LuHm7ZjnyWqShyPGFOU71lALhV38VF
         W8AkZyqdcqNi8a9ZxdBqYPVqa1CthRp1RuDuPABFszE7jPfTXLa+axKsI+eGolMeHqFX
         6JnfP8NuBUCqgUlEYeKMBzXSf9MvjaA+2tNRCSBqI811NkXtbvllrAVofM+KTlIgDorT
         4y2wQYGpl6VrsXi1R/rAQ6Vp9vybXGT1UC9YddrUmaDZ5lRSnE9v1FSKwU+wmgrfVbHA
         Mp+w==
X-Gm-Message-State: AOJu0Yxu93dKiOGVsLyATa6gC52TpbWyoiXDymnQeL6n8nGOztU+M5TL
	lp4146Y4Jclp+HRWgGuVkGFY64106WLB
X-Google-Smtp-Source: AGHT+IH48soYtB+0t/bne+hGf7moRou1XJ+R5BVm78Pe8nqeg7PSu6qYIszkwdIRGv/DPq2eRb0VZQ==
X-Received: by 2002:a05:620a:199f:b0:77f:2baf:c95a with SMTP id bm31-20020a05620a199f00b0077f2bafc95amr3944754qkb.115.1703340132559;
        Sat, 23 Dec 2023 06:02:12 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:10 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 2/5] net/sched: Remove uapi support for tcindex classifier
Date: Sat, 23 Dec 2023 09:01:51 -0500
Message-Id: <20231223140154.1319084-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223140154.1319084-1-jhs@mojatatu.com>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8c710f75256b ("net/sched: Retire tcindex classifier") retired the TC
tcindex classifier.
Remove UAPI for it.  Iproute2 will sync by equally removing it from user space.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_cls.h       | 16 ----------------
 tools/include/uapi/linux/pkt_cls.h | 16 ----------------
 2 files changed, 32 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 0d85f7faad53..c474cf53fa84 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -310,22 +310,6 @@ enum {
 
 #define TCA_FW_MAX (__TCA_FW_MAX - 1)
 
-/* TC index filter */
-
-enum {
-	TCA_TCINDEX_UNSPEC,
-	TCA_TCINDEX_HASH,
-	TCA_TCINDEX_MASK,
-	TCA_TCINDEX_SHIFT,
-	TCA_TCINDEX_FALL_THROUGH,
-	TCA_TCINDEX_CLASSID,
-	TCA_TCINDEX_POLICE,
-	TCA_TCINDEX_ACT,
-	__TCA_TCINDEX_MAX
-};
-
-#define TCA_TCINDEX_MAX     (__TCA_TCINDEX_MAX - 1)
-
 /* Flow filter */
 
 enum {
diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/linux/pkt_cls.h
index 82eccb6a4994..bd4b227ab4ba 100644
--- a/tools/include/uapi/linux/pkt_cls.h
+++ b/tools/include/uapi/linux/pkt_cls.h
@@ -234,22 +234,6 @@ enum {
 
 #define TCA_FW_MAX (__TCA_FW_MAX - 1)
 
-/* TC index filter */
-
-enum {
-	TCA_TCINDEX_UNSPEC,
-	TCA_TCINDEX_HASH,
-	TCA_TCINDEX_MASK,
-	TCA_TCINDEX_SHIFT,
-	TCA_TCINDEX_FALL_THROUGH,
-	TCA_TCINDEX_CLASSID,
-	TCA_TCINDEX_POLICE,
-	TCA_TCINDEX_ACT,
-	__TCA_TCINDEX_MAX
-};
-
-#define TCA_TCINDEX_MAX     (__TCA_TCINDEX_MAX - 1)
-
 /* Flow filter */
 
 enum {
-- 
2.34.1



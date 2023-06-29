Return-Path: <netdev+bounces-14526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269A74242C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF7C1C20A04
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97610961;
	Thu, 29 Jun 2023 10:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA614A9A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:59 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604BD1BE8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:56 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63588812c7aso2104026d6.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035555; x=1690627555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjaZOIU4h0pDNUE+B8kyotPo8kdEDisMP+rDMllxaGs=;
        b=F/w1p2l+yfazCLKOtchvm6wzltAGeuYAdetG/0YTykcbDz01UZeo+Ou+PyA/E9iGfC
         RxmX0QiZXhy2wrHzHF4vJxyo6Z/8Hsx7tqjExlI1tkbkv4vU4jCE5F+eMaiKfb6xJJTZ
         WVO5EguAIrdTdmyEEt7ZqRp7CpgA3JqhmLF9xzPXfwLi0F9l7Sp0HqAq1T+/ufZoBC01
         cuDI8DIGe9KOqywkdoursghbUf1LukiYIyzPCqOt8nkF6UMqi62iVMBe5i4TgnFxZDic
         QmmiaNHwHTREDxpbEKqXRAZGcCKXnSAKkbMZZQt6hIL+1NhyfgeFQhdXg8X/O1APRvY3
         0+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035555; x=1690627555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjaZOIU4h0pDNUE+B8kyotPo8kdEDisMP+rDMllxaGs=;
        b=Inmx74ED9bTwI/snYwKmkeyUjALl51+Q3SrxtKjLwx08OMO5D6tWCMQKOEApyPAKNv
         sgLjPECM7qJgjB6Ad1P+lBze8Vanfdk7IAX4GGZG21Iwlk+FZ4v3xmxedTq627ZDglVs
         AE1JR8IjmvEUATcCJFi0Xtn22XkHwnHVGNa05Zo6drI9haLc13aoBpj5MKEaAD5qNNvK
         sPtuRw1blYeHA/rYRZbPmeDIA7Yf738SxZjmp01DmQ1RR4Yctk3S/W6QkiZWSgLqKyWu
         /8lvJpiXVec6+Nizqj0J4yO+GtMNzQ/pMHgwzCbgOUEPcOrLs0vOLSqbol5CIQvPsZBu
         86ZA==
X-Gm-Message-State: AC+VfDwE1ugveVvqwvwIewevT/03FG7c3/ULum4AY1Fv4apddGXXNrbw
	0Y+yhdNFU7QVNGsRCOowqKHaTfPw24MIGB8WuWo=
X-Google-Smtp-Source: ACHHUZ4tYbm8Cy3C7LA3vB00Wvs6egD43oPnWrJlsZ9DwUB9UYIzZMXdbC+mY4ymtAFMLIMTIBeGMQ==
X-Received: by 2002:a05:6214:e43:b0:62e:ffc3:a9e5 with SMTP id o3-20020a0562140e4300b0062effc3a9e5mr4409211qvc.3.1688035555122;
        Thu, 29 Jun 2023 03:45:55 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	kernel@mojatatu.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 06/21] net: introduce rcu_replace_pointer_rtnl
Date: Thu, 29 Jun 2023 06:45:23 -0400
Message-Id: <20230629104538.40863-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629104538.40863-1-jhs@mojatatu.com>
References: <20230629104538.40863-1-jhs@mojatatu.com>
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

We use rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held()) throughout the
P4TC infrastructure code.

It may be useful for other use cases, so we create a helper.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306c..971055e66 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -62,6 +62,18 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rcu_dereference_rtnl(p)					\
 	rcu_dereference_check(p, lockdep_rtnl_is_held())
 
+/**
+ * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
+ * its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ *
+ * Perform a replacement under rtnl_lock, where @rcu_ptr is an RCU-annotated
+ * pointer. The old value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr
+ */
+#define rcu_replace_pointer_rtnl(rcu_ptr, ptr)			\
+	rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held())
+
 /**
  * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
  * @p: The pointer to read, prior to dereferencing
-- 
2.34.1



Return-Path: <netdev+bounces-14539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E215742456
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC461C20AAC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F961171C0;
	Thu, 29 Jun 2023 10:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D0171B7
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:22 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CC1FE3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635e5b06aaeso4511146d6.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035579; x=1690627579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxozgYPIJezgNc0ZLNNqct8fkxA6ty7Q7qbLZpS6mBU=;
        b=iGXn5rBHbJXhLQxjBkP14xXgoNgSYRFMuOdaSMizFqwzC7vZFdiwJFqcjsqSYvv31f
         fKIHb6cbBftS8mZJXlZZZTPicKvHOrAqpQ+bJysZ00bAAelGuzj6gbUTwfRAgsuRF784
         3HuVyn3/J6rJn00LVezyVBwBTrdt4gl5LJcHij4C7zSApymXAQJqm3ga4nXZrmMRt85b
         fLp6Drtkp4OkLDv/fWsi0/sA9Ip749ei6e2G1/P5jk7L4hAkxIbEySWVRXQYlcw2m7IJ
         +DYTWRYJN1dfuCMBgPKiy6k7Z3J40S1OAFKAumuUhS0OZn2nv/etmPyJhJuAJ4nhL9RO
         Fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035579; x=1690627579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxozgYPIJezgNc0ZLNNqct8fkxA6ty7Q7qbLZpS6mBU=;
        b=bejLmItteJTC+K3indA+BJ9xOY8AFKc2ziddmtLkJgfXcTauXnCnUgXWXsD1Q45G2W
         x6lParhIHCOfrnSbjUTpdWRx1jgddg3ryaGtaBZpSCjN5LPNpnokyrziwvGQXUn174QL
         tJZI4dRR2KXhUiUsg04tUqvYZMZho30KLtak4+s/V0ht7t1aaI1cTJBjQggCoHcFUl0r
         13zEVAhv44zPToSP43PrCDVUwzG67Kj233vjOMmsw9VjNHaKCb7caeaOlijWYbUGb1Gx
         crJ4KWZ1M55C8DdEB4uaTdgk7quX5rxeozGTP7Nz7IDwdHwBtL4uSNXTBPssDK3SyG3A
         X0uQ==
X-Gm-Message-State: AC+VfDyXqD9pSwyGU55btjvZn3bdZKClSRTI1mDd/IqUQG5LvmTMSf3r
	yjE0vnqHC+cRg6AtjtMK+A4MjYqenCPMeu4CdHk=
X-Google-Smtp-Source: ACHHUZ5ED4ayyRbYy3tNvBZ0aVNWyGYCUVxe3HNzqWG5GZs1scGruaKW+0xqDIjjZYEcFyeF0kFHXw==
X-Received: by 2002:ad4:5d4d:0:b0:632:b37:3327 with SMTP id jk13-20020ad45d4d000000b006320b373327mr35983104qvb.56.1688035579091;
        Thu, 29 Jun 2023 03:46:19 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:46:18 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 21/21] MAINTAINERS: add p4tc entry
Date: Thu, 29 Jun 2023 06:45:38 -0400
Message-Id: <20230629104538.40863-22-jhs@mojatatu.com>
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

P4TC is currently maintained by Mojatatu Networks.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebd26b3ca..32f6cd30a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15782,6 +15782,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
 
+P4TC
+M:	Victor Nogueira <victor@mojatatu.com>
+M:	Jamal Hadi Salim <jhs@mojatatu.com>
+M:	Pedro Tammela <pctammela@mojatatu.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/net/p4tc.h
+F:	include/net/p4tc_types.h
+F:	include/net/tc_act/p4tc.h
+F:	include/uapi/linux/p4tc.h
+F:	net/sched/cls_p4.c
+F:	net/sched/p4tc/
+F:	tools/testing/selftests/tc-testing/tc-tests/p4tc/
+
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.34.1



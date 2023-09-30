Return-Path: <netdev+bounces-37176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE87B40FC
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9456DB20AA8
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4E15AFE;
	Sat, 30 Sep 2023 14:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA9156F1
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:20 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56570106
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b2463d651so46209406d6.3
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084576; x=1696689376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLfsb6yRCQChyO/cx8Q0g33uGIDPR3LNzXTvXr5MuNo=;
        b=XlfMMsxoBUEdkxfImzY6NCZvf5Rfm7prlizlUK4co04HZSFfpBIetOhuUH0/S0nWNR
         EE4bZtEC0IGItyM6p/0jBYYUbuP+K7WjNd0pTJFh4n321lxysmnqzT0shLXZGnJ5Pz3X
         uNussNER+A+b+0z1uguRtSLV6yRZC9z4qz1IqrULZ+NQf6NsxDrGmG18cXofWcsv7uaE
         B9XUuFyXELtKIzt+xZrsYlYp1ECxcNwPiIdiu38mieu5TyMssl+6HRt3lQmuOdN6nwoo
         qht6/8gW/bhEFRsjdWuRtHy9j7f8bigidz/QZUlAstStx3wT5vr8S8jdC7rhnYLRVJ1/
         VTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084576; x=1696689376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLfsb6yRCQChyO/cx8Q0g33uGIDPR3LNzXTvXr5MuNo=;
        b=oXewTMX3/xFl2oVzl9B3IOz2nikQuA/LbUGQHqi0Er9QOeVJa1vNXDd32vjW4IHMFd
         z44pPfjIyZenchmCNWtlwECrtGE/YiMDTlj7OgyiUSyS4bMwK60xKkYBBI6AHkFMLnqL
         ze5TpY9VY6GDY+VtXhCnt7utroeZOtIz7YqICgD9TGXPBjztA+mZ+ep786eh/HsZXwLf
         FSJJTPUycZX/0h5SY7aZi1ntUjVsqZnTBK1wu7NXUuorwkzmUIz3FQ8JxI2ecsMwv3mL
         IYiodaluFKnsS9Tdez0WLirdVLHSp5HAalECCp7hyKK9es/xhGC+XZJtOjWdYj5Lzks9
         XtLw==
X-Gm-Message-State: AOJu0YxWQ8VwB9mv7zf97BVl98FQMRr3HpnnAalbsedXSEmlFfTFnMWO
	YyMTXDCq5TSeZ4rFnMJZQpwnZ7ykDezz0xKeSPw=
X-Google-Smtp-Source: AGHT+IHoOhJKJGAyP5c1r25OopjPUZA2eqoFUvpbTb68LSjvH+bEI6iATf6lznEoey7jXm9yULRaPw==
X-Received: by 2002:a0c:e554:0:b0:65b:a76:ea34 with SMTP id n20-20020a0ce554000000b0065b0a76ea34mr6846880qvm.2.1696084576056;
        Sat, 30 Sep 2023 07:36:16 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:36:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 17/17] MAINTAINERS: add p4tc entry
Date: Sat, 30 Sep 2023 10:35:42 -0400
Message-Id: <20230930143542.101000-18-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
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

P4TC is currently maintained by Mojatatu Networks.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b3222835..312e40837 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16092,6 +16092,21 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
 
+P4TC
+M:	Victor Nogueira <victor@mojatatu.com>
+M:	Jamal Hadi Salim <jhs@mojatatu.com>
+M:	Pedro Tammela <pctammela@mojatatu.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/net/p4tc.h
+F:	include/net/p4tc_ext_api.h
+F:	include/net/tc_act/p4tc.h
+F:	include/uapi/linux/p4tc.h
+F:	include/uapi/linux/p4tc_ext.h
+F:	net/sched/cls_p4.c
+F:	net/sched/p4tc/
+F:	tools/testing/selftests/tc-testing/tc-tests/p4tc/
+
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.34.1



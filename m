Return-Path: <netdev+bounces-41232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF07CA455
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9FBB20CF1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915222EFC;
	Mon, 16 Oct 2023 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G3h26xVW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958120B1A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:27 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A9E6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7c08b7744so51618007b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448984; x=1698053784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLfsb6yRCQChyO/cx8Q0g33uGIDPR3LNzXTvXr5MuNo=;
        b=G3h26xVWjEMKcnQEPlibjcj8ya9uAzaGNXoymXsn2/cLf5ezKTsgwwf2YVZpK8gGAE
         v2ogsv9jcYYihDxAR7Y1MOGmQy0LEiuoyYARkoOALgBEkzdw6YCzmTl96jyVbaBJKDeA
         CprL4uIHy28uhiW6SRck6F/osG22IMb1Vsn0EtcmyrrB+rwnRS+q5s/bf2OdG85JskMb
         W2mSOI299WneCKSW+iotoOGgyGxIwm2nspd1TCt0UYWExZqjZPXZYJcfadxvYjuuVf9C
         dxENFWSJw1eKJ9S6hC3LPRvW4ud8W5dgth8lt5bl3m/OE4wqDqlnrRFYMRY5uTHCZOWC
         1f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448984; x=1698053784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLfsb6yRCQChyO/cx8Q0g33uGIDPR3LNzXTvXr5MuNo=;
        b=E+AR8QY9QNSRD7Xk82qckemJyCqk0Udz8aFmyNbBv8HCkePWMmF5Yblobx1FrzZkBJ
         bWsiDn4ilwzNjoXuFX87eeeT/UNBd8DJVhszFR9mvW7gfFhG+4lNMHQf/PYckGAqw6nn
         X82D9pBczXVryjlVXugjET03RFbTVdwi3sZDxY1mTll2TkxuT1iRy39pmSC1is8oQjBA
         NDuCzsx45xx7LpNhQZRDzt5ftasofRPGY9RDALqft++4Zf6BV5hKJ8qHNA7XebH/jsAF
         xQ9i3um8TSNlpp680Q9JdfjsUPTctF78nzDj1FST6GqU7azoqfNlbtVmM0buJ1SwEhKX
         JW2Q==
X-Gm-Message-State: AOJu0Yzi4TQqfmWw7+SJmXx8h9u4JTCwcHtyMSEX+O/vZqvOQHsydIVE
	FdUZqb1avZo4XLzjImJEiWX7jYRCQGUXiUPsnbM=
X-Google-Smtp-Source: AGHT+IGwrYajHT27SdPzz/vtTr83LCp6XwRoKyEhnmo4u4ipPtN9g58XgPaaGRec+1NF2XzKKkEyhw==
X-Received: by 2002:a0d:e943:0:b0:599:da80:e1e6 with SMTP id s64-20020a0de943000000b00599da80e1e6mr35678299ywe.34.1697448984511;
        Mon, 16 Oct 2023 02:36:24 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
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
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 18/18] MAINTAINERS: add p4tc entry
Date: Mon, 16 Oct 2023 05:35:49 -0400
Message-Id: <20231016093549.181952-19-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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



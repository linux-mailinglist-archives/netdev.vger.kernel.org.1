Return-Path: <netdev+bounces-23180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734876B3A5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B696D2819AE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8032516A;
	Tue,  1 Aug 2023 11:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C325167
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:39:00 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D1E43
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4478ea3ac05so772716137.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889937; x=1691494737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRys4uhQz+XXtz0mX/+q9MfyY+ifJZqovVPtdqipjEc=;
        b=QoeXn3gv1hsaix2+DSAE2pW+8nssFet0Jl6Mo0CNrwxCZQfi80BEkIpzSa8MMB8e6x
         gn/em6GBtqx21yD7GRbyN2lYULnj36vZ6kwv19p+Am6jjbI/OsZQf0ibdgBxoTBwDbzG
         XJyJXtp6kJmoN5TQKmWOs828RjPJj9kU7XbC7j6xnPha4uVldjpNDUr6Fkdl8g56gXVA
         d0+X9sOeCc57qksiEWkXM86aQGaRZMGJlL0FByaoBXtyFpA9yQHLnMBJalLvzpfJZhTL
         NC8h0igqM3ohtj64ndmCOGw9/z7X/BH4i0tJDwI59sjYj0MPIG4/X6ph7jpRr52EgP8v
         5HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889937; x=1691494737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRys4uhQz+XXtz0mX/+q9MfyY+ifJZqovVPtdqipjEc=;
        b=ZXjE6rynGZJFOOoU+vGzZdrRX330cgNjvZhkuw83MPXS+9Pmps+wOruuAFxZuZVuJk
         4/UF5kvw3slK2XgP0L1rwUb8vUehEodW+nhagWCGh/mjeDqmRXArM8+odNkZPQ9cWrxF
         wjJ2E5JbxuQgDeyM0xwvWt4Y8XSy9OPkJ8RY05YaX0rWDEcx2gbtV6F9RJz8YmbBLzRh
         dALLw5yBjq2i9ztc6vvP81q6qqBpGyeQvruX/3WvHhV0exOpTR9GvdP9hhoQWR5nhgSx
         XaKQG74ICn4ZdZpgONgtBrDC6BXe3q+WsdtbV/1/0CHHpUbGTFc9OeBYxyzAn9FK2Q66
         wCDw==
X-Gm-Message-State: ABy/qLb6cWJrg2tJSriWcULEDbJOSyONxgdcHPjej+BFDlHaPPlFPLWU
	BX9YSuSHW/rOPsxft7fUP5kvXShmLHJmFgW8fW79uA==
X-Google-Smtp-Source: APBJJlFxGE7jtiNSsfmr7294EwPXiWWBWoeCEbIjy+gOhRvtbKO3V5F8vxW+BN/LWPDHeLnqg12Iwg==
X-Received: by 2002:a05:6102:3166:b0:447:8e20:6e2e with SMTP id l6-20020a056102316600b004478e206e2emr2116066vsm.34.1690889936950;
        Tue, 01 Aug 2023 04:38:56 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:55 -0700 (PDT)
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
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v5 net-next 23/23] MAINTAINERS: add p4tc entry
Date: Tue,  1 Aug 2023 07:38:07 -0400
Message-Id: <20230801113807.85473-24-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index ebd26b3ca..de3e35e46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15782,6 +15782,21 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
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



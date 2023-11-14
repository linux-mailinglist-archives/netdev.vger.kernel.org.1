Return-Path: <netdev+bounces-47761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19D7EB469
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA22C1F2542B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868A41A91;
	Tue, 14 Nov 2023 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HOHakC3R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A141A99
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:05:46 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FB130
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc5b6d6228so37022355ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699977945; x=1700582745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhHfdkW2/Y1xfD2GKm3JgoAOLUVQZBd2aUZA20+v5Vg=;
        b=HOHakC3R5wlvubsSt5+kTEcndbdHvOwLIL7D9sKuJwpyYRuwf/BIiqbc79SWi7UOnE
         nVvewnWltnD6Esw/JJdzTJjIzrTBaqZ+va0/qlQo0PnH2vQa3HOk0nYAk4EDPKRAGISn
         vo4QNWH9QVQEei8QvtC12aP2VTBtqMxh5bv6xTyDMbUdGnRMug6aOMHNnXI7N6ZFaq6g
         v8GKhsWfFmtDA8uaA3Yx4yIqQ43D5QmPL7ogf/z4DcdW+NIDmi7/ZPDl/YHuYWAr1DIU
         Nob/6kA3pYWu7NRAUpiX9wGyRm/CgpV6fyWeUf6/tU4kEYsqrxaat7bnlIjZxNba7VwT
         m81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977945; x=1700582745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhHfdkW2/Y1xfD2GKm3JgoAOLUVQZBd2aUZA20+v5Vg=;
        b=nc15rWuvp4vtByEBhB52O+6RBZL7TCXbWyuB5VfX3si8hHmSpoH8hBSedvo0zvyfMO
         wIDMLd0xRB0hl7J8CaiBCXeyCjmCfh0ae/9ZsFyz0T3CNag4MKJqfVZon8uyQbzq702Q
         Bo9Ybqir5HXkF++xzohMDW+hnvSfeFJPaVyvebQJb7velToLcCM67u3b2P7dKn29PfL+
         5d0eJ+1KcNgI0+0ALUxoFx6bobzK7IdunYsxtOk350Ae0oMlSzGJT6DXi4lrNKXTr4e8
         Z8GP79qPhmdYny77KLsyzbO8NhaLDu9hzzZ/BNYM3mwW+gxcSV35M/PjFUaYsTZu3KIK
         CiZg==
X-Gm-Message-State: AOJu0Yy8qwFRRsjpZwo6h7ctcniJb8XS7+BEEFGQKhLz+ZL+2Xl5nYk0
	QZIKHBe6ahvDk+HA2HjX+b53bg5izl+d/GozvRY=
X-Google-Smtp-Source: AGHT+IGdqIkKhhM4KryQwXZBnbATQnB5BzGQXNG1aNLGHFRIuCg52G877Lg0eFrdhEiYpXDSh1z50g==
X-Received: by 2002:a17:903:1247:b0:1cc:52ca:2e01 with SMTP id u7-20020a170903124700b001cc52ca2e01mr3288855plh.16.1699977945186;
        Tue, 14 Nov 2023 08:05:45 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:fa3f:3165:385:80b3])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm5833048plg.87.2023.11.14.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:44 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 4/4] selftests: tc-testing: use parallel tdc in kselftests
Date: Tue, 14 Nov 2023 13:04:42 -0300
Message-Id: <20231114160442.1023815-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114160442.1023815-1-pctammela@mojatatu.com>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leverage parallel tests in kselftests using all the available cpus.
We tested this in tuxsuite and locally extensively and it seems it's ready for prime time.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index ae08b7a47c42..4dbe50bde5a0 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -64,5 +64,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -c actions --nobuildebpf
-./tdc.py -c qdisc
+./tdc.py -J`nproc` -c actions --nobuildebpf
+./tdc.py -J`nproc` -c qdisc
-- 
2.40.1



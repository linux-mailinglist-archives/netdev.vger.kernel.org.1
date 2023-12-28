Return-Path: <netdev+bounces-60436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DB81F3F0
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0A628408F
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD73EDB;
	Thu, 28 Dec 2023 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ShJ4JkW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817F63CD
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36011002a61so6916455ab.2
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703728001; x=1704332801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWOr9qiisUkjpabZ4ff5uQEtv5SlwPvl6ptfPUH6+qE=;
        b=ShJ4JkW9x5Hx6vCIisDBFqLM4D5vass+jQGAMdzXLWSDHP3UIdENKnfd55AUb6ZB4s
         xysaZBQLWwi+Gq+uiXmTndc+34yaJPI3senkZ+aeMym/ujqLk/NhYZfdz9S/kBaje6Zs
         /WDxeYXfNBrDH0IqYIE1CcgmHazc/2H2V4GtM64jKbB2IcnEEPEMdFBGykHqGU/s/iBf
         j7J0kVA/6Oz0VIqp/eLXXwdP+LX5Vgd48tIIh9K9N5tY0FUXbBFifZy1lsh9fsyTsdEC
         3My8qqnVw47vFyzwHrwlTpR8LGz4orfvK33wIjO+fpuMZ8ab1fejrAzqnnizYqTFs9Mu
         FRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703728001; x=1704332801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWOr9qiisUkjpabZ4ff5uQEtv5SlwPvl6ptfPUH6+qE=;
        b=mNxwIr+DBoz2UQdJM2vuHtUwdGB2oM7nUDXECCXmpOYbA0t4Ca9Gshx9X9qMyeF+cx
         plqH6njUJyDuU64cATMBEeHLcV2stXgtlzFccwuYV7GGIqlWp6D93hsjnXr5essqDvxd
         wyQH0gUwu9+lhbTk8Nhjhz6IXg5XrxcCpUsJVWyOXY0Gg1PQWEDvT6QpxkPvOJzbFA+7
         +mdBusd9Kb5FBjBZIaxn4O6fxib829fwCPt2/pxwRpXS7FFRRVZpv2hOOVjyue7neR2w
         jCQj5scTjbxdEm2Mb96Pj9OtJSxdbfs7v1uTQA/XBxo8io/1G6Matg6XShqjxVOrl4as
         ohKw==
X-Gm-Message-State: AOJu0Yw7GNXbGe9VFJt9zeJK/crgVVoTfmEe6NGpT0BU3fAITrF+icEI
	mP26C7h0wd3dMzlfAF+lk9x4QIETH2lC4Q==
X-Google-Smtp-Source: AGHT+IGMPegCJ/F3qJEJmMCzk2K1vXg812RpdKQudnYzc843wiuvK4+uTcbD78Ik+CpZovH3zIE59Q==
X-Received: by 2002:a05:6e02:154e:b0:35f:eba8:4e36 with SMTP id j14-20020a056e02154e00b0035feba84e36mr8828546ilu.23.1703728001425;
        Wed, 27 Dec 2023 17:46:41 -0800 (PST)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id u26-20020a63235a000000b005c2420fb198sm12159560pgm.37.2023.12.27.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:41 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 5/5] netdevsim: add Makefile for selftests
Date: Wed, 27 Dec 2023 17:46:33 -0800
Message-Id: <20231228014633.3256862-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231228014633.3256862-1-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Makefile for netdevsim selftests and add selftests path to
MAINTAINERS

Signed-off-by: David Wei <dw@davidwei.uk>
---
 MAINTAINERS                                    |  1 +
 .../selftests/drivers/net/netdevsim/Makefile   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index dda78b4ce707..d086e49eac57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14853,6 +14853,7 @@ NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
 F:	drivers/net/netdevsim/*
+F:	tools/testing/selftests/drivers/net/netdevsim/*
 
 NETEM NETWORK EMULATOR
 M:	Stephen Hemminger <stephen@networkplumber.org>
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
new file mode 100644
index 000000000000..5bace0b7fb57
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = devlink.sh \
+	devlink_in_netns.sh \
+	devlink_trap.sh \
+	ethtool-coalesce.sh \
+	ethtool-fec.sh \
+	ethtool-pause.sh \
+	ethtool-ring.sh \
+	fib.sh \
+	hw_stats_l3.sh \
+	nexthop.sh \
+	peer.sh \
+	psample.sh \
+	tc-mq-visibility.sh \
+	udp_tunnel_nic.sh \
+
+include ../../../lib.mk
-- 
2.39.3



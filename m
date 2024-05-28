Return-Path: <netdev+bounces-98430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342678D1688
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76F11F224B1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E113C9C6;
	Tue, 28 May 2024 08:42:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD813C830;
	Tue, 28 May 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885760; cv=none; b=BxhzuGSWLP2+F75d6D/3Cr+0CrMxV8te7clSrNd/ysSDRorqhNMfrmA3w5ehZrGQDuQADN8mUcS1yIdsuF8m8cWugz++M5cMSH8fPvL8i/xbzqFNL5teHn2zMLrUcfeuq8TQCsCehWSAVLRj52rF6FX7sjoOCTRV4gfM3lsI/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885760; c=relaxed/simple;
	bh=IHyNigSCLQ5VlvilEwW2sJrDDZCTJHMR4UeBcHElRZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4nYWNzqi5hT2q7I0YQKvRzNnZwMSKWEEYXJkcokg2VctWRhsu9/f/b2v0AXH5WOZBhsdi4HgcnjvyFZa3acSqdVcOYZ6UFm0AtQa7xeKjPy25D+Zc9XoidtgJVfjFs3iFBozBeNqGIZGu7VniUAoSAFk3DXY10D3WpkQzIy/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a62db0c8c9cso54334566b.2;
        Tue, 28 May 2024 01:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885757; x=1717490557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ44z2IHQxiByRr0eSjAKQIa4cR1QKAIlkWz5epjhe8=;
        b=qaBrSRoprLAE+5BxiW+xHtCk40tCEPMU1MxWYeVjFtfTDL3/qiAtOS88u/6s1a8eum
         OVKTMXJ1Kd7AihIVJ1GlaJyZLhttRJOR3zOpGV8NlVBatMSIqXUkSQYMEtSmPgQxA4Ht
         UB9TON1rT4eyjjd85Q4+04qQ9wvXANmhtHbn8YTgf2zrBcJ3AR9KXrb6hl4FVYnxmEb2
         p935beLUWyLaEtKVA6DQvNor2Ar4xE4atqq/W+xMRcsdX3f1aZIq6qvUyI4wy40Udgt8
         fSmN09VNMN8USHTpJ9E0poKjktRq5f33LkQZugIZXxaT446Mrtpl/svpSFfJpgUY8WgQ
         /Fbw==
X-Forwarded-Encrypted: i=1; AJvYcCXvTx50oLDfsmB2QFevmVGFjRM5sOrrdY0XgajmXu5ymyZ2qYWt1Tcw0gJ8gpylGs3nXez37loyKP5UA6obs5Blr62VFF5r1fZXa6vBQqqOC1LU3XdB4ebx/0MTaxor091eOoW2
X-Gm-Message-State: AOJu0YxeZ6rPaxVKdyycHg3tWLIHxPXTPkR/qkuW5KTV4Hm5X7GX6uYc
	qy8VNTp/gy3ZtgjAthWlTIR1uB03prahyK+LRJ4OB3kNtOvCYn/k
X-Google-Smtp-Source: AGHT+IFAfYURkEKf76uBbY6pmEQlOS9NF66sT+vvMi4En1lUcGLtb6hlllzWJpFrVof+7BIXMaDgUA==
X-Received: by 2002:a17:906:f1d3:b0:a5a:2d0d:2aef with SMTP id a640c23a62f3a-a62642e7322mr1112803466b.21.1716885756902;
        Tue, 28 May 2024 01:42:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c0cc372sm588031866b.0.2024.05.28.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 01:42:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: thepacketgeek@gmail.com,
	Aijay Adams <aijay@meta.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] netconsole: Do not shutdown dynamic configuration if cmdline is invalid
Date: Tue, 28 May 2024 01:42:24 -0700
Message-ID: <20240528084225.3215853-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a user provides an invalid netconsole configuration during boot time
(e.g., specifying an invalid ethX interface), netconsole will be
entirely disabled. Consequently, the user won't be able to create new
entries in /sys/kernel/config/netconsole/ as that directory does not
exist.

Apart from misconfiguration, another issue arises when ethX is loaded as
a module and the netconsole= line in the command line points to ethX,
resulting in an obvious failure. This renders netconsole unusable, as
/sys/kernel/config/netconsole/ will never appear. This is more annoying
since users reconfigure (or just toggle) the configuratin later (see
commit 5fbd6cdbe304b ("netconsole: Attach cmdline target to dynamic
target"))

Create /sys/kernel/config/netconsole/ even if the command line arguments
are invalid, so, users can create dynamic entries in netconsole.

Reported-by: Aijay Adams <aijay@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
 * Use IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC) directly instead of a
   external function to check if dynamic reconfiguration is enabled.

---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d7070dd4fe73..ab8a0623b1a1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1262,6 +1262,8 @@ static int __init init_netconsole(void)
 		while ((target_config = strsep(&input, ";"))) {
 			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
+				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
+					continue;
 				err = PTR_ERR(nt);
 				goto fail;
 			}
-- 
2.43.0



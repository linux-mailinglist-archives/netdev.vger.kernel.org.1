Return-Path: <netdev+bounces-95387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640008C2220
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1892D1F21262
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E43130E39;
	Fri, 10 May 2024 10:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90554677;
	Fri, 10 May 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337027; cv=none; b=LIfM1u4qCrqanODVD+AcSj7V2M5nmJKEpEqqdu87t554QVhb2aUElPNF87gI62xTMDXrN/El3GZ4ZULTxXun9OHYEq7ovF4OES/cNnk64eK5ddteUoK6Je2oBKQ6KJyWxvkxu3/njsYNY7ElxUMiNuNMOys6t+laXxiYr4pCTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337027; c=relaxed/simple;
	bh=xFhHz1KjXpz9Rv+VlQW1WOjFDZBJOu2NMH+tMzfpL+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJTojW/J3gS02x9qGaG1fQ5iZI59cOjjgrDfnUGtUnbDP668sAdPyNmySQOJlE90jSEePLF03v1tg8+q3aVZfEUb2LdO+Msqld4KdJ2+gk+ogxML/I5FqR1d4R14IXObfevUgcVBk2/GdAiPytAxRN8AQfoHWq0OvcGv+toly3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ffff16400so3074791e87.2;
        Fri, 10 May 2024 03:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337024; x=1715941824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cpd+1uI5omhYD2wj/HwWULTJmMXVCOfVodGWbcrp/kg=;
        b=ffY8t9h77KCvFn0aFPMxBFuTKRcGmVhz+S9BoRI2FQy6poISe/uqYfzr8IbGdKaeF1
         jYeU/0/o/FTQ4IQEfKdIvDDgCH2qWat4VgHvmkYQspCOT4ns1O4pyfslWVTxJLSvOqcJ
         WaJ4IdfN1uzrWCs21uLQZKAhCXPXlh9A34QMR75go1XpM+LZUbFvA6Mjx5CxSmy+wIJd
         DSxAtNNbaBwPJD5aN/Jycr6Jijo6v9qvOUt4g0kkvoXIq9SAYDimw6H8fMByYF9BdxOv
         czs20VcqINOVNmshqWbaxKMwG7qtfLYJ8ywMgWMSg7QdQ2R6nQuk6gg+2ix4mHpnhRBv
         9suQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnKsUhiELTnOrWWiNrssDqMrntk6M5Zh2b2RbTIJVJf/iYWiCfxqDKbu7tauzsVjR9YWBJew8sEXs3SO8qvH0utaglNdAbudpfG1mzGgw6x07ApaSqAPBEkm+cyd1jY06muDub
X-Gm-Message-State: AOJu0YwNo4WGqjnYkF6dlF3/lt6JQ2i99E0lvTGnfe29FOGQhwIGn41g
	P900ztK/B4i+d5EG9ErnxScSXFvL76OALEMHiAXSk3Re1b9OkFeK
X-Google-Smtp-Source: AGHT+IF6SR57niQ6ZbUxHCPC3Q5Me6vEJFxgwq2p7jJwy9dYqNyIRsUhZIkZH4fkpsOv97w7jk84lQ==
X-Received: by 2002:a19:c207:0:b0:51a:f11c:81db with SMTP id 2adb3069b0e04-5220fe794b0mr1561407e87.30.1715337023305;
        Fri, 10 May 2024 03:30:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894eb1sm168791566b.77.2024.05.10.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:30:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: thepacketgeek@gmail.com,
	Aijay Adams <aijay@meta.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] netconsole: Do not shutdown dynamic configuration if cmdline is invalid
Date: Fri, 10 May 2024 03:30:05 -0700
Message-ID: <20240510103005.3001545-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d7070dd4fe73..e69bc88c22a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,11 @@ struct netconsole_target {
 	struct netpoll		np;
 };
 
+static inline bool dynamic_netconsole_enabled(void)
+{
+	return IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC);
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 static struct configfs_subsystem netconsole_subsys;
@@ -1262,6 +1267,8 @@ static int __init init_netconsole(void)
 		while ((target_config = strsep(&input, ";"))) {
 			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
+				if (dynamic_netconsole_enabled())
+					continue;
 				err = PTR_ERR(nt);
 				goto fail;
 			}
-- 
2.43.0



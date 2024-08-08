Return-Path: <netdev+bounces-116833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5BB94BD68
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD742879BC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275118E76C;
	Thu,  8 Aug 2024 12:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2C18E044;
	Thu,  8 Aug 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119937; cv=none; b=N1+wYKZJOMGzicGTgjm+Skk2+X33zwmjELhrIjsW+DXnvzj8VYA8/S8nX1BbIHOGBofwBJURVRt3TZLCiAJ983FMitgcl/pYUtdeBm9w5j0bqg3+t0MJsX7/MEigt82R1/nizZrA742CZGw5AStUYDwgiVwS4Ov2PfqYZmXMmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119937; c=relaxed/simple;
	bh=nMXJenmlaaysU0JQZeH02SdjKwMQW62YdqF+yVs0neI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAfGxRwN/DMlcFJY0vuFTspGx5R8MbeMeLXiyEx/jYmZkYDdlEKrcs9MNzpYXrEx5hsDR84eGPfwMbjKAU1Sg/bT0vLrLFAdlQjBLi2HI9lTM7IdygyGB3ZVkQ+OJA8se2b+oIHMdLgZZTsxBatwVcuT5QncljQ3cFF3VD9eX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efbb55d24so1567642e87.1;
        Thu, 08 Aug 2024 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119933; x=1723724733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PEQPsLBLzyzK/qbQY0aDtr7vNIA7SxB8GpCInNcz9w=;
        b=la9nkJoKDPZS23B4FXu/EHw5DwY6phSz075KiZceO05iy67Qwm18JPPVY6KXJmj8l6
         pEhgv1qL5rgcTKKjb0FFRtf1saseRo0t2/1jEqFQl5cx3G0qncKvreyiWCcV9V7JxOpU
         tu0ZwlbCmpPvyJBLOE48CpejYLrLWoWis3a6RMP9JNhanKv1e4TtykSn6ZsiL03Lqtr4
         AfCltNz8IBUgEmbhUZ/haPQPKUTvs/tq69eBU54FnTArbsEY3OL3Va89MB6a5FJEXoxJ
         VwOV8J1iig/czrKFKgLRgDwGRLe9w0O5m6THtCHdY2Xr3AfwwZvTfc1s6cIPIqcNR2RQ
         op1w==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z5BAsH3tuvTgo/1isAd7c+d+QVHsHp7ebsk+wx24lN+SPN1mjHZlVNCGciC1ztUVd5Ns7LHq0+eUhDUzIY7pncDV4ISj+aGIO9jfHFWfi2eJqv1CPjjlZH2vVNA0CZlKm/Bw
X-Gm-Message-State: AOJu0YxKGjvX5HK20ce3F/7R3JSHsrE8fWZaWSNrL+HQwdQ5rpufAWmF
	R7s3IToZqPS5/sZv3fKAoylFcn8X9a0RhWWn25ilP6cP4v1NsHwz
X-Google-Smtp-Source: AGHT+IF8Pubd0VyAZXyy3Ohp4CO6hSPwIxATlhMwYmw8/uu0Bjz4xAzODW5HzfiAaOTfaoLrSYiQdg==
X-Received: by 2002:a05:6512:31c6:b0:52c:dd94:bda9 with SMTP id 2adb3069b0e04-530e588c933mr1596695e87.56.1723119933087;
        Thu, 08 Aug 2024 05:25:33 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cd0sm751449866b.11.2024.08.08.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next v2 3/5] net: netconsole: Standardize variable naming
Date: Thu,  8 Aug 2024 05:25:09 -0700
Message-ID: <20240808122518.498166-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808122518.498166-1-leitao@debian.org>
References: <20240808122518.498166-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update variable names from err to ret in cases where the variable may
return non-error values.

This change facilitates a forthcoming patch that relies on ret being
used consistently to handle return values, regardless of whether they
indicate an error or not.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b4d2ef109e31..0e43b5088bbb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -336,14 +336,14 @@ static ssize_t enabled_store(struct config_item *item,
 	struct netconsole_target *nt = to_target(item);
 	unsigned long flags;
 	bool enabled;
-	ssize_t err;
+	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	err = kstrtobool(buf, &enabled);
-	if (err)
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
 		goto out_unlock;
 
-	err = -EINVAL;
+	ret = -EINVAL;
 	if (enabled == nt->enabled) {
 		pr_info("network logging has already %s\n",
 			nt->enabled ? "started" : "stopped");
@@ -365,8 +365,8 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netpoll_print_options(&nt->np);
 
-		err = netpoll_setup(&nt->np);
-		if (err)
+		ret = netpoll_setup(&nt->np);
+		if (ret)
 			goto out_unlock;
 
 		nt->enabled = true;
@@ -386,7 +386,7 @@ static ssize_t enabled_store(struct config_item *item,
 	return strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return err;
+	return ret;
 }
 
 static ssize_t release_store(struct config_item *item, const char *buf,
@@ -394,18 +394,18 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	bool release;
-	ssize_t err;
+	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto out_unlock;
 	}
 
-	err = kstrtobool(buf, &release);
-	if (err)
+	ret = kstrtobool(buf, &release);
+	if (ret)
 		goto out_unlock;
 
 	nt->release = release;
@@ -414,7 +414,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	return strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return err;
+	return ret;
 }
 
 static ssize_t extended_store(struct config_item *item, const char *buf,
@@ -422,18 +422,18 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	bool extended;
-	ssize_t err;
+	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto out_unlock;
 	}
 
-	err = kstrtobool(buf, &extended);
-	if (err)
+	ret = kstrtobool(buf, &extended);
+	if (ret)
 		goto out_unlock;
 
 	nt->extended = extended;
@@ -442,7 +442,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	return strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return err;
+	return ret;
 }
 
 static ssize_t dev_name_store(struct config_item *item, const char *buf,
@@ -469,7 +469,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	ssize_t rv = -EINVAL;
+	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -478,21 +478,21 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	rv = kstrtou16(buf, 10, &nt->np.local_port);
-	if (rv < 0)
+	ret = kstrtou16(buf, 10, &nt->np.local_port);
+	if (ret < 0)
 		goto out_unlock;
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return rv;
+	return ret;
 }
 
 static ssize_t remote_port_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	ssize_t rv = -EINVAL;
+	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -501,14 +501,14 @@ static ssize_t remote_port_store(struct config_item *item,
 		goto out_unlock;
 	}
 
-	rv = kstrtou16(buf, 10, &nt->np.remote_port);
-	if (rv < 0)
+	ret = kstrtou16(buf, 10, &nt->np.remote_port);
+	if (ret < 0)
 		goto out_unlock;
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return rv;
+	return ret;
 }
 
 static ssize_t local_ip_store(struct config_item *item, const char *buf,
-- 
2.43.5



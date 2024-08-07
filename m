Return-Path: <netdev+bounces-116382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007494A40B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD033280CB8
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78351D2788;
	Wed,  7 Aug 2024 09:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C711D174D;
	Wed,  7 Aug 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022245; cv=none; b=c8T+HRBioIiwm0bwHZ1/cPwKPXSmFyH+OOnZn0fPwG+1hvkUnltXriRLjKSlEdNKqzh8yGBTsTGWcLofrI7j31KIQPh3GAgDV8xA8DHnI5Ux4KSzhcXn+ASBnSGEZFOsU4ddyyo4wIFU2t8NIPqwvEuTj/4WOxskm4GNvlwSzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022245; c=relaxed/simple;
	bh=nMXJenmlaaysU0JQZeH02SdjKwMQW62YdqF+yVs0neI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9qVnlElbCgxW+lsLUh54C+blWTuIy8xhBCw3Ej2C/99rV5+7laTbks1yHphrDVizlP8Cw4yY26AcQ9yyiLsoWdxbiNJmzN+AMR4h/MzK1VFejD6dtWzVIWkK0rNvPMGmKUVut7o4lLRC260vWnN+nqo4IFzvKcNqaiDb5PRhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a81bd549eso126348966b.3;
        Wed, 07 Aug 2024 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022242; x=1723627042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PEQPsLBLzyzK/qbQY0aDtr7vNIA7SxB8GpCInNcz9w=;
        b=FZIxFpMs4aVNSizyXjhvnUygxp3uleByH5UVh7F73FIogsXCHMO3z5xEbTIh44xtQo
         tDJj5Gett+MMxMbFfo80BasNPc5g9kczye1XON9y7H6tG5Ko6XWXJzRgYu4Pe7KM+g8s
         k4SV5lJchjGKk3dC+a4nUVhqCE08FTnbqG5tdgc9yql702AnhYcWlpdM1quKFv9y8O0Y
         eGby3HulU5pEk0bWfCHKgbLsxm1XwwjaiIPxUrNzX6mRG4eXBp/K0ga1FcNEFEsK04h0
         tjO5XGlvrL/ikcqozpLsGdyLGZwdmvxNUugeQpmuPXrYADUUMgXEo09qWKvM/jqm7C+S
         DKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXttAVzgCTTS+8+5u4erelOcbGxn6ODqhHSDJX2tZDvsF8s0tv1Bg70AFYJQuf+Z4qPD9OeFxkcWP6PLtxoQx9s24ZZkLa67g0EV+YKrktAinLEdZRi1rwpdRTq6uPiuNJu08d
X-Gm-Message-State: AOJu0Yxh6lKrkFKEmU5vt2Jep3RtkXMU5qmKX4FKC9JMQAn27L7A46Fn
	+1SCgDvRxG4tjAxOYJtp7YiHo0SxFH0If0S4WEyswamCZ2Vz3sqp
X-Google-Smtp-Source: AGHT+IGYrrtSvr2abXg42nbVFcuir0UM8yhOizms5GHi/6Q5PfKCLl++XRJ41cKAbXlqIl2mKZstTA==
X-Received: by 2002:a17:907:7b87:b0:a72:4281:bc72 with SMTP id a640c23a62f3a-a7dc51014efmr1346148666b.63.1723022240389;
        Wed, 07 Aug 2024 02:17:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc2asm622541566b.63.2024.08.07.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next v2 3/5] net: netconsole: Standardize variable naming
Date: Wed,  7 Aug 2024 02:16:49 -0700
Message-ID: <20240807091657.4191542-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807091657.4191542-1-leitao@debian.org>
References: <20240807091657.4191542-1-leitao@debian.org>
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



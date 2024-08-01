Return-Path: <netdev+bounces-115067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2494504F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB11CB29C21
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158401BA868;
	Thu,  1 Aug 2024 16:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D21B372C;
	Thu,  1 Aug 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528844; cv=none; b=DLIfTsMKEIIY9pyW6BlCNZSPyfeyLDC/IRa+DIQ9WqXu4J5hPCnxhLwVZjpCp6qnvIH3NddxwN0wUgh272ifwUmSTi9jdEwvDVaNzTNU1V8G8L+PqeK0jMknbuOrKYRgN9h5WaGZAo45C3o6UGHUXZdauVR5VO/Ad1gNcMj3wfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528844; c=relaxed/simple;
	bh=84aBcW6YN3OxvL2Ztisz9NzO1eT9ywLCh52C6F9Glzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGikwbxu1AugRTNtp22XH0ESh3QiwOqhx7GtBSM3RZA2g9lUr6I/bCkOvwZCYqLLNV8NG2FFl0gmaFteKuQOGnJM8Ciw+NMnheGZrK6R7Khf/KuYh5bc+DZ4k0ihDz9EPGZ6o9m0TaavqbYJ+tnvxYxkiwrhznXQHelnbZaTWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so11376362a12.2;
        Thu, 01 Aug 2024 09:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528840; x=1723133640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WTGjpF8ofP7Y59hp4oDRQu/iNhPQ69qU6RnSz0WlhE=;
        b=hW6E6E6iUaRMi8DtGFZZ6+nL4yJNlDxmD8XyuxtBSzh0OzGsiCI9mmxRrTsTDDWY4+
         0u4PO6SfkHSKZWVHt6ftKnU3w28hIB1StWidP+08+G5T+wxBEdAwSxpTl+oweryBFwb7
         Bqvtf6+Uw2DmeQ+Eti60/GRT1sG/H1Gycw4WickowRUyuANGtKTsQurPLys7u1rkJL7q
         27/aPb5kn9dFMVpheTlLPwIQUTHVsnZI5a68IvdofE9Oey89PDy0+EJzaA8MmARoYcmp
         T7EMzGQcBW6hAQDiw7kStHXHWCh12NiR3joYL0Q7+472qD87UI3q/l4vQZnhFApjBR+i
         JbIw==
X-Forwarded-Encrypted: i=1; AJvYcCXc5j1ib4DAJX3gUdqFINun21zz+0iLoL2qKq5y7kJYdp7X5wHW/bxoEsCiiqp8gN3ZsJJYzjpJCpnZRk/iZVZpV/m4rCT30wmrfbsqMomVFfGDzUXQ/YaT1vISXsSjjVMPd7lm
X-Gm-Message-State: AOJu0Yz0DENAWGT4som7OBYfxdc39Glc+eF34EbjYyAgAfp6P6IelDx0
	Ml+d6B206aCd4LkvoPu4arhsdEsEYKUJEo8icUySd1YJTWhYtd8/
X-Google-Smtp-Source: AGHT+IHU91OsjH2erTD293Q7SRKJBwpK0junrFqS8LnZVGUawYDxdO4xK+cBfMHsQOUkwR/6Y8SYwA==
X-Received: by 2002:a17:907:1c0f:b0:a72:8a62:65e7 with SMTP id a640c23a62f3a-a7dc51042c1mr64835866b.57.1722528840433;
        Thu, 01 Aug 2024 09:14:00 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8356sm911164666b.206.2024.08.01.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:14:00 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] net: netconsole: Standardize variable naming
Date: Thu,  1 Aug 2024 09:12:01 -0700
Message-ID: <20240801161213.2707132-5-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801161213.2707132-1-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
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
index c0ad4df7252f..0980a61f8775 100644
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
2.43.0



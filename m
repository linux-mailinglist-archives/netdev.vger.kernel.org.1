Return-Path: <netdev+bounces-116834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B394BD6F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E22C1C2224A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80C18EFCE;
	Thu,  8 Aug 2024 12:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640B18E76D;
	Thu,  8 Aug 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119938; cv=none; b=UywZEHvBIR/HI/j58CME52M5Y5h9esQ4yv85zOt4YSeEl13MDf1Dz7I3S4RJKmmJINJKjHuzQUONQP4FsywGrqdGLWnNjjT2MeBXToIZG74WOaRKHnSgP+/DulZKkCP3JGcku/OQvHAZX3NTEHQAMMpoepk/ZYFLlsKgZvjZy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119938; c=relaxed/simple;
	bh=yTCdFjdAxkHmRI9W2QxfvJzihYP6I5yvau0CWdwzpiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7c6pVrKHwbkndYEaQSMeLQgOAHneVOkryIkXx3gK1NVLDwY4CBzj9gQ2SgLGX4r2MjQqbQJRfjvGCF7eQt6tmCEZsrdSZOud+tmEqfDn1971e5zGrH1M7fuHC9f+2D026a1uU62V5mAxTLq6dlSpeqfShxgp6VFWKYYhxr9Ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso8631451fa.2;
        Thu, 08 Aug 2024 05:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119935; x=1723724735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVSTja/S5Oln97aB6kFN81pfMbhMbR37wyk8sMAq4/s=;
        b=C0C1v9AzraEA/Yuf5C+oUj2yBqSY3Cx2DcAjyUNNvr24Vx1cv2g9SzxhbVLbGEUTUR
         pUI1yHTLc3sJEdziqH44hZ4yW1+1NO5vbY66yieCLIWMlov2Zfrk8NLPeSrTrlZ6qbou
         HyBs+HjJ5vjWr6rH6OkPY0e07xLzv+QSicuaRwYXQ9Ec/51J2TTKlTZENLikzxGbjf1k
         DRLA3Z9FaE9aM+ou96h6vfKsARkqA3UavaTtZ3IS4bfq0OmHVoEwqbIaNuIgqVg1fxHQ
         VilVQFLP3jKyZrBUa9Y5k9C9yMj+cUoka0G7t55mLCwEk00ZuPFbIVb6khyPht6SCmEZ
         Gxlw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoMvzwGNLFuMy/UkKDSIINL8iXUMJr9BMxvokb3pZlJs+kNAGHGm5fi8fPaoxeHIJg22Kjy+yhJPgWvXwFy2HByU2hz8+zdkhz8mzndfgOlGHqnhlBLJT3GuBZbaiXYTjZBs8
X-Gm-Message-State: AOJu0YyOQosTJIikFwIF+oXrQXCR3A4MqVdxTCcY/6kFxoiyRsgmzZGL
	uREFXsUkV+x9C7UidZuFqosuzGyMjQNZD9AfJhwp5AQcFVhpJ5is
X-Google-Smtp-Source: AGHT+IGFgNFqEL3b5QRaV337DBZuadXMMUkXYWwk4fYy+LPCQ2hnTKikQuk7to/oKAdTxNIaC0H/4A==
X-Received: by 2002:a05:6512:3b13:b0:530:aa3e:f397 with SMTP id 2adb3069b0e04-530e5892278mr1374301e87.43.1723119935013;
        Thu, 08 Aug 2024 05:25:35 -0700 (PDT)
Received: from localhost (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8cd5sm733047666b.213.2024.08.08.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/5] net: netconsole: Unify Function Return Paths
Date: Thu,  8 Aug 2024 05:25:10 -0700
Message-ID: <20240808122518.498166-5-leitao@debian.org>
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

The return flow in netconsole's dynamic functions is currently
inconsistent. This patch aims to streamline and standardize the process
by ensuring that the mutex is unlocked before returning the ret value.

Additionally, this update includes a minor functional change where
certain strnlen() operations are performed with the
dynamic_netconsole_mutex locked. This adjustment is not anticipated to
cause any issues, however, it is crucial to document this change for
clarity.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0e43b5088bbb..69eeab4a1e26 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -382,8 +382,7 @@ static ssize_t enabled_store(struct config_item *item,
 		netpoll_cleanup(&nt->np);
 	}
 
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -410,8 +409,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 
 	nt->release = release;
 
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -437,9 +435,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 
 	nt->extended = extended;
-
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -481,8 +477,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ret = kstrtou16(buf, 10, &nt->np.local_port);
 	if (ret < 0)
 		goto out_unlock;
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -504,8 +499,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ret = kstrtou16(buf, 10, &nt->np.remote_port);
 	if (ret < 0)
 		goto out_unlock;
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
@@ -515,6 +509,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -541,17 +536,17 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 			goto out_unlock;
 	}
 
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return -EINVAL;
+	return ret;
 }
 
 static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	       size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -578,11 +573,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 			goto out_unlock;
 	}
 
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return -EINVAL;
+	return ret;
 }
 
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
@@ -590,6 +584,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	u8 remote_mac[ETH_ALEN];
+	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -604,11 +599,10 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return strnlen(buf, count);
+	ret = strnlen(buf, count);
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
-	return -EINVAL;
+	return ret;
 }
 
 struct userdatum {
@@ -700,9 +694,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
 	update_userdata(nt);
-
-	mutex_unlock(&dynamic_netconsole_mutex);
-	return count;
+	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
-- 
2.43.5



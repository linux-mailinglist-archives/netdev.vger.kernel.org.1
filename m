Return-Path: <netdev+bounces-116381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E23394A410
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBB8B24B64
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D91D1F73;
	Wed,  7 Aug 2024 09:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E81D1743;
	Wed,  7 Aug 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022245; cv=none; b=gqsuZmnqsK7Hv6g8wFL9KQzeGwmVJMz0lxH6MhZ216aSX3nqoSlVQzu6PZl170nHTui1D6w7HpLQHjZVgPsBJgyQcZJ1gjp6bHKsZoId1Ug3J74nGrEEPgxbWlfbvZ//AcJMWuwMnWOo56t/iA+LGtumiyb+OZVL/eNj7xXOnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022245; c=relaxed/simple;
	bh=yTCdFjdAxkHmRI9W2QxfvJzihYP6I5yvau0CWdwzpiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucksGjj22EIp2fTHCL3IR8w/cf7Xn7lNySw3TTFXWli52EAMk2Xz875hkcRB1JjWuz6rrvW1KG/UshPeReZ+MubthqDfYWvj0h0c0MPn/HtkuUmi/FD8T79i1YNNhFMBd3JtM/IqcUylSuy5CSCehVi3ALEs4dhDuvBspI3YNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so207381566b.1;
        Wed, 07 Aug 2024 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022242; x=1723627042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVSTja/S5Oln97aB6kFN81pfMbhMbR37wyk8sMAq4/s=;
        b=AxWgYZ3PKb57vRCyKU0CJAiTdqiY4gY2FiiazwfLXcE7B1zRF09xFVVm/20X6S5pVK
         7tCt4Vn92gST9KbJ2bQGgK68hrKdvwQHdcjQarjtzf47GEZgnT7V7HOJAuxOxTKsjOxO
         lWNm7HNJTDBPZ7YvJgk7q7lVh2tH4UU9X1syW3idr28iZJgOIEoRvEEYPo0ZSWfka00q
         3PwVnp6a/pbDUfoEbGssDUejdk1FyM/3e2qOcICAvT4hEMztBe49JBprDBdYazP1+Uf3
         I0wie2HvMj6HCnSSORSbXEesBXbq5dB4c06U7jeaziGygMloKFlt54tKiJ7NVtDflvcS
         7iqA==
X-Forwarded-Encrypted: i=1; AJvYcCX5/TIY1GHx4GYTx77L0NQEiR25snejZJ42EjTnp+rYbqGzHPc8Ap2OP2cg51DHflgtoZz121eKc4d+iQKORs8sAKAx1MnSiQDCJorsIhkaUz6rHEjGt4+ZEZ9ds0xSSmpgHz/4
X-Gm-Message-State: AOJu0YzUmtM7KZfMvyr4O7ALnAYIG81TdQqsDC/gHXesNrFx7pq3qxJW
	lKjLC57/A6V1xENFR0ImV1SZUAu6qrbS6WJUboI5mJ+1ISIgUflm
X-Google-Smtp-Source: AGHT+IGVdO3FE6qqMZblUZHBU3xxPe+gkyCq9/NsIDkefGo5oJJGZifguTy0GzwccAd+JkLcECzD6g==
X-Received: by 2002:a17:907:968b:b0:a7a:952b:95ae with SMTP id a640c23a62f3a-a7dc509f900mr1346526566b.47.1723022242011;
        Wed, 07 Aug 2024 02:17:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc96c8b49sm621728666b.0.2024.08.07.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/5] net: netconsole: Unify Function Return Paths
Date: Wed,  7 Aug 2024 02:16:50 -0700
Message-ID: <20240807091657.4191542-5-leitao@debian.org>
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



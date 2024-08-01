Return-Path: <netdev+bounces-115068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE74945051
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E3DB29C10
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5411BB684;
	Thu,  1 Aug 2024 16:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F61BA86A;
	Thu,  1 Aug 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528845; cv=none; b=WWlseJ2LU0Tg+s+Yqkyy4aUuiM9w2KovDzIEDL27i8B1MPJEAz5YbZtPowF73MzwPoqXhtocbnawhFoBIGnAmwz7c3jnokdep2Zdv9c8YvfBgX5uLcUsj+lPNEMu115cmphiVMWnHchC5WOz7B9vqvvuOa1OSmrIrEtnmfKf9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528845; c=relaxed/simple;
	bh=aH1yEwSC01qNb2na4yUR3FpstcU83pdCY8kuWMCDHhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mILODu2Bje0Lz2dIwu0HY+W/Rk92AAKnhUu64paqZgYOoS32/s/FovvG/1vk+xr8wB6KSJQJ6am/6uG8CvxplIGFHPC40cCWBo73ufKANY4zhbb+5UpbtWJS678kXXiHyhIedkNmjIBHqUpOEHnG8lDYFDSWaSiY5+xbTRhqfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so10833230a12.0;
        Thu, 01 Aug 2024 09:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528842; x=1723133642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW/DNu7o3BWO/l2Alah7sarSMSV5UbORK3y1TxW0QAs=;
        b=LYNIl2LdjIq1g20jWJOcc+RvG5RObZMkFlOiCO3DTJ5O+QYQ6f2P918OpQugrDK7LU
         iF6+/08WkJxBf4+GSsnJMxpjQiYx1pGFBXWyJMpvqmp6Eq/wCTbKCfIaGcqZZO8TIMj6
         dFb+7K5V7yB6zp1MSrg6jvkxw8WCtIoJS8GjYEkjHkHNOIpzn3TdRp7byfRKY+r/8JSM
         KkU7nk/U7XbHGjsmdgQRQ0khKKqy/EpR/7plqmk+VdnQMUY8/CVvQu+sDAy8YARaRA0q
         /9LIWBY0rm5xDioav+XtGfgOrwUHyv8a1kmuH7S9a5NRiWe1ZmemqdUwJB/Q9WLnFUtc
         czAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFwCRo9OK4yiNJ0VvNnGVTlDcNkEaGKCEp372Z8aL28oV98qEdIgrkG6FYD3Wtabip9dzJLLiq+kfBWWwigSOxKK8aPC0NAmWFz6lMjMScR2ZCVfcR37PP1XB2Nf2K49TFmiNa
X-Gm-Message-State: AOJu0YxJy+PiC38m63dvZrVb0h/2ILxEbg5Yt3Vrq48CXR3SEmPlmWzI
	eLwy/EmtD2d/drzVaRfiEehfP4De9l44WS4ALU4cOhwu+MwO8p0g
X-Google-Smtp-Source: AGHT+IFmvS5csQdGU6mRHJKFsi6PI0N5TyaCieoOJxkkJIMlgbz2xRxKaOLoRY804k4r/7USdh7i+g==
X-Received: by 2002:aa7:c994:0:b0:5a2:69f9:1fe7 with SMTP id 4fb4d7f45d1cf-5b7f5dc1552mr613392a12.35.1722528842155;
        Thu, 01 Aug 2024 09:14:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb318dsm10410138a12.68.2024.08.01.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:14:01 -0700 (PDT)
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
Subject: [PATCH net-next 5/6] net: netconsole: Unify Function Return Paths
Date: Thu,  1 Aug 2024 09:12:02 -0700
Message-ID: <20240801161213.2707132-6-leitao@debian.org>
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
index 0980a61f8775..eb9799edb95b 100644
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
2.43.0



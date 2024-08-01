Return-Path: <netdev+bounces-115066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5B94504C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47450283C70
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88B1B9B26;
	Thu,  1 Aug 2024 16:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEC13B79F;
	Thu,  1 Aug 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528842; cv=none; b=pkDQXnt3bsqa12MKw6Wdi6Hc/832FtbPRnD0yRzeBqs7pyOhIRJ6BNVBoUmefriecgdYVcqNlJGwEnMpsG7yVndmPQhdrF8bT3ZaIHwH1vqmTcD1MIg9pxQN2YuB2v4do9G9gbn9d7OI2bp1iQ3ENdxni3gq/1t5pvABDKCgn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528842; c=relaxed/simple;
	bh=mMQmVObRVBuWpAB2ikI7wWAApPb3vfqPeQMvLpJnzME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAFKRF7not90wGlj63y7GhoAPtdJxSJdT7pBuWsxK0n2+ZfkjLuoPRdE6KH+Fe2a51MpagaMLlkOU4O+/cfOSxctZczBUcpXxrZcdmodRKOFX7sPNVukZYa7+/P2o51NcdTErUvT6aLO/KpOHXXIGJ9Tp1PjEcbCfdyFieR4ZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd855adbso10304044e87.2;
        Thu, 01 Aug 2024 09:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528839; x=1723133639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWWsP5Srxsq1NtqWc5nLvTQoERQAcCDYt/rgvLjpdoU=;
        b=EMuby2MHBU9FfykT/XnE6mTJn/sPxb+LTHxBckWxld5yDrrPBRde1JWIzM91NA1kDr
         78syiDVzm3gvW95R2P9wrExje5bvc/tl5l5pHLxN/7LJIoKldwxp4evPTF2xgZ2x3V3o
         WdUtjvB2WjUisAPns3c0pTesFnzWtEccvEsuhqTXUeEt3/MjziLC3wb3QjxxaKfRpLNO
         CTvqrBjr+DeV/JVD8f2s1X8SoLz3uzuic/z01i6aaf68a6F/x4qBJhwtmKUjNQ3FBXJ/
         +A8/VbdsEML5k1h8JxeQ4QFoYn1UUs06hVF4dc1pjEhe+3FKj67gHtySaAXsRiAqw2CR
         vgbA==
X-Forwarded-Encrypted: i=1; AJvYcCUPswcZKYV+SQIw6KYx1JYSZcUpU9nM/R9CpYGjSMD0h2WyPmQtt9o+huRxShjZfVGFT7BtWE0Ka3lH7HX0TJbm47puOmVTNxjHHMDTn6s7xrpzvqzL4L2gtHmEfCYoTXtrbtRo
X-Gm-Message-State: AOJu0YwGeP8Ii9fUdo5skWaJIzpLU4z8kSIOBR9hqckq9jGIbx3w6H+0
	z3iYz3iu4cr0MEqjYWjPSplsdeLyxeL8qfgKbIr4S58NB7gL3+gr
X-Google-Smtp-Source: AGHT+IHQ/aEe586XoVR7BG8EBKnNuvXVAIXWefDS4eDr0W1uHCxZ0ZiGCnuuUF3kX0aKcKj7FY3kBA==
X-Received: by 2002:a05:6512:3c82:b0:52f:d090:6da6 with SMTP id 2adb3069b0e04-530bb3b47b0mr306256e87.55.1722528838631;
        Thu, 01 Aug 2024 09:13:58 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab535a6sm912583966b.88.2024.08.01.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:13:58 -0700 (PDT)
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
Subject: [PATCH net-next 3/6] net: netconsole: Correct mismatched return types
Date: Thu,  1 Aug 2024 09:12:00 -0700
Message-ID: <20240801161213.2707132-4-leitao@debian.org>
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

netconsole incorrectly mixes int and ssize_t types by using int for
return variables in functions that should return ssize_t.

This is fixed by updating the return variables to the appropriate
ssize_t type, ensuring consistency across the function definitions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9c09293b5258..c0ad4df7252f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -336,7 +336,7 @@ static ssize_t enabled_store(struct config_item *item,
 	struct netconsole_target *nt = to_target(item);
 	unsigned long flags;
 	bool enabled;
-	int err;
+	ssize_t err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	err = kstrtobool(buf, &enabled);
@@ -394,7 +394,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	bool release;
-	int err;
+	ssize_t err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -422,7 +422,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	bool extended;
-	int err;
+	ssize_t err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -469,7 +469,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	int rv = -EINVAL;
+	ssize_t rv = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -492,7 +492,7 @@ static ssize_t remote_port_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	int rv = -EINVAL;
+	ssize_t rv = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -685,7 +685,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdatum *udm = to_userdatum(item);
 	struct netconsole_target *nt;
 	struct userdata *ud;
-	int ret;
+	ssize_t ret;
 
 	if (count > MAX_USERDATA_VALUE_LENGTH)
 		return -EMSGSIZE;
-- 
2.43.0



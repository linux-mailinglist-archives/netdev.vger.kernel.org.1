Return-Path: <netdev+bounces-116832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543894BD62
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4582B2304B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B318E039;
	Thu,  8 Aug 2024 12:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEC18E029;
	Thu,  8 Aug 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119934; cv=none; b=MNAYjya55aCW7jCbp/GnSkMxQHhJZs5KmvnHJRf2ZKZxLYFR1VKomqEGcxdWoVZ678Kj4jZqFIAJgpas53kZgNpBcqOpFzreX/comuJsaHbY4BThiI9qAiBwj7e9Dmg4iwDiaIUbmQKt8+2gzUjSJuzb5p9u4u2i9XON2HY1ogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119934; c=relaxed/simple;
	bh=uNPMmyO2gJaRHLVOL+/dVDGM5xdsI27/SpA8OMMZpis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CufOQ2xcRQjpmL9SrxS1+2Jws0gCA/WxBM0cyQw9e2KvPm8GhoEvYhacu5131/DuvXIMzGHKXUIC63oKm4AgzrHpebwhxllOv2bvotHJrQhfylpXZFh9jOKdsH7BgCVdLsk4L8cv9fd/TZVXuTWSFjiSzntQncYyz3q0tvSepEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so88700766b.0;
        Thu, 08 Aug 2024 05:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119932; x=1723724732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KhhVYpxynjfN7h4t5a1WXRfToCFw5V8n+fHSGGgbFM=;
        b=V0IxGmnWfeuy9qZDlW7gakVxPGeHDMkdnEmp3fErbgdoNurLm/hAnQZVYIdy6gWtDB
         UNOlc2gpVLo3zuX+F8YaA4vedY5Nz/pmQEkn5KdYDJS2EBuog6NYsGIyzVh0k15FMHpW
         aq7Lq9b/oq4t1nk6LmumLfRsjkBlGRzKgzTZGl8FvFq4b7aWl8XsEZP6bTIouPW1M3Yh
         U7shGAL8c1YQ6MX7SZDheBC1Mm+eaIrdpDtg5sMjFfrhabOAODdaOjt+4IoAA9HkeLvK
         iLOdKQenWBIgUndPC59AtZ5VWnjifh8AEXABB1bNapeK3I0/okPmrNog6PKt9cnUieFX
         bXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZr3Gq6IYgqm8oF0jycTlPqbR5eANoOcdjNWyxi3bPS3RgVGQKPmocfSyUOPL+wjLjj6L7QflIAq1X1SM+iE3U80w7cemdinTgnRYItlzk74Gus3XJauwWrKPlz5vEIgX971em
X-Gm-Message-State: AOJu0Yx/xUGh0ghefPUpFo8T3+SUS/SiDS57Xi9Q45VlDUJwOtazPGXm
	cNBP4frfwgCgUD93g63zrkgrAffA6eQJXZvXDTRqhVu6rAco1d0/
X-Google-Smtp-Source: AGHT+IGE0v3w8mV3R26kohgNkIzIE2idRulRz3a9k+sHNowvjgfs8zGyd97KjnKKs5cGdjHupRKAGQ==
X-Received: by 2002:a17:907:f756:b0:a77:e48d:bae with SMTP id a640c23a62f3a-a8090c6b6d6mr133994466b.28.1723119931268;
        Thu, 08 Aug 2024 05:25:31 -0700 (PDT)
Received: from localhost (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d88741sm740044066b.150.2024.08.08.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:30 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] net: netconsole: Correct mismatched return types
Date: Thu,  8 Aug 2024 05:25:08 -0700
Message-ID: <20240808122518.498166-3-leitao@debian.org>
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

netconsole incorrectly mixes int and ssize_t types by using int for
return variables in functions that should return ssize_t.

This is fixed by updating the return variables to the appropriate
ssize_t type, ensuring consistency across the function definitions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ffedf7648bed..b4d2ef109e31 100644
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
2.43.5



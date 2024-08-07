Return-Path: <netdev+bounces-116379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB694A406
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB59282C27
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17301D0DE3;
	Wed,  7 Aug 2024 09:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC01CCB32;
	Wed,  7 Aug 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022242; cv=none; b=a1n4V1POzSXhU3z9eXwoTKviwYu7ZBO2Y876Gdsr6FFY79Ype1V26GvnyPlmClx3tRWxGsW/1Beqm7SbIVGcpvvbQpHzK/8D9ClCvh1OBtvlG3q6kpexqVJjjEn682kvdmC3bs4OLzi8i6Ol0cWLICzql2lkhWqBckefH5l6WMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022242; c=relaxed/simple;
	bh=uNPMmyO2gJaRHLVOL+/dVDGM5xdsI27/SpA8OMMZpis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkiG8K892hoxIlBY7Xb+99Z3hw/nGstLwhKpiJTWTsDbN0cZchIeQqV6jYnu8vtsh4bXWpyzTWeiw9We+LlsgUMKaWsnjhDZH29Em5Boc3MGpy3Fach+xjxwYGikYwwKib9Af1LfZGX89rq7padzDii9LKlCRYJWuZcDV35PdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so2417901e87.1;
        Wed, 07 Aug 2024 02:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022239; x=1723627039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KhhVYpxynjfN7h4t5a1WXRfToCFw5V8n+fHSGGgbFM=;
        b=DgKWBUy10qJpV1qBTzEo50GKZh6uNwi3Vab6RUXF0mOGlD38VwNDQTS4bXX2Vo1R3p
         L7Mt+XRiYMsGsvJwQyXizy4YeXhkcjhO6urbNDHvySaFSIuhRQ0QOGWmEIXOfDO7wg3N
         0lgbaWNZrAa0UqP+ZlJ+TNd+mzkPun4QCVx6Gh07f//DAF6Znv+oS7eHI6d7H43phuGZ
         gyeY7MemZTzXt6/wbRh94qgFfOOiKARt4Aym1HEriYZFYenOABSoPsk3AjMyTo8qeS+L
         x0ehJTgZ0hrwtTT15RmlZ0JuzZr4PTIX0ktljZ/bXIoB/rOGccKnwHVndQ9hv+ex335B
         k6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVuDMnF6vCjW993jr/qG2zZS3Pe4jE+vK+qK5rTVLj+2CO7+F/JISPnyJJpCMv9jz+iq9H53+A80Lhxo0ucSCWTy0FQ3KcgC1mxI8V89PciWArO1BUpTnpMNj+aK/fW+w9e6ZAU
X-Gm-Message-State: AOJu0Yz7im10Ql5rQC/rVH5O1T/gvKTC9XpkbFTkYPGjYJns8p6E6lCs
	GdnPucwph7gElgE434/J5A5XtfjkssSVCHs27Q6S/lkEcuxeGCYl
X-Google-Smtp-Source: AGHT+IEPbSN6BxLnELhXOZlhNhgjA1X84lLNkfmyodMQUmOQ8Yc+dd/5ewUQrwhxl6ob7NjepVPQjA==
X-Received: by 2002:a05:6512:e9c:b0:52c:db22:efbf with SMTP id 2adb3069b0e04-530bb36f150mr12736359e87.16.1723022238688;
        Wed, 07 Aug 2024 02:17:18 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bb5sm623072566b.25.2024.08.07.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:18 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] net: netconsole: Correct mismatched return types
Date: Wed,  7 Aug 2024 02:16:48 -0700
Message-ID: <20240807091657.4191542-3-leitao@debian.org>
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



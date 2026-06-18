Return-Path: <netdev+bounces-300392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVgABp3FM2pOGAYAu9opvQ
	(envelope-from <netdev+bounces-300392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BA69F33C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:17:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=dOFwZzTK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300392-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C615F30599D3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CF3E8660;
	Thu, 18 Jun 2026 10:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F243EA95F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777715; cv=none; b=Y9hWRXd4pnlOhZNttn8mXhNPT75mCrMwAkqvxCCo0jWGw2vebDVRdcEzV9F227nHCn/Hd8yaYK9N5rZSpT/Z2A9rVM+gDnZ/vq8/N5TxscGT92NDXswc+WiouhliHJcvF7DxWLvMGJkC0yPJl4Qnqtt4GyJWs68WF92D9Yk8uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777715; c=relaxed/simple;
	bh=VRaDko0DUVq72GOfqGykoCOU7FMNSQo1WTrbna5YUT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PivDWISMYCe0ZUuc5uFug4wSb4ZocWCjvptKLDbGdKK3edpb7wk8OoJyENbIhE5eKkI1bSXk7qn8cGBBkA5p1rOuiuXFpUtTPOZ60mPFdRK2MJblyXxpd11CVUJcvXtrDIeEEK5dIO6ox7O4HYyJvrHcfV+K6QJvOBvt7NwLfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dOFwZzTK; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45fe59255beso455265f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781777707; x=1782382507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUwaRcs/J+cVFA/Hno8SLSYO8ZO17SVINUvpRUgcPhg=;
        b=dOFwZzTKoCVrcXmwqK8uFqbEqpWXioXM+hvqV9Qr62Zca3Eqj9z1Q4Med0ejhGDKFj
         54CY/XNFnOQnaMVcdsPa6U2w/qcGyGxc1J+Rh2qZ+wL1hiO4T9WWdTdLal4Ycgw3A4jU
         YOhwG/h/3xRVXaUrqeyghCqivEYqSPxAKsCpU6mmKm/Okn11rAPBWxdBn/U6CHiG/LwC
         jlbCxOU4PU2SszRKxGVTSu7K0ehddUI+71kH55I+2/atc4lBOybncNdk/fzT747wThkd
         NLt47sGBfxpJD0SJNiuJMOXbO3+yFqsZqEgRRx1NTMsXuBo8FaRg5u0PxinahSbxQ/HQ
         CZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777707; x=1782382507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUwaRcs/J+cVFA/Hno8SLSYO8ZO17SVINUvpRUgcPhg=;
        b=e5CQHj5djiGghAmQYEMAJQM4MlcDtdNKY5kWeuxVzg8r7svSr0uLCmt1lMFt5R7Gm7
         CfZreA+ppmkYU9qTsrSwXkNZWfIGDuZVQdQuWv0Rb97qL6nNsMSM0pD/V5sMlPDojd7Q
         BXi1XgQebG7ncQA2u2u0RX3wG3x/sQMgCSiP8SBDfYqXtovKY9ShwN5V2I9av5QEOudh
         YGPOF57uz7Zq2VLYLMC/4XX9PJJVjRtYbsxM02Bgc1Ga+9AmcCLQz+FRumn8KY4+AtCS
         yymx74s/EwUwgrjCZH8m0vMlZuFoErUXUYOo36aFCp6IaptjvcnpoWuPwtQt/E4mgavI
         6pSA==
X-Forwarded-Encrypted: i=1; AFNElJ8+CknZ69OGlk45avkzjABK89Ag4zJCaQIFON5KeLyjRh96S0Q8ZyRl/SzCn6C5xhM8k/xkRq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDWjw1p93vnwgzys8Dm3gNF41J+LFS0926seLPXqiXn3aheJl
	XKh+e8KYLYZTQKXaDpU4CKRsRVHAfoSIn4lfV9yzKh+vhZnGTKxcWOBdkv1gzSa8ATA=
X-Gm-Gg: AfdE7clow38N5DyvYKWBaJOK7KF4B9Eu5hgb7tPXmXMseumqRL/DOGk6f8aTd2UiUQy
	y06a7PJXiL/DEPYoxNC4IZt3sZvx/H+WFuUnys2cQ6+DgXR/Y6dlGM+L5KcFyX1kZQxBkZei9tl
	kBHa6z6aCXZnWM09YN/3dIwIfnBEYMuWUYkhdD6qg3S5pGv5W9jwa1EXPs9z3y2AxpCPf2SrRtb
	QG6p1kEmDs7oVJSdn/txCPrOaMYA1mMccoL3gmRycvTueDn5J30oSj1d2N6CjhD2dtvKWHiGOyC
	Boep33kaHdywTRRFm6FuPue+erVqmNIIxEHuZCcrTTWK4f2pqR/4na/PLVogL/PLYcJ4U71zDji
	vajUtmXb0tPHK/o6Wq8vPSwBotTHPmj4r6tWL+6PGVGxzaUpkMU93Zh7kmqoDwbnqhOoz82O9wH
	K9+RWJLjHgd37dbuOycEAGPpesnOZHAoi6ds6tbh/nivJNSfOk7L/q5KvR0UvzFSfk6qiOZEghC
	kak
X-Received: by 2002:a5d:51cc:0:b0:461:a169:f757 with SMTP id ffacd0b85a97d-4623fd87011mr9676750f8f.16.1781777707392;
        Thu, 18 Jun 2026 03:15:07 -0700 (PDT)
Received: from localhost (p200300f65f47db048595530b320b6c5c.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8595:530b:320b:6c5c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f263945sm64066132f8f.8.2026.06.18.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:15:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 1/3] thunderbold: Stop passing matched device ID to .probe()
Date: Thu, 18 Jun 2026 12:14:50 +0200
Message-ID:  <67d4dff187016bdef8fa41c23bb9b6647f1ad41b.1781776904.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
References: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=VRaDko0DUVq72GOfqGykoCOU7FMNSQo1WTrbna5YUT8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhizjo7L8AoeW5ci3hu5TkFc++6olOI7F7kxtZu56XseYO 5rsZuadjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAEzEbwb7P0ulLv9r2yI/FOqf z/lTxFb04sEUlZqe+ll7FJv8Lrzdz/hlKZMSu53TN87z85Yp1x1NVL18ddbDE68cUmTLnmoHhLX 23Pxf/y7/z4bXE+pN1JXUjj783bVWp0RSaPdEjor1+6KWTjrH52N+NqD3jmC7rt51TysLWyfB9t sBVtXzL3j8u9whfbPkrXzvijX3PjisKFxt4FXhUmTzb7eNkIhPkzrfZF6FKGFFJasMRn6Xyq3TG icuc1PTm7S3/u7M6/nVxs+Lt3487GQ7MdreOYhRb4Wpom08/4cX4m8id/lvbDuwpOz0lPUW60Sr v7w9t76uOqeeZVveFYegc6lq/fvVdwm8XXu2gLmHPdgbAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andreas.noever@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andreasnoever@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,baylibre.com:dkim,baylibre.com:email,baylibre.com:mid,baylibre.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 699BA69F33C

No driver makes use of that parameter, so drop it and don't spend the
effort to determine the matching entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/thunderbolt/main.c | 2 +-
 drivers/thunderbolt/dma_test.c | 2 +-
 drivers/thunderbolt/domain.c   | 4 +---
 drivers/thunderbolt/stream.c   | 2 +-
 include/linux/thunderbolt.h    | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index f8f97e8e2226..edfcfc41a316 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1335,7 +1335,7 @@ static void tbnet_generate_mac(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 }
 
-static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
+static int tbnet_probe(struct tb_service *svc)
 {
 	struct tb_xdomain *xd = tb_service_parent(svc);
 	struct net_device *dev;
diff --git a/drivers/thunderbolt/dma_test.c b/drivers/thunderbolt/dma_test.c
index 7877319b1b03..63e6bbf00e12 100644
--- a/drivers/thunderbolt/dma_test.c
+++ b/drivers/thunderbolt/dma_test.c
@@ -636,7 +636,7 @@ static void dma_test_debugfs_init(struct tb_service *svc)
 	debugfs_create_file("test", 0200, debugfs_dir, svc, &test_fops);
 }
 
-static int dma_test_probe(struct tb_service *svc, const struct tb_service_id *id)
+static int dma_test_probe(struct tb_service *svc)
 {
 	struct tb_xdomain *xd = tb_service_parent(svc);
 	struct dma_test *dt;
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 479fa4d265c2..24611f05b3cd 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -77,12 +77,10 @@ static int tb_service_probe(struct device *dev)
 {
 	struct tb_service *svc = tb_to_service(dev);
 	struct tb_service_driver *driver;
-	const struct tb_service_id *id;
 
 	driver = container_of(dev->driver, struct tb_service_driver, driver);
-	id = __tb_service_match(dev, &driver->driver);
 
-	return driver->probe(svc, id);
+	return driver->probe(svc);
 }
 
 static void tb_service_remove(struct device *dev)
diff --git a/drivers/thunderbolt/stream.c b/drivers/thunderbolt/stream.c
index c1f5c55583d0..b28e4e95b422 100644
--- a/drivers/thunderbolt/stream.c
+++ b/drivers/thunderbolt/stream.c
@@ -1540,7 +1540,7 @@ static void tbstream_group_detach_stream(struct tbstream *stream)
 	config_group_put(&sg->group);
 }
 
-static int tbstream_probe(struct tb_service *svc, const struct tb_service_id *id)
+static int tbstream_probe(struct tb_service *svc)
 {
 	struct tbstream *stream;
 
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index feb1af175cfd..d9dec4322aa0 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -465,7 +465,7 @@ static inline struct tb_service *tb_to_service(struct device *dev)
  */
 struct tb_service_driver {
 	struct device_driver driver;
-	int (*probe)(struct tb_service *svc, const struct tb_service_id *id);
+	int (*probe)(struct tb_service *svc);
 	void (*remove)(struct tb_service *svc);
 	void (*shutdown)(struct tb_service *svc);
 	const struct tb_service_id *id_table;
-- 
2.47.3



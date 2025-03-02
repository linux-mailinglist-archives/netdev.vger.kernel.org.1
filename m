Return-Path: <netdev+bounces-170985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7860A4AE8F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FED3B3C14
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D18821;
	Sun,  2 Mar 2025 00:09:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090623A6
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874162; cv=none; b=CTuFQOQyu7CnjgGHCECAiOhVcVO/1arp6UDOOoXw1rjbafWZSINVcOraa/5cG10m1ZrMduBB8jzjXhpzEUwkHgt8ytyY7BhhWA1CxTf3gpVcYjOpVSLZ/or0NqVK7XucFG+Z+SYYlZBzC3VPQwiR1TNrZdhL3YEdqvO6DP3w/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874162; c=relaxed/simple;
	bh=9GiT7L4h1luVUM8cTStiFw368eZQXH488W4KA610ib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmB7MaWisgmEi/hXEZG2aHVp9MJ/w3yAmhqUOx/BshNdgX5uvveecWteviZZPBylNipvqUoc6G6w5kjkrENDKWa0xa4sqdoBZiTxgqfSTsj+/I5VCDoodfN0Y3E6nUyLsyoAR29x3+E8bDjG0k8jdcXTtHKFRiNbJdtnY4wEab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so5347525a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874159; x=1741478959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Utg/GA8D1tIDHyPHqqvW1lSCX2gznfLGXZdJnASz7U=;
        b=BpVfJvgD1e/2azMw6K388L+/FsvRFHlmF92bgTuhh4SP3LpLnPiqPQ4iEuEQdRJYUC
         nRtppRPvg+Uv8fjNyzW2Bm82oFi62uSAh5zbdrkifESIZe4Gg4aWAZpfspc00UNsbW85
         rFReAE9mE7JR1tpUDYgt2/WyLSXIn1nIPS82nkq2ezgLdlQsDWwNLWVw0Kp+uZmYEAQS
         qxbs+OHymZIiY+1TO4Uoa7HNUmN/2MoF5OwRa6e3As1UXFTVziwZSi6s5mpe7ubgDlAd
         qrDZs7YNyNE02PU05fGwDmVt60zxZaL+RUebSFuEk/MkFrVBlg0Ffd4Ly4vuaoK5RiZt
         ndyw==
X-Gm-Message-State: AOJu0Yzbcj6IvuMWCjQXrZ4dkSbsQapAjMjA6GvwJXbkCXD01ABsl+Zj
	BXbYNvmnbbIgKByCKuIzjETbhlcUJdpKbKYHMSYa67G3ySFRZZDpc2cW
X-Gm-Gg: ASbGncvqNntJX5ImA1n95JCY6CVByvrO/pUpvh6Skv75omZno8LAbN9/BgqxUEnM+f4
	EjlqgOzafXN5xjw/UlqOOycoLjcN1ykIhWnGYce+3pC4nkhaIdv2pjfLeTumk2TpgmKVlSSxwiM
	iuiq8AOq/jwjFC+1/MMzbISOjGCDc/1Em2UHXGEKw0E5WTY0TsJ7DNsrmNRNOgByGLmigXjgYub
	XQ2TY0rknOqCKdTj82PrvrYgjtqDMGAcxDo0rxNPpPUfo4rltDG3n9unN1HEwrPGHPSi80Vu5ER
	hTeVDkSpGtzUIJZqQcqS0igMRHIiaaMovYorSEvABGRS
X-Google-Smtp-Source: AGHT+IGpHEg4mdIoarxUa94sMgGjwEYbkUkt9mRFbcPZiI9M1aSLwQxrovbjvKrY9bQfN75VotxA8w==
X-Received: by 2002:a17:90b:4990:b0:2ee:a04b:92ce with SMTP id 98e67ed59e1d1-2febac08d73mr10722249a91.32.1740874158845;
        Sat, 01 Mar 2025 16:09:18 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825a9901sm8169417a91.3.2025.03.01.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:17 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 12/14] net: add option to request netdev instance lock
Date: Sat,  1 Mar 2025 16:08:59 -0800
Message-ID: <20250302000901.2729164-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only the drivers that implement shaper or queue APIs
are grabbing instance lock. Add an explicit opt-in for the
drivers that want to grab the lock without implementing the above
APIs.

There is a 3-byte hole after @up, use it:

        /* --- cacheline 47 boundary (3008 bytes) --- */
        u32                        napi_defer_hard_irqs; /*  3008     4 */
        bool                       up;                   /*  3012     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mutex               lock;                 /*  3016   144 */

        /* XXX last struct has 1 hole */

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index efa0e3755a27..1813dc87bb2d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2485,6 +2485,12 @@ struct net_device {
 	 */
 	bool			up;
 
+	/**
+	 * @request_ops_lock: request the core to run all @netdev_ops and
+	 * @ethtool_ops under the @lock.
+	 */
+	bool			request_ops_lock;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
@@ -2774,7 +2780,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1



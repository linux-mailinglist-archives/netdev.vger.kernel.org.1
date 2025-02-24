Return-Path: <netdev+bounces-169146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58AA42AC1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BA01784EC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38A26658A;
	Mon, 24 Feb 2025 18:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7A266577
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420505; cv=none; b=tN6jrkl0aM0XP7HxaWZzF5Vl2rvRjimMzd8NkvQDLGpGhzAK5q52NP6v8RLD/o6gbHWv0Pyzom0n0qLcOFTvRTCgVNLe29YGPYtO95u8Ia+4/NBAHZR1EiZ4XwNjgYjsLeBnUtCcD5fEYiplYNDP0+UGjWQ3XyU/82tXwATh/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420505; c=relaxed/simple;
	bh=BYyQ4Or5SPWQ4XHDszO3E8l63WKEL0GHs67EpNVfXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3d6e+sZknjjR2ZpH9rMoEzPNCSekMdLGk3RjpmfKusxiE7GagEa9Xb5J6kGR5LvIh40onFd8uh/u/sEhpPNbPT2hVuaBj0Apnqfz/TmaJO1PTi70UI7Z7PJN+v62ZydPxK5ozWM3OgJT4U6umU3yGNy+8sCAiwlR06w+/IxRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8eb195aso104011935ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420503; x=1741025303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4NOp35sSOYqm+YHVCOvaTH4M4VfB98cdG0m5h35A4k=;
        b=Wv3PpWaGKlxCx8VCfRSdgF13J5J31Ygg8gZ9P33DkLOqdf/wrrJUt7BtICXzS1N+De
         uzyA/YkkWFyyxCqHVw8WmILP0vUVsRPYEC4kDXum5TgfQcyMrSZmKvwPNt1wiMzdp1JP
         QhjUc+E4sJRdq4eUlkIDpI+SXNuoBx4yIQqVY69r6uPRzc6++P6ShO6rSPmzXLmGwKaq
         uuvSUWrfYL0D1l9u75Ypcc0BbMDMhO8G25AI0lYzKrCorTl2yIxSZAKFfyVBqlLWYIIN
         b6BFQGpoCDhMjEgEqXkLQBk0zeKR+FIRjxnA7bhmR042+eu+nYtFsC/lTQq426eVr1Y2
         jhcg==
X-Gm-Message-State: AOJu0YyCcWoHcoFZNE9raYnOwjMQEiOlfdJSlQN6HoNxcoNdr/WVaaP9
	Oa4qC73wMUV9/C52voEZ+eAACOxD2sJnsYWJt3WNY6/s0UmLP6tdu8+2
X-Gm-Gg: ASbGncs8aKc2R+0fGL8IfXw9KfnZzmwqY9InckT556LKJHcb0H4u9xq/QVzHaUPHlg1
	M5GwsMfoJrUU3+XSaQSXJ5wCrrrer4B/6er3wk9+zZE0iC7wLoDzbh2RTSPcOo2X/qIp/vGD4cf
	A1ti5jLtr85/OfPsNIZ16Jm6OsWDEbGB3vmbKYkN4uCQfY/nqVp1InBe5+3GW+VE1gVfC6u8BB9
	lgSRF4gosVwSbRlKPJra4ZinIEiPFmigrg1qxNHh4cBQE7OjsBL+D311/SSd0vYxGVpOTF9ewnE
	xTrdPKIYFHgd41knYNvmEoZ2Bw==
X-Google-Smtp-Source: AGHT+IEc/cGBzwJOfTGjuYy9LPSL676pVvLC+AglRzyZ6fAmKyWRkI+PcDMt2d9suquVCB08jdm4ag==
X-Received: by 2002:a17:903:41cd:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-2219ffd11dfmr220387515ad.37.1740420502597;
        Mon, 24 Feb 2025 10:08:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d537d0f2sm183567305ad.105.2025.02.24.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:08:22 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v7 10/12] net: add option to request netdev instance lock
Date: Mon, 24 Feb 2025 10:08:06 -0800
Message-ID: <20250224180809.3653802-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180809.3653802-1-sdf@fomichev.me>
References: <20250224180809.3653802-1-sdf@fomichev.me>
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
index 57dff4cc5cee..b13d5da97f8c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2456,6 +2456,12 @@ struct net_device {
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
@@ -2743,7 +2749,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1



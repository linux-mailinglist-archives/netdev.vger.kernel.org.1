Return-Path: <netdev+bounces-267495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L97F8ontGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D84052858A2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ED0B3123CB7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE3C3B2FD9;
	Fri, 13 Mar 2026 14:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA983B27F2
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413487; cv=none; b=OWfkwuXv2pxNkycZ5VeeXxHBJny2lMnAJVWkg4wtyGmgkbG7WpDi+/1p5Ot9RvvZqyWjps8c7ig9RQn+5v+ncE86lpqwySpMQSdXIhsRkYtMSTH79rwCDt+HGwccGjVi/RCMbARWlaOW8zxr80S2VZKaMSQLKCWHWb3pOtQJnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413487; c=relaxed/simple;
	bh=VsVDexk7cC+vtlmk+AMoUidPoN3fQslFI2z+LwPL5mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UocDyuIvIgsd7JQ8xzxdRx80umFyR/LAYcTC1D+4/rjkWUMwmNR6WisCWUYCFRAN00cKEulvmVQX/OzA3Wekk/+Ehlz1/BKm9AoYcIXcw/PCPVXhNnEpc463INymKNU7jdwL8zKb0zbtOA//3pZueIgSuvhjo8qqBydR6S2usOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2681607eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413485; x=1774018285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jrjqiGF7X/s59EDv7oZIA5gmuR0Lq/+8OKqlVYX9VE=;
        b=N9ovFdRVW/uEJE4tadwXpkfdy4vARUZEp6UoMKTRojaclIDBKCfp+gNzpZmhzIYMEd
         g71KZb/2rLt+S3GnXubDIIMBANjHfwxUbCdZCFv2wqw/jawKhzqerUQ8WzD+8j1w7Wf/
         mUWBInS3z7AIzkxUsUbWRz1UN4WreqJ8tNGO4buO6g5+WnOesxAC/Tmmc+etCYzrnpeZ
         cyPYcFB+C4orAFJbIzW69d+6L8+G1ZMCDIRLNlyr2t390vvEjLRvW3q9kvU/oHDh/cgb
         jSil/EGda2nrVd8r7MLKJ6ys5kAgH565/YU1f86R0ULMCqzEE9x01tHwGl6S+21HvrEJ
         mrCA==
X-Gm-Message-State: AOJu0Yx1o4A8exD30Xxm3kPiI9+IhId/G3PrTNb7PRjD5ag6UeSm8hlR
	JKVxK2ynESWFXPew3B3Zt5v+ZNCfOeq6wPAW41J+h6nMPu1cdWub/mN2S65i
X-Gm-Gg: ATEYQzym6HI1tG9PxZDidmOofnDRIlNsdvUHI1dbIzadjTE63JlNdLrCxgfu0xOr7OK
	XsIRYiOpxU3gpdi/7rjNX9AHVKSxbMUF9Kmrtnuz+lFcS7g6QcWM0V/I8qSZm5iU+uegQEVXlYQ
	6w6Yv3+O7BK/LM4xFnkbyTxHA98lF6kcRYT1jlyGzc3JvC8j7ui41MA9fF/51eFQazQZCsfpkHE
	qTntDT6+Z8LwdQSeiSeAiFA1425cNF7M80NYSgkJ3lK2KLYzqPUbCL79qQd4jKOowy3ArrGNJSz
	s9SeZ/v5tX4nC1Zut/X2PBLvltCoSnyZu16K8VFrDyAx8ldTgkCQ65BE1JX8y8KuQAa6cJE+VHz
	/1naTokQKD/IK2g35rUcIE8FCo9LCo6Jp5HoCMsWaVeu1uTCpSTCdyOK8948rRpq8lCVL4mtfJ0
	/Kxrlz5g1sULubQlHBNW1pwJAoOFuofD0TThpEyGGEzoOixwlsNKiimAXnDpAJRF8puntsvTPkF
	X+rBWv/FaW5gJ9DEw==
X-Received: by 2002:a05:7300:7303:b0:2be:6a7:d54e with SMTP id 5a478bee46e88-2bea53fa143mr1563731eec.14.1773413485017;
        Fri, 13 Mar 2026 07:51:25 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1117sm3384952eec.3.2026.03.13.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:24 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 10/11] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Fri, 13 Mar 2026 07:51:12 -0700
Message-ID: <20260313145113.1424442-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267495-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: D84052858A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through dev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fd974ec317e7..5f8d61384e25 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9775,7 +9775,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
@@ -11467,6 +11468,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
-- 
2.53.0



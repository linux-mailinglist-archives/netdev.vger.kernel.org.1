Return-Path: <netdev+bounces-266978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgsCkuQsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-266978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E3427008C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F65317EF18
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4953BD655;
	Thu, 12 Mar 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E8+SKtWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE73BED7E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309860; cv=none; b=kowF1yIECNLIteGYUml4PWYkIjf47K9iY63xf5bkQLK0265WsrziDO+8RgTNhJTr9Z5DGymyaqV5Ucx4LYsjUrZUij/8rebiXb1UfZ4btOmvlUg91P74tZEQjkbLiP5MajiCFcUZm/wWE20ZXxcnnM0znSUpXWoZoI22yqTrXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309860; c=relaxed/simple;
	bh=KKgpf/IuVUhdHxdP18sDxJ2z6/oTRbCGNRlLhLLutN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgPytYwNlcnxXb1dtxNW5UaAJrWXoFnhqOAjxdKjdC9KqGCWiuFfUre6spFhLNGRoVR/KUomTOyXSoogUtQcviG6LJKlyNhjIq0bwFuZ/Nb8f//W2qpFTgFbnaN4tolxs9WHWhq7l+VM9Et8IanNQsjhf0xIwRP1vvhVB12rx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E8+SKtWF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c944bb62so622399f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309855; x=1773914655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=E8+SKtWFmwDJCxiHR7D6hjewlebDTzmIX5H6aMokblPjp1kdPTCOZAlV75KmK4vPU9
         S1MKdD7SKWApcat42ALG1GNeNl6v+gALfSCMVwOZYiL/eoCG2GhxED0d066M8d1RfM2+
         XyNKfLPNqWqP/1/yJ3TjdfdvEoOW5fGju04J6PktFh2fEHDeMAAr9eEMA8v5+mc35bLc
         2foekThgTl03ePc7gC9H/WIhkQlTFHu+kawL94nkOCquUm0q9jKW0wSBWTMNs5Xe0VG+
         z50iivAWMCL2Nc3iYziO8g79ktvF0fdzlgdZDC6Een7uUjsC2DIPlWDSjyJxeFrTP8B5
         ixeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309855; x=1773914655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=UDB95mOBkVsYaChQIMWdEJE40y8tnoMGzUE3aCatE5YhfTkgblFVQHamkImdSCOiop
         VlVh8bKdQfld9Wgr6Ayk04aOONYxVWtDvySXyK+tEMrJrARnZpawswwitnvdFgtXaLjE
         zAOCrBZsNHnwakJie3lSoqWu8eyVLiR2KcPVQyfMyFsW24bChbbKSQIf12Oi8Nkez6Dy
         O4QHdEeDuMnfY+OAIIWS0t6FcnozjSXdGfDpkXAm+bY3Aflxk4HM6RAqiWdxiOb/im5Q
         AJUZtfkWJE1PAIESIgFk/nxWBMprlgBqnabqcfZHtgYOXNHFXZRKUvy8ynUaHhw5JS8x
         euKw==
X-Gm-Message-State: AOJu0YwNKt+14CkC/YrKfhEwrbtKTcSzRLM4N7pSu01YToulC0vsrJuU
	vr1ezzTMPeOFzs7c9bsNQSKexQBqHBqk6TRSJh1vKzUotZ9vQA6PvB6l8MTRhzB8upAQuJ0Yotj
	dnjaQUFGr1g==
X-Gm-Gg: ATEYQzxdhauos+FIZi5zr/1IuSQcGfa97Zcgdubba/CDh1XhrxJbObeibB5yRXaJCrT
	8trClDahNkeAofXGd+dM4OI5sSBmR9mfev8RXVtiDqmuLZ0J2hRfZHGkZsKGWX76+zMXSwZcKh0
	JILpMAc+ca75vm4NKcpzaWWqu6kaprX3rsblglwihNsi/FrRyEVfusiOb6reVLZgTtmGaZ3RBdq
	dGsUJZ+QkzQ1ElgQ56doz9YiuN59lHozdBNKFQlu93dRdjHADtQhpX3MrPNArCWEY7eEQs6pJ8r
	2h9yecByeRnSt8NwFyskzbfZ4i2g6r4qyKacu/Th2y5VEADxMg+7WfiGJpA5+9etYHfxKgrGje/
	mZYgeP1CozjVz75qFnKgEnZ2Ts9ma6tD1xXrxywqZX0GIsk8E/+6qp8Hi+NVaBbVI6Zgdym7sbq
	rWk0yFXvOYLjkmX+7jWSs3Dzjy
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4854b0bb5c0mr98639645e9.13.1773309854890;
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm97596925e9.1.2026.03.12.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/13] devlink: support index-based lookup via bus_name/dev_name handle
Date: Thu, 12 Mar 2026 11:03:59 +0100
Message-ID: <20260312100407.551173-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266978-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B1E3427008C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- unify return value -ENODEV even in case non-numeric dev_name
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 9cba40285de4..fa38fca22fe4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -203,6 +203,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-ENODEV);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
 		    strcmp(devlink_dev_name(devlink), devname) == 0)
-- 
2.51.1



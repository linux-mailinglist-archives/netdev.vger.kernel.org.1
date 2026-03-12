Return-Path: <netdev+bounces-266980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +gpXDl+QsmmMNgAAu9opvQ
	(envelope-from <netdev+bounces-266980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED182700B0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BDDA31931A5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D193BFE5A;
	Thu, 12 Mar 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KSIjSVQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197D3BE161
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309861; cv=none; b=l0OCeAouw2aRIzrHd03yS9FR5GLXszxSwPZ/AOroO9Zv6IHkozSnjirCBbNT9/moHry6DfTzEFlhBTZCktteVFQLikacwDMuznzAlNQtPSaZpQYw0RXN7dWzakDEvnG6W4s/G56FgmMkf0BtQfPiTyPd9Kk6Cer8bBZFOAA2tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309861; c=relaxed/simple;
	bh=7DRFVjIY+Ygj/L7QkL1uTDqAGAZViCzf/BNmCHn88Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwbffkAgHRJp51lKFOAwaezCXHhaQa+oXf62UU10yHeEsL6rFFEDM658xWZfnmM9JbRKHRp7hc3Zzqq971rEWElaniTdZU/jkIX/t5BeCE9RQm7pS1jADibWD9ZmNdOrS4Y6pdnjuK8NySZlf/fnhAHzGAp23wr6wxwxJiBccv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KSIjSVQq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439fe4985efso678083f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309857; x=1773914657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=KSIjSVQqlLM6E+xIK5q2jBSjB/vBFosH4JkpAltGAax2/BQpY0uh1aIsegW2Nlh6SP
         1oAcecgqEZDMO4kmnlNDXbM57TokOVqNZOnU4mUZx+FdZth5alTWSEkDU29xwIXPcsrw
         ZLubgtFlefLPyEFdGd6n9dzhwTfs8ZsQFixqdmQRp9n3GbdZsGgzxx+z5W8qohb99SVa
         xxeRnv1ri7qvVZImf/lEao+JUZ2xFl0lPgdeu2jdTQl6b94N0SuNcWTQO+VF54T1H8Y5
         mIvPVKelhpj4H/G9kgPcz0aUDLe85NIvTNisS47IdEhrhqGrqlxZmkoKe1CfxakbinCS
         7C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309857; x=1773914657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=NkHRwElMGRhpF8puakYjHbNP0Vd95rGQnn+XeUTkFyxb2qPKcMN0Y78HGp9a6kmkn1
         zhlLp7GK5eNClEbTCuDISaijZ/iasaLlTI9jwAg4gTuLFfz6B7lKDjg9MgngJdvVL+Tc
         yonVW5iuHql9GaI+G+xlSCku3HQQE1SbUvBzBFj6CwcP5QxQYMTD9GnXoTPU/OvABry/
         GvgK2t0z05UtlWIHVPVahy/VodPWY8fWe0JNF8MsmfBaqspj8pQmKpTK5FbSuFmD8Wra
         bKK2CmFlRztY1pITecPKVTEGNCqhczV6WkdKXnjzNGeh1yWzUuELucrJ5T7eCiZbNlmt
         kyaw==
X-Gm-Message-State: AOJu0YwsuVDhNJaBVwiIYZo/UPG5AV2THDnLzLaS1IJ1a2s2qpVFOu3f
	JOOrEHsyzNTShfGp57+wAoK6x/5gLg+ox8s+NcYUpKqTwJ1OBA4FJ6E1NH1J30VxyJOCq9MoJbj
	i07fes6xYtA==
X-Gm-Gg: ATEYQzyDFUhiZ90vP/BDOHHu8+pmpjwxft8S8uB7H1ob//mwvxPJNB54N05p3PAIvp3
	UeF9IrjBpchQxBpvn0/LfcIANBWfS/Xzbep/VPfONZKr5dQvapjfyiRICHqJRYOMfte64tDuKjz
	O4jDRtWruhnUMmHZ26lpwxvO2p2rNOC8YdAjwFZ+6PlEJ0cBStMHxW1786ph5OKUivm5ey0w12R
	Qwz/WieldNSfeZXaNxs8e+SDdtr1SUFwkQl7zaOzEXywATYPf/GMEmiosCR0SxNmxxdJQ7fbSe/
	+H0xe+yMbjTb/c8qZgQ6OEPYreS0K5booCbBfC9WLtTh6CU66obJYRKdOnoRL7VtVZvNxrJcf+I
	XPLob0t4qg8hEJeN3ATmkfTLOi7V3NM6sosPRWx+cr3U4PHrEx0vmE4laisMOTf4oQ7CjgQ/qAr
	O+IyD4nJsT7wcT+Q==
X-Received: by 2002:a05:6000:186a:b0:439:b1c3:84bc with SMTP id ffacd0b85a97d-439f81e297fmr11955825f8f.7.1773309857325;
        Thu, 12 Mar 2026 03:04:17 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm6982812f8f.18.2026.03.12.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/13] devlink: introduce __devlink_alloc() with dev driver pointer
Date: Thu, 12 Mar 2026 11:04:01 +0100
Message-ID: <20260312100407.551173-8-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-266980-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CED182700B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Introduce __devlink_alloc() as an internal devlink allocator that
accepts a struct device_driver pointer and stores it in the devlink
instance. This allows internal devlink code (e.g. shared instances)
to associate a driver with a devlink instance without need to pass dev
pointer.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/core.c          | 40 ++++++++++++++++++++++---------------
 net/devlink/devl_internal.h |  5 +++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 237558abcd63..fcb73d3e56aa 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -418,27 +418,15 @@ void devlink_unregister(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
-/**
- *	devlink_alloc_ns - Allocate new devlink instance resources
- *	in specific namespace
- *
- *	@ops: ops
- *	@priv_size: size of user private data
- *	@net: net namespace
- *	@dev: parent device
- *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
- */
-struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
-				 size_t priv_size, struct net *net,
-				 struct device *dev)
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver)
 {
 	struct devlink *devlink;
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops || !dev || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -453,6 +441,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	devlink->dev = get_device(dev);
 	devlink->ops = ops;
+	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
@@ -480,6 +469,25 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	kvfree(devlink);
 	return NULL;
 }
+
+/**
+ *	devlink_alloc_ns - Allocate new devlink instance resources
+ *	in specific namespace
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *	@net: net namespace
+ *	@dev: parent device
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
+				 size_t priv_size, struct net *net,
+				 struct device *dev)
+{
+	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
+}
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
 /**
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f0ebfb936770..3cc7e696e0fd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
 	 * port, sb, dpipe, resource, params, region, traps and more.
@@ -66,6 +67,10 @@ struct devlink {
 extern struct xarray devlinks;
 extern struct genl_family devlink_nl_family;
 
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver);
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
-- 
2.51.1



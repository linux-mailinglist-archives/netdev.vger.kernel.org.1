Return-Path: <netdev+bounces-260944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DKEJpT6nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:35:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD66198246
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F7083065AFB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492FF3BFE2D;
	Wed, 25 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BCZJ2Gcn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9313B9609
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=KUiwVomYsOjB3jlt/NZDPPDtNtu8wkhFDnWA7qXbZCHvf7HZS6bnvp5tReJ1l2gPo3BymEfLj4KMa35yL4vkmK75Pz8LfIUmukj7x7lwO3CKSjzMQQHHL72jEzRuFfLAChjaVJdhUgsQYYphVnUe8pXruI9Tn7QMKSqW1/2isOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=zeq1qYaapsId/hMjNxT4XCjJUdeaG/At8G0u37BOTM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKPeRwF91B3WRJr9mBzc+ebLl6rDCIR5+KmuFXNHfVizRhGulpIuSXgX0V+pFeerdaqbkIeMit3A/tz2AIQIhnmMkX7JtXwcFfgecMdRu8ImydrO7C/JokqO6l+wx+mM/OAeHs8UiUSZxYEIAszjgpjK2SoBIlvXZe3J5XQu7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BCZJ2Gcn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806bf39419so6446315e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026467; x=1772631267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX2aUB9g6X7V6jOCUdCUrjVSDVEhvqjbcn21mgNjpkQ=;
        b=BCZJ2Gcn+JTSYzmoLKmiSQwiWZzeE4loMgsAfJd6CBvU5qPCkCsfEYfBzAPvVBr0Cc
         42Vu3eBOTPnbeLSYnWf66rTS5ZjI1ahwueEZ5JRvNGke/X1tQYLUW9u1UvtWYiYrxQgo
         0h1zSAz0sehVcaU7w7gZt9Uxi8fubYmOOhPoS3Mv9EBA7j7HbFY0PMaSBJ2gDijJtovv
         HjJ7QIX9KxWlUZhGsGgslYu1Nz4OS24n/KzH+2uQv7W0Gr1/9vMoCS4UzvVw79yacrV8
         Ougsfj46dCeVybaxbwet4iTLmD05+MiQcD0G8ElMjZA4t221nPzWEPyc6ZDv6iyu+ASa
         xZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026467; x=1772631267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dX2aUB9g6X7V6jOCUdCUrjVSDVEhvqjbcn21mgNjpkQ=;
        b=QW7eqArREZN3t6i5VFrUSuj2OdLykPgpZ1mk0yWdawWzAjc0R19ZP5uWMebUAIht0P
         QALWEEjfShP5GfVRRkezc0rtNmmRJ1UD8Tu7YHnaSXLVf0kGBgnt4qPs5xQ86XbWuQom
         e/WNExbzKeGiKtkIv1ELq+4i8LRCg6KEV2qyqwq3kk4bdxQ2jTU2RQmxWu8/OU/CdmKf
         HA6t14mOg2jT2cJm+t30w0PgwhP4TfeRUuujR+tjLWAf8st4wmeHb1Tk1hU3jshmF22K
         dO51y1YqS+pK3K3vFvo3PV1o/qnWI8+z8q9tIxiljESyp2mDE/6UQ2H0Llh/kXmDuDzl
         UfRQ==
X-Gm-Message-State: AOJu0YyApxj3kjNQa3T2Fx26m4Tl+4zRoLqCFHBEfn60PaUP04rtQJ9a
	k55fwBhI2vrcLUYNh/cAf9F2sRSyUDSs+Rv47PfDHtjZvSgoR9TPrg1bkRXuQ3p4mdcySR66wlF
	gznBU
X-Gm-Gg: ATEYQzzU7HfCkJ1FD2H0Wy2eV2bbGT1VdATEQwk0mUL6ALM7lPLnURkW7vZ/jcDnFF/
	h1M4LgngQW7I1Q42kA0nEsBtD8Qg1Ifm1epvnDvDOqYX1BB74+Az2kvkiKBnEf3I/2P4JfX5c1d
	xso128qzlxYPJdrAIzIjJeE1Vfnd4OSB8S2PbwEjyzCWbZsU/Lm+veBXR1YBZNJUQP/W4k4sk4i
	OTlLVLZl2xt/fdCwAiXNby/Ei3jF+wEKHHEHb015aIwGV3Oy/N36w5fVrfSWfQPIi6U/gm6Iv24
	ECOFOkNehqesjnhuRl3FuiaUMP12UZs8zTt8+khZ4YT5AQMqRLKqAM6YZnivRhezGv55yo+E6py
	97B8MabHId4eJOPyKBbYGT+KvVBXkA2iCzagWNje4/9dTjyquU+3VHsS2p8OA29QwZ25mesgPXQ
	DrdZnhKl5HrOMQQQ==
X-Received: by 2002:a05:600c:8b56:b0:483:7b99:131d with SMTP id 5b1f17b1804b1-483bd75e26emr68403175e9.16.1772026466481;
        Wed, 25 Feb 2026 05:34:26 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm80756235e9.9.2026.02.25.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:26 -0800 (PST)
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
Subject: [PATCH net-next v2 02/10] devlink: store bus_name and dev_name pointers in struct devlink
Date: Wed, 25 Feb 2026 14:34:14 +0100
Message-ID: <20260225133422.290965-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260944-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FD66198246
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Currently, bus_name and dev_name are obtained from the parent dev
instance every time they are needed.

In preparation to dev-less devlinks, store bus_name and dev_name
pointers in struct devlink during devlink_alloc_ns() and use them
throughout.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h          |  2 ++
 include/trace/events/devlink.h | 24 ++++++++++++------------
 net/devlink/core.c             | 14 ++++++++++++++
 net/devlink/devl_internal.h    | 10 ++++++----
 net/devlink/netlink.c          |  4 ++--
 net/devlink/port.c             |  4 ++--
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0afb0958b910 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1611,6 +1611,8 @@ struct devlink_ops {
 void *devlink_priv(struct devlink *devlink);
 struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
+const char *devlink_bus_name(const struct devlink *devlink);
+const char *devlink_dev_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index f241e204fe6b..32304ce9ad15 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -21,8 +21,8 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_ARGS(devlink, incoming, type, buf, len),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(bool, incoming)
 		__field(unsigned long, type)
@@ -55,8 +55,8 @@ TRACE_EVENT(devlink_hwerr,
 	TP_ARGS(devlink, err, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(int, err)
 		__string(msg, msg)
@@ -85,8 +85,8 @@ TRACE_EVENT(devlink_health_report,
 	TP_ARGS(devlink, reporter_name, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
@@ -116,8 +116,8 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_ARGS(devlink, reporter_name, health_state, time_since_last_recover),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
@@ -150,8 +150,8 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_ARGS(devlink, reporter_name, new_state),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
@@ -181,8 +181,8 @@ TRACE_EVENT(devlink_trap_report,
 	TP_ARGS(devlink, skb, metadata),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index da56e2b8afc1..49f856beb8b2 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -248,6 +248,18 @@ struct device *devlink_to_dev(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_to_dev);
 
+const char *devlink_bus_name(const struct devlink *devlink)
+{
+	return devlink->bus_name;
+}
+EXPORT_SYMBOL_GPL(devlink_bus_name);
+
+const char *devlink_dev_name(const struct devlink *devlink)
+{
+	return devlink->dev_name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
@@ -428,6 +440,8 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 		goto err_xa_alloc;
 
 	devlink->dev = get_device(dev);
+	devlink->bus_name = dev->bus->name;
+	devlink->dev_name = dev_name(dev);
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 31fa98af418e..d43819c6b452 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -32,6 +32,8 @@ struct devlink_dev_stats {
 
 struct devlink {
 	u32 index;
+	const char *bus_name;
+	const char *dev_name;
 	struct xarray ports;
 	struct list_head rate_list;
 	struct list_head sb_list;
@@ -174,9 +176,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->bus_name))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink->dev_name))
 		return -EMSGSIZE;
 	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
 		return -EMSGSIZE;
@@ -211,8 +213,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink->bus_name;
+	desc->dev_name = devlink->dev_name;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..3f73ced2d879 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink->bus_name, busname) == 0 &&
+		    strcmp(devlink->dev_name, devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1ff609571ea4..1d4a79c6d4d3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink->bus_name) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink->dev_name) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
-- 
2.51.1



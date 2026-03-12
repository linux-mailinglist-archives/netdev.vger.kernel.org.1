Return-Path: <netdev+bounces-266982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFlKOn+Qsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-266982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D91027010E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C7931B6DBC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18483C13EA;
	Thu, 12 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JUee8Qun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686033BF67F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309862; cv=none; b=DRCx+hoqZ90DdYBz6i0CZEuvHrwNRL827Oo/W8rXdfJD2QkZ12+JC4NdQvvoDQaqsy43CTq0y+DDwlgaZhrdPnMqnXmlTqqSDLXVgsqaATbF5S2I//KuVVI9UFNl1k+U3dBFabaR95GnNLpQZV9GWB8tEMueJVG+4uNzWNuChxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309862; c=relaxed/simple;
	bh=xLsXwuVt8lGwGVFFyvY2JOLZOXAAfQeVNQWGZqC43oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTX8FT17Z/p7m8wXeCf1iiLSs+n99MsQQAzeFbq+bQ2++LtPMK8h6FLkEUNj1IHoeeW2+uj30QzEpFUuCfsx8JeP7Rc/Q/xi9O8ZIzO6b3tf7cjJ8Z6wsbR1XCgCGTAxQt6ZN4habqSB3E5JLDxaDB9w3rJ9fJgv9APQxGgL8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JUee8Qun; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439ce3605ecso665070f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309859; x=1773914659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=JUee8QunVCarJIB7ly32JZiXD6VM53iMNKywSves0VBafjXSVLuOEwENnHsgch2+WN
         KSPyhF3oEu28k8eIFdtUZrgoWExq4+cD03JA/TecfX5dUSyve/bKqIHpJkq4RQhwJw5b
         ALK8ABS+14Db9gLNHv52/d8q/WAKMbenjHqr2+JNgU5TvcfV2s01rVbnuLcpcceZk6qq
         zSDSVyMFD3Mj9o5VWQuSC5CdqU8yYtTrwWiv1DWDXvRwsdkYcwb3662qUrZzkesE/7jK
         1M+7BF6h2x9ifyN9xIGuiweiYVuW9ztzUbl6/qDbfRXK687M1Caq9DvzItNbnUB9J3SG
         jfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309859; x=1773914659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=u20QNrfEAYt255H+YaBOo+DzfBXO/dmFZl4VZ7y17FrY4ycHQ1y0w96PWIz/jl9obG
         nT8cyFkTU14DSLpTBseFwZIq6whY34p8bWpGNk/EQX2f8BgpekG5zWhv6BqvFFq/PbLa
         qr/heUz00y9DR5aGXLCKEUSNpmJUxMcbriZ7Mpobk0FOuXx0Wc9vYqrrY0SUBnNAZN6s
         m0DH3u++F/FGDHOYNseotTiibfbJHFcTrid8Ow/kqnOdlD9MelkztSiXJsjOHGebLtdj
         fekKBJtrC0UqBH4PTLI+O84HP84RWIMkZIzzwRCY1hf/8EDRj9JN6ahS21VcTC0MIgs2
         XcYQ==
X-Gm-Message-State: AOJu0YwhwUnX2kAmqVmhC3RT3gjBq6riCjV82oeuuLs/H0cVz3TFHERL
	ZowP3Ea9E3ThA0O8lGY0N/pw6+AQ3GB4hY7GsRtJUw5rCFE9ckv1bqT8jxvnMzegXWPuPJfgBUc
	MusUTwC5BRA==
X-Gm-Gg: ATEYQzyom0q6HqTc4ZI2oHi/LGUDfY0vkehTLfSp26eT0jVD1QsHdox/bjhitim4ZOT
	7L2j4nwYpHtLwAs1p+elbCjXwaFP9e/Ft9K4lJQLMhRzBB/WpCZps1y6r7PflDRSZYmdeZ0MEOG
	eOtxmtujIKLddvmQmbcW91l1I4tku++pRH6nBRwawk9/3XX32UWDRtlbT0hXqxx9kvbDf58y678
	q5Ud+xT/KdQpfqihH2tMjqry+g1vMn+kjcBx+ll1M9yh4+YunQ5NhSYQdsd7qaZrcr5sne5nG0D
	HzMQ1GFZY5VIibC4Dypn085bOG9b6p8SDMC0h0gnfg3BuI8e7y5ziHDjrQa/achlxMRpHmhCg7p
	G3HVGEJMm9BXE2IfNUQhe+dDQsERL9WAiSycrZJfcMlDLjKdIZoUViPh+DxK9ySVojhAgd8HHk1
	7uikr+OwEmLljcdw==
X-Received: by 2002:a05:6000:230c:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-439f81bdb5amr10514615f8f.5.1773309858528;
        Thu, 12 Mar 2026 03:04:18 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm6943586f8f.29.2026.03.12.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:18 -0700 (PDT)
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
Subject: [PATCH net-next v4 08/13] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Thu, 12 Mar 2026 11:04:02 +0100
Message-ID: <20260312100407.551173-9-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-266982-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8D91027010E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that returns the driver name stored in devlink struct, and use it in
all trace events.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- using stored devlink->dev_driver
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0afb0958b910..45dec7067a8e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1613,6 +1613,7 @@ struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
 const char *devlink_bus_name(const struct devlink *devlink);
 const char *devlink_dev_name(const struct devlink *devlink);
+const char *devlink_dev_driver_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 32304ce9ad15..4f8edf77dfbe 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -23,7 +23,7 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(bool, incoming)
 		__field(unsigned long, type)
 		__dynamic_array(u8, buf, len)
@@ -57,7 +57,7 @@ TRACE_EVENT(devlink_hwerr,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(int, err)
 		__string(msg, msg)
 		),
@@ -87,7 +87,7 @@ TRACE_EVENT(devlink_health_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
 	),
@@ -118,7 +118,7 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
 		__field(u64, time_since_last_recover)
@@ -152,7 +152,7 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
 	),
@@ -183,7 +183,7 @@ TRACE_EVENT(devlink_trap_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
 		__array(char, input_dev_name, IFNAMSIZ)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index fcb73d3e56aa..34eb06d88544 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,12 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	return devlink->dev_driver->name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1



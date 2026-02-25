Return-Path: <netdev+bounces-260950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzwNBX8nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:41:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE919842C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C128F31A6895
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521483C1988;
	Wed, 25 Feb 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AOZtH26y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2793B9618
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026475; cv=none; b=UyJS9VmW/RHDt0ldqlRoJUwxCNr3eFFw6kH4QBMvslMWZ4tKJqQ0w31Vp28px4jqQmr0ML0JMYGGo5lWTLfObPyhKMqUy4aeEx2vaZ6BYVFtRUwUGTIIkJkjHQMbgfQhPRVoXONljG5w7GoiWu4NMiC//WDhRx6XdK4loxDiKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026475; c=relaxed/simple;
	bh=r67EuCuSEgnlNDiIhyauM9QDSlOGLxMQaLPlJqQlJh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI+Fp61hOkZIyDHpE4xO9ScyWr6mKXV3ICTVVZodVQhHd/jWRHTxysw4nKoCNDyeXI0SiqsOllO7o6Ij5qZ0e+aZ9oFcqqBbrYrG+8P8fg512gWgc0y/Gg4Zle2TvkzheB3zrc0SqV6tzBsDb5p98arQtWL7VH/CNTzpHv0EbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AOZtH26y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439857ec679so1811882f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026472; x=1772631272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=AOZtH26yAWQzenMcaat2LyaeVktBl+Jnj+7qC0HivzbZlq83omf8hSwpOq6FT20g3I
         Wsx6R0ZcIlIDWIUO2smLNtr8eEpHBeYiL0svrDCZkcGogkpnr89jND7jqCxZQV7yHIEu
         7i1c3k5Sga1q3MXVDIJG2JykJ+pjz9OgDbpWmS5q6Zk3qOPKKhNiPANE7XTNSWfxbIwx
         LsUgV5BFPftdNHnnq/8jjMhQaSEtnras5bLxBagybHLb5SNih1BlQZl9fipS0xr6fw9L
         O6DTRPm5tbLxdGTiBIUvjyJkiFR4A0FjaV3iK8WBUMwSWU9P9lye+ufJu23vRjx7XEH+
         rcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026472; x=1772631272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=gw+fXn4tRh9QpEhw4wrj1sYgRZlEz1UczWMfYwiDwOAVQ7GaNZY4nEEIZOVH7rm3Nf
         06CjpW9r8ENm/jrr8AKBovLD8CdA/00RNNxZ+bRn21RhX6v3WN+9s4Qzm78XJgip7MME
         P250V5jxrh2KxdOE4f1/i1bh+u/PL1XiLL2iZ/NeMlkNbRWSH6/a5DKXDUjm33N/Br41
         tcSGvj6ZBc6gpTAnOSQU080feC4g7pRae70gvFHHY69YYODv2KtYoXMxmgC2TFlHSFgd
         pRAEauv5byiUpV/Inuk/ZpLvDlRV1vnFO87idHnL1NF7IOcSl/oo16J9AjHzSi5fCuye
         VnpQ==
X-Gm-Message-State: AOJu0Yy1EXhOAtio+TLlnDsqK5BG8lYCfNAUitbVRmCLjNwpTKqlAtYM
	WpgzhqQUk9RCNz8qUbrimZjUuv1tDhXv/fzdVgrqLQ61OUWPJJ827qq65b3RWowiGA0Jbx4xIzV
	Wnt1f
X-Gm-Gg: ATEYQzzT/qp1EzXgXjzhgNfb7SVelXC1SrpHZ6dmI7AVJdjo1qld/Ze+pgz56L/GOHB
	619hxaYcrF4O5pWcQ7aPaWW4oyVCqlt9N2kHhOw9zuj65L9HYFI81K6mtL71c5KJ3qzVLbcTQkv
	FGh6DvFKAWn8j4NPpVzSSGSeEcMq72pC9CLMUH6LGOnFd+pVC1WspYlrorXoyd3tVT6mF//fXLO
	Q32/hfelJDnmxv5lXV+/zmUjcMHWYWi2ftKADxKgg9hudER2pfzIbFCZvCexWFIQnRSDAMM5Blw
	0jAOjxgmYpz+0fvCt8zblQ40tMIv8iFev0xR0NdUaBNqsFUMlNLZEGyiGQDH8AbspsBTEsHfj6y
	eO+VKya77HHFkTyZcAlfHmT9U9cE0MttH79axbNooh3o62v7ZAs3jB/odmEtdaNKX3O0HfqAhEy
	3Ess7u57HTA8G4XnVkPWHOBgcW
X-Received: by 2002:a5d:5d05:0:b0:439:869a:a15 with SMTP id ffacd0b85a97d-439942fbac8mr908648f8f.42.1772026471792;
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm33063361f8f.23.2026.02.25.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
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
Subject: [PATCH net-next v2 06/10] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Wed, 25 Feb 2026 14:34:18 +0100
Message-ID: <20260225133422.290965-7-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-260950-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.970];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 77FE919842C
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that safely returns the driver name or NULL, and use it in all trace
events. The trace __string() macro handles NULL via __string_src(),
recording "(null)".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  8 ++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

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
index 2dd6d45bec18..85ea5856d523 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,14 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	struct device *dev = devlink->dev;
+
+	return dev ? dev->driver->name : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1



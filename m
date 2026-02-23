Return-Path: <netdev+bounces-260071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJgUHdtrnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77D178617
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9233169AB1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B026E6E1;
	Mon, 23 Feb 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RIDIRYBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341C26AA93
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858572; cv=none; b=VCbJTI3OQpPUuoXSkmZrN36kbYIbNOXa9DvsOTT4frMuLb2lqw4p2b+PwYeLPGlI96JHEnhKg8Hu1w37w4Pf5ZHiQ48FMK/FyQCUFrnk9nH6UnIovA01Ali/eO72KnQT0LAYWv23xl5XtI+nz3X99e8yjL9XJWJk0ib7gyvmcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858572; c=relaxed/simple;
	bh=WaetWe9lfpCCIsVQ4jzwVKVojFjAtgD7kQR0lomhXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK8yGaYan1y3fekN6uqtsUkqqLdrWaodA/a0zCO3ARzYdfFUjRS35Vzxbw5Oka3C75MXKH9HnjB5O09PCS7uS0KcaPhUR2myH8HxpMbvpsXXDJ4FzSo4wNrqgPR/K5dYZkTiFfsnRtCbmwOZdqKrK0nvuVmXV5j1VV0GSCoIKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RIDIRYBn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362507f396so4266398f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858569; x=1772463369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SACzHmLk/4B8VDhI3G16liml/ixXtlxPmTM8toyqQE=;
        b=RIDIRYBn40Y38HpYYcWq9oQXQ2/h/Din4ge5oArUBHnGfU9ZTCboXy+RxWa/BG8hBa
         k8/pR5ZJ1W662V8CrR6hoi4R5KiAMg6OzAiffHAyOsCF3kxltOpOokMIl/4i/geyKUDQ
         Q1R0xIf5rFkAMTzCEqB5Q2yqfy0Mx/Gr2BOYvBsr7GOzwL/VPJQ2ENErGbsRR6VxzR5E
         57KaH7wyzkPThZjJ+h9MMOP8IPaDNA6+eekTQVBc1oO+dqja5RLlHQ9OjlZDylTx7Sxw
         8cnBKOAivGLbJ1ygWai39QeCJEHe8OJgwBem6M+Sz3EiS/+VCcXSTT2fU2JmWPgBOvO2
         mWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858569; x=1772463369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SACzHmLk/4B8VDhI3G16liml/ixXtlxPmTM8toyqQE=;
        b=WCdxbObPXNoaIEimEPllWfLSka5Fex37ZcTOxc+bqikB4T9preSixp3445ZaANvKsq
         zvXijo8RTm0SO44nxCen207V0ATFhgg5F8uazpnEZZmGpj9sEggs8efBvlNVAGK03FWf
         40AdZHsR+X7o6BAF9ZMQIlXZN8voCGH5DoMEBwMp2aAZ/e42K50T7rVtYOyoEBrH0vnw
         UGzdiOvHLZOCOhKY5veS8oVU0YzfPZZs4X6VEfx54XMiYdYrlYDFjdEci/A9/5+iBRet
         e4QY6LbkGyYyA6K/vu8GtZ/EqnhYax+0DCgnXhmHV3dQhN9E5FDjs3d01vQ/iqk1BFor
         GvBw==
X-Gm-Message-State: AOJu0YyqYvfFh+j1vbFFzal+I+fqVxd/gEJpg53MhjnSqc59SYJ6VafR
	P/ds48iDwT2J7iKd7NmDlRA610tP4gblXSBfXB9pkcadeOCmzV+H2N5WiCPkPUGA6vFDlV7Oa2y
	+HWms
X-Gm-Gg: ATEYQzxZCLhTdmwoRbemXb6pUnRkdbcXg5c4ERTR/UP0v5obvQRaCMcJn+z4uk+1bwl
	Z2dj0SPOPlutziVVqwvswYVKhtbrt5b69dQh6YHKOa72qOv8KSl7raz5SdDhsArxDGPahkom+ZE
	1yen8fEl5FEEz5mx1x23t5cMVxyg5uOV2SCcQqHsqzJNmXApm7oNFwi7B8RlYoxzPrRCSYrCCRy
	e6vi74NFesczDszLBiNO9oZwjBZPFa11JSakU0r310Wrfol8+JvU79kK/vFAQOQtqaRW7EdxOXh
	owG6Pieuzx6IZO79457oactAirq2v3S5W5t7KCCkzB2uDP/wBsEnVJJvPuYwPhS12aVGc7JGBgs
	zlLL23eLuUgBb873zZ/rc/o984MQZG2qiCTG4J23KbTeS7j7rCWhWkr3p4wKm64FSt1fq9rvLRd
	pjWYO8gWwLGJIemlUg3Q4zKIfF
X-Received: by 2002:a05:6000:40db:b0:436:216:98d8 with SMTP id ffacd0b85a97d-4396f1544e4mr16070656f8f.12.1771858569264;
        Mon, 23 Feb 2026 06:56:09 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm18330206f8f.20.2026.02.23.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:08 -0800 (PST)
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 08/10] devlink: introduce shared devlink instance for PFs on same chip
Date: Mon, 23 Feb 2026 15:55:55 +0100
Message-ID: <20260223145557.248679-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223145557.248679-1-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260071-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: CA77D178617
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of
the first PF and removed during remove of the last PF. The shared
devlink instance is not backed by any device device, as there is
no PCI device related to it.

The implementation uses reference counting to manage the lifecycle:
each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes.
The shared instance is automatically destroyed when the last PF removes.

Example:

pci/0000:08:00.0: index 0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_index/1: index 1
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: index 2
pci/0000:08:00.1: index 3
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: index 4

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h |   6 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 149 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 45dec7067a8e..e97ee09af5d6 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1647,6 +1647,12 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..8bd8f4b506f5
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	refcount_t refcount; /* Reference count */
+	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size)
+{
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				NULL);
+	if (!devlink)
+		return NULL;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_kstrdup_id;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_kstrdup_id:
+	devlink_free(devlink);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. The device is automatically added to
+ * the shared instance's device list. Return the devlink instance
+ * with a reference held. The caller must call devlink_shd_put() when done.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!id || !ops))
+		return NULL;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd)
+		shd = devlink_shd_create(id, ops, priv_size);
+	else
+		refcount_inc(&shd->refcount);
+
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!devlink))
+		return;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.51.1



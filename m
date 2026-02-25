Return-Path: <netdev+bounces-260948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YITIIBT8nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01082198422
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F0931A1E6D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7CB3BFE20;
	Wed, 25 Feb 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xiSL6goO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0A3BFE3E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026473; cv=none; b=imKX9yqMfxREUwm3r6wj664Wq9yc8hn30XGraQIaJMBjUdohSm446CLUB2gXvqdwO5Sqt68GmxjKVGNiYJfe+d3m3NP+TA0fgLlUpmxMEbeuV7CQfzojM480XRky2J3pAG5L6I/ld2wRjnHnGBCj/83HU6DLUYIG7kfyTxwTBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026473; c=relaxed/simple;
	bh=cBdk7OS/MqJvfgCd8WjMOg+aNCv6O46a+gTZy5CXlts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEiDfLxk3N1r8XfyxMuUvJLORXneLaB5S7WCEJPcZ5NrAjkEr6M/OF8jmbz9HlCMyPZSRuBiLsfudvk+kN1TF9U0MHffYQUzy+wx2eY9n+H5+39Du2e/X3xQtcqiPGoyWMPdZnSOUlq+iXMSlXDStLewhTJZSZsrBxvVAHJyDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xiSL6goO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48069a48629so68806735e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026471; x=1772631271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=xiSL6goO+ydywZ0fzuuyNAZq1mr+W3T+rXTnZaW85NBrwDG6raKJeZYgcNGPahmj8Z
         t7N86d5W0jiAt1mO5RM6jsIhTyDFR/mu5Jo9Fv6IMAmrLR3E0DBNqsY1ns+JwnTsdBKt
         0ZBjHt11fdIv82tXTu4UrNjqQVP8mH+sYTbSuy46ekEXtkCtkR3XN/ftgV0ClX06zHu2
         dBxUbUPq4d2ePWfZTZwHbIJsyBjO0+N8gv7bhmc33hKRb2PF1jIB691AdO9+Kj66ASqB
         dMvSZmrYuHsIo7o67ryn5C85snUmXazAPbFp8ccEGmcLFhlXdAgcgYr22PG0wV7vBSi6
         OgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026471; x=1772631271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=O8HM/If2wSkiYASX4eyLnPzTOxRD/VVD5o9KK7ZdhRgzG7tAlrkhjN4v6taUfwcAZ2
         FYjgGPNlFmiuA7ZQQoBSFfOiP3h5tOxIcjg19XJTWdCUWb2936n3ogz3G4KjTDloOTW9
         BPZZr9ccTIe7xx3zs61nQ0DZxYtWEpoN6lxAWqbqJoWyJRa1KDc2O/pKwtwd5FS1akMc
         t3kb8y+MB74fkTgK7sDcfRBhfV5RzkC6hZwCVE5HGbjX3hxIV3r/UWdxKY6JgV0olkQm
         cSyz6djifhlLGOCts8vrmre2kaEs3EoPGuFAyj+KqWgPCkIXF/T1Opn7lFAhBFf1pl+D
         +SUA==
X-Gm-Message-State: AOJu0Yw6p1dru1WOcOAVh7c6o8G0h/2XSHLOQKX+wYq+tmZ3KMvO3jIy
	bws4nXp9slR17C5mt89n1CL/dhOeR7kLhoeML9XV056vrCoLYfLAzB7SPM4updTUs+iX9Gv1cbj
	4WpOT
X-Gm-Gg: ATEYQzxXh8JJde2WasBjCoB/otE1TFqXdHB85vNj7Irz2ED8qtIUeEX5fWEhNbSFV9A
	Q6H3VOHwVz+BMk/pk8OfpgD9xdAwDvF45kGRBWytT9mLFpLcyxue3kMt4adBs9bddb3DoXvCuis
	iZeSylaSXtqm/DrPfZuuo45ozNhjYaje/JGDd7uc3z1on8QZr+bgk6jaCLrvun2AbY4r12Z3as4
	d9KUjE3YbvLmK2CjAowHYVvtVUHxv3RGnxvnzkgx9o3GrZ+iVoWPC538S0MjNFLAFOQeRAERNoc
	7GY/Tzw1bcjC/2d4fgp3bsDrs9wYwweEcvgF+BBmPAJ3XmlDH5YX7H0mBdsdn/6A8eukkJBcqAB
	lQEhwYeaAfwWLpycYgQ6qiLoFODGagGXJjHDuCSoQp52YbXwnbg/kd7hHLOrJtJ2dC7iFtiIkbc
	iwWypG6ZPX+IRhjA==
X-Received: by 2002:a05:600c:8716:b0:471:1717:411 with SMTP id 5b1f17b1804b1-483a95e9a7fmr276220965e9.24.1772026470590;
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm18237565e9.3.2026.02.25.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
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
Subject: [PATCH net-next v2 05/10] devlink: support index-based lookup via bus_name/dev_name handle
Date: Wed, 25 Feb 2026 14:34:17 +0100
Message-ID: <20260225133422.290965-6-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260948-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 01082198422
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
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
index b73cec31089f..127f337489c0 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -200,6 +200,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-EINVAL);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
 		    strcmp(devlink->dev_name, devname) == 0)
-- 
2.51.1



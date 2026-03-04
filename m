Return-Path: <netdev+bounces-263906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKAbB8hbqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:20:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59E204192
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE2F333FC80
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94735E92D;
	Wed,  4 Mar 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DZOczu81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33635DA67
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640048; cv=none; b=Qd1GtB5tG4CliQN6OAOoHSn/ykuLAWltHWALgezCL9Yk1C3rnTJ5qItMnGd2eA+mj4uCnKNRXu3PM6t5kp+MKgGhxKPZ8OoSrukoaVAYNbkRook6IVkWPKNbIiXM3OCIFjPzHO9a2UmzPN2Rj5mQOk2tknMfH0YX31br4VhMm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640048; c=relaxed/simple;
	bh=1WRGLRV1Mf3gtLoQpSz/WpelFSk3nN1ML07ryNxiF/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyGxDshw/NMaED8S84G2wQ/kzhjo9V5abS0RiG6WQS0n/pZCa5Hqq/5gUG/6swVi2B+WEnuMRc/KOZYz+hloz/uwNqrBUmxWmZ2nVhGXh/pTmTtDttR9Irkyppj7HwOMCE4TS6eYEW3cEIe7KQapAz7bOqsIXmc5yt8ApmwpX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DZOczu81; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371bb515eso105064725e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640045; x=1773244845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=DZOczu81F1YpJZt0v/hbcrxLBV2F3mt8F/FDxiydgHMhEfA6LkKSGkIsT2Gyfn2h5B
         jfFRx6jA9UjgWz/yVI84PRIzZQslfItpsM6aWg1Fh+h1rtBsfVYieIbBCqU7w1COEOqM
         6lbVvq22GjXwU1hxCbVsVaGAqvq+iimirKt1ElPXMyxz5t5r2TYQk+TAjISxaB0jwmq2
         aD1zCXck1RgfGttAgf+xGjhzPbApxbR5zOv4tXkeyiZk4nqop8HzbwDTsyUDqUo69Mpy
         NpJalalKe7JI//WgQR3NBlOFTIq0i1UhwOmlWrPItK/SpLQ52dCbFNuk98Nhi2BbSGOM
         YX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640045; x=1773244845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=stjiNX3R/XK4WSXqWLcCgkZ1Dky9+8fyx/T8N5gTOEAHT/keJpQACn2GLSKHpqAdS1
         ZmriWPMn5nYGpJ/rkwvHb2m07D/JGegpDcT4npO8v2KQMnvZRu10P8hicRTdiDCz3YUc
         9yvF+rn32oldG0tQWTvRT0o8itqlRvTpejPlLc2YXGqbr202I9QVyM5Vou5Lzwqay2IO
         7gWV/DeAGOkiHCQ4sKzff2SJhweGyvxMkPQk7pG8xAXrchfewEvLKvM7tAFelhIiVRcz
         HyKE5szH96SLAE31na8uUpbhdXLY/wGHoFRTVDnPwUXaEzxWeWAYWnY11BlXZ8istVld
         JAew==
X-Gm-Message-State: AOJu0YwXyYs0oJ7EAL3T2DWyvpAZnaSkVxirum3Ff3Q4zR55Ltewglee
	uGBR+miACSO+TKTZeVxNe/0OrMDHaZkRn29jcG55xu4goid+hOU6sbGyJXbD8KIhfIVEJXKrx8P
	5rtMf8FA=
X-Gm-Gg: ATEYQzzNc30Buzjzy/MfGkvqAT0vbDyGRHsVtxgg0tNmmsTOWqcZKbHtGWpA+0ccW64
	RPnIr+mGpreNxG59JqPgp4QmVIP1hn8xmqw3wB9XodDt+5EQLdmPCVmq6OZTESKgjA4tp+ftWIx
	ZBVQ6d0JetBwedvj1PJ8xqU5D9m/GPg3xwyrP2vy5pX5Yvi7qA0aD9DOze2b6s8skkGGH8HRogu
	GPfgGuziPv0/tUvVNlASoMK21EpPW+d7wQf2RMAVYNDYNZFdOen7UGrKRfv0Yc/nrIy2cn4nMb0
	m0KxnXq7Og5pK8nSn7rPxJmuDj8D/9OIr+SyllYD/618YARisrEa8fG1FVzOCZ4idzS4E9yxP2F
	vPiVKR2frdbQFNPPCn1OkfmCS3x1bcUf0F0e+rKBfbSaHaDadN9lS0tsClU7+2p8dpYSrszRlds
	AGgBAEC6UGQ7uDUS38L2I/OdOIn3/6YQOKo4uER4+EBN2+LQ==
X-Received: by 2002:a05:600c:1986:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-4851988f93fmr39508765e9.25.1772640044457;
        Wed, 04 Mar 2026 08:00:44 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851887fd5asm62598465e9.11.2026.03.04.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:43 -0800 (PST)
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
Subject: [PATCH net-next v3 09/13] devlink: add devl_warn() helper and use it in port warnings
Date: Wed,  4 Mar 2026 17:00:18 +0100
Message-ID: <20260304160022.6114-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F59E204192
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
	TAGGED_FROM(0.00)[bounces-263906-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Introduce devl_warn() macro that uses dev_warn() when a backing
device is available and falls back to pr_warn() otherwise. Convert
all dev_warn() calls in port.c to use it, preparing for devlink
instances without a backing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  9 +++++++++
 net/devlink/port.c          | 14 +++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 3cc7e696e0fd..cb2ffef1ac2d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -71,6 +71,15 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+#define devl_warn(devlink, format, args...)				\
+	do {								\
+		if ((devlink)->dev)					\
+			dev_warn((devlink)->dev, format, ##args);	\
+		else							\
+			pr_warn("devlink (%s): " format,		\
+				devlink_dev_name(devlink), ##args);	\
+	} while (0)
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
diff --git a/net/devlink/port.c b/net/devlink/port.c
index fa3e1597711b..7fcd1d3ed44c 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -976,7 +976,7 @@ static void devlink_port_type_warn(struct work_struct *work)
 	struct devlink_port *port = container_of(to_delayed_work(work),
 						 struct devlink_port,
 						 type_warn_dw);
-	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
+	devl_warn(port->devlink, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
@@ -1242,9 +1242,9 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  */
 void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	dev_warn(devlink_port->devlink->dev,
-		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-		 devlink_port->index);
+	devl_warn(devlink_port->devlink,
+		  "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+		  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -1273,9 +1273,9 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
 	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
-		dev_warn(devlink_port->devlink->dev,
-			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
-			 devlink_port->index);
+		devl_warn(devlink_port->devlink,
+			  "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
+			  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_NOTSET, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_clear);
-- 
2.51.1



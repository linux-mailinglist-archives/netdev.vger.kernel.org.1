Return-Path: <netdev+bounces-33452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54979E087
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659121C20CC2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9521804A;
	Wed, 13 Sep 2023 07:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C618049
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:50 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381801728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f915c3c42so3944969f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589167; x=1695193967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN8q4XBfm3D9pTOrAcZXoCrCq4gI7qNgVO87RHtcd8Y=;
        b=ag4Ss4nfYiKDqTR3bpfZz0Ae/1Yu3/C6Nbz/jR7r2SVwoAUn/tZ4naEiEz/TfKur6B
         +04EcaELG5nuDcvGd1RZqvghtg9pKQ0yiC/HuOMjFRB1GfOnZIOHsQtnRBHWcq6PnVmm
         YBK7PTUE502Xgrqt7TJE6JO+EyZ2/cUIOxd7sOmleMwBt6d0VdVy6kXsUFLNyomXBm4l
         bZmVuJDAt9SygdRMhEj1V+NDZDMLeH9mcKwU8J2Y2IqOVb+HMqMInoHh7wMkaEU2B3fz
         XNlWEQiKHQroxEL+RaFYJO6ZNbS+FSpFDSaKDds9uVXcgGyKfWeEHi9/2Szj65799oLZ
         zwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589167; x=1695193967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN8q4XBfm3D9pTOrAcZXoCrCq4gI7qNgVO87RHtcd8Y=;
        b=xI+OrAX0lHu9EFHc7VgLHFLvakhtFPbeouatH7Gm+aQk/uKuQ0VyfqbyZ9sMulIZ6e
         pwTLZAgSJZHB7fCvjgnNCEIo5XMVNpXYzWgDl1EfU82rTcWQQIrYLMNjOk1UbSlQ2JAo
         2nZdq72qqjKIfARLjPfV3SKeE2Vh/An9w49q9owFF8nRwIPae6JGWd5E5Bwee20rnvdF
         5OeiKiNjFcZAmOcnncJMTcXRULD/RQ/1mm7+AeEoSD5TyctxGqb5npy3RYjbi1LbuTgw
         6LQ6XeclaXBibs5+55g42FR2jXuf5VwNBQUavFmcKYsRQbLBhJxdnjDbVUqWo4LqJi2M
         s1mg==
X-Gm-Message-State: AOJu0Yy6UAY/0CkXm8RncxBJW9R1AHToDTvHQ8nTzb617OCehMkRoLHK
	TqXF+5+LLR0/vTz0L7t40X/ByhKzQsRJQDlFENo=
X-Google-Smtp-Source: AGHT+IHhK/o9tMnGq9BysiNRfyMeq9z/6sa64HJj0CuN3iVrpsaxCiUlL5hQVBqpNBLVSwMIGJ2+Ww==
X-Received: by 2002:a5d:55c1:0:b0:31d:d3db:4566 with SMTP id i1-20020a5d55c1000000b0031dd3db4566mr1381572wrw.4.1694589167762;
        Wed, 13 Sep 2023 00:12:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b003197efd1e7bsm14600739wrm.114.2023.09.13.00.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 01/12] devlink: move linecard struct into linecard.c
Date: Wed, 13 Sep 2023 09:12:32 +0200
Message-ID: <20230913071243.930265-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of exposing linecard struct, expose a simple helper to get the
linecard index, which is all is needed outside linecard.c. Move the
linecard struct to linecard.c and keep it private similar to the rest of
the devlink objects.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 net/devlink/devl_internal.h | 14 +-------------
 net/devlink/linecard.c      | 19 +++++++++++++++++++
 net/devlink/port.c          |  4 ++--
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f6b5fea2e13c..1b05c2c09e27 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -206,19 +206,7 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
 
 /* Linecards */
-struct devlink_linecard {
-	struct list_head list;
-	struct devlink *devlink;
-	unsigned int index;
-	const struct devlink_linecard_ops *ops;
-	void *priv;
-	enum devlink_linecard_state state;
-	struct mutex state_lock; /* Protects state */
-	const char *type;
-	struct devlink_linecard_type *types;
-	unsigned int types_count;
-	struct devlink *nested_devlink;
-};
+unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
 
 /* Devlink nl cmds */
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 85c32c314b0f..a0210ba56f2d 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -6,6 +6,25 @@
 
 #include "devl_internal.h"
 
+struct devlink_linecard {
+	struct list_head list;
+	struct devlink *devlink;
+	unsigned int index;
+	const struct devlink_linecard_ops *ops;
+	void *priv;
+	enum devlink_linecard_state state;
+	struct mutex state_lock; /* Protects state */
+	const char *type;
+	struct devlink_linecard_type *types;
+	unsigned int types_count;
+	struct devlink *nested_devlink;
+};
+
+unsigned int devlink_linecard_index(struct devlink_linecard *linecard)
+{
+	return linecard->index;
+}
+
 static struct devlink_linecard *
 devlink_linecard_get_by_index(struct devlink *devlink,
 			      unsigned int linecard_index)
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 4763b42885fb..7b300a322ed9 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -483,7 +483,7 @@ static int devlink_nl_port_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 	if (devlink_port->linecard &&
 	    nla_put_u32(msg, DEVLINK_ATTR_LINECARD_INDEX,
-			devlink_port->linecard->index))
+			devlink_linecard_index(devlink_port->linecard)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -1420,7 +1420,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
 		if (devlink_port->linecard)
 			n = snprintf(name, len, "l%u",
-				     devlink_port->linecard->index);
+				     devlink_linecard_index(devlink_port->linecard));
 		if (n < len)
 			n += snprintf(name + n, len - n, "p%u",
 				      attrs->phys.port_number);
-- 
2.41.0



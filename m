Return-Path: <netdev+bounces-48024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEA7EC4F5
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB52280E43
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C828E36;
	Wed, 15 Nov 2023 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SlfJ+yeD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815502E63B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:48 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D12E1
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079f6efd64so9082781e87.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057864; x=1700662664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/ZFK3xawEcyb9omOiGWO1jMML/5COVB0SorPJoKYQ=;
        b=SlfJ+yeDAh51gqWfyOw29PvgsDgO/TKi0xxN99cD5q7ycKw8AJMxfw+kLhDOXaNVoW
         XcqGI5kq4qmMUipJGfvFThqWixBYNczA4WQek4fEqv1Ihp1oRwg+NOwzbVR0Fap6WOgK
         fYuPH+vrVgY0OyN6oR7/WrMzEVKbZV+qWZB8Ssbbs2/PP/IXFbEkntZ0DY+bVOvWcP5d
         DSrycII8up/9eVAtnN5uf37+sW8ftprvCm/cAnr3aeVbJ4VMVfrefRc0b9Dv/vq2d2cv
         QJ3QO7MIolVR7U8TMla8XxNtvh+maFVheyCjIhCKoGAZru0FFt6ZsKo8kzFUaaIBz9GR
         vYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057864; x=1700662664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA/ZFK3xawEcyb9omOiGWO1jMML/5COVB0SorPJoKYQ=;
        b=XG08gpTPO50tlKVH3MRaIleNSzUFS5VsijcH0axR3IJqHAQcCSKV/Fz/zQxavPWUY2
         irgByAziGWRv4UYv5wr63Ce8Iu6hcAq9B9RiWmpW2+AJBhr4l7mcsCv6Qt3Yt0TRqlrq
         DzXC/2Epna8V61P0+YOE51Ur8fDJN/7EXlsTMTN6u6ZHNF7tgWvseOs+h2beb2QLiJGy
         GR21i+PkdtcU7RIqVXYHNx7IGM+KDI6hsWScUgF8H4D6UaIC8ArA8xsX0x57Ue1+54Px
         4tCzadmzzvedJNWbP+TXeX0+60fCEFPR15sddr0fRJTk8MMFynKhZIteobwi4WIqqaGL
         CAKA==
X-Gm-Message-State: AOJu0YxXuvv/bLA1ab7dLCxAPiRH2BtDdn+FuSrFgGDnozDmcdmxpmzx
	ZYYAshnJPPKsoFXnr7RZBZoBOtbUUy4QKOrnbWc=
X-Google-Smtp-Source: AGHT+IG40o9RcpsW73ukEPy2DTq84ciQkjPbcIA7h5hDVEAbHBFSrvAXnq/n36vkyylikVs7HOBxFg==
X-Received: by 2002:ac2:46c6:0:b0:50a:3c38:6b68 with SMTP id p6-20020ac246c6000000b0050a3c386b68mr8571983lfo.24.1700057864361;
        Wed, 15 Nov 2023 06:17:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b4-20020a50b404000000b005438ce5bf80sm6693251edh.20.2023.11.15.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:43 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com
Subject: [patch net-next 8/8] devlink: extend multicast filtering by port index
Date: Wed, 15 Nov 2023 15:17:24 +0100
Message-ID: <20231115141724.411507-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115141724.411507-1-jiri@resnulli.us>
References: <20231115141724.411507-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Expose the previously introduced notification multicast messages
filtering infrastructure and allow the user to select messages using
port index.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  1 +
 net/devlink/devl_internal.h              |  9 +++++++++
 net/devlink/health.c                     |  6 +++++-
 net/devlink/netlink.c                    | 10 +++++++++-
 net/devlink/netlink_gen.c                |  5 +++--
 net/devlink/port.c                       |  5 ++++-
 tools/net/ynl/generated/devlink-user.c   |  2 ++
 tools/net/ynl/generated/devlink-user.h   |  9 +++++++++
 8 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cc4991cbce83..49d4fbf3fe44 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2065,3 +2065,4 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - port-index
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 0ee0bcdd4a7d..3ed7808013f1 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -181,6 +181,8 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 struct devlink_obj_desc {
 	const char *bus_name;
 	const char *dev_name;
+	unsigned int port_index;
+	bool port_index_valid;
 	long data[];
 };
 
@@ -192,6 +194,13 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 	desc->dev_name = dev_name(devlink->dev);
 }
 
+static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
+						struct devlink_port *devlink_port)
+{
+	desc->port_index = devlink_port->index;
+	desc->port_index_valid = true;
+}
+
 int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
 
 static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 2f06e4ddbf3b..0e96d26203f1 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -490,6 +490,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 				   enum devlink_command cmd)
 {
 	struct devlink *devlink = reporter->devlink;
+	struct devlink_obj_desc desc;
 	struct sk_buff *msg;
 	int err;
 
@@ -509,7 +510,10 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 		return;
 	}
 
-	devlink_nl_notify_send(devlink, msg);
+	devlink_nl_obj_desc_init(&desc, devlink);
+	if (reporter->devlink_port)
+		devlink_nl_obj_desc_port_set(&desc, reporter->devlink_port);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 void
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 738e2f340ab9..6c033d1f7e64 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -46,11 +46,16 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
+		flt->port_index_valid = true;
+	}
+
 	/* Free the existing filter if any. */
 	kfree(sk->sk_user_data);
 
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name) {
+	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -68,6 +73,9 @@ static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 	if (desc->dev_name && flt->dev_name &&
 	    strcmp(desc->dev_name, flt->dev_name))
 		return false;
+	if (desc->port_index_valid && flt->port_index_valid &&
+	    desc->port_index != flt->port_index)
+		return false;
 	return true;
 }
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f207f3fc7e20..b3f37e3c1b64 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -561,9 +561,10 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
 };
 
 /* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
-static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* Ops table for devlink */
@@ -1243,7 +1244,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
 		.doit		= devlink_nl_notify_filter_set_doit,
 		.policy		= devlink_notify_filter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 758df3000a1b..62e54e152ecf 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -507,6 +507,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 				enum devlink_command cmd)
 {
 	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_obj_desc desc;
 	struct sk_buff *msg;
 	int err;
 
@@ -525,7 +526,9 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 		return;
 	}
 
-	devlink_nl_notify_send(devlink, msg);
+	devlink_nl_obj_desc_init(&desc, devlink);
+	devlink_nl_obj_desc_port_set(&desc, devlink_port);
+	devlink_nl_notify_send_desc(devlink, msg, &desc);
 }
 
 static void devlink_ports_notify(struct devlink *devlink,
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index cd5f70eadf5b..86392da0b52c 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -6853,6 +6853,8 @@ int devlink_notify_filter_set(struct ynl_sock *ys,
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
 	if (req->_present.dev_name_len)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
+	if (req->_present.port_index)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
 
 	err = ynl_exec(ys, nlh, NULL);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index e5d79b824a67..b96837663e6e 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -5258,10 +5258,12 @@ struct devlink_notify_filter_set_req {
 	struct {
 		__u32 bus_name_len;
 		__u32 dev_name_len;
+		__u32 port_index:1;
 	} _present;
 
 	char *bus_name;
 	char *dev_name;
+	__u32 port_index;
 };
 
 static inline struct devlink_notify_filter_set_req *
@@ -5292,6 +5294,13 @@ devlink_notify_filter_set_req_set_dev_name(struct devlink_notify_filter_set_req
 	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
 	req->dev_name[req->_present.dev_name_len] = 0;
 }
+static inline void
+devlink_notify_filter_set_req_set_port_index(struct devlink_notify_filter_set_req *req,
+					     __u32 port_index)
+{
+	req->_present.port_index = 1;
+	req->port_index = port_index;
+}
 
 /*
  * Set notification messages socket filter.
-- 
2.41.0



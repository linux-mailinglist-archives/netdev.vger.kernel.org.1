Return-Path: <netdev+bounces-33459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDB379E097
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5092B1C20E0D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE018AF2;
	Wed, 13 Sep 2023 07:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5018C22
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:02 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080D1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50091b91a83so10604984e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589180; x=1695193980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1bT9y8w37q/lqO7jWhPz/MCizYdOi4GhRkpzRZ8STo=;
        b=H3axmAZzMYVlsDoMA4ai51J+JXwP1MHv9cBYXAeTXCAPIiMEJ5iR5C961+Eqh6dyJa
         Khei+h3+kF72daKekWqqOv5LSV21LUCVjT+6/cDEYLnJjYgR3QPwguV37rS06dsGLNg8
         6ffLTdZFD2LbBKLVljM34lLjDvKIgwV2iwGfn5MvjX/F/q5DpbqOdby1xzr3ppmhDqVu
         qMvpAMDGwL+65k27enlOBwYxW9aBoeV1lUbsiHdOjNLQOl4WO9ruvHtFm5z4wJIwGU9O
         q5NdSsVLC4nelM/bEHVn7uVfdYTwYkqYR5iBWQBCWe4/aSSp2pWDhkfuX3XGbUZfyj1o
         +pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589180; x=1695193980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1bT9y8w37q/lqO7jWhPz/MCizYdOi4GhRkpzRZ8STo=;
        b=IxBv7nD9xRRaq6EZRFpqZXNG530cWzY593usI0+lAmteVwOATYQzHJIFEKN+Y62Ppb
         Bt2PZr1ngJXCqIbIekqJ2Ra8j2+CUpRAla34KNEA4ABFMgYRgWFD5PBoB4a0xn1+9zqv
         dQV9oCkrga1djr9LcBcdrdMhVc4jFJwUasrRDl6PbBur8ZlLk8UrsdAKY0q4GH3fjDl9
         S7iH/ElWxz61EZ/rYAdozS3tCxW/7D/vJpUtCC7/dHymIEHSsvmWbB8hA7nhgMhyT9Fq
         cSZRgf1hZLcuSPFOFBMXYTTn3QBnygEGoGA6J1iF7f9KJVxcORvAMen+aMcjDBxuWVsS
         UMYg==
X-Gm-Message-State: AOJu0YxGogJZYXTkH1XRwfK/3Oj0C9xAOrF/qs769Skzqr8Nqtik0fj3
	snwN9KBCEQJQ8mSc7+05c+XfPJBOS16crCteOQ8=
X-Google-Smtp-Source: AGHT+IGtZHMYbT255bHbYyb1Y1eoVQqwOABQajlX+UkYvc41jFozXUm3VUt+1Y5ij29G9g2icyooWQ==
X-Received: by 2002:a05:6512:3088:b0:4fe:95e:159a with SMTP id z8-20020a056512308800b004fe095e159amr1659956lfd.23.1694589179608;
        Wed, 13 Sep 2023 00:12:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fed630f560sm1114662wmb.36.2023.09.13.00.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:59 -0700 (PDT)
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
Subject: [patch net-next v2 08/12] devlink: expose peer SF devlink instance
Date: Wed, 13 Sep 2023 09:12:39 +0200
Message-ID: <20230913071243.930265-9-jiri@resnulli.us>
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

Introduce a new helper devl_port_fn_devlink_set() to be used by driver
assigning a devlink instance to the peer devlink port function.

Expose this to user over new netlink attribute nested under port
function nest to expose devlink handle related to the port function.

This is particularly helpful for user to understand the relationship
between devlink instances created for SFs and the port functions
they belong to.

Note that caller of devlink_port_notify() needs to hold devlink
instance lock, put the assertion to devl_port_fn_devlink_set() to make
this requirement explicit. Also note the limitations that only allow to
make this assignment for registered objects.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of previous patch
- utilize newly added rel infra
- split devlink_nl_put_nested_handle() arg extension into separate patch
---
 include/net/devlink.h        |  3 +++
 include/uapi/linux/devlink.h |  1 +
 net/devlink/port.c           | 51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 29fd1b4ee654..2655ab6101ec 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -150,6 +150,7 @@ struct devlink_port {
 
 	struct devlink_rate *devlink_rate;
 	struct devlink_linecard *linecard;
+	u32 rel_index;
 };
 
 struct devlink_port_new_attrs {
@@ -1697,6 +1698,8 @@ void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 contro
 void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
 				   u32 controller, u16 pf, u32 sf,
 				   bool external);
+int devl_port_fn_devlink_set(struct devlink_port *devlink_port,
+			     struct devlink *fn_devlink);
 struct devlink_rate *
 devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 03875e078be8..cd4b82458d1b 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -680,6 +680,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_STATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
+	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 7b300a322ed9..4e9003242448 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -428,6 +428,13 @@ devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct devlink_port *por
 	if (err)
 		goto out;
 	err = devlink_port_fn_state_fill(port, msg, extack, &msg_updated);
+	if (err)
+		goto out;
+	err = devlink_rel_devlink_handle_put(msg, port->devlink,
+					     port->rel_index,
+					     DEVLINK_PORT_FN_ATTR_DEVLINK,
+					     &msg_updated);
+
 out:
 	if (err || !msg_updated)
 		nla_nest_cancel(msg, function_attr);
@@ -1392,6 +1399,50 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 contro
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_sf_set);
 
+static void devlink_port_rel_notify_cb(struct devlink *devlink, u32 port_index)
+{
+	struct devlink_port *devlink_port;
+
+	devlink_port = devlink_port_get_by_index(devlink, port_index);
+	if (!devlink_port)
+		return;
+	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_NEW);
+}
+
+static void devlink_port_rel_cleanup_cb(struct devlink *devlink, u32 port_index,
+					u32 rel_index)
+{
+	struct devlink_port *devlink_port;
+
+	devlink_port = devlink_port_get_by_index(devlink, port_index);
+	if (devlink_port && devlink_port->rel_index == rel_index)
+		devlink_port->rel_index = 0;
+}
+
+/**
+ * devl_port_fn_devlink_set - Attach peer devlink
+ *			      instance to port function.
+ * @devlink_port: devlink port
+ * @fn_devlink: devlink instance to attach
+ */
+int devl_port_fn_devlink_set(struct devlink_port *devlink_port,
+			     struct devlink *fn_devlink)
+{
+	ASSERT_DEVLINK_PORT_REGISTERED(devlink_port);
+
+	if (WARN_ON(devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_SF ||
+		    devlink_port->attrs.pci_sf.external))
+		return -EINVAL;
+
+	return devlink_rel_nested_in_add(&devlink_port->rel_index,
+					 devlink_port->devlink->index,
+					 devlink_port->index,
+					 devlink_port_rel_notify_cb,
+					 devlink_port_rel_cleanup_cb,
+					 fn_devlink);
+}
+EXPORT_SYMBOL_GPL(devl_port_fn_devlink_set);
+
 /**
  *	devlink_port_linecard_set - Link port with a linecard
  *
-- 
2.41.0



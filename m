Return-Path: <netdev+bounces-19495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17175AE3D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBF41C213FE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462F18B1B;
	Thu, 20 Jul 2023 12:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910818C0A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:51 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5B2106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so6082815e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855528; x=1690460328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJPr/vMKbuV0TpgGx2ePkiFr9rU+ybeZG0PO9Ib0uNQ=;
        b=2imtr7cYCE4wD9c1hA4406ddXVwxaagoHZSbHsA1Ok4qdvUyR1K+tWNle7o94kPr9B
         09TUqwckkPMRFDzn4v60QJ/Nq5XQDrKMAuKfYa1SYGtrEXaQlPCO0Vh3D3fhD0qpaRCz
         qgiYSUuGKmTMYwwX5ud755DZaMV5KWrhLfI2q901i9+CbNfCAX5aVP33VGnHD/otyP92
         35jPXMNCoVqLvGozNLC9YfGRSdw6dAJAhzIH9ao40UBkOEK0mUHTix65G6CjZaM/QZGx
         TpDRDM98OHPSck8nAxMEbA17qJEK9hrdueChZBYPOz1nhBLTMZC3uurXcsvMx/Tp2aJd
         Vhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855528; x=1690460328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJPr/vMKbuV0TpgGx2ePkiFr9rU+ybeZG0PO9Ib0uNQ=;
        b=E4E2KVZ5dJ9xs30FPUkmf8OASwjDBwASDguygPfW1X+JbJqzZs1BNTx6LyhmMwXgDj
         Vike0PqlzTBlIwyOrcQogBQprjj7tYU9KFp6vdiARUZhEuBOAjGBblvTY4vTcNEcG+/D
         1MrDNSe7GPNOnGQ/j/eZ1VlXM3Ja6YijVpLeDX0ihh+CVlLWelgLfqYYCCwp0ZKJSrGo
         SybYYCyo9GqF8/tnhUkpMrenyCdkNIAmOPcqdZ3ytZta0vJRQKK4dg8OzuWm6/1iu07K
         jQaWZMZToMFGQG7aw5l3RgWEQGqGP5owqm/jHdL58niMsWlaWcebz7kqn/Fwpnl2mxi/
         mQpQ==
X-Gm-Message-State: ABy/qLZ1tWhiZrmrHKtrhZAy9QztqsRBqC2Qg+ABzK+grFZxe+7A5JIm
	aHSYIGc4/nX0eVLAzmh2Zb+Iiv6nCvRJYBngdTs=
X-Google-Smtp-Source: APBJJlG5oBk0biBCBZ1SHd6/H/OijoZfE+5TBpY4lVaQeXbxQ+GMCWAkAAXQ33A1J/D0BNX1J65LUA==
X-Received: by 2002:a05:600c:3658:b0:3fb:b008:2003 with SMTP id y24-20020a05600c365800b003fbb0082003mr6888281wmq.38.1689855528366;
        Thu, 20 Jul 2023 05:18:48 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q9-20020adfcd89000000b0030ae3a6be4asm1202600wrj.72.2023.07.20.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 11/11] devlink: extend health reporter dump selector by port index
Date: Thu, 20 Jul 2023 14:18:29 +0200
Message-ID: <20230720121829.566974-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720121829.566974-1-jiri@resnulli.us>
References: <20230720121829.566974-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce a possibility for devlink object to expose attributes it
supports for selection of dumped objects.

Use this by health reporter to indicate it supports port index based
selection of dump objects. Implement this selection mechanism in
devlink_nl_cmd_health_reporter_get_dump_one()

Example:
$ devlink health
pci/0000:08:00.0:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32769:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32770:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98304:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98305:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98306:
  reporter vnic
    state healthy error 0 recover 0

$ devlink health show pci/0000:08:00.0
pci/0000:08:00.0:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32769:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32770:
  reporter vnic
    state healthy error 0 recover 0

$ devlink health show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0

The last command is possible because of this patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 ++
 net/devlink/health.c        | 21 +++++++++++++++++++--
 net/devlink/netlink.c       |  8 ++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 168d36dbc6f7..510b66806341 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -115,6 +115,8 @@ struct devlink_nl_dump_state {
 struct devlink_cmd {
 	int (*dump_one)(struct sk_buff *msg, struct devlink *devlink,
 			struct netlink_callback *cb);
+	const u16 *dump_selector_attrs;
+	unsigned int dump_selector_attrs_count;
 };
 
 extern const struct genl_small_ops devlink_nl_ops[40];
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 194340a8bb86..74d322ee5b83 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -390,12 +390,21 @@ devlink_nl_cmd_health_reporter_get_dump_one(struct sk_buff *msg,
 					    struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct nlattr **selector = state->selector;
 	struct devlink_health_reporter *reporter;
+	unsigned long port_index_end = ULONG_MAX;
+	unsigned long port_index_start = 0;
 	struct devlink_port *port;
 	unsigned long port_index;
 	int idx = 0;
 	int err;
 
+	if (selector && selector[DEVLINK_ATTR_PORT_INDEX]) {
+		port_index_start = nla_get_u32(selector[DEVLINK_ATTR_PORT_INDEX]);
+		port_index_end = port_index_start;
+		goto per_port_dump;
+	}
+
 	list_for_each_entry(reporter, &devlink->reporter_list, list) {
 		if (idx < state->idx) {
 			idx++;
@@ -412,7 +421,9 @@ devlink_nl_cmd_health_reporter_get_dump_one(struct sk_buff *msg,
 		}
 		idx++;
 	}
-	xa_for_each(&devlink->ports, port_index, port) {
+per_port_dump:
+	xa_for_each_range(&devlink->ports, port_index, port,
+			  port_index_start, port_index_end) {
 		list_for_each_entry(reporter, &port->reporter_list, list) {
 			if (idx < state->idx) {
 				idx++;
@@ -434,8 +445,14 @@ devlink_nl_cmd_health_reporter_get_dump_one(struct sk_buff *msg,
 	return 0;
 }
 
+static const u16 devl_cmd_health_reporter_dump_selector_attrs[] = {
+	DEVLINK_ATTR_PORT_INDEX,
+};
+
 const struct devlink_cmd devl_cmd_health_reporter_get = {
-	.dump_one		= devlink_nl_cmd_health_reporter_get_dump_one,
+	.dump_one			= devlink_nl_cmd_health_reporter_get_dump_one,
+	.dump_selector_attrs		= devl_cmd_health_reporter_dump_selector_attrs,
+	.dump_selector_attrs_count	= ARRAY_SIZE(devl_cmd_health_reporter_dump_selector_attrs),
 };
 
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index c2083398bd73..bd60d229cfbe 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -265,8 +265,16 @@ static void devlink_nl_policy_cpy(struct nla_policy *policy, unsigned int attr)
 static void devlink_nl_dump_selector_policy_init(const struct devlink_cmd *cmd,
 						 struct nla_policy *policy)
 {
+	int i;
+
 	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_BUS_NAME);
 	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_DEV_NAME);
+
+	for (i = 0; i < cmd->dump_selector_attrs_count; i++) {
+		unsigned int attr = cmd->dump_selector_attrs[i];
+
+		memcpy(&policy[attr], &devlink_nl_policy[attr], sizeof(*policy));
+	}
 }
 
 static int devlink_nl_start(struct netlink_callback *cb)
-- 
2.41.0



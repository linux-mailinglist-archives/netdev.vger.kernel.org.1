Return-Path: <netdev+bounces-45276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6EE7DBD9E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547B7B20CDC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8218C23;
	Mon, 30 Oct 2023 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WNmucrI4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157518E03
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:17:56 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97817DF
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:17:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a98517f3so6544837e87.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698682672; x=1699287472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cwnCkvKtR/PL1gWbn3Z0/7iTEdGVLg59+0VHbaXZHg=;
        b=WNmucrI4c6TAsdO3h9BC0kSUvmHkEPVejw43m4RgoqD/YHzf40/HH9I0A1gTlmzQkO
         SsuMPYZS6RAA/t9+iZKDavT1DEzcJjmE751WzNOGqFRCoxyPY9QVW/lvEORYHhAZor2m
         0loylaPxGN+96lmzZNkJ8lEtsWOZw/6Eh7Qm1GOX6uyjRT2c4MTuP8ZwGZPxC6hzBucP
         VZutguJPWD+Fi2zElNObkSa77dNQS9zoBZ2gasY1GqXVIUzJr+m81/Twg0STBn3BH/nH
         yAeIhd3zoJuNszZBjZZle5+sNjEy+q3ynL7OgfNZy5LQT/tzAs2tyNTrUMMBRMX9ATAO
         Dchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682672; x=1699287472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cwnCkvKtR/PL1gWbn3Z0/7iTEdGVLg59+0VHbaXZHg=;
        b=S8Ou1shjYq0CGXDC9iI2+M91Ar4mItTHVvxcqYAnhEseHQVYesgd8Z4UUlZ4SKD4J/
         BScfDiYc0tiegW7lOowPWwCtV6/bc9OV+VEgrGtkHOsRzY2v2R3fsvrYsWGa1Uo6C5aB
         5puRnmy2+O2ZtuE3rTa7JmVFAEFo9DM3pti07Pn9WdT3kL+vBicKgMqR5oavqjK1QiR6
         1WSR9W14QrsdlyERM1wdVXOLoF5AZU0tPgKoxov3S1y7IEalx0pJ1zY4OMJg+8sJlj6v
         qVTvUxASVp0yoI2DJeXHGJMCFVK+OnIWHal5uIG6c9OSKOMWFE1jHGgYIzC6oQvgIuim
         4t1A==
X-Gm-Message-State: AOJu0Ywmipy5/oXTqO4LGp+18s50eIW8YnALXycHJSFLw+dwsX511GPN
	f/CC+AEtXRexFLP/TE8z4X5VVTGG3FsX3Myqyos=
X-Google-Smtp-Source: AGHT+IGJeGbGfwqMYnUZJ8vpMgs4LSTXWYkYlaGQoIbnnzuAwofMC5hFLAH4B7GBQk3/Pgs8USwJow==
X-Received: by 2002:ac2:5104:0:b0:507:a624:3f36 with SMTP id q4-20020ac25104000000b00507a6243f36mr7270644lfb.11.1698682671683;
        Mon, 30 Oct 2023 09:17:51 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r17-20020a50aad1000000b0053e2a64b5f8sm6362787edc.14.2023.10.30.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:17:51 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com
Subject: [patch net] netlink: specs: devlink: add forgotten port function caps enum values
Date: Mon, 30 Oct 2023 17:17:50 +0100
Message-ID: <20231030161750.110420-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add two enum values that the blamed commit omitted.

Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 4 ++++
 net/devlink/netlink_gen.c                | 2 +-
 tools/net/ynl/generated/devlink-user.c   | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c6ba4889575a..572d83a414d0 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -71,6 +71,10 @@ definitions:
         name: roce-bit
       -
         name: migratable-bit
+      -
+        name: ipsec-crypto-bit
+      -
+        name: ipsec-packet-bit
   -
     type: enum
     name: sb-threshold-type
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9cbae0169249..788dfdc498a9 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -15,7 +15,7 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_OPSTATE] = NLA_POLICY_MAX(NLA_U8, 1),
-	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(3),
+	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 75b744b47986..bc5065bd99b2 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -121,6 +121,8 @@ const char *devlink_port_fn_opstate_str(enum devlink_port_fn_opstate value)
 static const char * const devlink_port_fn_attr_cap_strmap[] = {
 	[0] = "roce-bit",
 	[1] = "migratable-bit",
+	[2] = "ipsec-crypto-bit",
+	[3] = "ipsec-packet-bit",
 };
 
 const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value)
-- 
2.41.0



Return-Path: <netdev+bounces-29991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DF7856EF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FEB2812DB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202CBE68;
	Wed, 23 Aug 2023 11:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F03C120
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:23 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18769E5E;
	Wed, 23 Aug 2023 04:42:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso55344011fa.1;
        Wed, 23 Aug 2023 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790940; x=1693395740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiVZqxrHrDEjKqHpG0E1vsVFPxLq4d+wLTQ19ytIU5Y=;
        b=Cnx6eI5givYG7DFs03E8bRpsX52flO5OdLw9KuggFvt+ByYX8OJXb4QuaB/uvBMLDm
         FlSGyoHyTpfk5rhQRZhGouaW8rx7JfvJeCkChiGnY8Fg1dT5nvV2U+2IvsOW9kWHf7iK
         LsFiEwgN+HvSOPheEiKsPGzmaO+KRiY7dhzcQVQq/r6e9wRBLHF6UQDNsJhR3/toB0/4
         JZQpb6aTWyhMNG++ro6aJwwn92LV7U3mhLKdGq1/HXHwixC1x+VzlV29+HNbpuK89eFb
         FAEuArPrmM5GDE98zwHnB/Zd2jGHc12Uc91Rt4DfZixBI9LXqXxMc1svf6xwN9Vjt8E0
         dJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790940; x=1693395740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiVZqxrHrDEjKqHpG0E1vsVFPxLq4d+wLTQ19ytIU5Y=;
        b=RQnm4lqjQ4gw4O5ANNPbY15fTYzbExq2t9giiTCxuwSxgB62shs/t16JLlKaCseHCf
         CxknYa8A4ArL2V5GeP3QaV9CvarOSZU0goWO/CaT7dMJoulTAxWpMhW4sI7q+7dBGQOV
         fsdQo5OvfndcY2Fgkmhto87AAqaYYvSXo8aG9OuBsDf6mBDJRfruYiUoRZpTPS0AkoWH
         TLnQ+nFlenEekzXX/oeJ0qWdMksSRrxuU6AHpntLRFm53No1mUAl4jCO9lITbwmZnlgF
         pgRxEpGPOAk+0NKfnoC+/KtlZ1ZAcF1ZEV20OP6uBUUQHI1cteUBUryl85SFiUiSsV3m
         RveQ==
X-Gm-Message-State: AOJu0YzAOGx9SYok1PyWrLOGpwHZuDnSelHlLPMYRENMvkDCgoZrCW9q
	rZDpIZlEMvD8jiRh9/uWMwPDIvds9krJNQ==
X-Google-Smtp-Source: AGHT+IG6RxwuOW+2PvCFmEP3EsuNwibj0dUKzozA1fRt36PoqzpnRDkm8fZTyf3deWg+o0omHzQa0A==
X-Received: by 2002:a2e:958e:0:b0:2b7:4169:fcf5 with SMTP id w14-20020a2e958e000000b002b74169fcf5mr8897056ljh.37.1692790939858;
        Wed, 23 Aug 2023 04:42:19 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:19 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 05/12] tools/ynl: Add mcast-group schema parsing to ynl
Date: Wed, 23 Aug 2023 12:41:54 +0100
Message-ID: <20230823114202.5862-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823114202.5862-1-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a SpecMcastGroup class to the nlspec lib.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 0ff0d18666b2..37bcb4d8b37b 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -322,6 +322,26 @@ class SpecOperation(SpecElement):
             self.attr_set = self.family.attr_sets[attr_set_name]
 
 
+class SpecMcastGroup(SpecElement):
+    """Netlink Multicast Group
+
+    Information about a multicast group.
+
+    Value is only used for classic netlink families that use the
+    netlink-raw schema. Genetlink families use dynamic ID allocation
+    where the ids of multicast groups get resolved at runtime. Value
+    will be None for genetlink families.
+
+    Attributes:
+        name      name of the mulitcast group
+        value     integer id of this multicast group for netlink-raw or None
+        yaml      raw spec as loaded from the spec file
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+        self.value = self.yaml.get('value')
+
+
 class SpecFamily(SpecElement):
     """ Netlink Family Spec class.
 
@@ -343,6 +363,7 @@ class SpecFamily(SpecElement):
         ntfs       dict of all async events
         consts     dict of all constants/enums
         fixed_header  string, optional name of family default fixed header struct
+        mcast_groups  dict of all multicast groups (index by name)
     """
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r") as stream:
@@ -384,6 +405,7 @@ class SpecFamily(SpecElement):
         self.ops = collections.OrderedDict()
         self.ntfs = collections.OrderedDict()
         self.consts = collections.OrderedDict()
+        self.mcast_groups = collections.OrderedDict()
 
         last_exception = None
         while len(self._resolution_list) > 0:
@@ -416,6 +438,9 @@ class SpecFamily(SpecElement):
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
 
+    def new_mcast_group(self, elem):
+        return SpecMcastGroup(self, elem)
+
     def add_unresolved(self, elem):
         self._resolution_list.append(elem)
 
@@ -512,3 +537,9 @@ class SpecFamily(SpecElement):
                 self.ops[op.name] = op
             elif op.is_async:
                 self.ntfs[op.name] = op
+
+        mcgs = self.yaml.get('mcast-groups')
+        if mcgs:
+            for elem in mcgs['list']:
+                mcg = self.new_mcast_group(elem)
+                self.mcast_groups[elem['name']] = mcg
-- 
2.41.0



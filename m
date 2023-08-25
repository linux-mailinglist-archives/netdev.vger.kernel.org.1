Return-Path: <netdev+bounces-30656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B8788767
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5660E281839
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C40DF6C;
	Fri, 25 Aug 2023 12:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122ABCA4E
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:03 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8863268C;
	Fri, 25 Aug 2023 05:28:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4013454fa93so7463935e9.0;
        Fri, 25 Aug 2023 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966494; x=1693571294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3JNQ7Oh5owJGsNuRLVxCjomaWW15pCWkrYOkZcvBZo=;
        b=Lncl2MGerveCnauB8RSWWpOZRFMOIEx4RypcTwCXkIJiP0eOKIpXyKtb0DjPmRpGJt
         wuWPQpCLgMl4QHtHnbmXtHd6kTi/oWgLhIQd/KKxqY8gvYV3Ec4cJG0NJlyL2UjE1sEX
         2Zr9icGJPi/melNc3bdu18quAduAmL1FoO4dJOqyegiBc9627hJO3jPUEs/Vp1dP3iqc
         P0oXJP/0z7P/KBSIMYtozST0oLZ8XMzP1u76VwOOMj7v1H9eX5lqpMVYo+a/VzJ27KQM
         DYcHv4FhjXJdJIfIQPKexRCFtZRmw779C1NKLVutzTiZUOJZ5B1v5t4nl3byAqfU0qBS
         PG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966494; x=1693571294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3JNQ7Oh5owJGsNuRLVxCjomaWW15pCWkrYOkZcvBZo=;
        b=RC2Inzu4JMqwzOgOivbntDIzOPRNKPVMrFjVVpz0VngL6rv/g05u39zWszLqLEzKPe
         FyzzMgu5UivlXJE8XDGoIio1+AnP7D/Zp9ykyyrRxI0Sf/H2boFjx0g6y7RLJMtFL/2p
         xmC4kI8uMVM2KdywKjQ8MIl01Bv/+5CavzcPkPAJALA3PAciVkckRbgT5FgP0D4D6XK+
         xL/9jK6AMQbW4KL1D//thN5yFA9nQSqrdRqG8YDIv5rVyU0NSbL275RweNAng9pOMFsV
         C4S5soZd8/myM1tSoZlgtQ/KkO7CEbGAHRzmeH+AvrNqqwJOqoXQVLAsX/THpdTOfh50
         wCYQ==
X-Gm-Message-State: AOJu0Yy5nY/atRspia3JSN/SS6fyMvAdQ8rKI+2xMmgrC2mMyu9S7D2J
	BJcszSRy4LvfR8UVlEkZNApN1lX6TQkF8A==
X-Google-Smtp-Source: AGHT+IHvfQHUjSBj767WLXKMRLsZ5p3K49y34JnMzlJFnuZ6dNLmg2pkEVxpR7DIVqxlFb/8oCb/4Q==
X-Received: by 2002:a05:600c:218d:b0:401:38dc:8918 with SMTP id e13-20020a05600c218d00b0040138dc8918mr3659016wme.24.1692966493768;
        Fri, 25 Aug 2023 05:28:13 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:13 -0700 (PDT)
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
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 05/12] tools/ynl: Add mcast-group schema parsing to ynl
Date: Fri, 25 Aug 2023 13:27:48 +0100
Message-ID: <20230825122756.7603-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825122756.7603-1-donald.hunter@gmail.com>
References: <20230825122756.7603-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a SpecMcastGroup class to the nlspec lib.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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



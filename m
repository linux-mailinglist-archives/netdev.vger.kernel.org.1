Return-Path: <netdev+bounces-27801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFA77D382
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C991C20DF8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140419882;
	Tue, 15 Aug 2023 19:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B51426C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:38 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8810C1;
	Tue, 15 Aug 2023 12:43:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so53309825e9.1;
        Tue, 15 Aug 2023 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128615; x=1692733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDx4UweuNbOniPGlCFbOuSXwgxgV3XvqIUyY5uAZbZI=;
        b=jozvqTnHbUBkcZLEfQY4U3sMIaVGJ2e+StTjbeuPsbeZ/ozhisINZVC5OusOS6SOqB
         hJMj75Ma20RAy2sAvnqFUBZxUqV2FvdJ5BW4qFFH537T7NEKLEC/XWcDPJzMQzzbXKKL
         ICTKvPPcXe75rYF1B6RZAM5S8gwBWp6NhU7D+S98Z5RZqjoV4eSPxGbzVR1usqPg4DWt
         P7+Z8kgdjG7kcNqzcEcTQ/zj2obVOYEtgn4oLs/MuSaWVMKlt+X++WHu3VTlBGJI195D
         8uwhz7N6aQ14E8tMQEfNzAvJRErU2k2TkuytDlLaRB3G0TPhhWsRIYpS0qkBP43x7RG7
         L3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128615; x=1692733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDx4UweuNbOniPGlCFbOuSXwgxgV3XvqIUyY5uAZbZI=;
        b=ChamTA2+QCp35lDx42R3giTtInA/GMMj9xVDyaRV5BHIx2Dls9Hu7UgVkp2JogJbV7
         4CRBjnLUuUDHKZD68c8uXvqDKeB2unX++6XdRhdKreTenrrd9P4itUa80tj1o/ELYmfP
         dGwyLpXB/CLv7kKKvvWCFq8y7tlAQveye2tt/ih1USX4lPxBB/gLQDVnjcjj53k3m74j
         fTtrzwGZYu+0+CqPZ7/LwZs1QHsLQfSQc68VyRwIv9ri+l6RNdjIrixEVpZlZWRLGi84
         r04+lpr3QGnoHCxiQ49vb94wYA4RyjpbZCgpycfSzu11UJ2Hds6zgefLPqujx7U8WW0Q
         03GA==
X-Gm-Message-State: AOJu0YzAqNVCt8eDPeQFNH/R7SsWttnGnQUsSRvgMrPNffbpbHKTBeiz
	ozqKuabxor+BC8ezTsgdXBejrxnbEgU7NmJ2
X-Google-Smtp-Source: AGHT+IECMUljCAPhztgn1+ddIKC9zxQJx97KyZhNkxLLOd+cVD2CN4DDVZU3cnQYXXZCZPVgxf4EmQ==
X-Received: by 2002:a7b:cd97:0:b0:3fe:4900:db95 with SMTP id y23-20020a7bcd97000000b003fe4900db95mr11064524wmj.37.1692128615548;
        Tue, 15 Aug 2023 12:43:35 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:35 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/10] tools/ynl: Add mcast-group schema parsing to ynl
Date: Tue, 15 Aug 2023 20:42:48 +0100
Message-ID: <20230815194254.89570-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815194254.89570-1-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
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
 tools/net/ynl/lib/nlspec.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 0ff0d18666b2..a41ad89eb369 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -322,6 +322,21 @@ class SpecOperation(SpecElement):
             self.attr_set = self.family.attr_sets[attr_set_name]
 
 
+class SpecMcastGroup(SpecElement):
+    """Netlink Multicast Group
+
+    Information about a multicast group.
+
+    Attributes:
+        name      name of the mulitcast group
+        value     numerical id of this multicast group for netlink-raw
+        yaml      raw spec as loaded from the spec file
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+        self.value = self.yaml.get('value')
+
+
 class SpecFamily(SpecElement):
     """ Netlink Family Spec class.
 
@@ -343,6 +358,7 @@ class SpecFamily(SpecElement):
         ntfs       dict of all async events
         consts     dict of all constants/enums
         fixed_header  string, optional name of family default fixed header struct
+        mcast_groups  dict of all multicast groups (index by name)
     """
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r") as stream:
@@ -384,6 +400,7 @@ class SpecFamily(SpecElement):
         self.ops = collections.OrderedDict()
         self.ntfs = collections.OrderedDict()
         self.consts = collections.OrderedDict()
+        self.mcast_groups = collections.OrderedDict()
 
         last_exception = None
         while len(self._resolution_list) > 0:
@@ -416,6 +433,9 @@ class SpecFamily(SpecElement):
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
 
+    def new_mcast_group(self, elem):
+        return SpecMcastGroup(self, elem)
+
     def add_unresolved(self, elem):
         self._resolution_list.append(elem)
 
@@ -512,3 +532,9 @@ class SpecFamily(SpecElement):
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



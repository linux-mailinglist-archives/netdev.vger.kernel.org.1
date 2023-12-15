Return-Path: <netdev+bounces-57835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A938A8144B2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308C11F236A4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930791A730;
	Fri, 15 Dec 2023 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1L7GwCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9891249EF;
	Fri, 15 Dec 2023 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33644eeb305so297691f8f.1;
        Fri, 15 Dec 2023 01:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633066; x=1703237866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7ATvvWAwlICnlQ+Ug6Mcf8P7xms4Jb4b05sYoRU5LI=;
        b=B1L7GwCABIYJ4ib4tj0UyBe7lcjMhU/CSlnVNSomHF3Qrr+zK6bsyWjTP/0BSl3WEC
         MKfX2bbOG6GJwA3VTfZ9q1tTv9l4cEzOTMkKJNBOmGdu3XVR0SEt04myAVLjR/s6z3pg
         K0ZWqAuoRlDKULBsGkQj0rTSQpOwdSVi8cVFL0ya+M31DlMKUKoCpi8ja9qyI5E9mlS7
         1nR5Cc2BwqdCo6OYpVABy47kZoShSSRFiipi4h+qzPNa/p0Wei5tP2Cf0QZEVQdm4iYl
         bea+zpfovlrRYbsJtHxLe2zNYePSHv37P5nDIMDBDGHL8+x8wVmHmkPykg9gHlAEicJx
         bvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633066; x=1703237866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7ATvvWAwlICnlQ+Ug6Mcf8P7xms4Jb4b05sYoRU5LI=;
        b=qRsxxhZF+SjVAN0LAURENPBNPIaCcj4sECrDUt5ZK64kho60xyLslKueNWll6dSA56
         Ermfj3D0k37UvqAYZNab6XDsyurN8hOnVhkwvVIAcHQuwZ/Qg+2i6RdFBR+NiHhTrYh3
         gzDUCYgDJHuGRLhz/oaWjVyYP5saa4W6PoepLvKzvAZAaE20gfucux+1iTXKlAL6FLoS
         I06RKFF1W1zXzPpV6jsOz94wORHWRTdOm5YjHcPQd+9LUAbNmZVcJJfHlV/eqkqSf6GM
         BNzyKY/PIfn+fkg1U9SiqJoez3x6o1Zp/va20OZNnsDKiEe7d8uV6KCYHdRI35rRXoFo
         iIjA==
X-Gm-Message-State: AOJu0Yy9RRS30hn0ssSGAZAbFBWQU4ab1z/KtnqO1UMGuA3uOyTUgnT5
	NjgiPeOl+JOhjo+Pa6wZMSMS10wANArg7Q==
X-Google-Smtp-Source: AGHT+IHgyBUalSGMVqWbbjNc1RTl/atsPwf+KVuJw6VRP424NCK9Nme7PwfgKhZeFD+MvTQ38dry2Q==
X-Received: by 2002:a05:600c:c1b:b0:40b:5075:c147 with SMTP id fm27-20020a05600c0c1b00b0040b5075c147mr5247043wmb.8.1702633066612;
        Fri, 15 Dec 2023 01:37:46 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 10/13] tools/net/ynl-gen-rst: Add sub-messages to generated docs
Date: Fri, 15 Dec 2023 09:37:17 +0000
Message-ID: <20231215093720.18774-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section for sub-messages to the generated .rst files.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index b6292109e236..19e5b34554a1 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -251,6 +251,24 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
     return "\n".join(lines)
 
 
+def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
+    """Parse sub-message definitions"""
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(entry["name"]))
+        for fmt in entry["formats"]:
+            value = fmt["value"]
+
+            lines.append(rst_bullet(bold(value)))
+            for attr in ['fixed-header', 'attribute-set']:
+                if attr in fmt:
+                    lines.append(rst_fields(attr, fmt[attr], 2))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
 def parse_yaml(obj: Dict[str, Any]) -> str:
     """Format the whole YAML into a RST string"""
     lines = []
@@ -287,6 +305,11 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
         lines.append(rst_subtitle("Attribute sets"))
         lines.append(parse_attr_sets(obj["attribute-sets"]))
 
+    # Sub-messages
+    if "sub-messages" in obj:
+        lines.append(rst_subtitle("Sub-messages"))
+        lines.append(parse_sub_messages(obj["sub-messages"]))
+
     return "\n".join(lines)
 
 
-- 
2.42.0



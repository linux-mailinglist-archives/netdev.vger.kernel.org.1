Return-Path: <netdev+bounces-56625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963AD80FA12
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E081C20DDC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0064CFA;
	Tue, 12 Dec 2023 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PleFqmvc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF4CE;
	Tue, 12 Dec 2023 14:16:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-336378d3bfdso245631f8f.1;
        Tue, 12 Dec 2023 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419401; x=1703024201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHxjA/PI+QAMG6yG9cC6vwGS4SQuFy0Xe9c6W4xTqrU=;
        b=PleFqmvcZjiIYBQ7g45jWKUS9AxCrgbMg3/6X1WVSK91i7ZreLypDHcILIEgAIR3Da
         daotFiS33KPR0hHSQyBH0mQfYCSG3N4+8w6VfdGNoWbVcMCq0amOLKw1sVc+osxfSH/v
         e7VJOCONxquZjd63fet6WlyGrlczvC7zI57WH5AqxLGfbZ/Sj8Ji8L942L64ojxQgAku
         AYJ5Pmn7v1Leyu5rCd+NekSfPk7Xy/f54QPjVjSdVafvqQHK7Rdv9KtMz97jLNUGV42N
         u1UbfdoTsabDc98c7kzkqVWk0Wze1xP01yvj0ynp9LUAtZefqvhQMC+uWQGuwOmI5E0s
         8CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419401; x=1703024201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHxjA/PI+QAMG6yG9cC6vwGS4SQuFy0Xe9c6W4xTqrU=;
        b=udDy12k2eTiKCDa90dbov+8L02Uc5RKUJwAafYj14kxhjbP2tpH/dqVaMQxcJj5SVv
         InZRzu808PL4FvJlz4o8a4nENsX8Wx9k6mDLj4ul39iY1I2g5DZFY6q+c08nUKL9FlxP
         eWrrgLX3NY4kiF6SjrZ38vDTd+OoTucg6Zf8t/ByUCphJCrw8tcUnI1Hxp7UCta9Usvx
         Ds7wSokb0d6RIyeHG2qkbiJScNlXQimc+Lo1L5FGuGyoXr9OEP2Q/4bozN3rFKlABdDY
         u6kSx6uDsiAOvEQ6GGLC5Voue3FjTz5vntqGCUVXwGFpvov8JvYvCA56e9m6dAuN6Cgt
         S3Cg==
X-Gm-Message-State: AOJu0YzHdX0xgLmkwzsvaAAyB7URSm8/je1DV56107YQcLhx/Wik6M+f
	gMTAnbUtKRg3zEzliaI195DZL0u1pi/Ltg==
X-Google-Smtp-Source: AGHT+IHAaHcjvbDyC4d75ye3Sgk47lb+xm9olv+jfpgp/vnm6uxEEARq3DUHgd7QxnaM+G6PZ+gKKQ==
X-Received: by 2002:adf:fa83:0:b0:333:2fd2:2ee4 with SMTP id h3-20020adffa83000000b003332fd22ee4mr3473688wrr.93.1702419400845;
        Tue, 12 Dec 2023 14:16:40 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:40 -0800 (PST)
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
Subject: [PATCH net-next v3 10/13] tools/net/ynl-gen-rst: Add sub-messages to generated docs
Date: Tue, 12 Dec 2023 22:15:49 +0000
Message-ID: <20231212221552.3622-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section for sub-messages to the generated .rst files.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
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



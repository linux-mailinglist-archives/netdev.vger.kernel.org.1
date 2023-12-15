Return-Path: <netdev+bounces-57837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDB8144B6
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475F81F23669
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A7182C3;
	Fri, 15 Dec 2023 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdAhbdTD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821624A1B;
	Fri, 15 Dec 2023 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso9022685e9.0;
        Fri, 15 Dec 2023 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633069; x=1703237869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=QdAhbdTD9FqAWwjPcnObWwoByyaZP8XvBmJ7a0FYrMwSmlUGO5s9ldm3pz9oumR+su
         eJ6pG+iuNslq9zx+aH6ci2kD+tdkLKP1yDckNKgyPFmRHA3Q8hfW52xP+4Dm8O7Lg/go
         jwnRZOyKVxkA6a0MEUhI6JSyUHkVTv9wf8j8vFL1ZC6Z4dUtl7FblRVddCunelhh9D/H
         HjonpiG282U9yy+mXL8r+StPllCxo1ssOHqMraKzKY2jzBLSaC40XPbDFtc7Fho2vpcu
         XmmAl9TqcmFCi6YEd7v3F+1rBW24aQtSJ2y3BQ5qMyA5XJAV2S6tLXZqxfaKHbmnRMsR
         V3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633069; x=1703237869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=OG96BVHipXA2MkTeZ7u3S8ZS7x3ZaDD3KHjCwGqhZZrvKHb3GAz2guE2JvRqFgLE+u
         3R21oUTownS/x9Bx1zQDP1dAnjuW59LjsQddSL7xgitqldHbMQryhVgX/Uqv/48LoANh
         AKYenshRiXzrYvg6hSt+047H060h7UFZYNe6LpD5C2n9WukdPpU/ZcSLMOa11N8Xx2TI
         50ZJ8Wp2fDimMfz0B2Dn/Wp07TsukiMZSv3244DT4K+Ynucq7EKLzcXnCwO2FHJTi1yl
         B9ZUVUr88ILNAf/lFCt7VZYNQQjwfNRbZ7/RqsK6Zzd9jgjE2S5bkjeGZnLPtUDwRL+9
         MaEA==
X-Gm-Message-State: AOJu0YwnerSJFNteNv/MT0TtnP3G446NpIwZ783cASrBP2dErVv/eGVG
	5QZ0T2HmyIfjpUpOzoXVoVvf4gK8X3gNxw==
X-Google-Smtp-Source: AGHT+IGr501RoT3yisw9pNhbUwTXXkC7CkKtCN+YPdPEOdCasBKtM8uLNqDky8+PbogpE0jebnq2iw==
X-Received: by 2002:a05:600c:138c:b0:40c:53bb:71d9 with SMTP id u12-20020a05600c138c00b0040c53bb71d9mr3140590wmf.111.1702633068904;
        Fri, 15 Dec 2023 01:37:48 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:48 -0800 (PST)
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
Subject: [PATCH net-next v5 12/13] tools/net/ynl-gen-rst: Remove bold from attribute-set headings
Date: Fri, 15 Dec 2023 09:37:19 +0000
Message-ID: <20231215093720.18774-13-donald.hunter@gmail.com>
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

The generated .rst for attribute-sets currently uses a sub-sub-heading
for each attribute, with the attribute name in bold. This makes
attributes stand out more than the attribute-set sub-headings they are
part of.

Remove the bold markup from attribute sub-sub-headings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 6b7afaa56e22..675ae8357d5e 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -235,7 +235,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
         lines.append(rst_section(entry["name"]))
         for attr in entry["attributes"]:
             type_ = attr.get("type")
-            attr_line = bold(attr["name"])
+            attr_line = attr["name"]
             if type_:
                 # Add the attribute type in the same line
                 attr_line += f" ({inline(type_)})"
-- 
2.42.0



Return-Path: <netdev+bounces-57838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5208144B8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7108284863
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376C18B04;
	Fri, 15 Dec 2023 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhr8MxsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30524B43;
	Fri, 15 Dec 2023 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so2030775e9.1;
        Fri, 15 Dec 2023 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633070; x=1703237870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V5ZQMPmTn5yuCORESpkBWINnqFBr/Yw1GW8OWGFQV0=;
        b=nhr8MxsNjOdHM2q1mmQvtxuCVKQFoYK228hMPOB411UkSHJ/xWup26Zw3rR0+7Jrws
         ycFcELw0CdOh2XhcwqFQZQO5lZIP93fdy0uQnASLS6yQo15KM+7Du+WHVxLn2u2tYubY
         mWpRbAh15WCecaEli2p/mpEnfsfVPPrtO5qirn+5TY2Imo7pxqGt1niJ8+GjKSL9MKxI
         hmAAEUikQyfDd34YRaOD7SiM548IOiKmJCuo+/+knhRW0v7lO3wTytDOwPL21Nv9Rcia
         ziY8Ldb50wW7z4/6cSgwm5JitFlMfi0e+/YLRBXoeqQjprQ/RAL2Il7YeAfdxBFLLqaA
         D+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633070; x=1703237870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V5ZQMPmTn5yuCORESpkBWINnqFBr/Yw1GW8OWGFQV0=;
        b=ccPpnfKrLg5ZHwZZrWZYstB9jTjvf/0AQ+u+WofqNXphBlICD7uJu7uoVk/Km9Rquj
         VR8pmUFKaMug7tipl6DT4J3dZXUSU3SJnhcxWiniTwh1w2B3a+AGTQZW5Rj0WtWV1kKg
         Ya+Gl4aMzL9XdChKPwEbn1g6qggEZpXbXkSC7jRwuTXmDvFPHM1qe4vSyTbsshA56RZc
         2e5OTlj4gAxF5P5qoFT4SDMH4Q2PfBmM5BL8Hj+KZdSIWNu4GJtTEFvummu7ReLmqFHr
         y/5U/sO1ZvZruDJn3gJBf1XEFCdDNDNd3XBJR7flulXYtvz/iDahRnuZD3+xbYQSkMY7
         YdhA==
X-Gm-Message-State: AOJu0YyydCcvSUxfyUe6TkuIA8IFkj51srZbxq6fPPlDKi0NDkBU2J0E
	IpV5LlASLMQ52bzNDFYINQzPllslR3Mf3w==
X-Google-Smtp-Source: AGHT+IGfnlBGJ0nCrH3bQnX6Z3jF5liqc7MqaoC0YQ2zZYYLKNz3AjvXb4jonYvgNiIOQUqJbmtLUA==
X-Received: by 2002:a1c:6a13:0:b0:40b:5e4a:2352 with SMTP id f19-20020a1c6a13000000b0040b5e4a2352mr5786568wmc.84.1702633070330;
        Fri, 15 Dec 2023 01:37:50 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:49 -0800 (PST)
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
Subject: [PATCH net-next v5 13/13] tools/net/ynl-gen-rst: Remove extra indentation from generated docs
Date: Fri, 15 Dec 2023 09:37:20 +0000
Message-ID: <20231215093720.18774-14-donald.hunter@gmail.com>
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

The output from ynl-gen-rst.py has extra indentation that causes extra
<blockquote> elements to be generated in the HTML output.

Reduce the indentation so that sphinx doesn't generate unnecessary
<blockquote> elements.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 675ae8357d5e..f7d5bf96736f 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -69,7 +69,7 @@ def rst_paragraph(paragraph: str, level: int = 0) -> str:
 
 def rst_bullet(item: str, level: int = 0) -> str:
     """Return a formatted a bullet"""
-    return headroom(level) + f" - {item}"
+    return headroom(level) + f"- {item}"
 
 
 def rst_subsection(title: str) -> str:
@@ -245,7 +245,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
             for k in attr.keys():
                 if k in preprocessed + ignored:
                     continue
-                lines.append(rst_fields(k, sanitize(attr[k]), 2))
+                lines.append(rst_fields(k, sanitize(attr[k]), 0))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -263,7 +263,7 @@ def parse_sub_messages(entries: List[Dict[str, Any]]) -> str:
             lines.append(rst_bullet(bold(value)))
             for attr in ['fixed-header', 'attribute-set']:
                 if attr in fmt:
-                    lines.append(rst_fields(attr, fmt[attr], 2))
+                    lines.append(rst_fields(attr, fmt[attr], 1))
             lines.append("\n")
 
     return "\n".join(lines)
-- 
2.42.0



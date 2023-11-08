Return-Path: <netdev+bounces-46640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F37E5844
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66C21C20952
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0321199AE;
	Wed,  8 Nov 2023 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCFXkccT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15389199AC;
	Wed,  8 Nov 2023 14:04:04 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738E71BEF;
	Wed,  8 Nov 2023 06:04:04 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso7087246d6.1;
        Wed, 08 Nov 2023 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699452243; x=1700057043; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bTSKgbOdcy5X+MX1qBjBKNf1zsmqIk3O75quBISCig=;
        b=fCFXkccT89WYTvJDpsjXzOBJR/RQ7cnTYHkPc7sVV8uTUyeaUPpIM5tHD0V1MC1Lw/
         fsZpST0SZw34V8cL0I1quZRNfBh8lSZSaKoQNFh1u6M3XAxHWoFG3v7FnKTy7Sm5HvcN
         rPA4hjoXOnt1wdjUAb7RIjNq9vNP/qI27bhaM1z9dOaDp8MBRSqWovV4U6SIoOzpbKH1
         VUnQk25/QaJtBZ3snLodIHK3+3yn5JZXmhvE/TXWDAR7s7B1Vv9A0MLU+LaE3Yoiz3WQ
         Rel34ceyqoicupF/lzAvd0LaxmA7Tdn8hBbMu8rZp0Bk9UiFoMhtdu3i0X4395wGKKtI
         qUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699452243; x=1700057043;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bTSKgbOdcy5X+MX1qBjBKNf1zsmqIk3O75quBISCig=;
        b=mkPKAnqT3Wm0XAuZC3lIrqrpvfFj/yJmt2OMHWTzYf19kURCG2Tef8R5DEAqb/IcwT
         Wx6FI2J4npwtqxYXqZbdLTWir+PkPwrJHjiy1d2VXTQcvhkELIsguKbZIeZukwl5bmkD
         2Tg4BF8nTeE07//daq1hPzuxh0FUOK3mE6I55i4QNEoOqtNyPFj7A6l2SkHLuMqBmSMP
         hkIx/3efoAxWMgrBO43yo9NuIXSfHFfiGSf1gSv7KhSilyUrqGXuGg4UZvKcrod8QrBX
         UQ64+DxJdZC5G+iBWC3lv3XxQOerZ6hTtdawG6YQDCwZa3HpjG04XSaYb/BY471Zfv2S
         SKtQ==
X-Gm-Message-State: AOJu0Yy2DfUBJMJWI8CcnADCF1xblJaf5QgwfUeGaZluNolwruCMsp6h
	6mFxpMOQhundixwrGeshfRl/c7Bxk8nJOpXW
X-Google-Smtp-Source: AGHT+IGapD8WBUv+8bhRoBfqfirLNajqwl253g5PMx4/w0HQ+14WYEJ3KMz+G+KeHuLkDQKJcpVfbA==
X-Received: by 2002:a0c:d84c:0:b0:66c:fa89:a894 with SMTP id i12-20020a0cd84c000000b0066cfa89a894mr7899917qvj.10.1699452242986;
        Wed, 08 Nov 2023 06:04:02 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id o11-20020a056214108b00b0067095b0c473sm1100973qvr.11.2023.11.08.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:04:01 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net,  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <20231103135622.250314-1-leitao@debian.org> (Breno Leitao's
	message of "Fri, 3 Nov 2023 06:56:22 -0700")
Date: Wed, 08 Nov 2023 14:03:34 +0000
Message-ID: <m2y1f8mjex.fsf@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> This is a Sphinx extension that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates a rst file to be
> displayed into Documentation pages.
>
> Create a new Documentation/networking/netlink_spec page, and a sub-page
> for each Netlink spec that needs to be documented, such as ethtool,
> devlink, netdev, etc.
>
> Create a Sphinx directive extension that reads the YAML spec
> (located under Documentation/netlink/specs), parses it and returns a RST
> string that is inserted where the Sphinx directive was called.

This is great! Looks like I need to fill in some missing docs in the
specs I have contributed.

I wonder if the generated .rst content can be adjusted to improve the
resulting HTML.

There are a couple of places where paragraph text is indented and I
don't think it needs to be, e.g. the 'Summary' doc.

A lot of the .rst content seems to be over-indented which causes
blockquote tags to be generated in the HTML. That combined with a
mixture of bullets and definition lists at the same indentation level
seems to produce HTML with inconsistent indentation.

I quickly hacked the diff below to see if it would improve the HTML
rendering. I think the HTML has fewer odd constructs and the indentation
seems better to my eye. My main aim was to ensure that for a given
section, each indentation level uses the same construct, whether it be a
definition list or a bullet list.

It would be great to generate links from e.g. an attribute-set to its
definition.

Did you intentionally leave out the protocol values?

It looks like parse_entries will need to be extended to include the type
information for struct members, similar to how attribute sets are shown.
I'd be happy to look at this as a follow up patch, unless you get there
first. 

Thanks,
Donald.

diff --git a/Documentation/sphinx/netlink_spec.py b/Documentation/sphinx/netlink_spec.py
index 80756e72ed4f..66ba9106b4ea 100755
--- a/Documentation/sphinx/netlink_spec.py
+++ b/Documentation/sphinx/netlink_spec.py
@@ -92,7 +92,7 @@ def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
     """Parse 'multicast' group list and return a formatted string"""
     lines = []
     for group in mcast_group:
-        lines.append(rst_paragraph(group["name"], 1))
+        lines.append(rst_bullet(group["name"]))
 
     return "\n".join(lines)
 
@@ -101,7 +101,7 @@ def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
     """Parse 'do' section and return a formatted string"""
     lines = []
     for key in do_dict.keys():
-        lines.append(rst_bullet(bold(key), level + 1))
+        lines.append("     " + bold(key))
         lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
 
     return "\n".join(lines)
@@ -124,18 +124,19 @@ def parse_operations(operations: List[Dict[str, Any]]) -> str:
     for operation in operations:
         lines.append(rst_subsubtitle(operation["name"]))
         lines.append(rst_paragraph(operation["doc"]) + "\n")
-        if "do" in operation:
-            lines.append(rst_paragraph(bold("do"), 1))
-            lines.append(parse_do(operation["do"], 1))
-        if "dump" in operation:
-            lines.append(rst_paragraph(bold("dump"), 1))
-            lines.append(parse_do(operation["dump"], 1))
 
         for key in operation.keys():
             if key in preprocessed:
                 # Skip the special fields
                 continue
-            lines.append(rst_fields(key, operation[key], 1))
+            lines.append(rst_fields(key, operation[key], 0))
+
+        if "do" in operation:
+            lines.append(rst_paragraph(":do:", 0))
+            lines.append(parse_do(operation["do"], 0))
+        if "dump" in operation:
+            lines.append(rst_paragraph(":dump:", 0))
+            lines.append(parse_do(operation["dump"], 0))
 
         # New line after fields
         lines.append("\n")
@@ -150,7 +151,7 @@ def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
         if isinstance(entry, dict):
             # entries could be a list or a dictionary
             lines.append(
-                rst_fields(entry.get("name"), sanitize(entry.get("doc")), level)
+                rst_fields(entry.get("name"), sanitize(entry.get("doc") or ""), level)
             )
         elif isinstance(entry, list):
             lines.append(rst_list_inline(entry, level))
@@ -172,16 +173,16 @@ def parse_definitions(defs: Dict[str, Any]) -> str:
         for k in definition.keys():
             if k in preprocessed + ignored:
                 continue
-            lines.append(rst_fields(k, sanitize(definition[k]), 1))
+            lines.append(rst_fields(k, sanitize(definition[k]), 0))
 
         # Field list needs to finish with a new line
         lines.append("\n")
         if "entries" in definition:
-            lines.append(rst_paragraph(bold("Entries"), 1))
-            lines.append(parse_entries(definition["entries"], 2))
+            lines.append(rst_paragraph(":entries:", 0))
+            lines.append(parse_entries(definition["entries"], 1))
         if "members" in definition:
-            lines.append(rst_paragraph(bold("members"), 1))
-            lines.append(parse_entries(definition["members"], 2))
+            lines.append(rst_paragraph(":members:", 0))
+            lines.append(parse_entries(definition["members"], 1))
 
     return "\n".join(lines)
 
@@ -201,12 +202,12 @@ def parse_attributes_set(entries: List[Dict[str, Any]]) -> str:
                 # Add the attribute type in the same line
                 attr_line += f" ({inline(type_)})"
 
-            lines.append(rst_bullet(attr_line, 2))
+            lines.append(rst_bullet(attr_line, 1))

             for k in attr.keys():
                 if k in preprocessed + ignored:
                     continue
-                lines.append(rst_fields(k, sanitize(attr[k]), 3))
+                lines.append(rst_fields(k, sanitize(attr[k]), 2))
             lines.append("\n")
 
     return "\n".join(lines)
@@ -218,7 +219,7 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     # This is coming from the RST
     lines.append(rst_subtitle("Summary"))
-    lines.append(rst_paragraph(obj["doc"], 1))
+    lines.append(rst_paragraph(obj["doc"], 0))
 
     # Operations
     lines.append(rst_subtitle("Operations"))


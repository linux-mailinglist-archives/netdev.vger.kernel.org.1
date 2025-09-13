Return-Path: <netdev+bounces-222792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A67B5611E
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D1A1B2405A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E682F0670;
	Sat, 13 Sep 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3TeHejH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88B2F0675;
	Sat, 13 Sep 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770217; cv=none; b=K3QcNFJpGO8WqFe5EhBPe3fCX7C3l9YHQakU20xP0OSgtamyEF2lQW+vpbUKAmY+GAWCz6plVxDQVHTfD+dNYH2TgAwZgHeafFFyjobBTyjowpVQyoZ6yNQXkKv6J6wjmsywLKxi90yKSklMgFYnp6Sl6gcG0Vm8YQLWqyMgtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770217; c=relaxed/simple;
	bh=wY0XHLGd9xfGQcDc3Ca5OzNSdVcYQC1mZ0sokzrrGuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtEdY7QFrz5RjShezTbTn/M4i+UJfKjKAUxW+Mfy1PnPuJqJkfbhl4ZdglQuKx2qOu/CcjWMTZG8hVkHNtvARLXjywsQOuIhO8tt1bI7F6j5zj973jersvp3hZb2TrrO4Vp+GgcqTcXM/Je3jyJFxUbeWJ2zXnxyuTsS/v0USkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3TeHejH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9262C4CEFA;
	Sat, 13 Sep 2025 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770215;
	bh=wY0XHLGd9xfGQcDc3Ca5OzNSdVcYQC1mZ0sokzrrGuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D3TeHejHc6IrF9zNXpaHIHh5YVwGxx3F5FNWDoC19gGsFI9h1qNDsBYkivE0njdzh
	 4GEcmMO1QrLoGc5waaSuLuE49efcTzvQP3sjhhScKWY1rVvdOwZ9mm/1ky3V2wzP1+
	 FMdWgANMy+vvQ97ZJQGhHntbITD/k2YJDfdrs4NhUOpuAVm4Ox2vIddEKENmgemAkz
	 j2p3qTIFn9kobkVkcMLhCUsSYfXgdzEsnnxeWPkocYM1yDKG0qhj5uGV/xyGBDRmpr
	 B3PRkhSDX5jIh3KZ2JWmai0o9WGr6zmxBpF1spledP2CSuSXpX4IlX2YhvxKOX6I4Y
	 3M07SCW/vYy/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 13 Sep 2025 15:29:51 +0200
Subject: [PATCH net-next v3 1/3] tools: ynl: rst: display attribute-set doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-net-next-ynl-attr-doc-rst-v3-1-4f06420d87db@kernel.org>
References: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
In-Reply-To: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wY0XHLGd9xfGQcDc3Ca5OzNSdVcYQC1mZ0sokzrrGuE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOFt4XmLrLZF0yw91f21lOsyz5ceaodO/C88cSEo/GZ
 SYsdW5O7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI7kOMDH+kZOuk5t47YNWd
 O3Mec7b1Hob+Y4lTJyyas8XwpYeqRAXD/1xOnU9LDbQ+ZXRaHixw0GNzTjDR3c2hsUnJMeWFj44
 VAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some attribute-set have a documentation (doc:), but it was not displayed
in the RST / HTML version. Such field can be found in ethtool, netdev,
tcp_metrics and team YAML files.

Only the 'name' and 'attributes' fields from an 'attribute-set' section
were parsed. Now the content of the 'doc' field, if available, is added
as a new paragraph before listing each attribute. This is similar to
what is done when parsing the 'operations'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this patch can be applied without conflicts on top of net-next and
docs-next. To be honest, it is not clear to me who is responsible for
applying it :)
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 403abf1a2edaac6936d0e9db0623cd3e07aaad8e..3a16b8eb01ca0cf61a5983d3bd6a866e04c75844 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -289,6 +289,10 @@ class YnlDocGenerator:
         for entry in entries:
             lines.append(self.fmt.rst_section(namespace, 'attribute-set',
                                               entry["name"]))
+
+            if "doc" in entry:
+                lines.append(self.fmt.rst_paragraph(entry["doc"], 0) + "\n")
+
             for attr in entry["attributes"]:
                 if LINE_STR in attr:
                     lines.append(self.fmt.rst_lineno(attr[LINE_STR]))

-- 
2.51.0



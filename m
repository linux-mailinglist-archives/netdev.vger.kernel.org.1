Return-Path: <netdev+bounces-222603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C12B54F61
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6C5A3EA8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68353101AE;
	Fri, 12 Sep 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsDbMdFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52830FC24;
	Fri, 12 Sep 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683394; cv=none; b=GmhoghwzyyEVmFKk4Q8ZuPt7E2ae8C8eWG/eZTlmCjdA99MfeL5LnkOtbYj4jGZISpaHcA/FA8HqPew73/hGYhRSbhkzukdDkvYjnNtDPHf5j+BBtMkqL6b1N+0s58nHIXGu6ixXwKQ5dLFstKKvxhUKdSIGFArTQ9W83AW6axE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683394; c=relaxed/simple;
	bh=wY0XHLGd9xfGQcDc3Ca5OzNSdVcYQC1mZ0sokzrrGuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T27+dfv+dWUnMyD61UEx+ovMR5e5W7HzY/XzlPQ1X9h7gnGGNfjVboQzeluwFgXO7v44He2Oz98gSXI7aSg5pmMWdAZHN4Nj2Mcfosyfj22OfEF96tpIrw+bTzCGrRTBHzbY0pOh3agaHQ40jMb7/5qI4gkHMDun3qJFxHaCcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsDbMdFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5816DC4CEF4;
	Fri, 12 Sep 2025 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683394;
	bh=wY0XHLGd9xfGQcDc3Ca5OzNSdVcYQC1mZ0sokzrrGuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HsDbMdFW/fij6Q6lV/sVGhKgefrWI8nK6cus3DykfbfY0IRYCVnXSVUvKz1iB8CnB
	 WAqFxHQAdJLdsOyPuGaMxThLmEcqs6sStSOsXVoAO/PoA5Y6/FDlWrIseoqoML1345
	 PQahLSOTDmF4SNtYefj0XStKXLARQSjOeeId49LfznG6twbe3GtOkqPczQkS7xjJPy
	 eiMjr8q184mLkLmWp3Uw7nvTO+9aorvjoE3FkuKdjQjAnjINHX9mjR65LO4KAw2tQ5
	 A0lZTm5K4A3cI11wC6Tv/gypAumGHvkdIx3Ka3ae7o/B2HR2vro1EO23igB8TkMdRf
	 OEw7+RoT2dL8w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 15:22:59 +0200
Subject: [PATCH net-next v2 1/3] tools: ynl: rst: display attribute-set doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-ynl-attr-doc-rst-v2-1-c44d36a99992@kernel.org>
References: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
In-Reply-To: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
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
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOyO3qZTaVU/u5e92uuxO3lbZrF+kv3dn/RXX1JD9bL
 zvRs2cjO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayOo/hv6sli3aQ7GrlWWmy
 lWv4+mflGypHfOb7fPSzmFSYnOi0Kwz/I9ojr55KUhT+cjVYZGbuzGNpNasyTCz/LpI/UBFvoSf
 ECAA=
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



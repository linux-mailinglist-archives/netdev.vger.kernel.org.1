Return-Path: <netdev+bounces-199022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F8ADEAAC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C356189E2E8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A22DF3D1;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P91TIwux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C972BEC28;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247211; cv=none; b=kkhK4sjKnPM546baCQzWSrbNxS1u/buw4QPaYRJKLoD3vLPAlKGMVyIjT8f97NgpZydebBZkixL1vfKt5UOFkNRKKvQ77USATSG2k1LqiF9lWPRLtnaDIiUMbaHeQKEBE9v0DKKzkROhbVBVgZmrgMPixpKX1H/yoyZcq5W9nEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247211; c=relaxed/simple;
	bh=MZJWqI3Ttw/muYCtmcZ8ZV0+firnnb8VF0+QvKwQ1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uioe4DoH9e3xAfV5CgbK02n93656xl5gFCzOhq5bO3imM5Ea5TiMu1jWl3titRd3+XXMOW7U60x2xBrcvoSzOsB7qIa75rF+AWxooQJ3waWoI6iNm9OrNLtTuYmbaQCSvLFwsoWmF0Qrr0Tgw/lTs6E8hmCclr2gArCUOljMcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P91TIwux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59226C4CEE7;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=MZJWqI3Ttw/muYCtmcZ8ZV0+firnnb8VF0+QvKwQ1QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P91TIwuxhS2K9nDmQzM6kFxsLu9ADImckCvp9pDPV1AUX+4/xgi1rrQf5gmEhSjEm
	 lQgkonVoIjkS60GRyPswnAJHSYa4fJguEgACI87M6Z8FhnoYzYYXugIrq7JDFsAicd
	 wzNZIzZeueNuvcoZJRu2ncRFAOJVzu/M5i5kXEqpOvXi5FNg9w9HdLw/XxwynsplNk
	 xXN2QOWBiqrcALkNK9qDPwFa6l+WUYeixXCM1LztaGoNslJFBxGmalCfGAWruUhLdW
	 Q4LjPlImNUA7FLRFygbdYWMGGJbnSiuZkDn08F9R1anDFdbdBCW8dSiwuOQ+K7Fdnc
	 Kl1CAAppMiDdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UR-26te;
	Wed, 18 Jun 2025 13:46:49 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 03/15] docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
Date: Wed, 18 Jun 2025 13:46:30 +0200
Message-ID: <205e2b0baddabf47ab23ed08fbddd3fdc0cdcc58.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, rt documents are referred with:

Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt-link<../../networking/netlink_spec/rt-link>`
Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`

Having :doc: references with relative paths doesn't always work,
as it may have troubles when O= is used. Also that's hard to
maintain, and may break if we change the way rst files are
generated from yaml. Better to use instead a reference for
the netlink family.

So, replace them by Sphinx cross-reference tag that are
created by ynl_gen_rst.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/netlink/netlink-raw.rst | 6 +++---
 tools/net/ynl/pyynl/ynl_gen_rst.py                  | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 31fc91020eb3..aae296c170c5 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -62,8 +62,8 @@ Sub-messages
 ------------
 
 Several raw netlink families such as
-:doc:`rt-link<../../networking/netlink_spec/rt-link>` and
-:doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
+:ref:`rt-link<netlink-rt-link>` and
+:ref:`tc<netlink-tc>` use attribute nesting as an
 abstraction to carry module specific information.
 
 Conceptually it looks as follows::
@@ -162,7 +162,7 @@ then this is an error.
 Nested struct definitions
 -------------------------
 
-Many raw netlink families such as :doc:`tc<../../networking/netlink_spec/tc>`
+Many raw netlink families such as :ref:`tc<netlink-tc>`
 make use of nested struct definitions. The ``netlink-raw`` schema makes it
 possible to embed a struct within a struct definition using the ``struct``
 property. For example, the following struct definition embeds the
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 0cb6348e28d3..7bfb8ceeeefc 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -314,10 +314,11 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     # Main header
 
-    lines.append(rst_header())
-
     family = obj['name']
 
+    lines.append(rst_header())
+    lines.append(rst_label("netlink-" + family))
+
     title = f"Family ``{family}`` netlink specification"
     lines.append(rst_title(title))
     lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
-- 
2.49.0



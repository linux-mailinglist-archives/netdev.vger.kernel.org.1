Return-Path: <netdev+bounces-205476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CAAFEE4E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD2645C5F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7EF2E9739;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5mxQYhJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E88F40;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076749; cv=none; b=K6i4zIBYT3+Uavqe9Vh1SbF1WJoWOL4X4lqhhlPZJEQukNWXszhJl+XkKFO+TRxqkayy27PsIfx73v2n31qoon5k6XovONGKh1X8pPuFJxbftbsL4gqgZUavMfseZqz6pfMq5SPNtTkrnj/RYngmdxCCYtBMBibfGaEwVIXb81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076749; c=relaxed/simple;
	bh=W4oDpda6kbCRnn0ODm8ONN7mKwlVwM/eB17fbg3mJL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy//IaFxB79lAwxU9o9TO8N0Aer9W/DbSew/Ytk1RX7CT2Yh7QvL97hhP+VFtJ5T9tLysjBUEABpWE7wLSCGvnDFTxpGb1Ruj3EJDkKYDLrcrPVaQuFP6KY4vYEec21J66psQ1O9hIFWkc86i5V6T7dAJLoRcVneaG2/RVN58is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5mxQYhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA21FC4CEF6;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076748;
	bh=W4oDpda6kbCRnn0ODm8ONN7mKwlVwM/eB17fbg3mJL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5mxQYhJQ3plU3wn+9g6HVoJfWZcRPJBnbUJzowJTsPBApSdXe7iGzpvPCAzzLjZg
	 bthsN1+Q5vZ6h3CPV7xFff5AP55LB0ZL6v1ZcNs4gaJAxZdqAYVdEwSyntaPtuhz2b
	 2W7ifLwtaXrL5wdf9KTyHot0EKpUfn0ylg88B/QwQPHjRNCH+m3ooUgf3V6JYoZhwN
	 iGtsD3VQHxoZtdO9sjWcEWHwvmaZ2Q0dluiBaLosq1F/RTOstxtr9CXpj/vhPm5LTN
	 P4WFvU+y0r/+1DHiM0E0sutUToD6nG3YrVED6uXiG+tg+safuyyOkBPMLUI2gMRKVo
	 lK+Oswv5c9bYQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000Igp-0lkF;
	Wed, 09 Jul 2025 17:59:03 +0200
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
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 01/13] docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
Date: Wed,  9 Jul 2025 17:58:45 +0200
Message-ID: <9d6089d93e9cd25e8773d7966f6e60ed016d2ccd.1752076293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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



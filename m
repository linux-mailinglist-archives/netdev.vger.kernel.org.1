Return-Path: <netdev+bounces-51997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC57FCDBD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3891C20C2B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04163C9;
	Wed, 29 Nov 2023 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8VSEY6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84B63AE;
	Wed, 29 Nov 2023 04:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8936C433C7;
	Wed, 29 Nov 2023 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701231274;
	bh=XD/RBlDsVQGj3kZTyVUAALtmbZJmgeU+U/q5t8pz5/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=T8VSEY6Zc6TxGO7Z6r+IiwoOeJTrPWb2kpquzFRvjhzq7Igx4vaa5upBe2cr+LJrl
	 pEzTLXkZgsOwYJKdpvl+/g4nvJvC+Jq+xUk/ee+iauahdSnU0wi7Fhwx1fpwFUbMoJ
	 t1QZmD7t6mANaNCDOVq5Suu6N7w7MfHejtEIvkDvxFL/q5f15+KHh9XlKKZVUuki2e
	 C4G7vNhyMkMMs/lkZV6q1up2tWm1K2959Qps1DHJTlxdMaROWO8n3xWMPk1H5zdBCN
	 8opMmsN6WwrfzmamNILAaQJZ8sgN83bYMriOjQbqx4ES0z8fo8ZSlZn5mYe7tyg6/b
	 6bX93/eL6Gcjg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2] docs: netlink: link to family documentations from spec info
Date: Tue, 28 Nov 2023 20:14:27 -0800
Message-ID: <20231129041427.2763074-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To increase the chances of people finding the rendered docs
add a link to specs.rst and index.rst.

Add a label in the generated index.rst and while at it adjust
the title a little bit.

Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add type to the arg
 - link from index
v1: https://lore.kernel.org/all/20231127205642.2293153-1-kuba@kernel.org/

CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org
---
 Documentation/userspace-api/netlink/index.rst | 4 +++-
 Documentation/userspace-api/netlink/specs.rst | 2 +-
 tools/net/ynl/ynl-gen-rst.py                  | 8 +++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/netlink/index.rst b/Documentation/userspace-api/netlink/index.rst
index 62725dafbbdb..c1b6765cc963 100644
--- a/Documentation/userspace-api/netlink/index.rst
+++ b/Documentation/userspace-api/netlink/index.rst
@@ -16,4 +16,6 @@ Netlink documentation for users.
    genetlink-legacy
    netlink-raw
 
-See also :ref:`Documentation/core-api/netlink.rst <kernel_netlink>`.
+See also:
+ - :ref:`Documentation/core-api/netlink.rst <kernel_netlink>`
+ - :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index c1b951649113..1b50d97d8d7c 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -15,7 +15,7 @@ kernel headers directly.
 Internally kernel uses the YAML specs to generate:
 
  - the C uAPI header
- - documentation of the protocol as a ReST file
+ - documentation of the protocol as a ReST file - see :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
  - policy tables for input attribute validation
  - operation tables
 
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index b6292109e236..8c62e040df5d 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -122,6 +122,11 @@ SPACE_PER_LEVEL = 4
     return "\n".join(lines)
 
 
+def rst_label(title: str) -> str:
+    """Return a formatted label"""
+    return f".. _{title}:\n\n"
+
+
 # Parsers
 # =======
 
@@ -349,7 +354,8 @@ SPACE_PER_LEVEL = 4
     lines = []
 
     lines.append(rst_header())
-    lines.append(rst_title("Netlink Specification"))
+    lines.append(rst_label("specs"))
+    lines.append(rst_title("Netlink Family Specifications"))
     lines.append(rst_toctree(1))
 
     index_dir = os.path.dirname(output)
-- 
2.43.0



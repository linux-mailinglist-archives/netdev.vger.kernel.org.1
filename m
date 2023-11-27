Return-Path: <netdev+bounces-51467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA837FAC18
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED0F1C209E2
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8403456F;
	Mon, 27 Nov 2023 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONp5tQ+1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB241A286;
	Mon, 27 Nov 2023 20:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF93C433C8;
	Mon, 27 Nov 2023 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701118604;
	bh=lAsbEbppacCJFKnkajKXtFhGpV+NdV4a4bQb09RY8Aw=;
	h=From:To:Cc:Subject:Date:From;
	b=ONp5tQ+1r4zJ1gt/iClLw0JzXs1DJH3EI1HopPJZYAPlXZKqmsUSaCQAU38NmOsNL
	 WIY69MhtaS1Mg5YsO4ju7vNFfoV+EpiBfz1qZZkj27su/8OVFwCry981GVREaEHHkI
	 wbHChghp9P/iYM0zxZRqHEo2qMNZS6S0uEbo97M61hkOGGWqgF7TpGQgX6yRZ7n0eV
	 lxLtvoQS8bFYErLVIbAkBWREWNBw07ObuOBvbA+zMosA6EI4BQvIpCpXnexWxr5a7I
	 gPvtdmDEgbMuIhD8sD5clM+XxoJ1PLRJlFnk4LthvMnPItg5gN5Ci4kxV4x2xs/wet
	 icfmMlD3Q23pg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: netlink: link to family documentations from spec info
Date: Mon, 27 Nov 2023 12:56:42 -0800
Message-ID: <20231127205642.2293153-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To increase the chances of people finding the rendered docs
add a link to specs.rst. Add a label in the generated index.rst
and while at it adjust the title a little bit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: leitao@debian.org
CC: linux-doc@vger.kernel.org
---
 Documentation/userspace-api/netlink/specs.rst | 2 +-
 tools/net/ynl/ynl-gen-rst.py                  | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
index b6292109e236..2c0b80071bcd 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -122,6 +122,11 @@ SPACE_PER_LEVEL = 4
     return "\n".join(lines)
 
 
+def rst_label(title) -> str:
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
2.42.0



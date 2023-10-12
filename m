Return-Path: <netdev+bounces-40389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8767C71C1
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7861C20D62
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC8286A4;
	Thu, 12 Oct 2023 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiifXfOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86491D2EE;
	Thu, 12 Oct 2023 15:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB234C433C8;
	Thu, 12 Oct 2023 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697125404;
	bh=8K74BfeHSQ5itwA3zaVHf1nQ8zccbd6+NF/GgtqDtc8=;
	h=From:To:Cc:Subject:Date:From;
	b=SiifXfOMm+9w6TcdzdytFAG6In5L0z0gje+LPoU83GHrHJ5ZQNEPPSxUVZFJPP0Vm
	 FH2pIi7AJNfXgJmG0Y9CsJ2kPIr7QeEa/2OalBnB7OSQ6zfB+Mb7jJ64R3zDvNwsdZ
	 UpNKNBhlbLTwoNkAHMEX/2ZfzyV7B3JjiGl4ny2CEn7t6lKWEtwbbNuKbn4w05eIpU
	 IAcNlgM5b1Bwlkz+x0i+aBdQa8K0gp9VCBuwnsHhqWN0eULM4a/a0joeQsXUW1juT1
	 pNwOW3MH5wUeCWJD8a9hL6iNlAL6qK/OUG6Jwg/E8o/EyIEKW2zcvB0iiE+YCjYbwO
	 kBTVrBy4R3iWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: netlink: clean up after deprecating version
Date: Thu, 12 Oct 2023 08:43:15 -0700
Message-ID: <20231012154315.587383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jiri moved version to legacy specs in commit 0f07415ebb78 ("netlink:
specs: don't allow version to be specified for genetlink").
Update the documentation.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../userspace-api/netlink/genetlink-legacy.rst     | 14 ++++++++++++++
 Documentation/userspace-api/netlink/specs.rst      |  5 -----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 40b82ad5d54a..11710086aba0 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -11,6 +11,20 @@ the ``genetlink-legacy`` protocol level.
 Specification
 =============
 
+Gobals
+------
+
+Attributes listed directly at the root level of the spec file.
+
+version
+~~~~~~~
+
+Generic Netlink family version, default is 1.
+
+``version`` has historically been used to introduce family changes
+which may break backwards compatibility. Since breaking changes
+are generally not allowed ``version`` is very rarely used.
+
 Attribute type nests
 --------------------
 
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index cc4e2430997e..40dd7442d2c3 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -86,11 +86,6 @@ name
 Name of the family. Name identifies the family in a unique way, since
 the Family IDs are allocated dynamically.
 
-version
-~~~~~~~
-
-Generic Netlink family version, default is 1.
-
 protocol
 ~~~~~~~~
 
-- 
2.41.0



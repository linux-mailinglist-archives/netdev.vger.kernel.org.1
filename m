Return-Path: <netdev+bounces-41578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5C7CB590
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822AF281507
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D6381BD;
	Mon, 16 Oct 2023 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgpdJjU0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3237C83;
	Mon, 16 Oct 2023 21:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF20C433C8;
	Mon, 16 Oct 2023 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697492744;
	bh=urYeCNriV0kxeshU5Rna6R1RxVeHNVc0shzEPlTWcXs=;
	h=From:To:Cc:Subject:Date:From;
	b=QgpdJjU0XWdzBdhLG07ys33H8Qw8Ytzfr+oRrjxHcr4A9LshNYoVlPLC4QGfOCDRf
	 cVR39GPluQOUMdjrYhbaa4lhC5UJESydkJYNWZuB1w6AkAeeGh78EPJqT6et5NY9Ym
	 zpSWRwkPnGAd44J+SpnM4dEBiJ1bE4T7XWZWJ8W0Ptx6uhU+kU0NcExJZ2Lno7O4rh
	 j7BedJqbzeBK+SzvTE/Lq9nn71WkVm5gTAJcXhFUstCKrSgib5SwifWdgo83DvtYpD
	 i+8T7mF9cfMrC4PcLciAnJewEDTMyq3lb+5VtEqCGRIsHFYSclsf/6dTjclhbXTInh
	 i17kTR9+0WsEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] docs: netlink: clean up after deprecating version
Date: Mon, 16 Oct 2023 14:45:40 -0700
Message-ID: <20231016214540.1822392-1-kuba@kernel.org>
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
v2:
 - s/Gobals/Globals/
 - breaking changes are -> compatibility breaking changes are
   I think it's plural but the omission of "compatibility" made it confusing
 - not changing the wording to "should never be used", I prefer existing
v1: https://lore.kernel.org/all/20231012154315.587383-1-kuba@kernel.org/
---
 .../userspace-api/netlink/genetlink-legacy.rst     | 14 ++++++++++++++
 Documentation/userspace-api/netlink/specs.rst      |  5 -----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 40b82ad5d54a..0b3febd57ff5 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -11,6 +11,20 @@ the ``genetlink-legacy`` protocol level.
 Specification
 =============
 
+Globals
+-------
+
+Attributes listed directly at the root level of the spec file.
+
+version
+~~~~~~~
+
+Generic Netlink family version, default is 1.
+
+``version`` has historically been used to introduce family changes
+which may break backwards compatibility. Since compatibility breaking changes
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



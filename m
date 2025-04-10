Return-Path: <netdev+bounces-180988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69BAA835E6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF93B2F0E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD533193077;
	Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlJucMLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85611494DB
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249631; cv=none; b=eHYNcab4HyRWZ3oMQlKTQbkiLpd8hl6oPwpPFqvRrxtav3ebnY5FHVDh4MReVSPjI5ypV0RQB0ht/l4lSAS7GqC+VZK5LDa4NntSoZ66K7QUPN7GF/pYv90zjGcTkXeAVvjHbP+4UxrG4sUo0C4Fy9cAU9Z0dlq97k5bHaNJqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249631; c=relaxed/simple;
	bh=+HD3W9jEdp9+lfCLfeo8WLJiA7wEXd8+3tAfzLedAh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meF9VIeJ+G/3aLkXDOS2VdE88cB9y7rk9L5qWhP3QWJLbIS6hfSEPp61C2hwICSxxfRC6CMrTp0xrxS/9e6DuuJg9yGtdavqjfgZYtTJcrx8Q3A4LRrYpXiWh27giKGzxCmiuwuBSRZaEApLbHRbKmGcD4dxz0vnB3NGDgPuf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlJucMLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5BCC4CEEB;
	Thu, 10 Apr 2025 01:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249631;
	bh=+HD3W9jEdp9+lfCLfeo8WLJiA7wEXd8+3tAfzLedAh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlJucMLO8xKB9rsQrz5WYhMcVMFoSR4zIZX0kbLUoy+p5v3LwvdaAiQkmmy9aLNUi
	 08NcdvlWZM27NndpczLEu7uqtufHkK4AUSrbVJQx6B/QhThiEtAowdc64ajZr+E8he
	 0fmJgEMuPHf3Cv4jYUTIt79IkhUdd5Rr9nqVmqeUWKdxnwQiBIxjVMXZ2FgszI9HFQ
	 0K1OjtOaDU0Nj/5qSOyKnBj2+gLInV/7BH3v0vK4Z6paLPUXr3D+o5AybHh4HQWCy3
	 26cjpM4A2WTgnDZYUDawa5AU1BayWcQmo5brZdZEGDp8BaPCKPdDDICWvgkK1B06ZX
	 +67ZIRUsla6gQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/13] netlink: specs: rename rtnetlink specs in accordance with family name
Date: Wed,  9 Apr 2025 18:46:46 -0700
Message-ID: <20250410014658.782120-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtnetlink family names are set to rt-$name within the YAML
but the files are called rt_$name. C codegen assumes that the
generated file name will match the family. The use of dashes
is in line with our general expectation that name properties
in the spec use dashes not underscores (even tho, as Donald
points out most genl families use underscores in the name).

We have 3 un-ideal options to choose from:

 - accept the slight inconsistency with old families using _, or
 - accept the slight annoyance with all languages having to do s/-/_/
   when looking up family ID, or
 - accept the inconsistency with all name properties in new YAML spec
   being separated with - and just the family name always using _.

Pick option 1 and rename the rtnl spec files.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: extend commit msg
---
 Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml}   | 0
 Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml}   | 0
 Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} | 0
 Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} | 0
 Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml}   | 0
 Documentation/userspace-api/netlink/netlink-raw.rst          | 2 +-
 tools/testing/selftests/net/lib/py/ynl.py                    | 4 ++--
 7 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml} (100%)
 rename Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml} (100%)
 rename Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} (100%)
 rename Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} (100%)
 rename Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml} (100%)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
similarity index 100%
rename from Documentation/netlink/specs/rt_addr.yaml
rename to Documentation/netlink/specs/rt-addr.yaml
diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt-link.yaml
similarity index 100%
rename from Documentation/netlink/specs/rt_link.yaml
rename to Documentation/netlink/specs/rt-link.yaml
diff --git a/Documentation/netlink/specs/rt_neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
similarity index 100%
rename from Documentation/netlink/specs/rt_neigh.yaml
rename to Documentation/netlink/specs/rt-neigh.yaml
diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt-route.yaml
similarity index 100%
rename from Documentation/netlink/specs/rt_route.yaml
rename to Documentation/netlink/specs/rt-route.yaml
diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
similarity index 100%
rename from Documentation/netlink/specs/rt_rule.yaml
rename to Documentation/netlink/specs/rt-rule.yaml
diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 1990eea772d0..31fc91020eb3 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -62,7 +62,7 @@ Sub-messages
 ------------
 
 Several raw netlink families such as
-:doc:`rt_link<../../networking/netlink_spec/rt_link>` and
+:doc:`rt-link<../../networking/netlink_spec/rt-link>` and
 :doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
 abstraction to carry module specific information.
 
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 8986c584cb37..6329ae805abf 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -39,12 +39,12 @@ from .ksft import ksft_pr, ktap_result
 
 class RtnlFamily(YnlFamily):
     def __init__(self, recv_size=0):
-        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
+        super().__init__((SPEC_PATH / Path('rt-link.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
 
 class RtnlAddrFamily(YnlFamily):
     def __init__(self, recv_size=0):
-        super().__init__((SPEC_PATH / Path('rt_addr.yaml')).as_posix(),
+        super().__init__((SPEC_PATH / Path('rt-addr.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
 
 class NetdevFamily(YnlFamily):
-- 
2.49.0



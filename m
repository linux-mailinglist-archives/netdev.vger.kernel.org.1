Return-Path: <netdev+bounces-180522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D89A81992
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25AE4C401C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CA259C;
	Wed,  9 Apr 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCjC/3so"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420D23DE
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157062; cv=none; b=pwjUR93rV/+GuMUyl0lZLIft1g07pM/KkLoGIVK7uGSI1S0FkktFUBVh0O9crNwLxmm7iXj6FAdkIWZlHUPXzMCsRt2V12KTNWZGCE8azViEYTmDXpyU4DMjZbGLQeDWVqUFHjwtVD5t8Obx5Q/v203k+/XIHp9CZMnfX04l8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157062; c=relaxed/simple;
	bh=SHf5HfHiuPyOj5xmsiAga8tiM75vuzQrRfAF0E9/dqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8LM37szr3zskMdw021BOjvnrsp+zIPTadi7k195c8GFx9hRIjcEusM/89w7dLWYhXCncPxt3p1cB3lOxz0KLgP3s3vN5ZP9rgL4+Hnk9LDzg9mF6CKBfLDlLgrG27O+LEwH21t4/ZQwbrfM+3ZDInkYHox+fRhN9jtJ1T9sQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCjC/3so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D9C4CEEA;
	Wed,  9 Apr 2025 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157062;
	bh=SHf5HfHiuPyOj5xmsiAga8tiM75vuzQrRfAF0E9/dqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCjC/3somM471mgESe0iLTPntQANRIdIma32OMMtcm9y/h1wE6KuGBHz4xRZFatPz
	 aARY1qCAAykh4GO98wdjED78+xFW9QreaYV1hffWKISOp+fQCOXyx/pU9V7glCunTP
	 OgPqictd1AAr7FHt24iedUY7EVhtqRBL9xqSBUFbRS2l9p4xfo3jr8trUMUX2eSB19
	 Q/yw8Vfhl5I1jAINQjo15J2jwIrFfVUfRy90rqZXyGUc8quDKLer+JStU3lhN4EUlg
	 7C+e38tsZgE6ka+Mf+DX8Ra2BDTOw9YjroihMF1Ch5ypHP58SPcx7O1YncwgakWPNo
	 FenNOkawGzV6A==
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
Subject: [PATCH net-next 01/13] netlink: specs: rename rtnetlink specs in accordance with family name
Date: Tue,  8 Apr 2025 17:03:48 -0700
Message-ID: <20250409000400.492371-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtnetlink family names are set to rt-$name within the YAML
but the files are called rt_$name. C codegen assumes that the
generated file name will match the family. We could replace
dashes with underscores in the codegen but making sure the
family name matches the spec name may be more generally useful.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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



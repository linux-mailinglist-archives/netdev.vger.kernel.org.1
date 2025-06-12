Return-Path: <netdev+bounces-196902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38767AD6DE5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B84188478E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87150239E62;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY6kr6e7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A923027C;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=OoWvPE8NXu3xpVrxUHhpSMNbNcpbpTufoHUVpr15PVCuO5TG4K+PgWFb8k9YPkyYoYbaNkoJXXtmMBHPa/T0lU3VwUIGDu0+ddlXC1WgZNCfAqsuGlfdu8fz8wFWskTbCKzbSJ1tFw2v98zwldm+mm2yUaLDCl/E3uTVA1mrEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+YAhpl5fYB6RgeAJtYAq14mrmo0CYRYnIhTrS2k38lY+kBhZKHZag/H+O/uKqjMbU/TM5bRCmFeU+LxU6sECLrVmkmtUI6jFvYeKKT5J9DJFitZSjiFcQ5Hf5NVJHIuZ/E+OpIXTI54RGsvI7otth4tE8J9SBgPO2lBQWf7W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY6kr6e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F5C4CEF2;
	Thu, 12 Jun 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iY6kr6e7t9X0fY6cA0BO2hl97xvLAU1X+FqXUuf/Zj/gPasJ4px/BybClaBCc+UtN
	 8LKhk2B+99BHQf9MY5Ndz/yUoGCl1RsCx4TNV0T+PBhuUmbiZJDIDkifZMfn6EOwt/
	 RfSJPSUv2bpNOTE99rryohJ9b+4uGKptX9qdjiHN41VVCMVa2ejIOseVOoSOato/ab
	 zP1bE+donimiTaqISL/WbUWnyeOuhdOMZAQ4h4Id2ZlkCbsfxfuZPlLs5ZyBaaJ8WK
	 uJakU2J0oAeeXNGUBexanpFzk7yKZqV0pcLA8maefhCtTj+zXXHXv3P5Hxe4W/nv6x
	 /ibqos4qx8Alw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEL-00000004yv6-49fB;
	Thu, 12 Jun 2025 12:32:21 +0200
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
Subject: [PATCH v2 01/12] tools: ynl_gen_rst.py: create a top-level reference
Date: Thu, 12 Jun 2025 12:31:53 +0200
Message-ID: <ed66166bec8051df75465f9821671b21011fbda4.1749723671.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
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

that's hard to maintain, and may break if we change the way
rst files are generated from yaml. Better to use instead a
reference for the netlink family.

So, add a netlink-<foo> reference to all generated docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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



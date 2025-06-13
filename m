Return-Path: <netdev+bounces-197448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF915AD8B07
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8484F3BE096
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302A2E7F03;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfXMsNuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46842E2EF9;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=qQxKbW4MyBOudKlD3oOc1Kwqa8h05bo5+CyY3cmSow9rBQFTqEfsCFbZjmxhbAikNufvEZeQrfedqGreGBYWlyorrJuvM1gt084+QEgINBgbiMfEXkHsfC0Op7hd9g/oLDIe8JPgo1viyVsP1q8Fh/JMFvJuWwLNq9pKqZ70frU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnPzVzmbm3euJ0rbPXHZ24EFKWUHdPjQo2d7E6kW9377/+omdZj/nbH/QnqGHZA5lLe1KSPWW3OySMALiMptso6n6F1JdMaZFMkaVuTB+n61OtW89QLGkRMIR1HFfAsoY+qw9AhzbPW2Bd7Vb4mUp95pQ8K3n1qESdG1fi/hF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfXMsNuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F1C4CEEF;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814966;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfXMsNuEfbnCAzjcLttoSxLxlVO4Utcw7Ac2B8yV5lJf3mxdJbqdPKzxIr+jOG0RB
	 +ZFDmvrKGU8ym8piW7ewVWatTcVX8WY4AfQWu2dsuie2twuVhDu6ItNrgJZ7ScroNq
	 QkgDQ2jvioSIUvGR2cMutxrECJcFk9jDJkl4kWIcFgSnjRZJIRJpQyYvdS/vTrO6mi
	 rlI/ZjpjEy4myyxSLWcSvRiwY93wpNPqfJlkgYcNVoNELH/BOAUaEbkJ8cmk8y5ned
	 Telif6QT+3TUoI4cB6/TWJALYq1maV+ODmux12s3a9d76I3YSWq/TFDUeF1LoY8qBn
	 vKHBDsbTD3vQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o0-00000005dEl-26aa;
	Fri, 13 Jun 2025 13:42:44 +0200
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
Subject: [PATCH v3 01/16] tools: ynl_gen_rst.py: create a top-level reference
Date: Fri, 13 Jun 2025 13:42:22 +0200
Message-ID: <ed66166bec8051df75465f9821671b21011fbda4.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
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



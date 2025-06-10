Return-Path: <netdev+bounces-196041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AAAD33F1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C14172A6A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781528B7F8;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwsLZMRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260171A2564;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552385; cv=none; b=WPFox42xc0jgjY+DtE6vGnXv1kimu3Qg60FKDD8xxzFo8sf7vmz9f2iq9s4DsG6HJogpBrXL+k6wmju1d6lWt+l7PG7UNKYE3OgcUhszB/Yf9B+QB2kqOSwIi2FXRorgnWWaDGOmLc1+7VLXmDupNrETUybixyxeSvRbvBqwtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552385; c=relaxed/simple;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+lykUmpq9UiSEUrGMikPiLk6sHJsYxiSyGD8YqGsx2BbQRgpCNI+DLfHKjvEmGvhNbVNmf1KHCbpjtAVC0X6vYYQZCPEeaIVekjefHStD2Ljn5VLCm+cHL1o2DUUKVZjErMJIxKlcElB/L9YubAY3coQFicLlIbRR4k81QA0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwsLZMRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D61C4CEED;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552384;
	bh=8JLj251EiGtS/E11n5n+267zLGC8qyxQhPvEcm7GqEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwsLZMRMGrOKfxc83+DsbyVjsXXIaMTQmxXly3qq612w3OgHSNQ+rW6FqT6NIryTT
	 JGohFd50AnEprkna77PPHqIzZLVFxMlNlJlOmHXNznLJx7hwPx7Dn9El99lPJURmrk
	 wCWQRvVXmfIsPUJ8PeFePt36X8F+NBmgFB38O633c8dCC2wMIBbcnhkVQqi4Vwarzs
	 YHmxLGUQI5gsRMvQ95qTDVoOqOv04PleljZksChmpq4e8ohEvyhiSBstW+FQ8ti+l8
	 lMM3x8UGK7cxcrf8sBUWhftIEH9znV7Gxed/2FXe4CJPcwYSYR0IrkhJRs4jQnGpOM
	 pWtbbiVoQ04Qg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uOwUo-00000003juv-3izT;
	Tue, 10 Jun 2025 12:46:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paul E. McKenney" <mchehab+huawei@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH 1/4] tools: ynl_gen_rst.py: create a top-level reference
Date: Tue, 10 Jun 2025 12:46:04 +0200
Message-ID: <ed66166bec8051df75465f9821671b21011fbda4.1749551140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749551140.git.mchehab+huawei@kernel.org>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
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



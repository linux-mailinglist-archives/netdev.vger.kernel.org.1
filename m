Return-Path: <netdev+bounces-197461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2713AAD8B1B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D869D1E54A2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5542EBDDE;
	Fri, 13 Jun 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCZ5OEll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC412E7F17;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=ATowjSd7MGeaQ6mA7D12tKGv6kPgNkmKbumDIqJdc+4rAKyRMJyJaxORq+ggbLB1KdRZkD5QFuwSoxmz/UVuI943aOoSvYbu4yw5dXlbRH85XFSjAR+pQiwI15juoghKdgAnKG7fipaasvdBWDRo6tKh7vKJ1Z8xjRLUDQXzYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=jazvmyYFMnGYOxxVZMEBOjTd9mMz+TrushWEPpOXIDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4F31+cNvfKmlw62gFu34Rlu+wkYxz5vJIFlBDZx+6FnnkUHdIYmltDqUa38SUT5m/nBu3Yd+0Z6hikJS8hCquruXJh7oAvfg9saK5do4I6e41TPyFnmQgezVGFPUWEzVvmqTc0B0hjpRFyYGOpz9CIJ+v8iAyu9HThtB/GuygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCZ5OEll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BEFC4CEF0;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814967;
	bh=jazvmyYFMnGYOxxVZMEBOjTd9mMz+TrushWEPpOXIDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCZ5OEll50G95vHVAMlJ4oAHPBCfNFX3WUcZFFup++oyru4a1NoZa4Sq8j+h/KvWG
	 YH2FBzmyxbYLNcA8LxeeCh52QyoUbXXjnfi7rbg+ur7NCwctf2WkRzCmzDeS63mF+E
	 OGbcHd0lKDPspvm7fW+FUxEPHz4NgkjD4VDEXDDCRVI1uN+8YUvIHE9DQONsF80N5p
	 XOS2jR0pCwppCQAoR4A0q18cd1hr77zSnQ8vRH/YoxTsiqeVHI+ea9ROobCLPk8BiV
	 lytCcoR9GaSCr0SDEu7nEBuqodSoQE8te0qJSL22O0U+7TepL1MCf10RNEAeu5gs0d
	 3Ru45k/lEE3mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFj-1lXM;
	Fri, 13 Jun 2025 13:42:45 +0200
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v3 16/16] docs: Makefile: disable check rules on make cleandocs
Date: Fri, 13 Jun 2025 13:42:37 +0200
Message-ID: <18a6c2c8a9f331b3d1abc6e943d0e5aa2bc18655.1749812870.git.mchehab+huawei@kernel.org>
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

It doesn't make sense to check for missing ABI and documents
when cleaning the tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9185680b1e86..820f07e0afe6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -5,6 +5,7 @@
 # for cleaning
 subdir- := devicetree/bindings
 
+ifneq ($(MAKECMDGOALS),cleandocs)
 # Check for broken documentation file references
 ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
 $(shell $(srctree)/scripts/documentation-file-ref-check --warn)
@@ -14,6 +15,7 @@ endif
 ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
 $(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI validate)
 endif
+endif
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
-- 
2.49.0



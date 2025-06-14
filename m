Return-Path: <netdev+bounces-197745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2608FAD9B94
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CBF189C0D4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CEA2C08B7;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ron2pf0w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BB298CD2;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=OC6hx+Bm7OM6IqYkNxWKiuUgL3GMPI4vNe1q7139DxitXHKxzZqjH5+b/hBKmXr7HiV6UhRx6UO449l/IHZTntK/drjdtkX+7AWbK86orHzdljQBHqZaeq9Dz+gCvrc+5nNPDColTOTORnDen0D7YEgex2wmYHg34lSOKpqaDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=jazvmyYFMnGYOxxVZMEBOjTd9mMz+TrushWEPpOXIDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtPq5SeT+pWYBhOM88RCVbSfv5/leHdtcu3wemQ6EJdt8PIFq2FpM7jpHq0dqNW5PvDwRmlEUqsDhuRRpWwRnoZ1qS5xxdv6xmfna8m0IZpyu8IIIn08U2r9mGqzriFY1c3/77UckOfr97v4wijXpMG+42CuyWS96x2HnFMeQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ron2pf0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA2C113D0;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=jazvmyYFMnGYOxxVZMEBOjTd9mMz+TrushWEPpOXIDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ron2pf0wEzLlgOKo4jmBETCTLD/zzRde1B1blhmA9544cAqKpYlKO6zjy7IQ87L4m
	 oIxcgKs0txHocJYfjic3d74DjoToEIPJOdhhLZkvXszxongHQHizoTbzDf2i3uVCWd
	 9D62wpxysFGCkZuNUc3fXwuukYKboCinO5aHe5WrEaYeJu8R95fv+bivZxEjNNjjTp
	 tmKs9Y8a6X4Fnn25ln/4pJY4Mqaj/keRzemu5qDOsx/6uImiy1hSQmnZSpm7wCgv6E
	 D5b5V+mz7N4d4ZicqPXqaq2n9U0tNa8tE9p065wR/WePMaMdCt0SiLHBeV39LxPvjJ
	 tSbFGd0AIJsww==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064bT-2hKl;
	Sat, 14 Jun 2025 10:56:16 +0200
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
Subject: [PATCH v4 13/14] docs: Makefile: disable check rules on make cleandocs
Date: Sat, 14 Jun 2025 10:56:07 +0200
Message-ID: <bafc364ae9119b4536460903cfd3a3afc33a4151.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
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



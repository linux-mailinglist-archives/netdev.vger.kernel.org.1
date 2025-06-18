Return-Path: <netdev+bounces-199026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BFADEABF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D450217E514
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686512E8888;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKo5HGIf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080B2DBF4C;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=WIMbHWtkYz2XdfS7se/m6u9Vdn+XeqBl2X32SrBZPSlnG8vrhkPYNCan4iWucW8ptqLmC97VpDur9g7gmI7sPZYGINAbmDc1od9kxKXzSQNHwE03Lw1bdOcrJho2BIkLkaL5Kx66zPDhAdZ3SmEpVNY23De+696CowMFQvm5buE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=9sv3o8O8M0IyOR5wJkoSEusaPecRlQcEL5SoMo0iJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw+jiwaF/Tfi2zyBRc3u6nRZXJEWzckD/zp5kF4ijgiMh64UdEMF/YzE/pkSquyU1OJkFjddPyh4j1Ss4NQK8unuptCK9x65I/kycFdsqH0j7Q1zP6ioIrSy2i+z0WxTb7vkeW227SygplSwnNGeelcRuOG5qbVR0rk27Ggfia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKo5HGIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B0C4AF0B;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=9sv3o8O8M0IyOR5wJkoSEusaPecRlQcEL5SoMo0iJ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKo5HGIfommgZx8yi6Zi+eJ1SoQ2VQ+0T5muWeAbjZTUtGMXuu8g73Mc1KWSLPPCT
	 RZSfdvSj+AetUWCOucjQtZDb/DrDX8D2GrPThxG0Nkjuvl7BM+ttN8nQyQfAGOrZpZ
	 ZIk44uUGn5Ex2o6s1xNoHE2y0rYR8Bli8XYuPV/6XAnCbqZkoXc5ugdr2sRn4+05jp
	 ob7sqMs3tDQDF8/X/sP7TUHE3diI7O/NbQCLZXz5ilJ+UejabNBc8zptGaFqjqJ6mK
	 WCxOmyMFcUYh6vZrAkTiuyJ9gpmwhVe70bwe0v2CwmsXJHbyIy2QXlkevHf+jnaH2P
	 R6+Uh2uam2B7w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UN-1zMZ;
	Wed, 18 Jun 2025 13:46:49 +0200
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
Subject: [PATCH v6 02/15] docs: Makefile: disable check rules on make cleandocs
Date: Wed, 18 Jun 2025 13:46:29 +0200
Message-ID: <e4ad47a238cffc8659786bcfdba4126f08522035.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d30d66ddf1ad..b98477df5ddf 100644
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



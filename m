Return-Path: <netdev+bounces-199332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4DADFDF4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27413AC54C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261824888C;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbnZLsJO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8523C513;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=bdayaJ/VlIUU0EW07sUniqC7fqqSqBSIHTEqMq3j1hcdLeh+e+KfHUAHTB0tfgu4Mu78P1gswnIMBoXQwZkVT8aBm6sp2h2hSvvRNxvgxG3pksVbFz/SzkshIs0P2yr7JEoJssCuLqGvgUyPT1SLOPgOy1fMjSY/1AMP2AYsaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=9sv3o8O8M0IyOR5wJkoSEusaPecRlQcEL5SoMo0iJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pabstBfxszBw9PNQY+2MByzu/1bIHatVyYM8TjBc3nXbBEV+1tmfG0lwRATi0tTHyk6rUy8wYBWdoa6qiT+E550fOwH8MR5yJwJ7kx8z1A4mn7wILO5nxVmAq1kkHc8rGxAGXkX0pkPbPovRMKUTK0VAt4Fc8hnOEV/Qi18fpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbnZLsJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD4C4CEED;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315820;
	bh=9sv3o8O8M0IyOR5wJkoSEusaPecRlQcEL5SoMo0iJ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbnZLsJOfX17tLAz7qbnLMk773IGNbYnRDyQpKMIaYSSYXx+7QT50vdx1PdbrnYDl
	 cfgRFpMTse25+SNe+5bQP+SFsJ9Das/C6MDrUWobo5twvuIMWpUu0S1gBNQJn8AN7I
	 ZQpEVrX7OolctvrgJ9lZ73Klhq8RqmSbu/nscz6Qn5Z1JSL0w9LxYcov8/44A4yK7r
	 qkdNOHWZjuUbT9fHqM8NyV6MX2PPIghFatRSQp45C4u8xanw0Zn+yR3p3cIGjn3xbh
	 5X/29p5GSdfq+ClQ+7+IhLxnaDcH2tkMEMLKPHqBz+G7lnfmP7QZyKcqKH+DbWlrM2
	 NLaTMQv3RmkeQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96I-00000003dGe-3atf;
	Thu, 19 Jun 2025 08:50:18 +0200
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
Subject: [PATCH v7 02/17] docs: Makefile: disable check rules on make cleandocs
Date: Thu, 19 Jun 2025 08:48:55 +0200
Message-ID: <e4ad47a238cffc8659786bcfdba4126f08522035.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
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



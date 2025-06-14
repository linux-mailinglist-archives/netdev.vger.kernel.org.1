Return-Path: <netdev+bounces-197746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C27AD9B96
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D04189C008
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581752C08B9;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrsOCRsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6E299928;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891379; cv=none; b=U+MXT60eeLqxluGpt/ihoalF7UkjDaC5A31RAcOrSXfS9179uUZGfOeDF4o6I2uKSZlhHIHXvJmMqb7+UwigtEiB/UrCRK/FHxyEv+59XT846PvYukFG3NEypyF74aljSLJI3KCuvABzRnzakXljBGv9bJt9pz/2GLXDBR6hOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891379; c=relaxed/simple;
	bh=00F9KG3FuikbC/77I/aVEWzxRtC/68GGYQsrs3gqu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud7aAwX/IHTstc5MesAawLTPL+Y2LypacaZZsec3evl+Ktn7huiNCSxN1raLryowpq5kVYrz2JcEq6Qmf0Aoeuzhm7jYu5x4Sc9XqWVHgplF2K7VGNG0CDfjcgYFSR1ugv4AX/TgMpyJoRxFaZOcHOsga/5vVxn6pzuKTscVvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrsOCRsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A8BC4CEFE;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=00F9KG3FuikbC/77I/aVEWzxRtC/68GGYQsrs3gqu00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrsOCRsq69wKZqzbM/v4hKRkiF6UJl4qiGVj1ejjEYSbVZjgDJ59mBRM/3knDFwKr
	 wB5f4hi2a2j86U0ExnNWsZOn1GPDAF12SAx99jKz9Bc+VuB2RMR9/KopRFxyiN+hb3
	 z++8JFza65hM6EA7H22qSVa5eCE/PkyJ4D+xag+c87NqULs+gw0Q9H8XYiWckTiXm+
	 d1iMqSQ50AMTZqgNp7W86D6LNAhAt7P6h14Jwpz2rJoGpS7ghjiDFGq9zNleKAg2TG
	 NijsY+UTSH1gJ1VGEuWiuYpBEmjR2FXAZE0qie7DYNJq+pnvdPENlyaFSzoeZb5bLI
	 4DWsDFgHQXbyQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064bL-2EQ1;
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v4 11/14] docs: uapi: netlink: update netlink specs link
Date: Sat, 14 Jun 2025 10:56:05 +0200
Message-ID: <dbc3dfd26ade24dc92c5b4003fd952f067f0fab9.1749891128.git.mchehab+huawei@kernel.org>
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

With the recent parser_yaml extension, and the removal of the
auto-generated ReST source files, the location of netlink
specs changed.

Update uAPI accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/netlink/index.rst | 2 +-
 Documentation/userspace-api/netlink/specs.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/netlink/index.rst b/Documentation/userspace-api/netlink/index.rst
index c1b6765cc963..83ae25066591 100644
--- a/Documentation/userspace-api/netlink/index.rst
+++ b/Documentation/userspace-api/netlink/index.rst
@@ -18,4 +18,4 @@ Netlink documentation for users.
 
 See also:
  - :ref:`Documentation/core-api/netlink.rst <kernel_netlink>`
- - :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
+ - :ref:`Documentation/netlink/specs/index.rst <specs>`
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index 1b50d97d8d7c..debb4bfca5c4 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -15,7 +15,7 @@ kernel headers directly.
 Internally kernel uses the YAML specs to generate:
 
  - the C uAPI header
- - documentation of the protocol as a ReST file - see :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
+ - documentation of the protocol as a ReST file - see :ref:`Documentation/netlink/specs/index.rst <specs>`
  - policy tables for input attribute validation
  - operation tables
 
-- 
2.49.0



Return-Path: <netdev+bounces-196039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994EAD33EE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105901895E62
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718B22488B;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdnqWVGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7311712;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552385; cv=none; b=EL0krxslYZEYy32J2h7VXrzde3BFh2aJKB2cRyMHStB+8AfkdmS+rf31+ORS2ZJarFkZYvJrqdxDDsX0bcik1peYqs1IrA/4vKw+nYcLxBpcs2srf+87S+oHR2Te8YPwkQ71dGDDIZULwD49AXqVh5AiZVfVwkwwDR9KDreMXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552385; c=relaxed/simple;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVKqEC26toGLwK5xo48zJxoRcox+PEW2avpcE6l8GO/bBV9XZdtsa2f0t7/mggCamoJsUycQKuG8HtYP8TynRQiSuFAMAD4zZxX27cgeEfzH556DG3++KWMoAFQbyqxooBFBtB61ia24ow/eTVbOCNbYU2KirgIF3WU0GLqIKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdnqWVGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210BC4CEEF;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552384;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdnqWVGevQtmr0KsXTjTfpno1skOkSyi6x1Hks2h6YU0aHrGAguVpDfqBw2W1Q+Dj
	 pIwBi9urXY01/F2pNNKYPsAs6iXfGvQR1H8kedKiHSq0378ycI13RSNn3SoNfVGYzf
	 VCiRrugcypTsecgqpY8zyacuw3Fuhl5+v80KHjmgTBqM2f5OTuwEAKaOgQZ36MEooC
	 PeNvtcVrh2yeDZAZvHTXOb1Eh+sjtl1OVs5yq8GkZe/W6SmBfbYgFqAymWN97oGwtR
	 3Lj6pPBc+nJcBme5YiLQ6RYTHdETipHqTPqtOMlunrndis24GFiiX/L9FtoPhwg5Bu
	 EVB87LfQOt8CQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uOwUo-00000003juz-3zyW;
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
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH 2/4] docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
Date: Tue, 10 Jun 2025 12:46:05 +0200
Message-ID: <4d46b08e43e37403afc09412692cb5eb295019b6.1749551140.git.mchehab+huawei@kernel.org>
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

Having :doc: references with relative paths doesn't always work,
as it may have troubles when O= is used. So, replace them by
Sphinx cross-reference tag that are now created by ynl_gen_rst.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/netlink/netlink-raw.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 31fc91020eb3..aae296c170c5 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -62,8 +62,8 @@ Sub-messages
 ------------
 
 Several raw netlink families such as
-:doc:`rt-link<../../networking/netlink_spec/rt-link>` and
-:doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
+:ref:`rt-link<netlink-rt-link>` and
+:ref:`tc<netlink-tc>` use attribute nesting as an
 abstraction to carry module specific information.
 
 Conceptually it looks as follows::
@@ -162,7 +162,7 @@ then this is an error.
 Nested struct definitions
 -------------------------
 
-Many raw netlink families such as :doc:`tc<../../networking/netlink_spec/tc>`
+Many raw netlink families such as :ref:`tc<netlink-tc>`
 make use of nested struct definitions. The ``netlink-raw`` schema makes it
 possible to embed a struct within a struct definition using the ``struct``
 property. For example, the following struct definition embeds the
-- 
2.49.0



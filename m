Return-Path: <netdev+bounces-196903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC6AD6DD1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D503A9ABC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908EB239E7B;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIoyDMAP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA24230996;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=mzI/QO2NRFjF9JwH0vxnfaWLTzehTVwGLBHFe6AqpBHsF/Dg+qp42LvGIyLen6/LAQvieE42A6h0rW948dEwpsgG6wqXxH0bnrYONd1vn1giyVhc2n/r04YBkH3GmIZVYW2gS6ucq5QES7MVzgGEgK9AzCcVUgDoXafEGfKoCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL+XoGEe3uFri09eAt4tkSkFMegCQjs7jTnhUYyucMOBvIU0ul03+6mt3TRhLw/cFk1rj/MxtDOxu4pRBfOr7R/DP53ZxmhOIupLdWsg4mSslP5M619v3PO2YYFf8yzijzR59F7oE1KFb+nZscB4AyLSMDWrsRcIC7OyLR4LFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIoyDMAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A59C4CEEE;
	Thu, 12 Jun 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIoyDMAPe/8WMdus1hKZVnjmQHgHnb5uSraiJP5BRxBkL7sfLCwonmSFGJ5Xn7S6o
	 BbYraGss3g5AH8XQV0f63Hp4riXO4134bvduLT8H7sFP0tl4/0nj+oWgP0UBbNg2tT
	 KajFHJaknz+qh+vzRbxrqxDO67awCEClwiYnn+Mgy6t9Bi+XbIO80qW32WSgYhMQLA
	 M8T7VfskiTvcTElLKZ9Ah+77cUVo+ed1I59jikba/XbUqjdeKpOxOXGKu4ve1RDkoF
	 CZ2Gy8yi1M1fBP8kaLrJYU+ivsTj8IRTm09gwRE5bs9V3fdyESjGrqOtl11e6LZye/
	 xLT1oIj8J4e4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvA-0Co5;
	Thu, 12 Jun 2025 12:32:22 +0200
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
Subject: [PATCH v2 02/12] docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
Date: Thu, 12 Jun 2025 12:31:54 +0200
Message-ID: <4d46b08e43e37403afc09412692cb5eb295019b6.1749723671.git.mchehab+huawei@kernel.org>
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



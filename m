Return-Path: <netdev+bounces-198461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC0ADC408
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A61E1887DE9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756B293C72;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOMOPn+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0928DF02;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=OA7EFKI01QLNxMXYdk8xGqxf3p51JkMNZShHTrvywkVm9ZYsgEc6IxIExZgKuJug7oQPsl44e85FnxWjUBYeTAxu23xxCv0VG0s/MR+MjvfLlCru6oVF8to6/pppv5dD7Hm+eIPbM/aF1o/w/YxyzvqvajijJ6TzcDCi+Y6ZcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSeJsa+vdNL5MIeuUAZ8N5QbOHhl1gAnnzu/7fHw8GqqF43UV/mnksjfu2jZ0nDrt72i9Jh834cSA/Kj0Y2mZC6/luxyue/VbSs4P2EJ6fguaxb2H401cApnjFtlMza9NCoMFik6e+jFJsdflYf3tsd6EwwrhZU7WfEAnHPHdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOMOPn+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AEFC4CEF4;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=5GdVV6A8bXN64ovkNLx7Xdx5aR1iPXnV/yeu24lgmqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOMOPn+m1yfIhvgONplR1Usc4iysrHrJZYnc/Q0rROBjUYdNggtuelIGRJwH9B3d/
	 1INd1hXWAJAmucd2fKQ5FiqAhOQJmj18KP4/lO8b3nLgPYY9WST80I7CTFmLD3KSU4
	 MsE5gG6gg/62uvuI2hf5kcJS0UwwRIpV8EtYW2kZBnOCF16ffTZT+Z0pTfu77qQL5C
	 qN5Wj856IIonXqPWr6l/m8YKzrBYibIF3wodC79JH+nF6cOog21p7dp1j9dEGZKk70
	 0+T2hSj7Qri0N+ShAb9TopsCDoZqahWNM0EnalAamHpfP117o6unK8xos/K9AulRkh
	 QSvXLVKscyzGA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH3-00000001vd2-469f;
	Tue, 17 Jun 2025 10:02:29 +0200
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
Subject: [PATCH v5 04/15] docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
Date: Tue, 17 Jun 2025 10:02:01 +0200
Message-ID: <2ad71c748e2f6dc3095b6ce67ec4d43f0fcc038c.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
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



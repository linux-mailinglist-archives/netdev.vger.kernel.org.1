Return-Path: <netdev+bounces-205482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93325AFEE70
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F3E7607B2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30312EAB92;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SghyPGZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5C2E9ED5;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076749; cv=none; b=ScCoLM2TH7KgB5ZdsiHqwB7ZpQ/Se6kWw7xaAdOpKtBH5ACzHutq2eGPgPCI3Iq23Dtcafu8KE3GeWLRITWdh2Dsr6dY8046QQmms+OB77L6X10QpiLoLL54VPLLUnRIWRWtO/WcK9nzvY9QgsAgsMrxK/QuA20DU+TobmMAsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076749; c=relaxed/simple;
	bh=gCUujhjF05O4bN0j1mBzTOE2gqunIOFmC86Oe+w0BHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgwhMFMtcbRypPV2dU6Ojk0Lka6iCmyHt0S7GUzR/FXaM90fdM+avOOCNxref/B8qPtejcqK+GQ54j0M+lIP2SbuVs9seWpkSf0qTdb0i0WGfd55EKi3iTMHZsduVb0tkYKa30gBJ7i2/sw6Y6J6c0exFqOBqK0z8J6mnwMk58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SghyPGZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3EBC4CEF9;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076748;
	bh=gCUujhjF05O4bN0j1mBzTOE2gqunIOFmC86Oe+w0BHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SghyPGZC64a8+hYDtQ035MwCtTzFkPLVuVNDlyGVNA8VZ70/RSMlu3Q050DsRH9RD
	 OzX2ZQJSPmHsxf0/PRtA4/mVVPHqE+FRbFbDXFsW48LRrgauXDe09Evl8/iOloCASj
	 R4SZepQONJYlOE8oAYPb+qnNZc6cDLnD2K6qMOM+5lcpFfm9NS1BXZEO7HmqABwxmV
	 Iqy+/t6CUAlE/H+TWNeaAD+aa+Kogd6kwq1VS3DBKRkHSyDakTFBq1xcvue8zXOpW2
	 i0vbIVY9w47lcZMFwXtH7CiB5Se/A8sz1LSl0GQhdfLCez4LflApD3Mr9rc1FKGbWh
	 ECprCMC5ik0mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000Ih8-1Tvd;
	Wed, 09 Jul 2025 17:59:03 +0200
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
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 07/13] docs: uapi: netlink: update netlink specs link
Date: Wed,  9 Jul 2025 17:58:51 +0200
Message-ID: <7b6f297817a1bda7f9d2981e5c6b68bb53620219.1752076293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

With the recent parser_yaml extension, and the removal of the
auto-generated ReST source files, the location of netlink
specs changed.

Update uAPI accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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



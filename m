Return-Path: <netdev+bounces-210578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A34B13F63
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE247A3590
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A1273D68;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty+Sqtq7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47172202F8E;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=AJZ9g6LCPXHcp2pNBV3UN3WksTM38+Z/CpZ9dh+Crddt9uKAGctcJcHeJleerGpSQCVZefVQnoixvOdJtW/wmx0Isz4VY+PS5qpNe06FnOzP+HymyCrhiWquiz6dxqibv5sGiNhx6wcN310C6F+v9aJzluWwg4kgpptQbkdHX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAyFGcUgRPfCei1NE47fUe4cQHRMsP53xbAqC6zKsEamk7GsRfTB2qyUmq4IecvqzZiFlpM8AarCRQiO3Eck54seaapXg9X2jsI2X/fyFKiba1TY0ya01DGEJAGTFhlWepIjeO6p6U5TpxyFs0duXaskPHwH1j8noAevXHU7SmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty+Sqtq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1E2C4CEF9;
	Mon, 28 Jul 2025 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty+Sqtq7VrudIdBdNN1rE0m3vCwtK+8o2gy/Qp8kgHRw9fjGY+arSIIO+Ex35OIFx
	 29rneKQcC2YYO5UlFAL1FmooxtFilvJ0H9LqQe/TykftAFhjecoY782TNzmBkaCmsO
	 Vi0KmwbOChPh6AsTs7xODwzDFe0n6p28XF4bggk/Sxsa+8pO/XKRDBiJYB4z1atK/g
	 IxhkYOJJoF4pHfkhC1HGdzPe8gt+m4pjHUwacd9CsULKEk6DkszvKrud2pqyhxOKmU
	 C9uoSIvpK8yI+RBEXRVFXFelEyxbvowyPPZmB0H7O3x1G7LUXnYlM7wmN+To4H/fVN
	 GVEpaPjsR2HTA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gcn-1Cdi;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 03/14] docs: netlink: index.rst: add a netlink index file
Date: Mon, 28 Jul 2025 18:01:56 +0200
Message-ID: <dab12dfc8f73f59a1fbe929657c891e282d9fc10.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Instead of generating the index file, use glob to automatically
include all data from yaml.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/index.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/netlink/specs/index.rst

diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
new file mode 100644
index 000000000000..7f7cf4a096f2
--- /dev/null
+++ b/Documentation/netlink/specs/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _specs:
+
+=============================
+Netlink Family Specifications
+=============================
+
+.. toctree::
+   :maxdepth: 1
+   :glob:
+
+   *
-- 
2.49.0



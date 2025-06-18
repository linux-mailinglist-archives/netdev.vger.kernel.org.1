Return-Path: <netdev+bounces-199021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD7ADEAC2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406DD3A8971
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DD2DE1F3;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr6Z57a3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637D2BEC3F;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247211; cv=none; b=Ekq+KSpA5UU8xoDa807Xq0si3+OaWtiXqppaHQvXM+fbikICAmwFikZ51iiyRG6rVuJtMlHCfJuKYaXwFv08Hc/EbW508SZvLdu+AhTdxKDBIJ25UoYiqPVLESqMsaxx2uYzStiDo2MBtLf8VzjTieRf+R8Lw5GQbbK2JUdMkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247211; c=relaxed/simple;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRpctvHH2+ueL0QUqKiIjmUBIY2e2driYeyL1IYfLjtyLxKSeStsilRGLWM/zeQ3qoSZLGHz7qvLQM40pMHItbIJkHWW5/VNPTsh568OESQN8z5dk+xyWzsRXr3lKGjT0Ch1UTCCyXLJKYBX7J5r/In1Ptf3OVbO5Tv0Puogf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr6Z57a3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66690C4CEF4;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr6Z57a3juhMa/tARGa4WTOcB7PeTRPuzl0CYxiGCCurhYGvSo74ISWo6DVkJgdpl
	 6dohbAY9J+ERcWMPgLhJ0Je0N3xc6Eyg29g6rva8tyHW0tjWQwjtDcpjhPo/sKRX+1
	 dVfSKv1a26OE7M16QzqZus9XAUlfYUG3D4mmlx3eYDnnps2JVT2RtFYYSl2VLEjM2m
	 ws+yPl7YkMvKBz604fXe4t814XndrOn+WRlo/8lJgakSMsuMe2Q3GnZxRIkRVoFOEb
	 SPzntBSBlq3xItX6uqfvP2tGGdKFx7lq2YiKmYbgkBfnAazJppPHZxcL5IKlesvxgu
	 jvO+Gs9iAF1Iw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UZ-2Luw;
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 05/15] docs: netlink: index.rst: add a netlink index file
Date: Wed, 18 Jun 2025 13:46:32 +0200
Message-ID: <468efe892aecc585288a3fcdbecc1db7d4871196.1750246291.git.mchehab+huawei@kernel.org>
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



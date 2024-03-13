Return-Path: <netdev+bounces-79602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1B87A1EA
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 04:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F987B220B6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041DE10A13;
	Wed, 13 Mar 2024 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crAiFTea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAA10A01;
	Wed, 13 Mar 2024 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300214; cv=none; b=Kp2CVCjssRr/RlZfMC1G06V8zTiPZ2Nz/vGh+c29wbk3uEl8j9bZuU9CjBk2fjfjyBkgCuoUdxcicBpwsJMGy+uUB37smYR+BlrHDsjEhYBY7RWHLtBCYbLTFVBD/WNkp6mi5ODCgOq/aaJwuaUZWHOwDdr5N1n0vw4hvjL8fyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300214; c=relaxed/simple;
	bh=/ba0nPvlWUxIUd8scRb/0mUtyRYX1xYB5ftd7JwlaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2A9N1ytP2s+drfmkwoNAorT10uIbF25Vmc+RY/FaEph6DIInKbJYX/ucsCnFWfUsqijjRVoVxaxiz4SYDZ/DU3dAeHqWJ8+5I1RZMW2JFrORkLehSPxZMuN5yAMBiZTCy0Nd/19bxZimmV3Q2baaCPybG+NHa4w5wzs4JDrQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crAiFTea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92DBC433F1;
	Wed, 13 Mar 2024 03:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710300214;
	bh=/ba0nPvlWUxIUd8scRb/0mUtyRYX1xYB5ftd7JwlaM0=;
	h=From:To:Cc:Subject:Date:From;
	b=crAiFTea2twAeeZuzZGHL6IrzHLi1gZLSXxaPU9suJndYkCodg7Y5raLGswjCGvKb
	 weaZSsOBzdFkvo36eAwzzgVB9WHGWEHsA/93nidT55oT64n/P7uOaCWCwqC4qNzGs/
	 h1rJvJWNm65NZGL4hRfXWA8F7l2GWPo5kvt0hpSjp8hyFrLelIhBQq4PZtXOLgw8K/
	 PcSyK1ugcvNiKZ7x/LzW/dVaNHOyCtiw8n+eU92V29fc5igDZqS63fOoWi71Gx9ETK
	 D4vtbT+SVGdxxiTqKLmGI1aDOIyNw9kH6bjDzjY7CpHDThLjSUL98jk5uW+diBkTqR
	 Hn/WvHq1v65yQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	corbet@lwn.net,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	linux-doc@vger.kernel.org
Subject: [PATCH net] docs: networking: fix indentation errors in multi-pf-netdev
Date: Tue, 12 Mar 2024 20:23:29 -0700
Message-ID: <20240313032329.3919036-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stephen reports new warnings in the docs:

Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected indentation.
Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected indentation.

Fixes: 77d9ec3f6c8c ("Documentation: networking: Add description for multi-pf netdev")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20240312153304.0ef1b78e@canb.auug.org.au/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Turns out our build test for docs was broken.
---
CC: corbet@lwn.net
CC: przemyslaw.kitszel@intel.com
CC: tariqt@nvidia.com
CC: saeedm@nvidia.com
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/multi-pf-netdev.rst | 50 ++++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
index be8e4bcadf11..268819225866 100644
--- a/Documentation/networking/multi-pf-netdev.rst
+++ b/Documentation/networking/multi-pf-netdev.rst
@@ -87,35 +87,35 @@ all using the same instance under "priv->mdev".
 
 Observability
 =============
-The relation between PF, irq, napi, and queue can be observed via netlink spec:
+The relation between PF, irq, napi, and queue can be observed via netlink spec::
 
-$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'
-[{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
- {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
- {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
- {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'rx'},
- {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'rx'},
- {'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'tx'},
- {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'tx'},
- {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'tx'},
- {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
- {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
+  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'
+  [{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
+   {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
+   {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
+   {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'rx'},
+   {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'rx'},
+   {'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'tx'},
+   {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'tx'},
+   {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'tx'},
+   {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
+   {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
 
-$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'
-[{'id': 543, 'ifindex': 13, 'irq': 42},
- {'id': 542, 'ifindex': 13, 'irq': 41},
- {'id': 541, 'ifindex': 13, 'irq': 40},
- {'id': 540, 'ifindex': 13, 'irq': 39},
- {'id': 539, 'ifindex': 13, 'irq': 36}]
+  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'
+  [{'id': 543, 'ifindex': 13, 'irq': 42},
+   {'id': 542, 'ifindex': 13, 'irq': 41},
+   {'id': 541, 'ifindex': 13, 'irq': 40},
+   {'id': 540, 'ifindex': 13, 'irq': 39},
+   {'id': 539, 'ifindex': 13, 'irq': 36}]
 
-Here you can clearly observe our channels distribution policy:
+Here you can clearly observe our channels distribution policy::
 
-$ ls /proc/irq/{36,39,40,41,42}/mlx5* -d -1
-/proc/irq/36/mlx5_comp1@pci:0000:08:00.0
-/proc/irq/39/mlx5_comp1@pci:0000:09:00.0
-/proc/irq/40/mlx5_comp2@pci:0000:08:00.0
-/proc/irq/41/mlx5_comp2@pci:0000:09:00.0
-/proc/irq/42/mlx5_comp3@pci:0000:08:00.0
+  $ ls /proc/irq/{36,39,40,41,42}/mlx5* -d -1
+  /proc/irq/36/mlx5_comp1@pci:0000:08:00.0
+  /proc/irq/39/mlx5_comp1@pci:0000:09:00.0
+  /proc/irq/40/mlx5_comp2@pci:0000:08:00.0
+  /proc/irq/41/mlx5_comp2@pci:0000:09:00.0
+  /proc/irq/42/mlx5_comp3@pci:0000:08:00.0
 
 Steering
 ========
-- 
2.44.0



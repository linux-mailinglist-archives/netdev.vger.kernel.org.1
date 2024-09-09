Return-Path: <netdev+bounces-126626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A79721A4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE571F23605
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A617D8A9;
	Mon,  9 Sep 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uliUmaC/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB8170A27
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905579; cv=none; b=VauD4m2oRlsM6kOn5azWz0pzqYiCJkZ519U44BsYO6Qgcj90kzT1zJTPcNFJgOWQinfszEYM8YoTp2ybuF/ZfFDxtyrFxRz4zHLWlSzgMQDd5hTPmKkg5EuY3cAoaEUw1h8mMdpRD3alUDT4nZXzs13v+7bMf2ulY2+2EEkPHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905579; c=relaxed/simple;
	bh=H3ylEI5liH/9aXFmYRaI58CknhVgVSv9sIzWk3GtSKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZQ2VY7HdsSZnRsOMtJFUs3avW3VrWJvnzQ6ojyCCQVPd16UNumvQZoLpcvMkebN3WbyoaDP9e6822LtvodeOsVT4Rqs9iRNeaFQsZfVJsAlyP4+9jjA+aJNuYcu0k+vzCBe6jvfgjSUGqI32BpaQYw2jrpPv3RLqV7cI9Ze/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uliUmaC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE9C4CEC5;
	Mon,  9 Sep 2024 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725905579;
	bh=H3ylEI5liH/9aXFmYRaI58CknhVgVSv9sIzWk3GtSKU=;
	h=From:To:Cc:Subject:Date:From;
	b=uliUmaC/blYLwsnaj7gjLFCQE/2BzRf+pdrVyZ5a5qk3UkLHjlw0b1I7j23MaThs+
	 Yua+8o9Vmy/9uDF2rlAe7b81Md6zSkdZvR+ZeCrVKqf9VuXVc8ehsFvvvpE9PM2zXZ
	 hFphc6TLtzIjtcYGoCvBXoI9CXm1Ay3JpmrMk+lvutylfITAgxDn9yvrWhjlADdob7
	 lMEp/vZU3UJbRzwiNjnVsud/dxSXCkWkmsYdIWy0G1h9e76+BduX5Ea/SvJQgtKE47
	 BUgOZYhpWE9yX1M1mlev4jrY41bCttrlUiFJVSby5bfQz4p8DjhHAV1WHEhK0zUDxF
	 ARTaFm7pouOpA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net-next V4 00/15] mlx5 updates 2024-09-02
Date: Mon,  9 Sep 2024 11:12:33 -0700
Message-ID: <20240909181250.41596-1-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds HW steering support in mlx5.
For more information please see tag log below.

V1->V2:
 - Fix sparse and checkpatch issue.

V2->V3:
 - Smatch and coccicheck fixes.

V3->V4:
 - Error path fixes.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit bfba7bc8b7c2c100b76edb3a646fdce256392129:

  Merge branch 'unmask-dscp-part-four' (2024-09-09 14:14:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-09-02

for you to fetch changes up to 510f9f61a1121a296a45962760d5e2824277fa37:

  net/mlx5: HWS, added API and enabled HWS support (2024-09-09 11:10:06 -0700)

----------------------------------------------------------------
mlx5-updates-2024-08-29

HW-Managed Flow Steering in mlx5 driver

Yevgeny Kliteynik says:
=======================

1. Overview
-----------

ConnectX devices support packet matching, modification, and redirection.
This functionality is referred as Flow Steering.
To configure a steering rule, the rule is written to the device-owned
memory. This memory is accessed and cached by the device when processing
a packet.

The first implementation of Flow Steering was done in FW, and it is
referred in the mlx5 driver as Device-Managed Flow Steering (DMFS).
Later we introduced SW-managed Flow Steering (SWS or SMFS), where the
driver is writing directly to the device's configuration memory (ICM)
through RC QP using RDMA operations (RDMA-read and RDAM-write), thus
achieving higher rates of rule insertion/deletion.

Now we introduce a new flow steering implementation: HW-Managed Flow
Steering (HWS or HMFS).

In this new approach, the driver is configuring steering rules directly
to the HW using the WQs with a special new type of WQE. This way we can
reach higher rule insertion/deletion rate with much lower CPU utilization
compared to SWS.

The key benefits of HWS as opposed to SWS:
+ HW manages the steering decision tree
   - HW calculates CRC for each entry
   - HW handles tree hash collisions
   - HW & FW manage objects refcount
+ HW keeps cache coherency:
   - HW provides tree access locking and synchronization
   - HW provides notification on completion
+ Insertion rate isn’t affected by background traffic
   - Dedicated HW components that handle insertion

2. Performance
--------------

Measuring Connection Tracking with simple IPv4 flows w/o NAT, we
are able to get ~5 times more flows offloaded per second using HWS.

3. Configuration
----------------

The enablement of HWS mode in eswitch manager is done using the same
devlink param that is already used for switching between FW-managed
steering and SW-managed steering modes:

  # devlink dev param set pci/<PCI_ID> name flow_steering_mode cmod runtime value hmfs

4. Upstream Submission
----------------------

HWS support consists of 3 main components:
+ Steering:
   - The lower layer that exposes HWS API to upper layers and implements
     all the management of flow steering building blocks
+ FS-Core
   - Implementation of fs_hws layer to enable fs_core to use HWS instead
     of FW or SW steering
   - Create HW steering action pools to utilize the ability of HWS to
     share steering actions among different rules
   - Add support for configuring HWS mode through devlink command,
     similar to configuring SWS mode
+ Connection Tracking
   - Implementation of CT support for HW steering
   - Hooks up the CT ops for the new steering mode and uses the HWS API
     to implement connection tracking.

Because of the large number of patches, we need to perform the submission
in several separate patch series. This series is the first submission that
lays the ground work for the next submissions, where an actual user of HWS
will be added.

5. Patches in this series
-------------------------

This patch series contains implementation of the first bullet from above.
The patches are:

[patch 01/15] net/mlx5: Added missing mlx5_ifc definition for HW Steering
[patch 02/15] net/mlx5: Added missing definitions in preparation for HW Steering
[patch 03/15] net/mlx5: HWS, added actions handling
[patch 04/15] net/mlx5: HWS, added tables handling
[patch 05/15] net/mlx5: HWS, added rules handling
[patch 06/15] net/mlx5: HWS, added definers handling
[patch 07/15] net/mlx5: HWS, added matchers functionality
[patch 08/15] net/mlx5: HWS, added FW commands handling
[patch 09/15] net/mlx5: HWS, added modify header pattern and args handling
[patch 10/15] net/mlx5: HWS, added vport handling
[patch 11/15] net/mlx5: HWS, added memory management handling
[patch 12/15] net/mlx5: HWS, added backward-compatible API handling
[patch 13/15] net/mlx5: HWS, added debug dump and internal headers
[patch 14/15] net/mlx5: HWS, added send engine and context handling
[patch 15/15] net/mlx5: HWS, added API and enabled HWS support

=======================

----------------------------------------------------------------
Yevgeny Kliteynik (15):
      net/mlx5: Added missing mlx5_ifc definition for HW Steering
      net/mlx5: Added missing definitions in preparation for HW Steering
      net/mlx5: HWS, added actions handling
      net/mlx5: HWS, added tables handling
      net/mlx5: HWS, added rules handling
      net/mlx5: HWS, added definers handling
      net/mlx5: HWS, added matchers functionality
      net/mlx5: HWS, added FW commands handling
      net/mlx5: HWS, added modify header pattern and args handling
      net/mlx5: HWS, added vport handling
      net/mlx5: HWS, added memory management handling
      net/mlx5: HWS, added backward-compatible API handling
      net/mlx5: HWS, added debug dump and internal headers
      net/mlx5: HWS, added send engine and context handling
      net/mlx5: HWS, added API and enabled HWS support

 .../ethernet/mellanox/mlx5/kconfig.rst             |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   21 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    8 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   12 +-
 .../mellanox/mlx5/core/steering/hws/Makefile       |    2 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |  954 +++++++
 .../mlx5/core/steering/hws/mlx5hws_action.c        | 2604 ++++++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_action.h        |  307 +++
 .../mlx5/core/steering/hws/mlx5hws_buddy.c         |  149 ++
 .../mlx5/core/steering/hws/mlx5hws_buddy.h         |   21 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c  |  997 ++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h  |   73 +
 .../mlx5/core/steering/hws/mlx5hws_bwc_complex.c   |   86 +
 .../mlx5/core/steering/hws/mlx5hws_bwc_complex.h   |   29 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c  | 1300 ++++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h  |  361 +++
 .../mlx5/core/steering/hws/mlx5hws_context.c       |  260 ++
 .../mlx5/core/steering/hws/mlx5hws_context.h       |   64 +
 .../mlx5/core/steering/hws/mlx5hws_debug.c         |  480 ++++
 .../mlx5/core/steering/hws/mlx5hws_debug.h         |   40 +
 .../mlx5/core/steering/hws/mlx5hws_definer.c       | 2146 ++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_definer.h       |  834 +++++++
 .../mlx5/core/steering/hws/mlx5hws_internal.h      |   59 +
 .../mlx5/core/steering/hws/mlx5hws_matcher.c       | 1216 +++++++++
 .../mlx5/core/steering/hws/mlx5hws_matcher.h       |  107 +
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.c       |  579 +++++
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.h       |  101 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_pool.c |  640 +++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_pool.h |  151 ++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_prm.h  |  514 ++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.c |  780 ++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.h |   84 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 1209 +++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.h |  270 ++
 .../mlx5/core/steering/hws/mlx5hws_table.c         |  493 ++++
 .../mlx5/core/steering/hws/mlx5hws_table.h         |   68 +
 .../mlx5/core/steering/hws/mlx5hws_vport.c         |   86 +
 .../mlx5/core/steering/hws/mlx5hws_vport.h         |   13 +
 include/linux/mlx5/mlx5_ifc.h                      |  189 +-
 include/linux/mlx5/qp.h                            |    1 +
 41 files changed, 17285 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/Makefile
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_prm.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h


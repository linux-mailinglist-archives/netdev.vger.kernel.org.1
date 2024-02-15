Return-Path: <netdev+bounces-71941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974485595F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126C32925D1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB4182DD;
	Thu, 15 Feb 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCokavv1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727EC1BDD5
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966514; cv=none; b=D5gRoksibFn10tcfPA/soxP2OXJaPJkdr1YLu9Zvyd8Fy9vVpNk/dcSGnUyVu2WG/Klj56KSFOlds0XWo/66OG8wPk8Ufvlz4vjlPvY4520JXdUbl60d2g9GWBRAxr4Yn61KrUAFzWg22YMPBvAhWJKlQe2fiL91eZ+uGA9013s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966514; c=relaxed/simple;
	bh=38C/2clIsMaDyZtQJG6Rp86EGlnVntvGRKK1wamXz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=looCymlSqQ+Qgr5o02xSCRXE8HQX7g3fhI9o/R332WmZX6LIRfl/ASI4JOGGOKynGUKH9mzgBQZVeRhpJ9Cfc3PPPpqgRgyaVE8CTq0Ohxz0nQ2GgHRcXD9DyC5OdCSJRxwmENeGTLwy0BOwU5bsK+oFTrH9wW82Qfg4qXr6Dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCokavv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD67FC433F1;
	Thu, 15 Feb 2024 03:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966513;
	bh=38C/2clIsMaDyZtQJG6Rp86EGlnVntvGRKK1wamXz8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCokavv1D6KVL+aHdTXjW7ooLo1gSZHeB3PhrsaBrb8I3olV1S7avP6wxgovpUBwn
	 bKmV8aVKMp4X5hjABG+Ghn+hL+Pm/0Rc+YQLvKpNEp3556gZquV8gWW8TLoD1y+Tmh
	 Yu/AdlQwz8SJ1LeDHODMbpbx0PQ1njLp/ZZGYVUoiTygtBarciY3SvW1SyidyNnIDp
	 5Vt1vYg3ZlAs4T1w7YJaZHpfnfYcOQ4T2+X6roGO1a3sQJqrKo7eUEwfDL+2ngp3sS
	 VIwquTiCF4ay2cT1kZnwl0Y/UIefzVSjB0VhtpRvBNjRvy4HilC5Gx/RKIL7dvE1Lq
	 4CIJrEABxmmug==
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
Subject: [net-next V3 15/15] Documentation: networking: Add description for multi-pf netdev
Date: Wed, 14 Feb 2024 19:08:14 -0800
Message-ID: <20240215030814.451812-16-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add documentation for the multi-pf netdev feature.
Describe the mlx5 implementation and design decisions.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/multi-pf-netdev.rst | 157 +++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 Documentation/networking/multi-pf-netdev.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 69f3d6dcd9fd..473d72c36d61 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -74,6 +74,7 @@ Contents:
    mpls-sysctl
    mptcp-sysctl
    multiqueue
+   multi-pf-netdev
    napi
    net_cachelines/index
    netconsole
diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
new file mode 100644
index 000000000000..6ef2ac448d1e
--- /dev/null
+++ b/Documentation/networking/multi-pf-netdev.rst
@@ -0,0 +1,157 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===============
+Multi-PF Netdev
+===============
+
+Contents
+========
+
+- `Background`_
+- `Overview`_
+- `mlx5 implementation`_
+- `Channels distribution`_
+- `Topology`_
+- `Steering`_
+- `Mutually exclusive features`_
+
+Background
+==========
+
+The advanced Multi-PF NIC technology enables several CPUs within a multi-socket server to
+connect directly to the network, each through its own dedicated PCIe interface. Through either a
+connection harness that splits the PCIe lanes between two cards or by bifurcating a PCIe slot for a
+single card. This results in eliminating the network traffic traversing over the internal bus
+between the sockets, significantly reducing overhead and latency, in addition to reducing CPU
+utilization and increasing network throughput.
+
+Overview
+========
+
+This feature adds support for combining multiple devices (PFs) of the same port in a Multi-PF
+environment under one netdev instance. Passing traffic through different devices belonging to
+different NUMA sockets saves cross-numa traffic and allows apps running on the same netdev from
+different numas to still feel a sense of proximity to the device and achieve improved performance.
+
+mlx5 implementation
+===================
+
+Multi-PF or Socket-direct in mlx5 is achieved by grouping PFs together which belong to the same
+NIC and has the socket-direct property enabled, once all PFS are probed, we create a single netdev
+to represent all of them, symmetrically, we destroy the netdev whenever any of the PFs is removed.
+
+The netdev network channels are distributed between all devices, a proper configuration would utilize
+the correct close numa node when working on a certain app/cpu.
+
+We pick one PF to be a primary (leader), and it fills a special role. The other devices
+(secondaries) are disconnected from the network at the chip level (set to silent mode). In silent
+mode, no south <-> north traffic flowing directly through a secondary PF. It needs the assistance of
+the leader PF (east <-> west traffic) to function. All RX/TX traffic is steered through the primary
+to/from the secondaries.
+
+Currently, we limit the support to PFs only, and up to two PFs (sockets).
+
+Channels distribution
+=====================
+
+We distribute the channels between the different PFs to achieve local NUMA node performance
+on multiple NUMA nodes.
+
+Each combined channel works against one specific PF, creating all its datapath queues against it. We distribute
+channels to PFs in a round-robin policy.
+
+::
+
+        Example for 2 PFs and 6 channels:
+        +--------+--------+
+        | ch idx | PF idx |
+        +--------+--------+
+        |    0   |    0   |
+        |    1   |    1   |
+        |    2   |    0   |
+        |    3   |    1   |
+        |    4   |    0   |
+        |    5   |    1   |
+        +--------+--------+
+
+
+We prefer this round-robin distribution policy over another suggested intuitive distribution, in
+which we first distribute one half of the channels to PF0 and then the second half to PF1.
+
+The reason we prefer round-robin is, it is less influenced by changes in the number of channels. The
+mapping between a channel index and a PF is fixed, no matter how many channels the user configures.
+As the channel stats are persistent across channel's closure, changing the mapping every single time
+would turn the accumulative stats less representing of the channel's history.
+
+This is achieved by using the correct core device instance (mdev) in each channel, instead of them
+all using the same instance under "priv->mdev".
+
+Topology
+========
+Currently the sysfs is kept untouched, letting the netdev sysfs point to its primary PF.
+Enhancing sysfs to reflect the actual topology is to be discussed and contributed separately.
+For now, debugfs is being used to reflect the topology:
+
+.. code-block:: bash
+
+        $ grep -H . /sys/kernel/debug/mlx5/0000\:08\:00.0/sd/*
+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/group_id:0x00000101
+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/primary:0000:08:00.0 vhca 0x0
+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/secondary_0:0000:09:00.0 vhca 0x2
+
+Steering
+========
+Secondary PFs are set to "silent" mode, meaning they are disconnected from the network.
+
+In RX, the steering tables belong to the primary PF only, and it is its role to distribute incoming
+traffic to other PFs, via cross-vhca steering capabilities. Nothing special about the RSS table
+content, except that it needs a capable device to point to the receive queues of a different PF.
+
+In TX, the primary PF creates a new TX flow table, which is aliased by the secondaries, so they can
+go out to the network through it.
+
+In addition, we set default XPS configuration that, based on the cpu, selects an SQ belonging to the
+PF on the same node as the cpu.
+
+XPS default config example:
+
+NUMA node(s):          2
+NUMA node0 CPU(s):     0-11
+NUMA node1 CPU(s):     12-23
+
+PF0 on node0, PF1 on node1.
+
+- /sys/class/net/eth2/queues/tx-0/xps_cpus:000001
+- /sys/class/net/eth2/queues/tx-1/xps_cpus:001000
+- /sys/class/net/eth2/queues/tx-2/xps_cpus:000002
+- /sys/class/net/eth2/queues/tx-3/xps_cpus:002000
+- /sys/class/net/eth2/queues/tx-4/xps_cpus:000004
+- /sys/class/net/eth2/queues/tx-5/xps_cpus:004000
+- /sys/class/net/eth2/queues/tx-6/xps_cpus:000008
+- /sys/class/net/eth2/queues/tx-7/xps_cpus:008000
+- /sys/class/net/eth2/queues/tx-8/xps_cpus:000010
+- /sys/class/net/eth2/queues/tx-9/xps_cpus:010000
+- /sys/class/net/eth2/queues/tx-10/xps_cpus:000020
+- /sys/class/net/eth2/queues/tx-11/xps_cpus:020000
+- /sys/class/net/eth2/queues/tx-12/xps_cpus:000040
+- /sys/class/net/eth2/queues/tx-13/xps_cpus:040000
+- /sys/class/net/eth2/queues/tx-14/xps_cpus:000080
+- /sys/class/net/eth2/queues/tx-15/xps_cpus:080000
+- /sys/class/net/eth2/queues/tx-16/xps_cpus:000100
+- /sys/class/net/eth2/queues/tx-17/xps_cpus:100000
+- /sys/class/net/eth2/queues/tx-18/xps_cpus:000200
+- /sys/class/net/eth2/queues/tx-19/xps_cpus:200000
+- /sys/class/net/eth2/queues/tx-20/xps_cpus:000400
+- /sys/class/net/eth2/queues/tx-21/xps_cpus:400000
+- /sys/class/net/eth2/queues/tx-22/xps_cpus:000800
+- /sys/class/net/eth2/queues/tx-23/xps_cpus:800000
+
+Mutually exclusive features
+===========================
+
+The nature of Multi-PF, where different channels work with different PFs, conflicts with
+stateful features where the state is maintained in one of the PFs.
+For example, in the TLS device-offload feature, special context objects are created per connection
+and maintained in the PF.  Transitioning between different RQs/SQs would break the feature. Hence,
+we disable this combination for now.
-- 
2.43.0



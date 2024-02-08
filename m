Return-Path: <netdev+bounces-70092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAF84D93D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFFA285085
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AC36139;
	Thu,  8 Feb 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6qBdxCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FF36138
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364464; cv=none; b=LJaPJ+vgOKaU0VmaOJRNG53B9PktpI05+Ooknp54tPxEkoT9/hWldoSO7vdEAzD5WG4bGSb7FuUfsUhBma7sPBb/UKe2SneOvMKeN+PXvbGVpudn0xdOVeldGjN7bYEOvIII6TrewUsIhMndR743g2IgekL+OnxBb9Kx0X3dgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364464; c=relaxed/simple;
	bh=6JY404awMC86LTGLLzYAR/y6KIIgLTH5me+VvHCnDEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGSlaZNj8SteHs5wRa/oCNWXcTE9e1HQ3YTOtFtjTzH9Oi0uT6V174MO7AwBgZcKGZjgwVWlrvQTdaXkdS2sTzK3jjnfBxeeUDk+z++IR1VJYG+3dA8ltJ13mySbH7Fq9izHfdi3vnknPNM/xBHZMDKR0LN2Vbxq1D2wF2WdkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6qBdxCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F50C433F1;
	Thu,  8 Feb 2024 03:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364464;
	bh=6JY404awMC86LTGLLzYAR/y6KIIgLTH5me+VvHCnDEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6qBdxCe5GXBwVV3XvjeFVKg+hCqEpPubIr9BtHzz4JlUTKKwZwgCI/fRYsMTvQ4e
	 Fxa6gXKI3GqSm5GKQ67SD2qwC4GQ3cl7RJhZPU8MIlG5DccrExDMmwfRrhNWP65Gfd
	 +BnFekSPaoDpheaRr3+bybs5rpJJ4OXchYsPRyuy/i6NdxfsdUXhXyPNblmFIISr73
	 GehHMRb7KzkCSaBI/yuWGYm+hHzwF9oEQQvoT0Ws6QZoJiHWf6ne50WbJZ8Y9YxSnV
	 fU1lmqc6kPBIpJMJMdFlfHytr8wkeJcn4EPTAeEFX5MtcPB26zd/WJ2tqoe3B0yF98
	 +Myir4fBx624Q==
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
Subject: [net-next V2 15/15] Documentation: net/mlx5: Add description for Socket-Direct netdev combining
Date: Wed,  7 Feb 2024 19:53:52 -0800
Message-ID: <20240208035352.387423-16-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add documentation for the feature and some details on some design decisions.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/sd.rst             | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mellanox/mlx5/sd.rst

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/sd.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/sd.rst
new file mode 100644
index 000000000000..c8b4d8025a81
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/sd.rst
@@ -0,0 +1,134 @@
+.. SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+.. include:: <isonum.txt>
+
+==============================
+Socket-Direct Netdev Combining
+==============================
+
+:Copyright: |copy| 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+Contents
+========
+
+- `Background`_
+- `Overview`_
+- `Channels distribution`_
+- `Steering`_
+- `Mutually exclusive features`_
+
+Background
+==========
+
+NVIDIA Mellanox Socket Direct technology enables several CPUs within a multi-socket server to
+connect directly to the network, each through its own dedicated PCIe interface. Through either a
+connection harness that splits the PCIe lanes between two cards or by bifurcating a PCIe slot for a
+single card. This results in eliminating the network traffic traversing over the internal bus
+between the sockets, significantly reducing overhead and latency, in addition to reducing CPU
+utilization and increasing network throughput.
+
+Overview
+========
+
+This feature adds support for combining multiple devices (PFs) of the same port in a Socket Direct
+environment under one netdev instance. Passing traffic through different devices belonging to
+different NUMA sockets saves cross-numa traffic and allows apps running on the same netdev from
+different numas to still feel a sense of proximity to the device and acheive improved performance.
+
+We acheive this by grouping PFs together, and creating the netdev only once all group members are
+probed. Symmetrically, we destroy the netdev once any of the PFs is removed.
+
+The channels are distributed between all devices, a proper configuration would utilize the correct
+close numa when working on a certain app/cpu.
+
+We pick one device to be a primary (leader), and it fills a special role. The other devices
+(secondaries) are disconnected from the network in the chip level (set to silent mode). All RX/TX
+traffic is steered through the primary to/from the secondaries.
+
+Currently, we limit the support to PFs only, and up to two devices (sockets).
+
+Channels distribution
+=====================
+
+Distribute the channels between the different SD-devices to acheive local numa node performance on
+multiple numas.
+
+Each channel works against one specific mdev, creating all datapath queues against it. We distribute
+channels to mdevs in a round-robin policy.
+
+Example for 2 PFs and 6 channels:
++-------+-------+
+| ch ix | PF ix |
++-------+-------+
+|   0   |   0   |
+|   1   |   1   |
+|   2   |   0   |
+|   3   |   1   |
+|   4   |   0   |
+|   5   |   1   |
++-------+-------+
+
+This round-robin distribution policy is preferred over another suggested intuitive distribution, in
+which we first distribute one half of the channels to PF0 and then the second half to PF1.
+
+The reason we prefer round-robin is, it is less influenced by changes in the number of channels. The
+mapping between a channel index and a PF is fixed, no matter how many channels the user configures.
+As the channel stats are persistent to channels closure, changing the mapping every single time
+would turn the accumulative stats less representing of the channel's history.
+
+This is acheived by using the correct core device instance (mdev) in each channel, instead of them
+all using the same instance under "priv->mdev".
+
+Steering
+========
+Secondary PFs are set to "silent" mode, meaning they are disconnected from the network.
+
+In RX, the steering tables belong to the primary PF only, and it is its role to distribute incoming
+traffic to other PFs, via advanced HW cross-vhca steering capabilities.
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
+/sys/class/net/eth2/queues/tx-0/xps_cpus:000001
+/sys/class/net/eth2/queues/tx-1/xps_cpus:001000
+/sys/class/net/eth2/queues/tx-2/xps_cpus:000002
+/sys/class/net/eth2/queues/tx-3/xps_cpus:002000
+/sys/class/net/eth2/queues/tx-4/xps_cpus:000004
+/sys/class/net/eth2/queues/tx-5/xps_cpus:004000
+/sys/class/net/eth2/queues/tx-6/xps_cpus:000008
+/sys/class/net/eth2/queues/tx-7/xps_cpus:008000
+/sys/class/net/eth2/queues/tx-8/xps_cpus:000010
+/sys/class/net/eth2/queues/tx-9/xps_cpus:010000
+/sys/class/net/eth2/queues/tx-10/xps_cpus:000020
+/sys/class/net/eth2/queues/tx-11/xps_cpus:020000
+/sys/class/net/eth2/queues/tx-12/xps_cpus:000040
+/sys/class/net/eth2/queues/tx-13/xps_cpus:040000
+/sys/class/net/eth2/queues/tx-14/xps_cpus:000080
+/sys/class/net/eth2/queues/tx-15/xps_cpus:080000
+/sys/class/net/eth2/queues/tx-16/xps_cpus:000100
+/sys/class/net/eth2/queues/tx-17/xps_cpus:100000
+/sys/class/net/eth2/queues/tx-18/xps_cpus:000200
+/sys/class/net/eth2/queues/tx-19/xps_cpus:200000
+/sys/class/net/eth2/queues/tx-20/xps_cpus:000400
+/sys/class/net/eth2/queues/tx-21/xps_cpus:400000
+/sys/class/net/eth2/queues/tx-22/xps_cpus:000800
+/sys/class/net/eth2/queues/tx-23/xps_cpus:800000
+
+Mutually exclusive features
+===========================
+
+The nature of socket direct, where different channels work with different PFs, conflicts with
+stateful features where the state is maintained in one of the PFs.
+For exmaple, in the TLS device-offload feature, special context objects are created per connection
+and maintained in the PF.  Transitioning between different RQs/SQs would break the feature. Hence,
+we disable this combination for now.
-- 
2.43.0



Return-Path: <netdev+bounces-68681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A352F84795E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA291F27E3B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637512C7F4;
	Fri,  2 Feb 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6W7uTX2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481212C7F2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900945; cv=none; b=qlCIwuap4w3yNKmYl1484UYRBKaNJOkaoNncKdt+JYhDcte/E1ciZSawjEYXHe5TK2SLsEbUX6bdWcjxNa+KQOCdMDCpeRhaMxKzpJqTbq375uL7vvl0RCWqKoAf+TXLK7FsRC9l8yXFnspM4orqf3qfCauHyRCqJLWTLP0uWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900945; c=relaxed/simple;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrrndGKTuTFlpyUfQQmf8pQEJCbO8ATDupRiOXv4mAPJTym0UK/ccYUUJK8SSv+Wmmyx5ZyA9Q/vZo8vIgW5iOk4oYTgSSU+kHEniCktgUUmGjbczkBz7g62kZ284ROkqSdi9zgvCiX9YAFjC7ZraMVpXZzpuO0c4MVR9YOwSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6W7uTX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52779C43394;
	Fri,  2 Feb 2024 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900945;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6W7uTX2/ZbbfQoDpzhjOr+MmZ3pnvxW5acMOasxZ8kGXZKaGKKMppWRyDMTdUvmT
	 Xv5trdikg7H7fVZbPjg0o+GHfCn+/Eds7DxGoNjTywF3xhMFFdGlVT1Rx6UtB5JHN4
	 C5WhBTR5JX8UAwVWENEwWGRw0hNb7W0hFQIl2AIO6mjpmipsh7fw2vK4xlE5llXg6z
	 2W4pQA7zwhjuRW6YJR2wvN1iQkfp59e2phdsq1OVVGkHOU5IwS1NQask0R20q5ck4j
	 tvuqlFRTteQtfFgoH9YLYrILi6k3qBOjOHOFUVuY/9heIuEXLMY7NXyaH0p6kZA+AP
	 zZNVOf2yoH6yA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next V3 05/15] Documentation: Fix counter name of mlx5 vnic reporter
Date: Fri,  2 Feb 2024 11:08:44 -0800
Message-ID: <20240202190854.1308089-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Fix counter name in documentation of mlx5 vnic health reporter diagnose
output: total_error_queues.

While here fix alignment in the documentation file of another counter,
comp_eq_overrun, as it should have its own line and not be part of
another counter's description.

Example:
$ devlink health diagnose  pci/0000:00:04.0 reporter vnic
 vNIC env counters:
    total_error_queues: 0 send_queue_priority_update_flow: 0
    comp_eq_overrun: 0 async_eq_overrun: 0 cq_overrun: 0
    invalid_command: 0 quota_exceeded_command: 0
    nic_receive_steering_discard: 0

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index b9587b3400b9..456985407475 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -250,7 +250,7 @@ them in realtime.
 
 Description of the vnic counters:
 
-- total_q_under_processor_handle
+- total_error_queues
         number of queues in an error state due to
         an async error or errored command.
 - send_queue_priority_update_flow
@@ -259,7 +259,8 @@ Description of the vnic counters:
         number of times CQ entered an error state due to an overflow.
 - async_eq_overrun
         number of times an EQ mapped to async events was overrun.
-        comp_eq_overrun number of times an EQ mapped to completion events was
+- comp_eq_overrun
+        number of times an EQ mapped to completion events was
         overrun.
 - quota_exceeded_command
         number of commands issued and failed due to quota exceeded.
-- 
2.43.0



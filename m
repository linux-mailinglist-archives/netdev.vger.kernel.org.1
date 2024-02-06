Return-Path: <netdev+bounces-69326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A815C84AB35
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E6B23140
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CBEC7;
	Tue,  6 Feb 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXUWAOli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C984A11
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180937; cv=none; b=BuG2mEqyhoRdHfvAcOd6JAtVYhHJCjy2a78PRPGS4fVJHVfBbFw6iBAPULQz01XEuqgV/4UcPqp3VE5phgNf6OQ1t6CwOk1B/89iJb3oP6QQB2f50G1tg7iKN+Y+CnlTUiPIQ6J088/B8aM+2SLf936q4SkGdKwyayYOBq68+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180937; c=relaxed/simple;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrQ3N9WwQPmVCuuIpOagNZUX3Q6oTQFNX7xwW3KAHqHd5eBwZPaFKdO6r3wL63ujzIcSocm+eX0Q/8ql+7xZKjYWTsD0c0WnOW+JfILEHLKfC6WPIco9y0wlSN6CiCMNHTRePobbaiWnUBENI/hdiYdyDS/E5/7y9k6k4tEvEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXUWAOli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDB7C433F1;
	Tue,  6 Feb 2024 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180936;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXUWAOli8awUG+gKyYOMjAAkb1C2MDPARtC0nVgXuRmCeT8IWQ78v5QXscF6/Utv+
	 BvAXNzIxvCh36UE4Q+ZfMKd6ZReY/3ygvFKiAXL4svz//QIcPNBm6n1NG0xx+xWw7+
	 1bCk4u8cKiGsVfR45vgIAtW4/ppBnd7zDOhN8CNoZzg7gAf+WXmxJ4l2+qHkk+L+vR
	 9pcQe9KWnQHNEuwPCG3Z/lCEiB6IucdQRMdPmyBeGU/J0wl3KZy4mBeVGGII9d1HRb
	 c+5jqdncmCSIFeDrlWdof/mTMxWIBC8hys6WoWmQX4DIyEG4CcGvLtaEy8R8N8QC6+
	 IDUk2LbBGamrA==
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
Subject: [net-next V4 05/15] Documentation: Fix counter name of mlx5 vnic reporter
Date: Mon,  5 Feb 2024 16:55:17 -0800
Message-ID: <20240206005527.1353368-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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



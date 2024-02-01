Return-Path: <netdev+bounces-67851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB78451FC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97341F25405
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805A158D66;
	Thu,  1 Feb 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMQNhXk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848041586E8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772738; cv=none; b=c4rfaxBSwASBfSDOuomrjxaU6JHV3tyel2Aa91l4B1DSa6B6XruJB5SU5Ta9KbOZn7zPobgAME7YH1PiFks122UVnGcgpxYtCQFpu0XaKpOEFsBqLZ3R48yYxOKNesBZNRyD4Ybiz+ZseABpxH3pa6lD8esFRBGJdhF+hHbOuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772738; c=relaxed/simple;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8Y6tZNrdsHwH+eTwrkKwK0jtAeTTYsO9YqXVb4D3i9veh+zilJAI2YGRAbGCYHXeSszYMpl/HjOafO64nm5cyGkAeqB5UfCDY478sQkC+377XvPWbPsZMOhVTz+tpbEv46sXLpS8llnFUcJLRTSkvdmJ0MA6rUv7TT4YTW4vA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMQNhXk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5C2C433C7;
	Thu,  1 Feb 2024 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772737;
	bh=ckEkkVPO2+TtiY79VyV5xXKtbNgtj08CKVvwqoCMEv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMQNhXk/ZiLIxMKvQqYRGVD47tRgmHEaJAcuiZbSEO7VkWAyacScMV5M8LeywM+zV
	 cmHRSWn/rf3BiElejQjK8OGcW4M/dFaXRrJ0Vwn5PvbQtodH/i0Skn+O73dGPxGMNc
	 7Ou1M/wM0ae9BX2lcVuLblVF5CV6OYWwVnDhcxlA3DOzzabNEA7i2NBDIhJx3YTfR7
	 agD4+4sEU8fqX7EKlJrtvT7IRqxllyfRn/YVtRDka0QhXp/T12pvzIepesBKjA7YrT
	 dFF8md6e3qAXNIJO5S53hbuBcYf4VH3d2a9jMlW7JtzEz7KQDi3Vamm5UPmEnkvByd
	 1exS7VUgenMQw==
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
Subject: [net-next V2 05/15] Documentation: Fix counter name of mlx5 vnic reporter
Date: Wed, 31 Jan 2024 23:31:48 -0800
Message-ID: <20240201073158.22103-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
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



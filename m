Return-Path: <netdev+bounces-66302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B583E598
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9EF283219
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAD50A83;
	Fri, 26 Jan 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrIA1M2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782050A80
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308614; cv=none; b=B7AHTFc8EHpaj5gcqSgTxbl6cnJBDoZRKtKzTvxbk57jYYTN3skq8U8+x+v+M/IRMc0/RGb9dRNWVjxE7WN7NIKjNEI9HqEWNvdklRiLcTp4egjwzyhoLplhodBn5URiM9BMH3vaX5aWlWr2cjrz5foY6IoZuQyD/KgOfzFzUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308614; c=relaxed/simple;
	bh=5FVi6ukbKSnMweqwpAcYY5gMvB3cT1IYdm0h099DpX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKFy89Uvy4aQQuBAmHcspdS/3WZj1c85dR+U64WUOq+abfiNNwdfmOiwJd4AL4kTY9wbuWJUwfiJfTSHrR6jXJbcdvVJrX/nj9/m0vKV7RqWEYHKQmzJYln4/MFSlkRYH7OyklUOQ8MuuG4TKckoTZ8Ne84dep7c0sVAAo0OWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrIA1M2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACDCC43394;
	Fri, 26 Jan 2024 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308614;
	bh=5FVi6ukbKSnMweqwpAcYY5gMvB3cT1IYdm0h099DpX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrIA1M2V17F47A2RJ07Nm3R/Or38lEdPr6+ZMrsY9GTUrBGQTWgvCfYbLCdx2FQ/m
	 ac5ul/1gXbjvTG2lU/ZB8L9nPABUzjXV19EPF776gBXUR4X2UcqUh+E4HIKTMeVT18
	 ZyCApp00I2qJmZMZL/ue5RstL7/b98WyEb+wNObdJYc5uuuk31FBefET0UpfpAtXFW
	 cGjDFVdXi90hBnGDNqe+Bldv7qRQJQfCR59IEOvyRuVVf46mu6mNHVKFXqZ2dU/vRV
	 XTbF0cgG5qWhpBegpFrwgy8v7nAnA+rahob2pq8CdYcNp02uXHTZUECr3eURl4/qWX
	 vqVSYmgWWuUcg==
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
Subject: [net-next 05/15] Documentation: Fix counter name of mlx5 vnic reporter
Date: Fri, 26 Jan 2024 14:36:06 -0800
Message-ID: <20240126223616.98696-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223616.98696-1-saeed@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
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
index 702f204a3dbd..62a2ac7d6f68 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -246,7 +246,7 @@ them in realtime.
 
 Description of the vnic counters:
 
-- total_q_under_processor_handle
+- total_error_queues
         number of queues in an error state due to
         an async error or errored command.
 - send_queue_priority_update_flow
@@ -255,7 +255,8 @@ Description of the vnic counters:
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



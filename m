Return-Path: <netdev+bounces-146470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C0D9D38E1
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2901F25B7F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A471A7AF7;
	Wed, 20 Nov 2024 10:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-132.mail.aliyun.com (out28-132.mail.aliyun.com [115.124.28.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63C1A704C;
	Wed, 20 Nov 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100219; cv=none; b=qKryEJfC2LniMAUFtd6d9WoqkrjaBZNZBqn26cibxdQyjxyFxnRGsGltPFTA/RGYk7c1hCAxHyDPtxV0fSRqUhG2xnfsxiYsZWf4RHPaqxjwHjd5H4VbJZn3T3+p4wzRYp2EGsLNQfUKH/M8QHJPCbGnYCSgUFMoSX5QcVLIKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100219; c=relaxed/simple;
	bh=gu6UkrKnbpAcYBpjxtVBY+QIYIRJ7uLyqa1Ei6+AVF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEznnRuJpR2avOXHDxONrD/11ISVJeMwptuggV6WkGfu6uKTl9jXTmRTDV6gVmyY1Tu1rlk0ePjzalw9Ok4DTYjK+pbgt9/8tqfOjFhhMWuW41zyHUNBHipseA7hJOD5KZkskWgVt9mJXeUZMn9jQYmy0mwA0jckvdyZ+lvtgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppfz_1732100208 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:48 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 19/21] ethernet: Update the index.rst in the ethernet documentation folder
Date: Wed, 20 Nov 2024 18:56:23 +0800
Message-Id: <20241120105625.22508-20-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the yt6801 entry in the index.rst.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 Documentation/networking/device_drivers/ethernet/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 6fc196149..f8b88408d 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -46,6 +46,7 @@ Contents:
    mellanox/mlx5/index
    meta/fbnic
    microsoft/netvsc
+   motorcomm/yt6801
    neterion/s2io
    netronome/nfp
    pensando/ionic
-- 
2.34.1



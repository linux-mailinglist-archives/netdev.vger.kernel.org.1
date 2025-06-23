Return-Path: <netdev+bounces-200427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E8FAE57DC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AF1172B1B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5722F164;
	Mon, 23 Jun 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6p89t7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AB279DA7
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720648; cv=none; b=aK17qbbjXyz3cBL2egS72kRTVP81/HOmrQTJYN0GrQM08xvaNgdlZw20XlqUzvXYZuGwIEnWA21O9Agg7AYXYM+J7zoV2xBSaSfgMB1euoebIc0we1XVaKhQZCDQpmFpN7jxyPMt2M+lLXd5gYhXbf5GniyGsYWTKNi2L0yipeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720648; c=relaxed/simple;
	bh=uIUngXMdMaPWsTSfVQ1H32iCN4bRh7/Ci3R3qbB5lmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjBLHUu9j/E1SQ2Ck2B53QxTeBjxaKJKmfHPL7FzLAUkizhfXTkxuVfJKgFFpvK61YkuZyFaKRkDDeXenS0QEUKFjbhDHN9ynqBVb3MVMtUuhRxtlKSlLw2z/MHZVwVYNa2kRnL/vAR6WO1E0k1VpGK/XyxG5HuTctvlX7fMEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6p89t7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C31C4CEEF;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720647;
	bh=uIUngXMdMaPWsTSfVQ1H32iCN4bRh7/Ci3R3qbB5lmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6p89t7F35xAfN1Ts7ieBTqGIOxTC2a8q4/V5tyiChT77L5Pn8lkED2F+GZk3Jl3i
	 NwwnOc/zSz5EE76v3ovxzOiQXAc81PfxuNYMZR5s1uwC3uDBQqGCjQqBS8efCsLoy1
	 xGjpfvXhhFAodsKSHHeySO068/Zoy8ICezOd42nmcjf0OCo04oj0LXhi0GYTk8T7yd
	 6qDLBZY2YKI/y/OT8iHAVJFS7f0kTO3+dXT9n3pUCm0nYLo6ikSr3KGDY1bnOyLDyZ
	 mE/h0p2alGpfvP5xEcNSP9Z2tIZF8mUndmeTymm8IKE9AYrm2Kp6c/zNz7Ou09uZkW
	 cZD+qtEZlnsHw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 7/8] doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
Date: Mon, 23 Jun 2025 16:17:19 -0700
Message-ID: <20250623231720.3124717-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ETHTOOL_GRXFHINDIR reimplementation has been completed around
a year ago. We have been tweaking it so a bit hard to point
to a single commit that completed it, but all the fields available
in IOCTL are reported via Netlink.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/ethtool-netlink.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 08abca99a6dc..07e9808ebd2c 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2451,7 +2451,7 @@ are netlink only.
   ``ETHTOOL_SRXNTUPLE``               n/a
   ``ETHTOOL_GRXNTUPLE``               n/a
   ``ETHTOOL_GSSET_INFO``              ``ETHTOOL_MSG_STRSET_GET``
-  ``ETHTOOL_GRXFHINDIR``              n/a
+  ``ETHTOOL_GRXFHINDIR``              ``ETHTOOL_MSG_RSS_GET``
   ``ETHTOOL_SRXFHINDIR``              n/a
   ``ETHTOOL_GFEATURES``               ``ETHTOOL_MSG_FEATURES_GET``
   ``ETHTOOL_SFEATURES``               ``ETHTOOL_MSG_FEATURES_SET``
-- 
2.49.0



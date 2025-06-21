Return-Path: <netdev+bounces-199998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F9AE2A98
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76547AC2E6
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A7C221FB2;
	Sat, 21 Jun 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkAcVEp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F7225A3E
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526396; cv=none; b=tx+p5Z5MWUmMhL8+Jzjhv/PaxVws0T3sRoWGV6K/2dUQVZsiU9n42n9bNx84zbTEQYvEgqAYR1TcVm7vwaunVu3PRk1SlUyxtoc3mT0vALBaMMr3KjEZm2Dl3anSH3CDoCFN0oiz+F6ShTpxzwp2o9gAnaz/gBkBGju7jGPVCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526396; c=relaxed/simple;
	bh=uIUngXMdMaPWsTSfVQ1H32iCN4bRh7/Ci3R3qbB5lmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYyB1Hj8pQMMD28yo8+2rWs6se071j6Fz0aqgkrxu9XPwap/k3X3Ps2J13EW9vct0CwWVk6mFYJ16FQI9j/nD0CReL943H0mkleRaA5RieQQDcWeUM2thobjorTOyAujy/yCsBbdjt2Vz76i8Kj1fXsWGOwe9CKqtsKY6x9+x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkAcVEp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89796C4CEEF;
	Sat, 21 Jun 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526396;
	bh=uIUngXMdMaPWsTSfVQ1H32iCN4bRh7/Ci3R3qbB5lmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkAcVEp1dDGeCSInq3zXEcdV70l6xQEguedFMN3oADaO0SEFXzbco/2FyaLGMik4m
	 mQaOitwTEVeIxjcmnxYG5tcwZcRdCu0ozRENfrQ2EhjzE+cs5xUsRk9+0mwkGEK1Tf
	 D8xisHmThYWQZ0lQp8tGiIYtTPNshxtHO9WPWCXmXJS131Cw1J6rxZnqgq+ULLzY+p
	 Ob1FfrdCgAzRyc+2RW2j7AG+tAjuXXhHb5p8dmaHyh7D7Kpg39nj+HyXWb7x6xB+q+
	 rgCTzZ+B21GXrwyJGyu1ZP66THPNDGOR1tWm1sSr5rzNUKz3+tuK9zyFrZ9aVDQhIz
	 P3TsuMOs2veoA==
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
Subject: [PATCH net-next 7/9] doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
Date: Sat, 21 Jun 2025 10:19:42 -0700
Message-ID: <20250621171944.2619249-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
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



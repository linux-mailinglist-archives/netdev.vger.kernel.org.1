Return-Path: <netdev+bounces-166724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380EA37106
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 23:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EA63AF96E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB919ABAB;
	Sat, 15 Feb 2025 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goXfwj2j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2151624C2
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739659938; cv=none; b=NvRCFc94tlr4W/7zjsAbdu0jNGRPL3S2AprYEYcAfewj4Ar2XsMMRdHF2yx5x+caH4XEz6bR+nMCg64pasuaYRcMFE2RXXy98e4ur1cmWlLf7KebZQ9b5ERzS09h36jAzFpZ4mmF85cm2VLx6psjINrNOz5j7rFQZTVi7pyO5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739659938; c=relaxed/simple;
	bh=X/yIrN+M/wj+6nMPH/IGJ2ATiwbdCNcXkzon9vGhX8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQrunpmKtNg5YIBPFez3ynSNJoX/yTHTjq6q0tvcL/JuIV0hWTYLEGxq891XsjnnT0uAnI3idFKEyU8FkNSqh2ZjYwzBNk6uPhcVNeffVoFDGiTQ4bYCdWppVa9f+i+f2QHqL8O7AbhsTHsFEyLWNToXIY4KiGgIJc7w+skX2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goXfwj2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C067C4CEDF;
	Sat, 15 Feb 2025 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739659936;
	bh=X/yIrN+M/wj+6nMPH/IGJ2ATiwbdCNcXkzon9vGhX8o=;
	h=From:To:Cc:Subject:Date:From;
	b=goXfwj2j+MutVzllX8YtxN0jyO6XYBF7QyAlbWFSIBKW2QwhQ+yX28PLDOQC2bXk8
	 mTTKGOhw+BUBuoe68UaAxOnA+suXEOdaJtuAoifFFkN8iDqURwA3Z5+x0uMSzPvmtO
	 USLQoWVt/YxtZDmLUeF5+s7ED+od+/KfHwPPiShVXXUq/XVrFM5/aKp24t51OLjBi5
	 E+3SmYIbmFM1EkHhqKR/JrSW8huw8+Az0JE/NOykZLNhly4/v9sKNtbBfoJeoPzf1D
	 jShYSO2HE3kQw2PEPxOmOYLyZSk8BjpGkzVtPunxa60KF4EzobNaF7ilka8qiZjHu0
	 seFDfnvQXl1dQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: create entry for ethtool MAC merge
Date: Sat, 15 Feb 2025 14:52:00 -0800
Message-ID: <20250215225200.2652212-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir implemented the MAC merge support and reviews all
the new driver implementations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index de81a3d68396..e701073d87c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16477,6 +16477,12 @@ F:	net/ethtool/cabletest.c
 F:	tools/testing/selftests/drivers/net/*/ethtool*
 K:	cable_test
 
+NETWORKING [ETHTOOL MAC MERGE]
+M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+F:	net/ethtool/mm.c
+F:	tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
+K:	ethtool_mm
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1



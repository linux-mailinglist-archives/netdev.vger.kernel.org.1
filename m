Return-Path: <netdev+bounces-159269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC927A14F4B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E3E168317
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427E1FF1BA;
	Fri, 17 Jan 2025 12:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98751FF1AD
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117584; cv=none; b=cZyr+aZ91/qDdiWdpvFn5DdUBumYDYCQFyQUXBV8aLYDx3ebavu4izYMhHk0lT0tYR0Tl51y+n/VZyhJteLeiV69xPmRAsKs8dvFVkfan4uWH6o8MbwrzTBmZFgQs3C2RQ0xDxaF8PkEzIMnvZPmlIkg5vQmRbFgoBPTspb71AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117584; c=relaxed/simple;
	bh=IhrNNazByRI4Qn4Vuo9O8NENc6EPgz4xHbO+Oyw9NcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLkMZwl8mCxCiF7soxJzX9Xck3ukrvuMCyBnR8o2VMTpD5/plf2pNK+5h9lb2gUklgsHThUYwR5Mcm4oOVDMekKdeH0ZMmQuNWrQ7rYn/4BzJP3Qcd6NsnK0vPGxp507EyDGxoP1m5d+SeovAoKqQK7zw0uSsNHxSm8KfoV9fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5973c90d8a96Dd71A2E03F697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 617C8FA367;
	Fri, 17 Jan 2025 13:39:40 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/10] mailmap: add entries for Simon Wunderlich
Date: Fri, 17 Jan 2025 13:39:07 +0100
Message-Id: <20250117123910.219278-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map the defunc mail addresses to the currently used mail address (listed in
MAINTAINERS).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 .mailmap | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 53e038f5f654..efabe03f7849 100644
--- a/.mailmap
+++ b/.mailmap
@@ -642,6 +642,11 @@ Simona Vetter <simona.vetter@ffwll.ch> <daniel@biene.ffwll.ch>
 Simon Horman <horms@kernel.org> <simon.horman@corigine.com>
 Simon Horman <horms@kernel.org> <simon.horman@netronome.com>
 Simon Kelley <simon@thekelleys.org.uk>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@saxnet.de>
+Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
-- 
2.39.5



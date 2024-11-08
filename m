Return-Path: <netdev+bounces-143412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CE9C2553
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8681C21A8D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E721A9B2F;
	Fri,  8 Nov 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="tnj/yjbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZlI8QPy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92429233D86;
	Fri,  8 Nov 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092865; cv=none; b=ccpHjhJI9SRZg5WChUPw93TuPcFFn13gNLFGQQ3vZO4DS/XWXzztloMyDq2Y7S0vc8orHadIp5iWiBCjwzRaRsh7WMPmBFVXNEYpPwhNCEom9d0/YYwZsFffmdRqy0xZbqGJlWYF8tbt9qH86uPmjJypeSkKZ3qcDHpQKtkIFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092865; c=relaxed/simple;
	bh=9RFCnV1HA+JAMGMxBOD4CMeBoBWK3KP2OGb0KFop63E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPoDkhP05sC0pA9ovHLwlhTGQESog8/NUdCG4bxxBVWhnlP591e7rzcoV24ar5q+GJKhKh0MhyH0pfIRBWMv9LWLwbcfdYp18/bqMyNejR+/I2lhhK5zyMWpdlIB3k+ubSemmCMWY78HdG7L7cuoeZfatzkzUwCJOM/lcED9xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=tnj/yjbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZlI8QPy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65A2125400F5;
	Fri,  8 Nov 2024 14:07:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 14:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731092862; x=1731179262; bh=HiAM5eMjVhyB5MoM7JC3x
	XR5NMnN7n646cNyYK+b9As=; b=tnj/yjbEUwceOgjbH5h1PeM60rKs5nTVEuRo1
	Wa4gP17ReZCArCBvz67XlfdysP+YLhltEkjWvhTiWLkdXD/7XAx3CWlhX8O0EELi
	MSsUdU/xb83BX/DYB+/91l6Ea31LGMJDG86mpHL09E7sNO7/8FRGPP5JrFxpJda0
	haWltxdnVAqOargkV5/u0kVQ4EYBAZpjFRlTiBrPlznRkHdFiRswKI2ezmO5qpWP
	dig6fJkZOR/HumvxKKhpmxgQbSsZyuhYA0Rnt8v7MYbCTGPwHnRB7mNRlKvRGQXz
	OAebEj9HrzCUvAI+ci4xG/6m5uqi7W2k4QfieGyUB3YaJp0rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731092862; x=1731179262; bh=HiAM5eMjVhyB5MoM7JC3xXR5NMnN7n646cN
	yYK+b9As=; b=MZlI8QPyepJsdYqP+8iuijG2mdHQWs+r8lBtBgdDxviK5iBVWzs
	axS+u2mCnZQD6GbLQmbojq/hqR10laxjSYJZz8uZ9iMdb+bnM6Mb7hVKp1V6ZTpc
	iQSjvITAD5WC05yya3aRZj0ZMwpw+xwCXnEeLTYxQ6nZZnLXRgyoHi7FHkpVLpWS
	hWLG1sxWdkftzt1kIR/uHbkOb5iNOatUq0S36qZOfaSIh+hB986zafYBa2Wru0EL
	7UnXA9TFrNEN5x3sfrDGbb6DPTWuBso1JHmLU1vFBbTENiYPVG8iQ3SUOpKyLdpB
	3wbstrLcMmzeW+BwJ1jZRiyyNR77wmZQaFw==
X-ME-Sender: <xms:fWEuZ0gCh9ga0YbktLacWKLgrjmTAaZvI9eKl4GK8aH6FnE601ZPjA>
    <xme:fWEuZ9DE3k-moOOKOdZbkL5mJP6gSteTuJImj_qfBzC1ByM1HJDjLx8JM9jjTmADV
    cR9uIzgZQTwUsYYhA>
X-ME-Received: <xmr:fWEuZ8EEze2dk8AXTGpC7FlYLYazYuBA-R25kkJH1TWv_bJXeTn1GGh78EpbJWLHObqLUqfJ3oATY32MTywDFSkjb8isavV4p2NjJCWdD00ZVL0rOvNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmihgthhgrvghlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrthhinh
    drlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fWEuZ1TYX3f8G8NR5So9K9FRwO15b-rJNEYFunddunX4kolZQ0rpDQ>
    <xmx:fWEuZxxY3nG3AE-ditLud_rtSDAroUqZcJrC6HBNYP59k0icrqtj5A>
    <xmx:fWEuZz5Ii0Hq3AbLRj6Pd7156JrsplK1kcmTVBFw3xMMCOeglkaQdg>
    <xmx:fWEuZ-wH-9r61teeYOAHzBzc8VHsNZDpZLPP_toi7DOWneSr2rOPHQ>
    <xmx:fmEuZ2opO6Nj7z2dGyr4qbjMwF5b5qTIBL9udWNwWt6di9vohkHsKLzh>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 14:07:40 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: michael.chan@broadcom.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	martin.lau@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net-next] bnxt_en: ethtool: Supply ntuple rss context action
Date: Fri,  8 Nov 2024 12:07:29 -0700
Message-ID: <384c034c23d63dec14e0cc333b8b0b2a778edcf1.1731092818.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
contexts") added support for redirecting to an RSS context as an ntuple
rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
codepath. This caused `ethtool -n` to always report the action as
"Action: Direct to queue 0" which is wrong.

Fix by teaching bnxt driver to report the RSS context when applicable.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cfd2c65b1c90..a218802befa8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1187,10 +1187,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		}
 	}
 
-	if (fltr->base.flags & BNXT_ACT_DROP)
+	if (fltr->base.flags & BNXT_ACT_DROP) {
 		fs->ring_cookie = RX_CLS_FLOW_DISC;
-	else
+	} else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
+		fs->flow_type |= FLOW_RSS;
+		cmd->rss_context = fltr->base.fw_vnic_id;
+	} else {
 		fs->ring_cookie = fltr->base.rxq;
+	}
 	rc = 0;
 
 fltr_err:
-- 
2.46.0



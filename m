Return-Path: <netdev+bounces-143831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E149C4601
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA71B21828
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E465155A30;
	Mon, 11 Nov 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hr5O2KDc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRijmbTS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D01139597
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353996; cv=none; b=ViMtcercm+k0qCaGhJ/MRj8kPmQdk4juVTFvVEvNAWHebaPb2dfQvejxP3Bm//NGQc12rrWp6PCuiLw33rlS08d7qXier587xag5Ow1BqC7Ggq0owUPLeF2YBBBKQlzZBWdUty0bHHMeLljM0EWJhKsaWBo1OcQWVPCuy0nhIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353996; c=relaxed/simple;
	bh=lCV8NLDKnqePrhHOL36FLO7s0ij1OJAiFGOJN5LI4cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeS6X1DYMw4OHc32miDH+VTBtQtV+As24ixU2l/ssd4LuuWhZtT9GazwIIiztdyU6YeT0e3UVHvywHKotVr8xHpxy3X6N/XJ8ha8UTYtf3rl9TZ33/JdeNLi6C0POJEoWMpEBHmBZWUPbiZCvwh1EkgUJTFFvSISOd5ivMsC91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hr5O2KDc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRijmbTS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0C5425401CF;
	Mon, 11 Nov 2024 14:39:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 14:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731353992; x=1731440392; bh=ihst99hvpncEo8/Wsqcei
	vluzwzLwXDCnFLs7FhUpCE=; b=hr5O2KDcJ0wGutTYlO8OajKSG/e2zgaHF6DW0
	2R6SZqLkk6AmXH0xSIYI1wF6dX8yPoQKrbRFcR9+CMf9EqS4sRt3kNgzKRieRi/g
	DSULBRCGbEOScqOLccQ8+wb65QI8482PkzvyDd5RvLNXr1SizKzAdNZu+enV9jtW
	P7TwLDzqmwTnE5odwgCnhInhVHBnGvAY/FIafTO/cZ/KtEXDeKrXfe/OxSUYCSUa
	RAVFqZbURTApjHDDSnjwmrMSOsSPBOel+K6Y9uCmf8aF7d9zkq3M0rdeFapQHbTc
	UmVt1QnwkG06fDvaDdkWPwmu84/0LfUfhivUL6l8ZH0qz59pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731353992; x=1731440392; bh=ihst99hvpncEo8/WsqceivluzwzLwXDCnFL
	s7FhUpCE=; b=aRijmbTSsvHdfzd04zHZ49A5fcxERoXTUkunFV85atFRcEVsSot
	72OVJyagyNvXwSnjfTCBOlN5qryy8bgAy//Hq20vJJ6yIGNRNIbFyl0aSYjIQVvb
	Nv708utafkVP03B8ezmrhyKH+qNfmPY86P+pn3ClPQDNvN5DOv4qnVcZrUjJNh50
	Dw/6gOCoXAt6zUC21hDy4zvuq0uGGcx7YL9pzmx2Ehyei3adON6K/ZVZpeV499oA
	Q2JiiKvkxrco3RyAZ36Orr+fr0LT7v7mJBzf3k/n9xr+KO7dV3fgZyntDjrdo97T
	WdCpyZQrR8nZiJ+DYx9x+4o/sCKTBwi+A4A==
X-ME-Sender: <xms:iF0yZ_CcmpJXyHi39tcnaQyeIeH9GmZlaA6EsUfAcoMaPa9mp8aJ4Q>
    <xme:iF0yZ1iOCmoz4WX8VrFaKpmXjgf_mm14S_-xtPUcrWY4TO6VrbYCKu0fejplZHDsB
    Z4wfpKSM13AdaJGIA>
X-ME-Received: <xmr:iF0yZ6kD4iLBasbA8hF7SSoJmF9dZ5q7kKMZaQiUqta6_-R8p2GVq-LMgGrQ57_oDgeT-1iCDlSjtW5HurSL5iWt8ET6oF-bAXhPtCk6GIEHl0PnQ2qP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtth
    hopehprghvrghnrdgthhgvsggsihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopegrlhgvgigrnhguvghrughuhigtkhesfhgsrdgt
    ohhmpdhrtghpthhtohepjhgurghmrghtohesfhgrshhtlhihrdgtohhmpdhrtghpthhtoh
    epvggtrhgvvgdrgihilhhinhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvg
    grmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:iF0yZxzRNBz7oK8tGaZAu5BZVo80zvSirNBkS-YkwEOiawuwEYEWLg>
    <xmx:iF0yZ0T1b8CYsUR5O7KtrAh7Yz_qNaG-vq5WMtg_GFmEMPl26i_dBQ>
    <xmx:iF0yZ0YinRmJGRtCDQypFPrXJy4dWh1mE6F-MLGaTKQmtohlDxMofQ>
    <xmx:iF0yZ1QN2NPQu_kce5tkWw2mcPvox8sj-n_QYUhpaUmrDHbXZyckvg>
    <xmx:iF0yZ99w0PDlJAFCfhbvAzQI9lqzDuCUjOyR-Ww_lMgbEH_OqbtQh2Bd>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 14:39:51 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com
Cc: netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC ethtool-next] rxclass: Remove flow mask inversion
Date: Mon, 11 Nov 2024 12:39:35 -0700
Message-ID: <ca04ff95522065d10c846cdee3787beaf9d226a2.1731353933.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, all flow masks were "inverted" such that a set bit (1) means
mask-out and an unset bit (0) means mask-in. This was originally done to
fixup the hardware-TCAM expected format (according to Alex).

I'm sending this RFC to check if the current output is still desired.
From what I understand, the kernel drivers see it the "natural" way (set
means mask-in and unset is mask-out). So it's unclear to me who/what the
current ethtool output benefits.

I've CC'd Alex (original author) as well as a few folks who've been
helping me dive into the RSS contexts API.

Before:

    # ethtool -N eth0 flow-type ip6 dst-ip ::1 context 1
    Added rule with ID 0

    # ethtool -n eth0
    32 RX rings available
    Total 1 rules

    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: ::1 mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            RSS Context ID: 1
            Action: Direct to queue 0

After:

    # ./ethtool -n eth0
    32 RX rings available
    Total 1 rules

    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ::
            Dest IP addr: ::1 mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Traffic Class: 0x0 mask: 0x0
            Protocol: 0 mask: 0x0
            L4 bytes: 0x0 mask: 0x0
            RSS Context ID: 1
            Action: Direct to queue 0

This patch was tested on both (and only) mlx5 and bnxt.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 rxclass.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index ac9b529..02541bd 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -12,14 +12,6 @@
 #include <arpa/inet.h>
 #include "internal.h"
 
-static void invert_flow_mask(struct ethtool_rx_flow_spec *fsp)
-{
-	size_t i;
-
-	for (i = 0; i < sizeof(fsp->m_u); i++)
-		fsp->m_u.hdata[i] ^= 0xFF;
-}
-
 static void rxclass_print_ipv4_rule(__be32 sip, __be32 sipm, __be32 dip,
 				    __be32 dipm, u8 tos, u8 tosm)
 {
@@ -104,8 +96,6 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp,
 
 	flow_type = fsp->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
 
-	invert_flow_mask(fsp);
-
 	switch (flow_type) {
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW:
-- 
2.46.0



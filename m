Return-Path: <netdev+bounces-143414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F59C2598
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AAC285A62
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC81A9B23;
	Fri,  8 Nov 2024 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="K7MbjZGV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mw0UEkwm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695B233D79
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094380; cv=none; b=byw8uAipFBC1nTX9+zw7bCoTb/RAjyCab/CF9Si4HzRKBgjeZYUfGGXKTTPPy84mMJuXTPPl9FKd1TUnxgalU4VkKoikSDdCcEaVR0XSLoUXebm/BOXCo5xXzK5RG/bZjwcKqJ2zaLKCbRXekKj6tDO2WZnloenWHlV9CDiOoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094380; c=relaxed/simple;
	bh=0GdVltL3jaD6bStxPRTomunDRc3con7IchwrMsJMT/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGzrEVmBEkYwZqRk8sQigzKFuEWxn/QpgqVL7qSAbTmxMKCQoWjRXn3NzkhJ2rJb/kDUBhyUao1jOVrzUYOfla846HvpQSj3cud+smZ1lAwMGMlpuoFrU1P6uxzTaolgdMCbWO6T56wabOP8oWbEwq8OKyCnelhE7MXXsIWgN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=K7MbjZGV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mw0UEkwm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DB16E11400B2;
	Fri,  8 Nov 2024 14:32:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 14:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731094377; x=1731180777; bh=j8gO6i/ziwPrj//ac+Beg
	sPerMSppQVNjiwokAT73KM=; b=K7MbjZGV6kJiUDO+MAOiptWLL8DGjMaXK2sNU
	xAa/NEk9iWJv1rZJr4MRz2081V50cmIajAG4NTerEHpNRO7rkOoQ3Mb8cywsDnrD
	hYTObHhQUji49mZ5NFFyLHGGgMoNLGwH22093PQs1DKyEe/1JSLuk1/v3iMloeBf
	4bulR0C/xyxGdWzmSrRVxmUB7QPG6emgNNEezQNbWewGJY2zgJSuWVgnVw4URTur
	X4/Jodf88jwwBTAobcNubcNN7Pzt6Yo6EpWyUhr5SbvdssI0dXnEA+P4sJrM3p31
	DOp8PW4OfG1+rUtqPyzDXImeHzdAnH24DnoKGiMrfMlpw8yZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731094377; x=1731180777; bh=j8gO6i/ziwPrj//ac+BegsPerMSppQVNjiw
	okAT73KM=; b=Mw0UEkwm7c2DaV8i15mirXzsqaYdtLkBGJcsJW3ytHLxlKlEx+N
	apmnaSk7E9cT2GdQXZhV/WRK72WrWDmw+wNmq3R7N8roUGfoJcHpngsfzpgzl9vs
	u9mXYssEshyAbBwhw1Du91OWhlI8ztwNEIJhaRBUCP/S6wePkmD0yLaWy8d+etHR
	+EXI9jc+Nsoi1En36OMxvLw5ocFF7UyJ4R9Gg55msc007fISYF42Y4WGDFWO8QXT
	TH9aBl6E/Uizwg0bofxxdVKnG+9owQ/3vK56nRoB2u63bZ8fWqYRBlxKO0MuqdPR
	quNDmwA8qbQdvwSEzLTt0B8d7fi2V0enU1w==
X-ME-Sender: <xms:aWcuZwZuonxn6iEi8slVCDKoA2pCpQUe0QwcR59xn-kFNdr8I5tkyg>
    <xme:aWcuZ7ZYgOkZQz0HJbTZfmljCdNFw4zEgg9wPro4R-_clZCD8YnjSiskN1ffVun1M
    JCO6UOmklvXVadWiQ>
X-ME-Received: <xmr:aWcuZ6-hgU5SANB5JLZLa1J4kTOzqPR0BrGek7fQOhNHdnOoxFGDrnwUfgSWsi_eiO9EL7UzzsIdafzcTqnS77T_7TbzwUu8NUnkYnJCh8IwIQVKNHj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmkhhusg
    gvtggvkhesshhushgvrdgtiidprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtoh
    epnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhn
    vghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:aWcuZ6p9rPjgDRwvp6iQ3meVZAGHhxnOMKJ6qwEhBY5zjqLnSl-cKQ>
    <xmx:aWcuZ7oBVFt9IKh60FCPlwT5bdu4vUyVVNl6U0qy6bnnulPPNTokEg>
    <xmx:aWcuZ4R0sMCd4mfyDBAqx4pNAy-YvhUFb--_lPQXIXCY-dgHCY1VUw>
    <xmx:aWcuZ7rFHehka24PiJAmB8mkosuuHMrWfuBBkkbgdDGWf2i72kHQIA>
    <xmx:aWcuZ8dgP7Abh8-4c0BCIB5dGV_X5fJI-1vMI_1Hgjrv1gilitjvDPxd>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 14:32:56 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	mkubecek@suse.cz
Cc: kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH ethtool-next] rxclass: Make output for RSS context action explicit
Date: Fri,  8 Nov 2024 12:32:43 -0700
Message-ID: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if the action for an ntuple rule is to redirect to an RSS
context, the RSS context is printed as an attribute. At the same time,
a wrong action is printed. For example:

    # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
    New RSS context is 1

    # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
    Added rule with ID 0

    # ethtool -n eth0 rule 0
    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: <redacted> mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            RSS Context ID: 1
            Action: Direct to queue 0

This is wrong and misleading. Fix by treating RSS context as a explicit
action. The new output looks like this:

    # ./ethtool -n eth0 rule 0
    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: <redacted> mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            Action: Direct to RSS context id 1

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 rxclass.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index f17e3a5..80d6419 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -248,13 +248,12 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp,
 
 	rxclass_print_nfc_spec_ext(fsp);
 
-	if (fsp->flow_type & FLOW_RSS)
-		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
-
 	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
 		fprintf(stdout, "\tAction: Drop\n");
 	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
 		fprintf(stdout, "\tAction: Wake-on-LAN\n");
+	} else if (fsp->flow_type & FLOW_RSS)
+		fprintf(stdout, "\tRSS context id %u\n", rss_context);
 	} else {
 		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
-- 
2.46.0



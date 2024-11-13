Return-Path: <netdev+bounces-144272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BFC9C66DF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244D9285F36
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3266433AB;
	Wed, 13 Nov 2024 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="L+22kipD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zi7N4RSu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B7433A4
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462359; cv=none; b=iOd8Qx70Wkg982M7mzDunKRKWHQDNHuWy4gYTcPKsdb1oGqUaDeJt5CLS9ysc9mc+hfpWKKeIqC1lweM2HT3yMSMv8xKyRmmwb/eYY7V+4BAQgie/oWhAw5ucI4eyDbXSloqurd9M1k6VX91Dv9ZDqolDm6bnRVgD/BGdHb8WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462359; c=relaxed/simple;
	bh=KYxTX5cFG2dIKaro9zXrC8CiwxrY3+5IJ0gOTH6hmhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phF//qhsuNxDHOlIN8/2kfk/cqIjS1wf1XGjNuPKKQ+p/vrg2rvYlOqAm/MmNQpgV4LBJ/9cUUfWQaGtSQ6iLzL0bMd3NdPiM44ympedYYZuCki0o+oYkC2f81FDFNKW6lvG9Qe0C5kzhrOnYDolqu2EXD9N/17o3aRtyCWvReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=L+22kipD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zi7N4RSu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C36271140113;
	Tue, 12 Nov 2024 20:45:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 20:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731462356; x=1731548756; bh=tcHZmpQZpFXvvp/v/7ORY
	2Q66bQuG/nW2Fbf0YDwJKw=; b=L+22kipDLo1BOwHXloU1iB3UtNGK0R15PIPfE
	v9Jb2mvQgaokeuYi0QNMRHbKogRbQBDOENL91MMs2xSTQSWg06C4RelMvhGu2IwJ
	YT960w04q+qIls2Hkal1iJNrW8eUbeSM68T5hvyxNRHfXv2ySDkV/swqxRph0CeD
	w6/KJZr/nkAJx/nz9+TRs08tjAccgBcO+2T7cX5RLj1yAy259PKQ2QrixdhlL9N+
	ERp78oWXbnhu6FnE3toAuKrAHgq0S30u4OejsJM6h38rG7MGG/DI0UDyx4x3BTsE
	b9oXr0Z6AEfaj90jfxfTbI5KZ3XQNAzsWkeA2NfTF5bF9AO1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731462356; x=1731548756; bh=tcHZmpQZpFXvvp/v/7ORY2Q66bQuG/nW2Fb
	f0YDwJKw=; b=Zi7N4RSubdZhVRt5all5QUYv4zFk8QS+oSrVDcpBDP9Set4ojUK
	bTRTn/02l6cWEkXkdpGD4Oo2Udf/KBTNFjrlG18IRbzm7xObITvybQqzS71sOOWi
	X0CpvQOTpqVqLHr+CrJxN8aEXwKFKbfjXwu9XSb8pRZY2SGIvBgZ0YtwSZiIbi1c
	/RJuudjsjLUZZkKIZiXMOpaqXLFTgzruetwKDdJ6ACSr/ayQZXcQGho7jwSEkLFE
	INp0kTsjofU+aQ1yHHqS/GJmGiEVjF6Ix7FimUmXRilYdNSg604azRd8l4jzBgdT
	tGbLsAO2Ph+RWUpwF8blpHePOayD4rKntiw==
X-ME-Sender: <xms:1AQ0ZwYCAZ9ZXI1kqlodu5G041rP_HFym1Idj655H4Qw3S6HMiZA2Q>
    <xme:1AQ0Z7ZcvfQ0exHpQAcvkEE9ahUKagwXClJU1cMk62rDTE9WiPBPI25YEzr6WJCC2
    Ic4YvTg34KS_C2Hmg>
X-ME-Received: <xmr:1AQ0Z69VFJmSx6d6Oaf-c-9ZfNajrEiJRd9kKnEtGgcYUdebPTMO5i9EvCPxbioRI40A8QJQBYZcA9YYnfo0XUh42UzMcynjCVbRUf8w0a-wGqqV-0sb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvge
    fgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvtghrvggvrdigihhlihhngiesghhmrghilhdrtghomhdprhgtphhtthhopehjug
    grmhgrthhosehfrghsthhlhidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdr
    lhgruheslhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtgho
    mh
X-ME-Proxy: <xmx:1AQ0Z6oh23YIExOz3F5Gi5stExN7W9g3T0JKuyIuMtqa6Me7OUprog>
    <xmx:1AQ0Z7rVhyw54Lcu5F6u-tKIZqf_xEHopAAp8gHFwju6AooOjvoypg>
    <xmx:1AQ0Z4S4OdTijkIm9oC4UnKBFxAha1xBZfFeHdvJUadpBbATFTfvIA>
    <xmx:1AQ0Z7q5pzwSI7AjOcmzHQLJ26cMa0ws4eSeEBlrLXNAcBUDGbBPUQ>
    <xmx:1AQ0Z_cH0LGtt14IkKbnIxjDuT5bZwzFvrLxKWwQNhzEyINv_1nIiyai>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:45:55 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ecree.xilinx@gmail.com,
	jdamato@fastly.com,
	davem@davemloft.net,
	mkubecek@suse.cz
Cc: kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH ethtool-next v3] rxclass: Make output for RSS context action explicit
Date: Tue, 12 Nov 2024 18:45:43 -0700
Message-ID: <e9de21b76807da310658dbfd46d6177c1c592fe7.1731462244.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently `ethtool -n` prints out misleading output if the action for an
ntuple rule is to redirect to an RSS context. For example:

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

The above output suggests that the HW will direct to queue 0 where in
reality queue 0 is just the base offset from which the redirection table
lookup in the RSS context is added to.

Fix by making output more clear. Also suppress base offset queue for the
common case of 0. Example of new output:

    # ./ethtool -n eth0 rule 0
    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: <redacted> mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            Action: Direct to RSS context id 1

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes from v2:
* Change capitalization and formatting

Changes from v1:
* Fix compile error
* Add queue base offset

 rxclass.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index f17e3a5..1e202cc 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -248,13 +248,17 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp,
 
 	rxclass_print_nfc_spec_ext(fsp);
 
-	if (fsp->flow_type & FLOW_RSS)
-		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
-
 	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
 		fprintf(stdout, "\tAction: Drop\n");
 	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
 		fprintf(stdout, "\tAction: Wake-on-LAN\n");
+	} else if (fsp->flow_type & FLOW_RSS) {
+		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+
+		fprintf(stdout, "\tAction: Direct to RSS Context %u", rss_context);
+		if (queue)
+			fprintf(stdout, " (queue base offset: %llu)", queue);
+		fprintf(stdout, "\n");
 	} else {
 		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
-- 
2.46.0



Return-Path: <netdev+bounces-141795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F49BC437
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC061F21E02
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FC18873A;
	Tue,  5 Nov 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Zm/1jv86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EldO/XTv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4671367;
	Tue,  5 Nov 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780018; cv=none; b=EuVTDpBxgF9OEnHuaHJQrtG7cCYK9pcKS4fXbGdpX409q/Y8L2g+KfOSFTyanp8SOXVn2lmfdTq/5CgXS5Xc7/vSSaqZDGjPCbI84ojUkPek0+6W3qEuARrKz64AhShP1wDNPCnjw3eVEaQbdpS8+fRPO4HnyIrVqzEW1H2nYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780018; c=relaxed/simple;
	bh=+XtWvul0vyCck5CzAWASUv5TAMX8Dh7v2fZY93/Q/4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2mxfg+joxCM224W2hb9u7x1B+DCf9j8eaL0HDSXnZmIBxfpkmyo/8zio+um8DzIHbB7qn0UUUq7TZXavKS5NTBhYbcPXZu1648PWgfsbKvn+0diGabmp5xMzZrGzqFEVtBvlGbafqKCFYqsV/bON2w9K3LZivWzWWE8mfpGdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Zm/1jv86; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EldO/XTv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C8E82540195;
	Mon,  4 Nov 2024 23:13:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Nov 2024 23:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730780015; x=1730866415; bh=+0xuMymHiRYSYp3ZD9hHq
	gsREfQ/XJH47o0IfBEfcQc=; b=Zm/1jv86rz5WSvAnQYxItTtwXtfk9fdwdUoEv
	c6AIqbzDKN0uH9osWOBQ3cB/NZcQEVVVWJ6BZrelzEBcWjsJpO9WkdcgWzxXNmIG
	3GmN0aKcJDsJDu/Yq6OX9Qwvw4YyT31B2P6BRH3WQyXXDCaNibV0vrfEihEhE+IG
	S5oAWvuvLiiakwhyEOiwYMG60j6xJxtGXo3WXhq1eYIWC4NQ4HN5WCoZZnzKdrtP
	lVsTgM3lvTUf5AGBrkmPRaez1fZIB386NVh5iHDL9SYiQ+fHS+xGeBteX3mUW6E+
	NS3/2UBhrsUpBdWg24pTGN9iH+sTUXR3qWY2y7RjPia6Uidmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730780015; x=1730866415; bh=+0xuMymHiRYSYp3ZD9hHqgsREfQ/XJH47o0
	IfBEfcQc=; b=EldO/XTvFo2as3FPIVrHCst0ZIHrllHAzGEz9fSxZUXL4ZQLaWA
	hjUDfqAHUe/0CgSFfAEt+iB+8IBY3lRgaOFuocLDvjQ6S06V46QgudB4GeSVM5Co
	0PhU6BGnJnWCGOiefKJUb1cJEwTgGweY5tsgIKuzl7qQ/7Xw+hfSkRR2yhZO8cnx
	Gv05twPzaC+fka4stir2kXyrwsa6n+xghUP6x7YD8XSjEC6WKazsAhhOM2B3vmam
	E10fW6K8lQcAWrl9TZWuDwMqCs350xlXpxW9055bPYE+qciEcaH5YCinuvvNnoc6
	G5iXBBWetRiTQsWcFfSbApZr2rEhaL0Orbg==
X-ME-Sender: <xms:bpspZ0LH6oriMXW_pbcqrlSse9oc1bBuBTlfNV2RhcfMgO30p1z6CA>
    <xme:bpspZ0I_yknGgb6fvjpO9AT-qf7Qg4g_oUOAn4G7GHECQURKGiLlkSIAalvdDWPyK
    oSVHP3PQWaypvR1dw>
X-ME-Received: <xmr:bpspZ0uTKqTCDGJ9r6weFtsDqJr249x0TSOsGaSgzQ5EeBhyaPxRRhejUNsR4qNSYS2fWvNA5ryjEvk5pJr774G39nRxe6_CIKA6XBEJc5Je3Ny4-oWB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhitghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhn
    uhigrdguvghvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:bpspZxaFfT7MwBNG9B7uaOg6cN2Hkh5iCzFJDodtGK-0Id_WukRZqA>
    <xmx:bpspZ7Yyj2G6ldGz268uHzVR-z6kCj2HO7heDIRteFsbmGMMe2dLQg>
    <xmx:bpspZ9C3NkbAr-YYzsG_EkdN8tzCTz38WjiI5BsJf2eC-ayos0w-CA>
    <xmx:bpspZxa1zlTI884kVEKKR_k1ggI95ACbwfWhNF9mOJpFdho1H6SOGw>
    <xmx:b5spZwOBgNBaODp3rHRbtYmlZGuzDyF7yzvNfGQS-ToVM0gWfKFl1B0p>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 23:13:34 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	kuba@kernel.org,
	martin.lau@linux.dev
Cc: kernel-team@meta.com
Subject: [PATCH net-next v3 0/2] bnxt_en: ethtool: Improve wildcard l4proto on ip4/ip6 ntuple rules
Date: Mon,  4 Nov 2024 21:13:18 -0700
Message-ID: <cover.1730778566.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset improves wildcarding over l4proto on ip4 and ip6 nutple
rules. Previous support required setting l4proto explicitly to 0xFF if
you wanted wildcard, which ethtool (naturally) did not do. For example,
this command would fail with -EOPNOSUPP:

    ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1

After this patchset, only TCP, UDP, ICMP, and unset will be supported
for l4proto.

Changes from v2:
* Target net-next
* Remove Fixes: tag
* Remove support for IPPROTO_RAW (0xFF) l4proto

Changes from v1:
* Set underlying l4proto to IPPROTO_RAW to fix get path

Daniel Xu (2):
  bnxt_en: ethtool: Remove ip4/ip6 ntuple support for IPPROTO_RAW
  bnxt_en: ethtool: Support unset l4proto on ip4/ip6 ntuple rules

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 44 +++++++++++--------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  1 +
 2 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.46.0



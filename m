Return-Path: <netdev+bounces-229994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9785BE2D86
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2D31A63510
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15302319879;
	Thu, 16 Oct 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Nf9MlY8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7k0K6Us"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8712E543B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611181; cv=none; b=ZKJtg6XYg5AIo5GEQbyC/twaWnutejFlYbkMnETwd/JYlvuzgyykDMYXSokJAMWjXzMkQos7e6334Hn64uRKoCJFpsgjZWbOdrWhkzgZOSOIoN+N/jXbj98b3BXBZYg4hmFlWg744gd3/3vAUTRLl1DAjWLXdJZqWtdxg8oKFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611181; c=relaxed/simple;
	bh=N8wH1ahoQmkeqpbnzYnsGrRvS90hCfj5b+DAKQ6J3bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tuo46k/iNxaiPGI/Wnonp9DgMELc698XXx/0eCDQCLbS3GEHEf4Dg85yam748jWNMFGcTE/y6on9HLtLaOZrl+qGhacFCjob7f7GW4n7cXpNhPhz/vBpYu3SKVodOUX7Ag0fZGj3H7V43dgoXLz6Ks0WsnxDTZ9HJFdjZrAi+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Nf9MlY8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7k0K6Us; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 859321D000DE;
	Thu, 16 Oct 2025 06:39:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 06:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611178; x=
	1760697578; bh=55FYdxNf02SWATxmU7EYsVCzzbmobf2jebON65oZeZY=; b=N
	f9MlY8Y47J3bAa0EGN4IN/9RyUtR6sG9HBXOHbIrAIVUIxAIbvn4V4AN5eZvEnQY
	VOxak+YedwNFh7M4eJ60Gan6105gsYy3Vnl5dfk/pRJZ5C8E+LTTkLh+neBMEwha
	MabBqrm44Ux1Uod2Ten+z4ICafitn1/IRCb6azct+AKcIkhae7wEKI9B2UkiSJ+Z
	SysCdMnkQi++pmLAav3VbyO6H2TgxZ0tpTxr98lvdxA6hVYL626pDHVKOlkCJaTd
	lj6PymCPXKNWHNe1RhMb6AT86UNxjzDXy+u0BgzlAN/SstR7MgdQhPwpvJcbqrUc
	OYdaNfai3Kll2BWd0lkaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611178; x=1760697578; bh=5
	5FYdxNf02SWATxmU7EYsVCzzbmobf2jebON65oZeZY=; b=I7k0K6Us3iMsWZiCQ
	mA1KERjuiAnDjIP4vFaQ3Nz6Mvc3vt4uVMSm4neO1AVuOYREisaNo3/JQpoA21QZ
	JoBvU+K9NFfZ3CrkmLO4eFfLqnEpS5HUjUVHR2FddGlksjXN070fB1rgMNXMwmxE
	/301OnAPSZnFOfDwfJDqpMGh0vtvm6F4zP8elIsYW8/qhEuK0umlmRMCm5NTgDE8
	pIEv7sqjiZaK6I1mgfYOJMmmr0rGhLhwwArSJ5mNqqsEaFS1ytxPL1wL15D3j2MA
	Ep3shTbRoA3aHAd8QlQrVct82hA9SntWCA+8dviEjyI1kGw1+JJtSGv9XK0QVHRs
	1Ot4Q==
X-ME-Sender: <xms:asvwaNnpl3I-6saAI2_WTqm08lM5Czv-mMJrCSl6atNM--uIaZBOBw>
    <xme:asvwaP1HAmwBb0Km2PyuKOj9ZpUDpIJLOufOHpXoqTM-5-FqVtGrfgSSkLNCY5VUs
    wXdO-dyjPERdSZ3UDCwSuqe_-W562v_PGYGwhCt7iVGx8w0uZOnH69j>
X-ME-Received: <xmr:asvwaIoCzDqXJSjt_VZvhHU5XR7kx8fJab9AODE0Zh8gpLEjZHPMQt-_cZWW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtph
    htthhopegrughosghrihihrghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:asvwaMcefS9GQjGLf4ELInfoKVBkDhk0fb8kymqkBjfst1yiE98Ygg>
    <xmx:asvwaHoaokAb59BjdrLYS25RZFd6EntDr9JAeU6zmVnSCvmhKezEmA>
    <xmx:asvwaNEv3asm7YpDX7yPnc4V0hry6vGfPJo3_1U3b58DSxZrhXHnAw>
    <xmx:asvwaHs1usAjGEzgvf_KSATDwDSF9AsXbEW1keUMR-gUysgSgEOpcw>
    <xmx:asvwaKorsn7-tiAwRjyluRvxY1fEZ7poNkEmSmlrB3ZQGHoyVNdYqvSN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:37 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover states during netns deletion
Date: Thu, 16 Oct 2025 12:39:17 +0200
Message-ID: <2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760610268.git.sd@queasysnail.net>
References: <cover.1760610268.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current hlist_empty checks only test the first bucket of each
hashtable, ignoring any other bucket. They should be caught by the
WARN_ON for state_all, but better to make all the checks accurate.

Fixes: 73d189dce486 ("netns xfrm: per-netns xfrm_state_bydst hash")
Fixes: d320bbb306f2 ("netns xfrm: per-netns xfrm_state_bysrc hash")
Fixes: b754a4fd8f58 ("netns xfrm: per-netns xfrm_state_byspi hash")
Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c3518d1498cd..9e14e453b55c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3308,6 +3308,7 @@ int __net_init xfrm_state_init(struct net *net)
 void xfrm_state_fini(struct net *net)
 {
 	unsigned int sz;
+	int i;
 
 	flush_work(&net->xfrm.state_hash_work);
 	xfrm_state_flush(net, 0, false);
@@ -3315,14 +3316,17 @@ void xfrm_state_fini(struct net *net)
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
+	for (i = 0; i <= net->xfrm.state_hmask; i++) {
+		WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_byspi + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_bysrc + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_bydst + i));
+	}
+
 	sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
-	WARN_ON(!hlist_empty(net->xfrm.state_byseq));
 	xfrm_hash_free(net->xfrm.state_byseq, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_byspi));
 	xfrm_hash_free(net->xfrm.state_byspi, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_bysrc));
 	xfrm_hash_free(net->xfrm.state_bysrc, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
 	xfrm_hash_free(net->xfrm.state_bydst, sz);
 	free_percpu(net->xfrm.state_cache_input);
 }
-- 
2.51.0



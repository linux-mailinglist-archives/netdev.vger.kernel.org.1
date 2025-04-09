Return-Path: <netdev+bounces-180772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC707A826EA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196D5902F48
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43EB263F4B;
	Wed,  9 Apr 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LzFSBZD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnmTp7Mq"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C871E4AB
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207221; cv=none; b=AOhgjbd5dJUGUliHKuBtfj5RjnUPAL4ED/Pvoo6nPx/1Xe2U9XbNHBYK+e9qQTuBr9jlvb23EWG8VwoZAEBvKvTXqWBAw5W6nW2XAByH2sAwkhVgc3jugv2Hm4GScKCQeJA3enHtmiKlaspXeQFMlKF1bxYKNIHiF1834oW5ccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207221; c=relaxed/simple;
	bh=4y94+9Blr9FKoWqAHE0cO01sttpbwpaMRWXYwk2gdrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3csMidb91RJDnG49BSCk69+V/1ef+3ZAmTskGJ+6hg58G5FfpZsb+9GNtBUvGUEIHs0ryiFG+NuVjMUHgywWVPU/6yABod+LJjug6PGkaQjoqDnVU+CDHzsNxSky43jJs7BAK2MgfmGOJsNzMpKcInYSy1xZ40ck4EW4eBkK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LzFSBZD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnmTp7Mq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BEC82540121;
	Wed,  9 Apr 2025 10:00:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1744207214; x=1744293614; bh=5Ul0mxBGRL
	qIyGaBWPQ+yM7fgXaYbsEIAT1kM7V1DAo=; b=LzFSBZD3IeiB4Op7zB6giTk2d6
	goRFhgPfRtM3FDs88ChkP5+78jAJ69XWSyXdNda0ut/VypmIhcewvC9ixKHfyfus
	BDsjwZaYcGaRHHirjNziiJr/s0tVykig6QAdot0LLOcuId/VYDstJKtrSTJcY0dd
	JiLnxlqbYgLzwL90rr8azkR1Rv//+E1vCsPkMiFHZffXyi180yyHb8vy1k2v/yXM
	QIFmxB38HyQ0EypAT/pkIC8Ye8eM/mMWjfKG3xFYFWA/PuAxYhkrLwjry0NkXAYH
	niMZKs3be4lOXm1dT84ur9b6x0NUtGBMRB/U+9SibhQb8OgFsP3w3TKFGchw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744207214; x=1744293614; bh=5Ul0mxBGRLqIyGaBWPQ+yM7fgXaYbsEIAT1
	kM7V1DAo=; b=CnmTp7MquXiI6mQN7ev/KnaXNNvFOX44nR79HzcHkDYc1vVj4hW
	bZpJaX6V+JWggsxqzCFW8PXJMw7HH2VKDyj7nlS9KYjhfiJNgH65LfoIsYeVZUTV
	IEbUh90AtN4xkhcYXylY59oNXSpoD1If7/to6XTtf3MHmStvDYVpsMEfm0bv3hTP
	tlj+6XiTNoT+VSOQ51WJV9BUDGYZAHrmwqTNIeZUHBzR7sSxry1xMxCR8S+H9d4e
	v7v5gSsrMIEP7ZjsUkc2qcJN92rXLcFTnaHcNxlybGcr6LWrgk1qXXGbNYYWLEDq
	8PtDWBgHxBteJfd4KfT8p8FLN8xVkwbFsrQ==
X-ME-Sender: <xms:bH32Z4t-r74P4WdjInBJTDugsjhz0ZHEvmtY2PPH5Vllx_MJ5cXawA>
    <xme:bH32Z1ffg1YIcOy7eUyFkuuR1KQ1dFVYt2qb4GOTxFmKa3SsBwGD_fxUKTSTAZ3n8
    g6BSNSQfgMGV0Xa9YM>
X-ME-Received: <xmr:bH32ZzyaYp6aYUcuT199jierhfBZ1OWOOBxVwFB6B1fJl3n1LG4Ga4BTdQJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedtuefgffekjeefheekieeivdejhedv
    udffveefteeuffehgeettedvhfffveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrg
    drohhrghdrrghupdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggt
    uhhnvghtrdgtohhm
X-ME-Proxy: <xmx:bH32Z7P_wIJzp1QzuO5qJjugn-67jyves8wR7GgyiHp11F37B9vQyw>
    <xmx:bH32Z491L0Gb3UlToNL6M584GNiBR_S9J0SBqR3DW-AByLeWTqd2vQ>
    <xmx:bH32ZzUkjkf02Utft9lEF7RaIBitdYA38SMBrNva8CeRpIwUqU7QGw>
    <xmx:bH32ZxeahvXE2hMsS2zEGaah2jBwv__LZjytDAYjAeW6udAIyWE4Gg>
    <xmx:bn32Z_ASsOrHRRT0-KtGMyMOpBogoOVTUjcHmFQBVfBLZ-kAjaRUkCvN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 10:00:11 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 0/2] fix some leaks in espintcp
Date: Wed,  9 Apr 2025 15:59:55 +0200
Message-ID: <cover.1744206087.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmemleak spotted a few leaks that have been here since the beginning.

Sabrina Dubroca (2):
  espintcp: fix skb leaks
  espintcp: remove encap socket caching to avoid reference leak

 include/net/xfrm.h    |  1 -
 net/ipv4/esp4.c       | 53 ++++++-------------------------------------
 net/ipv6/esp6.c       | 53 ++++++-------------------------------------
 net/xfrm/espintcp.c   |  4 +++-
 net/xfrm/xfrm_state.c |  3 ---
 5 files changed, 17 insertions(+), 97 deletions(-)

-- 
2.49.0



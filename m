Return-Path: <netdev+bounces-211517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDBFB19EBA
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199F5189AB80
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF02246769;
	Mon,  4 Aug 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wtKJYImH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBbKMaMn"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660E2451C3
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299601; cv=none; b=ZLgiwGKe+5ioencaNKDLh3Q9PR754D5soUMYHfXtNm7cPlpVfjxQhwqw5vU6jZRNlOlK3MjPNZX4YYQ5J0dY1n0RTd4WC5FAaY9KxICP9S3WU4z79iUbDipMmi27Gf3poRs2WiQa/xNbcTEewjqQuGrt3GGzErm/FA4r/qPBlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299601; c=relaxed/simple;
	bh=TH05jlLQ9iMnPK//qoLSm3t6OX5Jq/Q9tcjOF8NXf0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZ7ixA+2hdCUIH8Y+XRKVtlriibni/t4nOZt5cJCeyjNs/DtuHdJDDaATqfZCRYQ9F6eydurildGcJd4doj/yjr6CbbBXPSh4hW75Uxccle6/h7u5Lg22tt/wg/EKI6HVTaNKZkSHa3wPDR+tdXfq0DER5rBHUF79oiNcBxAJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wtKJYImH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VBbKMaMn; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 153091D000B4;
	Mon,  4 Aug 2025 05:26:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 05:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1754299596; x=1754385996; bh=WhuvXEAINQ
	zLBUe6VgVMWUgQwWnMjq7h3DwJKOuPOow=; b=wtKJYImHJWmljh7Rq4jvzpmEoX
	hBWV7LjXLKekuN9WcsK4ISvkoMY0itITduTq4+3Xlpk64rjemen7Lgm0QfhakHne
	WGSqHCjyUno+ZUVIrh/KcZrV2qAHBt2MptZfrwtG2rYkHkgCswFdSEQ9o4CP2It5
	TTaIgdZEylp4dUeuoz3dbqWC5l5MSv64F7aER8k5zB+JTeXJp+x1Y/Vr8YlPDjG6
	QiW3XxpfzOKV6ENdHtcRdYRXfQl0EdHhgejt5za9a7xwODdnntstYXvvOOSPTG+S
	XJhH1A+F0xq2xPPYhp07bLqfd/ys+ubf/m0AOAaSuSNG1B4WhNWKjWOxVklA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754299596; x=1754385996; bh=WhuvXEAINQzLBUe6VgVMWUgQwWnMjq7h3Dw
	JKOuPOow=; b=VBbKMaMn+QwRL73YmBF8dyR/zGYlDtZM7ytX1hKlIuTUwOtwM4W
	phi8zu7IFaUW8eEIDIfxQ0oeD1kWghW3xI2gd4C+/aO48rIsqfMp29NSXyAjr4i0
	BW2/EZLLj6L9Zh3WmLldYV3Ei07fPATei9xaTjWY8xoPanAjC8vRaHLOxs7ZzpLb
	lodekP5OdftZeRIt7xwLw23kwD6urcBrqPtjdBM02uLs9x2kddY6SIGthKvyBG/a
	q4Mn4ljbHqaYgZP6zK6L2KrG95xU2/z+oy79vXlAClOm78QmE7QVaQVBxYIhN5S2
	6mVe45BaxRzew03mHMJ4nOs0d+dvqdon5TQ==
X-ME-Sender: <xms:y3yQaJ61YPb-AbBKbIk_N-lXQbt0dO_AGGRpUgzUBt_rl4EMMHNKWw>
    <xme:y3yQaL39jUkU2pUaAMbcHXrCGFqTAOZbqfq_cE4poL4fRfmF5aTx3Mws4RUZoeRey
    wxIMkn1VQak2yYzQE0>
X-ME-Received: <xmr:y3yQaEsHKTX-qkqxn92Bt1i9CvToiQ3VQLKRHGHa3Bpf9_2NsdW9SHD-qmST>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtth
    hopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhho
    rhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvth
X-ME-Proxy: <xmx:y3yQaB4zy1PF5oMlyIndXJ2T2rgCOkay72FZPsS7l72aveTFa-5BSg>
    <xmx:y3yQaAe0ICr8vxtIeQtwQAopkUC84MFsJBTe19uw99R9LpXN_b3f-Q>
    <xmx:y3yQaOzX6tFQ0jIi0dy3ouayX3a2UyPHMaWV4X5FYC0L1WS-RIYn9A>
    <xmx:y3yQaF8wMogJNySY3LNOQznC-UMkOYN8RmtVgtkLRa7MhHUm8IKFFg>
    <xmx:zHyQaLRSu59rqSYjz_dfIo0fOqk-71IhoHEZo0nUmsDoG-BBUYeBTFa1>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:26:35 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH ipsec v2 0/3] xfrm: some fixes for GSO with SW crypto
Date: Mon,  4 Aug 2025 11:26:24 +0200
Message-ID: <cover.1754297051.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a few issues with GSO. Some recent patches made the
incorrect assumption that GSO is only used by offload. The first two
patches in this series restore the old behavior.

The final patch is in the UDP GSO code, but fixes an issue with IPsec
that is currently masked by the lack of GSO for SW crypto. With GSO,
VXLAN over IPsec doesn't get checksummed.

v2: only revert the unwanted changes from commit
d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")

Sabrina Dubroca (3):
  xfrm: restore GSO for SW crypto
  xfrm: bring back device check in validate_xmit_xfrm
  udp: also consider secpath when evaluating ipsec use for checksumming

 net/ipv4/udp_offload.c |  2 +-
 net/xfrm/xfrm_device.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.50.0



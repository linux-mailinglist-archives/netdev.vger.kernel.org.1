Return-Path: <netdev+bounces-156880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92050A082C7
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334F9188B284
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E01FBC94;
	Thu,  9 Jan 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="t/3omw74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAlncUv1"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963BA2D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461883; cv=none; b=ThxUWNeUca3MTueL+KpewNNSsTWI4Ltcgam+9VnIWpMrb3ZkgeDC3/eagb5oesxlnpF8cRfVm/n9Tylma1q7NPBLCdaY5THQJ6UXMR62p7jOrm3nAHwr9i6Q4JPn1kPWSUSG6c2StBkpc9Alp+P0gSecAn+UpfoN0f5hX70nDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461883; c=relaxed/simple;
	bh=LUubxPSZBzhhoACieSQAN0sEctzjzLAj5+uz9FxlkhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxEQyN1HsvDMgu91tdGQWFOxT1CPi6GkkWNqkv9PsUpHFwQ6HOttGoiAYMvDkvyzMOGTKnnt0xpp2FFSUO/uRYtb+yc84yO+mIOwnMmio8vk3B1VFu/uNq+sC4lf9V4mDn/pd4/pCcurCjV1oRkaQ3ICw5mV5FDImuZX+BRpevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=t/3omw74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAlncUv1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C986B25400D8;
	Thu,  9 Jan 2025 17:31:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jan 2025 17:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1736461880; x=1736548280; bh=Mn2GPrH+zh
	5SofmZZNbIsysuCPdRo1vv5vUQo+9pBUY=; b=t/3omw74FDXIgG8QnrvNDJ3DLX
	7cia54IB3FLivQevKaMVNlFvwX+EWAd45EOcD2RXH/kRzAfzBTqvS5aCeIb9tSlh
	WGejxaMT4D66RK7fcrG+mOBYHCXsTzzMCFTOa2dM8OnNbWB3tTxVfJbYeF484+r3
	J5GfT8tu8eY6eFer3HfcGNMlBaBZGs/jBis9TSH31G4I2Nv7EZ8vN7bQPI6RM0WZ
	Td2zsonfjgZZ8kBPJoyFOLn8Q2bbhc7gT7pCkLHJ7/mOEKnNWCjFm5i/w/vXRmST
	AyIzOa7Ldww/Yq3g5hx8ysG3rcr6PgTkigm7PAkzREhpFg7YvF15IMKbt25w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736461880; x=1736548280; bh=Mn2GPrH+zh5SofmZZNbIsysuCPdRo1vv5vU
	Qo+9pBUY=; b=BAlncUv1htpmyH/6Or0cVPihYl4yeRBQ7dmVyrN4nJcscTBoXPi
	teQxeXCdWW7Fm5pluz9dLIKGLsutZ+Uc0o10Gypm2yn6tYdiCwZ1c0mpwcASqhBF
	IVWlRfL8hLwZwiQ6MCq2bZDcuV8Ko+RyKouhrOU873D3ChVP5dsDqp5H/B6pP5IO
	2ugMUpfg/TNnTptRe2bJyHfuz++VNG4qWXJPesrV7wveqVFHWjq5yd0tNFyT+pev
	Guu+hicCErQ+3UnFMkBPJ7HX40rVxKBnkb8Fe8I4L9G5EBenoogB3c7sZ6eaeo1s
	XqutxbFUUyMdbvynBVFiw30C3HtIa5HHQow==
X-ME-Sender: <xms:OE6AZ4bUrLTJqDZYqzETGOt1OdLWpejKanA0tFrBFIRE865K54Q43A>
    <xme:OE6AZzb9BJx_QxbFEzLV3SoJhgp2yddRi1xL73brbS3KMKVeSgC0JJpe8L3vzNKrj
    85ss7YSNfoL-rb-10A>
X-ME-Received: <xmr:OE6AZy-sxiIwtJZa7mCXcvvpBT_8MahdQVPIlquiv49QDzQEQaeVm80dl4ze>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeevgfeitdetjedtkeehffetjeekteekgeej
    tdeiudejleehgeeuledugfehveeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehq
    uhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopegsoh
    hrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggv
    nhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshiiisghothdoiegrtgejfegsfegrsghfudgsheelkeekieeffhgr
    sehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OE6AZyr2gA8oXVSypY9q7oRd5Asc11dKHWfNkYpFc79CsV5RlPyiIA>
    <xmx:OE6AZzpQDg4GDpAiiEQ77E_ltYfjJrJYBGFhgW3SmZOM3wqzFJHaQg>
    <xmx:OE6AZwThipoppe2qXpBaLuScxDZW68mdpCfYa9N19UP6ZrjLkfhp2Q>
    <xmx:OE6AZzr4mO19Ol1EAiB3c9_1FQzsilVIZGyZ04-M1qCfYMqL5KdkJw>
    <xmx:OE6AZ0dnsHGNbpCRP6Ux2snkm0A9zuiUtvClmyJuiZZiIrf3kuNEowmN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 17:31:19 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
Subject: [PATCH net-next] tls: skip setting sk_write_space on rekey
Date: Thu,  9 Jan 2025 23:30:54 +0100
Message-ID: <ffdbe4de691d1c1eead556bbf42e33ae215304a7.1736436785.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a problem when calling setsockopt(SO_SNDBUF) after a
rekey. SO_SNDBUF calls sk_write_space, ie tls_write_space, which then
calls the original socket's sk_write_space, saved in
ctx->sk_write_space. Rekeys should skip re-assigning
ctx->sk_write_space, so we don't end up with tls_write_space calling
itself.

Fixes: 47069594e67e ("tls: implement rekey for TLS1.3")
Reported-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/676d231b.050a0220.2f3838.0461.GAE@google.com/
Tested-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9ee5a83c5b40..99ca4465f702 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -737,6 +737,10 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	else
 		ctx->rx_conf = conf;
 	update_sk_prot(sk, ctx);
+
+	if (update)
+		return 0;
+
 	if (tx) {
 		ctx->sk_write_space = sk->sk_write_space;
 		sk->sk_write_space = tls_write_space;
-- 
2.47.1



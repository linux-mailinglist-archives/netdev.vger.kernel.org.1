Return-Path: <netdev+bounces-229125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5CBD8616
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC5C406B07
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6C2D47EB;
	Tue, 14 Oct 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="3p8TSfdj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r+9BIwXr"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F42D47E4
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433485; cv=none; b=UrotGjbaVAD023YaKBO/ujN31OG53lxcw8m/WGcfbUNU4hoQPoUBLtNbxEzM9h57ljXbI/plfQG3TmlC3p5OtsWsoyTPdcL0SdKZ4w5pCVY9DqDwXxHU4BDZaMTiwBK13qLxMoriSksjk/r63D3HHfMx24dbSqA8pyOamMhJ1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433485; c=relaxed/simple;
	bh=D0Xd/0UEfhqZRbucDGUtMfGvg2m6tyXTja9l2d3Qx34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/K7kvKLvpJXesKclR164AtBqpgdVlXO5phzWwsY39eFxNxjhP+mCEf8UzEYHjCbW9auOKkaF5T18YR+h9Nt7NZT34QuR3LB4lmizIi1hNH8AMB4+LkyWhgzuQigVdmBrL7D0k/13afiOlZC5U8BvQLN5yd/B4rJTxmnuKxlX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=3p8TSfdj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r+9BIwXr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC2AC14001F1;
	Tue, 14 Oct 2025 05:18:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 05:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433482; x=
	1760519882; bh=M2gwGlMhv09YMN5AZQcM7VYyWIHfycnRSZuAgsG8gBI=; b=3
	p8TSfdjEaR+DvSYzDya0InlWyqi2EJEsJPmodEVjaaqnrsiloeCrRTgtFlVJsYRa
	oCnSR/WCvtTw++86f4SyzMx1X3sqOq9OBqgLRQPGADb9/36o4jr7EPa+Tm1jBkBx
	REgoIBRy8RAkkyEZ3rHEF8mxjwVBA4WkpvqHzKtu1hqReyokNXR+DRHuSerAHjLi
	Bh5v4EI9vChdvs6DZQNAUdS/jOVbaPUoq85wzaw7zVYjC16/DbOh8VyhH4H7fuBr
	Z87p9NrxcQjEgBJbsWX3cIbIUoP40tr2uJZsTy879U9igMEhE1HOJfNnMREeVXFu
	wxOzSMEuvYFuLOrF3hRlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433482; x=1760519882; bh=M
	2gwGlMhv09YMN5AZQcM7VYyWIHfycnRSZuAgsG8gBI=; b=r+9BIwXrfamPVWbYP
	2QL5VkTloDHJEko4QKK15ShQE8xg9ZzhXbdFXob6n14Uw2n8nXPEb1HJ3TQbj6+T
	RSTwVLAz8hPmFPZ9DAGS2vj2/elkrAicwuY8xp10+wsItjqMbm+RQOBORHnC85ZJ
	JzcYESZ9BgxWeTz54xSJKI03+94lz9YSzTn5+fvHzO91uWGsRY2TPjLP3ONlinMd
	BAs9eq89iEG5VOofoIZIJZbkQ24l/AKnIZFjVLdVvu+6oHc6RZ6eGKsw+BBYc/Ie
	E0cthvIVgol/2Ns5i7wWWFylOJe3WS7fxjad+lcClNm1eigZ9zkKt+2Jh54LX/Vv
	69T1A==
X-ME-Sender: <xms:ShXuaDJpKV6x3vbtW0D9wiNedAQU6uYhSRPj79NmiAonoBajtNtz7A>
    <xme:ShXuaOCcab3v4UMDSpIECP_3k0AnG-l_xO4i6tBcWxLhGAt2Tn2qcYsW0sRThZ2Ae
    sPC7z9MRhihNfIm6Gofzy9AtJxRtSI68gRKbpRkHdDuhH66LSgK8N0>
X-ME-Received: <xmr:ShXuaECeewqWpSAm9Yk0-YmGnHIqTvtjIKpvMawi8TGvOgLwBI-mL_cSBdxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ShXuaIALcW_KvSrKuFIYacTfxuYaSaXxwfGgsSAodW5ENkCwu-vFvA>
    <xmx:ShXuaHqijNIiOxjvrkxkmFveNl38uhp4qCr_RlyLAEguoUL4ffeKlw>
    <xmx:ShXuaKkjT5jo1bxN4F9kxuuaDmN30i5E0rLBYQssTYVqWjqUk6Jr0w>
    <xmx:ShXuaPxMwbd3svSn9gcPS0umhB8A_dM1CxKMe4g7FKah8yeDhRM_3g>
    <xmx:ShXuaOPWdCBYusONfcJ5G_fP-FOTgwFQ-6D1Vw4wAMDdAL6_i4xhoMXW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:18:02 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 3/7] tls: always set record_type in tls_process_cmsg
Date: Tue, 14 Oct 2025 11:16:58 +0200
Message-ID: <0457252e578a10a94e40c72ba6288b3a64f31662.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace wants to send a non-DATA record (via the
TLS_SET_RECORD_TYPE cmsg), we need to send any pending data from a
previous MSG_MORE send() as a separate DATA record. If that DATA record
is encrypted asynchronously, tls_handle_open_record will return
-EINPROGRESS. This is currently treated as an error by
tls_process_cmsg, and it will skip setting record_type to the correct
value, but the caller (tls_sw_sendmsg_locked) handles that return
value correctly and proceeds with sending the new message with an
incorrect record_type (DATA instead of whatever was requested in the
cmsg).

Always set record_type before handling the open record. If
tls_handle_open_record returns an error, record_type will be
ignored. If it succeeds, whether with synchronous crypto (returning 0)
or asynchronous (returning -EINPROGRESS), the caller will proceed
correctly.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..39a2ab47fe72 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -255,12 +255,9 @@ int tls_process_cmsg(struct sock *sk, struct msghdr *msg,
 			if (msg->msg_flags & MSG_MORE)
 				return -EINVAL;
 
-			rc = tls_handle_open_record(sk, msg->msg_flags);
-			if (rc)
-				return rc;
-
 			*record_type = *(unsigned char *)CMSG_DATA(cmsg);
-			rc = 0;
+
+			rc = tls_handle_open_record(sk, msg->msg_flags);
 			break;
 		default:
 			return -EINVAL;
-- 
2.51.0



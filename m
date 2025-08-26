Return-Path: <netdev+bounces-216941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE8B3630F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F73682F11
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243534F46F;
	Tue, 26 Aug 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CsnpUgZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HV4mvBPt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09C34F463
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214238; cv=none; b=PE2Jz8xkIMRxIQsQ8u8sizzenQ5u7BqjJ2nj1MsQ5bh+/bGpjJzsfgouGmPj0O7qesxP6EmeRDAnsNzwDgFvySL+KJ4xZM93LIwPOwQ4zDjncKtPkHSiyDA/IDJVYcNIsFwyfoQVRa7jK799Ngm5chGYaYQADeZjjtHlqQX9Qn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214238; c=relaxed/simple;
	bh=2e2q1Up+6ZOdPE7NFM72xI+NBOURMTbG6KWIUX+J38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdCioKpG21ccJrx7ApM5YtK2kaCpXrdP4CCGKMK8sSlT4mXVTDoGVZrm6UZz6cgLZZSbogAl4Yc2h6c9n8Rzx39KDRV0LzV7tUWWpYraptEA5sdnXS6SwTyMkBPowAOU1rqAMbb54hvIdJ0AvpreEsOIwGPsMgafseDuACu++ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CsnpUgZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HV4mvBPt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82D507A0178;
	Tue, 26 Aug 2025 09:17:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 26 Aug 2025 09:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214236; x=
	1756300636; bh=KPGYemxqLUDR34M9V6pEzLwuBH7DShZem6jUeFOPbq0=; b=C
	snpUgZh9bAbjhCTSTZ7mPfhbOmXrRslHXwEGsET4y94AP/FCB3CjkYLktY+QdgHv
	cnLE03KDTRQB1WVzqQo7ZgeF33yCGJNFMD0wGIdz9hDjoxCInXO+KSg4LYkbgJqm
	kFEnQVhrAiMunZ//tOFbrUlNdlhA6hODhn6d+CpZaY5p36tnQF7RTD5/0a5JLsek
	OvW6hAZ4Is1x4I450Ol8UpYktu6ZodhtXCcKpDfMtqA64RBbPTjr7gtW/5l/7RYz
	6anU2/FCRXbRpeFlgDX6CKzi9xkX2SxW/49xHHngpxmR+VRxMOTebrz91kJSxT5A
	l5ldBsUJkp4nN/pDYQlkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214236; x=1756300636; bh=K
	PGYemxqLUDR34M9V6pEzLwuBH7DShZem6jUeFOPbq0=; b=HV4mvBPt6L8Nby4RB
	B9dVzcGRmFQ8FkaFSxZK+PRM4K8HxMk01NiYHQEz3Q3nY8m8f0fMQkSqZ5pU1IAt
	7lrVqMU2yoq9D/Y3jkQ92dpxE6fI9lkBSBwQ1lGYfM49i0nAXrIdp1XH/kgKXYRK
	A4BJQlnBaw+yVVvzfj6aX3f6XEaqQI2F+32tVwbhZgAUj0SpWzS0Sq8I1fphRJIR
	x7MNnzUQABKIfk5AHaY2kNB1x0HKkzxbubJaD4YMpnz9+ATNGEV6dCDInbTqRIyG
	7PLJHFo4bVCQOTdYwqq0cgm1Pzq1qlqDmwjbyEGnNwOmE6tJYFhCHuV19O2o+iLo
	VpOqA==
X-ME-Sender: <xms:3LOtaOrUy_N5UDwXCNUlaqVE9AX_kfrhqOBn59EdFIVvi_RLyfG_uQ>
    <xme:3LOtaM3ZFFdgO8DC2EQnOC8jf6CgMVIlYNcSsQhG8CoOjz72e2Mr2TPQ3M-OCqQlL
    fUNSj_1gmVcHITin2U>
X-ME-Received: <xmr:3LOtaFAzZYa-Y3Jjnhd2Uqg-9CwfdF34GBrp-pfhukVtyzbZcR_0kHQhrmmC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:3LOtaMc2t7xt1ptMlVZv6JYOB9m1QP3tixZdY97FanhJW4YCKlPemQ>
    <xmx:3LOtaCgIRaQvARcPA47XQwcwDAzTS2tiLGekOXA1dQgns-Ufek3MlA>
    <xmx:3LOtaMobLQdEHPJ7qKUPDT8r1AzpUNJO7I2xrZJnscN0FOglrqTEfw>
    <xmx:3LOtaKFINhHgW08bgQYoF989lVUrToNi6qIph9kq-xky8NUT0P78pQ>
    <xmx:3LOtaJONq5Q4rOJJYfj6fza2Pw22xS71XHScE5W7Y6JBhrFr79iyzKi9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:15 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 12/13] macsec: replace custom checks for IFLA_MACSEC_* flags with NLA_POLICY_MAX
Date: Tue, 26 Aug 2025 15:16:30 +0200
Message-ID: <95707fb36adc1904fa327bc8f4eb055895aa6eff.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those are all off/on flags.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index dc17b91dce2d..115cdf347643 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3766,12 +3766,12 @@ static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_CIPHER_SUITE] = NLA_POLICY_VALIDATE_FN(NLA_U64, validate_cipher_suite),
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
 	[IFLA_MACSEC_ENCODING_SA] = { .type = NLA_U8 },
-	[IFLA_MACSEC_ENCRYPT] = { .type = NLA_U8 },
-	[IFLA_MACSEC_PROTECT] = { .type = NLA_U8 },
-	[IFLA_MACSEC_INC_SCI] = { .type = NLA_U8 },
-	[IFLA_MACSEC_ES] = { .type = NLA_U8 },
-	[IFLA_MACSEC_SCB] = { .type = NLA_U8 },
-	[IFLA_MACSEC_REPLAY_PROTECT] = { .type = NLA_U8 },
+	[IFLA_MACSEC_ENCRYPT] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_MACSEC_PROTECT] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_MACSEC_INC_SCI] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_MACSEC_ES] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_MACSEC_SCB] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_MACSEC_REPLAY_PROTECT] = NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_MACSEC_VALIDATION] = NLA_POLICY_MAX(NLA_U8, MACSEC_VALIDATE_MAX),
 	[IFLA_MACSEC_OFFLOAD] = NLA_POLICY_MAX(NLA_U8, MACSEC_OFFLOAD_MAX),
 };
@@ -4246,7 +4246,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
-	int flag;
 	bool es, scb, sci;
 
 	if (!data)
@@ -4272,15 +4271,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 			return -EINVAL;
 	}
 
-	for (flag = IFLA_MACSEC_ENCODING_SA + 1;
-	     flag < IFLA_MACSEC_VALIDATION;
-	     flag++) {
-		if (data[flag]) {
-			if (nla_get_u8(data[flag]) > 1)
-				return -EINVAL;
-		}
-	}
-
 	es  = nla_get_u8_default(data[IFLA_MACSEC_ES], false);
 	sci = nla_get_u8_default(data[IFLA_MACSEC_INC_SCI], false);
 	scb = nla_get_u8_default(data[IFLA_MACSEC_SCB], false);
-- 
2.50.0



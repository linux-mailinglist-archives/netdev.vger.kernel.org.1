Return-Path: <netdev+bounces-216933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF26B36300
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ACF8A1307
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA5345741;
	Tue, 26 Aug 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="loMFqPTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boY55ehE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDC343D94
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214221; cv=none; b=W380Tp6AYUh1lP4yGWXN94uzoZ9FwDFlPrxC3WNE2kKofh/DNe8qyKGnGx1yjiTnQkrq5FM+pPUX89Uh5Vq9+YtXJHN9kt2p6nf75HASrJu92sw1wGuW6xBXoxPalLA+pfYmzYguqrfzP9xHW6FbbfyfBlsR9rnpdQYcORe2B5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214221; c=relaxed/simple;
	bh=r9nelYUiLxJc7WVlZjmCTfnMxmIX8sXQt5NE2AK6+Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+mVHlmvGs/cgiYQ5WE3RcS6qBA/4QQnP0oWLn0coyEQ1hIs6SVEyNolqwYp+Pa1BiM5hkzFS7XMOVmJAahy1VnvvnkUbq0MZIOENHQhPVjfly5iB1gvKStSKqZu5/3o/ajdQGJ5E8PDuEBsBs+/Co27kHrYwSZXb/jkRvQmVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=loMFqPTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boY55ehE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A16D7A00E6;
	Tue, 26 Aug 2025 09:16:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Aug 2025 09:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214219; x=
	1756300619; bh=/W1bit76KwO3SrFTpVMzFTog+Cn4ETxqInvWW20sT80=; b=l
	oMFqPTWpdX5wWPah0xwHHR5zUlPi5VFRDa9+/IS0uYBtr3eyXk8+v2e5m4PZBcVR
	pD2LGFUxy+3spmwMpaM2MG+Zzfq5xGj6XjMarOgOmboTr2k4/6vNycP9zqilBp6D
	eZ7wrCEfIXjEVr66sYUqmJjHwqjXtHDFj2gjxHZ2GQmYDDVS0HxH3pn+e5WUDRKN
	y00EM0xb07nPY2Wz/xNUvEcnrug4PY9BfLGQRNHvg7TvDvbcDhN0wcHZZ1iwkwir
	tYouz/9udTThHnxgJoHjDnlNWiOlLRFlrL8Fywn+UYbil5oyzK4cUYtFD7aCZqHV
	taveDEhWlPjl8hrGRaqeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214219; x=1756300619; bh=/
	W1bit76KwO3SrFTpVMzFTog+Cn4ETxqInvWW20sT80=; b=boY55ehE1RQO0rEVB
	u9mj0NczdfHxE2e0jo4H8PbzpUFPKsImVZDDLMUao/sqboSZXeI1zSC0xZYaE2Ql
	nBC6uK0FJbbYi11+JZuInjmd1VqGExis7tcEDHwFkZfQ5Jqty+CcvZVDnDzgJYUA
	80cdaQQp2wrYLMr5m1HrWtrp1BTCNvhh9Q8wKC4ZIzgIxtsfb272FhfxMj6tdK8n
	x6AusM3g/Tu1WhnExGZtT+XY4xEwlLG4Fz6tyvRLAkUyFnwDn6OH53no5Rzbe0ui
	crpoUiL8fivFQtAkROiPgbSxJrLaASRVYaTKvI6216t6VNg1vRfEvt9SErdxTBCo
	sJSIQ==
X-ME-Sender: <xms:yrOtaGiVcICL3KzOgOE4LpaSTSnSzbfazuai7xU4PEHszakh2F_hIQ>
    <xme:yrOtaHMDVPbCy38VMGbkkieTZ9kM04VrXCxwoVeXT6bRiX8-0_lltrqJNQG-d1VkH
    -ncF2-p7Yfjad4jats>
X-ME-Received: <xmr:yrOtaP4SvWwKEbwWwrpBLLdMpu5QySzf3uk_uGe1s98TwnEnAEgq9j_EXCrc>
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
X-ME-Proxy: <xmx:yrOtaN3Hf9tS-gXGEbJIKLNlbfc7eacnZcC46NFLP9b66FdsvkSX1A>
    <xmx:yrOtaIaSTMYs_zAO3C_jk96_gSQB19sxdHB84n34_JCaGqCAzYlhgg>
    <xmx:yrOtaNB5W13lyHTE3cl3AS1LGq4ADUVDBIuVOKgzCU8nhXNKhbBCtA>
    <xmx:yrOtaC-19UxE4joMA0UbvbJup2Rc7Is1v5XJrdkCm7QTSPHZPvrW0A>
    <xmx:yrOtaKIiOWxHEUgjrKlZcpZRUDHiG7qEg_HlQ-TUN8Uaey71FpRX-Deq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:16:58 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 04/13] macsec: replace custom checks on MACSEC_SA_ATTR_KEYID with NLA_POLICY_EXACT_LEN
Date: Tue, 26 Aug 2025 15:16:22 +0200
Message-ID: <c4c113328962aae4146183e7a27854e854c796fb.1756202772.git.sd@queasysnail.net>
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

The existing checks already specify that MACSEC_SA_ATTR_KEYID must
have length MACSEC_KEYID_LEN.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4bff2c90ff49..1b59f2c6b393 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1672,8 +1672,7 @@ static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_AN] = NLA_POLICY_MAX(NLA_U8, MACSEC_NUM_AN - 1),
 	[MACSEC_SA_ATTR_ACTIVE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
-	[MACSEC_SA_ATTR_KEYID] = { .type = NLA_BINARY,
-				   .len = MACSEC_KEYID_LEN, },
+	[MACSEC_SA_ATTR_KEYID] = NLA_POLICY_EXACT_LEN(MACSEC_KEYID_LEN),
 	[MACSEC_SA_ATTR_KEY] = { .type = NLA_BINARY,
 				 .len = MACSEC_MAX_KEY_LEN, },
 	[MACSEC_SA_ATTR_SSCI] = { .type = NLA_U32 },
@@ -1737,9 +1736,6 @@ static bool validate_add_rxsa(struct nlattr **attrs)
 	    nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-	if (nla_len(attrs[MACSEC_SA_ATTR_KEYID]) != MACSEC_KEYID_LEN)
-		return false;
-
 	return true;
 }
 
@@ -1960,9 +1956,6 @@ static bool validate_add_txsa(struct nlattr **attrs)
 	if (nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-	if (nla_len(attrs[MACSEC_SA_ATTR_KEYID]) != MACSEC_KEYID_LEN)
-		return false;
-
 	return true;
 }
 
-- 
2.50.0



Return-Path: <netdev+bounces-216934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97983B36309
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC032A681E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA23451B0;
	Tue, 26 Aug 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dA3AEOB1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOTZ18no"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6D23D7DD
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214223; cv=none; b=di+yvx/ql406U5kIiw6oGEuQRR3L0/HuCNW1R+sYHeTut0EUGh3q4MKKAxisYFGmxozapWym9kHhdYUoCn9St0xMu/UCEppNJzbIEJK+hHjSLxQm3NHdJdBh4kcXvjWovmfkI679/JmSLa+moSmnCFDYXH13NlXLAWKOCD9ZhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214223; c=relaxed/simple;
	bh=kTgqsGXbjLdoRi789hXDo8U9ff2PqfsRH+kYe/PrMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLSntgsWyJGCOg34T+/4Djl71OHp29RRCqLP5rc0Ec8hMPgC119Plxx+lmtUIWC7LkXcJYCy4gPQ//hMkwqCSsRaPch7LP+G7azuNPUznoKzVFzfSUiszYPySrc29RYsJ69exyOvYCypfFFH+kCbFpoHNw/oIUyayYlFzC3RJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dA3AEOB1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOTZ18no; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 58BC41D00074;
	Tue, 26 Aug 2025 09:17:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 26 Aug 2025 09:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214221; x=
	1756300621; bh=pT437oxSDg4kaBMbY5yyX/KNVqQcUQ4eAv+jtuZTkT0=; b=d
	A3AEOB1zvcQa0iHJBCFp7tAz+laUqimLkqKGmxw+3ua1wv93aouYoWLoBpqAQuVk
	AJwDCbb3RvBTbs1JStxzjRoNr/3YpjbM9DKgIPeYRN2uXHxklgKvwuKVJDLZVmQt
	fpzwa5ueYacbgK6wRPkirFvPi5Rlq1Y4x6yfRNW5pe37uInwJusN1a9k4c5Tegm3
	iZW4ZOyr/1syAFV9lxheaVcdbIQAhGbkVpvn2WlSL/FYakF8vb10daKXr+bII4WN
	OE8VvhteGjnd5mBXmLGrp7YBiMavfk/nEXXZQBolB7c+kEZR5qpa+ZI0XLJrL5GI
	/ATp94zs2/SmXH0gDdQfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214221; x=1756300621; bh=p
	T437oxSDg4kaBMbY5yyX/KNVqQcUQ4eAv+jtuZTkT0=; b=IOTZ18nor9k/MdKqs
	pR+1p+2L77CzooAh3eZervjzzXMFcREXL6rcL4C1Af8yt+QkWdvE0st0ufCtdx5W
	93r8i3P/W9xD6Y4VQOZJJuLDEwGDUTktU1dTYFzacv5SrQpa6rV/nD2uPMNk5YVt
	nPaLeZOISZxXIFwnOYOtx0TLt9kNZgtpVk/Av0Av7YQAs78+lRLf/iZecmHTMntE
	b/WN31Wzfp955XXqYo2mDYX/XEUp2kqDMKcjgRUuRXZsH3qK4a2CaOjd4fSWlM8z
	8bFMRxqzHbViPdfq1kZU3gsZ0ogiroa1E5uyLzGdXkJX/yr1sAalzCd3lBZJY280
	L5KPg==
X-ME-Sender: <xms:zLOtaO4gNoKzPYvhc0GjIILWSKIWhkblTwuZ1SYQdlLo_v7fNw_nXQ>
    <xme:zLOtaIHPUgaMCKfRP13kXShO9WiTEjb64oGtziq2lEM_K6u5P9SRfZmOH3Ws86U8H
    qRFoy9txgNmxY_KuQs>
X-ME-Received: <xmr:zLOtaPSIdmiu6xB8J4JgGae2WaLTZqlO9EOGTNgCWZb_NgOJCwNK6dpzmu_R>
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
X-ME-Proxy: <xmx:zbOtaJsFOryD1QPCWL0EWHSaSQpGvOLszBdWxgV5RebkFfJjauUujw>
    <xmx:zbOtaGyQOXgK1M1rJlAVWpZcLAO_e5PAO7WjkHzzqQFblT-yet5Tiw>
    <xmx:zbOtaL44aI_pSWVZBhUS6uyuZJ6OAoAwQsgdrSiADD7Y3n34eB6LNg>
    <xmx:zbOtaIXUVHfJrRpS5dmWBq7oaftBBXzpOYV26lMwj5y001f3KIadsQ>
    <xmx:zbOtaJcr4C0tPzlxM9TnkCI0vMnTPewCoXFdjqyLEaZKfQEhfCM6oKDz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:00 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 05/13] macsec: use NLA_POLICY_MAX_LEN for MACSEC_SA_ATTR_KEY
Date: Tue, 26 Aug 2025 15:16:23 +0200
Message-ID: <192227ca0047b643d6530ece0a3679998b010fac.1756202772.git.sd@queasysnail.net>
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

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1b59f2c6b393..b613ce1e3a7e 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1673,8 +1673,7 @@ static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_ACTIVE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
 	[MACSEC_SA_ATTR_KEYID] = NLA_POLICY_EXACT_LEN(MACSEC_KEYID_LEN),
-	[MACSEC_SA_ATTR_KEY] = { .type = NLA_BINARY,
-				 .len = MACSEC_MAX_KEY_LEN, },
+	[MACSEC_SA_ATTR_KEY] = NLA_POLICY_MAX_LEN(MACSEC_MAX_KEY_LEN),
 	[MACSEC_SA_ATTR_SSCI] = { .type = NLA_U32 },
 	[MACSEC_SA_ATTR_SALT] = NLA_POLICY_EXACT_LEN(MACSEC_SALT_LEN),
 };
-- 
2.50.0



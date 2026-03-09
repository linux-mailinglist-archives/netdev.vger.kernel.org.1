Return-Path: <netdev+bounces-265471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGExOxKirmlIHAIAu9opvQ
	(envelope-from <netdev+bounces-265471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D62372B1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A53E30217FB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DC3921FC;
	Mon,  9 Mar 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="FGRCEITv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z6raCYhy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787593803C9
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052396; cv=none; b=isWB/7CyyvK2yfhMy8unBKd13EhdF4dUeZMEmrj/lq4v6MDF1BSUcRMjtUprPGH8pEOfnvCOGPmt/Q32QMctkOCK3MGcK+cf9ru7OnovGc0i+DSdAgyM1vuH3vUnoc2E0pGHp98p4um3Yqw6+HBdlHSPqqgHIFmJICu4Fl5hjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052396; c=relaxed/simple;
	bh=0MPE8XyH99rjpZKLWeGjM9VHcWXNZIdoNwKdjbWTt6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL/vh7ZvAsapfIiFYZLxcAu+lL3amov0WYutuTI6Q1wxHsZ0jo6o7q7/O8qS8TYrYrxeVCCgtEkrH0405worTYTTMwxIdUUYfvH8sucrv5V5yybkHbOWsz5APp5ABbeWC0A8RXWow7kJ0WS+D58Y/xkOdOWwSaGi5Yb5fthZp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=FGRCEITv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z6raCYhy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C192E1D00126;
	Mon,  9 Mar 2026 06:33:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052394; x=
	1773138794; bh=a+DO8deMQexpEiLwFUTg3N/P3cpcplaUj1scC8ro6GM=; b=F
	GRCEITvJhqtfuR8a0pFqXq+HMCXRhSq55ftxTUuT1Ml4LQ2Gt+3auWfjxuhMU04U
	krvd9WC7isOH5ev+KAGPkPHuzK2eEgdY2yuadLWipLbrayMe0s2R48tWsHz2zKRv
	dz/Sgg0k2FiSjlhB1OdCE5U/LcajegKb0ee0AvEvQp9NMI5ns9IXwNQzNdFJ0cCH
	J+bjXfelOAMQFo7NyLQWRnSPiRrM3P0kiHEd7mP7nTnNti+YlPF0EphsfulTjUOK
	owcQexAG5hK7rd7JCUbETNbzyUmfXFEOzuB4RavUDAot/uqs09zMxnQRwqLJiCR+
	Cc05sFJNj0WJlEQlQRN/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052394; x=1773138794; bh=a
	+DO8deMQexpEiLwFUTg3N/P3cpcplaUj1scC8ro6GM=; b=z6raCYhyySTubW7VI
	y100HBlzOHAghSAerrlLafSd4wCo51X6sE/214ITZ5o2QgSsRnt2TrUaUnChyKRg
	WQudwFD/p17/I0Hz0uizW4FJ/b7foMWfT9vHbiaJ6UdbHRJlYK3UHF89xCW8XoTE
	2Pk+iOL6+BEtnnX/uW1/e0xjUSn2VHQvLrStRyHbXNLJ9CDijTvRVXrpuTsMjsac
	CPyTrv4qEpoAd70qoUhiPeq4y+UAJWNZiptdu9+v/d34C/PHvLQy3QJSyfKQcPeJ
	kXQLEc5E2iMoXAABcliffbIFQuPzoqxLD+XSZWVEzmagCVd+VxmKYSjaQYPKls3v
	50low==
X-ME-Sender: <xms:6qGuaYr-UID7iIo2WkDLvX_YDXyiXo0GlMOmbIAgv6qljquD0oM-gA>
    <xme:6qGuaaGq-ggRVoHlnHgcI2fc6EVtClCE3gwSC8-uLyzZ1KgO4MI9KK-OvJkDhtl2k
    Aq1AoTRghySQ7f0EnrPglyBMTgwy7Aq8eTiJdQEEjpAxMSBY5UPFa1W>
X-ME-Received: <xmr:6qGuaQtgXnrobmpxrDspoppMEIYjfXxzfcZHa5M4lD6QQgxJEh5niJoDPF2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:6qGuaUWtyRNtkbjgSpW9lbiLDD0jaVjI5ZIcyUVNTM8UoWrPTOQxvA>
    <xmx:6qGuaUFXOdM6nLN1Erwn9Kyrv66WxzyniR0IiRkwF_ugdWj7pV_yGg>
    <xmx:6qGuae22W8efcR7FcEONgcyyqqWokbDf1kVjS66F9QcPZxRSIatIuQ>
    <xmx:6qGuaeON96V7o6CmyPh1uuEi9E65uK35YpXclNGUxnBBgGXmJIyKIw>
    <xmx:6qGuad_fycmv5WL7yijUnkYyyAKC5tRhEf52gpA5oaf95ggkNiN1z2p->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:14 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 09/10] xfrm: add rcu_access_pointer to silence sparse warning for xfrm_input_afinfo
Date: Mon,  9 Mar 2026 11:32:42 +0100
Message-ID: <0d4b2a553e6541cc94a7f2df0b8c58a452b1c190.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B4D62372B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid]
X-Rspamd-Action: no action

xfrm_input_afinfo is __rcu, we should use rcu_access_pointer to avoid
a sparse warning:
net/xfrm/xfrm_input.c:78:21: error: incompatible types in comparison expression (different address spaces):
net/xfrm/xfrm_input.c:78:21:    struct xfrm_input_afinfo const [noderef] __rcu *
net/xfrm/xfrm_input.c:78:21:    struct xfrm_input_afinfo const *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 4ed346e682c7..dc1312ed5a09 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -75,7 +75,10 @@ int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo)
 
 	spin_lock_bh(&xfrm_input_afinfo_lock);
 	if (likely(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family])) {
-		if (unlikely(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family] != afinfo))
+		const struct xfrm_input_afinfo *cur;
+
+		cur = rcu_access_pointer(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family]);
+		if (unlikely(cur != afinfo))
 			err = -EINVAL;
 		else
 			RCU_INIT_POINTER(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family], NULL);
-- 
2.51.2



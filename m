Return-Path: <netdev+bounces-292727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI4CLB9VGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9DD5F3E7B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 814BE30E5A9B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09F3F0A8A;
	Thu, 28 May 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="CJfeCqS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69C3E5EE1
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978909; cv=none; b=OUP6rp5fxrWcHu/Fc5ruVY5ysJ0lAuxFAxNAyvWikVAaiwPL+V5jwE5u3lx8bRwtL234AwbyiogpcKU9vy4jV3Sd6rx5x919mkqen7qIUOySULdlKucJO/wV633FyiDRnMzeeQtEjj+EQ5ltgYggw/owiaSQyQDbUV21LM3KqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978909; c=relaxed/simple;
	bh=UR2E/C0im6l6T98H8IXvdVRK0YqkWaJLP1h2nNkucBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xjtvi4zEUjT3FeyKUckNd0yyOBhoMs1aIRBDe3p7/Bjlse6fIZPZiJn0wi4uyLiubg/gNiSnSBEvuZWWqg3gvoRgIFa52G21sIzpW6tV77HyKOFi5GCLZEaDjll+qEoEhaDfmN7VnASNQRR5iAkAwG7tGguyhy0KCHAuLqTb9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=CJfeCqS7; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=CJfeCqS7qikt2c3LdpYPYqlxIpfI35QRvdNQbCtRbx3qLRoKQYosfz1XlptkxqR+/hNbmJ
	OWP4C2GJuKA0O8jF4gOodEZZg7zzlOjtb1c5+IJif0tGhsmyuZdACesJrEnR2PF0OU+qNo
	pJI1RRUsMbtGnO9qNBypEDQslQM6uKUbYiGraQ80MPlHEdRztpq66TQkRhXXzt3GM3K/NI
	nNJn/KGK8K1SZBgr1HojXXDPKwhrwo9BMoKg4wi+7S1I3EvB4fezBGPYdRvd6mEhM2IYP4
	1Qr2IUQn16zYIO1Ypa9kPk1kjmwC66nc2FsnHezoksBSz4whezDA3HzbkkR06A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] MAINTAINERS: Don't send batman-adv patches to netdev
Date: Thu, 28 May 2026 16:29:12 +0200
Message-ID: <20260528142924.329658-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292727-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D9DD5F3E7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Do not send batman-adv patches directly to the networking maintainers or
the netdev mailing list for initial review. Keeping these patch iterations
off netdev reduces review load, especially for patchsets that require
multiple revisions before reaching consensus.

After the review was finished on the BATMAN ADVANCED mailing list, the
patches will be queued up and then submitted to netdev as PR, including the
full patchset in the same thread (for the last review).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 741fb4166aa2b..75ff01377fc6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18635,6 +18635,7 @@ F:	net/
 F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+X:	Documentation/networking/batman-adv.rst
 X:	Documentation/networking/mac80211-injection.rst
 X:	Documentation/networking/mac80211_hwsim/
 X:	Documentation/networking/regulatory.rst
@@ -18645,6 +18646,7 @@ X:	include/net/iw_handler.h
 X:	include/net/mac80211.h
 X:	include/net/wext.h
 X:	net/9p/
+X:	net/batman-adv/
 X:	net/bluetooth/
 X:	net/can/
 X:	net/ceph/
-- 
2.47.3



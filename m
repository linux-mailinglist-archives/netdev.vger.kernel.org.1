Return-Path: <netdev+bounces-293740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOsRIw19HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FA61F5C9
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43F9F300EDB9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7A37DAD5;
	Mon,  1 Jun 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="vz759esL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D0379EE8
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317414; cv=none; b=NRkF0h5CXaHX14hf9CkXNh6XS5i8+J5hRLk/kgLooROpGdi9ddBq1E+e1kJI3i46JBlhkK6R+W+2CUFnfl9r5oGMxAdjlQePWOjmdSq4H0xj7FcgkOmVOcbjEbSHIeA3ft6fMUzJDLOPL1olJn3TFkOJvxvKAhbwhWmgiOiCTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317414; c=relaxed/simple;
	bh=UR2E/C0im6l6T98H8IXvdVRK0YqkWaJLP1h2nNkucBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrgOnodiZ7vgTneVU4vTOv/KPCNxiVoZlBwXTLGu5i9l19TBeRO8ipOIbKMt5xpyh0LuKzK0J04yhdpTRwDpJ0EKBduMeHqCH7I8e5rkejmXeyIdLCywJxoauxJQozrvFOc3XrSbsay7nN4mmiogYA7EG/aKx7MWdXbFznUf4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=vz759esL; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=vz759esLIN3EOkBpyGzcOP/frAJ/4SSguFrP7K1GpzZ84AIU/KuPm9nfsov1MvC8HjUeb0
	qIAQXCQtCWrhn3VQiK00Z46TYhc1M6EYHus5k0qoh5dq3Iah19hwZsnCiPjUob80w15Y3k
	If+gJBWj7o1w9da9BXnqZUKWYzmxMew5asxh6A5hQ4N4Hps5EkhDYqBEWf5lwGZztmDHty
	8x7glnvUtKVBX0C+D0UWWJqXnRY5VWwJaoAD5u2mEKc154JPFk7jvkyNYPKX3+sc7Yzafu
	z/5d+IIigtrg5zLRRs8yUo2b6K3Gz33hlUcGuUwR5W+VTxQLPthAN1oGH0sqzw==
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
Date: Mon,  1 Jun 2026 14:36:17 +0200
Message-ID: <20260601123629.707089-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293740-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim]
X-Rspamd-Queue-Id: 244FA61F5C9
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



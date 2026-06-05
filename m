Return-Path: <netdev+bounces-295680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFvXBot6ImqbYAEAu9opvQ
	(envelope-from <netdev+bounces-295680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B6645F78
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bWwsArv3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295680-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84DA9302AEE3
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC147B422;
	Fri,  5 Jun 2026 07:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373A472775
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644022; cv=none; b=eGUG6I/xCXVPaTMPDfaKhUvKvaL6BcrwptBDkLXfEBoTHYAVcOT6vMLti0FTYjPgSgCZUeedWMapeBVAjOhfR2rxKjj0KbnOK8GCVxqMQgje+D6+rtdfu01Dt1+77edbSq1vrsmu61HSFqFQDu3jMRPuSsQoNy2ChZSqnPiImmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644022; c=relaxed/simple;
	bh=6wxIf4iVWK1x1g7o6BZMvgAjpP3p4hgZ9/6fRW7KVk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGFK3CSODT8vY1swUSXhz7rP+XxZ3AWz+JHSoEB+yMNnL+K40+WL2pOmY79ARsGOSBwWtsG1X4ykMO9ZN5ro+tQwphG562hCqNIMQuWqgK0mBGxp0I/QUb6VuwIjJHLQTEqa5z2Gs0Mjnz6/P5nfSCeneqO9pdTVOEVeZW3pnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=bWwsArv3; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Min51foF2kElplOUTaOkcqj5GJmfwEQQHqIG5in0FV0=;
	b=bWwsArv3bgYIz8xIy1AK/pUEVTmitbggph35VEwNo/2dnvjiYQPn84R6HMrFAMgjUszKlE
	lZyztpRKDerEKmMTKKQZtDC3WuEb9JTMdwEu0KDLD2vMlYSYkW8vuAarFPBdjXzlLRsfGC
	nwGYWvMsqZ9oK1ej+bs0YvAdOKf4dF0Qpiqj4Dm5c+4NUCgf5UA5vLYdlaiTAHeeSmPoCj
	+QfwLLtAYFEZPFtfmoJ11bEE5s88Yhfs+Mp/BdRy6d9ovP2k/PjiOKV8cezVQRbi5uKx4i
	XuN4i8EjPAoG9s+QWuOxKFKrW5Ch00GdL/TQGsHD7m+2DtJIEOnizUDSQLOc5A==
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
Subject: [PATCH net-next 10/11] batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
Date: Fri,  5 Jun 2026 09:20:04 +0200
Message-ID: <20260605072005.490368-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295680-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,narfation.org:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 104B6645F78

From: Sven Eckelmann <sven@narfation.org>

All receive handlers in batman-adv are consuming the skbuff independent of
the result of the handler. The "(without freeing the skb) on failure" is
therefore not corrrect anymore for the current implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 72ae8ffc9db65..14920f4bb315b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -984,7 +984,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
  * @if_incoming: the interface where this OGM has been received
  *
  * Return: NET_RX_SUCCESS and consume the skb on success or returns NET_RX_DROP
- * (without freeing the skb) on failure
+ * (freeing the skb) on failure
  */
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)
-- 
2.47.3



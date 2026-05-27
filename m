Return-Path: <netdev+bounces-292349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF/CGu8KF2qH2QcAu9opvQ
	(envelope-from <netdev+bounces-292349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:17:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 002335E6B7A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEFE130BDD17
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE542B726;
	Wed, 27 May 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CK3b4fb8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQ5KBl94"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79387429825
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894645; cv=none; b=ROf0MWVIYyCl9Dj0cddbSgqqffoBv7XCMmUoByGuTUubNcNh9JyiQTsn4eaCmVCeF55urOohY6e5mNeu7ODUPpVSsGJVtRE9KlQqxQUIlJ/RQs7P//EUIm5Gyx20BRjFSnSQKfh/8yMj7GVBZ7RJKvJLLZqqTHaQic92MMbZfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894645; c=relaxed/simple;
	bh=/Vr8MUDHu7F6px4gQMtOKL2jRf1NKTge6fYFFNck7M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3vU2XV7gwV48sGIE7WwGcIJeqcPjn5dSN1+zd671FDSyE7JjyzDYACX3y7SWWeYW2br1Km18Peyu0312W+Mn7swAobWQ+Ysh0ywvd7KKRX+V+aJ1xYBj347RErcPlaOwHnQ6EN2oi9LlSmGpBEjn0DGI4OaU9/p+41PLQBIPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CK3b4fb8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQ5KBl94; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGm0hYhahD7tucU4+kR0zzN+Asi3TlqSb3PAzu30CHE=;
	b=CK3b4fb8KpuiIBp1RljYrFcMSQ7a8KAl3QiPogjq06e7l84jvC18KbGxILxtJ9ePV4HTO3
	Bm1DAQB/kXj1kdZdfpW027948SJ75sLsg8e05k7p6W9R6mj9BQ2qDZ2Tw4n7n5D9zDbqAF
	P/cXkw1K9703q6ecGeXQ7nZZRIxTBlmrICGEDuD6udpVSr153buQ2wnoFV84jFnjWjEgBQ
	anO1X7bgMtAV4PZq7Gf36QKgi1uSRM+jG15jcXdsHQMy7hCxZ2p5/WgS4gIbZ9Tc0IMt0y
	7SSj0Y902ObQ3rYx1tFI6uNP1x8438qhkdeRq30s4yeAw4Ggr/ttcdNdpombsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGm0hYhahD7tucU4+kR0zzN+Asi3TlqSb3PAzu30CHE=;
	b=vQ5KBl94Ki3BlwQzMODsyGdTMTueP5lfCxPBr2s+TcUVkCl4ZVgCz/aAUFulcv6kdsi9Jr
	rLZFapgOVBasmZAQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v5 7/8] hsr: Move struct hsr_ethhdr to a global header
Date: Wed, 27 May 2026 17:08:57 +0200
Message-ID: <20260527-hsr_ptp-v5-7-158a7633eac0@linutronix.de>
In-Reply-To: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292349-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 002335E6B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the offloading case the network driver needs to inspect the HSR
header to find out if the encapsulated type is a PTP packet where it
needs suppress offloading of the packet.

Move the header so it can be included the driver.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h | 5 +++++
 net/hsr/hsr_main.h     | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index 1db1bd0fa181d..bdcfe88e023fc 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -49,6 +49,11 @@ struct hsr_tag {
=20
 #define HSR_HLEN	6
=20
+struct hsr_ethhdr {
+	struct ethhdr	ethhdr;
+	struct hsr_tag	hsr_tag;
+} __packed;
+
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 134e4f3fff603..cf0a3c76a217d 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -72,11 +72,6 @@ static inline void set_hsr_tag_LSDU_size(struct hsr_tag =
*ht, u16 LSDU_size)
 				       0xF000) | (LSDU_size & 0x0FFF));
 }
=20
-struct hsr_ethhdr {
-	struct ethhdr	ethhdr;
-	struct hsr_tag	hsr_tag;
-} __packed;
-
 struct hsr_vlan_ethhdr {
 	struct vlan_ethhdr vlanhdr;
 	struct hsr_tag	hsr_tag;

--=20
2.53.0



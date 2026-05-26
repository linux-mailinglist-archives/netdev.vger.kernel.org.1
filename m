Return-Path: <netdev+bounces-291818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ai0NGbIFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0195D9913
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F11A304CFC6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452193AF657;
	Tue, 26 May 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rve28ga+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AA3AFAF5
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812258; cv=none; b=fZ7COs+7rIoalkvIKmXS5X1PjgvMaocyBOtNPzDyYRw2Ir7oEk6GI088FLIch1Wj69m4CocXMux6Fb0yD+L8hW0eeVpZI0t75Ooa5mSOTEMB2q0zRXzc7FPiXQIQdbgNkIpVDLyajGaynxjGIIpZEiO+nYmXy7/KHqz1eZRtBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812258; c=relaxed/simple;
	bh=RgO/xF6ivgTjLS8eTr3tYoc3voosxCkLiwLkMaf3Zcc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fN8PR4+KYpYm3i4RyNZ6r++1ldpLJQ7Osmc9ZwgpJjh6nHMAEDLm8iPCo5BHnsft1V/OQt0ZtEqC43ojgz1m2ABLGJDK7UA+IW1dsqh8mgCF9uFC+UnY0jEb6VmlK7Xme5PQIa+UcWjqCKJ+kPH5I91I0D456PDWRxoT0vGJWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rve28ga+; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779812247; x=1780071447;
	bh=DodzDfZ2mSsiymi+WvOdbdnqcD9P0WO9Nsrr5WlGLjc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rve28ga+xRm4h7X+tpSNi57YJZds8fJWnyJ2Z9b5TICvPZxaenTbhNcpzI34IUmlp
	 FU6wBYkIm7CKTgkuC0ma5zj5XB2aECpYWjiXNXm7ReplCtMoSneT6MxPBNejhdSDcC
	 Ks6s9MLj0UWqscOYeOl3KNbIZvvn9B3UaRsIObIQejiX1BC/gCvFIFTlNNnTC6OcOQ
	 Tp+Oz1YfNw1Sw8i/8ETL2HNDeRFfGmJhOra2kAjBMz7jWz2kjcOOzFD6o2hRt1BjhU
	 76u8cJY5wcdzyAX8acR52DwHgTSf/DnF78KE6t9y0+MsBBlOCuSyh2C/92CqUS+Cx3
	 7aF4w38Emyh6g==
Date: Tue, 26 May 2026 16:17:22 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next] doc/netlink: rt-link: fix binary attributes marked as strings
Message-ID: <20260526161641.459869-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 48dbeda967b64e3ed87c8dfb43c0039a503680c9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291818-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[protonmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 4F0195D9913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These link-attrs attributes were previously marked as strings:

- wireless - struct iw_event
- protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
- cost, priority - unused
---
 Documentation/netlink/specs/rt-link.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netli=
nk/specs/rt-link.yaml
index 79c89f204..6b8d5af41 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -880,19 +880,21 @@ attribute-sets:
         struct: rtnl-link-stats
       -
         name: cost
-        type: string
+        type: binary
       -
         name: priority
-        type: string
+        type: binary
       -
         name: master
         type: u32
       -
         name: wireless
-        type: string
+        type: binary
+        doc: struct iw_event
       -
         name: protinfo
-        type: string
+        type: binary
+        doc: A nest of ifla6-attrs or linkinfo-brport-attrs
       -
         name: txqlen
         type: u32
--=20
2.51.2




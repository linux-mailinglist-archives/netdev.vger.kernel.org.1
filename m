Return-Path: <netdev+bounces-291971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCrWIjEnFmq3iQcAu9opvQ
	(envelope-from <netdev+bounces-291971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:05:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E085DD6A7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2487303FFA9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AA3C4540;
	Tue, 26 May 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qm2rlLWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08057211A14
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836712; cv=none; b=X+YBDTd7p1pUX8Ws6UP/usWUyr4p/zbEhUnlEpI5c3oHtlGz5ImK6LRxMzWB6Fru+ZpWXwXuf/aEydYzQmu55WxMPORFDVSVSGOkSeKoIqMIjcZ3jlRXPov9ThVddQsnpD37ffXjFuCjEeQxmdUr+rCm79S3cQjqZScnEOdTEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836712; c=relaxed/simple;
	bh=UVNiu7k1ZLaRZ08/CWaUu8pz5M/OH/d8mtcOhbJtVIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ILhqJ/jmzVKppOcZhjO46lMhQGrgsc+pATBscg3Hew0dXDH4cTx/txA8rpmpg7uRJ5KKw/VU9i+YsYLCod99BI164zBCqUo+QeaUfr9WgCHmFH7XI+1QQb9VveliVHNQQ0XFM7xJnbe0Vj0RvEBh/Dlft5A5yrUE1RhEiTpu3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qm2rlLWt; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779836703; x=1780095903;
	bh=XSmAhcXAbOo7ZIzWDZmuQSZ4sxS7qpz2n1lYbEwGnuM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qm2rlLWteNwipFntR0bMd/RNT5fAzddyPhleGvQWfNN6cNY46mcrQD3/rEt/odK6e
	 up9Qb+hM8tXR9Ke5W9p22xmlK5BtJIBXCalYIQkPKmg3Ztr+VfVdTcFIkfv+3tDuTE
	 kyd7YmJKuvf1R6ZMaNnh5VYD5nSi4wnO/cll3J+PoTwcZagWDEy+2B1qXkhcaLLc8m
	 K3okcKn5xTZg8Wwq/wo5XI2HoLrkL0o7RWeMsXUEL+tWU8yZf3k5Q4+P+rkHAs++uI
	 +eOztUrmXdxJfxKZDTDxn6/Xme/4h5HXh6lgLUgrSIBog9IRUyZT75g2/GSRZi2Bke
	 MuHbrVf2yP7QA==
Date: Tue, 26 May 2026 23:04:56 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v2] doc/netlink: rt-link: fix binary attributes marked as strings
Message-ID: <20260526230321.594068-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: de6f9c75c8cfe3a4c6d7713ab7a65ed8a32671e9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291971-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[protonmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: E1E085DD6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These link-attrs attributes were previously marked as strings:

- wireless - struct iw_event
- protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
- cost, priority - unused

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
v2: Added SoB

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




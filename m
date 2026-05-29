Return-Path: <netdev+bounces-293105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBF9I0aDGWobxQgAu9opvQ
	(envelope-from <netdev+bounces-293105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E36021CA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E463038B88
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CF3D3D19;
	Fri, 29 May 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fQfdY8ry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31933D7A01
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056900; cv=none; b=YJUjW8jK28lSNddOKrudn8eWWDY2Vo4jOhgrq5+NRZ5sPysm/tjg8j0v6ngnskVTt+ryva0+TjD+Tv/ItvC1tA0lwvmM8vefG2IX2jIYtMMQZb8occNpWPVdLE84vG+SmhTu5COF4E5XzA3FFevdTYLrOw5gdccKdAPNXwJ7cLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056900; c=relaxed/simple;
	bh=rjH0iQ+B3CvgOEq5RvwB5Xi++xE8paRc6J3+du4Nrdo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=q01V8i2ndzqVLukjoLIYeBTeHhv6khIN6ZsCODkJrz74n2ZJJM0XLQ+Wp5MUJLF3ED34pGSzpKOO9WCogF9P5tTx2LSpCXioiprNjfqmwfWtML3nJpOMrXB6OHHQQxur/R2+L7M9YS7yxJPJ0l8gQx8oxDJR1Ic40bSLo1XWem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fQfdY8ry; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1780056890; x=1780316090;
	bh=GtYZY6ctEkhlw/clHSGZnPXQm6XBZHAzd/Nny8lRIuE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fQfdY8ryGDYiYPGcYR1qvNqpAL6UuVXPfv1dK7cUJMeIYKm3QY91j9h6xh31ePvLi
	 zvDkYGQJJPKNzKESOsC6qQ66cHGXZDRy+QdqevxG+/TQ08iz/nhOyBzJPOLRZSww+y
	 AEmQpEg/SIs4nKCyFsvaVz+DD1Y/0BmEgqJCZZZNXjSZB/ImcqCo94UTE1lONxNSQm
	 x09zderOinULo+8zn9eetmdkgi0ax00S1K1ZD392fypSZnBmqfPhmhW3g3Qp9pG4B5
	 /+I2/Ba8juqBbCnjOUpyl945IZuukZNL9r5h095XutMzS1Txt3wMgrEEYJ3UoINyOy
	 SRSPL/ri4bfXw==
Date: Fri, 29 May 2026 12:14:44 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v3] doc/netlink: rt-link: fix binary attributes marked as strings
Message-ID: <20260529121355.1564817-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: a5b4cc05216ab9d4745627e4b00981349ed37511
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293105-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[protonmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 347E36021CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These link-attrs attributes were previously marked as strings:

- wireless - struct iw_event
- protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
- cost, priority - unused

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
v3: cost, priority marked with "type: unused" instead of binary
v2: Added SoB

 Documentation/netlink/specs/rt-link.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netli=
nk/specs/rt-link.yaml
index 79c89f204..a5c029781 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -880,19 +880,21 @@ attribute-sets:
         struct: rtnl-link-stats
       -
         name: cost
-        type: string
+        type: unused
       -
         name: priority
-        type: string
+        type: unused
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




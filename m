Return-Path: <netdev+bounces-222797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C65B56152
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30771566FB1
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5022BEC4A;
	Sat, 13 Sep 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="bhUVDTl5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF6EACE
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772343; cv=none; b=Z9sEUTeRmtQUayOJqcjS6HxjQ6QbSwqdXc5m9ESxZ4VRfqlNGFJ+3/eVpXo7lbMSjLQzpJbtC4gg2fYU8y1F9oW/2C3wkg1D3IFbp23LPzJQjrFNJwSoI+AnNoexLjjFXYDJ4w5chVZojtkezDpucrL/icOgCY4HEE3Gou8w85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772343; c=relaxed/simple;
	bh=YsRRPq64b682Hjnrv0A0If9d9mzfAykTfuO9g9TCdpY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=j2U0OiyPEU+kFA5COwvLRmoEAulQePilSsxn9VQAJF/aSr6qUKSr8jXZ6oTtxh7KLU/GcawenGQ3NLyGcmMPHK4odgXf0jbFiADej/O9hOfrpezZFikAw1Ad51kVtgLq39SQo4Y9oyt2LAWSF20C8gfvt3vOZWkL8DXBz6LipTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=bhUVDTl5; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757772332; x=1758031532;
	bh=2EM3CAzKxoFmbHErKWr4jVAZejLm4dmCrmDJeXhd70U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bhUVDTl53zbttdp0nnEhiJdd9da3ySdfDwsWM3xa46aG9zJqeReNoHm0M/gijFVDa
	 swGkNOuLEKRZc3OjgYuRjcz7q3gWk2S/Swro4gaUC16Er6PHxoxgd31w7RBEW9t3nb
	 NRfLvvA+JDhys4Dd/ilD+Foq4nKWye8RQJqvDIqqRxgZ9cI3YQqO/ep9udPXUbyVV3
	 xRAJECcYBNazCWZyWKdu1JhcPHO0MyG+e8a7Fu0lR71oPAgbMWyzAMsUuTVihwCFau
	 +WQyYtU8KqFfOx1PSXSHmriWA1as7BiAxG9VTWN+Hw++yNKcpSsRx+guF8Ienkspxe
	 LrpWBRxGCiQOA==
Date: Sat, 13 Sep 2025 14:05:28 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH] doc/netlink: Fix typos in operation attributes
Message-ID: <20250913140515.1132886-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 74a898a89a48ca2021a41170b6ee955aea239b64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm trying to generate Rust bindings for netlink using the yaml spec.

It looks like there's a typo in conntrack spec: attribute set conntrack-att=
rs
defines attributes "counters-{orig,reply}" (plural), while get operation
references "counter-{orig,reply}" (singular). The latter should be fixed, a=
s it
denotes multiple counters (packet and byte). The corresonding C define is
CTA_COUNTERS_ORIG.

Also, dump request references "nfgen-family" attribute, which neither exist=
s in
conntrack-attrs attrset nor ctattr_type enum. There's member of nfgenmsg st=
ruct
with the same name, which is where family value is actually taken from.

> static int ctnetlink_dump_exp_ct(struct net *net, struct sock *ctnl,
>                struct sk_buff *skb,
>                const struct nlmsghdr *nlh,
>                const struct nlattr * const cda[],
>                struct netlink_ext_ack *extack)
> {
>   int err;
>   struct nfgenmsg *nfmsg =3D nlmsg_data(nlh);
>   u_int8_t u3 =3D nfmsg->nfgen_family;
                         ^^^^^^^^^^^^

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/conntrack.yaml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/net=
link/specs/conntrack.yaml
index c6832633a..591e22a2e 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -575,8 +575,8 @@ operations:
             - nat-dst
             - timeout
             - mark
-            - counter-orig
-            - counter-reply
+            - counters-orig
+            - counters-reply
             - use
             - id
             - nat-dst
@@ -591,7 +591,6 @@ operations:
         request:
           value: 0x101
           attributes:
-            - nfgen-family
             - mark
             - filter
             - status
@@ -608,8 +607,8 @@ operations:
             - nat-dst
             - timeout
             - mark
-            - counter-orig
-            - counter-reply
+            - counters-orig
+            - counters-reply
             - use
             - id
             - nat-dst
--=20
2.49.0




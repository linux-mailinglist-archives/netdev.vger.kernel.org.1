Return-Path: <netdev+bounces-283635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHX6EiJ492mUiAIAu9opvQ
	(envelope-from <netdev+bounces-283635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:30:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF84B67BC
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38406303CA52
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B33CD8D5;
	Sun,  3 May 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI+J/Yob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6B3CE49D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825595; cv=none; b=Dj31m6Vx+bk8YfezizkB5IpMVJW0Yu9vNZDHvf0w/WJ2gguVSczei5ya7EeTSCGH2LUmqJMnFNM6g/PItM9q0ltp+h490qFgQHpo7LmN9kWRzkbXkll6nISxmi/lopeXcHqj8FyUY33Mr3awyqMdjzkPR6aTiSHxkl12jb7Ev5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825595; c=relaxed/simple;
	bh=ytJNk6Sp5oqo2mhDyk8PHPFkvKfco1b3mZP7WKRR2TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFPTgY4Su+8hoe5draJeUjGITmnyx98fFjD6HieFkSbBmc3lg2Yj391yYhvkukZHUhAYO3q8dFY2AQ/gxuNd1WZAo4b5ECKjo2CHj8XitOl03Mh+3f8JpKqbwCpEF9twwjHM15q4Jp997a5HeKt7TvBbOBPKEKCbE8E4FjascqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI+J/Yob; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so2263346b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825592; x=1778430392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGj4HzPbiY0MFbpVfiKxyLwbBa+PWzq3vhH8Hs94Z0I=;
        b=PI+J/YobHQWKAp6UM4i8nBLtmtUsqtEnWVKsKYbttfAkw5fiA3mgH8ayDPK0n3R/4l
         aLSJ9TShFc94a4PoIIFDzmuL9AyEKQ0WlufK6uA2rzjaw7C2lino5YUBDw8L/N4HvGjN
         dNNbmY4+u1cYb2mE/u/LjLgijwl5LlF90fwJYO1YqMEbSrfoT7M7HXQUIdwfYtXwLZ+f
         3ocoW8M2I2gvF47cT6yoflLG6qjyGf9WizYsZoF5RZJ3igabqbYm8QX/ZUh+Np+bIiFX
         wVJHHM97Y9iNdG7Z7dotkW75GA92F3EXPbLpeejfnwbxI6iJXP2J+j38M+tC2mzN+nW0
         dUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825592; x=1778430392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGj4HzPbiY0MFbpVfiKxyLwbBa+PWzq3vhH8Hs94Z0I=;
        b=pCYreH5K+0SRcO4ofv1PnsPc14pMIwU1V2QknO1M8Te9XGprFXOqtNWEpVFPidpeZq
         bVgVZG4lnQfbiIWkFLMkcTBsEejhU3RXXoZvRS1Sa613lw/CvAY3uChMTfbtVIzCQnV0
         StbuyUMccmZR9yJ+dPLjcHmUgKDtRW3LEE3akYPmD5b5+tu0KIPe6QIvFXtwEGwXqAiP
         AxVi9vsF0SarRtQK2hQQVeGKVOYL68zo4zd92gK/aw49WPruFMLZbaX3rnLvnUYm7K2C
         2Y6JM09t8xR0xl8w3igN1Oi9kjt2PyAwxJ60w6u77n7rmoPjJmBZtioVXvUSMe1WFeii
         1ilA==
X-Forwarded-Encrypted: i=1; AFNElJ+wrNYorzdqO1AaIGR4UKe3+7D6b/U6cLVFjqkqPd48sGZNY62sDIJw4oUOXHNv9oBxnqmLa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguB3paGBW4OA7B98vq7OjTZNFmYVVWzYOJyKZNWQJ6gQASj7h
	6nXX/XUgB/l2e7hvbVKstlWcyBHrjFOnfOXuacH94UaIiYAlk4nN2OXS
X-Gm-Gg: AeBDiev88+5vjQOn+WGwHUyuK1nPLxpkX9S01//fYW993dokiNGlwbO/+62M36BNcdV
	gHp6np93wS2EAQjGisT+8leIhcpk2kmx3kXOQzL3jcFCctrspODkk7K1JQOvGKcLc1uAGWZFo92
	5Ru0IWEz6Ozw6eZtxbiBXK0r4X8FL+Di+KQURUGcQjiy39MLBFoolXW7KwYdkipeeY+cZ3q42ht
	UUVSSX9zTuEvMuHnQpxemhMd8FdjIQD/utRPHeLZI/t84mbPpU26x7dddZAJnEQUOIi+iHCa0qt
	3QEkjq8FFskKOl2RIShTnM8+roJzUtYH2L4qhAf+k45SwykKgYbjHjVL84jLN6mekRPVIAHnzRW
	FCUbdsQJWVZDCOlnGuvwY62WHExv0tzjW9tufEXlqwLKYJK+j73HaAgwyNyZu8MMBHtLQCwr9JA
	C5e8jA/O9DlM+uyxKPrRG04RhpEAOvnZankSE+hxrR73LUmqYJnHpgXB8=
X-Received: by 2002:a05:6a00:1407:b0:82a:7046:86a2 with SMTP id d2e1a72fcca58-8352d03beecmr6175792b3a.10.1777825592351;
        Sun, 03 May 2026 09:26:32 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:31 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 04 May 2026 01:26:00 +0900
Subject: [PATCH 7/7] Documentation: networking: add seg6_mobile guide
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-srv6-mup-v1-v1-7-e0a6791575cb@gmail.com>
References: <20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com>
In-Reply-To: <20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11107;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=ytJNk6Sp5oqo2mhDyk8PHPFkvKfco1b3mZP7WKRR2TM=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93cjoBhU12NhAo5DhnO7WXlrPkNVwC8k27WVS
 6rre30V1mKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IwAKCRAq19F1Kl0b
 TSJhEAChTxUHMC+AEQPv+H3YRz1SHAK+o75w0CosXqUyoJ0NbRa7Za6+J5EncU42AvpkfKXtdEF
 Csf+uSRPVSvZwb5U9Ny1bPh05hywD+RdRpTQUHx0KAFoCJix/9lbxnXfAcwEKDDTJdO42dm9UJc
 N7WsKVR8ln+ppe2PNc24h4fOLaq08kOTf4UpNBUVLFURFEFy0F9ZWRfxluOzZ/hgt5FwIeKfAMk
 mfDh4TGgpo8gyYnG7TLaJ49Qk/Ulx9WqYKfNeFbS2M0iZappIa9sum4ChlKQpeQTt8NjN+KtCpT
 JILpoUGdSIqvUa1KP9bEnTKfMX0M2xOFEKrST5Q9uuGaNariDVZUn1GM6Oav4OlwGOhjfgrLWr6
 I9HOHd/rq6nRoQP+kkEBuIZiDTctBM4JMeo2VbH9uTlwbwcQO8KsjxrVXjLXm8WytSy0ClUwk68
 agn+8hTh/u1stcqdqtza71n5HNER4IUOHToRv/9sa+wT5DKO2WzBh9GLxptO/5J9WFyAA4A/8wH
 eVQL125YfZz0iYz9tAqcZXUlPxYrYllOtreuC0o8HrPmXVQj0/FVlTme7i9lXchzPgJGjUfUYJZ
 CPihrbry8qJJ04DcTWLvek3r/4OhphLgylhESaQv4QdhJDzSb9SoB5YrMceQpYSnCveyeN8BD+l
 iGyWPBCWDcPigXw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: A7DF84B67BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.map:url]

Document the six RFC 9433 Mobile User Plane behaviors implemented
by seg6_local, the SID layout used by the GTP behaviors, security
considerations (HMAC, SR-domain perimeter filtering), netfilter
integration with nf_hooks_lwtunnel, and the location of the
selftests.

Link: https://www.rfc-editor.org/rfc/rfc9433
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 Documentation/networking/index.rst       |   1 +
 Documentation/networking/seg6_mobile.rst | 236 +++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 44a422ad3b05..90fa0ad223da 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -108,6 +108,7 @@ Contents:
    sctp
    secid
    seg6-sysctl
+   seg6_mobile
    skbuff
    smc-sysctl
    sriov
diff --git a/Documentation/networking/seg6_mobile.rst b/Documentation/networking/seg6_mobile.rst
new file mode 100644
index 000000000000..6a268bedf3be
--- /dev/null
+++ b/Documentation/networking/seg6_mobile.rst
@@ -0,0 +1,236 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+SRv6 Mobile User Plane (RFC 9433)
+=================================
+
+This document describes the SRv6 Mobile User Plane (MUP) behaviors
+implemented by the ``seg6_local`` lightweight tunnel.  Six of the
+seven behaviors defined in `RFC 9433`_ are supported and configurable
+through ``ip route ... encap seg6local action ...``: End.MAP,
+End.M.GTP6.D, End.M.GTP6.D.Di, End.M.GTP6.E, End.M.GTP4.E, and
+H.M.GTP4.D.
+
+End.Limit (RFC 9433 Section 6.8) is unimplemented.
+
+.. _`RFC 9433`: https://www.rfc-editor.org/rfc/rfc9433
+
+Behaviors
+=========
+
+End.MAP (`RFC 9433`_ Section 6.2)
+---------------------------------
+
+Endpoint with SID mapping.  Replaces the IPv6 destination address with
+the next SID; the SRH is left untouched.  Standard SRv6 endpoint hop
+limit handling applies (an ICMP Time Exceeded is emitted when the IPv6
+Hop Limit would reach zero per RFC 9433 Section 6.2 S01-S03; the Hop
+Limit is decremented per S04 before forwarding).  ``nh6`` selects the
+replacement SID::
+
+    ip -6 route add 2001:db8:f::/64 \
+        encap seg6local action End.MAP nh6 2001:db8:2::e \
+        dev <dev>
+
+End.M.GTP6.D (`RFC 9433`_ Section 6.3)
+--------------------------------------
+
+Encapsulation endpoint that consumes IPv6/UDP/GTP-U and emits SRv6.
+The new SRH is built from the configured segment list, with the
+original outer IPv6 destination ``D`` of the inbound GTP-U packet
+stamped at SRH ``segments[0]`` (the ultimate destination of the SR
+Policy).  The configured ``srh segs`` last entry is the remote
+End.M.GTP6.E SID and lands at SRH ``segments[1]``, the penultimate
+position required by RFC 9433 Section 6.5 Note; the kernel encodes
+``Args.Mob.Session`` into the locator-relative slice of that SID so
+that the egress End.M.GTP6.E peer can recover ``D`` (and hence the
+original gNB-side GTP-U destination) from ``segments[0]`` after its
+SRv6 strip::
+
+    ip -6 route add 2001:db8:f::/64 \
+        encap seg6local action End.M.GTP6.D \
+            srh segs 2001:db8:2::e \
+            src 2001:db8:2::1 \
+            sr_prefix_len 64 \
+        dev <dev>
+
+``sr_prefix_len`` declares the locator length used by the remote
+End.M.GTP6.E SID and must match the prefix length configured on that
+remote endpoint; the SR Gateway has no way to discover the remote
+SID's locator length on its own.
+
+The wire SRH for the example above is
+``[D, 2001:db8:2::e | Args.Mob.Session]``: ``segments[0]`` is the
+saved original outer IPv6 DA of the GTP-U packet, and
+``segments[1]`` is the End.M.GTP6.E SID at the egress UPF in the
+penultimate position required by RFC 9433 Section 6.5.
+
+End.M.GTP6.D.Di (`RFC 9433`_ Section 6.4)
+-----------------------------------------
+
+Drop-in variant of End.M.GTP6.D that preserves the original IPv6
+destination address as ``segments[0]`` (the last in-transit SID in the
+new SRH) and discards TEID/QFI rather than folding them into
+Args.Mob.Session.  Useful when the upstream service expects the
+original destination to survive untouched::
+
+    ip -6 route add 2001:db8:f::/64 \
+        encap seg6local action End.M.GTP6.D.Di \
+            srh segs 2001:db8:2::e,2001:db8:3::e \
+            src 2001:db8:2::1 \
+        dev <dev>
+
+End.M.GTP6.E (`RFC 9433`_ Section 6.5)
+--------------------------------------
+
+Egress endpoint that decapsulates SRv6 and emits IPv6/UDP/GTP-U.  The
+active SID carries the 40-bit ``Args.Mob.Session`` field defined in
+RFC 9433 Section 6.1 immediately after the locator; TEID and QFI are
+extracted from it.  The route prefix length implicitly declares the
+locator length on this end of the tunnel; no explicit
+``sr_prefix_len`` is required because the SID is locally instantiated
+by this route::
+
+    ip -6 route add 2001:db8:e::/64 \
+        encap seg6local action End.M.GTP6.E src 2001:db8:2::1 \
+        dev <dev>
+
+The route prefix length must leave room for the 40-bit
+``Args.Mob.Session`` that immediately follows the locator, so the
+constraint ``prefix_len + 40 <= 128`` (i.e. ``prefix_len <= 88``)
+is enforced at install time.
+
+The optional ``pdu_type {dl|ul|<num>}`` attribute supplies the PDU
+Type field (3GPP TS 38.415 Section 5.5.2) of the GTP-U PDU Session
+Container.  When set, every emitted packet carries the container with
+that PDU Type and the QFI from ``Args.Mob.Session``; when unset the
+kernel emits a short GTPv1-U header with no container, regardless of
+the QFI.  ``pdu_type`` MUST be set on routes serving 5G N3 traffic;
+omitting it targets LTE-only / S1-U deployments.  Numeric ``<num>``
+in 0..15 is also accepted (per TS 38.415 the field is 4 bits wide;
+2..15 are currently reserved).
+
+End.M.GTP4.E (`RFC 9433`_ Section 6.6)
+--------------------------------------
+
+Egress endpoint that decapsulates SRv6 and emits IPv4/UDP/GTP-U.
+The SID encodes the IPv4 destination per RFC 9433 Section 6.6
+Figure 9.  ``v4_mask_len`` declares the width of the IPv4 DA slice
+that immediately follows the locator (in 1..32, the constraint
+``locator + v4_mask_len + 40 <= 128`` is enforced at install time)::
+
+    ip -6 route add 2001:db8::/32 \
+        encap seg6local action End.M.GTP4.E \
+            src 2001:db8:2::1 v4_mask_len 32 \
+        dev <dev>
+
+The IPv6 source address carries the IPv4 SA per RFC 9433 Section 6.6
+Figure 10.  ``v6_src_prefix_len`` declares the Source UPF Prefix
+length P in bits (1..127, default 64); the IPv4 SA slice is then
+``v4_mask_len`` bits wide starting at bit offset P.  The kernel
+always reads a 32-bit window from the configured ``src`` template at
+offset P (the upper ``v4_mask_len`` bits are overlaid with the
+recovered IPv4 SA), so the constraint ``v6_src_prefix_len <= 96``
+(equivalently ``v6_src_prefix_len + 32 <= 128``) is enforced at
+install time.  Bits outside the IPv4 SA slice are taken verbatim
+from the configured ``src`` template::
+
+    ip -6 route add 2001:db8::/32 \
+        encap seg6local action End.M.GTP4.E \
+            src 2001:db8:2::1 v4_mask_len 32 v6_src_prefix_len 64 \
+        dev <dev>
+
+``pdu_type`` takes the same values and has the same effect as on
+End.M.GTP6.E (see above).
+
+H.M.GTP4.D (`RFC 9433`_ Section 6.7)
+------------------------------------
+
+Headend behavior that consumes IPv4/UDP/GTP-U and emits IPv6 with
+the SID encoding the original IPv4 destination plus Args.Mob.Session
+per RFC 9433 Section 6.7 Figure 11::
+
+    ip -4 route add 10.99.0.0/24 \
+        encap seg6local action H.M.GTP4.D \
+            nh6 2001:db8:: \
+            src 2001:db8:2::1 \
+            v4_mask_len 32 sr_prefix_len 32 \
+        dev <dev>
+
+The inbound IPv4 SA is encoded into the IPv6 SA using the same
+Figure 10 layout as End.M.GTP4.E (controlled by ``v6_src_prefix_len``,
+default 64).
+
+Per-route VRF / interface binding
+=================================
+
+The five GTP-related behaviors (End.M.GTP4.E, End.M.GTP6.E,
+End.M.GTP6.D, End.M.GTP6.D.Di and H.M.GTP4.D) accept the standard
+``oif`` ``seg6_local`` attribute to bind their egress lookup to a
+specific output interface or VRF device.  This lets operators keep
+the SRv6 underlay, the N3 reference point (toward gNB) and the N6
+reference point (toward the data network) on separate routing tables
+or VLAN sub-interfaces, which matches typical multi-tenant
+deployments::
+
+    ip -6 route add 2001:db8:e::/64 \
+        encap seg6local action End.M.GTP6.E \
+            src 2001:db8:2::1 \
+            oif vrf-n3 \
+        dev <dev>
+
+Without ``oif`` the egress lookup uses the default routing table.
+
+Netfilter integration
+=====================
+
+The five GTP-related behaviors expose IPv4 / IPv6 inner T-PDUs to
+``NF_INET_PRE_ROUTING`` between the outer strip and the new outer
+push (mirroring ``End.DX4`` / ``End.DX6``), so iptables / nftables /
+conntrack can apply policy on the inner 5-tuple before
+re-encapsulation.  Non-IP inner payloads bypass the hook and are
+re-encapsulated unchanged.
+
+Enable with::
+
+    sysctl -w net.netfilter.nf_hooks_lwtunnel=1
+
+This sysctl is one-way: it cannot be cleared without reloading the
+kernel (see :doc:`nf_conntrack-sysctl`).
+
+Example: drop traffic from a UE address on an ``End.M.GTP6.D`` SR
+Gateway::
+
+    nft add table ip filter
+    nft 'add chain ip filter prerouting \
+        { type filter hook prerouting priority 0; }'
+    nft add rule ip filter prerouting \
+        ip saddr 10.0.0.42 counter drop
+
+GTP-U non-T-PDU handling
+========================
+
+The three GTP-U decap behaviors (``End.M.GTP6.D``,
+``End.M.GTP6.D.Di`` and ``H.M.GTP4.D``) only encapsulate ``T-PDU``
+frames (3GPP TS 29.281 Section 5.1, message type 255) into SRv6.
+Any other GTP-U message (``Echo Request``/``Echo Response``,
+``Error Indication``, ``Supported Extension Headers Notification``,
+...) is forwarded unchanged toward its IPv4 / IPv6 destination as
+a regular packet, so a downstream UPF that owns the GTP-U control
+plane can process it.
+
+The downstream UPF must therefore live behind the SR Gateway, on
+the IPv4 / IPv6 network the GTP-U destination is reachable through.
+Assigning the UPF's address to a local interface on the SR Gateway
+is not a supported topology: the SR Gateway cannot at the same
+time intercept ``T-PDU`` for SRv6 encapsulation and deliver
+non-T-PDU GTP-U to a local userspace socket addressed to the same
+destination.
+
+Debugging
+=========
+
+The SRv6 Mobile data path drops malformed or out-of-policy packets via
+the standard skb drop-reason infrastructure (``SEG6_MOBILE_*`` in
+``include/net/dropreason-core.h``) rather than silent ``-EINVAL``, so
+the cause is observable via the ``skb:kfree_skb`` tracepoint.

-- 
2.50.1



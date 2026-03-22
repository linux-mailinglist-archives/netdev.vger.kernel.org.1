Return-Path: <netdev+bounces-270283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G35J/w8v2nwzgMAu9opvQ
	(envelope-from <netdev+bounces-270283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474112E7CC5
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96EAF300668A
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BF366079;
	Sun, 22 Mar 2026 00:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EC2C15A9
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140666; cv=none; b=s6KQadxMHRl+nEyWQPXd+5LqzJuLJeo6406kchl9+pr4dii4yb5vauC4vLDZZrwmnUjCwrUaSiwyPHbshwZnfDJtZUBSqY+0PscNe9uNjD/aPaIEwK0mvW6wQgBJrUwU7du/ZmtZIabN9ftqsvQ+zNOd0oFqhiYu8C/PloGROcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140666; c=relaxed/simple;
	bh=zo7nQlbQC2AOymAPgrMA4IrdEz9jHyYJKbNFIq28Hac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri8eRHSIhTtruvroeAy0QqhY+W1pa8PAeaqyPtXq2Rs6bKAs1QYGhXLdjZ5GQhwT2cfFapw7ilOO7OGNB4lFLuHYD12ZIH+Bs+ffZNf3y6HixEBub+HWusCpspGeEvwVuL4br7y/6o+CVwF7koCSl1cmbMxJt2IQdmiN/V5UC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M0oi8E021661;
	Sun, 22 Mar 2026 01:50:51 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH iproute2-next 3/4] seg6: man: document End.DT2U behavior in ip-route man page
Date: Sun, 22 Mar 2026 01:50:20 +0100
Message-Id: <20260322005021.12770-4-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
References: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270283-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Queue-Id: 474112E7CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the End.DT2U seg6local action in the ip-route(8) man page.
Add the End.DT2U syntax, describe the l2dev parameter, and provide
a usage example in the SRv6 examples section.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 man/man8/ip-route.8.in | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index aafa6d98..bba7a4fd 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -993,6 +993,21 @@ only accepts packets with either a zero Segments Left value or no SRH
 at all, and an inner IPv4 or IPv6 packet. Other matching packets are
 dropped.
 
+.B End.DT2U l2dev
+.I DEVICE
+- Decapsulate the inner Ethernet frame and deliver it locally on the
+specified L2 device.
+.I DEVICE
+must be either a bridge port or a
+.B srl2
+device. When
+.I DEVICE
+is a bridge port, the Linux bridge performs MAC source address learning,
+destination MAC lookup, and L2 forwarding within the local bridge
+domain. This action only accepts packets with either a zero Segments
+Left value or no SRH at all, and an inner Ethernet frame (protocol 143).
+Other matching packets are dropped.
+
 .B End.B6 srh segs
 .IR SEGMENTS " [ "
 .B hmac
@@ -1450,6 +1465,12 @@ ip -6 route add 2001:db8:1::/64 encap seg6local action End.DT46 vrftable 100 dev
 Adds an IPv6 route with SRv6 decapsulation and forward with lookup in VRF table.
 .RE
 .PP
+ip -6 route add fc00::100/128 encap seg6local action End.DT2U l2dev srl2-0 dev eth0
+.RS 4
+Adds an IPv6 route with SRv6 L2 decapsulation and local delivery of the
+inner Ethernet frame on srl2-0.
+.RE
+.PP
 ip -6 route add 2001:db8:1::/64 encap seg6local action End flavors psp dev eth0
 .RS 4
 Adds an IPv6 route with SRv6 End behavior with psp flavor enabled.
-- 
2.20.1



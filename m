Return-Path: <netdev+bounces-244524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5692CB959D
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137B330216BC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64032C1595;
	Fri, 12 Dec 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="IIc5gMLL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C920E005;
	Fri, 12 Dec 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558186; cv=none; b=QYY77YrTOZD5z4u1YUKSupkc0JOpBpmS3nQhWU63byiPDAaViBh/IVXysgulBZjYlSE+D5GnUExcqq9F1Me9jqDwC8eZ26k1OcHVFpwbefZ777SVq+nsTjj8T3Y4LcUsBIahw1HwqesR84RB2f0KpRbob5SXDMopt32c7LiwuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558186; c=relaxed/simple;
	bh=q6kw0aNBE5Azvu81OLRFxZNVbPRvnoYOlEH1QqgQovc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/DGKLDPEYeEuKfVOXQLnxp91y1WgV8EZAkuP4c9A5yK39qS++zuUQ+ByuSiEveWBOIqIsX8l4QN2XPZImeMEZ1aevkE+W4CGYRZ8o80pNHl0Ex4ngOLY86hc5reP2ewju9gt5XBXVAvCCES11VLMewoUFuUrLlJTooO7yMEv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=IIc5gMLL; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557422; bh=q6kw0aNBE5Azvu81OLRFxZNVbPRvnoYOlEH1QqgQovc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIc5gMLLV2UlF4NL4mb8ao/wLlx7UHFMV260tbhKCXedj5NtIBLUxPGArXyFMCaW5
	 RTcSdi1uiSKSY3AIt78R+XExQsf0Vl/nxnE6GG71Q6xdmWTOYgu9AUKnkJCm5gvr2j
	 iDqlrUGtpjrNI7Ezd+pGUUdYHJ/zwbUWw1dLAHIXnZhDKRUHkJSViwFklm5Ft9e14Y
	 AfZvvUvp4p2lMmmsSMXrK9qnjsmMGHj/xsMzFJjcJ7nCBGGFz6gKzRtzxQIocMwTfx
	 GG5OUsaqy2iYdb7DiyooZrT5l0DcPQ9w1TUy6l9b+vTpuUHfgmi7Sxj41gu4aaGak+
	 GVieNnTlc97yQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 152A6125483;
	Fri, 12 Dec 2025 17:37:01 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 1/8] landlock: Minor reword of docs for TCP access rights
Date: Fri, 12 Dec 2025 17:36:57 +0100
Message-Id: <20251212163704.142301-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Move ABI requirement next to each access right to prepare adding more
  access rights;
- Mention the possibility to remove the random component of a socket's
  ephemeral port choice within the netns-wide ephemeral port range,
  since it allows choosing the "random" ephemeral port.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..efb383af40b2 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -182,11 +182,13 @@ struct landlock_net_port_attr {
 	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
 	 * to an available port from the ephemeral port range.  This can be
 	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
-	 * (also used for IPv6).
+	 * (also used for IPv6), and within that range, on a per-socket basis
+	 * with ``setsockopt(IP_LOCAL_PORT_RANGE)``.
 	 *
-	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
+	 * A Landlock rule with port 0 and the %LANDLOCK_ACCESS_NET_BIND_TCP
 	 * right means that requesting to bind on port 0 is allowed and it will
-	 * automatically translate to binding on the related port range.
+	 * automatically translate to binding on a kernel-assigned ephemeral
+	 * port.
 	 */
 	__u64 port;
 };
@@ -332,13 +334,12 @@ struct landlock_net_port_attr {
  * These flags enable to restrict a sandboxed process to a set of network
  * actions.
  *
- * This is supported since Landlock ABI version 4.
- *
  * The following access rights apply to TCP port numbers:
  *
- * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
- * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
- *   a remote port.
+ * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind TCP sockets to the given local
+ *   port. Support added in Landlock ABI version 4.
+ * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the given
+ *   remote port. Support added in Landlock ABI version 4.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
-- 
2.47.3



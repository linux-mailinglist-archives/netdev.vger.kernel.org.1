Return-Path: <netdev+bounces-283950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCZiLdjJ+Gls0wIAu9opvQ
	(envelope-from <netdev+bounces-283950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF94C1643
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C58A302F686
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C823E3159;
	Mon,  4 May 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfgHUusY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACD3E0C54
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912223; cv=none; b=SB7SJ7aq/QOjQOHWPevasO+VS0vLMQBSieY430rPGSCMATBpy9BV06pDLXR85JCV4Spg7Y1nOVDkzeKJvuC4Ab9xiQ4t0NGapHCkvDR9nOr4ExAjashH/yXtqrV0ZDPRhfjnoLA9WUQznqVKFhmkmoVPb+Uf0vhfpQp68qtAfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912223; c=relaxed/simple;
	bh=+iiiX3BvtYgkBAUfsPCcDZX4Aid/ECDwiIQZzdJjkNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5X6lFvzrIuNX6r1ndlXI0XS1FxfBKgXb8sPP+UtxJsxCe9oiHg4G+2L7dtPxnKZi46b9EpKcGPrXW9zpSGcLoThv1Ej9QT9P1LanPEo46l8DijitxAg58wv5zwb5FPamja88D6YQxcrd0PDnqT4NI5n9KkNa9Zrxa+82WKtdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfgHUusY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso738325b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777912220; x=1778517020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4SDDOQTi/UT2LIZcsZGLS3qiP3+rr4zN9xXGDgjw4U=;
        b=lfgHUusYEg7LgD+BuBOI3EuiVMM5H4bghSXghViiri8ojDluvFUrpEYDsGYpCrPiAb
         Pw9lDTGxhX0+R5sVptxcKjHnz1YhVpoZYvYGiJcBkwjKr9qnrxc04Lzqg7Tv55/lhVDA
         Jf22UHV2ub01iRfOkNaVkgaFwNpW004wDbcaXprpMMIGsOye6u0NRMdy1g2gQ+soa8+v
         j7b/EFbhtzz9uEzxvFuDUuIf/GI5tds4Elr3S4+qPgyFhkdKB3QZjuEqEDRBYUpzU//5
         rx4uS+p8OXB8eUBjizhuSN9nF9FUvcqnRL9zjfrYZ57Qns0nkaGWy6vo0SifcIq5L/dM
         hDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912220; x=1778517020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4SDDOQTi/UT2LIZcsZGLS3qiP3+rr4zN9xXGDgjw4U=;
        b=fja43jX4U48PtKWwx0AxKDmT3Bhgq5miX911Uj8lOTchLfb2UBCm+Z1EnCHML6ALKh
         92fflVsGBomTKEHyzrUbPKrKOVWUikmFh4FH1GS4LYjwqe6u7cOc/cNupl0cyCYrCgo6
         vzFZ+s+nX9k1+pHqu+XKq+t3H0D6J94QaJ6GX7nxNYSFTpfFthXSdWrHC+HhusmwGgmf
         kyTy3wbKm6M1iH0dVvIGJU94rxa2BkscAziWkVOfMKXUE1NuyNHxHzeAhjEpfbXBnXHF
         qK12XgMcxtajdo92ZIT1SKLIj7pPabdNCJ5cduLI8p0/cosKYqiQNiVpL2pekv2nAAgL
         vL5A==
X-Forwarded-Encrypted: i=1; AFNElJ//ZvY4SHr5y5NoI/SsUidv0XmlwMnYpawDpz2e+4YiyVoqLGDADsAfu1iPinLqaS04SViFJt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKd/crO+FAjwGVu0eSc6pwswiV6RQvu9dGNXSsFCL5HOpISiah
	oXcGdlURsr8mL/2uDur51dgrQsA3zBgJGjaBEVAVYsXiCpPuC3NhHcN9
X-Gm-Gg: AeBDievGjCrm8ea4lRKxqbR7YarTFItvfJlis5nVj2j477hoJY/QInnGq6Rcy43P+RR
	Tskaa1MIUbrEiYxeddhpXym+s4wJwX/KltM7m4JJ+qLh2jsFSJxtpLqioTbzQKdMn1MnUyHpASs
	bgo0XeT2101qwP4vwL4KV/k1hHgWclwAX8bfq41agDaQaOzAzc1I3wMYPPM8wcndKaUisKeE7F0
	IptE4NCuP3B7WltXuaMPCVpBBuh79Bo+jet5y8KvUWUJ5e+vP7UWkCHDHJQTqnz4333XNrylLRh
	3ao4HfZhvK8vUZ1qT0pBWv1IkzvloSsNIATOY57obp1U3xgLYZPM7tnDE0I377hbZosFeMGCQEP
	8vfn2PlCd3wwHnRqZvxJv0e6GY7xdthoXuwyTiGqVcnuXIdRsxMQHFSHWfHv1FZWCJRnGC27iI6
	CARoS82oDkq88YwjeCD5gb2tBVjNWbA5UW1vP8qzO5rfm1
X-Received: by 2002:a05:6a00:98f:b0:82f:4725:f6d0 with SMTP id d2e1a72fcca58-838fe8711b3mr144617b3a.29.1777912220379;
        Mon, 04 May 2026 09:30:20 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm4998663b3a.42.2026.05.04.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:30:19 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:30:11 +0900
Subject: [PATCH v2 1/7] seg6: add End.MAP behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-1-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9123;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=+iiiX3BvtYgkBAUfsPCcDZX4Aid/ECDwiIQZzdJjkNs=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MmUQwE1DvRY1mrT1chXPXCYjnWz3JzuPfrDm
 HL6Zvy/U6yJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjJlAAKCRAq19F1Kl0b
 TbUmD/0UeSzpAQ0PNYbxTBqMwqlVIxxKM/NPWe8+lzUZukIj4qXV+wYtXi6zYARHws7Wl5pkAwt
 s85uTo9/zK97uY2+hH7g57YfdMrqEjdJUHvYsTeVdK4EFO9PbB/YMdoVCLq7OUvbsM/J+Wo6cR+
 K/ZJ9ZRY7QzBV24fd+GnJtRPP9FzUobQCZU/zHaTeDKrfris9RBlK7A6jOImCnvKv82ohS86nCR
 gMvbG0ZrdOL5gco+X4QYyfdQwAfyFU851S56e21r1TY2bLlPH6hRXzdDPf40dJ7RYF+Sn9nR/VS
 D2d8OGL0ICoB+VB6wDeL5d69zejtfH0S8jGp8hQuZmptsEjUOFl2+nEagB89KcoQszSLreJOqUw
 +CO719N6TLHKgaEGndoBb0GEmc1hJegxuADzAPHhiD8W7wYq5W5u0O6lRQGEP981GMmKONW5HFw
 r0Qko/sZR/XNwhcyK9JlzkEaIGupe4hW99jCxmTpxdh0QsnPdhW4CKdnDHkS95UHMF+ol5DuHFd
 kdOpcIzN8ycDDEs51KAHBqVOmpnSB2T0naONNP5RsJiAtkCkVjV8cDeXrXVCF5SW0CV7pa1+AE4
 TU359/LfJhNLzFjrE/vn8MSU2IW6jP4aLh9rIr8Q6Lo5rIL2K+axkXa5I/TgfhFRcZTA3vJMKNL
 /9vHveYD2hm0RYw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 51FF94C1643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,srv6_end_map_test.sh:url,end.map:url,lib.sh:url]

Add the End.MAP behavior (RFC 9433 Section 6.2): an endpoint that
replaces the IPv6 destination address with a configured next SID
and forwards via IPv6 routing without consuming the SRH.  The new
nh6 attribute selects the replacement SID.

Add three drop reasons that End.MAP emits to dropreason-core.h, so
dropped packets show up in the standard skb:kfree_skb tracepoint:

  SEG6_MOBILE_INVALID_SRH_SL
  SEG6_MOBILE_HOP_LIMIT_EXCEEDED
  SEG6_MOBILE_NOMEM

Configuration:

  ip -6 route add 2001:db8:f::/64 \
      encap seg6local action End.MAP nh6 2001:db8:1::e \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.2
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/net/dropreason-core.h                    |  12 +++
 include/uapi/linux/seg6_local.h                  |   2 +
 net/ipv6/seg6_local.c                            |  73 ++++++++++++++++
 tools/testing/selftests/net/Makefile             |   1 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 103 +++++++++++++++++++++++
 5 files changed, 191 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e0ca3904ff8e..1be5c54d7605 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -127,6 +127,8 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(SEG6_MOBILE_INVALID_SRH_SL)	\
+	FN(SEG6_MOBILE_NOMEM)		\
 	FNe(MAX)
 
 /**
@@ -600,6 +602,16 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL: invalid Segments Left
+	 * value or SRH validation failure on an SRv6 Mobile path.
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_NOMEM: skb head/tail expansion or
+	 * helper allocation failed on an SRv6 Mobile path.
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_NOMEM,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 4fdc424c9cb3..45386fdfa821 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -67,6 +67,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_BPF	= 15,
 	/* decap and lookup of DA in v4 or v6 table */
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
+	/* swap DA with new SID, leave SRH untouched (RFC 9433 Section 6.2) */
+	SEG6_LOCAL_ACTION_END_MAP	= 17,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..bd8e3312973f 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1468,6 +1468,73 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+/* SRH validation helper for SRv6 Mobile (RFC 9433) behaviors that may
+ * receive an SRv6 encapsulated packet.  Returns the SRH on success or
+ * NULL on validation failure / when the SRH is absent.  The caller
+ * uses @missing to distinguish the two NULL cases: an SRH-less packet
+ * may be acceptable depending on the behavior.
+ */
+static struct ipv6_sr_hdr *seg6_mobile_get_validated_srh(struct sk_buff *skb,
+							 bool *missing)
+{
+	struct ipv6_sr_hdr *srh = seg6_get_srh(skb, 0);
+
+	if (!srh) {
+		if (missing)
+			*missing = true;
+		return NULL;
+	}
+	if (missing)
+		*missing = false;
+
+#ifdef CONFIG_IPV6_SEG6_HMAC
+	if (!seg6_hmac_validate_skb(skb))
+		return NULL;
+#endif
+	return srh;
+}
+
+/* RFC 9433 Section 6.2 -- End.MAP
+ * Replace the outer IPv6 destination address with the configured next
+ * SID, decrement the Hop Limit, and forward via IPv6 routing.  The
+ * SRH is left untouched, so any subsequent End* behavior continues to
+ * see the original Segment List unchanged.
+ */
+static int input_action_end_map(struct sk_buff *skb,
+				struct seg6_local_lwt *slwt)
+{
+	enum skb_drop_reason reason;
+	struct ipv6_sr_hdr *srh;
+	struct ipv6hdr *ip6h;
+	bool no_srh = false;
+
+	reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+
+	/* When an SRH is present it must HMAC-validate before we touch
+	 * the destination; an SRH-less packet is also accepted because
+	 * End.MAP does not consume the SRH.
+	 */
+	srh = seg6_mobile_get_validated_srh(skb, &no_srh);
+	if (!srh && !no_srh)
+		goto drop;
+
+	if (skb_ensure_writable(skb, sizeof(*ip6h))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
+		goto drop;
+	}
+
+	ip6h = ipv6_hdr(skb);
+	ip6h->daddr = slwt->nh6;
+
+	skb_dst_drop(skb);
+	seg6_lookup_nexthop(skb, NULL, 0);
+	return dst_input(skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
 static struct seg6_action_desc seg6_action_table[] = {
 	{
 		.action		= SEG6_LOCAL_ACTION_END,
@@ -1565,6 +1632,12 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.optattrs	= SEG6_F_LOCAL_COUNTERS,
 		.input		= input_action_end_bpf,
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_MAP,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.input		= input_action_end_map,
+	},
 
 };
 
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..4fbb1eff79f8 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -90,6 +90,7 @@ TEST_PROGS := \
 	srv6_end_dx4_netfilter_test.sh \
 	srv6_end_dx6_netfilter_test.sh \
 	srv6_end_flavors_test.sh \
+	srv6_end_map_test.sh \
 	srv6_end_next_csid_l3vpn_test.sh \
 	srv6_end_x_next_csid_l3vpn_test.sh \
 	srv6_hencap_red_l3vpn_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_map_test.sh b/tools/testing/selftests/net/srv6_end_map_test.sh
new file mode 100755
index 000000000000..7ee54b4cc97f
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_map_test.sh
@@ -0,0 +1,103 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154
+#
+# Selftest for the SRv6 End.MAP behavior (RFC 9433 Section 6.2).
+#
+#   +--------+   2001:db8:1::/64   +--------+   2001:db8:2::/64   +--------+
+#   | srupf1 | ------------------- | srupf2 | ------------------- | srupf3 |
+#   +--------+       veth-1        +--------+       veth-2        +--------+
+#                                (intermediate
+#                                 SRv6-aware UPF,
+#                                 End.MAP)
+#
+# All three netns are SRv6-aware UPFs in the RFC 9433 sense (not
+# 3GPP UPFs).  Per RFC 9433 Section 6.2 End.MAP is used by the
+# intermediate UPF (here srupf2): srupf2 has an End.MAP SID for
+# locator 2001:db8:f::/64 mapping to the new SID 2001:db8:2::e.
+# srupf1 sends an IPv6 packet to 2001:db8:f::1; on srupf3 the
+# destination address is expected to have been replaced by
+# 2001:db8:2::e.
+
+source lib.sh
+
+readonly TIMEOUT=4
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup()
+{
+	setup_ns srupf1 srupf2 srupf3
+
+	ip -n "$srupf1" link set lo up
+	ip -n "$srupf2" link set lo up
+	ip -n "$srupf3" link set lo up
+
+	ip link add veth-1 netns "$srupf1" type veth peer name veth-1-srupf2 \
+		netns "$srupf2"
+	ip -n "$srupf1" addr add 2001:db8:1::1/64 dev veth-1 nodad
+	ip -n "$srupf2" addr add 2001:db8:1::2/64 dev veth-1-srupf2 nodad
+	ip -n "$srupf1" link set veth-1 up
+	ip -n "$srupf2" link set veth-1-srupf2 up
+
+	ip link add veth-2 netns "$srupf2" type veth peer name veth-2-srupf3 \
+		netns "$srupf3"
+	ip -n "$srupf2" addr add 2001:db8:2::1/64 dev veth-2 nodad
+	ip -n "$srupf3" addr add 2001:db8:2::e/64 dev veth-2-srupf3 nodad
+	ip -n "$srupf2" link set veth-2 up
+	ip -n "$srupf3" link set veth-2-srupf3 up
+
+	ip netns exec "$srupf2" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	ip -n "$srupf1" -6 route add 2001:db8:f::/64 via 2001:db8:1::2
+
+	ip -n "$srupf2" -6 route add 2001:db8:f::/64 \
+		encap seg6local action End.MAP nh6 2001:db8:2::e \
+		dev veth-2
+
+	# allow srupf3 to reply back to srupf1
+	ip -n "$srupf3" -6 route add 2001:db8:1::/64 via 2001:db8:2::1
+}
+
+check_dependencies()
+{
+	if ! command -v ping >/dev/null; then
+		echo "SKIP: ping is required"; exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.MAP"; then
+		echo "SKIP: iproute2 too old, missing seg6local action End.MAP"
+		exit "$ksft_skip"
+	fi
+}
+
+run_test()
+{
+	# srupf3 replies to ICMPv6 echo on 2001:db8:2::e, so a successful
+	# ping from srupf1 to the End.MAP SID demonstrates that the action
+	# replaced the destination address with 2001:db8:2::e.
+	if ! ip netns exec "$srupf1" ping -6 -c 1 -W "$TIMEOUT" \
+			2001:db8:f::1 >/dev/null 2>&1; then
+		return 1
+	fi
+	return 0
+}
+
+main()
+{
+	check_dependencies
+	setup
+
+	if run_test; then
+		echo "TEST: End.MAP [PASS]"; exit "$ksft_pass"
+	else
+		echo "TEST: End.MAP [FAIL]"; exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1



Return-Path: <netdev+bounces-283630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJQaE4p392mEiAIAu9opvQ
	(envelope-from <netdev+bounces-283630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:27:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D364B674C
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF8A302297C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812A3C9EE8;
	Sun,  3 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEhb6950"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A993CBE7D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825585; cv=none; b=q2wfuBzfI0Xnox0ooHyyq6amJHynlxx7sQByX/sHrzcOiN1sIfziCu3FcIMFQdiUJwp6XWnW+yaBmG5qpHM3E+QaoJ/tdvvlNOHApAo4KIwSPc6WnFYycHdYg9ybpYoUSyXtyzR4mWGMmXeDMP6G7SvYA408xx71AXh/YfL9K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825585; c=relaxed/simple;
	bh=SxGReMlzw3Hbr3FumISVQUEevvoku2k6RQvdnyWurZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXpr71azABmtAay9On8Q1H219DAFTQV2kBv501OAIUlOC6mnO8R57QvgTN5RnCDmDwejnYy1oFO8RkwLHXDZNQnOtlVtmtIjfMxLqOtWS5OqZBZhGIMIVGOJYwCZILepbAHfUFxPLrMFpJehWOj3M4TzoWGYKYDszp5RB07CcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEhb6950; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c801d732058so317607a12.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825579; x=1778430379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O/WBA0naYjaLIMQ/8nFNwLdpKq1tIBgYuN4vFPjhNc=;
        b=FEhb6950LK6A9ZADATIXbwwW/jT+K1lGZr1XR6CkBq9P4BKehhzFvH5zQhV9Q0El6b
         yg68NONoBBHbeIzePKYBjfwy9w+0rBOLlv8DuPFciUruO2RFgXj6UnpyjP0/n85UHq8e
         FHMo1bbuEXNGvgT2cXOwNOKvrrazFWif/dwBJRNTkacos2x7q0mA6bfObCRJp4fo8Dbw
         yGJRurxufc4qFTtDnZq3vkuVR3kS5k3ATqYIepcigas3JhwkmseCkhIQPaTLssU04ZtY
         J3NX4wSaxfoKewD8p4N2JUPmc9ITs0XH9NSzN1kCEc5ZjET4+v/EHqDijKwspriCD0eO
         ni8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825580; x=1778430380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9O/WBA0naYjaLIMQ/8nFNwLdpKq1tIBgYuN4vFPjhNc=;
        b=EP6lRxfKjNEKyKg2B+UX87GX3mYKfd92K9dKIrnIxLsTmOh1N2amVh2+4BGWyccFTs
         GSDayJwxnmt01A80MJSx58aGipG+SHs0qVg+67vlEcgpRkN7ujM1elNfFd73bDyus4Hs
         tvyTLUYkxghedJIUkDrjAi6rKNTakF3V2VRPcoxhMKyRL1Bo78/wtENiLkaXUUq59cxq
         fPAepkJrcAGmL2/MYFHwh9kk9Qpa07Bohw1q8H9N+p88VLqzo9F3UD9DfSEAenEU9jjk
         xxAnzAinSFYwFSCmOww3umE2whBR3Y1DrtHcoHDfOUUQSDsjUidz1RyUN6Y1g2n5aYtQ
         OSgA==
X-Forwarded-Encrypted: i=1; AFNElJ+8LHXrn3qsklL8pD+kk0e4Q4++N+jsVBs7K2+FCCvFcIeLF0u9XB+z89SCt8t4uQLTLChbPQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NSODh0k/zpjsETkCso3Aj1zn2SMOP3P9EfMSuAzlSUOYCTEn
	thepTsSu/S4xxcoG1t1BQYQpdDIC6pG1X7tAUXQTbNBkyFRHUyIZME5S
X-Gm-Gg: AeBDieuq/QGfJmjHK8IzOP/HicRSVRDF193GlhXj/9m/FCywdJ2Hg+tWkhodAQovfiA
	D024W9trWPxxor3RpNDB39js7rNlqziShfxlEzALAUSvhvKcsaTIHFHmGkJGaquxUX+yR6nCYJy
	2JWicRCsQlwxsdh5k59iJA03OsJuFW3luFgZI69c/HWXAiPj1FMtx0YhYWFVxarMtkIPzYVcc0B
	hivEbTY7yLd+Uv6Gbjf3qr2d2m/wfyAsntRaktEr23J/i1ZK3dV2BUv2UleiTjzJP6DSJC0FK/K
	8CkLD33I0DvD4h5Wlv6nP7ImWsv+Bi2p73q8G/V+qzKK1cL8hislREoT747mRc1rbOX3z82woFT
	+Iv6iNa+00/x1ieQSWp2OZaDQm+FUJjIyAh57Bpb6MMSLm/mWCEsnNKs/ok9TFSVt+sDDwJjPRk
	ZiW19XtLFQSrx3rka69nZjR+wT/Uh+aqBWX3lBqzwxbKR0
X-Received: by 2002:a05:6a20:3d05:b0:3a2:cbd1:11e with SMTP id adf61e73a8af0-3a7f02e61ddmr5420085637.14.1777825579133;
        Sun, 03 May 2026 09:26:19 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:18 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 04 May 2026 01:25:55 +0900
Subject: [PATCH 2/7] seg6: add End.M.GTP4.E behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-srv6-mup-v1-v1-2-e0a6791575cb@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=48212;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=SxGReMlzw3Hbr3FumISVQUEevvoku2k6RQvdnyWurZE=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93chka23qqsr239diaOUuvEyR0953wTU215Ch
 0IIUu5SgPCJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IQAKCRAq19F1Kl0b
 TZ3lEAC5dXxaRPKJ+GcwWoj1yHcESrPrLJsC4Ujoy7odJ93+hAXgxyX+3zU95Rpb4Ae7FvdrcEE
 ESMlJI1m8I/kidn0Me9EmIe6ej4lOPd1pzKxDarIoASHtEb2HUy+s7kEHt1adgP9ngzBaSdiDik
 J7l+r+kXryrFf15KEZqTFnsHsckWMy5Fi4VJMl4N27IgSAM9711EThLQL+GXTsPp/Qo+IKr2oSz
 YY8zkbdt+C4DSeJ+GdcCR9M52Ou7U++Kb+o+NqiC86XlEC1FacN9/67Dd4pGUnGXIPwhnIyF0dB
 U7K0Al4X58Wtglynf98+5u4xWwZuHFEwzRn9sI14kZOIJ60rvbrJEWAESMLKD5reQdd9jL5Z4/I
 SDjsc+nQ0VSIWXCkITyBh9KP0gmV/QzxYO7qSB/I2kRh/BodzD21tZMU4YsyekG0xXc5A1vrYjk
 ZJjC2wkTTQ+jZRwYHz1iThF1hNqFTEmFebyXAB4QVh6uZBAAmSI04wSV0tac6lkIDs3BWbDvk6C
 3Wi+6bx8TDj0/lpWuvNE7UfPTbZLamdp2sooFpx2oWbcU3IhUIlf03OdEaWf6uS5e9b+YnSrlXr
 b2FQbE9Xmq4XK1xvKW6Qb/QGF/UY9XIoG9bLm3pfmTVzFs51b8oZ9y5h7PnA30TkFjd8w+0yTY3
 LiMCykvqGpZy2Rg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 87D364B674C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,srv6_end_m_gtp4_e_test.sh:url,lib.sh:url,end.map:url]

Add the End.M.GTP4.E behavior (RFC 9433 Section 6.6), which
decapsulates an inbound SRv6 packet and re-encapsulates the inner
T-PDU in IPv4/UDP/GTP-U toward a legacy IPv4 receiver, including an
optional PDU Session extension header.

The SID layout per RFC 9433 Section 6.6 Figure 9 is:

  |<-- locator -->|<-- IPv4 DA -->|<-- Args.Mob.Session -->|<-pad->|

The IPv4 destination is recovered from the SID; the IPv4 source is
recovered from the inbound IPv6 source by overlaying the configured
src_addr template with the v4_mask_len bits at bit offset
v6_src_prefix_len (default 64) of the IPv6 SA, per RFC 9433
Section 6.6 Figure 10.  Args.Mob.Session is the 40-bit
field defined in RFC 9433 Section 6.1: QFI(6) | R(1) | U(1) | PDU
Session ID(32).

DSCP / ECN / Hop Limit -> TTL are propagated from the inbound IPv6
outer to the new IPv4 outer per RFC 6040.  GSO packets that would
not fit the egress route MTU after adding the outer headers are
rejected explicitly because the GSO segmenter cannot fix this up
after the network protocol has changed from IPv6 to IPv4.

When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
NF_INET_PRE_ROUTING between the SRv6 strip and the GTP-U push,
mirroring End.DX4 / End.DX6.

Add four drop reasons used here to dropreason-core.h:
SEG6_MOBILE_BAD_SID, SEG6_MOBILE_BAD_GTPU, SEG6_MOBILE_BAD_INNER,
and SEG6_MOBILE_MTU_EXCEEDED.

Configuration:

  ip -6 route add 2001:db8::/32 \
      encap seg6local action End.M.GTP4.E \
          src 2001:db8:2::1 v4_mask_len 32 \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.6
Link: https://www.rfc-editor.org/rfc/rfc6040
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/net/dropreason-core.h                      |  28 +
 include/uapi/linux/seg6_local.h                    |   6 +
 net/ipv6/seg6_local.c                              | 711 +++++++++++++++++++++
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/srv6_end_m_gtp4_e_test.sh        | 485 ++++++++++++++
 5 files changed, 1231 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 17f881009336..26b587efb4dc 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -130,6 +130,10 @@
 	FN(SEG6_MOBILE_INVALID_SRH_SL)	\
 	FN(SEG6_MOBILE_HOP_LIMIT_EXCEEDED)	\
 	FN(SEG6_MOBILE_NOMEM)		\
+	FN(SEG6_MOBILE_BAD_SID)		\
+	FN(SEG6_MOBILE_BAD_GTPU)	\
+	FN(SEG6_MOBILE_BAD_INNER)	\
+	FN(SEG6_MOBILE_MTU_EXCEEDED)	\
 	FNe(MAX)
 
 /**
@@ -619,6 +623,30 @@ enum skb_drop_reason {
 	 * helper allocation failed on an SRv6 Mobile path.
 	 */
 	SKB_DROP_REASON_SEG6_MOBILE_NOMEM,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_BAD_SID: SRv6 Mobile (RFC 9433) SID
+	 * layout violated (e.g. v4mask out of range, locator + IPv4 DA +
+	 * Args.Mob.Session does not fit in the IPv6 destination).
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_BAD_SID,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU: malformed GTP-U header or
+	 * GTP-U extension header on an SRv6 Mobile ingress / decap path.
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER: malformed inner IP packet
+	 * on an SRv6 Mobile encap / decap path (failed pskb_may_pull,
+	 * ipv6_skip_exthdr, unknown inner IP version, etc.).
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED: GSO packet would not
+	 * fit the egress route MTU after adding the SRv6 Mobile outer
+	 * headers, or the post-encap length exceeds MTU on a non-GSO IPv4
+	 * input that carries DF.
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 45386fdfa821..b42cb526bb81 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -29,6 +29,10 @@ enum {
 	SEG6_LOCAL_VRFTABLE,
 	SEG6_LOCAL_COUNTERS,
 	SEG6_LOCAL_FLAVORS,
+	SEG6_LOCAL_MOBILE_SRC_ADDR,
+	SEG6_LOCAL_MOBILE_V4_MASK_LEN,
+	SEG6_LOCAL_MOBILE_PDU_TYPE,
+	SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -69,6 +73,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
 	/* swap DA with new SID, leave SRH untouched (RFC 9433 Section 6.2) */
 	SEG6_LOCAL_ACTION_END_MAP	= 17,
+	/* SRv6 to IPv4/GTP-U encap (RFC 9433 Section 6.6) */
+	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index cebecbe5e49b..f6fb1db8ebb0 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -32,6 +32,10 @@
 #include <linux/etherdevice.h>
 #include <linux/bpf.h>
 #include <linux/netfilter.h>
+#include <linux/udp.h>
+#include <linux/unaligned.h>
+#include <net/gso.h>
+#include <net/gtp.h>
 
 #define SEG6_F_ATTR(i)		BIT(i)
 
@@ -184,6 +188,17 @@ struct seg6_local_counters {
 
 #define SEG6_F_LOCAL_COUNTERS	SEG6_F_ATTR(SEG6_LOCAL_COUNTERS)
 
+/* Per-route configuration for SRv6 Mobile (RFC 9433) behaviors. */
+struct seg6_mobile_info {
+	struct in6_addr		src_addr;		/* outer IPv6 SA template */
+	u8			v4_mask_len;		/* IPv4 portion length (bits) */
+	u8			pdu_type;		/* PDU Type (0=downlink, 1=uplink) */
+	bool			pdu_type_set;		/* PDU Session Container enabled */
+	u8			v6_src_prefix_len;	/* Source UPF Prefix length (bits) */
+};
+
+#define SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT	64
+
 struct seg6_local_lwt {
 	int action;
 	struct ipv6_sr_hdr *srh;
@@ -197,6 +212,7 @@ struct seg6_local_lwt {
 	struct seg6_end_dt_info dt_info;
 #endif
 	struct seg6_flavors_info flv_info;
+	struct seg6_mobile_info mobile_info;
 
 	struct pcpu_seg6_local_counters __percpu *pcpu_counters;
 
@@ -1494,6 +1510,493 @@ static struct ipv6_sr_hdr *seg6_mobile_get_validated_srh(struct sk_buff *skb,
 	return srh;
 }
 
+/* Args.Mob.Session is a 40-bit field (RFC 9433 Section 6.1 Figure 8). */
+#define SEG6_MOBILE_ARGS_MOB_LEN	40
+
+/* Read @nbits from a 16-byte big-endian @addr at bit offset @bit_off,
+ * returned left-justified in 64 bits.  Caller ensures bit_off + nbits
+ * <= 128 and 1 <= nbits <= 64.
+ */
+static u64 seg6_mobile_addr_get_bits(const u8 *addr, unsigned int bit_off,
+				     unsigned int nbits)
+{
+	u64 hi = get_unaligned_be64(addr);
+	u64 lo = get_unaligned_be64(addr + 8);
+	u64 v;
+
+	if (bit_off == 0)
+		v = hi;
+	else if (bit_off < 64)
+		v = (hi << bit_off) | (lo >> (64 - bit_off));
+	else
+		v = lo << (bit_off - 64);
+
+	return v & GENMASK_ULL(63, 64 - nbits);
+}
+
+static bool seg6_mobile_v4_mask_valid(u8 v4_mask_len)
+{
+	return v4_mask_len > 0 && v4_mask_len <= 32;
+}
+
+/* Extract the IPv4 DA and Args.Mob.Session from an End.M.GTP4.E SID,
+ * where the SR Gateway locator occupies the leading @locator_bits
+ * bits of the IPv6 destination, the IPv4 DA the next @v4_mask_len
+ * bits, and Args.Mob.Session the 40 bits that follow it (RFC 9433
+ * Section 6.6 Figure 9).
+ */
+static bool seg6_mobile_parse_gtp4_sid(const struct in6_addr *daddr,
+				       unsigned int locator_bits,
+				       u8 v4_mask_len,
+				       __be32 *v4_da, u64 *args_mob)
+{
+	u64 da_field;
+
+	if (!seg6_mobile_v4_mask_valid(v4_mask_len))
+		return false;
+	if (locator_bits + v4_mask_len + SEG6_MOBILE_ARGS_MOB_LEN > 128)
+		return false;
+
+	da_field = seg6_mobile_addr_get_bits(daddr->s6_addr, locator_bits,
+					     v4_mask_len);
+	*v4_da = htonl((u32)(da_field >> 32));
+
+	*args_mob = seg6_mobile_addr_get_bits(daddr->s6_addr,
+					      locator_bits + v4_mask_len,
+					      SEG6_MOBILE_ARGS_MOB_LEN);
+	return true;
+}
+
+/* Compose the IPv4 source address per RFC 9433 Section 6.6 Figure 10:
+ * the @v4_mask_len high bits are recovered from the inbound IPv6 SA at
+ * bit offset @v6_src_prefix_len (or /64 when 0); the remaining low bits
+ * come from @src_template at the same offset.
+ */
+static __be32 seg6_mobile_v4_sa(const struct in6_addr *ip6_sa,
+				const struct in6_addr *src_template,
+				u8 v4_mask_len, u8 v6_src_prefix_len)
+{
+	u8 p_bits = v6_src_prefix_len ? : SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT;
+	u8 sa_bits = min_t(u8, v4_mask_len, 32);
+	u64 template_field, sa_field, mask;
+
+	if ((unsigned int)p_bits + 32 > 128)
+		return 0;
+
+	template_field = seg6_mobile_addr_get_bits(src_template->s6_addr,
+						   p_bits, 32);
+
+	if (sa_bits) {
+		sa_field = seg6_mobile_addr_get_bits(ip6_sa->s6_addr,
+						     p_bits, sa_bits);
+		mask = (sa_bits >= 64) ? ~0ULL : ((~0ULL) << (64 - sa_bits));
+		template_field = (template_field & ~mask) | (sa_field & mask);
+	}
+
+	return htonl((u32)(template_field >> 32));
+}
+
+/* Return the bit length of the routing prefix that delivered @skb to
+ * the current End.* handler (i.e. the prefix length of the matched FIB
+ * entry).  This is the locator length used to position v4DA /
+ * Args.Mob.Session inside the SID per RFC 9433 Section 6.6.
+ */
+static unsigned int seg6_mobile_skb_prefix_bits(const struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct rt6_info *rt;
+	struct fib6_info *fib6;
+	u8 plen = 128;
+
+	/* container_of() below requires an IPv6 dst. */
+	if (!dst || dst->ops->family != AF_INET6)
+		return 128;
+
+	rt = container_of(dst, struct rt6_info, dst);
+	rcu_read_lock();
+	fib6 = rcu_dereference(rt->from);
+	if (fib6)
+		plen = fib6->fib6_dst.plen;
+	rcu_read_unlock();
+
+	return plen;
+}
+
+/* GTP-U PDU Session extension header (3GPP TS 38.415).
+ * 4-byte minimum unit: ext_len=1, PDU Type in high 4 bits of @pdu_type_spare,
+ * QFI in low 6 bits of @spare_qfi, next_ext=0.
+ */
+struct seg6_mobile_pdu_session_ext {
+	__u8	ext_len;
+	__u8	pdu_type_spare;
+	__u8	spare_qfi;
+	__u8	next_ext;
+};
+
+#define SEG6_MOBILE_PDU_SESSION_NH		0x85	/* PDU Session extension header type */
+#define SEG6_MOBILE_PDU_SESSION_QFI_MASK	0x3f
+
+/* GTPv1-U mandatory header flags: Version=1 (bits 7..5 = 001) +
+ * Protocol Type=1 (bit 4); E/S/PN bits clear by default (3GPP TS
+ * 29.060 Figure 2 / Table 5).  ORed with GTP1_F_EXTHDR / GTP1_F_SEQ
+ * / GTP1_F_NPDU when those optional fields are present.
+ */
+#define SEG6_MOBILE_GTP1U_FLAGS_BASE	0x30
+
+/* Bit shifts within the left-justified 64-bit Args.Mob.Session
+ * (RFC 9433 Section 6.1 Figure 8): QFI(6) | R(1) | U(1) | TEID(32).
+ */
+#define SEG6_MOBILE_ARGS_QFI_SHIFT	58
+#define SEG6_MOBILE_ARGS_TEID_SHIFT	24
+
+static u8 seg6_mobile_qfi_from_args(u64 args_mob)
+{
+	return (args_mob >> SEG6_MOBILE_ARGS_QFI_SHIFT) &
+	       SEG6_MOBILE_PDU_SESSION_QFI_MASK;
+}
+
+static u32 seg6_mobile_teid_from_args(u64 args_mob)
+{
+	return lower_32_bits(args_mob >> SEG6_MOBILE_ARGS_TEID_SHIFT);
+}
+
+/* Push a GTP-U header on top of @skb.  When @pdu_type_set is true the
+ * GTPv1 long header (with the EH bit set) is followed by a 4-byte
+ * PDU Session extension header (3GPP TS 38.415); @pdu_type selects
+ * the PDU Type field (0 for downlink, 1 for uplink, 2..15 reserved).
+ * When @pdu_type_set is false the GTPv1 short header is emitted with
+ * no PDU Session Container, regardless of @qfi.
+ */
+static int seg6_mobile_push_gtpu(struct sk_buff *skb, u32 teid, u8 qfi,
+				 u8 pdu_type, bool pdu_type_set)
+{
+	struct gtp1_header_long *gtphl;
+	struct gtp1_header *gtph;
+	struct seg6_mobile_pdu_session_ext *pdu_session;
+
+	if (!pdu_type_set) {
+		if (skb_cow_head(skb, sizeof(*gtph)))
+			return -ENOMEM;
+
+		gtph = (struct gtp1_header *)skb_push(skb, sizeof(*gtph));
+		gtph->flags = SEG6_MOBILE_GTP1U_FLAGS_BASE;
+		gtph->type = GTP_TPDU;
+		gtph->length = htons(skb->len - sizeof(*gtph));
+		gtph->tid = htonl(teid);
+		return 0;
+	}
+
+	if (skb_cow_head(skb, sizeof(*gtphl) + sizeof(*pdu_session)))
+		return -ENOMEM;
+
+	pdu_session = skb_push(skb, sizeof(*pdu_session));
+	pdu_session->ext_len = 1;
+	pdu_session->pdu_type_spare = (pdu_type & 0xf) << 4;
+	pdu_session->spare_qfi = qfi & SEG6_MOBILE_PDU_SESSION_QFI_MASK;
+	pdu_session->next_ext = 0;
+
+	gtphl = (struct gtp1_header_long *)skb_push(skb, sizeof(*gtphl));
+	gtphl->flags = SEG6_MOBILE_GTP1U_FLAGS_BASE | GTP1_F_EXTHDR;
+	gtphl->type = GTP_TPDU;
+	gtphl->length = htons(skb->len - sizeof(struct gtp1_header));
+	gtphl->tid = htonl(teid);
+	gtphl->seq = 0;
+	gtphl->npdu = 0;
+	gtphl->next = SEG6_MOBILE_PDU_SESSION_NH;
+
+	return 0;
+}
+
+/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
+ * the inner T-PDU exposed by End.M.GTP4.E.  After the outer SRv6 has
+ * been popped the inner IP is briefly visible to netfilter; the
+ * finish half then needs the synthesised IPv4 outer fields and the
+ * GTP-U identifiers to rebuild the packet.
+ */
+struct seg6_mobile_gtp4_e_cb {
+	__be32	v4_da;
+	__be32	v4_sa;
+	u32	teid;
+	u8	qfi;
+	u8	outer_tclass;
+	u8	outer_hoplimit;
+	u8	pdu_type;
+	bool	pdu_type_set;
+};
+
+#define SEG6_MOBILE_GTP4_E_CB(skb)	\
+	((struct seg6_mobile_gtp4_e_cb *)((skb)->cb))
+
+static int input_action_end_m_gtp4_e_finish(struct net *net,
+					    struct sock *sk,
+					    struct sk_buff *skb)
+{
+	struct seg6_mobile_gtp4_e_cb cb = *SEG6_MOBILE_GTP4_E_CB(skb);
+	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
+	struct seg6_local_lwt *slwt;
+	struct iphdr *iph;
+	struct udphdr *uh;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+
+	/* Reject GSO packets that would not fit the egress IPv4 path after
+	 * adding our outer headers; the GSO segmenter cannot fix this up
+	 * once we have changed the network protocol from IPv6 to IPv4.
+	 * The MTU check uses the inbound IPv6 dst as a conservative bound
+	 * (the outbound IPv4 route is not known until ip_route_output_key()
+	 * below); skip the check entirely when no MTU is known on the
+	 * current dst.
+	 */
+	if (skb_is_gso(skb)) {
+		unsigned int ovhd = sizeof(*iph) + sizeof(*uh) +
+				    sizeof(struct gtp1_header_long) +
+				    sizeof(struct seg6_mobile_pdu_session_ext);
+		unsigned int mtu = dst_mtu(skb_dst(skb));
+
+		if (mtu && (mtu <= ovhd ||
+			    !skb_gso_validate_network_len(skb, mtu - ovhd))) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
+			goto drop;
+		}
+	}
+
+	/* Reserve worst-case headroom for the entire outer chain we are about
+	 * to push: IPv4 + UDP + GTP-U long header + PDU Session extension.
+	 * Subsequent skb_cow_head() calls inside seg6_mobile_push_gtpu() then
+	 * become no-ops.
+	 */
+	if (skb_cow_head(skb,
+			 sizeof(*iph) + sizeof(*uh) +
+			 sizeof(struct gtp1_header_long) +
+			 sizeof(struct seg6_mobile_pdu_session_ext)))
+		goto drop;
+
+	if (seg6_mobile_push_gtpu(skb, cb.teid, cb.qfi, cb.pdu_type,
+				  cb.pdu_type_set))
+		goto drop;
+
+	uh = skb_push(skb, sizeof(*uh));
+	skb_reset_transport_header(skb);
+	uh->source = htons(GTP1U_PORT);
+	uh->dest = htons(GTP1U_PORT);
+	uh->len = htons(skb->len);
+	uh->check = 0; /* IPv4 UDP checksum optional; offload may set later */
+
+	iph = skb_push(skb, sizeof(*iph));
+	skb_reset_network_header(skb);
+	iph->version = 4;
+	iph->ihl = sizeof(*iph) >> 2;
+	iph->tos = cb.outer_tclass;
+	iph->tot_len = htons(skb->len);
+	iph->frag_off = htons(IP_DF);
+	iph->ttl = cb.outer_hoplimit;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = cb.v4_sa;
+	iph->daddr = cb.v4_da;
+	__ip_select_ident(net, iph, 1);
+	iph->check = 0;
+	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+
+	skb->protocol = htons(ETH_P_IP);
+	nf_reset_ct(skb);
+	skb_dst_drop(skb);
+
+	/* The IPv4 outer is constructed locally from the SRv6 SID and the
+	 * inbound IPv6 outer (RFC 9433 Section 6.6 Figure 9 / 10).  The
+	 * IPv4 source address is synthesised, so it is not guaranteed to
+	 * have a reverse route; ip_route_input() + dst_input() with
+	 * rp_filter enabled would drop the packet.  Use an output route
+	 * lookup with FLOWI_FLAG_ANYSRC and emit via dst_output(): the
+	 * packet is locally originated from the IPv4 stack's perspective
+	 * and traverses NF_INET_LOCAL_OUT.
+	 */
+	{
+		struct rtable *rt;
+		struct flowi4 fl4 = {
+			.daddr = cb.v4_da,
+			.saddr = cb.v4_sa,
+			.flowi4_proto = IPPROTO_UDP,
+			.flowi4_flags = FLOWI_FLAG_ANYSRC,
+			.flowi4_oif = slwt->oif,
+		};
+
+		rt = ip_route_output_key(net, &fl4);
+		if (IS_ERR(rt)) {
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
+			goto drop;
+		}
+		skb_dst_set(skb, &rt->dst);
+		return dst_output(net, NULL, skb);
+	}
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+/* RFC 9433 Section 6.6 -- End.M.GTP4.E
+ * Receives an SRv6 packet and re-encapsulates the inner payload in
+ * IPv4/UDP/GTP-U (with an optional PDU Session extension header)
+ * toward a legacy IPv4 gNB.
+ *
+ * When net.netfilter.nf_hooks_lwtunnel=1 the inner T-PDU is exposed
+ * to NF_INET_PRE_ROUTING after the outer IPv6/SRH is popped and
+ * before the GTP-U header is pushed.  This lets nftables / conntrack
+ * apply policy on the inner 5-tuple at the SR Gateway.
+ */
+static int input_action_end_m_gtp4_e(struct sk_buff *skb,
+				     struct seg6_local_lwt *slwt)
+{
+	u8 qfi, outer_tclass, outer_hoplimit;
+	unsigned int outer_len;
+	struct ipv6_sr_hdr *srh;
+	struct in6_addr ip6_sa;
+	struct seg6_mobile_gtp4_e_cb *cb;
+	bool no_srh = false;
+	int inner_nfproto;
+	__be16 frag_off;
+	__be32 v4_da, v4_sa;
+	struct ipv6hdr *ip6h;
+	u64 args_mob;
+	u32 teid;
+	u8 nh;
+	int off;
+	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
+
+	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp4_e_cb) >
+		     sizeof_field(struct sk_buff, cb));
+
+	if (!pskb_may_pull(skb, sizeof(*ip6h))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	ip6h = ipv6_hdr(skb);
+	ip6_sa = ip6h->saddr;
+
+	/* Snapshot fields read from the IPv6 outer before any pskb_may_pull()
+	 * call below: seg6_mobile_get_validated_srh() invokes pskb_may_pull()
+	 * internally and may reallocate skb->head, invalidating @ip6h.  RFC
+	 * 6040 outer-to-outer propagation: DSCP+ECN to TOS, HopLimit to TTL.
+	 */
+	outer_tclass = ipv6_get_dsfield(ip6h);
+	outer_hoplimit = ip6h->hop_limit;
+
+	if (!seg6_mobile_parse_gtp4_sid(&ip6h->daddr,
+					seg6_mobile_skb_prefix_bits(skb),
+					minfo->v4_mask_len,
+					&v4_da, &args_mob))
+		goto drop;
+
+	/* Validate SRH (if present) per RFC 9433 Section 6.6 S01-S04: SL
+	 * must be 0.  HMAC is enforced when the SRH is present and the
+	 * kernel was built with CONFIG_IPV6_SEG6_HMAC.
+	 */
+	srh = seg6_mobile_get_validated_srh(skb, &no_srh);
+	if (!srh && !no_srh) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+	if (srh && srh->segments_left != 0) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+
+	/* @ip6h may have been invalidated by pskb_may_pull() inside
+	 * seg6_mobile_get_validated_srh(); re-evaluate before any further
+	 * dereference.
+	 */
+	ip6h = ipv6_hdr(skb);
+
+	teid = seg6_mobile_teid_from_args(args_mob);
+	qfi = seg6_mobile_qfi_from_args(args_mob);
+
+	v4_sa = seg6_mobile_v4_sa(&ip6_sa, &minfo->src_addr, minfo->v4_mask_len,
+				  minfo->v6_src_prefix_len);
+
+	/* RFC 9433 Section 6.6 upper-layer S02 mandates "Pop the IPv6
+	 * header and all its extension headers".  Use ipv6_skip_exthdr()
+	 * so HBH / Routing / Dest-Opts / Fragment headers are accounted
+	 * for in addition to the SRH.  The terminal next-header value
+	 * also selects NFPROTO_IPV4 / NFPROTO_IPV6 for the
+	 * NF_INET_PRE_ROUTING hook below.
+	 */
+	nh = ip6h->nexthdr;
+	off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh, &frag_off);
+	if (off < 0) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+	outer_len = off;
+
+	switch (nh) {
+	case IPPROTO_IPIP:
+		inner_nfproto = NFPROTO_IPV4;
+		break;
+	case IPPROTO_IPV6:
+		inner_nfproto = NFPROTO_IPV6;
+		break;
+	default:
+		inner_nfproto = -1;
+		break;
+	}
+
+	/* For inner IP traffic that may traverse NF_INET_PRE_ROUTING below,
+	 * pull the full inner IP header into the linear area so a netfilter
+	 * hook reading skb_transport_header() does not access stale data.
+	 * Non-IP inner is forwarded as-is via the GTP-U T-PDU payload.
+	 */
+	if (!pskb_may_pull(skb, outer_len + ((inner_nfproto == NFPROTO_IPV4) ?
+					     sizeof(struct iphdr) :
+					     (inner_nfproto == NFPROTO_IPV6) ?
+					     sizeof(struct ipv6hdr) : 0))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb_pull_rcsum(skb, outer_len);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	cb = SEG6_MOBILE_GTP4_E_CB(skb);
+	cb->v4_da = v4_da;
+	cb->v4_sa = v4_sa;
+	cb->teid = teid;
+	cb->qfi = qfi;
+	cb->outer_tclass = outer_tclass;
+	cb->outer_hoplimit = outer_hoplimit;
+	cb->pdu_type = minfo->pdu_type;
+	cb->pdu_type_set = minfo->pdu_type_set;
+
+	if (inner_nfproto >= 0 &&
+	    static_branch_unlikely(&nf_hooks_lwtunnel_enabled)) {
+		/* Set skb->protocol and the transport offset to match the
+		 * inner header so the hook chain sees a coherent IPv4 /
+		 * IPv6 packet.  The finish half overwrites skb->protocol
+		 * to ETH_P_IP after the IPv4 outer is pushed.
+		 */
+		skb->protocol = (inner_nfproto == NFPROTO_IPV4) ?
+				htons(ETH_P_IP) : htons(ETH_P_IPV6);
+		skb_set_transport_header(skb,
+					 (inner_nfproto == NFPROTO_IPV4) ?
+					 sizeof(struct iphdr) :
+					 sizeof(struct ipv6hdr));
+		nf_reset_ct(skb);
+
+		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_m_gtp4_e_finish);
+	}
+
+	return input_action_end_m_gtp4_e_finish(dev_net(skb->dev), NULL, skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
 /* RFC 9433 Section 6.2 -- End.MAP
  * Replace the outer IPv6 destination address with the configured next
  * SID, decrement the Hop Limit, and forward via IPv6 routing.  The
@@ -1543,6 +2046,11 @@ static int input_action_end_map(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+/* Forward declarations; defined next to the parse_nla_mobile_* helpers below. */
+static int seg6_mobile_v4_validate(struct seg6_local_lwt *slwt,
+				   const void *cfg,
+				   struct netlink_ext_ack *extack);
+
 static struct seg6_action_desc seg6_action_table[] = {
 	{
 		.action		= SEG6_LOCAL_ACTION_END,
@@ -1640,6 +2148,19 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.optattrs	= SEG6_F_LOCAL_COUNTERS,
 		.input		= input_action_end_bpf,
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_M_GTP4_E,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR) |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V4_MASK_LEN),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_PDU_TYPE) |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN) |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
+		.input		= input_action_end_m_gtp4_e,
+		.slwt_ops	= {
+			.build_state = seg6_mobile_v4_validate,
+		},
+	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_MAP,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
@@ -1736,6 +2257,11 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_BPF]	= { .type = NLA_NESTED },
 	[SEG6_LOCAL_COUNTERS]	= { .type = NLA_NESTED },
 	[SEG6_LOCAL_FLAVORS]	= { .type = NLA_NESTED },
+	[SEG6_LOCAL_MOBILE_SRC_ADDR] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[SEG6_LOCAL_MOBILE_V4_MASK_LEN] = { .type = NLA_U8 },
+	[SEG6_LOCAL_MOBILE_PDU_TYPE] = { .type = NLA_U8 },
+	[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN] = { .type = NLA_U8 },
 };
 
 static int parse_nla_srh(struct nlattr **attrs, struct seg6_local_lwt *slwt,
@@ -1970,6 +2496,163 @@ static int cmp_nla_oif(struct seg6_local_lwt *a, struct seg6_local_lwt *b)
 	return 0;
 }
 
+static int parse_nla_mobile_src_addr(struct nlattr **attrs,
+				     struct seg6_local_lwt *slwt,
+				     struct netlink_ext_ack *extack)
+{
+	memcpy(&slwt->mobile_info.src_addr,
+	       nla_data(attrs[SEG6_LOCAL_MOBILE_SRC_ADDR]),
+	       sizeof(struct in6_addr));
+	return 0;
+}
+
+static int put_nla_mobile_src_addr(struct sk_buff *skb,
+				   struct seg6_local_lwt *slwt)
+{
+	if (nla_put(skb, SEG6_LOCAL_MOBILE_SRC_ADDR,
+		    sizeof(struct in6_addr), &slwt->mobile_info.src_addr))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int cmp_nla_mobile_src_addr(struct seg6_local_lwt *a,
+				   struct seg6_local_lwt *b)
+{
+	return memcmp(&a->mobile_info.src_addr, &b->mobile_info.src_addr,
+		      sizeof(struct in6_addr));
+}
+
+static int parse_nla_mobile_v4_mask_len(struct nlattr **attrs,
+					struct seg6_local_lwt *slwt,
+					struct netlink_ext_ack *extack)
+{
+	u8 len = nla_get_u8(attrs[SEG6_LOCAL_MOBILE_V4_MASK_LEN]);
+
+	if (!seg6_mobile_v4_mask_valid(len)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile IPv4 mask length must be in 1..32 and leave room for the 40-bit Args.Mob.Session");
+		return -EINVAL;
+	}
+	slwt->mobile_info.v4_mask_len = len;
+	return 0;
+}
+
+static int put_nla_mobile_v4_mask_len(struct sk_buff *skb,
+				      struct seg6_local_lwt *slwt)
+{
+	if (nla_put_u8(skb, SEG6_LOCAL_MOBILE_V4_MASK_LEN,
+		       slwt->mobile_info.v4_mask_len))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int cmp_nla_mobile_v4_mask_len(struct seg6_local_lwt *a,
+				      struct seg6_local_lwt *b)
+{
+	return a->mobile_info.v4_mask_len != b->mobile_info.v4_mask_len;
+}
+
+static int parse_nla_mobile_pdu_type(struct nlattr **attrs,
+				     struct seg6_local_lwt *slwt,
+				     struct netlink_ext_ack *extack)
+{
+	u8 t = nla_get_u8(attrs[SEG6_LOCAL_MOBILE_PDU_TYPE]);
+
+	/* 3GPP TS 38.415: PDU Type is a 4-bit field. */
+	if (t > 0xf) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile PDU Type must fit in 4 bits (0..15)");
+		return -EINVAL;
+	}
+	slwt->mobile_info.pdu_type = t;
+	slwt->mobile_info.pdu_type_set = true;
+	return 0;
+}
+
+static int put_nla_mobile_pdu_type(struct sk_buff *skb,
+				   struct seg6_local_lwt *slwt)
+{
+	if (!slwt->mobile_info.pdu_type_set)
+		return 0;
+	if (nla_put_u8(skb, SEG6_LOCAL_MOBILE_PDU_TYPE,
+		       slwt->mobile_info.pdu_type))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int cmp_nla_mobile_pdu_type(struct seg6_local_lwt *a,
+				   struct seg6_local_lwt *b)
+{
+	if (a->mobile_info.pdu_type_set != b->mobile_info.pdu_type_set)
+		return 1;
+	if (!a->mobile_info.pdu_type_set)
+		return 0;
+	return a->mobile_info.pdu_type != b->mobile_info.pdu_type;
+}
+
+static int parse_nla_mobile_v6_src_prefix_len(struct nlattr **attrs,
+					      struct seg6_local_lwt *slwt,
+					      struct netlink_ext_ack *extack)
+{
+	u8 len = nla_get_u8(attrs[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN]);
+
+	/* RFC 9433 Section 6.6 Figure 10: P + IPv4 SA (a bits) + padding =
+	 * 128.  P must be non-zero and leave room for the IPv4 SA (a >= 1)
+	 * within the IPv6 source address; the cross-attribute upper bound
+	 * (P + a <= 128) is enforced in the action's build_state callback.
+	 */
+	if (len == 0 || len > 127) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile v6_src_prefix_len must be in 1..127");
+		return -EINVAL;
+	}
+	slwt->mobile_info.v6_src_prefix_len = len;
+	return 0;
+}
+
+static int put_nla_mobile_v6_src_prefix_len(struct sk_buff *skb,
+					    struct seg6_local_lwt *slwt)
+{
+	if (nla_put_u8(skb, SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
+		       slwt->mobile_info.v6_src_prefix_len))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int cmp_nla_mobile_v6_src_prefix_len(struct seg6_local_lwt *a,
+					    struct seg6_local_lwt *b)
+{
+	return a->mobile_info.v6_src_prefix_len !=
+	       b->mobile_info.v6_src_prefix_len;
+}
+
+/* build_state callback shared between End.M.GTP4.E and H.M.GTP4.D
+ * that performs the RFC 9433 Section 6.6 Figure 10 cross-attribute
+ * sanity check (Source UPF Prefix length P + IPv4 portion length a
+ * <= 128) using the effective P (= the configured v6_src_prefix_len
+ * or the SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT when unset).
+ */
+static int seg6_mobile_v4_validate(struct seg6_local_lwt *slwt,
+				   const void *cfg,
+				   struct netlink_ext_ack *extack)
+{
+	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
+	u8 p_bits = minfo->v6_src_prefix_len ? :
+		    SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT;
+
+	/* seg6_mobile_v4_sa() reads a 32-bit IPv4 template at @p_bits from
+	 * the IPv6 SA template, so the prefix must leave room for those
+	 * 32 bits.  v4_mask_len is bounded to 32 separately, so this also
+	 * implies p_bits + v4_mask_len <= 128.
+	 */
+	if ((unsigned int)p_bits + 32 > 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile v6_src_prefix_len must leave room for the 32-bit IPv4 source template (prefix_len <= 96)");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 #define MAX_PROG_NAME 256
 static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
 	[SEG6_LOCAL_BPF_PROG]	   = { .type = NLA_U32, },
@@ -2399,6 +3082,22 @@ static struct seg6_action_param seg6_action_params[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_FLAVORS]	= { .parse = parse_nla_flavors,
 				    .put = put_nla_flavors,
 				    .cmp = cmp_nla_flavors },
+
+	[SEG6_LOCAL_MOBILE_SRC_ADDR] = { .parse = parse_nla_mobile_src_addr,
+					 .put = put_nla_mobile_src_addr,
+					 .cmp = cmp_nla_mobile_src_addr },
+
+	[SEG6_LOCAL_MOBILE_V4_MASK_LEN] = { .parse = parse_nla_mobile_v4_mask_len,
+					    .put = put_nla_mobile_v4_mask_len,
+					    .cmp = cmp_nla_mobile_v4_mask_len },
+
+	[SEG6_LOCAL_MOBILE_PDU_TYPE] = { .parse = parse_nla_mobile_pdu_type,
+					 .put = put_nla_mobile_pdu_type,
+					 .cmp = cmp_nla_mobile_pdu_type },
+
+	[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN] = { .parse = parse_nla_mobile_v6_src_prefix_len,
+						  .put = put_nla_mobile_v6_src_prefix_len,
+						  .cmp = cmp_nla_mobile_v6_src_prefix_len },
 };
 
 /* call the destroy() callback (if available) for each set attribute in
@@ -2715,6 +3414,18 @@ static int seg6_local_get_encap_size(struct lwtunnel_state *lwt)
 	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_FLAVORS))
 		nlsize += encap_size_flavors(slwt);
 
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR))
+		nlsize += nla_total_size(16);
+
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V4_MASK_LEN))
+		nlsize += nla_total_size(1);
+
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_PDU_TYPE))
+		nlsize += nla_total_size(1);
+
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN))
+		nlsize += nla_total_size(1);
+
 	return nlsize;
 }
 
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b43e87e36174..c27d54fd5ab7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_PROGS := \
 	sctp_vrf.sh \
 	skf_net_off.sh \
 	so_txtime.sh \
+	srv6_end_m_gtp4_e_test.sh \
 	srv6_end_map_test.sh \
 	srv6_end_dt46_l3vpn_test.sh \
 	srv6_end_dt4_l3vpn_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_m_gtp4_e_test.sh b/tools/testing/selftests/net/srv6_end_m_gtp4_e_test.sh
new file mode 100755
index 000000000000..011495e7b0ee
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_m_gtp4_e_test.sh
@@ -0,0 +1,485 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for the SRv6 End.M.GTP4.E behavior (RFC 9433 Section 6.6).
+#
+# Three network namespaces are connected back-to-back:
+#
+#   +-------+   2001:db8:1::/64   +-------+     10.0.0.0/24     +-------+
+#   | srupf | ------------------- | srgw  | ------------------- |  gnb  |
+#   +-------+        veth-n9      +-------+        veth-n3      +-------+
+#
+# srupf is the SR-domain-side SRv6-aware UPF (RFC 9433 sense, not a
+# 3GPP UPF) that injects the SRv6 packets, gnb is the GTP-U-side
+# test peer, and srgw runs the End.M.GTP4.E behavior under test.
+#
+# On srgw an End.M.GTP4.E SID is installed with a /32 routing prefix;
+# the SID layout (per RFC 9433 Section 6.6 Figure 9) is:
+#
+#   Locator | IPv4 DA (v4_mask_len bits) | Args.Mob.Session (40 bits) [| pad]
+#
+# With locator=/32 and v4_mask_len=32 the IPv4 DA lives at bytes 4..7 and
+# Args.Mob.Session at bytes 8..12; bytes 13..15 are SID padding.
+# Choosing a non-tail-aligned layout (i.e. not /56 with c=0) makes sure
+# the test exercises the offset-based extraction rather than a
+# "last 5 bytes" shortcut.
+#
+# Args.Mob.Session is laid out as (RFC 9433 Section 6.1, Figure 8 -- 40 bits):
+#   QFI (6) | R (1) | U (1) | PDU Session ID (32)
+#
+# The test crafts an IPv6 packet whose destination address encodes
+#
+#   IPv4 DA          = 10.0.0.2 (gnb)
+#   QFI              = 5
+#   PDU Session ID   = 0x123 (= the GTP-U TEID, 32 bits)
+#
+# Args.Mob.Session bytes are therefore 14 00 00 01 23 (top byte is the
+# QFI byte (5 << 2) = 0x14, next four bytes are the 32-bit TEID).  With
+# the /32-locator placement the SID ends up as
+#   2001:db8:a00:2:1400:1:2300:0 .
+# The expected output is an IPv4/UDP/GTP-U(long)/PDU-Session-ext packet with
+# TEID 0x00000123 and QFI 5.
+#
+# The IPv6 source address layout per RFC 9433 Section 6.6 Figure 10:
+#
+#   | Source srupf Prefix (P bits) | IPv4 SA (a bits) | padding |
+#
+# is exercised in two scenarios:
+#   - Default (no v6_src_prefix_len attribute): P = 64, IPv4 SA at
+#     IPv6 bytes 8..11.
+#   - Explicit v6_src_prefix_len 48: IPv4 SA at IPv6 bytes 6..9, with
+#     a 6-byte Source srupf Prefix and a 6-byte trailing padding region.
+
+source lib.sh
+
+readonly TIMEOUT=4
+tcpdump_pid=""
+have_vrf=0
+
+cleanup()
+{
+	if [ -n "$tcpdump_pid" ]; then
+		kill "$tcpdump_pid" 2>/dev/null
+		wait "$tcpdump_pid" 2>/dev/null
+	fi
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup()
+{
+	setup_ns srupf srgw gnb gnb_vrf
+
+	ip -n "$srgw" link set dev lo up
+	ip -n "$srupf" link set dev lo up
+	ip -n "$gnb" link set dev lo up
+	ip -n "$gnb_vrf" link set dev lo up
+
+	# upf <-> srgw (IPv6).  Two srupf addresses encode the same
+	# IPv4 SA (10.0.0.1) at different byte offsets, exercising the
+	# default /64 and an explicit /48 Source srupf Prefix layout:
+	#   2001:db8:1::a00:1:0:1     -> IPv4 SA at IPv6 bytes 8..11 (P = 64)
+	#   2001:db8:3:a00:1::1       -> IPv4 SA at IPv6 bytes 6..9  (P = 48)
+	# The srgw peer addresses are placed on the same IPv6 /64 prefix
+	# as the srupf side so the srupf routes can name them as on-link
+	# next-hops without explicit neighbor discovery.
+	ip link add veth-n9 netns "$srupf" type veth peer name veth-n9-srgw \
+		netns "$srgw"
+	ip -n "$srupf" addr add 2001:db8:1::a00:1:0:1/64 dev veth-n9 nodad
+	ip -n "$srupf" addr add 2001:db8:3:a00:1::1/64 dev veth-n9 nodad
+	ip -n "$srgw" addr add 2001:db8:1::2/64 dev veth-n9-srgw nodad
+	ip -n "$srgw" addr add 2001:db8:3:a00:1::2/64 dev veth-n9-srgw nodad
+	ip -n "$srupf" link set dev veth-n9 up
+	ip -n "$srgw" link set dev veth-n9-srgw up
+
+	# srgw <-> gnb (IPv4)
+	ip link add veth-n3 netns "$srgw" type veth peer name veth-n3-gnb \
+		netns "$gnb"
+	ip -n "$srgw" addr add 10.0.0.1/24 dev veth-n3
+	ip -n "$gnb" addr add 10.0.0.2/24 dev veth-n3-gnb
+	ip -n "$srgw" link set dev veth-n3 up
+	ip -n "$gnb" link set dev veth-n3-gnb up
+
+	# allow forwarding on srgw
+	ip netns exec "$srgw" sysctl -wq net.ipv4.ip_forward=1
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	# routes on upf toward the End.M.GTP4.E locators
+	ip -n "$srupf" -6 route add 2001:db8::/32 via 2001:db8:1::2
+	ip -n "$srupf" -6 route add 2001:db9::/32 via 2001:db8:3:a00:1::2
+	ip -n "$srupf" -6 route add 2001:dbb::/32 via 2001:db8:1::2
+
+	# install End.M.GTP4.E on srgw with PDU Session Container (5G N3:
+	# pdu_type dl), default /64 Source srupf Prefix
+	ip -n "$srgw" -6 route add 2001:db8::/32 \
+		encap seg6local action End.M.GTP4.E \
+			src 2001:db8:1::2 v4_mask_len 32 pdu_type dl \
+		dev veth-n3
+
+	# install End.M.GTP4.E on srgw with PDU Session Container and
+	# explicit v6_src_prefix_len 48
+	ip -n "$srgw" -6 route add 2001:db9::/32 \
+		encap seg6local action End.M.GTP4.E \
+			src 2001:db9::1 v4_mask_len 32 v6_src_prefix_len 48 \
+			pdu_type dl \
+		dev veth-n3
+
+	# install End.M.GTP4.E on srgw WITHOUT pdu_type: short GTPv1-U
+	# (LTE-style, no PDU Session Container) regardless of QFI
+	ip -n "$srgw" -6 route add 2001:dbb::/32 \
+		encap seg6local action End.M.GTP4.E \
+			src 2001:db8:1::2 v4_mask_len 32 \
+		dev veth-n3
+
+	# Per-route VRF case: a second egress IPv4 path in its own VRF
+	# (e.g. modelling a second tenant on a different interface).  The
+	# End.M.GTP4.E SID for this tenant binds the egress IPv4 lookup to
+	# the VRF via the standard seg6_local 'oif' attribute; without
+	# it, the lookup would fall through to the main table where the
+	# 10.0.1.0/24 prefix does not exist.
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	modprobe vrf 2>/dev/null
+	if ip -n "$srgw" link add vrf-n3 type vrf table 100 2>/dev/null; then
+		have_vrf=1
+		ip -n "$srgw" link set dev vrf-n3 up
+
+		ip link add veth-n3-2 netns "$srgw" type veth peer name \
+			veth-n3-2-gnb netns "$gnb_vrf"
+		ip -n "$srgw" link set dev veth-n3-2 master vrf-n3
+		ip -n "$srgw" addr add 10.0.1.1/24 dev veth-n3-2
+		ip -n "$gnb_vrf" addr add 10.0.1.2/24 dev veth-n3-2-gnb
+		ip -n "$srgw" link set dev veth-n3-2 up
+		ip -n "$gnb_vrf" link set dev veth-n3-2-gnb up
+
+		ip -n "$srupf" -6 route add 2001:dba::/32 via 2001:db8:1::2
+
+		ip -n "$srgw" -6 route add 2001:dba::/32 \
+			encap seg6local action End.M.GTP4.E \
+				src 2001:db8:1::2 v4_mask_len 32 oif vrf-n3 \
+				pdu_type dl \
+			dev veth-n3-2
+	fi
+}
+
+check_dependencies()
+{
+	if ! ip netns help 2>&1 | grep -q "exec"; then
+		echo "SKIP: ip netns exec not available"
+		exit "$ksft_skip"
+	fi
+
+	if ! command -v tcpdump >/dev/null; then
+		echo "SKIP: tcpdump is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! command -v ping >/dev/null; then
+		echo "SKIP: ping is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! command -v python3 >/dev/null; then
+		echo "SKIP: python3 is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.M.GTP4.E"; then
+		echo "SKIP: iproute2 too old, missing seg6local action End.M.GTP4.E"
+		exit "$ksft_skip"
+	fi
+
+	if ! python3 -c "import scapy.all" 2>/dev/null; then
+		echo "SKIP: python3-scapy is required"
+		exit "$ksft_skip"
+	fi
+}
+
+capture_traffic()
+{
+	local capture_ns="$1"
+	local capture_iface="$2"
+	local src="$3"
+	local sid="$4"
+	local out="$5"
+
+	# capture GTP-U traffic on the egress side.  The capture is torn down
+	# by the explicit kill -INT below; the cleanup() trap only fires for
+	# unexpected exits.
+	ip netns exec "$capture_ns" tcpdump -U -nni "$capture_iface" -w "$out" \
+		'udp port 2152' 2>/dev/null &
+	tcpdump_pid=$!
+	# Give tcpdump a brief moment to attach the BPF filter before we
+	# start sending traffic; tcpdump does not expose a "ready" signal.
+	sleep 1
+
+	# Send a single ICMPv6 echo-request to the End.M.GTP4.E SID.
+	ip netns exec "$srupf" ping -6 -c 1 -W "$TIMEOUT" -I "$src" "$sid" \
+		>/dev/null 2>&1
+
+	# stop tcpdump after the packet has had time to traverse
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+}
+
+run_test()
+{
+	local src="$1"			# IPv6 SA the srupf must use
+	local sid="$2"			# End.M.GTP4.E SID to ping
+	local expected_v4_src="$3"	# expected IPv4 SA in the egress GTP-U
+	local capture_ns="${4:-$gnb}"	# netns where GTP-U is expected to land
+	local capture_iface="${5:-veth-n3-gnb}"
+	local out
+	local rc
+
+	out=$(mktemp)
+	capture_traffic "$capture_ns" "$capture_iface" "$src" "$sid" "$out"
+
+	# Expected wire layout (verified via scapy field comparison rather
+	# than tcpdump -X | grep so the test is robust against tcpdump
+	# output formatting changes):
+	#   IPv4 (src=$expected_v4_src, dst=10.0.0.2) | UDP(2152) |
+	#     GTPv1 long (TEID=0x123, S/PN/E=001) |
+	#     PDU Session ext (next=0x85, len=1, PDU type=DL=0, QFI=5) | inner T-PDU
+	EXPECTED_V4_SRC="$expected_v4_src" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IP, UDP
+
+expected_v4_src = os.environ['EXPECTED_V4_SRC']
+pkts = rdpcap(sys.argv[1])
+if not pkts:
+    sys.exit("no captured packets")
+
+found = False
+for p in pkts:
+    if not (IP in p and UDP in p):
+        continue
+    if p[UDP].dport != 2152:
+        continue
+    if p[IP].src != expected_v4_src:
+        sys.exit(f"unexpected IPv4 SA {p[IP].src}, want {expected_v4_src}")
+    payload = bytes(p[UDP].payload)
+    # GTP-U long header: flags(1)|mtype(1)|len(2)|teid(4)|seq(2)|npdu(1)|next(1)
+    if len(payload) < 12:
+        continue
+    teid = int.from_bytes(payload[4:8], 'big')
+    if teid != 0x00000123:
+        sys.exit(f"unexpected TEID 0x{teid:08x}, want 0x00000123")
+    next_ext = payload[11]
+    if next_ext != 0x85:
+        sys.exit(f"missing PDU Session ext (next={next_ext:#04x}, want 0x85)")
+    pdu_session = payload[12:16]
+    if pdu_session[0] != 0x01:
+        sys.exit(f"PDU Session ext_len {pdu_session[0]} != 1")
+    pdu_type = pdu_session[1] >> 4
+    qfi = pdu_session[2] & 0x3f
+    if pdu_type != 0:
+        sys.exit(f"PDU Type {pdu_type} != 0 (DL)")
+    if qfi != 5:
+        sys.exit(f"PDU Session QFI {qfi} != 5")
+    found = True
+    break
+
+if not found:
+    sys.exit("no IPv4/UDP/GTP-U packet observed")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify the short-GTPv1-U output produced when pdu_type is unset on the
+# route: 8-byte GTP-U header, no extension flag, no PDU Session
+# Container, regardless of the QFI extracted from Args.Mob.Session.
+run_test_short()
+{
+	local src="$1"
+	local sid="$2"
+	local expected_v4_src="$3"
+	local out
+	local rc
+
+	out=$(mktemp)
+	capture_traffic "$gnb" "veth-n3-gnb" "$src" "$sid" "$out"
+
+	EXPECTED_V4_SRC="$expected_v4_src" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IP, UDP
+
+expected_v4_src = os.environ['EXPECTED_V4_SRC']
+pkts = rdpcap(sys.argv[1])
+if not pkts:
+    sys.exit("no captured packets")
+
+found = False
+for p in pkts:
+    if not (IP in p and UDP in p):
+        continue
+    if p[UDP].dport != 2152:
+        continue
+    if p[IP].src != expected_v4_src:
+        sys.exit(f"unexpected IPv4 SA {p[IP].src}, want {expected_v4_src}")
+    payload = bytes(p[UDP].payload)
+    if len(payload) < 8:
+        continue
+    flags = payload[0]
+    # Short GTPv1-U: version=1, PT=1, no E/S/PN bits (0x30).
+    if flags != 0x30:
+        sys.exit(f"unexpected GTP-U flags {flags:#04x}, want 0x30 (short)")
+    teid = int.from_bytes(payload[4:8], 'big')
+    if teid != 0x00000123:
+        sys.exit(f"unexpected TEID 0x{teid:08x}, want 0x00000123")
+    found = True
+    break
+
+if not found:
+    sys.exit("no IPv4/UDP/GTP-U packet observed")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify that nf_hooks_lwtunnel=1 makes the inner T-PDU 5-tuple
+# visible to nftables on the SR Gateway.  The inner T-PDU is IPv6
+# (ICMPv6 echo-request from the upf); the nft rule matches on its
+# IPv6 source address.  DROP must suppress the GTP-U at the gnb,
+# ACCEPT must let it through.
+run_nf_test()
+{
+	local verdict="$1"		# drop | accept
+	local expect="$2"		# 1 if GTP-U expected, empty otherwise
+	local src="2001:db8:1::a00:1:0:1"
+	local sid="2001:db8:a00:2:1400:1:2300:0"
+	local out
+
+	ip netns exec "$srgw" nft flush chain ip6 filter prerouting
+	ip netns exec "$srgw" nft add rule ip6 filter prerouting \
+		ip6 saddr "$src" "$verdict"
+
+	out=$(mktemp)
+	capture_traffic "$gnb" "veth-n3-gnb" "$src" "$sid" "$out"
+
+	if [ -n "$expect" ]; then
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IP, UDP
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IP in p and UDP in p and p[UDP].dport == 2152:
+        sys.exit(0)
+sys.exit("expected GTP-U packet not observed at gnb despite nft accept")
+PYEOF
+	else
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IP, UDP
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IP in p and UDP in p and p[UDP].dport == 2152:
+        sys.exit("GTP-U packet leaked to gnb despite nft drop on inner")
+sys.exit(0)
+PYEOF
+	fi
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+main()
+{
+	local rc=0
+
+	check_dependencies
+	setup
+
+	# Default /64 layout: IPv4 SA at IPv6 bytes 8..11.
+	if run_test "2001:db8:1::a00:1:0:1" "2001:db8:a00:2:1400:1:2300:0" \
+		    "10.0.0.1"; then
+		echo "TEST: End.M.GTP4.E (default /64) [PASS]"
+	else
+		echo "TEST: End.M.GTP4.E (default /64) [FAIL]"
+		rc=1
+	fi
+
+	# v6_src_prefix_len 48 layout: IPv4 SA at IPv6 bytes 6..9.
+	if run_test "2001:db8:3:a00:1::1" "2001:db9:a00:2:1400:1:2300:0" \
+		    "10.0.0.1"; then
+		echo "TEST: End.M.GTP4.E (v6_src_prefix_len 48) [PASS]"
+	else
+		echo "TEST: End.M.GTP4.E (v6_src_prefix_len 48) [FAIL]"
+		rc=1
+	fi
+
+	# pdu_type unset: emit short GTPv1-U with no PDU Session Container
+	# even though Args.Mob.Session encodes QFI=5.  This is the LTE-only
+	# / S1-U style output.
+	if run_test_short "2001:db8:1::a00:1:0:1" \
+			  "2001:dbb:a00:2:1400:1:2300:0" \
+			  "10.0.0.1"; then
+		echo "TEST: End.M.GTP4.E (pdu_type unset, short header) [PASS]"
+	else
+		echo "TEST: End.M.GTP4.E (pdu_type unset, short header) [FAIL]"
+		rc=1
+	fi
+
+	# VRF binding (per-tenant): egress IPv4 lookup goes through vrf-n3
+	# (table 100), where 10.0.1.0/24 lives.  Without "oif vrf-n3" the
+	# main-table lookup would fall through; the GTP-U observed in
+	# gnb_vrf demonstrates the binding.  SID 2001:dba:a00:102:14:0:123:0
+	# encodes IPv4 DA 10.0.1.2 + QFI=5 / TEID=0x123.
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	if [ "$have_vrf" = "1" ]; then
+		if run_test "2001:db8:1::a00:1:0:1" \
+			    "2001:dba:a00:102:1400:1:2300:0" \
+			    "10.0.0.1" "$gnb_vrf" "veth-n3-2-gnb"; then
+			echo "TEST: End.M.GTP4.E (oif vrf-n3) [PASS]"
+		else
+			echo "TEST: End.M.GTP4.E (oif vrf-n3) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP4.E (oif vrf-n3) [SKIP] (CONFIG_NET_VRF not loaded)"
+	fi
+
+	# Inner T-PDU netfilter hook: only meaningful when nft is present
+	# and the kernel exposes net.netfilter.nf_hooks_lwtunnel.
+	if command -v nft >/dev/null && \
+	   ip netns exec "$srgw" sysctl -wq \
+		net.netfilter.nf_hooks_lwtunnel=1 2>/dev/null; then
+		ip netns exec "$srgw" nft add table ip6 filter
+		ip netns exec "$srgw" nft 'add chain ip6 filter prerouting' \
+			'{ type filter hook prerouting priority 0; }'
+
+		if run_nf_test drop ""; then
+			echo "TEST: End.M.GTP4.E (nft drop on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP4.E (nft drop on inner) [FAIL]"
+			rc=1
+		fi
+
+		if run_nf_test accept "1"; then
+			echo "TEST: End.M.GTP4.E (nft accept on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP4.E (nft accept on inner) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP4.E (inner-flow netfilter hook) [SKIP]" \
+		     "(nft or nf_hooks_lwtunnel unavailable)"
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		echo "TEST: End.M.GTP4.E [PASS]"
+		exit "$ksft_pass"
+	else
+		echo "TEST: End.M.GTP4.E [FAIL]"
+		exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1



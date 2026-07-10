Return-Path: <netdev+bounces-306545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h2bKNh7jUGpt7wIAu9opvQ
	(envelope-from <netdev+bounces-306545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:18:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B973AAFE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XG3tSn0n;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306545-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306545-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A1D53004617
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4F3B14D0;
	Fri, 10 Jul 2026 12:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501040BCB0
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685907; cv=none; b=UZZTVbX4WV4FaABNu6M9E5yKXCN/PfhcnAiPPYDZhb09ZuP+67YH0xppqGp3joHtDgtf+bM3f9+0ukTo2AI/6GlQU3iPxiNb3SNRwzMh3pb2YtcPCl42Lp+JZZWfcCgAlC+q9yeVxnQzd1sS8fCBPcJVKUvSqy9a1tMSmFQzvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685907; c=relaxed/simple;
	bh=FJCKa58IC6H0MQEjqDmcHw2w07jC+tF+UFLv0awPSOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwCQnW+bS2g+WZAZKouLZviQzqm+L7cgzOZZpYQ3yKHPylAVlIOc4rskxrUwe8rAWWpCxQTeBGdrixKj3iBls8L4T8lrqJ1B8CejZ7Y2soWneZQ5pbWSwXwQ/aYlEse47n3wgLa9Hy+kwYuRy4wIumink6GWiClM/NqP/qg2ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG3tSn0n; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso864728b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783685903; x=1784290703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OCEE6Z1wOLlnnOwCFs9n15GERESAgBFscngiBSRg7M=;
        b=XG3tSn0n0s0DGjTLWmAAOlls9sk9LaG7wXd0igQwKmHMP7S4nFU5JP1i4uAKB9U+G3
         bwMW9Q73RlLtkoXTiUhAuAqKYwt23bUGqHf0wVxNOyl8kP6SUqmMOL3WEkSrR9mdv897
         LkWzCBiSEqNHphAjwtTYqe9YPy9w9qk94OaF82ZEMhPxOrRmI+wk1Syai5uWSr9eW7Oz
         ajk/hpMZgiHojfFXFOHVrp1bC0qGtv0pI4ycjdNkebP+kyOYIEgGXuAOhhstHpvqGSZF
         198v44OxKag1nAIrVg/LL6XryRzs5fMzHz1aSIdgqZhFGXpC1/iTxOIBZbM9k+MK56oD
         mPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685903; x=1784290703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OCEE6Z1wOLlnnOwCFs9n15GERESAgBFscngiBSRg7M=;
        b=MlLhWZfEPIxd3ayPZKC+XZcoOhnVRa6MN8WpMOhNzipUxyS9UiC7A1zqURlJ9VCvPv
         rhrOPBgRul1VKKNIm3VeZH9wZsj6lXCAnwJryVnMduhulzIEuXowOZb+yVhR9lQkMfvw
         apf/DZ2uAHTXsQa6ngXIyGRQYQGA8YTwMR8UXZjQrOFz6AEWySaVs9gJemNEXAvBh1gf
         oAv04f/FJSuiiBGMVjG2U7Aee5l0QJf4qK2tRoZ5kr3BAepaGu4kXGZGGgzuvWmVg8F9
         BkwOc6j98SdDf+tp9HLfVtcsWexZrBC742ILMtppaukzNgsZJQqSfetELSZXE+ZaiPGE
         NuIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4wxmqZFBZSjyXHwKhAwV9KCpryMbnefV0fheTyYPki2+fM295NK9IkWU7zKomj+Gjo0xFzUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8yCov8mUbYMy0/z1UiHE6sMms41MfCv/z+2gUfOwgVOFqJWL
	mrL1jrwVcz7v8355GVDRSO7NtEguS4RgjSwNeFHk0CAAU2M+RgTp3zNe
X-Gm-Gg: AfdE7cntoGLnRatb8wxhte9cEgjvfy5PSTdhktNP/dpHaB6GNksGv29vBidd5MyzO4e
	BOovGYKisDgpLVjf32/LhOU5InvlyFTVe1u1hx6JbT7/dOnddBH0drWXeOALRynGKC+DnAGySYq
	yTEPI4AYKfH03Ec5k43iL01WsKxaH2aeeeSmycNXtjbW1JbUsKjThaTViXReyWbekUH8sJ7EzEU
	PmkvOU+88QHclk6TXprA5RcEetEs+G725S1DdP4cw+68gLqYfSiJ3j3nvowW9Psa6Pt9WuCJhje
	8ODPo+UVYrxfDVtE4eZH2ky698VZYBNdmf8b8lkuj+r65Z+AxVJdN+Tik7iHAC4OGzuBmPMTHH0
	F1dTCu/HJ3tuCvqoLM/D2Qy5FmgFvC0cjgNyugNHO1h3wumFWr1JI7sH3hwMKkswQpqiT0GHWtm
	PZKwOAnjUeQMSZjFjCRHqdmYTKdQWVy8IpUg==
X-Received: by 2002:a05:6a00:12cf:b0:848:2f84:f431 with SMTP id d2e1a72fcca58-848432cc7a0mr10846270b3a.74.1783685902780;
        Fri, 10 Jul 2026 05:18:22 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm8600845b3a.8.2026.07.10.05.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:18:21 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 10 Jul 2026 21:18:18 +0900
Subject: [PATCH RFC iproute2-next 1/2] uapi: sync lwtunnel.h and add
 seg6_mobile.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-seg6-mobile-end-map-v1-1-970275f3d80b@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com>
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=FJCKa58IC6H0MQEjqDmcHw2w07jC+tF+UFLv0awPSOU=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqUOMKv5e/vJSPBeYTAQUTE4HBxzMG3B5thHRBM
 iX5brNy1u+JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalDjCgAKCRAq19F1Kl0b
 TfuREACLJW/nCRLMsLVygpFOlNdktDv9me+4h625hQOZEo7USJ56CATeizP4JMEsEfMFrd/fH1w
 TAKeh/2RA7XbYkDn8Rp8o1y8jvgC53CBO14vuaUD1crlDd44sloY07ePDJKoHB/9a1BhGNBFlP8
 KJXbywPC9V8j0LQDp/cgWhQDKyDVwub2s200kkoAJGcG34LhCsMxoEXQRxJoxXxAlakO18ZV0H+
 JUhhdEyI/e6N4l9700NVGAFli3oR0dsQ2gr0r7SeL5VofFIT/SjL+x1jMfzQoY6PeTwfQR2GwK1
 b5kNiaqc82VSYf23428ZzRZi24/aZOHvEMS3HZFCcUHRJnJdbLk/owtSDo7m/CY1KxO6AEsVFK7
 Vj/V7u/hKvG+3lFU+IMFH9uQZ5kzw3MAAayc2y7y+Sf/ikuHqSUoCKtA9hXBH4HAEnX97jFayDu
 RyHkxD8qp/eRZnI6mO64fps8mFhxzmjW6Ij3Qy5F+7C6CuRDedzaJehdmOBTQqD1GySSXz6/W/Z
 T1cOUvd6L/Ub2G2G6UaXmB+t4BTFgUoup7Er/AMy/87DL2loZVpF2yQvdZOWC/vfuyXOsmB7Kvn
 543inXQxu6NVwCe1Y/YAXoKTLINXkfL+fZRJgmkbr4BVS8+YhSCuc/dfR0bjWEXInOeEPG0jKA/
 VT2p2L/0nby0ALg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306545-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:yuyakusakabe@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[uniroma2.it,common-net.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B72B973AAFE

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/lwtunnel.h    |  1 +
 include/uapi/linux/seg6_mobile.h | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/lwtunnel.h b/include/uapi/linux/lwtunnel.h
index 9d22961be619..b5adca10a9f1 100644
--- a/include/uapi/linux/lwtunnel.h
+++ b/include/uapi/linux/lwtunnel.h
@@ -16,6 +16,7 @@ enum lwtunnel_encap_types {
 	LWTUNNEL_ENCAP_RPL,
 	LWTUNNEL_ENCAP_IOAM6,
 	LWTUNNEL_ENCAP_XFRM,
+	LWTUNNEL_ENCAP_SEG6_MOBILE,
 	__LWTUNNEL_ENCAP_MAX,
 };
 
diff --git a/include/uapi/linux/seg6_mobile.h b/include/uapi/linux/seg6_mobile.h
new file mode 100644
index 000000000000..b99eabe9a2a1
--- /dev/null
+++ b/include/uapi/linux/seg6_mobile.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  SRv6 Mobile User Plane implementation
+ */
+#ifndef _LINUX_SEG6_MOBILE_H
+#define _LINUX_SEG6_MOBILE_H
+
+enum {
+	SEG6_MOBILE_UNSPEC,
+	SEG6_MOBILE_ACTION,
+	SEG6_MOBILE_NH6,
+	SEG6_MOBILE_COUNTERS,
+	__SEG6_MOBILE_MAX,
+};
+
+#define SEG6_MOBILE_MAX	(__SEG6_MOBILE_MAX - 1)
+
+enum {
+	SEG6_MOBILE_ACTION_UNSPEC	= 0,
+	/* swap IPv6 DA with the next SID, leave SRH untouched */
+	SEG6_MOBILE_ACTION_END_MAP	= 1,
+
+	__SEG6_MOBILE_ACTION_MAX,
+};
+
+#define SEG6_MOBILE_ACTION_MAX	(__SEG6_MOBILE_ACTION_MAX - 1)
+
+/* SRv6 Mobile Behavior counters are encoded as netlink attributes
+ * guaranteeing the correct alignment.
+ * Each counter is identified by a different attribute type (i.e.
+ * SEG6_MOBILE_CNT_PACKETS).
+ *
+ * - SEG6_MOBILE_CNT_PACKETS: identifies a counter that counts the number
+ *   of packets that have been CORRECTLY processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped are NOT
+ *   counted).
+ *
+ * - SEG6_MOBILE_CNT_BYTES: identifies a counter that counts the total
+ *   amount of traffic in bytes of all packets that have been CORRECTLY
+ *   processed by an SRv6 Behavior instance (i.e., packets that generate
+ *   errors or are dropped are NOT counted).
+ *
+ * - SEG6_MOBILE_CNT_ERRORS: identifies a counter that counts the number
+ *   of packets that have NOT been properly processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped).
+ */
+enum {
+	SEG6_MOBILE_CNT_UNSPEC,
+	SEG6_MOBILE_CNT_PACKETS,
+	SEG6_MOBILE_CNT_BYTES,
+	SEG6_MOBILE_CNT_ERRORS,
+	SEG6_MOBILE_CNT_PAD,		/* pad for 64 bits values */
+	__SEG6_MOBILE_CNT_MAX,
+};
+
+#define SEG6_MOBILE_CNT_MAX	(__SEG6_MOBILE_CNT_MAX - 1)
+
+#endif /* _LINUX_SEG6_MOBILE_H */

-- 
2.50.1



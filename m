Return-Path: <netdev+bounces-283632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFrKB8N392mEiAIAu9opvQ
	(envelope-from <netdev+bounces-283632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A234B6780
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2FF302D520
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F73CBE7A;
	Sun,  3 May 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGro33cU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69423CBE66
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825590; cv=none; b=mfVS9sHKQRCKUoh86uhJY9EwCWJxnEX01dlgQZrP1zBYi07LKXICNxvNhj6Nxmq4MIEiFJpsV+OGQQePMDyGmapuqQEdpU1HpZZqNZNxK1InLXHkLKGKNF9f2wfagAY+HPm284x4wveEf7hD9h76+3Zc1NjO1YsLur+QC1U8gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825590; c=relaxed/simple;
	bh=lAmhvud8DJT1TnGXr3FPni6vH/gxo1WayILgZEjRzl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9tHZHHKD/cx5yK/PiB8aHGrUYD1rgxHDSRHJ0ertPrecIq+oCYmJu+Ubn7wkmf28vU4cp7iDKe5HsibYqglncXoH5IuzrOlCVHHEGY4/0T/J1Lo7SwoUlX/pf+jfIZjTrLgJLmAMuVw6qVE+Ot+WvcemPoZjQkM2Kw2gM2XPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGro33cU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b458ca2296so19160125ad.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825585; x=1778430385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OGyNf/G/NUfxGyxAPHvO+QDV0lYjw4rC39Twclqgs4=;
        b=eGro33cUTtVwfWaeuICGQvtbyzTiRgwRxAfu5LIQClwB+rylpmY3I6/LHC1kaYetVo
         EOBlMTUgqqFTFsCjixQ+fZtiopZS4VciakMKMZ60kcr33v8oEzo6vLwRQFrISRVFqSp3
         kRkT9uQ4N+hfauMGPMftkUBorJn49jZRrnanmeyApr/t90pVBLh6A86uqWBn95iWoZjK
         GrydlyCbY5cSKw7K+kzL1yeIzw9WEdWy0ppoZ96tblyD9885nRMQCNdLi2BRJgUjGkHZ
         jGmt5bNKr78TlRXtGI2Mu3sB5/GPREvpUv0zQB7HcYl24U8O4qUfRYyI5FsAaRRPpujY
         tmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825585; x=1778430385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OGyNf/G/NUfxGyxAPHvO+QDV0lYjw4rC39Twclqgs4=;
        b=ozIGzV0GHBiJ4l+0wj3lpay9Pw7wt/j6jkf3TOo1Rw0516mO8KIJNR0r+RCy2+yKXR
         H9dbYqu+29Pl46iylIgcpn+GbM0W2InY41E3bezF1+Z6prNOjTifF0uPnUVsLD97CiGx
         RPSMdaxhX9JsxHwvrrbP5rywhDgQQk/a8oW0U7+frK7JeQFzYwOaEDRZIbHkEf8HaQQw
         db6UR4WjKhdtF262t/ih0eU1678u6u+YIZtG7LwMayW0O7WfJWWXFjmkLT9Vy1S0fMMV
         1CLAkAgQcmGkPjKk6i6d7naVDVPa9pNyrNfRfh+WWNVbp+SUMyEwVG5N8kZMtz35fE0J
         fiLw==
X-Forwarded-Encrypted: i=1; AFNElJ+HV85Ba37aTZhx3+YJZjx1g5u1SDTSBYpon1cWTQCDNE+WKQc1zko4dTiWsJnbC0LPQafosSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SDQc5bCIRiBbcrzZhpqFE95kJ1Cb3zi2A6Ub6Cz1Xaq6DCTR
	VMZ5Lvlpm4BzAtHmS8soYyeFDVfkyYGDBBbcCwuGYAswsA8vP5pZisNN
X-Gm-Gg: AeBDiesSSXpOc3IrE9Qpxpng5b5636OlBrPACqIvpbmcdGHT5Qi0jPTXle4yMY9PHNU
	5MAVKxS+tUB1yE0l3LH3aTmDhH/y11fEx3x78pIK7Z/dgjT29K+p/R0G2Ylbzhpv4tEJBtYZxtq
	eo++1KRE/iQgLyt/GTEWFXDV4ao+Y4xAdRERB8jWarebHqBspvxsxG8ZiAk4i7Y210T7rmWbkMg
	9BqrSFtXRhtVbB0AGMp09tCtU8KzPF1kgYVfoaJyXxbOd4twxGCncLXpGHL5AJtNZgyeac4C8R3
	WtD/jTmxRbNLOW+4bAkCAOg/QnXRZWIjBmVMiVheZ6keYi81b+hHQUZR0aFUlc57V9UYRzWDJcD
	UptLWIjAR2/QBftv/TRGR6X4x0JbvFXDh5xzyAO7hlVtavCo4CW/1JDma1jaWxuXx9v4b20hyXP
	BpsaxfvNsWzB/HVKSIDC7O+MCQQzhwZV0KrnvLJ7mkdb+E
X-Received: by 2002:a05:6a20:e210:b0:39f:df57:ee7b with SMTP id adf61e73a8af0-3a7f1a9f5c8mr6930786637.21.1777825584718;
        Sun, 03 May 2026 09:26:24 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:23 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 04 May 2026 01:25:57 +0900
Subject: [PATCH 4/7] seg6: add End.M.GTP6.D behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-srv6-mup-v1-v1-4-e0a6791575cb@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=41279;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=lAmhvud8DJT1TnGXr3FPni6vH/gxo1WayILgZEjRzl8=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93ci3NHeHwjMwqjM2Fc6dek9CbwIDqAB986iA
 1nrQS/29C+JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IgAKCRAq19F1Kl0b
 TUuvD/9PH+7Mj9DZXmXzyHkkfi5gdKaBZszFYHuSFcBC1NNG/Pyv8EtQKjjJT6rEBbuKS/EW8Ng
 s74OVaMw4Zz9YuB+mqo0yiD3kFbvwrphVy56+RlH6lKT+VM/5Su1z6Hle8wnlEffQQHPN7NsjOL
 y2ZMonh9/yjO9FN3Lbm3VBjSKD2ceW9+CwPCA3cUlNIBctClrZM7WyXZ/rJ5uqpmN64Fubwugla
 XN7tIPutNaRB/AjKgBVajW18wSWAoERUTSggJNnARh/xTCiX4Y9o5SEfqDdcCNhbl0PNMiHfzmO
 tgv68AZbklDBX1nnMyjMCrCjgwD9r3m6gYIku24WMe4KcZa4z1hb0ssQJapUVxt81Pczk0SPZhU
 XaKpaHE3UZoau+5vPFKZf2UKPwB2nbybYSgrFQxfQe6PoiTjm9DsJv4SaLX6lxOewSBYx9LxAYA
 +/86XhuYQ+TQRurQdek8b6ga32iAduNraaRj7WzdiqRIZmLMwqNZTIacosNMr9ShD0wc3TyR7Y/
 dLZ/rAa8VJwV+BA62lAu7dH7iODCLqvrWk7xaSr/u+i/vfNi/KM2BwIy2G0j/dlXbdtfn2Ha1Re
 eMsl4QUgIHj9rQhSxDPozeZZZrQjIj5RpwYGUEFr5OCXcdRpuSQ63feWPztyu6jI8IUxcqWxssn
 BQq/DU3bNPheQXw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 38A234B6780
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
	TAGGED_FROM(0.00)[bounces-283632-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url,srv6_end_m_gtp6_d_test.sh:url,dst.dev:url]

Add the End.M.GTP6.D headend behavior (RFC 9433 Section 6.3), which
receives an IPv6/UDP/GTP-U packet matching a locally instantiated
End.M.GTP6.D SID and re-encapsulates the inner T-PDU in SRv6 using
the configured SR Policy.  TEID and QFI are folded into the 40-bit
Args.Mob.Session field defined by RFC 9433 Section 6.1.

RFC 9433 Section 6.3 Step S08 specifies "Write in the SRH[0] the
Args.Mob.Session" for a single-SID SR Policy.  When the SR Policy
contains more segments, the augmented SRH must reserve a leading
slot for the original outer destination D so that the downstream
End.M.GTP6.E (which Section 6.5 requires to sit at the penultimate
SID and Step S01 instructs to "Copy SRH[0] and D to buffer memory")
can rebuild the GTP-U tunnel.  Args.Mob.Session is therefore stamped
into segments[1] (the End.M.GTP6.E SID's locator-relative tail).

The augmented SRH (slwt->srh + one extra leading slot) is built
once at build_state time and reused on every packet.

The new SEG6_LOCAL_MOBILE_SR_PREFIX_LEN attribute carries the
locator length used by the remote End.M.GTP6.E SID; it is required
because the SR Gateway has no way to discover the remote SID's
prefix length from the FIB on its own.

When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
NF_INET_PRE_ROUTING between the GTP-U strip and the SRv6 push,
mirroring End.DX4 / End.DX6.

Inbound GTP-U packets are classified by message type (3GPP TS
29.281 Section 5.1).  Only T-PDU (type 255) is encapsulated into
SRv6.  Any other GTP-U message (Echo Request/Response, Error
Indication, ...) is forwarded unchanged via the lwtunnel's saved
orig_input so that a downstream peer that owns the GTP-U control
plane can process it.

Configuration:

  ip -6 route add 2001:db8:f::/64 \
      encap seg6local action End.M.GTP6.D \
          srh segs 2001:db8:2::e \
          src 2001:db8:2::1 \
          sr_prefix_len 64 \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.3
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h                    |   3 +
 net/ipv6/seg6_local.c                              | 512 +++++++++++++++++++++
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/srv6_end_m_gtp6_d_test.sh        | 496 ++++++++++++++++++++
 4 files changed, 1012 insertions(+)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 8e46ede2980d..7d3d3d245b47 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -33,6 +33,7 @@ enum {
 	SEG6_LOCAL_MOBILE_V4_MASK_LEN,
 	SEG6_LOCAL_MOBILE_PDU_TYPE,
 	SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
+	SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -77,6 +78,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
 	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
+	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2ebcbd7b99a4..6ac4de529c08 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -13,6 +13,7 @@
 #include <linux/net.h>
 #include <linux/module.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/lwtunnel.h>
 #include <net/netevent.h>
 #include <net/netns/generic.h>
@@ -194,7 +195,9 @@ struct seg6_mobile_info {
 	u8			v4_mask_len;		/* IPv4 portion length (bits) */
 	u8			pdu_type;		/* PDU Type (0=downlink, 1=uplink) */
 	bool			pdu_type_set;		/* PDU Session Container enabled */
+	u8			sr_prefix_len;		/* egress SR prefix length (bits) */
 	u8			v6_src_prefix_len;	/* Source UPF Prefix length (bits) */
+	struct ipv6_sr_hdr	*aug_srh;		/* augmented SRH for End.M.GTP6.D{,.Di} */
 };
 
 #define SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT	64
@@ -1637,6 +1640,53 @@ static bool seg6_mobile_extract_args_mob(const struct in6_addr *daddr,
 	return true;
 }
 
+/* Write @nbits of @val (top bits) into a 16-byte big-endian @addr at
+ * bit offset @bit_off, preserving surrounding bits.  Caller ensures
+ * bit_off + nbits <= 128 and 1 <= nbits <= 64.
+ */
+static void seg6_mobile_addr_set_bits(u8 *addr, unsigned int bit_off,
+				      unsigned int nbits, u64 val)
+{
+	u64 hi = get_unaligned_be64(addr);
+	u64 lo = get_unaligned_be64(addr + 8);
+	u64 mask_hi, mask_lo;
+
+	val &= GENMASK_ULL(63, 64 - nbits);
+
+	if (bit_off >= 64) {
+		mask_lo = GENMASK_ULL(63, 64 - nbits) >> (bit_off - 64);
+		lo = (lo & ~mask_lo) | (val >> (bit_off - 64));
+	} else if (bit_off + nbits <= 64) {
+		mask_hi = GENMASK_ULL(63, 64 - nbits) >> bit_off;
+		hi = (hi & ~mask_hi) | (val >> bit_off);
+	} else {
+		unsigned int hi_bits = 64 - bit_off;
+
+		mask_hi = GENMASK_ULL(hi_bits - 1, 0);
+		mask_lo = GENMASK_ULL(63, 64 - (nbits - hi_bits));
+		hi = (hi & ~mask_hi) | (val >> bit_off);
+		lo = (lo & ~mask_lo) | ((val << hi_bits) & mask_lo);
+	}
+
+	put_unaligned_be64(hi, addr);
+	put_unaligned_be64(lo, addr + 8);
+}
+
+/* @prefix_bits is bounded to [1, 88] by parse_nla_mobile_sr_prefix_len()
+ * before this function is reached, so the guard below is unreachable
+ * today.  Defense-in-depth against a future regression.
+ */
+static int seg6_mobile_write_args_mob(struct in6_addr *addr,
+				      unsigned int prefix_bits, u64 args_mob)
+{
+	if (prefix_bits + SEG6_MOBILE_ARGS_MOB_LEN > 128)
+		return -EINVAL;
+
+	seg6_mobile_addr_set_bits(addr->s6_addr, prefix_bits,
+				  SEG6_MOBILE_ARGS_MOB_LEN, args_mob);
+	return 0;
+}
+
 /* GTP-U PDU Session extension header (3GPP TS 38.415).
  * 4-byte minimum unit: ext_len=1, PDU Type in high 4 bits of @pdu_type_spare,
  * QFI in low 6 bits of @spare_qfi, next_ext=0.
@@ -1664,6 +1714,16 @@ struct seg6_mobile_pdu_session_ext {
 #define SEG6_MOBILE_ARGS_QFI_SHIFT	58
 #define SEG6_MOBILE_ARGS_TEID_SHIFT	24
 
+/* Combine TEID and QFI into a left-justified Args.Mob.Session value
+ * (RFC 9433 Section 6.1 Figure 8); R/U are emitted as zero.
+ */
+static u64 seg6_mobile_args_from_teid_qfi(u32 teid, u8 qfi)
+{
+	return ((u64)(qfi & SEG6_MOBILE_PDU_SESSION_QFI_MASK) <<
+		 SEG6_MOBILE_ARGS_QFI_SHIFT) |
+	       ((u64)teid << SEG6_MOBILE_ARGS_TEID_SHIFT);
+}
+
 static u8 seg6_mobile_qfi_from_args(u64 args_mob)
 {
 	return (args_mob >> SEG6_MOBILE_ARGS_QFI_SHIFT) &
@@ -1722,6 +1782,121 @@ static int seg6_mobile_push_gtpu(struct sk_buff *skb, u32 teid, u8 qfi,
 	return 0;
 }
 
+/* Parse the GTP-U header at @skb offset @gtp_off.  Pulls each
+ * additional region (long header, extension chain) into the linear
+ * area as it walks; on success returns the total header length to
+ * consume (mandatory + optional + extension headers), or a negative
+ * errno on failure.
+ *
+ * Returns -EOPNOTSUPP if the packet is a well-formed GTPv1-U header
+ * that this code path does not consume itself (any non-T-PDU message
+ * such as Echo Request / Error Indication).  Callers pass such packets
+ * through to the configured forwarding path via
+ * seg6_mobile_passthrough_non_tpdu().
+ *
+ * Returns -EINVAL when the GTP-U header is structurally malformed
+ * (truncated extension chain, ext_units == 0, etc.).  Callers should
+ * drop those.
+ *
+ * On success, *@teid is set to the GTP-U TEID and *@qfi is set to the
+ * QFI found in a PDU Session extension header, or 0 if none is present.
+ *
+ * Callers must re-derive any pointers into @skb->data after this
+ * function returns: pskb_may_pull() may have reallocated skb->head.
+ */
+static int seg6_mobile_parse_gtpu(struct sk_buff *skb, unsigned int gtp_off,
+				  u32 *teid, u8 *qfi)
+{
+	const struct gtp1_header *gtph;
+	const struct gtp1_header_long *gtphl;
+	const u8 *gtp;
+	unsigned int hdrlen;
+	u8 flags, next;
+
+	if (!pskb_may_pull(skb, gtp_off + sizeof(*gtph)))
+		return -EINVAL;
+	gtp = skb->data + gtp_off;
+	gtph = (const struct gtp1_header *)gtp;
+	flags = gtph->flags;
+
+	/* Accept only GTPv1-U T-PDU (3GPP TS 29.281 Section 5.1).  Other
+	 * GTPv1-U message types (Echo Request/Response, Error Indication,
+	 * ...) are dispatched separately by the caller.
+	 */
+	if ((flags & ~GTP1_F_MASK) != SEG6_MOBILE_GTP1U_FLAGS_BASE)
+		return -EOPNOTSUPP;
+	if (gtph->type != GTP_TPDU)
+		return -EOPNOTSUPP;
+
+	*teid = ntohl(gtph->tid);
+	*qfi = 0;
+
+	if (!(flags & (GTP1_F_EXTHDR | GTP1_F_SEQ | GTP1_F_NPDU)))
+		return sizeof(*gtph);
+
+	if (!pskb_may_pull(skb, gtp_off + sizeof(*gtphl)))
+		return -EINVAL;
+	gtp = skb->data + gtp_off;
+	gtphl = (const struct gtp1_header_long *)gtp;
+	hdrlen = sizeof(*gtphl);
+
+	if (!(flags & GTP1_F_EXTHDR))
+		return hdrlen;
+
+	next = gtphl->next;
+	while (next != 0) {
+		unsigned int ext_units, ext_bytes;
+		const u8 *ext;
+
+		if (!pskb_may_pull(skb, gtp_off + hdrlen + 1))
+			return -EINVAL;
+		ext = skb->data + gtp_off + hdrlen;
+		ext_units = ext[0];
+		if (ext_units == 0)
+			return -EINVAL;
+
+		ext_bytes = ext_units * 4;
+		if (!pskb_may_pull(skb, gtp_off + hdrlen + ext_bytes))
+			return -EINVAL;
+		ext = skb->data + gtp_off + hdrlen;
+
+		if (next == SEG6_MOBILE_PDU_SESSION_NH) {
+			/* 3GPP TS 38.415: the PDU Session extension header
+			 * is exactly 4 bytes long.
+			 */
+			if (ext_bytes != 4)
+				return -EINVAL;
+			*qfi = ext[2] & SEG6_MOBILE_PDU_SESSION_QFI_MASK;
+		}
+
+		next = ext[ext_bytes - 1];
+		hdrlen += ext_bytes;
+	}
+
+	return hdrlen;
+}
+
+/* Pass a non-T-PDU GTP-U message (Echo, Error Indication, ...) through
+ * the configured forwarding path so that a downstream UPF (which owns
+ * the GTP-U control plane) can process it.  The packet is delivered via
+ * the lwtunnel's saved orig_input -- ip6_forward for an IPv6 SID route
+ * or ip_forward for an IPv4 route -- which forwards using the existing
+ * skb_dst, reaching the UPF that lives in the L3 network behind the
+ * SRGW.
+ *
+ * @skb is consumed.
+ */
+static int seg6_mobile_passthrough_non_tpdu(struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+
+	if (dst && dst->lwtstate && dst->lwtstate->orig_input)
+		return dst->lwtstate->orig_input(skb);
+
+	kfree_skb_reason(skb, SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU);
+	return -EINVAL;
+}
+
 /* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
  * the inner T-PDU exposed by End.M.GTP4.E.  After the outer SRv6 has
  * been popped the inner IP is briefly visible to netfilter; the
@@ -2119,6 +2294,289 @@ static int input_action_end_m_gtp6_e_finish(struct net *net,
 	return -EINVAL;
 }
 
+/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
+ * the inner T-PDU exposed by End.M.GTP6.D / End.M.GTP6.D.Di.  The
+ * outer IPv6/UDP/GTP-U is gone by the time the finish callback runs,
+ * but the SRH built in finish still needs the original outer DA and
+ * the Args.Mob.Session derived from TEID/QFI.
+ */
+struct seg6_mobile_gtp6_d_cb {
+	u64		args_mob;
+	struct in6_addr	orig_dst;
+};
+
+#define SEG6_MOBILE_GTP6_D_CB(skb)	\
+	((struct seg6_mobile_gtp6_d_cb *)((skb)->cb))
+
+static int input_action_end_m_gtp6_d_finish(struct net *net,
+					    struct sock *sk,
+					    struct sk_buff *skb)
+{
+	struct seg6_mobile_gtp6_d_cb cb = *SEG6_MOBILE_GTP6_D_CB(skb);
+	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason;
+	const struct seg6_mobile_info *minfo;
+	struct seg6_local_lwt *slwt;
+	struct ipv6_sr_hdr *new_srh;
+	int inner_proto;
+	int err;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	minfo = &slwt->mobile_info;
+
+	inner_proto = (skb->protocol == htons(ETH_P_IP)) ? IPPROTO_IPIP
+							 : IPPROTO_IPV6;
+
+	err = seg6_do_srh_encap(skb, minfo->aug_srh, inner_proto);
+	if (err) {
+		reason = (err == -ENOMEM) ? SKB_DROP_REASON_SEG6_MOBILE_NOMEM
+					  : SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb->protocol = htons(ETH_P_IPV6);
+
+	new_srh = (struct ipv6_sr_hdr *)(skb_network_header(skb) +
+					 sizeof(struct ipv6hdr));
+	new_srh->segments[0] = cb.orig_dst;
+	if (seg6_mobile_write_args_mob(&new_srh->segments[1],
+				       minfo->sr_prefix_len, cb.args_mob)) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
+		goto drop;
+	}
+
+	ipv6_hdr(skb)->saddr = minfo->src_addr;
+
+	/* seg6_do_srh_encap() copied segments[first_segment] to the outer
+	 * DA before Args.Mob.Session was stamped; refresh it.
+	 */
+	ipv6_hdr(skb)->daddr = new_srh->segments[new_srh->first_segment];
+
+	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
+	skb_dst_drop(skb);
+
+	seg6_lookup_any_nexthop(skb, NULL, 0, false, slwt->oif);
+	return dst_input(skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+/* RFC 9433 Section 6.3 -- End.M.GTP6.D
+ * Receives an IPv6/UDP/GTP-U packet matching a locally instantiated
+ * End.M.GTP6.D SID and re-encapsulates the inner T-PDU in SRv6 using
+ * the configured SR Policy.  TEID and QFI are folded into
+ * Args.Mob.Session.  Per RFC 9433 Section 6.5 ("End.M.GTP6.E SID MUST
+ * always be the penultimate SID"), Args.Mob.Session is encoded into
+ * segments[1] of the new SRH (the penultimate SID at the egress UPF)
+ * while segments[0] holds the original outer DA so that the egress
+ * has a real GTP-U destination after End.M.GTP6.E decap.
+ *
+ * When net.netfilter.nf_hooks_lwtunnel=1 the inner T-PDU is exposed
+ * to NF_INET_PRE_ROUTING after the GTP-U strip and before the SRv6
+ * push, mirroring End.DX4 / End.DX6.  This lets nftables / conntrack
+ * apply policy on the inner 5-tuple at the SR Gateway.
+ */
+static int input_action_end_m_gtp6_d(struct sk_buff *skb,
+				     struct seg6_local_lwt *slwt)
+{
+	unsigned int outer_len, inner_off;
+	int gtp_hdrlen, inner_proto, inner_nfproto;
+	struct in6_addr orig_dst;
+	u8 inner_first, qfi;
+	struct ipv6_sr_hdr *srh;
+	struct ipv6hdr *ip6h;
+	struct udphdr *uh;
+	u64 args_mob;
+	u32 teid;
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+
+	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp6_d_cb) >
+		     sizeof_field(struct sk_buff, cb));
+
+	/* RFC 9433 Section 6.3 SRH-S01: drop if outer SRH carries
+	 * SegmentsLeft != 0
+	 */
+	srh = seg6_get_srh(skb, 0);
+	if (srh && srh->segments_left != 0) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	ip6h = ipv6_hdr(skb);
+	orig_dst = ip6h->daddr;
+
+	/* RFC 9433 Section 6.3 upper-layer S01-S11: dispatch on
+	 * (NH == UDP && UDP dport == GTP-U); otherwise delegate to the
+	 * regular End behaviour (S10-S11).
+	 */
+	{
+		__be16 frag_off;
+		u8 nh = ip6h->nexthdr;
+		int upper_off;
+
+		upper_off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh,
+					     &frag_off);
+		if (upper_off < 0) {
+			/* Outer IPv6 ext-header walk failed; the GTP-U
+			 * envelope below it is unreachable.
+			 */
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+
+		if (nh != IPPROTO_UDP)
+			return input_action_end(skb, slwt);
+
+		if (!pskb_may_pull(skb, upper_off + sizeof(*uh))) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+
+		ip6h = ipv6_hdr(skb);
+		uh = (struct udphdr *)((u8 *)ip6h + upper_off);
+		if (uh->dest != htons(GTP1U_PORT))
+			return input_action_end(skb, slwt);
+
+		gtp_hdrlen = seg6_mobile_parse_gtpu(skb,
+						    upper_off + sizeof(*uh),
+						    &teid, &qfi);
+		if (gtp_hdrlen == -EOPNOTSUPP)
+			return seg6_mobile_passthrough_non_tpdu(skb);
+		if (gtp_hdrlen < 0) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+
+		outer_len = upper_off + sizeof(*uh) + gtp_hdrlen;
+	}
+
+	args_mob = seg6_mobile_args_from_teid_qfi(teid, qfi);
+
+	if (!pskb_may_pull(skb, outer_len + 1)) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	inner_off = outer_len;
+	inner_first = *((u8 *)skb->data + inner_off);
+	switch (inner_first >> 4) {
+	case 4:
+		inner_proto = IPPROTO_IPIP;
+		inner_nfproto = NFPROTO_IPV4;
+		break;
+	case 6:
+		inner_proto = IPPROTO_IPV6;
+		inner_nfproto = NFPROTO_IPV6;
+		break;
+	default:
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	if (!pskb_may_pull(skb, outer_len +
+			   ((inner_proto == IPPROTO_IPIP) ?
+			    sizeof(struct iphdr) : sizeof(struct ipv6hdr)))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb_pull_rcsum(skb, outer_len);
+	skb_reset_network_header(skb);
+
+	/* Set skb->protocol to match the inner header so that the
+	 * NF_INET_PRE_ROUTING hook (and seg6_do_srh_encap() inside
+	 * the finish half) see a coherent IPv4/IPv6 packet.
+	 */
+	skb->protocol = (inner_proto == IPPROTO_IPIP) ? htons(ETH_P_IP)
+						      : htons(ETH_P_IPV6);
+
+	skb_set_transport_header(skb,
+				 (inner_proto == IPPROTO_IPIP) ?
+				 sizeof(struct iphdr) :
+				 sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
+
+	SEG6_MOBILE_GTP6_D_CB(skb)->args_mob = args_mob;
+	SEG6_MOBILE_GTP6_D_CB(skb)->orig_dst = orig_dst;
+
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_m_gtp6_d_finish);
+
+	return input_action_end_m_gtp6_d_finish(dev_net(skb->dev), NULL, skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+/* Shared between End.M.GTP6.D and End.M.GTP6.D.Di -- both
+ * prepend a single leading slot to the user-configured SRH to leave
+ * room for the original outer DA at SRH[0].  End.M.GTP6.D writes
+ * Args.Mob.Session into segments[1] at runtime; End.M.GTP6.D.Di
+ * leaves segments[1+] as the user provided them.
+ */
+static int seg6_end_m_gtp6_d_aug_build(struct seg6_local_lwt *slwt,
+				       const void *cfg,
+				       struct netlink_ext_ack *extack)
+{
+	struct ipv6_sr_hdr *aug;
+	int orig_len, aug_len;
+
+	if (!slwt->srh) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "End.M.GTP6.D{,.Di} requires srh segs");
+		return -EINVAL;
+	}
+
+	/* The augmented SRH adds one extra leading slot, so its hdrlen
+	 * field (u8) must still fit the +2-segment-equivalent encoding.
+	 * Reject pathological srh inputs at setup time so that no
+	 * silent overflow can produce an undersized aug->hdrlen and a
+	 * subsequent OOB read in seg6_do_srh_encap().
+	 */
+	if (slwt->srh->hdrlen > 253) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "End.M.GTP6.D{,.Di} srh too large to augment (max 126 segments)");
+		return -EINVAL;
+	}
+
+	orig_len = (slwt->srh->hdrlen + 1) << 3;
+	aug_len = orig_len + sizeof(struct in6_addr);
+
+	aug = kzalloc(aug_len, GFP_KERNEL);
+	if (!aug)
+		return -ENOMEM;
+
+	memcpy(aug, slwt->srh, sizeof(*aug));
+	aug->hdrlen = (aug_len >> 3) - 1;
+	aug->segments_left = slwt->srh->segments_left + 1;
+	aug->first_segment = slwt->srh->first_segment + 1;
+	/* segments[0] left zero; data path stamps the original outer
+	 * DA into the in-skb copy after seg6_do_srh_encap().
+	 */
+	memcpy(&aug->segments[1], &slwt->srh->segments[0],
+	       orig_len - sizeof(*aug));
+
+	slwt->mobile_info.aug_srh = aug;
+	return 0;
+}
+
+static void seg6_end_m_gtp6_d_aug_destroy(struct seg6_local_lwt *slwt)
+{
+	kfree(slwt->mobile_info.aug_srh);
+	slwt->mobile_info.aug_srh = NULL;
+}
+
 /* RFC 9433 Section 6.5 -- End.M.GTP6.E
  * Receives an SRv6 packet whose current SID is an End.M.GTP6.E SID
  * (Segments Left == 1) and re-encapsulates the inner payload in
@@ -2449,6 +2907,19 @@ static struct seg6_action_desc seg6_action_table[] = {
 			.build_state = seg6_mobile_gtp6_e_validate,
 		},
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_M_GTP6_D,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_SRH)		     |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR)    |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SR_PREFIX_LEN),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
+		.input		= input_action_end_m_gtp6_d,
+		.slwt_ops	= {
+			.build_state = seg6_end_m_gtp6_d_aug_build,
+			.destroy_state = seg6_end_m_gtp6_d_aug_destroy,
+		},
+	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_MAP,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
@@ -2549,6 +3020,7 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_LOCAL_MOBILE_V4_MASK_LEN] = { .type = NLA_U8 },
 	[SEG6_LOCAL_MOBILE_PDU_TYPE] = { .type = NLA_U8 },
+	[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN] = { .type = NLA_U8 },
 	[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN] = { .type = NLA_U8 },
 };
 
@@ -2964,6 +3436,39 @@ static int seg6_mobile_gtp6_e_validate(struct seg6_local_lwt *slwt,
 	return 0;
 }
 
+static int parse_nla_mobile_sr_prefix_len(struct nlattr **attrs,
+					  struct seg6_local_lwt *slwt,
+					  struct netlink_ext_ack *extack)
+{
+	u8 len = nla_get_u8(attrs[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN]);
+
+	/* The SR locator must be non-zero and leave room for the 40-bit
+	 * Args.Mob.Session that follows it (RFC 9433 Section 6.5/6.7).
+	 */
+	if (len == 0 || len + SEG6_MOBILE_ARGS_MOB_LEN > 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile SR prefix length must be in 1..88 (leaving room for the 40-bit Args.Mob.Session)");
+		return -EINVAL;
+	}
+	slwt->mobile_info.sr_prefix_len = len;
+	return 0;
+}
+
+static int put_nla_mobile_sr_prefix_len(struct sk_buff *skb,
+					struct seg6_local_lwt *slwt)
+{
+	if (nla_put_u8(skb, SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
+		       slwt->mobile_info.sr_prefix_len))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int cmp_nla_mobile_sr_prefix_len(struct seg6_local_lwt *a,
+					struct seg6_local_lwt *b)
+{
+	return a->mobile_info.sr_prefix_len != b->mobile_info.sr_prefix_len;
+}
+
 #define MAX_PROG_NAME 256
 static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
 	[SEG6_LOCAL_BPF_PROG]	   = { .type = NLA_U32, },
@@ -3406,6 +3911,10 @@ static struct seg6_action_param seg6_action_params[SEG6_LOCAL_MAX + 1] = {
 					 .put = put_nla_mobile_pdu_type,
 					 .cmp = cmp_nla_mobile_pdu_type },
 
+	[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN] = { .parse = parse_nla_mobile_sr_prefix_len,
+					      .put = put_nla_mobile_sr_prefix_len,
+					      .cmp = cmp_nla_mobile_sr_prefix_len },
+
 	[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN] = { .parse = parse_nla_mobile_v6_src_prefix_len,
 						  .put = put_nla_mobile_v6_src_prefix_len,
 						  .cmp = cmp_nla_mobile_v6_src_prefix_len },
@@ -3734,6 +4243,9 @@ static int seg6_local_get_encap_size(struct lwtunnel_state *lwt)
 	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_PDU_TYPE))
 		nlsize += nla_total_size(1);
 
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SR_PREFIX_LEN))
+		nlsize += nla_total_size(1);
+
 	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN))
 		nlsize += nla_total_size(1);
 
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 2eeff97cac21..70cec00aebdb 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_PROGS := \
 	sctp_vrf.sh \
 	skf_net_off.sh \
 	so_txtime.sh \
+	srv6_end_m_gtp6_d_test.sh \
 	srv6_end_m_gtp6_e_test.sh \
 	srv6_end_m_gtp4_e_test.sh \
 	srv6_end_map_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_m_gtp6_d_test.sh b/tools/testing/selftests/net/srv6_end_m_gtp6_d_test.sh
new file mode 100755
index 000000000000..1b39e6093c9c
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_m_gtp6_d_test.sh
@@ -0,0 +1,496 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for the SRv6 End.M.GTP6.D behavior (RFC 9433 Section 6.3).
+#
+#   +-------+   2001:db8:1::/64   +-------+   2001:db8:2::/64   +-------+
+#   |  gnb  | ------------------- | srgw  | ------------------- | srupf |
+#   +-------+        veth-n3      +-------+        veth-n9      +-------+
+#                                     |
+#                                     |   2001:db8:6::/64
+#                                     +--------veth-n6--------- +-------+
+#                                                               | lupf  |
+#                                                               +-------+
+#
+# gnb is the GTP-U-side test peer that injects the GTP-U packets.
+# srupf is the SR-domain-side SRv6-aware UPF (RFC 9433 sense, not
+# a 3GPP UPF) that receives the resulting SRv6 T-PDU.  lupf is the
+# SRv6-non-aware legacy UPF that owns the GTP-U control plane and
+# receives non-T-PDU GTP-U (Echo Request, Error Indication, ...)
+# forwarded by srgw via the H.M.GTP6.D route's dev.  srgw runs the
+# End.M.GTP6.D behavior under test.
+#
+# An End.M.GTP6.D SID is installed on srgw for locator
+# 2001:db8:f::/48 with src=2001:db8:2::1.  Args.Mob.Session is the
+# fixed 40-bit field defined by RFC 9433 Section 6.1, Figure 8.  When gnb sends an
+# IPv6/UDP/GTP-U packet to 2001:db8:f::1 carrying TEID 0x123, the srgw
+# is expected to emit an SRv6 packet toward 2001:db8:3::e whose last
+# SRH segment carries Args.Mob.Session in its right-aligned 40-bit
+# tail (QFI=5, R=0, U=0, PDU Session ID=0x123 → bytes 14 00 00 01 23).
+
+source lib.sh
+
+readonly TIMEOUT=4
+
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
+	setup_ns gnb srgw srupf lupf srupf_vrf
+
+	ip -n "$gnb" link set lo up
+	ip -n "$srgw" link set lo up
+	ip -n "$srupf" link set lo up
+	ip -n "$lupf" link set lo up
+	ip -n "$srupf_vrf" link set lo up
+
+	# gnb <-> srgw
+	ip link add veth-n3 netns "$gnb" type veth peer name veth-n3-srgw \
+		netns "$srgw"
+	ip -n "$gnb" addr add 2001:db8:1::2/64 dev veth-n3 nodad
+	ip -n "$srgw" addr add 2001:db8:1::1/64 dev veth-n3-srgw nodad
+	ip -n "$gnb" link set veth-n3 up
+	ip -n "$srgw" link set veth-n3-srgw up
+
+	# srgw <-> srupf  (SR-aware UPF, T-PDU SRv6 destination)
+	ip link add veth-n9 netns "$srgw" type veth peer name veth-n9-srupf \
+		netns "$srupf"
+	ip -n "$srgw" addr add 2001:db8:2::1/64 dev veth-n9 nodad
+	ip -n "$srupf" addr add 2001:db8:2::e/64 dev veth-n9-srupf nodad
+	ip -n "$srgw" link set veth-n9 up
+	ip -n "$srupf" link set veth-n9-srupf up
+
+	# srgw <-> lupf  (legacy UPF, GTP-U control plane recipient)
+	ip link add veth-n6 netns "$srgw" type veth peer name veth-n6-lupf \
+		netns "$lupf"
+	ip -n "$srgw" addr add 2001:db8:6::1/64 dev veth-n6 nodad
+	ip -n "$lupf" addr add 2001:db8:6::e/64 dev veth-n6-lupf nodad
+	ip -n "$srgw" link set veth-n6 up
+	ip -n "$lupf" link set veth-n6-lupf up
+
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.forwarding=1
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.seg6_enabled=1
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.veth-n9.seg6_enabled=1
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.veth-n6.seg6_enabled=1
+	ip netns exec "$srupf" sysctl -wq net.ipv6.conf.all.seg6_enabled=1
+	ip netns exec "$srupf" sysctl -wq net.ipv6.conf.veth-n9-srupf.seg6_enabled=1
+
+	# route on gnb toward the End.M.GTP6.D SID
+	ip -n "$gnb" -6 route add 2001:db8:f::/64 via 2001:db8:1::1
+
+	# install End.M.GTP6.D on srgw.  sr_prefix_len declares the locator
+	# length used by the remote End.M.GTP6.E SID; with /64 the kernel
+	# writes Args.Mob.Session into bytes 8..12 of the penultimate SID.
+	# dev veth-n6 is the legacy UPF leg: T-PDU encap takes the IPv6 SR
+	# Policy path (independent of dst.dev) while non-T-PDU is forwarded
+	# out veth-n6 via ip6_forward.
+	ip -n "$srgw" -6 route add 2001:db8:f::/64 \
+		encap seg6local action End.M.GTP6.D \
+			srh segs 2001:db8:2::e,2001:db8:3::e \
+			src 2001:db8:2::1 sr_prefix_len 64 count \
+		dev veth-n6
+
+	# accept the SRv6 packet on srupf
+	ip -n "$srupf" -6 route add 2001:db8:2::e/128 dev lo
+	ip -n "$srupf" -6 route add 2001:db8:3::/64 dev veth-n9-srupf
+
+	# avoid ND-resolution timing flakiness with static neighbours
+	local srupf_mac srgw_n9_mac lupf_mac
+	srupf_mac=$(ip -n "$srupf" -j link show veth-n9-srupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	srgw_n9_mac=$(ip -n "$srgw" -j link show veth-n9 | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	lupf_mac=$(ip -n "$lupf" -j link show veth-n6-lupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	ip -n "$srgw" -6 neigh replace 2001:db8:2::e dev veth-n9 \
+		lladdr "$srupf_mac" nud permanent
+	ip -n "$srupf" -6 neigh replace 2001:db8:2::1 dev veth-n9-srupf \
+		lladdr "$srgw_n9_mac" nud permanent
+	# Non-T-PDU passthrough: srgw forwards GTP-U control out the
+	# H.M.GTP6.D route's dev (veth-n6); pre-resolve the lupf neighbour
+	# for the Echo Request DA.
+	ip -n "$srgw" -6 neigh replace 2001:db8:f::1 dev veth-n6 \
+		lladdr "$lupf_mac" nud permanent
+
+	# Per-route VRF case: a second SR-side upf in its own VRF.  The
+	# End.M.GTP6.D SID for this tenant binds the SRv6 underlay output to
+	# the VRF via 'oif'; without it the lookup would fall through to
+	# the main table.  Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	modprobe vrf 2>/dev/null
+	if ip -n "$srgw" link add vrf-n9 type vrf table 100 2>/dev/null; then
+		have_vrf=1
+		ip -n "$srgw" link set dev vrf-n9 up
+
+		ip link add veth-n9-2 netns "$srgw" type veth peer name \
+			veth-n9-2-srupf netns "$srupf_vrf"
+		ip -n "$srgw" link set dev veth-n9-2 master vrf-n9
+		ip -n "$srgw" addr add 2001:db8:4::1/64 dev veth-n9-2 nodad
+		ip -n "$srupf_vrf" addr add 2001:db8:4::e/64 dev veth-n9-2-srupf \
+			nodad
+		ip -n "$srgw" link set dev veth-n9-2 up
+		ip -n "$srupf_vrf" link set dev veth-n9-2-srupf up
+
+		ip netns exec "$srgw" sysctl -wq \
+			net.ipv6.conf.veth-n9-2.seg6_enabled=1
+		ip netns exec "$srupf_vrf" sysctl -wq \
+			net.ipv6.conf.all.seg6_enabled=1
+		ip netns exec "$srupf_vrf" sysctl -wq \
+			net.ipv6.conf.veth-n9-2-srupf.seg6_enabled=1
+
+		ip -n "$gnb" -6 route add 2001:db8:f0::/64 via 2001:db8:1::1
+
+		ip -n "$srgw" -6 route add 2001:db8:f0::/64 \
+			encap seg6local action End.M.GTP6.D \
+				srh segs 2001:db8:4::e,2001:db8:5::e \
+				src 2001:db8:4::1 sr_prefix_len 64 count \
+				oif vrf-n9 \
+			dev veth-n9-2
+
+		ip -n "$srupf_vrf" -6 route add 2001:db8:4::e/128 dev lo
+		ip -n "$srupf_vrf" -6 route add 2001:db8:5::/64 dev veth-n9-2-srupf
+
+		local upf_vrf_mac
+		local srgw_e2_mac
+		upf_vrf_mac=$(ip -n "$srupf_vrf" -j link show \
+			veth-n9-2-srupf | python3 -c \
+			'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+		srgw_e2_mac=$(ip -n "$srgw" -j link show veth-n9-2 | \
+			python3 -c \
+			'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+		ip -n "$srgw" -6 neigh replace 2001:db8:4::e dev veth-n9-2 \
+			lladdr "$upf_vrf_mac" nud permanent
+		ip -n "$srupf_vrf" -6 neigh replace 2001:db8:4::1 \
+			dev veth-n9-2-srupf lladdr "$srgw_e2_mac" nud permanent
+	fi
+}
+
+check_dependencies()
+{
+	if ! command -v tcpdump >/dev/null; then
+		echo "SKIP: tcpdump is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! command -v python3 >/dev/null; then
+		echo "SKIP: python3 is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.M.GTP6.D"; then
+		echo "SKIP: iproute2 too old, missing seg6local action End.M.GTP6.D"
+		exit "$ksft_skip"
+	fi
+
+	if ! python3 -c "import scapy.all" 2>/dev/null; then
+		echo "SKIP: python3-scapy is required"
+		exit "$ksft_skip"
+	fi
+}
+
+send_gtpu()
+{
+	local outer_dst="$1"	# IPv6 destination of the GTP-U packet
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" OUTER_DST="$outer_dst" \
+		ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IPv6, UDP, IP, ICMP, sendp, Ether
+
+mac = os.environ['SRGW_MAC']
+outer_dst = os.environ['OUTER_DST']
+# GTPv1 long header (E bit set, next ext = 0x85 PDU Session) carrying
+# TEID 0x00000123, followed by a PDU Session ext (PDU Type=DL, QFI=5).
+gtpu = bytes.fromhex(
+    "34 ff 00 24 00 00 01 23 00 00 00 85"  # long header
+    "01 00 05 00"                            # PDU Session ext
+)
+inner = bytes(IP(src="10.0.0.1", dst="10.0.0.2") / ICMP())
+pkt = (Ether(dst=mac) /
+       IPv6(src="2001:db8:1::2", dst=outer_dst) /
+       UDP(sport=2152, dport=2152) /
+       (gtpu + inner))
+sendp(pkt, iface="veth-n3", verbose=False)
+PY
+}
+
+# Send a GTPv1-U Echo Request; End.M.GTP6.D must NOT consume it but
+# pass it through to the configured forwarding path so the downstream
+# UPF (legacy GTP-U control plane) can answer.  Verified by capturing
+# the unaltered Echo Request (type 0x01) on the upf side.
+send_gtpu_echo()
+{
+	local outer_dst="$1"
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" OUTER_DST="$outer_dst" \
+		ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IPv6, UDP, sendp, Ether
+mac = os.environ['SRGW_MAC']
+outer_dst = os.environ['OUTER_DST']
+gtpu_echo = bytes.fromhex("32 01 00 04 00 00 00 00 42 42 00 00")
+pkt = (Ether(dst=mac) /
+       IPv6(src="2001:db8:1::2", dst=outer_dst) /
+       UDP(sport=2152, dport=2152) /
+       gtpu_echo)
+sendp(pkt, iface="veth-n3", verbose=False)
+PY
+}
+
+run_echo_test()
+{
+	local outer_dst="$1"
+	local out
+	local rc
+
+	out=$(mktemp)
+
+	ip netns exec "$lupf" tcpdump -U -nni veth-n6-lupf -w "$out" \
+		'udp port 2152' 2>/dev/null &
+	tcpdump_pid=$!
+	sleep 1
+
+	send_gtpu_echo "$outer_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+
+	OUTER_DST="$outer_dst" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, UDP
+
+want_dst = os.environ['OUTER_DST']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 not in p or UDP not in p:
+        continue
+    if p[UDP].sport != 2152 or p[UDP].dport != 2152:
+        continue
+    if p[IPv6].dst != want_dst:
+        continue
+    payload = bytes(p[UDP].payload)
+    if len(payload) >= 2 and payload[1] == 0x01:
+        sys.exit(0)
+sys.exit("no GTPv1-U Echo Request observed at lupf "
+         "(End.M.GTP6.D failed to pass non-T-PDU through)")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+capture_traffic()
+{
+	local capture_ns="$1"
+	local capture_iface="$2"
+	local outer_dst="$3"
+	local out="$4"
+
+	ip netns exec "$capture_ns" tcpdump -U -nni "$capture_iface" -w "$out" \
+		'ip6' 2>/dev/null &
+	tcpdump_pid=$!
+	# Give tcpdump a brief moment to attach the BPF filter.
+	sleep 1
+
+	send_gtpu "$outer_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+}
+
+run_test()
+{
+	local outer_dst="$1"			# GTP-U outer IPv6 DA
+	local expected_srh0="$2"		# expected SRH[0] in upf
+	local capture_ns="${3:-$srupf}"	# netns where SRv6 should land
+	local capture_iface="${4:-veth-n9-srupf}"
+	local out
+
+	out=$(mktemp)
+	capture_traffic "$capture_ns" "$capture_iface" "$outer_dst" "$out"
+
+	# Verify with scapy: an SRv6 packet (IPv6 + Routing Header type 4)
+	# must reach the upf.  Per RFC 9433 Section 6.5 Note, SRH[1]
+	# carries Args.Mob.Session and SRH[0] carries the original outer DA.
+	EXPECTED_SRH0="$expected_srh0" python3 - "$out" <<'PYEOF'
+import ipaddress, os, sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+expected_srh0 = os.environ['EXPECTED_SRH0']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and IPv6ExtHdrSegmentRouting in p):
+        continue
+    srh = p[IPv6ExtHdrSegmentRouting]
+    if srh.type != 4:
+        sys.exit(f"unexpected RH type {srh.type}")
+    if len(srh.addresses) < 2:
+        continue
+    srh0 = ipaddress.IPv6Address(str(srh.addresses[0])).packed
+    if srh0 != ipaddress.IPv6Address(expected_srh0).packed:
+        sys.exit(f"SRH[0] = {ipaddress.IPv6Address(srh0)} "
+                 f"(want {expected_srh0}, the preserved outer DA)")
+    srh1 = ipaddress.IPv6Address(str(srh.addresses[1])).packed
+    args = srh1[8:13]
+    if args != bytes.fromhex("1400000123"):
+        sys.exit(f"Args.Mob.Session = {args.hex()} (want 1400000123)")
+    sys.exit(0)
+sys.exit("no SRv6 (RT6 type=4) packet with 2+ segments observed at upf")
+PYEOF
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify that nf_hooks_lwtunnel=1 makes the inner T-PDU 5-tuple
+# visible to nftables on the SR Gateway.  The nft rule matches on the
+# inner IPv4 source address (10.0.0.1, set by send_gtpu()); a DROP
+# verdict must prevent any SRv6 packet from reaching the upf, an
+# ACCEPT verdict must let it through unchanged.
+run_nf_test()
+{
+	local verdict="$1"		# drop | accept
+	local expect_srh0="$2"	# preserved-DA test, empty when no packet expected
+	local outer_dst="2001:db8:f::1"
+	local out
+
+	# fresh prerouting chain so each invocation starts clean
+	ip netns exec "$srgw" nft flush chain ip filter prerouting
+	ip netns exec "$srgw" nft add rule ip filter prerouting \
+		ip saddr 10.0.0.1 "$verdict"
+
+	out=$(mktemp)
+	capture_traffic "$srupf" "veth-n9-srupf" "$outer_dst" "$out"
+
+	if [ -n "$expect_srh0" ]; then
+		EXPECTED_SRH0="$expect_srh0" python3 - "$out" <<'PYEOF'
+import ipaddress, os, sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+expected_srh0 = os.environ['EXPECTED_SRH0']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and IPv6ExtHdrSegmentRouting in p):
+        continue
+    srh = p[IPv6ExtHdrSegmentRouting]
+    if len(srh.addresses) < 2:
+        continue
+    srh0 = ipaddress.IPv6Address(str(srh.addresses[0])).packed
+    if srh0 == ipaddress.IPv6Address(expected_srh0).packed:
+        sys.exit(0)
+sys.exit("expected SRv6 packet not observed at upf despite nft accept")
+PYEOF
+	else
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p and IPv6ExtHdrSegmentRouting in p:
+        sys.exit("SRv6 packet leaked to upf despite nft drop on inner")
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
+	if run_test "2001:db8:f::1" "2001:db8:f::1"; then
+		echo "TEST: End.M.GTP6.D (default) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.D (default) [FAIL]"
+		rc=1
+	fi
+
+	if run_echo_test "2001:db8:f::1"; then
+		echo "TEST: End.M.GTP6.D (non-T-PDU passthrough) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.D (non-T-PDU passthrough) [FAIL]"
+		rc=1
+	fi
+
+	# VRF binding: SRv6 underlay output goes through vrf-n9 (table 100).
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	if [ "$have_vrf" = "1" ]; then
+		if run_test "2001:db8:f0::1" "2001:db8:f0::1" \
+			    "$srupf_vrf" "veth-n9-2-srupf"; then
+			echo "TEST: End.M.GTP6.D (oif vrf-n9) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D (oif vrf-n9) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.D (oif vrf-n9) [SKIP] (CONFIG_NET_VRF not loaded)"
+	fi
+
+	# Inner T-PDU netfilter hook: only meaningful when nft is present
+	# and the kernel exposes net.netfilter.nf_hooks_lwtunnel.  The
+	# sysctl is one-way (cannot be cleared), but each test runs in a
+	# fresh netns so this is harmless.
+	if command -v nft >/dev/null && \
+	   ip netns exec "$srgw" sysctl -wq \
+		net.netfilter.nf_hooks_lwtunnel=1 2>/dev/null; then
+		ip netns exec "$srgw" nft add table ip filter
+		ip netns exec "$srgw" nft \
+			'add chain ip filter prerouting { type filter hook prerouting priority 0; }'
+
+		if run_nf_test drop ""; then
+			echo "TEST: End.M.GTP6.D (nft drop on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D (nft drop on inner) [FAIL]"
+			rc=1
+		fi
+
+		if run_nf_test accept "2001:db8:f::1"; then
+			echo "TEST: End.M.GTP6.D (nft accept on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D (nft accept on inner) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.D (inner-flow netfilter hook) [SKIP]" \
+		     "(nft or nf_hooks_lwtunnel unavailable)"
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		echo "TEST: End.M.GTP6.D [PASS]"
+		exit "$ksft_pass"
+	else
+		echo "TEST: End.M.GTP6.D [FAIL]"
+		exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1



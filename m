Return-Path: <netdev+bounces-283629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDL4OFR392mEiAIAu9opvQ
	(envelope-from <netdev+bounces-283629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:27:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C74B6728
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101BA30177B7
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FE3CD8B1;
	Sun,  3 May 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZyKYozd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237F3CCFB0
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825578; cv=none; b=Fs9gqWzrCuvjE53zLqUFqojF7ONc99xbR+OIVR+pW1nLEK70Jn1Bazvck9NOZGovFPJRwHfC6ZkEifD1pGxVZZ4B6OHzc4NmylfblHSFfSBlXbVQUbcA9snX4bh0ZfdBymOu+SwWjF+N598h8rftA4oPUXZq+xWGSJ49SSatuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825578; c=relaxed/simple;
	bh=cWrWy4lRcfTLfcTh6rppTo5D8aFWc22hbKKodGoaMxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fU0qkOq4dgEzajnqTLJz4rSyFOtcwrxKZRKgp6ULGYmaJNbtEMnaTYvwHi5LvN0OQkd8kWQQH+3g2GP+6vNsPEOv5r86gfh9YnvM7JyDhbsDuom8C4M0kXBNNtRG/FARXJrtnRltMku5PFI3p82c1NUsMAtv/lTEBnWoKELAw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZyKYozd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296d553142so2263285b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825577; x=1778430377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM4j+MCP9ZqcA5zgSOfp0zMVIDX1AvLx4KI5C4lbhEg=;
        b=rZyKYozdy5JHDVQv+WKoYkrjjvpmX0HBMu6EAwc/P7UfRW1VpEPHt5lJXmCNmJnV10
         hS1UOWTxg2RjFJJaBOtbiUOZA4Xkta/m4WqjsnN8/cha2AzMd7ke+QlEEX4Sk9ftrDob
         pbmpcskD5uwzTCTATnJwAlyA+ssEVOLLR5Zp7o2Ltpw5bi8W1xc/bvbXbRe6CL+cqg90
         IbquO3yZ++SmS/7bVCRYw9GZO1bMYIrzMlxbrTl6f8V4jAVLy33V9TrhPHFBmD7ZG0Fb
         O7qObjG8ml6j8PjDBsF71MIiQxecxCNbvDcuxW8ncgTRTnHND8u8NvVpbHY+0B3hHFj+
         CX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825577; x=1778430377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LM4j+MCP9ZqcA5zgSOfp0zMVIDX1AvLx4KI5C4lbhEg=;
        b=efszl0oPGArCWWGmpvQHAdeAn/xSs6ewzggV7e2FHrG81zNmIdywm6FlHhlsJh3jwB
         Tyavz8LLrupoQnPu3U5HgFlqaw3ah77y9n7vIVwwd9Pr08QwawC1Yn4NnBqE43EK9qbK
         kTtatJwevt6rAa1K26ylrvw+SBHqXeacl2ro3nc2jdsyEWWcRcj2T0QzPvu8SHSq4T9T
         7AfF9Uu5rT2SevfAibmvATI0l13BNAmrwXcs6OW3l8EKGWHS7CIAcztBFnoNES5ajAW8
         tqE7NJp5gdfLd/VuVzEDCPJB9LCfYgfW5lD7lLhOh2kQozRlAxuaKcCa03fnD8zCfNHa
         oPPw==
X-Forwarded-Encrypted: i=1; AFNElJ9nu2vANsMulcnR2bcrZhDUL9RMQqjL/m4ecmNYQMLLPvIE/ijbO3E323TSYJ798CIbc+86UAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWcXUhuJvyKekpu1w0dMOFnck66YnHvkmjDocRoaHqZga3zb6
	bhtwfMI3FnHCr0aOBqcjnzNeGUJ9mdBPEBbGeb0JyQn7N3Hf01BGfMcU
X-Gm-Gg: AeBDieu5cc10l1SxYUrFkH+CvODM1yEWmu5Be32bU53W6gmVmD43+3kLI8LsVICbrsV
	Pck/1S8kxKaF5B6MVcQX4Ef5o5/I4ZFMfur64ooWEBunhLPr+AMdrCvW9y9iWryyz/dd+mrj4Ol
	3rWl8qWw+Wps53bU4e2Vd7z/kTv3wHWoUK5UxAEQCnM8zsrD3+dvHFhcz0IQPrahOWDxBDrqwEo
	kkWDTdhPqzk7lrfFFvFc9QWLJJmAInJiOgFbOi2obyN7EOmB9VRGVrsO0qHIPdmhWAT3qIPmpdx
	Jka0zXE1GlZtAFOM3DdU7RcxdLfpTP5pzPZypJCgrQ9yHaodrOgmOdCd9daElWIEKqZZHUzSxSa
	9mwgDMaXpbD6bVAjbJqzUkrRo1WI7/PbhNQfTkvI5qN5gP84ElNZO2o79HSw8II+WG95vwmM4rS
	VjsBRynVn/Yxx07H1Rer8kVzr8oTSKdvYsUm1QDZpr8ELS
X-Received: by 2002:a05:6a00:4c1c:b0:82d:5da9:adbf with SMTP id d2e1a72fcca58-8352d2833ffmr6199061b3a.41.1777825576525;
        Sun, 03 May 2026 09:26:16 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:15 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 04 May 2026 01:25:54 +0900
Subject: [PATCH 1/7] seg6: add End.MAP behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-srv6-mup-v1-v1-1-e0a6791575cb@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9489;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=cWrWy4lRcfTLfcTh6rppTo5D8aFWc22hbKKodGoaMxM=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93chT/4gfKWT/HAkrwiu9IBekI9Ag+qmPT6PV
 CUk/6BvbtKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IQAKCRAq19F1Kl0b
 TS4HEACHoDjIcEZouyca1kiZymTGF9z7+DLmEyzI3m1tfKz2nFseoH48SjbeomnSEREkCLKZzZ6
 8Z7k43PlPOabXV01wgTMD4SJRJvmbp4m176I/S1+00nYgkFOUeOh/9I0FgYA/UaxDnQDItOohSu
 Dr7aunoZvKBpOTNGFtMhcgygzvzf6mH89eptTPAsyr46sz9br7m++CRYwuR0mNWTsAgzRglAbaX
 GK2I30L0VS/CU5JuhVxQfFteLOpvqgBDbzIo5DSqXQMYRRH5fuwoioYHb64MSL8zt2tnUnsaTX1
 SBrH0YFC+pRNmZuz5m++K54o/z7wd/1SPGIsvjrWhWUgzqwKxrkYomZ1ak148SUigdEyh+3tVG3
 IiQCLWolGl1Hftj2S9N4VEMfmbwZ34flw+YBBuprr1QexdNxEs6Cj/j9/H8W7x/s0uNe8oMd0/+
 yB85nzVUhNMlbZPxX+faTDw+/1e/nIukrTqRySRFN5GjTn4A7fB5YwOLewotnTe0Dk8vRayKE6g
 A39VEoWr/GNYN2J5JzvKZht5/gUUymdDYxlI3epOo9gBdWxEHvi0w4tI4NTZXs86UQuU9xceEIs
 Dq4htONrgLXi/MBeM+Yip0rYElWUnWqvaoNF3gVXKOHf3vFjnYrTk2yVHocMcOk+hTVzuN01xgb
 4HHmRR0C7U/iSYQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 5B0C74B6728
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
	TAGGED_FROM(0.00)[bounces-283629-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,end.map:url,lib.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,srv6_end_map_test.sh:url]

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
 include/net/dropreason-core.h                    |  19 +++++
 include/uapi/linux/seg6_local.h                  |   2 +
 net/ipv6/seg6_local.c                            |  81 ++++++++++++++++++
 tools/testing/selftests/net/Makefile             |   1 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 102 +++++++++++++++++++++++
 5 files changed, 205 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e0ca3904ff8e..17f881009336 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -127,6 +127,9 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(SEG6_MOBILE_INVALID_SRH_SL)	\
+	FN(SEG6_MOBILE_HOP_LIMIT_EXCEEDED)	\
+	FN(SEG6_MOBILE_NOMEM)		\
 	FNe(MAX)
 
 /**
@@ -600,6 +603,22 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL: invalid Segments Left
+	 * value or SRH validation failure on an SRv6 Mobile path.
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL,
+	/**
+	 * @SKB_DROP_REASON_SEG6_MOBILE_HOP_LIMIT_EXCEEDED: outer IPv6 Hop
+	 * Limit reached zero on an SRv6 Mobile forwarding path (e.g.
+	 * End.MAP).
+	 */
+	SKB_DROP_REASON_SEG6_MOBILE_HOP_LIMIT_EXCEEDED,
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
index 2b41e4c0dddd..cebecbe5e49b 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1468,6 +1468,81 @@ static int input_action_end_bpf(struct sk_buff *skb,
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
+
+	if (ip6h->hop_limit <= 1) {
+		icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT, 0);
+		reason = SKB_DROP_REASON_SEG6_MOBILE_HOP_LIMIT_EXCEEDED;
+		goto drop;
+	}
+
+	ip6h->hop_limit--;
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
@@ -1565,6 +1640,12 @@ static struct seg6_action_desc seg6_action_table[] = {
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
index a275ed584026..b43e87e36174 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_PROGS := \
 	sctp_vrf.sh \
 	skf_net_off.sh \
 	so_txtime.sh \
+	srv6_end_map_test.sh \
 	srv6_end_dt46_l3vpn_test.sh \
 	srv6_end_dt4_l3vpn_test.sh \
 	srv6_end_dt6_l3vpn_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_map_test.sh b/tools/testing/selftests/net/srv6_end_map_test.sh
new file mode 100755
index 000000000000..4e3b63699388
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_map_test.sh
@@ -0,0 +1,102 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
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



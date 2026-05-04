Return-Path: <netdev+bounces-283943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCliN0XF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF184C1395
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58F8E3028663
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464773E1213;
	Mon,  4 May 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4U6Tozj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A33E2773
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911058; cv=none; b=To+9A6jhs2KGVYPY79c4k3QzO2Y1Ar852DazPOSZzevZEaiezZh30juo1whJV9Q9GOPpN6BDQABW/5PTlJ2uK7wU8mtz5Ac2p8pC6LlIuh8ByJR7yt9uTlZBYCsUsQtlAUWdOt0WO6xpwCTBVz+z3yj/6uZ41DiTn75tNDutZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911058; c=relaxed/simple;
	bh=KdZSEZXqT5/TqKshJ0Cm8cz5idFCJ3lZ+Oa0tgSkABU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLm62TwwMZjLLdtH/Xn2ZcdBUvri+B0186zr/B7QSSX+KIdmDqK3kLr8uYE6GEfo2ByRxiX5N/ddOxq670POGWxtmkTGnOc/kWsyGkdQTqvTELCKj+RRPXkS+oMpuDFjbX/i4YDdW4DxGrSSr29IQi841t2WoQtm5R1RCvDQaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4U6Tozj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso25648795ad.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911056; x=1778515856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J5WHSOgMGvvbHVAo7IfeKGrVCSkcEOo6Kq4Cz9eTqQ=;
        b=c4U6Tozj8eSjQWWx/mBATxEBv0EHfwH/cTAq9AIb1wfRx6nA1JZXbAJlBM1PlPYEiT
         h6ir8XOcMfSQTY7wSvoJclVcF1tvf7AN8+XNeHY4HqSAdR884K9YpLVsNGJjwbrYva3W
         o6hZeHhJb+7WIXqz88Iyy6mACmDwTSaONCjWynHYGOTPvN4iB4au5Lj1xYDkTf1aEf+S
         PllnJSIUxS5/F/zaTUvLk+J8IPjTEd58GMY0v1eP2LVXmtouqTofBE+uem3ERcjIHMlZ
         8WD6JUCdMpf7puE6rAPFE/5OGe1rCrP1rRxVAtW5Qztu1KA7Cl2bB8CwvgtfJchds7jJ
         TjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911056; x=1778515856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2J5WHSOgMGvvbHVAo7IfeKGrVCSkcEOo6Kq4Cz9eTqQ=;
        b=RZKk6N98PLQYwvi3vwlqxYLSfuzSTkKsd1Nb9vflWXHkoGtfWBZLkokEVfy46tttV1
         ijY/8PHp67Z1rBkxPd+JtL6dnYIhGRqfY+PK2YlxGzRqE1GqsmUeVBnftXAqbmiVRGGi
         WxEpKI2Yi+SbVjqMLzjhMQkoYtFVdfXufUelTr7dO73jbziD7dOoOkLAfIZuEtzmJ+SX
         AHyxiTHRGM/f2uXUBu0OeabwVLM//nWn6AKucRl9k1MfqlcOguFnC7t0z/nxSwC+exGO
         Lb6zs48/6lMMt2jYcA+coEf2eT9+TamDUJ0wpzIx0WAKHldyLPRFb1noaWvAREOXe4+U
         a17w==
X-Forwarded-Encrypted: i=1; AFNElJ8tzkhDaXVdP/pcuxzBFBgZc7c/dkVBBI7PxWk8Fb+kAOTHcGna6HwakHp7OvUY1s5hZ0Yejw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzneX2W1Liz0TXd4bdv34Y2WsH2O9h+Nb4Hs9RIopQTXwpmupMg
	ysWgPSktE7O87bIWcHEPpnfubSBEmqIyopA4TVtcfvq/ofuORfdSVZBEFIWzs7mn
X-Gm-Gg: AeBDietrFaVOgBhEsslNwf3SiYt+AzYJDtnH0aiefLProDlTbElCntwcyfBlx4P1kEn
	24NJBwIDCb8msf6IzMskXkuOpznoIXyr/UhR9mQLk6NuUihbP6bdUYyazomYQBoUGVC4nZNH47w
	+fDsZw76N+9cZAZoes1b5KOwxR86Zbk9Z9McHhDzHzZbndTYfZjE5zufNZVTrZtoBrAbLhA4gjD
	ZC/OhBFLAdvxpiofRL5H3ciak8hxowRriR/gMB8N323uzKZD1TYNyd1O+cb0Kkj+/qNk8Zlih4Y
	QU43nG/OG7PNcWh/v6lLKp9PhAZ0E1Sn5+it7ZI4Ffke963vDiLiaIpqpv7dPg9E06ArKNZx6uU
	dCyLvTd+q0n7XfdTW73OfTyaJFWuNEFxUGPaq7NQvaNk9OKyJxnozRzgVtjAlx56cWfaNwGZ9oi
	4zcIGVlXCFCb9vD7JhpEIpI/GzxR1ez2ps9Ax97JMGkyRd
X-Received: by 2002:a17:903:44c7:b0:2b2:5099:2f40 with SMTP id d9443c01a7336-2ba4e4d0ef8mr555855ad.22.1777911055318;
        Mon, 04 May 2026 09:10:55 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:54 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:44 +0900
Subject: [PATCH iproute2-next v2 4/6] seg6: add support for the
 End.M.GTP6.D behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-4-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8113;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=KdZSEZXqT5/TqKshJ0Cm8cz5idFCJ3lZ+Oa0tgSkABU=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUDw/jxatj9dlRRiWcJ9RJ7+4h5A7XoUuWfv
 Uj3cayRqWaJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAwAKCRAq19F1Kl0b
 TY3xEACOxxWA5AoA5MIPve4Y3P/OXET7yU6A54i3Bd92t4f3kNPdg9EuQcdlzetIlKjY/uGUng/
 DU8rc5l9A+9xtyf6ztjVo4DPYabfASyBSzTTIryhQ1SC+Kq8hX+egwiS4J1mn5ZJMGu8Ce0CGDp
 Fr9tO3SOghM9hhLSrAU5UqfMk/Wr5oGbuGSWmc/7+he+cLsNlDoSq4KeHnm2vcXyQVblYlpkze2
 SXXyis9n5YxNuLzCQkH3ttTTtWRNexgRW6G1g2DnDbKpP4HpR73mBokqwAX5lFmf2lZl1MOozWr
 GoU/ut3Jj8O1kfWOsTbkKQAtZyjaNlRPgv6d3uer7GYmfburKwML4an435qGbLQ8lbFJQfHFiqN
 g7NELYCW4k8QNHOdL/CM0V7NyaE+OePgBgN/YYHoYMEhFpsnxOxUSz3hjF3pQscXG+Bs6+rqUpE
 x8LmguFSAD8HzECOzAhlRvZ3krOeB3AnGHbsbbyrNqxEoSJdW0DlP+yYvPgVoFLC0ZleFv5NfEV
 wWNXssQPHc42I+rWe7EiOjP/8QkWULE79ZJrdvWY9ogsSjLKC3SUNIrgXQBsMuIx+/1LkOQ/UmW
 eyp45MMNql0+ee7dOZ6hXKftsa/4ahdJn2PcVEZiWr8gzPRIxBtwdI+Ea7cCieamjU57ISOJ+Rv
 nSHx5fgRv1w0GWg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 5BF184C1395
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283943-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,end.am:url,end.bm:url,end.map:url,end.as:url]

Add support for the End.M.GTP6.D behavior, which translates IPv6/GTP-U
traffic into an SRv6 SR Policy.  The SR Policy is supplied through the
existing srh segs syntax, and a new sr_prefix_len keyword specifies
the locator length of the egress End.M.GTP6.E SID (1..88, leaving
40 bits for the Args.Mob.Session field).

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.M.GTP6.D \
    srh segs 2001:db8:2::1,2001:db8:3::e \
    src 2001:db8::1 sr_prefix_len 88 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  3 +++
 ip/iproute.c                    |  6 ++++--
 ip/iproute_lwtunnel.c           | 45 ++++++++++++++++++++++++++++++++++++++---
 man/man8/ip-route.8.in          | 29 ++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 6af145259ffb..ed44fb858600 100644
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
diff --git a/ip/iproute.c b/ip/iproute.c
index e009e7480e76..6cd19c2c2b00 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -106,11 +106,13 @@ static void usage(void)
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
-		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E }\n"
+		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
+		"            End.M.GTP6.D }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
-		"MOBILE_OPTION := { src ADDR | v4_mask_len BITS | v6_src_prefix_len BITS |\n"
+		"MOBILE_OPTION := { src ADDR | v4_mask_len BITS | sr_prefix_len BITS |\n"
+		"                   v6_src_prefix_len BITS |\n"
 		"                   pdu_type { downlink | dl | uplink | ul | 0..15 } }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 38e806b053c5..a63dfe379a89 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -408,6 +408,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
 };
 
 static const char *format_action_type(int action)
@@ -589,6 +590,11 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 		print_uint(PRINT_ANY, "v4_mask_len", "v4_mask_len %u ",
 			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_V4_MASK_LEN]));
 
+	if (tb[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN])
+		print_uint(PRINT_ANY, "sr_prefix_len",
+			   "sr_prefix_len %u ",
+			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN]));
+
 	if (tb[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN])
 		print_uint(PRINT_ANY, "v6_src_prefix_len",
 			   "v6_src_prefix_len %u ",
@@ -616,6 +622,22 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 	}
 }
 
+/*
+ * SRH-supplying actions (the seg6local equivalents of seg6 inline mode)
+ * pass the entire segment list explicitly; parse_srh() must not append the
+ * implicit terminating SID it adds for inline-style callers.
+ */
+static bool seg6local_action_excludes_final_seg(int action)
+{
+	switch (action) {
+	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void print_encap_mpls(FILE *fp, struct rtattr *encap)
 {
 	struct rtattr *tb[MPLS_IPTUNNEL_MAX+1];
@@ -1489,7 +1511,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	int segs_ok = 0, hmac_ok = 0, table_ok = 0, vrftable_ok = 0;
 	int action_ok = 0, srh_ok = 0, bpf_ok = 0, counters_ok = 0;
 	int mobile_src_ok = 0, mobile_v4mask_ok = 0, mobile_pdusess_ok = 0;
-	int mobile_v6src_plen_ok = 0;
+	int mobile_sr_plen_ok = 0, mobile_v6src_plen_ok = 0;
 	__u32 action = 0, table, vrftable, iif, oif;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
@@ -1497,7 +1519,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	char segbuf[1024];
 	inet_prefix addr;
 	__u32 hmac = 0;
-	__u8 v4_mask_len = 0, v6_src_prefix_len = 0;
+	__u8 v4_mask_len = 0, sr_prefix_len = 0, v6_src_prefix_len = 0;
 	int ret = 0;
 
 	while (argc > 0) {
@@ -1621,6 +1643,23 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 				       *argv);
 			ret = rta_addattr8(rta, len, SEG6_LOCAL_MOBILE_V4_MASK_LEN,
 					   v4_mask_len);
+		} else if (strcmp(*argv, "sr_prefix_len") == 0) {
+			NEXT_ARG();
+			if (mobile_sr_plen_ok++)
+				duparg2("sr_prefix_len", *argv);
+			/*
+			 * The egress SID must leave room for the 40-bit
+			 * Args.Mob.Session field, so the locator can be at
+			 * most (128 - 40) = 88 bits.
+			 */
+			if (get_u8(&sr_prefix_len, *argv, 0) ||
+			    sr_prefix_len == 0 ||
+			    sr_prefix_len > 88)
+				invarg("\"sr_prefix_len\" must be in the range 1..88\n",
+				       *argv);
+			ret = rta_addattr8(rta, len,
+					   SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
+					   sr_prefix_len);
 		} else if (strcmp(*argv, "v6_src_prefix_len") == 0) {
 			NEXT_ARG();
 			if (mobile_v6src_plen_ok++)
@@ -1680,7 +1719,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 		int srhlen;
 
 		srh = parse_srh(segbuf, hmac,
-				action == SEG6_LOCAL_ACTION_END_B6_ENCAP);
+				seg6local_action_excludes_final_seg(action));
 		srhlen = (srh->hdrlen + 1) << 3;
 		ret = rta_addattr_l(rta, len, SEG6_LOCAL_SRH, srh, srhlen);
 		free(srh);
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 7cf97924d699..35e6e2080a1f 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1088,6 +1088,35 @@ takes the same syntax and semantics as in
 .B End.M.GTP4.E
 above (no PDU Session Container is inserted unless explicitly set).
 
+.B End.M.GTP6.D srh segs
+.IR SEGMENTS
+.B src
+.IR ADDRESS
+.B sr_prefix_len
+.IR BITS
+- SRv6 Mobile User Plane End.M.GTP6.D behavior (RFC 9433 Section 6.3).
+At the SR ingress gateway, the matching IPv6/UDP/GTP-U packet has its
+GTP-U envelope removed and the inner T-PDU is re-encapsulated in SRv6
+using the supplied SR Policy
+.RI ( srh
+\fBsegs\fR\~\fISEGMENTS\fR).  The TEID is folded into the 40-bit
+Args.Mob.Session field placed immediately after the egress
+End.M.GTP6.E SID's locator (RFC 9433 Section 6.5),
+.B sr_prefix_len
+specifying the locator length in bits (1..88 -- the upper bound
+leaves room for the 40-bit Args.Mob.Session field within the
+128-bit egress SID).  The egress SID's locator
+length cannot be inferred from local state at the SR Gateway.  The
+egress
+.B End.M.GTP6.E
+SID can then recover the per-session identifier from the same offset.
+The new outer IPv6 source address is taken from
+.BR src .
+The action requires either no SRH or an SRH with
+.B Segments Left
+equal to zero on the inbound packet; other matching packets are
+dropped.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a

-- 
2.50.1



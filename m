Return-Path: <netdev+bounces-283945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KA6OyrF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D967A4C137F
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ED0D3008C1D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1193E3143;
	Mon,  4 May 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWMDf62j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473332ABC0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911062; cv=none; b=qVEcWRHx3lW0xYkjlJeN5fSEJ2rtigJvYYCIrzgpA2oMEGGgcJfFlHTKKQeSfh/8A2nxr4sttJEpWriWwdPVS8masQKPPVB7gODCAFf+mlWpuUUBmjHjsUFo7WwTAj5Nx0j9UPGLTRCaSYLnxiOwrtZRjTzd95EBMscFb1qy4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911062; c=relaxed/simple;
	bh=oeL3HocbaD/tDUctoP9RsKpjYIRBNRTKhfReqDR+hi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4x7TgtBDmHwy42wWIM7JjnZHOGAOl0mT2zZ6PD4xJtIG44MCu69Yj99ViHLOINhhqYpNmzFs7tm0qc7N0cT3fDLadgjfdn6URhqG/95yx0joth/SFUduFZu0Colrh95d+cITxC50kbSnZ0waS0Q+U5XwrAKqGFqeuwzrYO7Ie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWMDf62j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364d72f2986so2897933a91.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911060; x=1778515860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKbDj6b0PerwtN1AGREDW6+2KWJccCCCASqCCFFFip0=;
        b=kWMDf62jU3jIIBd8ib3bVAXiP+aT+a6HCJEN9Gs+2XbhDPqtOG99tpprlMeTuiujjm
         RLggtEn27fJyw9rnLCZAbc1hV4XGbv/WVpfTjMAd3FNU3ryjKu8Q0nKeC+tGb2lPR76k
         UR/yuxdLK8EZD75gKxXoKPLtUSsI4+YimfikX+3/vrzdSp2sxIN1lKnWjWDyll+mfuJp
         OED75b7kUQdeYwLxydwPbIP61FLjAKCg8e3Ymfx7Xh8wz4QLQMOXixpGJy2g099IefH7
         mxuimyX8WKTlyBH+o2PvtD/y/BDGOSYIOX9B1dL6j8hom2/zpfdgJzC/MFYrZE7zm7YB
         9nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911060; x=1778515860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKbDj6b0PerwtN1AGREDW6+2KWJccCCCASqCCFFFip0=;
        b=Ec13ngeEBBeiidE5CnERcp7if+tzPjQCeoAHdg1CAGslpf/i55kf9UIlD5gnGC5kwK
         pK1ys7uMl3nntR3MzzmSfitNrLL0dMA2w1l5zRN7jh3zXTL6sfXyfJH6jVKlA4PChav6
         00EYg0Vvs9QuknM4rFMiWWcUBu4Z2MdA5YiZ3JsqL3HrzCbhMV1/1Y8ttABCUW39xExb
         IKzWTQJPnbqL12G1l6rPM+BHMnSfc7JRmzNQUPTR9U3g6IlEehFpkJT1dY/y4+tF6RB8
         GVOtzIlGWVA0dKxBdTxG0troR8AIa2mWbiqulBrzKHuJpz0upU8ZrlCFOOW7vRcSsBGM
         //xw==
X-Forwarded-Encrypted: i=1; AFNElJ83tHz0+v/SUTelq9k2B+NQMFZjwGpCt4JJS0SI5Znq0X/Cm35hQ6hpnDYqzHLDpMoJ24xeDxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkD41j4ZGSgHQHhaaSHUjMMpHbLRhJdK4pUxNN8iRemLM+kbWu
	m6bP/zaXln6JRv4/x3WkwNtJ5aBUXZs6RxtvFZkah+VzeOOZniaoI7xgGHv3fbfb
X-Gm-Gg: AeBDietCcFaI+xMatcntBtkU0NSCkqXAvDmN/f00FKouIUwngQPUHJNPMAp+d3zE5Pl
	HWGu1ZiFwLWj9GE91jEPNbAzxNerUR7UVpNbeG6NWXXSRMcUFcYQO56EtcY20xfbwPCREgQQB5K
	BzI441L3AVz84WTn4qJDCCAvdLFlsd7dN+h6ITbWZ7SyxGLACZ9nb+de5Qj8jQWM5NQvwnkW40P
	vZCl5zzYfdbpYW+WHf4/h0WSXh3DwdRQh+ZEpgVvfrNL9b/Rm0ohv5rxu2eouEcPKyC8ejacwaR
	gjjRvQ4ZqmVpqPbnQR4jaw+mcrIb8Gvzf9sPYPN5i1WrxmygnVZ+VhyWVhqRa2rzhB6wlteFdu+
	kzwIPw6/0ca9rWK2SorO0UycZaSzPeAO3ehUghLatVO33IzsQA814v4mbD0/26SNmffaxhgz/e5
	+VIQlgEFp0qUvzbvRDyWRSmCettO6aJW1WK3J00vy+J4Q9
X-Received: by 2002:a17:903:120c:b0:2b4:5cb8:99eb with SMTP id d9443c01a7336-2b9f282555amr96915655ad.27.1777911060221;
        Mon, 04 May 2026 09:11:00 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:58 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:46 +0900
Subject: [PATCH iproute2-next v2 6/6] seg6: add support for the H.M.GTP4.D
 behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-6-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4938;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=oeL3HocbaD/tDUctoP9RsKpjYIRBNRTKhfReqDR+hi0=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUEu8Kb0FSGeQ/M0gKtO1yQ3Zh/mFYCxlMiJ
 9vUK3SVjeeJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFBAAKCRAq19F1Kl0b
 TQKdD/9mVaApHcBFw78S260tvIJrvnE48WQjQfk6S7qoSxhm+AZHMLBfhNemef++5bJ83VfLbzR
 IydRWLabmJ9sP5yYxlRQiBMX/aged687V2hne90rj8tzBcpIW9v602HwznluXHX+1vXa84Cr0i8
 rE6yhBsICIh5SQJ+Q8joglvUdNJNCUr9bZHtoLGxgbYkq18Ladw2WV4qD0sPl2pu3ZhzKbQfv7f
 /d+XvIWczRsb/TrU5EMLMo0+g2dKqsgryrwxkKk13aETvoWEg0lR1RUf6RG4NZp2+1jiv0Ev4Bk
 LtPOTt0cvsIpXcby3KRxtycsiFrGd9uKW4cSKiNCmzrDOt0IVtLP73RWjDLsMmPtiJi8GFTibW+
 xKZwf3rVN6N0mOxWdaW14aOak3BrLrE2u1IIFAe0dYhCkTkMVgixFxrYrb5C0AU4ZYFM2gPXdVS
 5PXAZHVrHBCFDyd8+bztQ+SVisUkpO8PURwiPSvZphlQwQrXIRRWQTJYiQmxjbMUzT0j0LFUrzm
 gwwiX8jXYUtOPM+8zDvzMS25xK+77mcEjs/5upaYJ5zAEzISV1suWrv/7KM+gpv4pHz8O5PlpxB
 +BGrdY+3AzE9+2PtHGdl5V/CkEtjEsFxcfkVvf4u0GC/liqIW706sqWBfa6VXokwsPOT48reoOi
 iHc7DOhuy8iBPew==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: D967A4C137F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283945-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,end.am:url,end.map:url,end.bm:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,end.as:url]

Add support for the H.M.GTP4.D headend behavior, which translates
IPv4/GTP-U traffic into an SRv6 SR Policy.  H.M.GTP4.D is installed
on an IPv4 route and reuses the existing src, v4_mask_len,
sr_prefix_len, and v6_src_prefix_len keywords.

The kernel validates that sr_prefix_len + v4_mask_len does not
exceed 88 bits and returns EINVAL via netlink extack otherwise,
since the locator, the embedded IPv4 destination, and the 40-bit
Args.Mob.Session field together must fit inside the 128-bit egress
SID.

Example:
ip -4 r a 10.0.0.0/24 encap seg6local action H.M.GTP4.D \
    nh6 2001:db8:f:: src 2001:db8::1 \
    v4_mask_len 32 sr_prefix_len 56 v6_src_prefix_len 64 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           |  1 +
 man/man8/ip-route.8.in          | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 0ca8405df2f2..69a875fcad73 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -82,6 +82,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
 	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
+	/* SR headend: IPv4/GTP-U decap, encap in SRv6 (RFC 9433 Section 6.7) */
+	SEG6_LOCAL_ACTION_H_M_GTP4_D	= 22,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 40494ccf8eaa..d956b39a8ef8 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -107,7 +107,7 @@ static void usage(void)
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
 		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
-		"            End.M.GTP6.D | End.M.GTP6.D.Di }\n"
+		"            End.M.GTP6.D | End.M.GTP6.D.Di | H.M.GTP4.D }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 570d95780ae4..0bb29e69dc52 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -410,6 +410,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D_DI]	= "End.M.GTP6.D.Di",
+	[SEG6_LOCAL_ACTION_H_M_GTP4_D]		= "H.M.GTP4.D",
 };
 
 static const char *format_action_type(int action)
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 0487338707c6..7badfcc1e8c3 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1133,6 +1133,51 @@ is rejected for this action: the original outer destination is
 preserved verbatim instead of being repacked with an Args.Mob.Session
 field, so no locator length needs to be carried.
 
+.B H.M.GTP4.D nh6
+.IR ADDRESS
+.B src
+.IR ADDRESS
+.B v4_mask_len
+.IR BITS
+.B sr_prefix_len
+.IR BITS
+.RB [ "v6_src_prefix_len"
+.IR BITS ]
+- SRv6 Mobile User Plane H.M.GTP4.D headend behavior (RFC 9433 Section
+6.7).  Match an IPv4/UDP/GTP-U packet, strip the GTP-U envelope, and
+re-encapsulate the inner T-PDU in a new IPv6 header whose addresses
+encode the per-session identifiers expected by an
+.B End.M.GTP4.E
+SID at the egress SR gateway.  The destination UPF prefix template is
+specified by
+.BR nh6 ,
+the source UPF prefix template by
+.BR src ;
+.B v4_mask_len
+is the bit length reserved for the original IPv4 destination/source
+address, and
+.B sr_prefix_len
+is the locator length of the egress End.M.GTP4.E SID (1..88).
+The 40-bit Args.Mob.Session field defined
+by RFC 9433 Section 6.1 follows the embedded IPv4 destination at the
+offset implied by
+.BR sr_prefix_len " + " v4_mask_len ;
+its width is fixed by the RFC and is not exposed as a knob.
+.BR sr_prefix_len " + " v4_mask_len
+must therefore be at most 88 bits so the resulting 128-bit SID can
+hold all three fields.
+.B v6_src_prefix_len
+controls the IPv6 SA layout per RFC 9433 Section 6.6 Figure 10
+(\fIP\fR | IPv4 SA | padding) in the same way as for End.M.GTP4.E:
+1..127, and
+.BR v6_src_prefix_len " + " v4_mask_len " <= 128" ;
+defaults to 64 when omitted.
+.PP
+.B Note:
+because H.M.GTP4.D matches IPv4/GTP-U packets, the route must be
+installed on the IPv4 FIB (\fBip -4 route add ...\fR); installing it
+under \fBip -6 route\fR is rejected by the kernel.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a

-- 
2.50.1



Return-Path: <netdev+bounces-283942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPpODjfF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08904C138D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DC0E302517D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEA3E2760;
	Mon,  4 May 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2+K6K9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877243E1223
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911055; cv=none; b=GTH2U7BFKudiCuRaVnkSHocZrM0T4/9Wv8lVlJRrmshvFpjvY6NenpNX4l8J1eUipTtQwXNP8Q2/xvdjANxXQWsQzeYiEACa/6sNGq+VUI0IYck0Bpga7RLOQv1gtl2PD/OZoXGHF7zFeNfo1ChUWjsPklt7jYOHNLk9YRfRvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911055; c=relaxed/simple;
	bh=RuneoWP3TdUvlCtHzaj1kd4cRTcs+qjn+w4Yv+QNz7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASgFdwcQghy7/fbhb3ESE+J7iaNJllDLkrxq+A3PsabIub9w83DP8s/BXA/rp4XSirrRHBz6te7CY+bE1+2q5PHSVl7RWjtFi7Wxr0OXIlZRMNkWgijslPu18UoYz8E1FxMYDES4sT1/SVPspz7ZBQJplbJ8Yq3Zk82B6OtSwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2+K6K9E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad617d5b80so25680775ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911053; x=1778515853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJLhKNEzsdDbo5QfDQuOAZ/DuHRynBpJ5+RUhJ/Ag6A=;
        b=N2+K6K9Et1F1VJgW2at+v8XjCeyyV5qeG9gWxd2mO+CUtzyBQAZ3N0kZV2kJ9bPXkf
         oKKe2Uxk8o0HMyFl875f49nnAuQoyAfsQdEDNbwwC4lKL5c92S7ARzWpU0E1Y2K75umZ
         nL6JJTQBlXoKzaS/WDnkwXVKhnE0VlL/x2CxPYqwtXSvXagxvkNoOjlZprGzAj58wItQ
         5p0Y69UP90HRI4+4Nz+BLJl/vkg83vjkWdFpiJJQz3lvw54LkCpqZ8hMjOraoG8wUmjs
         8tKqKP/XX/uPz27vX8XN5YZTzoBeCDu7JFC1xBDfrrnMwuC7TQ77p7bhAHxjIezLuQDg
         CzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911053; x=1778515853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJLhKNEzsdDbo5QfDQuOAZ/DuHRynBpJ5+RUhJ/Ag6A=;
        b=XTK3sFWWiK3oliHYafcYAOyrtPvOu/vX67+4+/6ERkfwSfF5YpiuAM5YkkLV7uTplp
         AcGYPsGPVYUlXOywv9WiRRVwKT5XAZe5PYW5O8k00qYJhOFynUeVnQh1Q2dWbb8fhPfo
         3D9KG3CW3gqcKmT7gyDk0mZesrC6aGXEHtSNgwPvipwA7Ooac1CYzvOyB1w8QyLNxKvl
         DZizBloXsmjlUtvCIelC3Fp9uouqPoWtX0V8V1N12Z2r6luyVRRMAPR2YXAnxHs5lJ49
         z+geJAlijcMduuFA6xhUAPRACgY5uNOWJAQgM/KL25UnJrdevz26n1wssPP/ohe3vMOm
         pDvg==
X-Forwarded-Encrypted: i=1; AFNElJ9ih6tNLEMoJBdCfaO9Pnr1ftOioX7j9RWeXVubremVi7vwhFVkgQUQsZ142NgdlNo5vMr9y7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9pApjm4mxfNjnuIfkIgXexwBZLcGpJpbLgtRlFaot7faxWjp
	zm2QYQX68YuwIthFMzDEj0ltQ+qmCVfvgMp9unefhb0xOJUP73Qy/wUv9E+2vw8a
X-Gm-Gg: AeBDieuWLSofPNVWPBo3MXrwKT1oLxTLQifALdyGtBpgkeVdS6+6J90Mqjsinu7zDlz
	XJoEoe7UFWg1PYraYaiQssRlZyfJo+aculLz9ioYvS7XD0XWwhQ+40aS5auSBhVjYu1cuTb9okc
	dOoJa3EbPx4mk9yF258gGQ1pDvYPEOn20fXjw4aECBLgtJot23cTAo/GIOMZOvnWTmpHD43//M7
	TA+QbW4IrFwKFSZoW7QLnd+ubIq54A61bV7BNkrndxdhxh3hS+0/edSg/KO6XpXtnNw0qjyQz5q
	KVOjRlKBLy+sokJXQfORkKCsBawnUFUpd3duPz3OGAPQUfwTGnjw7nXRimObsYHmh/Y+9Yn6At5
	X4GR+Jl9Y5Uwugq7IyaZfoQ0lS3/TCf63duy7XO4mDZ1ujfk8cNaMNy/7EU3HY3Ecv7xqfoDbhv
	qHcQGeiPyYYG9znn95vTs3fOX/RhF+0XSmVkuBkeMev7Bt
X-Received: by 2002:a17:903:46c8:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2b9f2851752mr100200685ad.38.1777911053307;
        Mon, 04 May 2026 09:10:53 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:52 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:43 +0900
Subject: [PATCH iproute2-next v2 3/6] seg6: add support for the
 End.M.GTP6.E behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-3-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3758;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=RuneoWP3TdUvlCtHzaj1kd4cRTcs+qjn+w4Yv+QNz7M=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUDYzyO26sN5w3HQ/PTlWpImtFX7ot8+8RiL
 sFU0Um361KJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAwAKCRAq19F1Kl0b
 TWidD/wLbLKJOv2gr/DzUGEnO5/07QPl57+iRWCapaCnVPdErZwOxRtnp5GLL04cdxX3rl7glCI
 YMPQmjQGn4bU/LitJ9XWTXz5MZMqRBKixuG4EluqyD+YejrFtQoc9vPPUTqIwAAHYdIHu9eMMBt
 ZArml0BlXFgi0FiZaN95HUVLm7CQPU6f2XAMKr/MHDYWGQSUy45To0TDGC2ThAluho4amsCs9L0
 VessorZQug7n6/cLLHBUYSrBH33dG7gBzkDJxPPPeMqfY4d8fhhSbI+XN7CMtxUGihwR3ZM+8T3
 lwxBvF+cQUbonII763Z6y3RKAbbOLaIohmBVXLqS8c60CX5Yu0UXAv3QTkpVX1JSTrIjBZxa62V
 1ggbrBM/EAdDsqLZXFJgorMBiR8TL7kMYCbvtVVayQWXkjbV/25STMMggMCjqPuI8scEXLlA5nM
 KmrbjvORFi/mjcjU+bzMg+SED2aMO1a7jup/7Fg9rEqbDrI/R3WV4q+t8CzI9nqUY/qsJaUxz18
 aU9LXy9oAxi0qDhDNnWrWyp65S99strxZH/Rpv0taOYrUmQgHCyTMeI1pWm3d2q2mF80dYvpdEO
 x+lmiXPtsjADwF98AxVscFws3Dv6hgdliEDBkmEct2LbVEdoqQBSRUGTfpaw7Ha8dWTZ3XGv4lz
 kyB0bRsXHHsI+fA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: B08904C138D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Add support for the End.M.GTP6.E behavior, which translates SRv6
traffic into IPv6/GTP-U.  The behavior reuses the src and pdu_type
keywords introduced for End.M.GTP4.E; v4_mask_len is not meaningful
for an IPv6/GTP-U tunnel and is rejected.

Example:
ip -6 r a 2001:db8:1::/64 encap seg6local action End.M.GTP6.E \
    src 2001:db8::1 pdu_type ul dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           |  1 +
 man/man8/ip-route.8.in          | 21 +++++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 8bb3cdc3a649..6af145259ffb 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -75,6 +75,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_MAP	= 17,
 	/* SRv6 to IPv4/GTP-U encap (RFC 9433 Section 6.6) */
 	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
+	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index f9ebba6541af..e009e7480e76 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -106,7 +106,7 @@ static void usage(void)
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
-		"            End.MAP | End.M.GTP4.E }\n"
+		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 49fe563d9b86..38e806b053c5 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -407,6 +407,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 };
 
 static const char *format_action_type(int action)
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index a878d4375f03..7cf97924d699 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1067,6 +1067,27 @@ PDU Type; when omitted no Container is inserted, so 5G N3 deployments
 must set it explicitly.
 The action only accepts packets with Segments Left = 0 or no SRH.
 
+.B End.M.GTP6.E src
+.IR ADDRESS
+.RB [ "pdu_type"
+.IR DIR ]
+- SRv6 Mobile User Plane End.M.GTP6.E behavior (RFC 9433 Section 6.5).
+At the SR egress gateway, an SRv6 packet whose current SID is an
+End.M.GTP6.E SID is converted into an IPv6/UDP/GTP-U packet directed at
+the next segment held in
+.IR SRH[0] .
+The 40-bit Args.Mob.Session field defined in RFC 9433 Section 6.1 is
+read from the right-aligned tail of the matching SID, and its 32-bit
+PDU Session ID portion is used as the GTP-U TEID.  The IPv6 source
+address of the new tunnel is set to the user-provided template
+.BR src .
+The action requires Segments Left to equal 1; other matching packets are
+dropped.  The optional
+.B pdu_type
+takes the same syntax and semantics as in
+.B End.M.GTP4.E
+above (no PDU Session Container is inserted unless explicitly set).
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a

-- 
2.50.1



Return-Path: <netdev+bounces-283940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA0jJBnF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F64C1368
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CEAF301BEC2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F333E2760;
	Mon,  4 May 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT4NT8X4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B993E1CE4
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911051; cv=none; b=ExP59ZprpG4jZMiPTeHojf97lCSOMscsJsuvwAem06vXzgeeJ3wCCrT9yKyLwOG6BZzajGe7DY8CLMemF5jatNtUA5lwAQSpX9YcKVfh44nLGUKadF+/j9PntH2OnMXJUg3zwNHk9O2W/MdL5FejS/0fOIJKKwJfO7UStvCzfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911051; c=relaxed/simple;
	bh=vYzH7BYeDUzA0oVONsCVHdrgOP8I9lOvmgigAkKlZ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jN7HwMVV6rE40jE9PxaeptBAGrX0zrcdIPywhOKl5H9RI58QIqPLgI+7RhA3kxvMQZ1oZ3XOsVAf+yrYQIUNX0PR2F/QfxKYyUskXEnO1jgr1QX+6vihUZxgFdKwmAzKDltiGZGnJ5yUVKDEN0dyTUGQzlg7lzGrGC/axmN77hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT4NT8X4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2addb31945aso23805155ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911049; x=1778515849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDJMXCllgedRNXLB5E312P0bluglV/gkKYlzVHToCTs=;
        b=jT4NT8X4EuEpX/7nyr7M58xO2BmmN2O41c7JN1Yj7YyawuGma18C1220kQrBtPlYn0
         mdOJyFE4Jzwu/gepdWKSRKyT9qNjbRP9cr5laHOJ6sWSg/oaof+yIwWbZNvYGgL1EIL3
         69+oj9SWrPTAP1XpXI6g9vFWAMi39o6+xGoLvm/ZiplwIgce1rOjXKWu0EyyY74sMpjt
         lyzim19JSsBONnq6VXsEDiSC1iSoyE9ofN/D3ndOdCrg5crMXA59SOx22RDbkfoDmcGO
         QB4qwQlDLoJsj2bElTyvc5dK0ZsWMoQcygX0PjBspWvytimMbpIGk85mbZVFh0pDm5Zq
         CD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911049; x=1778515849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bDJMXCllgedRNXLB5E312P0bluglV/gkKYlzVHToCTs=;
        b=ZZuxe0DK5UHWbET67pjSysIDGGmBUeU3syYKOZy/iKU4AYexCGrwZNXRimzwET2uvI
         +cVQd3pcfyY/X/4F7uOWnyTJqCP6WMMQ8o5rnbTyzmX0gD47Nr0eEAp/4CKuVkP9SK61
         xzfgKIQqmB/sn747/Z2jqHq7i4czV4oCcGZ5fdnAH424poAJgFRbwtK1HGk1SOJFuj/4
         EZTZWYiiMTzkYrwb7AkMfmjGPvz3gSq3NbCa1tyZ0waulJJrLDYsFu6nE97Nmk2d6dO6
         4amBlycPRa1xuII51BQpF1iBslRwX7SBLwnbOmd2N75mnD24FlN/VB7a46IVqQYGlWxX
         kDEw==
X-Forwarded-Encrypted: i=1; AFNElJ95BctN/7RQe8xvaugX58BOUgjTyMtG9zLwxtPbqersqZF5A2vyRmzVrryFB/l+WBy0UgqerC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdskWaFkgcPn+3McsAwvvhBRQ/92qlDMkPZoPXB4driKkAD08c
	aYwvNjLWvLcumQaUt1LNflL9c6XwfDBgCQz7JEdWwysszTkguDZh2L0boiTTz3lp
X-Gm-Gg: AeBDievC5XIUar4oW6UVXDZzygPsGbfQ3SqF0IwceQR13olYID8APKASY0uT+k/gx0h
	3lkkubT5ChB3XEGAn3Pnd9ayWGMq/u2/Vk3cth5yW86TiML+broFiBE7QErra5n+RXtXrLnjnQS
	/StItqVfx2ti28L6AePJHgFNqVdVQ/o2VWOrNjxDpWldaCrUU5DVfjrifKvInpCOjwoM6FacQzQ
	rJG1kr3qhM6ozl56e4tUlh4Bf/ySQ2Tx49IBtUmDsCgbZHmYnlEkwNR1RtT8cg05V+kZrNMBnW5
	GfzhGwkFFq9sIBBHMvXvSxhDzGjRdauVTTI7Tmj7rjNJw6ZeD+gcIolhDVqbco1K/Nj1JlaZ5DH
	i9j0HPwE9ntMQy2Q1YuW7Wx2Zg7N+cx74JU2uFW7dAmWa2Bejcx3RQcAqGr/Uezv4RV/wrtbJaL
	9L7+iEp2aAnQrzBp0d7jlNqHPTpO/QgGWbSnxbrFzIXAGo
X-Received: by 2002:a17:903:3c48:b0:2b2:5840:809c with SMTP id d9443c01a7336-2b9f2532922mr92807635ad.1.1777911049193;
        Mon, 04 May 2026 09:10:49 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:47 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:41 +0900
Subject: [PATCH iproute2-next v2 1/6] seg6: add support for the End.MAP
 behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-1-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=vYzH7BYeDUzA0oVONsCVHdrgOP8I9lOvmgigAkKlZ5w=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUCUaknCtgL9hVexyuLJYQzGR2vVx8g8zZcV
 Q/ZMNTTzEyJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAgAKCRAq19F1Kl0b
 TcAeEACiGMyDAjTYtG/1mAsNv7QW66v8tlRn+6/LejhGKVuyhJplB/miUlPV0KLdJSz16daXN9n
 6vUrluuvDuxo7zgQh7Oj0Ye81Vvp51jlCMsRKBcRx1JCXpjl4vyaQDoW8+HC7LIMT5MtcxKUmwM
 wUgwJyo+WbPsWEhJ5eWy22yN7qqXnht9cns+0H9mOLh8oIVrS+DjTicxxEHVL4ouzRH7OkjXHIy
 +TT6q2DjGLsdcxOnbejwDG3V2jnaNHqTrJQuy0Yt7JuTr8HhStmLm4W4+okVE3WUFbNeIjyUYoP
 18MBqpDqwHwY8hPjdVYiZZT66i7OH3v6i7bH5njfjebgErVS1QeQFBLlgHz7w7pNOEdM7qD9NBV
 B+fbkpwh6Cnvjehw0ZBmKqwF3DrHcnOXrX8x26ujYk9eDGaemzSTJQioRwW2RCXq6xahO6uHCUE
 QisuMnmmTIhN4GCv6+OflSGkxH2agJu97M+dmn6iTXs5DpgXNI5qUX61xcDMQ2NGx/Ed/dloW9E
 R7BcCqrmk3Di1EVUqIOQZYXDU0p0F1YKjQh1DfbDf6EgAV476PYovFTETlsgkJ4tbKVEdTrpaAY
 GDUbDgTCcthw7G1myV6PTNmjizGsr8sgAONdtshP8zekevBEUF09h/U+9lTbbu1TVEKxNv/FfCo
 cyZDsAiITHSUh9Q==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 075F64C1368
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
	TAGGED_FROM(0.00)[bounces-283940-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,end.map:url,end.as:url,end.am:url,end.bm:url]

Add support for the End.MAP behavior, which swaps the IPv6 destination
address with the next SID without consuming the SRH.  The new SID is
specified using the existing nh6 attribute.

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.MAP \
    nh6 2001:db8:1::beef dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h | 2 ++
 ip/iproute.c                    | 3 ++-
 ip/iproute_lwtunnel.c           | 1 +
 man/man8/ip-route.8.in          | 9 +++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 6e71d97f6f44..1678db71e8e7 100644
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
diff --git a/ip/iproute.c b/ip/iproute.c
index 5b9e7ac1134a..61394847018f 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -105,7 +105,8 @@ static void usage(void)
 		"SEG6LOCAL := action ACTION [ OPTIONS ] [ count ]\n"
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
-		"            End.BM | End.S | End.AS | End.AM | End.BPF }\n"
+		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
+		"            End.MAP }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 00b4f7565be6..3a25835662d1 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -405,6 +405,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_AM]		= "End.AM",
 	[SEG6_LOCAL_ACTION_END_BPF]		= "End.BPF",
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
+	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 };
 
 static const char *format_action_type(int action)
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 9f29fd436f59..c0b1e87ad022 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1024,6 +1024,15 @@ followed by the specified SRH. The destination address of the outer IPv6
 header is set to the first segment of the new SRH. The source
 address is set as described in \fBip-sr\fR(8).
 
+.B End.MAP nh6
+.IR ADDRESS
+- SRv6 Mobile User Plane End.MAP behavior (RFC 9433 Section 6.2).
+Decrement the IPv6 Hop Limit, replace the IPv6 destination address
+with the configured next SID
+.RI ( nh6 ),
+and forward via the IPv6 FIB. The Segment Routing Header is left
+untouched.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a

-- 
2.50.1



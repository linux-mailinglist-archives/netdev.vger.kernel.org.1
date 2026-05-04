Return-Path: <netdev+bounces-283944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGGqHFTF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B644C13A3
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3097302DE1B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A773E2760;
	Mon,  4 May 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML6S/LYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86493E1234
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911060; cv=none; b=CyOoHbN8jztYTOjPIjuc9EhqtPNPRmU9WlrmDKZX8CDU59eQUq5RAz3pKy3crH8jgs3cup+1tZIg2pID5WZHLohuz82Cui80Xty91L77swV3x3sl1ZzHthmWYDDic39ppYKKtcJmK9PNc7X4x8H+j/piPmWjlpiOfpAX8UeOqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911060; c=relaxed/simple;
	bh=meCHDyMS0AcMOWJuFWkiZSzPXDoQ5rk3vW9saPT9t+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgILOCGq1bJFxytRHPKJbQRbrn3s6DHktJ4EtQUod/JCPw6TAA6tMTtSU/upsl6OVkHHl7LEWMRBp0jMrD4HVMXDDIE5UrFa8DFmeUqZ5q7UI/L4aCki2HT8dwJ9jcP17+NZCqtpeaQOV3O4QzSGVr0ihmHemGVx9NVqDRS2U+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML6S/LYQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9705613ddso25189995ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911057; x=1778515857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsEWS8ToN+VMELdOieHSGMj4noISUPg4hNXcrOaCq7k=;
        b=ML6S/LYQD5y/WIMaZkpjtVdlXX2AP64oPJvc0rXhQ+Cn2o77HROIppxcrY2EcfQxwM
         OUdkmvCp8L7tSi+1eR0PDlZ2x8mpEfdYO4Xa+VEaLDPmmGCFswdAS8QEaRIZXxbSI8oq
         xiAvRNwjUSoLfqf6kjJyTzfJBJA356SfXOS9QOlKw/CiXhlC3ImvGlKjYKtsphFdxaqg
         zC2Hle8kdwzKUcKjadMmVxjB1jCBRSs5R8sSYwDQyV3PiSGtMSf95ltMoWe/a4x9slBX
         TNGWs0yewfImTcJpcf5b6SJnjSXQizO/WGm2Ew5wG6WRVuUPBj8hb+lKazgXTiD1fPIy
         Za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911057; x=1778515857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wsEWS8ToN+VMELdOieHSGMj4noISUPg4hNXcrOaCq7k=;
        b=BXk1l/vTrmAF21pnzS+5sZ0eSqUVXN+JqHA2j9UuLHQm8XrkHxcc4vYUXPzRzE38sb
         2O9HHIWIFaMzt9P8qbgdRE9AAlWlOGenqLe2kbeAjveXCZPU2I+a99lh+cC6zPNFxKa8
         0Rmx3k6GcPMGY7bo5xp/lXUtpZCEhFD/rNAMexMYz6JU7l0g6cZBmlubUxEiI6imtjoG
         y4LE84j8HftAB6aSsoHP96tL/2CVes6EIfwrk2u6MH+ss5wVZQ//vRHpMu3BLURKN5rB
         Mqp9JmCri1EE3bcPC+6p3+6VqdpxRzekwfHVCZQ+jEwGvS2qJpsX+ttAXhmDhtRz08p+
         E3TA==
X-Forwarded-Encrypted: i=1; AFNElJ817bAlvEYSrvB7Fu+MGRs98ubCsWp9bLDSrbcHixylQ5CF9/vCIgS81LPyO37NBgC+qjTiPlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeR+m94JhV/JHCDJhOcGaQ9+JccbIF1cq+ryWFG5EomljiaPYu
	bsu6IbA4t2jO/aoeckHGPOy5xJS9DzYCloo3LIN5OhFcO8pnmdOm6sEuMzIJl6Pm
X-Gm-Gg: AeBDietHhSjgJiQLBk+njTxGJIRdpWxKNlLyVMNYVVPoAsx/plgmE6+egvPoYS7D9uN
	AKP6cR0OkRDozJqPBVc63d5AAoFt5z7lIgKZ6qvfb0Ax79KHBz7CHnAMrjKvH4oUzOaZ6KjM8ua
	cv9xlHFPB6rkJVZTurrspg9v8eqKMCb+jCDGl20zwgpD7sUHvC/WYhLGo/exjnAfujs6EJJYKgu
	KH+yA0uWHKoCZYPlNJmWcgl3tauLNnNYwjlAImInAhdP9VTz3cweAAZIYva4KCy6TNnNKw1kHpp
	085o7NrTGsh6p0cfxRscRFHfdlCeXEkiQWOFcxh1lMnyvI+IOJRQSMXIN8OMy3oiHmi/LJ78YPB
	mamWnd2XORH09/9VypG5OEWpYqCvu99TZdrs3uuuqOqrWqL+4XZfMhdb7yQQb9I29VKHq7+U0We
	E+tEuvcp+wmhzW9/N+2MsY8YRtCbNeNUhjZtYB4N4e9k+S
X-Received: by 2002:a17:902:ef01:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b9f25968a6mr93194905ad.13.1777911057340;
        Mon, 04 May 2026 09:10:57 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:56 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:45 +0900
Subject: [PATCH iproute2-next v2 5/6] seg6: add support for the
 End.M.GTP6.D.Di behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-5-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3880;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=meCHDyMS0AcMOWJuFWkiZSzPXDoQ5rk3vW9saPT9t+A=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUD6ecj6ABSfGqvzgrrjs4jaeG83Z7iliiBQ
 E/n47kNyzKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAwAKCRAq19F1Kl0b
 TVltD/9mMernQDdd5RWMs4UmC6znj+WJ8wxOKh04CF0mCuVhSAh35ysB+VpwQkC1rYApC41aXgE
 vxkYmQSwdbBSC8V4oPVPV8Rtxd7fazKEgtR0BGvT4DokFZTEh+Ez8hH4zaFFkADcAmlJrz8EPxl
 22LMvIKA6X8s5pGFXkhrhOclhCsRJaAqUVQ6PJJaPNF/jSV8eKj/F7CbfbHdffKmh0PJLYXWsWC
 wgQwdyiUxPyheh+QHtWOhwqC/QEn/pu6q8XUYDB1ros2/GjiFo+lUYfnyU0U/+piuzK5gBdjzeh
 ODz1r/DP2pUQnZc8RsBbd26eB2sZD6lPHYDSzSZ7mc/FnY0MyfTKL0Vj+wnNHkycosrlLPcxySk
 CEUBIyeaOaN4NbueQnUypvClJZremHD1qBVCgLdClhGoFEoy0ZDqa+PkB7k+qy5/+tSgnivjIsY
 P4p3fSzzbNcpf0R8ZIkOAWEnH2Z1zMq/8n542YkoojuF0IXPsHrELX5NAk4roB5A9ufyOpgxEjZ
 H7yFSvHmGbjyP5RnYFW2EWkCyjpiWKuBDOo3uQoAGUxvI7Xt9HaqdxxcFUP59Lps4nps3UUHd7L
 fjbouwOgSfYdz9PFAXOqtG5b4FLiTJKwMFr3tZyg2do+n/qH1ta9lYCFjF6+A+Xly/zJk6o5bN2
 6FbbRY227GcUH8g==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: E1B644C13A3
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
	TAGGED_FROM(0.00)[bounces-283944-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[end.am:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,end.map:url,end.as:url,ietf.org:url,end.bm:url]

Add support for the End.M.GTP6.D.Di drop-in interconnect behavior,
which translates IPv6/GTP-U traffic into an SRv6 SR Policy while
preserving the original outer IPv6 destination as the final SRH
segment.  Unlike End.M.GTP6.D, this behavior does not take
sr_prefix_len.

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.M.GTP6.D.Di \
    srh segs 2001:db8:2::1,2001:db8:3::e \
    src 2001:db8::1 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           |  2 ++
 man/man8/ip-route.8.in          | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index ed44fb858600..0ca8405df2f2 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -80,6 +80,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
+	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 6cd19c2c2b00..40494ccf8eaa 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -107,7 +107,7 @@ static void usage(void)
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
 		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
-		"            End.M.GTP6.D }\n"
+		"            End.M.GTP6.D | End.M.GTP6.D.Di }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index a63dfe379a89..570d95780ae4 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -409,6 +409,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_D_DI]	= "End.M.GTP6.D.Di",
 };
 
 static const char *format_action_type(int action)
@@ -632,6 +633,7 @@ static bool seg6local_action_excludes_final_seg(int action)
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
 	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D_DI:
 		return true;
 	default:
 		return false;
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 35e6e2080a1f..0487338707c6 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1117,6 +1117,22 @@ The action requires either no SRH or an SRH with
 equal to zero on the inbound packet; other matching packets are
 dropped.
 
+.B End.M.GTP6.D.Di srh segs
+.IR SEGMENTS
+.B src
+.IR ADDRESS
+- SRv6 Mobile User Plane End.M.GTP6.D.Di drop-in interconnect behavior
+(RFC 9433 Section 6.4).  Identical to
+.B End.M.GTP6.D
+except that the original outer IPv6 destination address of the
+incoming GTP-U packet is preserved as the final segment of the new
+SRH, allowing existing SRv6 networks to be inserted into a legacy
+mobile path without changing the destination semantics.
+.B sr_prefix_len
+is rejected for this action: the original outer destination is
+preserved verbatim instead of being repacked with an Args.Mob.Session
+field, so no locator length needs to be carried.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a

-- 
2.50.1



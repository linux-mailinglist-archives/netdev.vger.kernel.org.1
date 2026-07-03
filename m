Return-Path: <netdev+bounces-304476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9gvEiODR2qHZwAAu9opvQ
	(envelope-from <netdev+bounces-304476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:38:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CF700B75
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:38:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ND2f8nnD;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304476-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304476-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F5233013034
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE273B27DE;
	Fri,  3 Jul 2026 09:38:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812273B3895
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:38:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071516; cv=none; b=mTkegEpmo9HTyVgEjQfgzQeX1z/aL/dC+zG4wOFANDOUo9pWMiwtR7M1Fk7RGqRDmdkUPnUz2v9BL8qYX25sfJwWdJEi88S8bEFiSGzeCwd6X6cwcN+Rk1/ujCzBgNJTuzKhWfq/wdWhlAKyLlI0vVcLjSrsLR/iTAmvx1WgfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071516; c=relaxed/simple;
	bh=3r01VP1PktDxz+Qx8S4s5rD/Cb2ZdBKy7iKYHk1Cpfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2MIESpSFLyoTkwaLZpCrM8Z68Ww24WTAZ/PX0N/kKL1ldJvifTyPRfIXuDkg7lF2xFMdR7iu7Ymn9rW3H2t6yC8LMw5rvyDHwhVHs3hdO/xF2HjCsjcXF2n2DY++t1m4hkuGYK4HloEiuipMgzaKjycI2m6l7dk6/bhK8opDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND2f8nnD; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84780c95e2eso238072b3a.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783071515; x=1783676315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tvB2+cEAzqM+Sm5jqy568bCLpanABrTdrDOGbANxSg4=;
        b=ND2f8nnD0nZz6oXEUfMzlfC/mTfIcfl2qszbzMVlmJe1FMvYB37M8fI1HsT330qlZK
         tpAGDg+86bMK0fX9tQFoLo1A5c5BOM5uh6RUSgOEUXfcJmO0FtP50pEJVgii+fOv9bE1
         mDUw6oy9pbbbllL9nbyvQDJvBMeOyk6uoUrUPdb+M/Q6d8fV5Is6AiAg/Q7SlRkX60n/
         uxRCsucJEMlJL2HS2g/5UyZjzRO5nwsp9dglUTRtexl3htZ37G8TUVkzL1yYcUwZwf0B
         ycqzV4sSvWEXIcmOpH73rBtPPmXvXqOKjRWwgthW9QBu5NVHFr1Sx8M7nv1DTKcCumNs
         WfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783071515; x=1783676315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvB2+cEAzqM+Sm5jqy568bCLpanABrTdrDOGbANxSg4=;
        b=tNEr1x+yL+fe7cvtbNYP5qfNBUPqZCINtf+3y9drx6efS4sgvd9adpcGXuZJnMk4nE
         CM6tUISVoztjm/VFTJDypP2FegJAJFrE1QCjTBu5dVbcen33LoULiGaduBOz8RN+J/X7
         3BiglQqSXBIVxzk18tyR7dHjn2Uh73zRFY4nHFhNiZX92tu8w76eF1taFdS9rA+nX18j
         nD1k7nSxSKAvyyQQRBom4hphq5rRlXGG0KNz2ZAncO11vqlYrflnWavr2+BILyjQ3nmG
         jZEmqxJZE7wcyQSlJb20wBx9IU8+CM2XUMdZHP2EacTBam76zE/54A0tf9RAC568zh8w
         g7qg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/sUwylnj9C9DzRcJ3FWUOiaZjd1Mz5F28lkZn9sN4JN3qSaNT8l1ZUXpGo19KL7zeMZOTAN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaxlr3ZUHlpG9mhNeucn1PLLv41k5Aq1oacAsXxsdtrUV7BV56
	8x7vb/bNgEjdKq1Fl4SANURFWK7ajt+wBXrA7l6TQcRA70pJpEMHhemH
X-Gm-Gg: AfdE7cnqPYyobRtE3xfBFvv3fG/e/MpVLGrufknmZVFqzjtzuY7aDAts4X4855ygmvV
	QZnmSALzHYhtjlCrUoEx78W8IMZFJ/RxjUYJRGK10XjMa3k9TQaVKR/VT65PZqhsgAlN9atNddX
	nm2S5Ao4b5Tl3SQEhhLytjeKkauc5/YwmivK+bzKpRwZAl2nirXr0Bq9rnDI11FAKXmNLRFHsym
	5t27d2OWPEvoT499p7320vWJN3aS0GEV8a0bl0xn21ierMpZZJagS6Qfz/vV37V13QMvd06bnBO
	2A74lw2xsx9fa8OzDC/tq61zYAoYo3nuXCNN7lGxkAuCrnsAuHDJ6w/2QBS3ksRc0zZYAQ79tqZ
	Ssa6ggJLM2blkJJ9f+jmqhd7KzOw89X6rbeSVL95u+Xds8YqXWJsPA4Os/W4ab13MlQS1bX4g9G
	9q3UpeUTGJMjuu/BxN3Q1lvInVMZvtLek=
X-Received: by 2002:a05:6a00:1c8c:b0:847:8f68:e8d7 with SMTP id d2e1a72fcca58-847c5002ec2mr8772819b3a.8.1783071514524;
        Fri, 03 Jul 2026 02:38:34 -0700 (PDT)
Received: from c79ofce.localdomain ([204.3.140.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94ab58sm2596183b3a.32.2026.07.03.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 02:38:34 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net v2] gtp: parse extension headers before reading inner protocol
Date: Fri,  3 Jul 2026 17:37:08 +0800
Message-Id: <20260703093708.18141-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osmocom.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304476-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:running910@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D15CF700B75

GTPv1-U packets may carry a chain of extension headers before the inner
IP packet. The receive path already parses and skips these extension
headers, but it currently reads the inner protocol before doing so.

As a result, the first extension header byte is interpreted as the inner
IP version. Packets with extension headers are then dropped before PDP
lookup.

Parse the extension header chain before calling gtp_inner_proto(), so the
inner protocol is read from the actual inner IP header.

Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v2:
- Add missing Fixes tag.

v1: https://lore.kernel.org/netdev/20260703084244.59077-1-running910@gmail.com/T/

---
 drivers/net/gtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a60ef32b35b8..4a8b00548673 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -826,6 +826,10 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
 
+	if (gtp1->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return -1;
+
 	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
 		netdev_dbg(gtp->dev, "GTP packet does not encapsulate an IP packet\n");
 		return -1;
@@ -840,10 +844,6 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 		return 1;
 	}
 
-	if (gtp1->flags & GTP1_F_EXTHDR &&
-	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
-		return -1;
-
 	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
 }
 
-- 
2.34.1



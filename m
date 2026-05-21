Return-Path: <netdev+bounces-290160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP5qJT1PDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE459D3CD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C95FE3019D83
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9471EE7B7;
	Thu, 21 May 2026 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfYvOpVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C021CC51
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322647; cv=none; b=QgN/wayTN4j0ncZc4dv1P7FE5UgBoiJ5JJpysf85RMrjvH3mfhHKNJC0yxY8T83q7SacZVg5G/HOIrmF7NgOxvhp3MlmSkkk5g0huELhH0ChXW7/Rgb1mX2+ItvL/IDVBMxwjf493C0H7MqhBceRcBV61IAL5Fh9hxRbM2X8cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322647; c=relaxed/simple;
	bh=TOFT+GtrMRJZx4HNyidmMAJZlZ/MBpkuAo+8r3ytcIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4hiUDeYeMM/FFblrJ+n0mZkG/CxrGqOH6VDXufJufliQEMynZoq5JLMAMF+ARH9sLWorCQLFMzddhP9P3I3Gq8vY9iOPxyrChDupdBljcfZHs5BlT9sPng9STDsWYRuLWmj9vPkkb98MYzCTf/hIh0vqw83jcKxr+bK2+c5Wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfYvOpVA; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-135e88b8e55so5391440c88.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322645; x=1779927445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB8hLxgPFXR6TxheosPkUZdcss+SaUcFoZO7z76syt0=;
        b=rfYvOpVA7LiEWCvi3NigVLkDt+h+zeUOaA0ri6gKONqLnom+R7f1+2B+7f+VGxTN/D
         zKCP1KZsFGT/7J4V6TVgf2OFKIec1o4QjwaPWS14XjnkwEfs0OOwkWSi0bls2jQH2NiR
         cXOiKpHhplIq7rZcOnsxaAMkszK0yWghPEgVszbQxMIdqXrgAV0/VD9Cv4eVQjEkXD5l
         yHJsqKXbuOQPg3UZaTdEFIW7uQCM6fKwaex6eG3HtBhJGDIevqo+Pl4SjQK3/zFCspXH
         wt7/FFSyjphzJlsnRxcEidhmdocrPmgZvT9Z3Hiunpn2i0h/LSZYZwPKO4whF2Bht1FW
         mCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322645; x=1779927445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JB8hLxgPFXR6TxheosPkUZdcss+SaUcFoZO7z76syt0=;
        b=SXccTgGMLSJlodQtsvn+Leq1ezBXSPO4jXWq5GrGNs5KoOczwv5EDk7+9obQfefqfN
         CsIZF1aa/uEaoPn/d3dMzyjnF6/TeO5vyqzSlZyeGCDSlyy6mHVKaot4iofzaHCLwG5q
         p+heG4IQulXpupCBh2NdJA8ju/rBcCwVdHnfPLH3xJzU9H57XR94FTaa9T4uv9qDxzia
         bmA8uSmTFnBKbEvs1nzuZnQtSlU+f8vcIG3MiXxPsTAMEy8yvEP7F0JugGmv/wmJn73m
         0ChsFyDIW67pliss9LWBkORnPlRdRw2Ex8VbzRNW0xwtaLNjrpInI+urGc1GXcLg/Cv+
         QZxA==
X-Gm-Message-State: AOJu0YzLpD7dNh5c4OsWFNcQrcNCD/0dacMVIiKUyLrM5aINgq4/IXaI
	gMFf4TCflJ8eq03xvgvgF9bT2v3OMpSeo6cLsR4/euTvp/RDCF+K9mPCspivC8omluc=
X-Gm-Gg: Acq92OHtZOO2E6fckvabub7xWtIb+4zYV3/BMTE0tpz9oAzXZnYsMbH488CfEQTummk
	QxYc6nXEq+fuirmtI/9ICaKamVplCL9Uo1mja7Ub7Ntx0VMhtYUp6znRuYolnySrH2/HEJK1mh4
	hutHBfoN8IFYCSg9zS78jV8Q42r5zZ/azurqBs0KFX74L1NfDhjVLjs83Svq9u04+TLrDbMOabo
	2+70/tyLIM7F6y5oje8UkeTPc+40YFQEd6SDzlDHI/VJu0En+vPEb1f9qbdRyfzlxjV+Cp0iuw9
	HfSUZrOJ7bus3oIvb5v5IK4grjFi9F8AmuzGp28elYGCghdDs/cTI7NdAA+N2ST1Wr6DSZsEo5I
	OQOeGPjPf9Um1SoO7DEo6ZgQMwFEhXg+RmXpcRolZiol8xf7p4G+ElQiWEEItPbWhIlMk1Zd3qu
	pmFZtJEFYUs5qpclpHSoRcJeECzNjl09pWPlECSJg4jJk9nKotPx5fcSviqNrcuJLnIC463tm1x
	LV/kqH4MsxwV/ApOnm1/o8VVWnRd1Mwn9rKqFdDGWUPOLbdPlXpQ1KhhQu6XujB22/1RBoz6LX7
	taH4hsy30b5fEOjNeQ==
X-Received: by 2002:a05:701b:2612:b0:12a:b3c4:c3b6 with SMTP id a92af1059eb24-13632e44d5fmr243724c88.21.1779322645008;
        Wed, 20 May 2026 17:17:25 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:24 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 2/7] net: arcnet: fix typos in comments
Date: Wed, 20 May 2026 17:16:14 -0700
Message-ID: <20260521001631.45434-3-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521001631.45434-1-enelsonmoore@gmail.com>
References: <20260521001631.45434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290160-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99BE459D3CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ARCnet code contains quite a few typos in comments. Fix them.
Initially noticed by inspection, then augmented using codespell.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arc-rimi.c  |  2 +-
 drivers/net/arcnet/arcdevice.h | 10 +++++-----
 drivers/net/arcnet/rfc1201.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 53d10a04d1bd..fb3d3565aa9a 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -185,7 +185,7 @@ static int __init arcrimi_found(struct net_device *dev)
 	lp->hw.copy_to_card = arcrimi_copy_to_card;
 	lp->hw.copy_from_card = arcrimi_copy_from_card;
 
-	/* re-reserve the memory region - arcrimi_probe() alloced this reqion
+	/* re-reserve the memory region - arcrimi_probe() allocated this reqion
 	 * but didn't know the real size.  Free that region and then re-get
 	 * with the correct size.  There is a VERY slim chance this could
 	 * fail.
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index bee60b377d7c..f1947342d67f 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -137,7 +137,7 @@ do {									\
 #define TXACKflag       0x02	/* transmitted msg. ackd */
 #define RECONflag       0x04	/* network reconfigured */
 #define TESTflag        0x08	/* test flag */
-#define EXCNAKflag      0x08    /* excesive nak flag */
+#define EXCNAKflag      0x08    /* excessive nak flag */
 #define RESETflag       0x10	/* power-on-reset */
 #define RES1flag        0x20	/* reserved - usually set by jumper */
 #define RES2flag        0x40	/* reserved - usually set by jumper */
@@ -166,7 +166,7 @@ do {									\
 #define RESETclear      0x08	/* power-on-reset */
 #define CONFIGclear     0x10	/* system reconfigured */
 
-#define EXCNAKclear     0x0E    /* Clear and acknowledge the excive nak bit */
+#define EXCNAKclear     0x0E    /* Clear and acknowledge the excessive nak bit */
 
 /* flags for "load test flags" command */
 #define TESTload        0x08	/* test flag (diagnostic) */
@@ -194,7 +194,7 @@ do {									\
 struct ArcProto {
 	char suffix;		/* a for RFC1201, e for ether-encap, etc. */
 	int mtu;		/* largest possible packet */
-	int is_ip;              /* This is a ip plugin - not a raw thing */
+	int is_ip;              /* This is an ip plugin - not a raw thing */
 
 	void (*rx)(struct net_device *dev, int bufnum,
 		   struct archdr *pkthdr, int length);
@@ -257,7 +257,7 @@ struct arcnet_local {
 	char *card_name;	/* card ident string */
 	int card_flags;		/* special card features */
 
-	/* On preemtive and SMB a lock is needed */
+	/* On preemptive and SMP a lock is needed */
 	spinlock_t lock;
 
 	struct led_trigger *tx_led_trig;
@@ -299,7 +299,7 @@ struct arcnet_local {
 	int num_recons;		/* number of RECONs between first and last. */
 	int network_down;	/* do we think the network is down? */
 
-	int excnak_pending;    /* We just got an excesive nak interrupt */
+	int excnak_pending;    /* We just got an excessive nak interrupt */
 
 	/* RESET flag handling */
 	int reset_in_progress;
diff --git a/drivers/net/arcnet/rfc1201.c b/drivers/net/arcnet/rfc1201.c
index 0edf35d971c5..f2ec58d06fc3 100644
--- a/drivers/net/arcnet/rfc1201.c
+++ b/drivers/net/arcnet/rfc1201.c
@@ -235,7 +235,7 @@ static void rx(struct net_device *dev, int bufnum,
 		skb->protocol = type_trans(skb, dev);
 		netif_rx(skb);
 	} else {		/* split packet */
-		/* NOTE: MSDOS ARP packet correction should only need to
+		/* NOTE: MS-DOS ARP packet correction should only need to
 		 * apply to unsplit packets, since ARP packets are so short.
 		 *
 		 * My interpretation of the RFC1201 document is that if a
-- 
2.43.0



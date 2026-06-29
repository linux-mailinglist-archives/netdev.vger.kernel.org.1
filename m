Return-Path: <netdev+bounces-302807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XU9wO/y+QmrWAQoAu9opvQ
	(envelope-from <netdev+bounces-302807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A96DE27C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:52:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=K2cHa1Rh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302807-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743FA3081116
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6CA423A65;
	Mon, 29 Jun 2026 18:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54D41C31C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759036; cv=none; b=rXrb5D/tbMaxFAyZuJQzjYyZF55IcGuhgLwOeTEqyXw90tvJOHw6UqZizuQAX2Pl51qMyOsd8WQPk8aUD+2iR2m0mVce8x70aqBTgXlQhgXNnUlPDeiXg5gHTLtfGihLh4tkc/c1ghRNU6/Yg1rGKRGV1C1uCM3U1DHHoJLh2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759036; c=relaxed/simple;
	bh=eNjC5uLH3iD/PZIjQtlYJEpug+Hg21bG+DMCzF+FR7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2144QdW4BFRqfoEWwo0AhqaSkVdnxsEtYwSAv+mlruUj/MHVlELGYUusjw9oSusW03rPCHVizqS2cYYhsP27aacIVns3utCJliwmfxUoaajXxyLt/8kE7bf64DHlFg/HXZt7PAeQRMNzCpvIdCaLd0MZgh0bGzT/3QLbZOnbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K2cHa1Rh; arc=none smtp.client-ip=209.85.219.98
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8efb708b1a0so17909346d6.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759034; x=1783363834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJNguK9akImV8lK82j7ByChpMDHPYd8i6dcAmIH/J9c=;
        b=kilKylnEmlD812hIvoUm76HzSb80qgKAePmsXgBDgsBmNM19Tb/UwYd06sjcMItSZT
         tqtPRtvIeN0erFFqaC88aAA7ViqFsChOnh6NHW1h/hCZLAg/gT11hn7i6a5xq9gHPNc1
         fb54dU2hbJPQSqJGPem0ZCvln/P0xAr3lJbP4Rxr407bVsxDlyJX7CvihLYRUC06zi23
         QB8NzVIjWPkkIwbfkt14mAT5Ex71Kn1lcQuFWeodknQylCWSzeAJ5tO2GxTORFkQfAuS
         pe84dHLxXcnne2z2A0xLt8yLGzBrHHgYSPmz7C7dR5EiSx5Og56ILksjJcTRITC/UNE1
         3K1g==
X-Gm-Message-State: AOJu0Yz/agp3dxNVlNhVMmy10/zSBNTff7q1Qxz7LNjiZUjwfoeWSd/+
	N/AsVFOGuPigcMAvWB04OqPc9F5ylMCalOpGy1b6HhriRCgSdAazT3jk878pd8yszgkUhEgk5/8
	SreEvJU6OcTKZjKiu08I2vG5t4teZ+Y6+EdO/flgNCivM2lU6AXHZp9ZQxQ714PG/VbjPYm2drq
	m+yTponPVpISghot7tU9YPy8lb4QJ/T66wTXscI/an502eBpZJDNaJACh59JLUJtlqyD7kYSnIF
	cHBc3ru89s=
X-Gm-Gg: AfdE7clOOwzSsNwkkKwe5Vcvri66wiEDwHmWSBAMA083TP4geleSkH8ffxW7D5Fsh86
	ujRJqOgBzA44mzoNgMiojnMDPwrlkiTBJaO/oNP412HW0eizWU51DKe6WwebzAUbiDAu83vL8Rv
	SBExeDjuysYvnKIXWVNNA4XOnFYJCd+0wlFoGotEyOZoZZFkC4BUAeMYUHSj6ba3iAheUAhRuCB
	fucbXNtt0xeIjPz2BaF1ZDwM0OfM3ls60ZdL6Xe6HT55p1cQNn8C2II9G+noPJnkt4nVoNiJHlG
	lBr6L6b+41bU25sLYfKZicceHulb6fUXyB0sYzm9tDFRbA285AqhIO/zihxK5ILivxR3VtloHo7
	ZCUEGC04BiEFM7eY+4aSSbN/8wz0kpMiRWhtlNnYt+/tzgBO/19hlF7ud4AG5hZJyXoD4Qr3BI0
	HEY3LeXAZbgNHJBO8Fi+qnPMPJbsjI2opobI9sOipJRxONpg==
X-Received: by 2002:a05:6214:f04:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-8f1b9fc85e5mr8495726d6.8.1782759033503;
        Mon, 29 Jun 2026 11:50:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8f1a5387e0csm440656d6.15.2026.06.29.11.50.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso13996681cf.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759032; x=1783363832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJNguK9akImV8lK82j7ByChpMDHPYd8i6dcAmIH/J9c=;
        b=K2cHa1RhoDw5YjW4PaqktaguPIF/rrfv9qcCRmNly0hEH18tbMMuoQpl4kZ2+vRtYW
         m1tz4bGB5FfgknQ9rkDVqNuOh9hOOUJaqhXwuUg+eeL27luIJ818ESYynCplZTDys5xY
         1tY8Kxgk0bfJv/3VR8uvkKbiD94Ak7Zn3gcWk=
X-Received: by 2002:a05:622a:2599:b0:51b:60f1:6895 with SMTP id d75a77b69052e-51c1073fe7emr8046601cf.2.1782759031863;
        Mon, 29 Jun 2026 11:50:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2599:b0:51b:60f1:6895 with SMTP id d75a77b69052e-51c1073fe7emr8046071cf.2.1782759031204;
        Mon, 29 Jun 2026 11:50:31 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:30 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 14/15] bnxt_en: Add support for inline transmit BDs
Date: Mon, 29 Jun 2026 11:49:20 -0700
Message-ID: <20260629184921.3496727-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-302807-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 727A96DE27C

Newer chips (P5_PLUS) support inline transmit BDs that contain extra
data.  One such use case is to transmit out-of-sequence kTLS packets
with encryption enabled.  To account for these inline BDs during TX
completion, we add the inline_data_bds field to struct bnxt_sw_tx_bd
(tx_buf).  tx_buf->is_push will always be set when sending these
inline BDs as the operation is similar to push packets.  tx_buf->skb
will always be NULL as there is no associated SKB.

The next patch will make use of this feature.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 62c1eea01647..ad6c8644e09c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -848,7 +848,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
-		if (unlikely(!skb)) {
+		if (unlikely(!skb && !tx_buf->is_push)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
 			return rc;
 		}
@@ -860,13 +860,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		}
 
 		cons = NEXT_TX(cons);
-		tx_pkts++;
-		tx_bytes += skb->len;
+		if (skb) {
+			tx_pkts++;
+			tx_bytes += skb->len;
+		}
 		tx_buf->skb = NULL;
 		tx_buf->is_ts_pkt = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
+			cons += tx_buf->inline_data_bds;
+			tx_buf->inline_data_bds = 0;
+			if (!skb) {
+				/* presync BD */
+				cons = NEXT_TX(cons);
+				continue;
+			}
 			goto next_tx_int;
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a726940a7014..1a34e334bc18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -917,6 +917,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			is_sw_gso;
 	u8			action;
+	u8			inline_data_bds;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
-- 
2.51.0



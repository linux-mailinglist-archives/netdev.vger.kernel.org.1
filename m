Return-Path: <netdev+bounces-287322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULwUKueaA2o78AEAu9opvQ
	(envelope-from <netdev+bounces-287322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1E52A415
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51489310C2FA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB13381B00;
	Tue, 12 May 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XKcEj0+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D33803D7
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620924; cv=none; b=aPCIlpO39CxpriKZj+uCRnchHmjloSg4e53ndO/lGMPVD3yBHbWzkMrZC+/G6x0FJiqcfda5JdxoEdUx/WVM6ummuVOe8sc/HLFMkoqVqlFaS3krXGW+YygCBK0MS0evkqMqABDPzeBrsBfcrKNrOXsERGudufunG2Q+9ga0Ki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620924; c=relaxed/simple;
	bh=XZ/Knxp3l5i6rB3NbEp2kUZP+nilCrHdTxDVlg+yiMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAHyN7Gtw+mo+7XExvPGP47X7QNHtL/BdCulzTdBkINrGpi4SbyrIIeyixtvmhFisqWdFVo8cQawhJ4VBpEKTLTK6tMEpPuZ6AU+QQElRTWzzg4a/kVRP5sx0ANTzH544cO//HzfVE7cWsNALWtRo1/EZsVDo0QDmsDgCjz32ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XKcEj0+w; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-90d2acb9936so124414785a.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620922; x=1779225722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3YxazkQEDn9UMv8up9LpnGm2yGMYAtYAUmv1kwoU20=;
        b=lnFyNL7hu2Qbxs/TW1WNbmLVYCyD9EeWwaQDgrr9KhWO8eYu3jom6e9j1t7zOYo7pw
         vSr5y+xoBl2ABS+ddSZE05CxodIXBFOASI/z3Lqb0T0eNAUMIXz3c/bkflg9Xlv9cekx
         r1okPu0i5avEF/7TbY/eXo1F6h9luAM3MAMRwO8+bteEUURcquryOTKhPW0dwtup8fKN
         XrNLPudY4sXKqicHfHbwF27lWle3Y+IYEx98RoCsL0bqX5UIctU6tUEG7RHa2BQyx8sr
         Z0NjZEYNoN+Zk0MTxcVIX+dPjpuFrFXSC1lGsxdQofuBsOF/dQSJO9oIJkpL39uKBX8Z
         UDJw==
X-Gm-Message-State: AOJu0Yz+mArWALbFqFJZDTfyOrqivm6MEvBljr/1S50ha/pHVpsiXV8Z
	oL2jpXQAH7D69dJJQGSumy/PfYYze3kxHjZog2bmmHDCxydw47wg+4nS8fRSR7Yl/shAYNaj9zb
	7F15+Gq2K54c6Wkqt7rj9bLYr+7XsGvoXn/VgOSweJnPUjHmhbESgpCrB/4WPkauO7MVusksShs
	c86/ja1D3xs7OEXLFmRKFrgtW+ydfCqRgkCdiEZ3LDjMVmDf64d8nET/Qr0Ad1m/xJAOkow33eW
	QeOiONa5js=
X-Gm-Gg: Acq92OGYSIdGa1hNPURs4GTb8taJMh4lMohsighRCJIbyyGZzPPXfBlu+D4yDRQlg4C
	KAzcY4LHW/8RGTh7vAgvjVSkXCr3UJ+Ebgl+QTbT458UmVRWE2uDovUS8SW8NWg8x6iIYTILHhd
	otFFMFjJmFkSKhE9XA7x3IJ2Gz3sFElCCxu7T1GrnZj9YZJEOj8EPHOVHDNfZS+tgqjYUHaI8g7
	r/ty8txUmIoH+VcorSgyTmmYL4F9IgWPpfJ4Po+pZCSGDH8PWGHWTDcfHBcvALW2iQWDOg6Soqe
	ZG1eBN3chNE0YIVu/38B0bv2WM5QmHiwxYv4bYArDJt3ty9oluOefAOC0cJ4wa7uWl0uLqIh7BS
	l+08l3sl93IZgVBDC19BqGp8i1SeNdtx6e2m/eaELRDO+xIT2kFjkghl21q19/bToZVU44JQEkX
	Perfihg+jCjV3z+Loq6J7r9Yh1oEOaBA6LJc31xKBRnKtDoW12O8ugLXKk
X-Received: by 2002:a05:620a:3942:b0:902:e187:a70e with SMTP id af79cd13be357-90fadd5e0fcmr26398885a.56.1778620921603;
        Tue, 12 May 2026 14:22:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-90fabbfe7a1sm1037985a.7.2026.05.12.14.22.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:22:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1306c2f7037so6219508c88.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620920; x=1779225720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3YxazkQEDn9UMv8up9LpnGm2yGMYAtYAUmv1kwoU20=;
        b=XKcEj0+wN+SpNG+MUJPYhbmCOSngGIIt8qQFVUuqX5eEIY1QRLmfeIJCdvyYI8eJNc
         NCOqyac1TjQosDuTMPL2VOLdQAKHTRjieO44OLGkCO8cUkRk6/6aBgid108ADJlRmzht
         qyH9Ke0WYVKW3TasGZP6Qjok3Efrov8Ae1JDU=
X-Received: by 2002:a05:7022:1284:b0:128:ca83:5aa1 with SMTP id a92af1059eb24-1349a9312bcmr75209c88.16.1778620919673;
        Tue, 12 May 2026 14:21:59 -0700 (PDT)
X-Received: by 2002:a05:7022:1284:b0:128:ca83:5aa1 with SMTP id a92af1059eb24-1349a9312bcmr75187c88.16.1778620919082;
        Tue, 12 May 2026 14:21:59 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:57 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 14/15] bnxt_en: Add support for inline transmit BDs
Date: Tue, 12 May 2026 14:21:04 -0700
Message-ID: <20260512212105.3488258-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260512212105.3488258-1-michael.chan@broadcom.com>
References: <20260512212105.3488258-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 54F1E52A415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287322-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 7cae7e3024ab..89c900db45ba 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -842,7 +842,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
-		if (unlikely(!skb)) {
+		if (unlikely(!skb && !tx_buf->is_push)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
 			return rc;
 		}
@@ -854,13 +854,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
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
index ab3a86634a20..e0880b8c4b73 100644
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



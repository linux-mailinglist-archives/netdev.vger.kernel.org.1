Return-Path: <netdev+bounces-274272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NVONZ+szWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDD381B96
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E07C3014970
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC33F0746;
	Wed,  1 Apr 2026 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="pZGUjFtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7A38423B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086680; cv=none; b=JtWdnCv39KANIWhq0DgbHDcDnPFKrdFPVxt9ITlcndiTvzwN6bjYg49KKmC3Wz5Hi+VDu81tYsjVQasID8V+roII3hOMHnJXb75J3eB+yS05dnNYfG0PASqEsd8tRNw91YlZkT+I4iFxjI56AtT+R7f/ICdUCRr8HMc7xmK9m5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086680; c=relaxed/simple;
	bh=d2rya2g227s0mOgCHZLhT/Jc5T9CEEjdfICOP2Htdp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAbhlvscvpZIGKeUmCKOshKd+jr4wFS27fZHkcWTRtoO5KPjSu+oJlnvo32i51UQr/HrZ0FN+KqLvdCQtovsynFeql16+56herihmQ0btFpJgsQ3LyN2wgQrC8kL3idQJqJsxQyrTw44Jn2du/R+fk4WKfOO7jLl/5nqFPHX/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=pZGUjFtO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82ce09b4197so118379b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086678; x=1775691478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQV6psvUVgK5CgQiXG3VYh+xP/mkvkQLPuwwhI8Z6M4=;
        b=pZGUjFtOw+6Y/R+lXOLMd65oMyAl2Pqv92KelEU9iJH4JnGMznJ11iAlYPFoOcUiR1
         Li3eACkoeFdU1PdNCzp8kJW0tCMbSw1/1yA/LhH0vYN1FQTQ4lmJguQ5M+Kq6lw3XujV
         KLS0oM9BgTF1VDDBpsyF8Nwr0mXRmgwgyOE6aS/coWVFvPD4PSoQDBB+aJpot5t+66Ty
         iSLZvCPNLNrFzFbAFv0L8vPTkBfTwMU8I62Cdoe1Joa3ezeuqc78ELwn/7RC+CeSoLj3
         mALuZRXcIXT2lNUR+FOt5mTDP+Q+CGP2LgYvgm4fJft0RCLUMgEDgU7yJGqgzj/4wYve
         y/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086678; x=1775691478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQV6psvUVgK5CgQiXG3VYh+xP/mkvkQLPuwwhI8Z6M4=;
        b=Rb4xWZypMQl89c+GQ/5lNZMSSRVuArATm67jQ13wd+XbY0mUZ/1fK/iiJh351s5m8a
         J0pQ9MM9w5IH3ZZCCEH+z3rDYYnFCBfSfvKkQHKyfJwc8/usSIGrS3SNbFkP2x/SdZk/
         Gi6qeP9wDJ1TpmI95hkQCFiTIpdxBoelSgmr5jPh8sYV3akY6N+cGS+35hFJuMDV8Fac
         ybf/jMSJ9eM9JGaKAGes3BGBUuEQFt5n3B8kHaq/ubJStnyCtQJPatW0YLYfUBEHiYlt
         GqRQy1LoGiHVd4nOyqWINY+07FJS55ZVPf67kkjip8XjirmJH4Nypv3UnvQH+zDymk0b
         FSzg==
X-Gm-Message-State: AOJu0YznLZC1iOAPG9A0IwBImvK40HRqsKdv8fOeIAEqggE/ZGteGy0F
	bKDjTKq4Wz6re7D4PbpLtGQu7WZmsMkX1vMKuxWYv3u719VH88ld+YXFg7Lb3M3eM3seKzRNuDn
	9wUq09Sk=
X-Gm-Gg: ATEYQzwfalJ8b1nczfGsjI9wHnaxW/W/p06tfTA/35IU2P2JceUIYgMnc81XePaBJUA
	V/dtf+tf41rX0VZkAIPn7V/d2P7PmUfZtc82SCjYTdOAGAYPzn8VeRuQRF3mpFU8p7zBhuYefOR
	Gh6ImO8TTYUfHAGS5cEMAz841+fo5BdjzzGdcdaMMlCRDvpcM66tVAttGNJx6MLh/1kuJNsVfck
	XVY2oBbX86m06jNbMGMNzvrHG6tQTGlpdDYxKMUzz8SFplLK5h5uiDbAnQEe1MKvNS42S6hSxuA
	SeK2QJBbhjTOMUXb7QRxK08WnPDrhoucRompbctuwKnGTsqlY9hFdzb1jco3h8nokzoyl/3q7bQ
	gNUYHoxTh4JT3x858sffBOQ3hNJM6b3RNaeK2chawUGS7DwQo9YR5TOAqx03LQ9765XOJvVBMy7
	bW79o=
X-Received: by 2002:a05:6a00:1405:b0:829:780d:99c9 with SMTP id d2e1a72fcca58-82ce8ae50e8mr4989900b3a.26.1775086677829;
        Wed, 01 Apr 2026 16:37:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c71e62sm939551b3a.44.2026.04.01.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:37:57 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 02/10] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Wed,  1 Apr 2026 16:37:30 -0700
Message-ID: <20260401233745.2333858-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274272-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 75BDD381B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ec611bc01ee..a6ff234c2864 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 30efcfbb4791..ce7291c68370 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2969,6 +2969,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0



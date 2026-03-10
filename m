Return-Path: <netdev+bounces-266335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG9lMP6LsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47898258397
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFC5E307B67E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E183EAC98;
	Tue, 10 Mar 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="AXTAF5ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4613CFF41
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177771; cv=none; b=lGormbju1VFhRBYMPxbVkCkUNoKDvy7feuhz3aN1qsicf/sxzgWN00m2NzhLfB6jNLvopfzkyiH68yfsTOtiquWFeS9WxUenUfVSNzq761A4LdS1dL6qliLX8c0yZrUqHYv+CNCs7Uw6wfWkpqkjJb6PqhnWF+CpoGNTrtKrhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177771; c=relaxed/simple;
	bh=+GtcV0YFOuvWw7iJiSWBEJ7HxYlIrdtSChqxKZ1x0pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3TtH0zNYdnM8PklMMGwkuJwYXbRUIhZcbtNdkJZoa+mg5m3Dyp/mSih9Gle9GlomTlVBB3ajJMn7TCDd8lac9BXWnHzbSJS0llzQMJdFWat1MWtMmQ/+ORYi6AJjqWjglbCwH1yXu8aO5PKccLM9/cFf1NWFOgvorqiMU7hS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=AXTAF5ek; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829759ca646so3569269b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177768; x=1773782568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsp2AL8p7AgDFcNjxBW2R9vCk4D/TpG/eONaogdk/ds=;
        b=AXTAF5ekhUS0bW96Y7oPMRT5x6jTeFmPX38AwDKCQrYvvP0mhJXsANxgSHZ4zdRRna
         vHbEj8T0rQt7NBvlVd2p4mJhK9I4FN+YtEoGs1nltBbajCP0OXji6Oe0ngHxHqaGoy6C
         /uWfQ9a3svLJZ2pBEfVtuCihtq1XaC2zi+ceUFpBCWqobEhv5WKpYc9iRpEepCRBqUOt
         QoAJ+56CU//pdWUSdfJj+DDai4fDGs6UYLaR4Q/LlAt7bbnQY65Hd5S5DEX88WQHJEP9
         BzzQVkgHl2qbmAY1SPwqJYppYLONcc9dmwUV45pIQfxpx755MwnKLkNOng5/1PJhKNKc
         69og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177768; x=1773782568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zsp2AL8p7AgDFcNjxBW2R9vCk4D/TpG/eONaogdk/ds=;
        b=aTePbzEygwLLG7NI81FDamaaRme4pUhTZPSsexY9EWgNX7APTm8RvFrsnbvvyZ6CKZ
         /cVcczn7GfQlP0FmksD0Bx9HDO6U+RA+n/7FGc1QjXi2+tBKNrAMdFuQb8o2MGlLK3Y1
         hR5fh0tlcmblXh0zQCdsuQBw3es97vi53kWwVGjzYdyKtWlGUs5w9ihHKN5qJca+hpP4
         fzZ1JT9n7q/Mcf7aY3USACG0S2+Hd8Y5JceDxEAMorAbu3CAu1AD0+Byr2fpwupwmK9u
         WFWhDKk/A7sqsjGcUPqPkKCGu9f4rgx8XA7EC9WkR/P0oqIKYMz6Xm4ARj1sDELfxq2j
         uA1w==
X-Gm-Message-State: AOJu0Yzx4pMU35WeRCsr6vESY1txy4n2TxK5PML7DVjpEQk8j1UzqjhR
	4EphbBho685LjzHSPYEW2iq+rLmAaQ+Dm4tJJWj5+LswzbmcNHAZjnRetgwwJhpsfe1b9zpE5KB
	svVraCus=
X-Gm-Gg: ATEYQzx0XRLZT5lQdWB4SuVLv2VJ3JbIU94UH7sJdk3EYBdq5c4dzOXhf2N89hRX3qC
	rukRlaziDYC7Cu3pDMnbHHyIbUqJSKadt9MhavMrw/gAMYk9YAuKqYC+eFWdbIhE6klO3cPc5M2
	P4lx4sXp2NlcIDEk68SWv3aj+fA6qFYIOxdRkKkMHb6G18IqpUp3TeK9CA//XnW/rxfiivCcNcy
	xIPYGVnJY00QDenXqFEJfQeKhw0HuYLxJSpIWEH5zEWU56kP8zl6eNw/nX2hnVvZEPiQXK1oEIr
	7z/ejgj1QAjMqMLZN6mdcCaTW2+KtmI46gBx09d0CWfboQo6bfisEtrmnZPH4+4d9crdnYAcZj9
	BpWL9/T1m4ktgEGr7qIsl4DVyy7R8BYoUsQ6nuaZ8Dk3sfAVvt7n7KkX6dth5zJHsY0PWY8zhkn
	vcdAE=
X-Received: by 2002:a05:6a00:2356:b0:827:3310:fb18 with SMTP id d2e1a72fcca58-829f723de6cmr282496b3a.51.1773177767706;
        Tue, 10 Mar 2026 14:22:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df87bfsm193051b3a.24.2026.03.10.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:47 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 03/10] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Tue, 10 Mar 2026 14:21:51 -0700
Message-ID: <20260310212209.2263939-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47898258397
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:mid,dama.to:email,dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 84095d09ecf8..5033aab2d3a6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -445,7 +445,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 663708fd3cbc..48c91cdf1975 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2936,6 +2936,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0



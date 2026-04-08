Return-Path: <netdev+bounces-276742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOmLNtHf1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:08:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E83C4A90
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51E2D30532A5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90E38946A;
	Wed,  8 Apr 2026 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="qc1S/qEH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288E3A1CE9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689601; cv=none; b=FJbeMaUcKag+FToo0xOdUs6rACM1Qhnp5YQm3Vh+bWBwi+/h9V+C/68QakG2ZJ/QQ4FRZNIBsJRYKNB7gnyw7Mw3NdLCYDkyqEHJRThktBUFfQ16K0VQdwr9KNKvUMkR7B6FvNjakXKOtBcBwTmyK3Eja7cypw6iILae2Tn9pY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689601; c=relaxed/simple;
	bh=ZEmHHdgCIKjmFksdw5ABxjeqzQWen/sEYMEcE4ycvlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTLUPMk4FYqLmkOR8X3N3MZ6120AoOdwNgBbCEItgxGEnH2oCHewgR+jNZCCSTh8d6cI4FpDjgqAGOIbDHzgyDF+0Iw0QqGmY+pNpokhet9VVT3xknA3BbmuREDZtXowmbzJHKRrZbV840gsz5Hm8fXGNqoLVvBmmnoqNpWMSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=qc1S/qEH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b23f90f53aso3338505ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689590; x=1776294390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8bNxSkLagGjMoaapqryA9wYOiBX4DR7keg4lmWMnD8=;
        b=qc1S/qEH6ySpkEXXLMh0uPY5aq1ZTBmF7V3y9dSYb/GdRIUFA7SiqD9lvY+FH9MXmY
         98VonNh6Q96Zb69zwB4YN3DiYB+MfklS6SK0Eu7LgQcQZEgsWJ7V85fvqBUwqRgGDCfV
         z8qE7WVbHFJr95p71YzgOXIwVGj2CP/HkwzjM+kOcNBKlAnki9sweh0uhfrpbB+8xjm9
         5CBSH+W3kYhCIlpUPGp2F/6cwr6TWh3DqhivcKl0XTu1d5Pgl5mHbU+lsEH9FVnxxTMS
         XJBqVn2oNwY2DTnclBNbO6eYY23deTWhkI8Pb2R12qOX+cXDEwn7/87Nj3ESdXfHgDy7
         rrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689590; x=1776294390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8bNxSkLagGjMoaapqryA9wYOiBX4DR7keg4lmWMnD8=;
        b=H36WOPXjJAkZ51WF5YH3ks9+cTyuuSrSvcMUDo3cCmM/YsF6XuH19IhaTob7U5VTIS
         KmU2cYoZXugfaJfj2kQlzqM2uCdDDzr/5s6TWR3rTIRr6Xj8mPG+D2Xy16HrTh/Xdreh
         YbKof5Mcl3erAnl//xpLs70Xm8zyIZsAb8QIydMJpAjAM+y8ujm3ihzsuImFPL/6AzxO
         T23rhzQHnoXFQUR9vNXF4FgDs5X9fPb6uUfOl5iomcAy+y3Ko1KDX7Okdqihb5akjaOG
         sb/M9nezDyNl4V7nGVch0oHmD5JBfhoRejj9KiJjzqx0N0f78rGjIKKP6luF+d9tkMnM
         PNaw==
X-Gm-Message-State: AOJu0YyWsAhslqPn5V9OQQUeb5B6xWxOglnoCORZbggxoFGHbpPwUpvm
	FNxwugQH+A5zSSi65Mdc1O6bkShAi4Jf8VZcWvPourBAbKn27RNZaFQdQVo3kuP2WlwGMkCNm12
	ErYu2dLI=
X-Gm-Gg: AeBDiev92bYN9RvpLtgHCclqfFOpUSKwUDQAA68BoB8Pn+1lYshEvrjP7hyGUwoBgWp
	cvLc7+Iy6wIrfuinlJd6gvC/v6011wtecHNl6UNRo3wSjQCrT3FkknzC4m28ce5/GW1PbOhppzW
	i1Izl5yH+SJRvZA7pLrygIK5floPGYcyk5/56Xe0s83tdgw0QtGAWu8vfaQiyf8wLoRCvD+0ldf
	pdX3aCWuOsdbylO0Od5wEcYwOh6LG9PajWQhxMm2B8tBWDx6Ta3fR0emAqRKif/+59VD4LehPZG
	/JcVqPpnjjyJiLEOjETzhBWeYdshDKlz7cRSTeV0bSlG/11tdt+BynjMs4pDZA/cPObbzlxaqxo
	L6BUuH5+YSJegV8i5X0G290tACrFGv5LZ178hM0quMdMUPXmn2UrYGcJ73FTvCBVBWNHqALLDqn
	l51RSlnIosJwW/sBs=
X-Received: by 2002:a17:902:ccc9:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b2816ca44emr266937355ad.14.1775689590308;
        Wed, 08 Apr 2026 16:06:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm211336425ad.75.2026.04.08.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:29 -0700 (PDT)
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
Subject: [net-next v10 09/10] net: bnxt: Dispatch to SW USO
Date: Wed,  8 Apr 2026 16:05:58 -0700
Message-ID: <20260408230607.2019402-10-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276742-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 577E83C4A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 26aae48a7d0e..2715632115a5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0



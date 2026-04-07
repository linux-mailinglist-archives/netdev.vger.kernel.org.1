Return-Path: <netdev+bounces-276188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KddGF9/1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:04:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89A3B531D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BF9D301CEE3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A037F8DC;
	Tue,  7 Apr 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="rymIBVDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA537F747
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599409; cv=none; b=Edka1aumAfPFRUc7h+fVCyXtHVW2ugDAebgt/EKdV+LK5UPAlhQKNDwWH/gqvTTNSiGDpEzdOZT93YwjP6U2B6sBpz9OsI1TpH8T9Qh+DsCKIF7mSKntGjCWIHZN/b8rorBFe+uu38FQa+/HsRbhVZmSqMebStureOFgBJoRG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599409; c=relaxed/simple;
	bh=iQ727465s3Aho370Tuxfm2rIvW+aDujPQFCVr+k8Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMFYFnCYhHWXqyT/6P2lB6lFJBm7SvFHoq/EMXrDI5sustu4Fx2nhlvPIs77mPo0qGKWgCVYlBsb1ip47C8BB9b+EfihQfVOYVZsj8llMA/RoUHTKRXbuVgouoIzkjvUQ3gyPKt4Vm228LcSC/PR0YCzlfGTMb6hufGrv/ITnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=rymIBVDN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b23f90f53aso49571815ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599407; x=1776204207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=rymIBVDNITZ+5tfuWYYdoS5xarPBYN7CyLLWn1xtA4IrO/baSQljV1k93rqPt6V1Ib
         9GcuX4wZiQuj/aKtpI5IpLzzQhz9vAMmBBC3CIejY9a10y1L7iRJ4NUiGMh3IUnAHf6s
         gq4Vda8yCtXpNvGp0WEUIFf/dFLb8gLOa9XY/wTDVe7a72CVwiN6TI5pKUntF2Z6pUJ2
         PryTE9r2zxFVWZbhzKP9kXMb+U4KwqExR2/vp/IKS6WAcoTi34r3Idroo4GOf4DISFiD
         FMZs18vx7IGAX7QOsbwCTnxhm/bYoyG/YyuxBko41cBRgoilq6DVt4vXFt2Qzb4bl6vO
         9RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599407; x=1776204207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=ap39EKw3RRVo9nJ8obV2uDn4jphDN97fz1INy0aebq+txT+At8qTwlkPu4Z8FpLj9Z
         VSIf55parPlEfrbSjX5A9IcGIwTLwufYPUYAdfmInZeHVANPV3t8bNl7CEjEPhQhHWSr
         A+27dKhfkccR2mg3B9cLy9+tDhT36XjOFC5vgDP1c6nT0hU45e7aUZKBMVvG9g8gsC/l
         1yUeIEtdCCzcMsyB/kWOYbQAL4v8cAdAn7idf8SrJiS+JP9XOzM3YRrTeAyHlVFC8t7l
         L9vvUAS57OlihhDmvRvhLGSh0QiE67p7w4iBQ6oJJ7PJv2aHgAbTWZn/Up/ePNVjCpTY
         MIIg==
X-Gm-Message-State: AOJu0YxHDG+Uf3zfiCxEc0incowrM2czx89vx5mzA9Oqrr1CISquT/lU
	ZfYymMK4HGHgMPeIUn8RZoyKUBRSKlbxr6LDOopi4vau1I3uTKb9hHiZtDbZyFLKgNLwTdTChHK
	Z//Ca
X-Gm-Gg: AeBDietPIoW4O2Rhee/U3+9yIcOwQYkniPMG56YodU9UUXqQ8ZTwN9Y5NhXrmjvLXFG
	fG5tb8tEVuRqaiow7jo0DIGsUMN5YsAY39uplsT0OpxJ3HNMXAEbm+Ki+JpfVJWAdjaHyqzJpl8
	Rs/Vq3Kz8La5xg8/uZfNTSd5kSTF6wwTzXvGd5p5ETI9+XbUNRAgqkjgQO20SKSWjpwEcXVvCvI
	qTyNqFz+LKIGmsOpOavGLeTlEAiVr612eUcMDWq+w7mVXwGyGud/Tt2YI/OsbmEM8dkjO9igCBq
	2ycNSZaAmiIIdFfOOG+bsg/oxgipcnvqZOrzqIbTcRfW5JYznN6rXxRVZlXU54ex1U36Vt2RKfT
	/jBA70y9jHd4V1QliPeIpaxwV9RF8WWrmB8FtDf4nVOIJ9jxdJQ0LLK6RVf4h81R+uqqmOXG0iK
	pHtMZ5
X-Received: by 2002:a17:902:ce06:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b2816d0934mr182992775ad.16.1775599407271;
        Tue, 07 Apr 2026 15:03:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c0f3sm190425905ad.41.2026.04.07.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:26 -0700 (PDT)
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
Subject: [net-next v9 02/10] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Tue,  7 Apr 2026 15:02:58 -0700
Message-ID: <20260407220313.3990909-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276188-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,broadcom.com:email,dama-to.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C89A3B531D
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
index fe8b886ff82e..d4288c458576 100644
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
index 3558a36ece12..2b40a5bd57af 100644
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



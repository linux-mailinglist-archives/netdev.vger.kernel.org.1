Return-Path: <netdev+bounces-269943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EIvNsBevWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:50:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F922DC0AB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6573330387D6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF403CE4B0;
	Fri, 20 Mar 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Qh1Y9TvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CB3C5545
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017734; cv=none; b=PwuehaaSLOzcvLOeGb8BNKb6RtLPDRWafudzVWxUXK9BRCgWfvjd7G+VxjyRh3RIrfbCQ6taIgdstyvOUBFE9W3tV5TyFXqmKpC1eR9lLY6miqWRR5IzCrwqk5tQapR7Ir3ksCRA8PGiFtE4vPxmvV63IwQokEwN9rzW5609obU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017734; c=relaxed/simple;
	bh=92aqkYJ0b5GlsxkwOgN+ntPd5LTvqgJxwBWqWknd7Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtTnxcrMPmlTZOWKMGXXwA4iCPU1SFQHfV4nNFsH+ApAdyDEoyLCj3SRDMvmxP/ykrxhA+XVW3IHYfGPWiMLazrnmqdiq4P1kiBqQWZSI5toiew7qptj3y8+ZuelciJLGnSiD1AR96ldlS9TjdvbtqgykWMuDh7s2GFcUpPWUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Qh1Y9TvF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aecc6b0861so11882785ad.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017729; x=1774622529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W18gZ6DTQpQ6YetxkK8bSGbSnx/tyFrgmhuV+UxdE8=;
        b=Qh1Y9TvFlo5ggIIrupO61GS9Iohp/YwZHU25TPDPI1TL7tpLOEpMuFvC+LdlMC/fqr
         VC3ycXq8fZSejd/MuUuzv2i0tVKUtEmJ3+oQvuWCZ+0PCThqkRzIkPj54/q7pRXfsEeS
         KPawp09SyfsfjfVaH4Kr9iWhc26eEC2t7SiWmZOz+g0GIV3k1t216N5f6D5WI8Z8pGnM
         sw+I+Poq9IIic+Xm7eRoLnKPOWQyxr3f4B2oOMI+XwbpjV412URqYpGZ7+AiDah4n/ar
         /XC/EoW/iSan3jXVKScpko82jegFy/qeEaVkUeLCMUya050AEzLj+0pQ83XjBbfgZhpE
         TL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017729; x=1774622529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1W18gZ6DTQpQ6YetxkK8bSGbSnx/tyFrgmhuV+UxdE8=;
        b=JYncr3Pz7JTlVn2micLElEzxTjl9yjnCPthApdYc9fqDQdaR6bqsQvLHq726/2Fb4n
         DQEES1zUfonvQbTVzB6ISwiX72a1Rt6WL9qSoJ/+Xti6FClCV4JGffOfvnarsIPF29SZ
         nhL28NUj2c7x1bATJEylUGowaKKxa6YE7KrE6hl0uwTq1W+nVECRswXhwhEwr442FTRj
         8Rmql9PWhoGq73MHWlYQ06XabYzNEaqSZZF/FXj30FM/qFF5n4hLZ00pGqh1FUDOJOaQ
         6Mb/iJSCMypBwxOB4kIh1ufNQLJ88Er69lqVi08LqREJXhm5h89x8TznrLELmsLhR08x
         wDaA==
X-Gm-Message-State: AOJu0Yx7/0p/TYkOyPiYLAF9hK6TcHpNCgieom3CrobaJrB2uIlq/T+/
	3BDO+/xyCM9d0YxmVN31ux4O1Lrnjcgk6JqxXU8U74Vs9p8+vgsQHGALnzOIqX/AkTiCctS7QLT
	uymOzFXI=
X-Gm-Gg: ATEYQzy0xCmCyz58ExTFbd/KW51HX9ptPGM1phx0DXkcJQQ0iPZMOHNhTcm+zdppEeR
	bRHQPJgBfNpX7Qc9lOsEusiLWd5zzOtf6OAxpOmia7c5a8xSxxgRiXkqqATEP819b481MfTxFtP
	73F0/EGLMEa+7DiLaI4vp1ZPj/yVfnzN096sL0CbfjTW+LA6/1D/x4i3SKec5C8564UHA4WhUPb
	eE2p6j8xL87n6YeVKvsfdNmxvtevgP6t1+hCZB+MfDvvHVvWRyIsIzBMPiOjQj2O7lOrj0CjkmT
	nq8Gej6ek8QkHT68Jy5PRXqbm1bxyUoFJRRtInaCy7QMekH9sse4M53kYaZ2kUmoiYqbc5YXAMN
	cb+G66MozFU7/brCdoPtLg02G0hZdkwWIJ5oPsRe1WcWpjGKUsvWfRI5CXZhabFj+1MWlAVnap2
	7+
X-Received: by 2002:a17:902:f605:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b0827db766mr29534045ad.37.1774017729468;
        Fri, 20 Mar 2026 07:42:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f90sm24692975ad.19.2026.03.20.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:42:09 -0700 (PDT)
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
Subject: [net-next v4 10/12] net: bnxt: Dispatch to SW USO
Date: Fri, 20 Mar 2026 07:41:31 -0700
Message-ID: <20260320144141.260246-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269943-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 54F922DC0AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d9ca4933ee62..5c3b3adaf701 100644
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



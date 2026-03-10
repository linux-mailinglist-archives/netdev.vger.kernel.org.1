Return-Path: <netdev+bounces-266342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNnrNb6MsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:27:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE09258424
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E343206DC0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEF3CAE70;
	Tue, 10 Mar 2026 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="1G1Sma4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DC3EE1C9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177789; cv=none; b=ZZy1V9F2ZNT+w2XZf2kFAYBm0AVC6bNk0+6SWBeTv8tEAu5AfbULAafgAo5loxf7v3tSNw1kZMdisTOwl7nTaam/MFi77MZ2owkY3eBGabORvIVRv9rQNOjxZPV0RVeux9/qTawGpdhacTfiL7H42HBwLgdWb8wS/238o6pxhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177789; c=relaxed/simple;
	bh=4pl2X834Ki+65pFAak8gvu/02cfVhH7h28ap53FwqVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM/214MoH10vDeJZQ94WdxVq5Q/jRP2qIUC+Q3tCLZ6zg6Fh5L0AIaHRpG/W/nM4AsVwihMdT7QhRc4rYLYRBpN9ZYVUJWfpmwjjVSc9CI/3v1HGyd61JqbKNJCyMwEWjqdWKlyi4oaGKvxfqT7z28G+KHBOb1jIAhko/YTZzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=1G1Sma4f; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829abaaa92bso2273462b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177780; x=1773782580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABX/dNXYvjh7NZFYOV2OPz3Z8fQKAQKA9c431nqYi7A=;
        b=1G1Sma4fBugbOU7gtRT1OwIb1ji303o7ELRpHy3UVZugKGEfOnOh5Aq89CawZNpQMw
         diQWKa2L9nirnbCO0POM9z3WB/+Z6hjn6oA0m+Ns0sYucSURMZ7W/cly7rdUXRWmKl50
         QqZTeOw1lN5/hQIzAsx6xNLcjITra+a9S+SPSE74rK6DQ7BN55EoZiaOBpZc+KU1mjGP
         Nz438uavmlSJhNPe+yoUpA+HWlKM0S7X5rBG5g4vOuBSu4H07lOEsMIUSsF3T4U1QHsi
         Lnm2IFYoi/mDyfpQ1rOvsNSRDNZql+Ek9jlmRDzWX2eSz9KpAo+BYbc8oFdvmSWQjLvl
         1TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177780; x=1773782580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABX/dNXYvjh7NZFYOV2OPz3Z8fQKAQKA9c431nqYi7A=;
        b=Eb8OZAZYUjn7xALKfhSdiI8Rj8IBLis8IO6FWbO2J7lOjGr63nj0tgQOD+6AnkUeMF
         Te8PZgS8zEtE2gJaPE4Zkk5UPbv5DWz/xbs4zaTJCibNx7Fh05szho/4+r87lAUQOhUc
         5RM1YaKekuKWRzAEQHgC6ucxynYiosPE/imeTJWCLE4AOyawKObVOvqwsRz+0fFSF379
         9z0xzMKmX8bAZ8UN4+MTCTh3Otw4HlFK0HFwYFClu6EDAZyVoHiqQve36SsR/avBy2D1
         vqwmv6QNnnou3oPLLUPzVXugJzz2NAGH/J4G7MRRbs9zgdMEZ6jdUMNxA6AY1oMGKm6l
         XcIw==
X-Gm-Message-State: AOJu0YybZ69s0iqC8LaZ4oPpUDX90O+K9e2kv1RnL5Wk0LGT9wUA1nfe
	8SmZrZHHeOd28B+8rkO7Hn/wcJ9la0RGj3MtUH74prhi6lQpYPoKmHylfVsHVwaNYAUgxGtTO84
	KIAdBkEw=
X-Gm-Gg: ATEYQzxQclYMdPuA/xtkoFt24CZBwmW3BYNmpBUjmBTjtI5JdIPpsf52nP3ALw0vBGM
	jjXFgRL9+nvTTSNFgRrGTqcZ08xr8eshMZohq8aUrivlZmeWjNnslJMxv3Y32WPRRIGA3Sn8IER
	4n+zosIX2doF3MZLDZpyu8FZH5/FgENwzAy2YlGTGTBtEP4lsACefiOyvH6nvu4Cgmul6pIN4wz
	RbJ19I23dBlloX4XgZyJSGjAHEL2/kBAcJpggEPsp1OkGZ9HiQg8FzHiVwBaKO8G1+ZxmY2rprt
	g5RIQML3oEQDwnF9ivKuBQvilwZhIK7CA5Ip6YPokAHZPx4U7TFnlscrAF+/B6vuZ5dt/cYxmLd
	v3Q2Yeuq8NTuS5QN7ZaHEC3yXhzvEGLggJXVSW77hc+FVuxr+bXjeE9pe+x3jgb7qpUEWknhAad
	2pCitN
X-Received: by 2002:a05:6a20:748f:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-398c5f3e353mr65122637.19.1773177780185;
        Tue, 10 Mar 2026 14:23:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf9f4e8sm123145a12.24.2026.03.10.14.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:59 -0700 (PDT)
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
Subject: [RFC net-next 10/10] net: bnxt: Dispatch to SW USO
Date: Tue, 10 Mar 2026 14:21:58 -0700
Message-ID: <20260310212209.2263939-11-joe@dama.to>
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
X-Rspamd-Queue-Id: 3BE09258424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266342-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

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
index 47dc98479066..72d66043096a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -506,6 +506,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
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



Return-Path: <netdev+bounces-300306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NxcvKGplM2qhAAYAu9opvQ
	(envelope-from <netdev+bounces-300306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C869D51C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:26:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=Fko+4Vwk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CAA301F593
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F905349CCC;
	Thu, 18 Jun 2026 03:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88334FF5D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:26:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753192; cv=none; b=GD8PXpnyD5LNa3BERWX9Qvn4vBNnOYM14s3zArUYwxfGurc/sM4+YglikqQpNv2PH1Y5E04c9xgBpM+EGujVbKO/OM2qdGzMKrse3sa7tLUxCtDiSZZsrkxiItusmflaFBZAl2tPusht8fkdL6JYu9CCLxP7f85OEHY2mmdE3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753192; c=relaxed/simple;
	bh=b0YhOtSBM/Lmob+zJpAf/7His4U9hIoU6AS5XQxgjwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk4Mojh5AEKttwBSHU/FvHial47AK2uCE8byu7+9sKxKeL4QkniSothfDlM8nJW0hotGrLknqdSoC1oqSOZ6kaSTcydyOZC0r7NfUG55PP0Rqr3WeHEmTwMPzIIspVAMPCyMVj7k1ARNa7LUeclW/LRPT/CYNJQnpG+a+CIkXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Fko+4Vwk; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso496085a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781753190; x=1782357990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyLnG58GfsEegBI5v888liXEEtDxsXhj/MxQKKDHSTM=;
        b=Fko+4Vwk3V6w1ffJOS2fP09GbA6UBWNmgVrtL8ZMwm/pAL8C3ZWiQ3fQuYD/aRcoay
         Vivsau2u85gEaZUKn71h5GUfzlhSONKf3Bk4WaKYJG7Lv9COiYfUrmueoXI4nBR5zjDH
         7S6pANKbfGKnEFT08bd1N2OsO3EnV25AAMI/zEEIP75GKu8Nx2sRAV3xD0vLaow9z6Kh
         LDPEGbHW+o7wnCh4Ojj+i+//RXZkZHg1dEnoXQ8GdBQBO6Z+jWyjQfaqwdCojwb8VJKr
         9XX6OohttvuQlEtDc2f5GmSKI3MLAqieXzPOCEWf2ywVoPUNXEY3qNbuM3g3BZjiVRL8
         g00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781753190; x=1782357990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyLnG58GfsEegBI5v888liXEEtDxsXhj/MxQKKDHSTM=;
        b=r6iLgE7Xqg8asd+JOcGJuj1C/Ew8Z2BNLblj0YTKmER4AS6iKlTOCvldG+FPwqIsu1
         xoaKYW/n8DhxcsXdxQBBx02Hons/D13fBwpGsnoJ47oS6rypfPN3MI6WTVFHNNDVp23V
         vbzM088cMFjkeXzA12b0iaIjnFeMlM8FG0QQryUWQN+1gsqvrwvCAsil/Zq27ptFnpGW
         4fHDON6+0W/FQundFb3xFtDZOdGJCk7Rn8RpRluoeuehNurLRIBCnPqbA3PWpLtPcaJM
         vInObTerQkpKQzwwxK3YDsuEizvgfCuPdWdYKsDI0gB2R7DkpyFqRj9HFlA4LznxQgBW
         EslA==
X-Gm-Message-State: AOJu0YyYHMWFdyWB11xqX5NSn5/Vrk5+R4zfvvhmzXEXKVgkfMlc8Pu6
	C6ujfljA5EWDfCXp1OORjLf5iZw2310er/nZ/4zJXs5J/v9BLZQbqPYXBv8fTaKAUfnXGFxHLbq
	b18KUtg==
X-Gm-Gg: AfdE7cn53cqESCb+G80Y+nG3MhARwM1tCEmMupOmEY+v0/jXvQb2ImY0nGKkHfD1gu2
	vJDeIqwLaEU6ll6raXAE/OI/ljYlG5xzpt7OFY4dFgGN32JoHo7c5oEKNCfzqYBgPBzO7PxagOJ
	VWYcaFuG3zGLe6EvlHDeYWtCrJkZfwG4qVXwhd7ieY0AuVB/ojezjqchIJmaeGbOuyOfB4NjQCu
	16zCt+Z3TUVliD/7jJGbFWhLu472d2K7CzkllqANb9epATVkfxOAijLU868NSxF/VWcxbQ73NVa
	2cgg/tB4af6ybg59sljUhYZC2C7kT1nT6lcmMrcgtw/LSJzkolhbSJuAMLtLuiZwv1+LzScTOza
	WNYXzOEM4yOy6BS6DZmpT1vU34gBhHDZfx/mpCDY923/8LdXbDI1QBOU9w2MUUWpDc76JEg==
X-Received: by 2002:a17:90b:586c:b0:37c:70a6:12af with SMTP id 98e67ed59e1d1-37c9da9926cmr6278186a91.1.1781753190496;
        Wed, 17 Jun 2026 20:26:30 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c522c3a41sm7702830a91.17.2026.06.17.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:26:30 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 2/2] geneve: validate inner network offset in geneve_gro_complete()
Date: Wed, 17 Jun 2026 20:26:22 -0700
Message-ID: <20260618032622.484720-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618032622.484720-1-xmei5@asu.edu>
References: <20260618032622.484720-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,davemloft.net,gmail.com,openai.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300306-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:kylebot@openai.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B6C869D51C

Even with both paths gated on gs->gro_hint, geneve_gro_complete()
re-derives the inner dispatch type and length from the packet and the
current gs->gro_hint, independently of geneve_gro_receive(). The two can
disagree if gs->gro_hint flips under a concurrent geneve_quiesce()/
geneve_unquiesce() (sk_user_data is NULL across a synchronize_net()), or if
the re-read option bytes differ from the ones receive parsed.

geneve_gro_receive() already records the inner network header position in
NAPI_GRO_CB()->inner_network_offset. Have geneve_gro_complete() compute the
offset it is about to dispatch at, adding ETH_HLEN in the ETH_P_TEB case
where eth_gro_complete() steps over the inner MAC header, and bail out if
it lands past inner_network_offset.

Use a lower bound rather than exact equality: between gh_len and the inner
L3 header, geneve_gro_receive() may also have pulled an inner VLAN tag
(vlan_gro_receive() advances the recorded offset past it), which only moves
inner_network_offset further out. A valid frame therefore always satisfies
inner_nh <= inner_network_offset, while a gh_len inflated by a hint
gro_receive() did not honour dispatches past the validated inner header,
i.e. the out-of-bounds completion. Only the latter is rejected.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/geneve.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7cf7aaac8ee1..396e1a113cd4 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -962,6 +962,20 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	type = gh->proto_type;
 	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 
+	/* Bail out if we are about to dispatch past the inner network header
+	 * gro_receive() validated. An inner VLAN tag only pushes
+	 * inner_network_offset out, so use a lower bound.
+	 */
+	if (skb->encapsulation) {
+		unsigned int inner_nh = nhoff + gh_len;
+
+		if (type == htons(ETH_P_TEB))
+			inner_nh += ETH_HLEN;
+
+		if (unlikely(inner_nh > NAPI_GRO_CB(skb)->inner_network_offset))
+			return -EINVAL;
+	}
+
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
 		return eth_gro_complete(skb, nhoff + gh_len);
-- 
2.43.0



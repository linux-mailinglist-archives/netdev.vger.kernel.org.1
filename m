Return-Path: <netdev+bounces-281618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCmTIywu8GkHPgEAu9opvQ
	(envelope-from <netdev+bounces-281618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E145B47D298
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7DF305022B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78612FB969;
	Tue, 28 Apr 2026 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="UYkNN7t2";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fD3N5uIf"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124F3246F4;
	Tue, 28 Apr 2026 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348058; cv=none; b=L7sVWyivTasLAbW00Tmld560JmL2BoaCl/KZNMh0aRST9mGpzUOtBIE50OlTSnvkNeHkfGjo+O1RAe21xw55ork6zjmr9pQSltGlEg0mCHmodhfk9V4b4xxKIKLsL596KaAUaQ0pcuf8NPhf/Sc+unNo73eDvZaNW23JZ2o48nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348058; c=relaxed/simple;
	bh=2HeLRS+9Oy1I9V2GqKYRBj5SGf5uOCzP41BzpxFObe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F32v0JD1H8wtUbwh6zFjP4e63yI7fbq8kUfwpZ9837pEGSKg6nBdCCS/QTm6M3y92j+8WBmhF9ysnX8CN/El/f10ZKA46wEOgTNmPJFVjVP2p/0JsSBIvV8sST5H6UXd/nALTJ3a0e4/4tNZJoUsn5rlmbnuMnDop6kzjsP55wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UYkNN7t2; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fD3N5uIf; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348055;
	bh=2HeLRS+9Oy1I9V2GqKYRBj5SGf5uOCzP41BzpxFObe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UYkNN7t2LQkn3p9T6I5yv9i5t5xas+rc+zr8WXr5bMssLH0uCi3FPQfijPWol/ptO
	 X6z93UY4PNsBWMPE/4SRBclCOBUXmp5UFAaDeyBsptrNOHty4Thfh4D6F75mPdGP74
	 iqI74YJWDDzkE/koWxYYP3M/cxp04qeHD+IbmEUeiOatLFLSOTCqr2PNIBWj31xa4w
	 nXfZxdGGbZQuJISEscwrzXXDImY5nTnU/NC5NU+XpIke6DvugatCKKK3S9Peov1KCe
	 9GcCwt7M8fMAh/RElVEH83Ys8UHpuOx1d8afuw7YsHPD4PmYjTl4AefUWFw6joT0WQ
	 PoeozyDEo9rew==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id BA87347DAF; Tue, 28 Apr 2026 03:47:35 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348053;
	bh=2HeLRS+9Oy1I9V2GqKYRBj5SGf5uOCzP41BzpxFObe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fD3N5uIfZHG5/9rPASI0npkl99iPphEv5Gwh58r2jLXFv47URbXmCAkp1ixpNc1ef
	 qTeuCJqaSI0wekaoky2Bwa/ks4mJqoZ/fyb977glNNuvsD5bfJHjec05cNmr+QjzP+
	 SUSvxmcuITR8E4TXrjafqhhuBfVFeethnXm9dY4m8PHBV4C5EbghM25QSjUAWoA8UU
	 V3nO7unAhH1iMVCYtTBZuFCh9vRRqoq6sRVaMigKzUoOrLWU9tvCSqbYfC5amrZj/4
	 15ecIqObiiK++9LnR3DJPDd3lKt4tDgoCDQrWB9XxISQJOutCyc46KjMYWRN12T4eT
	 BH7hnWK+OBULg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F181E476A4;
	Tue, 28 Apr 2026 03:47:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 28 Apr 2026 05:47:23 +0200
Subject: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
In-Reply-To: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: E145B47D298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-281618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Add interrupt mitigation code for both RTL8157 and RTL8159 that prevents
USB interrupt callbacks with urb->status ESHUTDOWN being triggered. While the
issue is rarely seen on the RTL8157, without the mitigation, it is
common on the RTL8159:
[273.561863] r8152 7-1:1.0 enx88c9b3b5xxxx: Stop submitting intr, status -108

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 8255261d73148a7b4dabe0188faf07cb1f356437..08cc3c1dae0facb2400890ba4d093c97ed56d40b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8444,6 +8444,12 @@ static void r8156_init(struct r8152 *tp)
 	else
 		r8153_u2p3en(tp, false);
 
+	if (tp->version >= RTL_VER_16) {
+		/* Disable Interrupt Mitigation */
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+	}
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 

-- 
2.47.3



Return-Path: <netdev+bounces-251950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPSyJbrycGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:37:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FEF594E4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A91E3788133
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A964DB56A;
	Wed, 21 Jan 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="HeFJaC1m"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071B4DB546;
	Wed, 21 Jan 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007500; cv=none; b=hk/W7nw4TTeHlqO8WTY0POcud7n1oIkpJJuNi+ATwErOGB6FLYVCEeLkUqlXGc97Djnx+wU8Q8TDjxTY4vCA3+Yp6+nQjiWQJm5/sAU5DsXVHCQkWwAxvl8QLxd6zJwxQx+aMTFsasER8HirBYt9C9Toba8MpUojxq9Btl/nMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007500; c=relaxed/simple;
	bh=0GrGhWbwswqou6wzlsc9dE/G/veSAbRQW0iD5Ve4Dls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fys2fb8hCmZco7SAcAWe0v9hd+opNfULS84y+LGnzZOYYW3v4OwhaXTcNGgm9JeuM+PPPVfR8d7q6xjTSIjACm2FZN8/YRQUgLhfeC+3L+A2n9VIARjfY/f71TPsJh4fH0Jft8a4gJ/T/tIRtIvD/GCQy0zSmGd6OZgTvAJh8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=HeFJaC1m; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZes-008XEu-IO; Wed, 21 Jan 2026 15:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=eNMRSz5L8fgL8ctUrXiNlrxD38QSSH4gIK6f6XdjByE=; b=HeFJaC1mdaOqO1JFtCyHaDqb+o
	AYbWVZoW4TkLPEY6c7eJ5zI0XROXccqy7RUoBXtNgEihN/3n3OME26NmwnJOISA1MophY0qHodcRs
	sRMMMr8/9oE94ctgx35jyRY+HVHmjHGefqARHNdLoT2XoYD0AKtjnrq8oHUVENSDbfzd+l7udyn/r
	kQrIxELHzkwwbh1Q8jNeS9XGONZUP76CWdNavaltvVSuWHgewUiXCScsctVEk+PGKMb/DIXH3olBd
	r5ffBQZhia625IXmRCUdzJ3lSVKxvROrC+GOiErca0omVSy1EL73FZzFreX/t3F5/GlqqVPL63Pqr
	9ZgCLz+A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZes-0001sg-6G; Wed, 21 Jan 2026 15:58:10 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeV-00GH6h-40; Wed, 21 Jan 2026 15:57:47 +0100
From: david.laight.linux@gmail.com
To: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 05/14] ixgbevf: Use C test for PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
Date: Wed, 21 Jan 2026 14:57:22 +0000
Message-Id: <20260121145731.3623-6-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121145731.3623-1-david.laight.linux@gmail.com>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251950-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linutronix.de,infradead.org,efficios.com,arndb.de,vger.kernel.org,gmail.com,intel.com,wanadoo.fr,linux.intel.com,chromium.org,linux-foundation.org,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,runbox.com:dkim]
X-Rspamd-Queue-Id: 64FEF594E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>

Compile-time tests being added to BIT() make it an 'integer constant
expression' rather than a pre-processor expression for W=1 builds.

This means BIT() can't be used in pre-processor conditional that
checks 'PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD'.
Change to use a normal 'if' statement, the compiler will optimise
away the unwanted code.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c   | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d5ce20f47def..65dd5834d0cf 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4166,9 +4166,6 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	u32 tx_flags = 0;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
 	struct ixgbevf_ipsec_tx_data ipsec_tx = { 0 };
-#if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
-	unsigned short f;
-#endif
 	u8 hdr_len = 0;
 	u8 *dst_mac = skb_header_pointer(skb, 0, 0, NULL);
 
@@ -4183,15 +4180,15 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	 *       + 1 desc for context descriptor,
 	 * otherwise try next time
 	 */
-#if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
-	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
+	if (PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD) {
+		for (unsigned int f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
 
-		count += TXD_USE_COUNT(skb_frag_size(frag));
+			count += TXD_USE_COUNT(skb_frag_size(frag));
+		}
+	} else {
+		count += skb_shinfo(skb)->nr_frags;
 	}
-#else
-	count += skb_shinfo(skb)->nr_frags;
-#endif
 	if (ixgbevf_maybe_stop_tx(tx_ring, count + 3)) {
 		tx_ring->tx_stats.tx_busy++;
 		return NETDEV_TX_BUSY;
-- 
2.39.5



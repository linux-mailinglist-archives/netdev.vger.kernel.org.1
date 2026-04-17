Return-Path: <netdev+bounces-279404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDyrN4594mnk6gAAu9opvQ
	(envelope-from <netdev+bounces-279404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3DF41DFD9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBFF301CF9D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7537D128;
	Fri, 17 Apr 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wRq7R5mn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHOeASAm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wRq7R5mn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHOeASAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5436EAAD
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450905; cv=none; b=IkQ6AxezaNc0cdBvqnxCBwRmWP7uv+s0xopTLjbbZyxkcLVrPJFxBaprx4kP2MjnuuOc2iIYEhB/7QlPyJAkFFqxbJ/7hdLIWtJvAvk0LtFDMCfXGGcgiZWJQMn0gD7FFSGxyoWSO/lrdpA71E8cpu4t0SPg+4kjdtwi5G4ztyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450905; c=relaxed/simple;
	bh=+RTYkB2m0cRxNY4pT8RzwxBCKN+3BoFBk1EtIQdEJoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ejlf0X1jqgjKOkC62j1u41O93K0zNN3BhYwaGBw6vYiAzmCvjzoWb3VlhnayFYmmyfk5JOh4/tC4I4r/AT1ZWYG8mRW9xk/smOrg8mB33CgtzkyOoSTdL8D5yZbFaBtFopYz0+BS0erpFCBZT4Oa4BwkeQGdFUmnfJeYGsQsFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wRq7R5mn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHOeASAm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wRq7R5mn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHOeASAm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 806666A9EA;
	Fri, 17 Apr 2026 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmRkp/3WVgIPmEM1j+91qLo1hAzTf+aJ86Bsu9R/Ex4=;
	b=wRq7R5mnKdmr81Lmpe48/rumdC7cVflibpkeOH+beE5WM1AR3UdzUFJy9yeheePaUy57wh
	qMfyGdbwDeEy7gSsgvRutVQDJMXuY/1XYg572f86P1PDc+XMMqChoZfTnZb3/WIbdoGeog
	8BktGW1tJpx2GfDvF//NWs6m42YP18w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmRkp/3WVgIPmEM1j+91qLo1hAzTf+aJ86Bsu9R/Ex4=;
	b=dHOeASAmRoFp15DSeF95rnX8CvLOK+oxa3NSEtXssc/J32c88c0lU5HxGFX83QyqiueATM
	ErIeD0neuUGUfhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmRkp/3WVgIPmEM1j+91qLo1hAzTf+aJ86Bsu9R/Ex4=;
	b=wRq7R5mnKdmr81Lmpe48/rumdC7cVflibpkeOH+beE5WM1AR3UdzUFJy9yeheePaUy57wh
	qMfyGdbwDeEy7gSsgvRutVQDJMXuY/1XYg572f86P1PDc+XMMqChoZfTnZb3/WIbdoGeog
	8BktGW1tJpx2GfDvF//NWs6m42YP18w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmRkp/3WVgIPmEM1j+91qLo1hAzTf+aJ86Bsu9R/Ex4=;
	b=dHOeASAmRoFp15DSeF95rnX8CvLOK+oxa3NSEtXssc/J32c88c0lU5HxGFX83QyqiueATM
	ErIeD0neuUGUfhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C16593AE;
	Fri, 17 Apr 2026 18:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SC6RAlJ94mmFFQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 17 Apr 2026 18:34:58 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/4 nf] netfilter: nft_tproxy: skip evaluation for non-first fragments
Date: Fri, 17 Apr 2026 20:34:31 +0200
Message-ID: <20260417183433.4739-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417183433.4739-1-fmancera@suse.de>
References: <20260417183433.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 7D3DF41DFD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tproxy expression relies on L4 ports to perform socke lookups. For
fragmented packets, every fragment carries the transport protocol used
but only the first fragment contains the L4 header.

As nftables is not evaluating chain priority, a tproxy expression could
be attached to a PREROUTING chain with a priority lower than -400. This
would bypass defragmentation.

Add a check for pkt->fragoff to ensure tproxy only evaluates
unfragmented packets or the first fragment in the stream.

Fixes: 4ed8eb6570a4 ("netfilter: nf_tables: Add native tproxy support")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nft_tproxy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index 50481280abd2..8080cbd878cd 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -30,8 +30,8 @@ static void nft_tproxy_eval_v4(const struct nft_expr *expr,
 	__be16 tport = 0;
 	struct sock *sk;
 
-	if (pkt->tprot != IPPROTO_TCP &&
-	    pkt->tprot != IPPROTO_UDP) {
+	if ((pkt->tprot != IPPROTO_TCP &&
+	     pkt->tprot != IPPROTO_UDP) || pkt->fragoff) {
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
@@ -97,8 +97,8 @@ static void nft_tproxy_eval_v6(const struct nft_expr *expr,
 
 	memset(&taddr, 0, sizeof(taddr));
 
-	if (pkt->tprot != IPPROTO_TCP &&
-	    pkt->tprot != IPPROTO_UDP) {
+	if ((pkt->tprot != IPPROTO_TCP &&
+	     pkt->tprot != IPPROTO_UDP) || pkt->fragoff) {
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
-- 
2.53.0



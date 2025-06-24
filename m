Return-Path: <netdev+bounces-200636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E3AE6619
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E14C3EF4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CA2C033B;
	Tue, 24 Jun 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFsrxZdL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9v/2oaty";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZFVlatqh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YFNC6k1d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DC2BF3DB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770733; cv=none; b=NT6wimsGQg9cs/i2gyIKtXZm7YJ8k3PmD+k0W/bg7/+T6AJMovWgY9C92p2aPAaqq9N6h0hvN1Z9LkOl32tTGnIblzKPSNulT+Nc+vLTkXOYeWFTHfuEV3VvtWmx9aD8jrsAew/ayidHgVZ5GKy8yg6FZEmlB65kvZ8AuGUHw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770733; c=relaxed/simple;
	bh=3pDkG0MqCxXkCsC5FOdHliPD8SIBKBHOfP1LbmcrrMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueaqMWm2cAJCEdx8DBiWDGJ+vwg2powNmTfjQfvLtaNug6Ijm5cV3TRwvL9q3dJcHhEItnxLgRzAShWELSqkokNiJdpVO3sQZwq5R8UJpIPdM/FOI7G+m6J72NNjkUrt3C2G0f8GnhrejDKQSifd5sJgtfi0+/Q7fWEacYhqLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFsrxZdL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9v/2oaty; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZFVlatqh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YFNC6k1d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E90A61F441;
	Tue, 24 Jun 2025 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750770730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AEuNN0vBnyJQyt/RbfAfHYNvjhkMctYvxkcaxDQ3gVc=;
	b=JFsrxZdLrYbPVoR521tQ3W/BhBuJsJSP0W2l00Vrjv2beNNsScVPVJC/B09vsniQfWXzOs
	ZGhMx2sYHoiJghxKQF5uHwdW95bSLJsrhHASU4lMLM6lWaY6mv6FDlXB/Hiw8eJFVenP7l
	TdQxEsiT9cqkarxRHFYXUnKrI4H/kbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750770730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AEuNN0vBnyJQyt/RbfAfHYNvjhkMctYvxkcaxDQ3gVc=;
	b=9v/2oatyzHCZz/jr7CabNdElARtNy5ZG5KIkl+4jQCJ9tcgOFD98SmCy8bYzOq5ThdOf8E
	IbV3tdm5Gdzf17Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750770728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AEuNN0vBnyJQyt/RbfAfHYNvjhkMctYvxkcaxDQ3gVc=;
	b=ZFVlatqhs1k0Sf22rK/sFWIEaIDV0pXRF8rNXWHNf3RjsleXcv8vp+7O1uAJKKhNy/F2Ge
	ug+Hj0PFguuRyYKcU0tHCIrCCNMIZNMZPdvHTlbGJKSn3skR6lN4EH5Y9T3cSPqGNoVOjw
	uOAv+tNKtwuB1wlKPahntLGfUN/01qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750770728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AEuNN0vBnyJQyt/RbfAfHYNvjhkMctYvxkcaxDQ3gVc=;
	b=YFNC6k1dgNAoJrdXf/KpYpKEKC1+XwXpkuqkjJrZQhyGiYA7pbt0WM7FYcQL/EPh3SP3r4
	F4RKeTcVyo9yFRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9477113A24;
	Tue, 24 Jun 2025 13:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pLn9ICikWmhDZAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 24 Jun 2025 13:12:08 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH ipsec] xfrm: ipcomp: adjust transport header after decompressing
Date: Tue, 24 Jun 2025 15:11:15 +0200
Message-ID: <20250624131115.59201-1-fmancera@suse.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The skb transport header pointer needs to be adjusted by network header
pointer plus the size of the ipcomp header.

This shows up when running traffic over ipcomp using transport mode.
After being reinjected, packets are dropped because the header isn't
adjusted properly and some checks can be triggered. E.g the skb is
mistakenly considered as IP fragmented packet and later dropped.

kworker/30:1-mm     443 [030]   102.055250:     skb:kfree_skb:skbaddr=0xffff8f104aa3ce00 rx_sk=(
        ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
        ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
        ffffffff84281420 ip_defrag+0x4b0 ([kernel.kallsyms])
        ffffffff8428006e ip_local_deliver+0x4e ([kernel.kallsyms])
        ffffffff8432afb1 xfrm_trans_reinject+0xe1 ([kernel.kallsyms])
        ffffffff83758230 process_one_work+0x190 ([kernel.kallsyms])
        ffffffff83758f37 worker_thread+0x2d7 ([kernel.kallsyms])
        ffffffff83761cc9 kthread+0xf9 ([kernel.kallsyms])
        ffffffff836c3437 ret_from_fork+0x197 ([kernel.kallsyms])
        ffffffff836718da ret_from_fork_asm+0x1a ([kernel.kallsyms])

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Link: https://bugzilla.suse.com/1244532
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/xfrm/xfrm_ipcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 907c3ccb440d..a38545413b80 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -97,7 +97,7 @@ static int ipcomp_input_done2(struct sk_buff *skb, int err)
 	struct ip_comp_hdr *ipch = ip_comp_hdr(skb);
 	const int plen = skb->len;
 
-	skb_reset_transport_header(skb);
+	skb->transport_header = skb->network_header + sizeof(*ipch);
 
 	return ipcomp_post_acomp(skb, err, 0) ?:
 	       skb->len < (plen + sizeof(ip_comp_hdr)) ? -EINVAL :
-- 
2.49.0



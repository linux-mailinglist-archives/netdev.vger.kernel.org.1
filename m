Return-Path: <netdev+bounces-260081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPIsCwZwnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:19:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE62178A2B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0292430244F7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B03285CAA;
	Mon, 23 Feb 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L0HByolD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3eUmRSDd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L0HByolD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3eUmRSDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F128505E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859971; cv=none; b=E5BYYtZEKhCriRnjBctcHFBFv9klINcvmzbZ3VVTBvABjlbQ2pDjiwat2AyEpmkCeE95e7sgKknVTM4+6HsPUOCZXevQbJguz6NMGpQHqnJoKQgbyGgn2RU9LXyQapY5EiqXTc0koxzntr08fi3bZ4nACa9BRVOgwg5n2T40UHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859971; c=relaxed/simple;
	bh=0O3RvJy5wMszVpqd7072pywBFbMARv2HhD0Qr8fHSJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr7HTUn2WqI6QSl+pzmYERrWhc/Wsf9Fe6+TlefjFvwW5n7396qdM1cbU2X/XouaFbh9CGCpLm0D5B+HmgDiaY8dHI49/iJ3XNJdi22gvt45CajlAhn81Cq8rqj2NG3NKfzRxVOnFPhksZRM/tQNZ5KMVZqYSi70hMLl0ZEPWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L0HByolD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3eUmRSDd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L0HByolD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3eUmRSDd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 409323ED75;
	Mon, 23 Feb 2026 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771859968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3eJX+/Hm/8RuHBx6XH/gu7RzCdwaePCRMFOhHNaKD8=;
	b=L0HByolDVRfyM01drZUEECGagzGV5s6SWkJjohtEthBkg7sJRUufWFphhvvroOyQ3c5xVd
	zL2wcxTWdXcnkuF71DQQjanTOW3QAvKbP9lprFbCNY6txADtM4CU6LKYiup3Hb/o4npRNz
	QM+02eL730I8vv6S7fkBSgvL3mUnaww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771859968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3eJX+/Hm/8RuHBx6XH/gu7RzCdwaePCRMFOhHNaKD8=;
	b=3eUmRSDdrxphum6bcXgQsXjZG1mi3jxmMQEwcNlI3fgXnGhloea2dS+FDVXybg9nMWk93f
	sVb9C2pOzefDzEAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L0HByolD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3eUmRSDd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771859968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3eJX+/Hm/8RuHBx6XH/gu7RzCdwaePCRMFOhHNaKD8=;
	b=L0HByolDVRfyM01drZUEECGagzGV5s6SWkJjohtEthBkg7sJRUufWFphhvvroOyQ3c5xVd
	zL2wcxTWdXcnkuF71DQQjanTOW3QAvKbP9lprFbCNY6txADtM4CU6LKYiup3Hb/o4npRNz
	QM+02eL730I8vv6S7fkBSgvL3mUnaww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771859968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3eJX+/Hm/8RuHBx6XH/gu7RzCdwaePCRMFOhHNaKD8=;
	b=3eUmRSDdrxphum6bcXgQsXjZG1mi3jxmMQEwcNlI3fgXnGhloea2dS+FDVXybg9nMWk93f
	sVb9C2pOzefDzEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E06C3EA68;
	Mon, 23 Feb 2026 15:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4qFSI/9vnGlRKQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Feb 2026 15:19:27 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] ipv6: discard fragment queue if middle fragment is not 8 bytes aligned
Date: Mon, 23 Feb 2026 16:19:18 +0100
Message-ID: <20260223151918.31965-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: BFE62178A2B
X-Rspamd-Action: no action

Currently the kernel IPv6 implementation is not dicarding the fragment
queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
relies on queue expiration to free the queue.

While RFC 8200 section 4.5 does not explicitly mention that the rest of
fragments must be discarded, it does not make sense to keep them. The
parameter problem message is sent regardless that. In addition, if the
sender is able to re-compose the datagram so it is 8 bytes aligned it
would qualify as a new whole datagram not fitting into the same fragment
queue.

The sooner we can free resources during reassembly, the better.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..8b0bc0ba56f4 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -163,6 +163,9 @@ static int ip6_frag_queue(struct net *net,
 			 * this case. -DaveM
 			 */
 			*prob_offset = offsetof(struct ipv6hdr, payload_len);
+			inet_frag_kill(&fq->q, refs);
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+					IPSTATS_MIB_REASMFAILS);
 			return -1;
 		}
 		if (end > fq->q.len) {
-- 
2.53.0



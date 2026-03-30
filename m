Return-Path: <netdev+bounces-273148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM76KhZqymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:18:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF035AEB3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F06330179F8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC07277C9D;
	Mon, 30 Mar 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATRnpqS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y84QewfJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATRnpqS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y84QewfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E163C9EFE
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872660; cv=none; b=fxUHplOXC2ctrSC3yNJrdov7G8yk+X6QflRryAK4/FTZO9rlrnrnLHqyP5NddfCpvIt7UXHUBZ4EJIRAS8xrSi4KLF7kwgXooeR3kNWQ4iwD5n1z4tAKbvne6L0S/Dhx1o1u+3YyaSXhbaybkXDmbRRQdL7n5/nSX96P/C9H4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872660; c=relaxed/simple;
	bh=+LMQoTvu244a85Ncb5u2POFz1DjpQtqMwBU9f7MsV38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6oiBTkgbaDt8Ofk/8kyjBu/RtW7m4O2mwfVrn+t8l/QUczBGwD3ExXH+bvae3y68h5x6gkRW4MY934Xj/+BNVSqUKE3+imRBGEIJ0USKkeIWwq0tD72nWMX6IN52NJ68HchFIVRqS+aAl9VjsEAILw0K+g2uNOrmlRlcDKxjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATRnpqS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y84QewfJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATRnpqS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y84QewfJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C96A5BD4C;
	Mon, 30 Mar 2026 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774872657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=ATRnpqS5y5bHge/fqewsFrAy0cf4AxqRJTYmorm3eu9NEclVMRhI8Oeu72wXfyICvmc8Q7
	Q2bw2kGXiZBKO/WoUms/T3tSS0NQVu9ix848fpGXTK243342DWfHxSE1TlNaYQfFEoGCJA
	eZDYdQS8hyOmOS1jYFJ3DfMBbYy2e+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774872657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=y84QewfJ9bXt4vs5Ny/yi7xpmaGvsuNPUHNsKWf/l5s451i66Po59uGwvjk3oATYXN/b/N
	IO9Vtiqq6wQWNkCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ATRnpqS5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y84QewfJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774872657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=ATRnpqS5y5bHge/fqewsFrAy0cf4AxqRJTYmorm3eu9NEclVMRhI8Oeu72wXfyICvmc8Q7
	Q2bw2kGXiZBKO/WoUms/T3tSS0NQVu9ix848fpGXTK243342DWfHxSE1TlNaYQfFEoGCJA
	eZDYdQS8hyOmOS1jYFJ3DfMBbYy2e+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774872657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=y84QewfJ9bXt4vs5Ny/yi7xpmaGvsuNPUHNsKWf/l5s451i66Po59uGwvjk3oATYXN/b/N
	IO9Vtiqq6wQWNkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F2E4A0A2;
	Mon, 30 Mar 2026 12:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DR80IVBoymkKSwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 30 Mar 2026 12:10:56 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: sdf@fomichev.me,
	petrm@nvidia.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] net: vxlan: check ipv6_mod_enabled() on neigh_reduce()
Date: Mon, 30 Mar 2026 14:10:33 +0200
Message-ID: <20260330121033.4479-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273148-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BBF035AEB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IPv6 must be enabled or otherwise neigh_reduce() might cause a kernel
panic. This was prevented by a check on in6_dev. Use ipv6_mod_enabled()
instead as it is cleaner and also consistent with the code at
route_shortcircuit().

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 drivers/net/vxlan/vxlan_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b5fbd03418b6..b3b692c4b628 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2027,13 +2027,11 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
 	const struct ipv6hdr *iphdr;
-	struct inet6_dev *in6_dev;
 	struct neighbour *n;
 	struct nd_msg *msg;
 
 	rcu_read_lock();
-	in6_dev = __in6_dev_get(dev);
-	if (!in6_dev)
+	if (unlikely(!ipv6_mod_enabled()))
 		goto out;
 
 	iphdr = ipv6_hdr(skb);
-- 
2.53.0



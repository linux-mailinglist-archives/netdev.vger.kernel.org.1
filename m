Return-Path: <netdev+bounces-252046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO3OBCc6cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:42:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2F5D7A8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4A166CDC27
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1A3D6472;
	Wed, 21 Jan 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9RpFhHX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YL94JoT8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T9RpFhHX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YL94JoT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA63D300B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024705; cv=none; b=Fe7mtMDiBwRuhSgtA6MbsAYa/q5RbeAYujKqJyACw3p8YImPD3CEKi93DjmtUx87bFC/HG9mkd/vKRvWcobT0Dr+f2OYmWcuovDPjQgkY+VaBxUMI3YzcJixGsdNOCxJg9L7Fg6Pvfrdt8JdI0nVbqip3MNsMHvPVXHbptnCyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024705; c=relaxed/simple;
	bh=39n7WKYNtmCamR154/ukYGCQW9LlGafGmKOGMfh6hik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSkyxzkiilSBf6CBk10oiCTOee5Zr8hgRvaDeH1KqdQHsSI2uvP8nvwZ1FGXe7NcYj2gKjFshmjMh9bN3Hgk6k4tZPrJFMrkIPLv6Lgf8HiXN4cBQD+ijAtJezS24rS4+Jq0e8+zOKGagypFGYSbx5Z5tYBNr5dEsdqWiorXK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T9RpFhHX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YL94JoT8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T9RpFhHX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YL94JoT8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20512336EE;
	Wed, 21 Jan 2026 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769024700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTU5LhVHLEhgbSZjYMrT4kO/047Z4LCoe0miKHAezNk=;
	b=T9RpFhHX8MbgAg8sGxR/59tPGkj5Ez6wgFvGWraikQFmKsQBqUp2mRikgMO6Qnib3IimOX
	tWHpqxrBql80v2uim2vBTGbOdnkeflhq5QzYfO7yTy76pGaCgVk2FRnvKMLsZlB7p+QnSw
	L1HTIIwCF/57EtMU2LNvmot2wrIPlxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769024700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTU5LhVHLEhgbSZjYMrT4kO/047Z4LCoe0miKHAezNk=;
	b=YL94JoT8XFd5GTvvxQCXcIzOWMpEXfL44nGHYT2lgwT7kiSt++DdC6u31mE5Z3SYrI7Rt1
	zjWhOqC8kdTnzjAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T9RpFhHX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YL94JoT8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769024700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTU5LhVHLEhgbSZjYMrT4kO/047Z4LCoe0miKHAezNk=;
	b=T9RpFhHX8MbgAg8sGxR/59tPGkj5Ez6wgFvGWraikQFmKsQBqUp2mRikgMO6Qnib3IimOX
	tWHpqxrBql80v2uim2vBTGbOdnkeflhq5QzYfO7yTy76pGaCgVk2FRnvKMLsZlB7p+QnSw
	L1HTIIwCF/57EtMU2LNvmot2wrIPlxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769024700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTU5LhVHLEhgbSZjYMrT4kO/047Z4LCoe0miKHAezNk=;
	b=YL94JoT8XFd5GTvvxQCXcIzOWMpEXfL44nGHYT2lgwT7kiSt++DdC6u31mE5Z3SYrI7Rt1
	zjWhOqC8kdTnzjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CC2C3EA63;
	Wed, 21 Jan 2026 19:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZWt8G7sscWnOHwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 21 Jan 2026 19:44:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	haleyb.dev@gmail.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next v3] ipv6: use the right ifindex when replying to icmpv6 from localhost
Date: Wed, 21 Jan 2026 20:44:08 +0100
Message-ID: <20260121194409.6749-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	TAGGED_FROM(0.00)[bounces-252046-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,suse.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 83E2F5D7A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When replying to a ICMPv6 echo request that comes from localhost address
the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
skb device ifindex instead. This fixes pinging to a local address from
localhost source address.

$ ping6 -I ::1 2001:1:1::2 -c 3
PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms

2001:1:1::2 ping statistics
3 packets transmitted, 3 received, 0% packet loss, time 2032ms
rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms

Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
v3: use ipv6_addr_loopback() as it is more efficient
---
 net/ipv6/icmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index c72270582d9c..1a25ecb92695 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -966,7 +966,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	fl6.daddr = ipv6_hdr(skb)->saddr;
 	if (saddr)
 		fl6.saddr = *saddr;
-	fl6.flowi6_oif = icmp6_iif(skb);
+	fl6.flowi6_oif = ipv6_addr_loopback(&fl6.daddr) ?
+			 skb->dev->ifindex :
+			 icmp6_iif(skb);
 	fl6.fl6_icmp_type = type;
 	fl6.flowi6_mark = mark;
 	fl6.flowi6_uid = sock_net_uid(net, NULL);
-- 
2.52.0



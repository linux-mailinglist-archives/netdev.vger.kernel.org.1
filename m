Return-Path: <netdev+bounces-255121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFfgLLSUfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:23:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE019BA071
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3997305CF77
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A534E75E;
	Fri, 30 Jan 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0AO675ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c59bHBXW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0AO675ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c59bHBXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11033EB01
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771950; cv=none; b=sHzA4ZhH1Ot/SGOaYl3nC4TYU4tTSdSGkkxsmMYib8kchZTj9Iuemn1GvA+VA9cnvBU3/8Xp3/EXXdCu4DRTxG8DbUQ+wNvo9zMh4OwMGpdPWCQ/ZLVgpL+yHd+ikI3aMY7tqYu7rN7eYND2e4jsCAVX+BpEWtPjv2NLTHEWRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771950; c=relaxed/simple;
	bh=bCGu71GEXxNkV5/9e+2XlverC9QkEitMkRMqV0O3rHg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hGzucd3Bz1K3qn1vV63zehQ7J9KT9dIche+g3/+wJjqOLLH2YsyTVuElEXwKzX4vPerFuetcfa/fsrfcaHCIqvK8v/hEaQXXziUVDcOHk3gjpxaC/s/o9VA/FLip/N9ppom029+rLmbPlp1R3qtusc9fIxkcjYTHdvHKK2otKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0AO675ba; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c59bHBXW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0AO675ba; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c59bHBXW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 098E05BCE2;
	Fri, 30 Jan 2026 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769771947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tFDS9SoaGcRO8FiVaarY/KBncYAPLW/z6WhT0SYl+s8=;
	b=0AO675bapcZijMdIoMDGjfhrAYKeMyB3Qn6S9e+6ZUt8R96jKAqTNci80E71OE41Cgwf8L
	sd6ES9g4lkCKzueRr1yXyhcUeWpTU3YZTFst/2A892P41vTwkkK19z+MW0d/h/tEIsr13z
	bDHFIg7IoHeneoY4AHeVf55PTbqv2GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769771947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tFDS9SoaGcRO8FiVaarY/KBncYAPLW/z6WhT0SYl+s8=;
	b=c59bHBXWye7efSWk8CHVfDsO9J1jqKnHa1YrY64ANB0+vxdZ9xsODkTJXN0f4w/ITdEXMQ
	QuSWa/dLde1zuNBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769771947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tFDS9SoaGcRO8FiVaarY/KBncYAPLW/z6WhT0SYl+s8=;
	b=0AO675bapcZijMdIoMDGjfhrAYKeMyB3Qn6S9e+6ZUt8R96jKAqTNci80E71OE41Cgwf8L
	sd6ES9g4lkCKzueRr1yXyhcUeWpTU3YZTFst/2A892P41vTwkkK19z+MW0d/h/tEIsr13z
	bDHFIg7IoHeneoY4AHeVf55PTbqv2GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769771947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tFDS9SoaGcRO8FiVaarY/KBncYAPLW/z6WhT0SYl+s8=;
	b=c59bHBXWye7efSWk8CHVfDsO9J1jqKnHa1YrY64ANB0+vxdZ9xsODkTJXN0f4w/ITdEXMQ
	QuSWa/dLde1zuNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD5153EA61;
	Fri, 30 Jan 2026 11:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uhzgNaqTfGl0DAAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Fri, 30 Jan 2026 11:19:06 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bonding: only set speed/duplex to unknown, if getting speed failed
Date: Fri, 30 Jan 2026 12:19:04 +0100
Message-ID: <20260130111904.144024-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tbogendoerfer@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE019BA071
X-Rspamd-Action: no action

bond_update_speed_duplex() first set speed/duplex to unknown and
then asks slave driver for current speed/duplex. Since getting
speed/duplex might take longer there is a race, where this false state
is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
 update port speed when getting bond speed") this race gets more visible,
if user space is calling ethtool on a regular base.

Fix this by only setting speed/duplex to unknown, if link speed is
really unknown/unusable.

Fixes: 691b2bf14946 ("bonding: update port speed when getting bond speed")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/bonding/bond_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e7caf400a59c..4cdf89b21ca0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave *slave)
 	struct ethtool_link_ksettings ecmd;
 	int res;
 
-	slave->speed = SPEED_UNKNOWN;
-	slave->duplex = DUPLEX_UNKNOWN;
-
 	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
 	if (res < 0)
-		return 1;
+		goto speed_duplex_unknown;
 	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
-		return 1;
+		goto speed_duplex_unknown;
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		return 1;
+		goto speed_duplex_unknown;
 	}
 
 	slave->speed = ecmd.base.speed;
 	slave->duplex = ecmd.base.duplex;
 
 	return 0;
+
+speed_duplex_unknown:
+	slave->speed = SPEED_UNKNOWN;
+	slave->duplex = DUPLEX_UNKNOWN;
+
+	return 1;
 }
 
 const char *bond_slave_link_status(s8 link)
-- 
2.43.0



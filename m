Return-Path: <netdev+bounces-296151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TP6GKGODJGqY7gEAu9opvQ
	(envelope-from <netdev+bounces-296151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F1B64E430
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:30:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="wijZ8I B";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296151-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 741AD3043E97
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB863D4126;
	Sat,  6 Jun 2026 20:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D33BFAFC
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 20:27:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777647; cv=none; b=W+aGEsO7YSD5knsmD8MzqFRAYZ6Q9miEZkqQuVQ8/MoYoLl16XMr94mpr9RQSIJWI4iQQR3mpFGvuum0xdKXuaj6/PG2KVkTQMuzA90CMMcTU0IhmU5o4w59PMK49OK2wcPMNYDCbcnZejc+jA1iavlLmojH4/i1QOAXiG2G2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777647; c=relaxed/simple;
	bh=1mFrbojz0PWOhUZtx3IzxM5Cw9QosOrwnDFFT7UZSQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s7U4bB9kBxdRvORUOVsi2Z5F7QW0jEOWsH17HZVa6V0W3ur3d4OnKzfxUNloIqFp+t8OZirkN/lBbwoGCilB3+Hc2Lj4cQvSRlW22N2MvWgj2TzOTAqhJVsYa+vru5ZWbB8SJfwV6KrQmLrPseVPIL05dgTuHGGt5ECYLsaDs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=wijZ8IB/; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxc1-007NTh-3f; Sat, 06 Jun 2026 22:27:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=KhMKaOFxgwuQkIs6RKratwnTu2UWxE6iXhf6LBrZbME=; b=wijZ8I
	B/QKevvdt5kIs4TVg4CKUyWlfIY6hFuZoGTbwyBcRGJefE8nJXSzDZQnMHDT22na81QMzQdYStjzK
	++VhngaY9Y6RiQBpuxY5YSguSYB/Vsb5Cg35GjG00PPy/yxfQSDZ7uaRmK3mt5CGWxh585FcF5QyF
	j3eDufEe6oBZAdYJLmQzQSBof+PJiUvhteccBci/F1/MUAxF+IueUqX3LXMR53NyOG6pXpx1nyZht
	X7TXKgdYB28krBnMMlOGJHdw2dSNYM4bjfaQ+I3c2EPKSFpKBOTotX1Wgv5u8YrsKoOTIyKkeVLXy
	tNxywe0G8/cTyOuI0mNxbqsCkAwA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-0005DL-J6; Sat, 06 Jun 2026 22:27:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbk-006V18-65;
	Sat, 06 Jun 2026 22:27:04 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/ipv4/ipconfig: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:21 +0100
Message-Id: <20260606202633.5018-27-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,nvidia.com,redhat.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58F1B64E430

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index a35ffedacc7c..ec60e201ebe7 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -371,7 +371,7 @@ static int __init ic_setup_if(void)
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
+	strscpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = devinet_ioctl(&init_net, SIOCSIFADDR, &ir)) < 0) {
 		pr_err("IP-Config: Unable to set interface address (%d)\n",
-- 
2.39.5


